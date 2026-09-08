**1. Downgrade the VS Code Speech Extension**

A known bug in newer versions of the VS Code Speech extension can cause audio input to break.

- Open the Extensions view (`Ctrl+Shift+X` or `Cmd+Shift+X`).
- Search for **VS Code Speech**.
- Click the gear icon next to the extension and select **Install Another Version...**
- Choose an older stable version (such as `v0.10.0`).
- **How to verify:** Click the microphone in Copilot Chat to see if it starts listening instead of immediately failing.

**2. Increase the Speech Timeout Setting**

If the microphone starts but stops recording when you briefly pause, Copilot is interpreting transient silence as the end of your input.

- Open VS Code Settings (`Ctrl+,` or `Cmd+,`).
- Search for  ` accessibility.voice.speechTimeout ` .
- Increase the value to a higher number to prevent early cut-offs.
- **How to verify:** Start recording and pause for 3 seconds. The recording should continue instead of ending your prompt.

**3. Verify the Local Dictation Model Download**

By default, VS Code downloads a local speech recognition model on first use.  If your network blocked this download, dictation will not function.

- Open the Command Palette (`Ctrl+Shift+P` or `Cmd+Shift+P`).
- Type and select `Chat: Install Dictation Model from Local Package...` to manually install it if the automatic download failed.
- **How to verify:** Once the model is successfully loaded, the microphone icon in the chat input will become responsive.

**4. Check OS Microphone Permissions**

Your operating system may be blocking VS Code from accessing the microphone.

- **Windows:** Go to Settings > Privacy & security > Microphone. Ensure VS Code is allowed.
- **macOS:** Go to System Settings > Privacy & Security > Microphone. Ensure VS Code is toggled on.
- **How to verify:** Trigger dictation in VS Code and look for the microphone indicator in your OS taskbar or menu bar.
