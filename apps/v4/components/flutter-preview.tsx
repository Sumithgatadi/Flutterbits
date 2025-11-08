"use client"

import { useState, useEffect, useCallback } from "react"
import { useTheme } from "next-themes"

interface FlutterPreviewProps {
  componentName: string
  title?: string
  description?: string
  height?: number
}

export function FlutterPreview({
  componentName,
  title,
  description,
  height = 600,
}: FlutterPreviewProps) {
  const [isLoading, setIsLoading] = useState(true)
  const [showLoader, setShowLoader] = useState(true)
  const [loadStartTime, setLoadStartTime] = useState(Date.now())
  const { theme, resolvedTheme } = useTheme()
  const [mounted, setMounted] = useState(false)

  // Ensure component is mounted before accessing theme
  useEffect(() => {
    setMounted(true)
  }, [])

  // Map component names to local preview paths
  // Components are built from flutter_components/preview_app and served locally
  const flutterComponents: Record<string, string> = {
    "alert-dialog": "alert-dialog",
    // Add more components here as you build them
  }

  const componentPath = flutterComponents[componentName]

  // Get the current theme (light or dark)
  const currentTheme = mounted ? (resolvedTheme || theme || "dark") : "dark"
  const flutterTheme = currentTheme === "light" ? "light" : "dark"

  // Handle loading completion with smooth fade and minimum display time
  const handleLoadComplete = useCallback(() => {
    const elapsedTime = Date.now() - loadStartTime
    const minDisplayTime = 800 // Minimum 800ms to prevent flashing

    if (elapsedTime < minDisplayTime) {
      // Wait for minimum time, then fade out
      setTimeout(() => {
        setIsLoading(false)
        setTimeout(() => setShowLoader(false), 300)
      }, minDisplayTime - elapsedTime)
    } else {
      // Enough time has passed, fade out immediately
      setIsLoading(false)
      setTimeout(() => setShowLoader(false), 300)
    }
  }, [loadStartTime])

  // Fallback: Auto-hide loading after 3 seconds max
  useEffect(() => {
    const fallbackTimer = setTimeout(() => {
      if (isLoading) {
        handleLoadComplete()
      }
    }, 3000)
    return () => clearTimeout(fallbackTimer)
  }, [isLoading, handleLoadComplete])

  // Reset loading state when theme changes
  useEffect(() => {
    if (mounted) {
      setIsLoading(true)
      setShowLoader(true)
      setLoadStartTime(Date.now())
    }
  }, [flutterTheme, mounted])

  // Build local preview URL
  const previewUrl = componentPath
    ? `/flutter-previews/index.html?component=${componentPath}&theme=${flutterTheme}`
    : undefined

  // If no component built yet, show setup instructions
  if (!previewUrl) {
    return (
      <div className="rounded-lg border bg-card">
        <div className="border-b bg-muted/50 px-4 py-3">
          <div className="flex items-center justify-between">
            <div>
              <h3 className="text-sm font-semibold">Flutter Component Preview</h3>
              {title && (
                <p className="text-xs text-muted-foreground">{title}</p>
              )}
            </div>
            <div className="flex items-center gap-2">
              <span className="inline-flex items-center gap-1 rounded-md bg-blue-500/10 px-2 py-1 text-xs font-medium text-blue-500">
                <svg
                  className="size-3"
                  viewBox="0 0 24 24"
                  fill="currentColor"
                >
                  <path d="M14.314 0L2.3 12 6 15.7 21.684.013h-7.357zm.014 11.072L7.857 17.53l6.47 6.47H21.7l-6.46-6.468 6.46-6.46h-7.37z" />
                </svg>
                Flutter
              </span>
            </div>
          </div>
        </div>
        <div className="p-8">
          <div className="flex flex-col items-center gap-4 text-center">
            <div className="rounded-full bg-muted p-4">
              <svg
                className="size-12 text-muted-foreground"
                viewBox="0 0 24 24"
                fill="currentColor"
              >
                <path d="M14.314 0L2.3 12 6 15.7 21.684.013h-7.357zm.014 11.072L7.857 17.53l6.47 6.47H21.7l-6.46-6.468 6.46-6.46h-7.37z" />
              </svg>
            </div>
            <div className="max-w-lg">
              <h4 className="font-semibold">Flutter Preview Setup Required</h4>
              <p className="text-sm text-muted-foreground mt-2">
                To see the live preview, build the Flutter web components:
              </p>
              <div className="mt-4 rounded-md bg-muted p-4 text-left">
                <code className="text-sm">
                  cd flutter_components/preview_app<br />
                  ./build.sh
                </code>
              </div>
              <p className="text-xs text-muted-foreground mt-2">
                Or see <a href="https://github.com/yourusername/flutterbits/blob/main/flutter_components/BUILD_TO_WEB.md" className="underline">BUILD_TO_WEB.md</a> for full instructions.
              </p>
            </div>
            <div className="flex gap-2 mt-4">
              <a
                href={`#usage`}
                className="inline-flex items-center gap-2 rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90"
              >
                View Code Examples
              </a>
            </div>
          </div>
        </div>
      </div>
    )
  }

  return (
    <div className="rounded-lg border bg-card overflow-hidden">
      <div className="border-b bg-muted/50 px-4 py-3">
        <div className="flex items-center justify-between">
          <div>
            <h3 className="text-sm font-semibold">Flutter Component Preview</h3>
            {title && <p className="text-xs text-muted-foreground">{title}</p>}
          </div>
          <div className="flex items-center gap-2">
            <span className="inline-flex items-center gap-1 rounded-md bg-blue-500/10 px-2 py-1 text-xs font-medium text-blue-500">
              <svg className="size-3" viewBox="0 0 24 24" fill="currentColor">
                <path d="M14.314 0L2.3 12 6 15.7 21.684.013h-7.357zm.014 11.072L7.857 17.53l6.47 6.47H21.7l-6.46-6.468 6.46-6.46h-7.37z" />
              </svg>
              Flutter
            </span>
            <a
              href={previewUrl}
              target="_blank"
              rel="noopener noreferrer"
              className="text-xs text-muted-foreground hover:text-foreground"
            >
              Open in New Tab →
            </a>
          </div>
        </div>
      </div>
      <div className="relative" style={{ height: `${height}px` }}>
        {showLoader && (
          <div
            className={`absolute inset-0 flex items-center justify-center bg-muted/50 z-10 transition-opacity duration-300 ${
              isLoading ? 'opacity-100' : 'opacity-0'
            }`}
          >
            <div className="flex flex-col items-center gap-2">
              <div className="size-8 animate-spin rounded-full border-4 border-muted-foreground/20 border-t-muted-foreground" />
              <p className="text-sm text-muted-foreground">Loading Flutter preview...</p>
            </div>
          </div>
        )}
        <iframe
          key={flutterTheme} // Force reload when theme changes
          src={previewUrl}
          className={`w-full h-full border-0 transition-opacity duration-300 ${
            isLoading ? 'opacity-0' : 'opacity-100'
          }`}
          title={`${componentName} Flutter Preview`}
          onLoad={() => {
            console.log('Flutter iframe loaded:', previewUrl)
            handleLoadComplete()
          }}
          onError={(e) => {
            console.error('Flutter iframe error:', e)
            handleLoadComplete()
          }}
        />
      </div>
      {description && (
        <div className="border-t bg-muted/50 px-4 py-2 text-sm text-muted-foreground">
          {description}
        </div>
      )}
    </div>
  )
}
