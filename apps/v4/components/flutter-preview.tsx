"use client"

import { useState, useEffect } from "react"
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
  const { theme, resolvedTheme } = useTheme()
  const [mounted, setMounted] = useState(false)

  // Ensure component is mounted before accessing theme
  useEffect(() => {
    setMounted(true)
  }, [])

  // Map component names to Flutter code locations
  // Using GitHub repo - code lives in flutter_components/examples/
  // Format: 'username/repo/branch/path/to/main.dart'
  const zappProjects: Record<
    string,
    { type: "github"; path: string }
  > = {
    "alert-dialog": {
      type: "github",
      path: "Sumithgatadi/Flutterbits/main/flutter_components/examples/alert_dialog_zapp.dart",
    },
  }

  const projectConfig = zappProjects[componentName]

  // Get the current theme (light or dark)
  const currentTheme = mounted ? (resolvedTheme || theme || "dark") : "dark"
  const zappTheme = currentTheme === "light" ? "light" : "dark"

  // Build Zapp.run URL from GitHub path
  const zappUrl = projectConfig
    ? `https://zapp.run/github/${projectConfig.path}?split=0&theme=${zappTheme}&lazy=true`
    : undefined

  // If no project configured yet, show placeholder
  if (!zappUrl) {
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
            <div className="max-w-md">
              <h4 className="font-semibold">Live Preview Coming Soon</h4>
              <p className="text-sm text-muted-foreground mt-2">
                {description ||
                  "Interactive Flutter preview will be available soon. See the code examples below to use this component."}
              </p>
            </div>
            <div className="flex gap-2 mt-4">
              <a
                href={`#usage`}
                className="inline-flex items-center gap-2 rounded-md bg-primary px-4 py-2 text-sm font-medium text-primary-foreground hover:bg-primary/90"
              >
                View Code Examples
              </a>
              <a
                href="https://zapp.run"
                target="_blank"
                rel="noopener noreferrer"
                className="inline-flex items-center gap-2 rounded-md border bg-background px-4 py-2 text-sm font-medium hover:bg-accent hover:text-accent-foreground"
              >
                <svg className="size-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6" />
                  <polyline points="15 3 21 3 21 9" />
                  <line x1="10" x2="21" y1="14" y2="3" />
                </svg>
                Try in Zapp
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
              href={zappUrl?.split("?")[0]} // Remove params for editing
              target="_blank"
              rel="noopener noreferrer"
              className="text-xs text-muted-foreground hover:text-foreground"
            >
              Open in Zapp →
            </a>
          </div>
        </div>
      </div>
      <div className="relative" style={{ height: `${height}px` }}>
        {isLoading && (
          <div className="absolute inset-0 flex items-center justify-center bg-muted/50">
            <div className="flex flex-col items-center gap-2">
              <div className="size-8 animate-spin rounded-full border-4 border-muted-foreground/20 border-t-muted-foreground" />
              <p className="text-sm text-muted-foreground">Loading preview...</p>
            </div>
          </div>
        )}
        <iframe
          key={zappTheme} // Force reload when theme changes
          src={zappUrl}
          className="w-full h-full border-0"
          title={`${componentName} Flutter Preview`}
          onLoad={() => setIsLoading(false)}
          allow="cross-origin-isolated"
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
