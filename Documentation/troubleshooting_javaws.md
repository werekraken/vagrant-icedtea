# Troubleshooting `javaws`

Here is a very basic test of `javaws` which is expected to open an informational GUI window.
```
DISPLAY=:0.0 javaws -about
```

A downloaded `.jnlp` opened on the command line will produce output which can be useful for troubleshooting.
```
DISPLAY=:0.0 javaws ./Downloads/viewer.jnlp
```
