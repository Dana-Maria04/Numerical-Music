# Numerical-Music

### Stereo to mono
The function stereo_to_mono converts a stereo signal into a mono signal by averaging the signals across each row.

This function performs the following steps:

Sampling the Signal: Audio data is read using audioread.

Quantizing the Signal: Bit depth is defined to quantize the signal.

Calculating the Average: The mean function is used to calculate the average across each row of the stereo signal matrix.

Normalizing the Signal: The mono signal is normalized to ensure values are within the correct range.

The functions used in this process are mean, which calculates the average of elements, and max, which finds the maximum absolute value for normalization.

In terms of complexity, the stereo_to_mono function has a complexity of O(n), as the function iterates through each element of the matrix to compute the average and normalize.

### Spectrogram
The spectrogram function takes the signal, sampling rate, and window size as parameters. It returns three values: the spectrogram matrix, the frequency vector, and the time vector.

The spectrogram matrix is a 2D matrix where each row represents a frequency and each column represents a time. The value at position (i, j) represents the amplitude of frequency i at time j.

The frequency vector is a column vector containing all frequencies present in the signal.

The time vector is a column vector containing all the moments at which the STFT (Short-Time Fourier Transform) was calculated.

The steps for calculating the spectrogram are as follows:

Determine Signal Dimension and Number of Windows: Get the signal's dimension and calculate the number of windows using floor.

For Each Window:

Apply the Hann function.
Compute the Fourier Transform of the window with twice the resolution of the window size (fft in MATLAB).
Remove the conjugate part of the Fourier Transform.
Store the result in the spectrogram matrix.
Calculate the Frequency Vector: Note that the Fourier Transform is symmetric, so we only need the first half of the frequencies.

Calculate the Time Vector: The time between each window is the window size divided by the sampling rate (starting from 0).

The functions used are hanning, which applies the Hann window function to weight the segment, fft, which calculates the Fourier Transform of the weighted signal, abs, which returns the absolute value of the Fourier Transform for amplitudes.

The complexity of the spectrogram function is O(n * log n) for each segment where n is the window size. Due to the fft function having a complexity of O(n * log n), the overall complexity for all segments is O(m * n * log n), where m is the number of segments.

#### Oscillator
The oscillator function generates a sinusoidal wave modulated by an ADSR (Attack, Decay, Sustain, Release) envelope.

The function parameters include the frequency of the sinusoidal wave, the duration of the sound, the sampling rate, and parameters for each segment of the envelope.

The function returns the generated sinusoidal wave as a column vector.

The steps for generating the sinusoidal wave are as follows:

Create the Time Vector:

A time vector t is created from 0 to duration with a step of 1/sampling_rate, based on the formula:

time_vector = (0:num_samples-1) / fs
Generate the Sinusoidal Wave:

Use the formula:

sin(2 * pi * frequency * t)
to generate the sinusoidal wave with the specified frequency.

Calculate the Number of Samples for Each Segment:

The number of samples for attack, decay, sustain, and release are calculated based on the envelope parameters and the sampling rate. floor is used to ensure the number of samples is an integer.

Calculate the Envelope for Each Segment:

Attack: Create a linear ramp from 0 to 1 over the attack samples.
Decay: Create a linear ramp from 1 to the sustain level over the decay samples.
Sustain: Create a constant segment equal to the sustain level.
Release: Create a linear ramp from the sustain level to 0 over the release samples.
Concatenate Envelope Segments:

Concatenate the attack, decay, sustain, and release segments to create the final envelope.

Apply the Envelope to the Sinusoidal Wave:

The sinusoidal wave is multiplied by the envelope to apply amplitude modulation.

The functions used in the oscillator are sin, which generates the sinusoidal wave, floor, which ensures the number of samples is an integer, linspace, which creates linear ramps for attack, decay, and release segments, and abs, which returns the absolute value of the Fourier Transform for amplitudes.

In terms of complexity, the oscillator function is O(n).

### Low Pass Filter
The low_pass function creates a filter that allows signals with frequencies lower than a specified cutoff frequency to pass while attenuating signals with frequencies higher than the cutoff frequency.

The function low_pass takes as parameters a signal x, a sampling rate fs, and a cutoff frequency fc.

It returns the filtered signal as a column vector.

The steps are as follows:

Calculate the Fourier Transform of the Signal:

The Fourier Transform (FFT) converts the signal from the time domain to the frequency domain, providing information about the amplitude of each frequency present in the signal.

Calculate All Possible Frequencies of the Signal:

Create a frequency vector corresponding to each element in the FFT, containing all possible frequencies for the given signal, from 0 to fs.

Create a Frequency Mask:

Create a mask vector that is 1 for frequencies less than the cutoff frequency fc and 0 for frequencies higher than fc.

The vector is binary, marking frequencies to keep (1) and frequencies to eliminate (0).

Apply the Hadamard Product Between the Fourier Transform and the Mask:

Apply the Hadamard product to eliminate unwanted frequencies.

The Hadamard product, also known as the element-wise product, is an operation applied to two matrices of the same dimension. Instead of performing a standard matrix product, the Hadamard product multiplies the matrices element-wise.

Calculate the Inverse Fourier Transform to Obtain the Filtered Signal:

Apply the inverse FFT (ifft) to obtain the filtered signal.

filtered_signal = ifft(filtered_transformed_signal);
Normalize the Filtered Signal:

Normalize the filtered signal to ensure its amplitude is within the correct range.

Normalization involves dividing the filtered signal by its maximum absolute value to ensure amplitudes are between -1 and 1.

The functions used are fft, ifft (inverse FFT), max to find the maximum absolute value for normalization, and abs to calculate the absolute value of elements for normalization.

In terms of complexity, the low_pass function is dominated by FFT and IFFT calculations, which have a complexity of O(n log n), where n is the number of samples in the signal.

### Reverb
Reverb is the persistence of sound in a space after the initial sound has been produced.

The apply_reverb function takes the signal and impulse response as parameters. It returns the signal with the impulse response applied.

The steps are as follows:

Ensure the Impulse Response is Mono:

Use stereo_to_mono to convert the impulse response to mono.

Calculate the Convolution Between the Signal and Impulse Response:

Use fftconv from the signal processing toolbox to compute the convolution.

signal = fftconv(signal, impulse_response)
Normalize the Resulting Signal:

Normalize the resulting signal to ensure its amplitude is within the correct range.

signal = signal / max(abs(signal))
The functions used are stereo_to_mono to convert a stereo signal to mono, fftconv to compute the convolution between two signals using FFT, and max and abs.

The complexity of the apply_reverb function is dominated by the FFT convolution calculation, which has a complexity of O(n log n).
