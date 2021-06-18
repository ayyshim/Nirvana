package np.com.uashim.nirvana;

import android.media.AudioFormat;
import android.media.AudioManager;
import android.media.AudioTrack;

class Nirvana {
     private double offsetFrequency = 0;
     private double carrierFrequency = 0;
     private double beatFrequency = 0;

    private AudioTrack sound;

    private short[] samples;

    Nirvana() {
        sound = generateTone();
        sound.setVolume(0.5f);
    }

    void setBeatFrequency(double beatFrequency, boolean play) {
        this.beatFrequency = beatFrequency;
        this.offsetFrequency = this.carrierFrequency + beatFrequency;
        if(play) {
            sound.stop();
            sound = generateTone();
            this.play();
        } else {
            sound = generateTone();
        }

    }

    void setCarrierFrequency(double carrierFrequency, boolean play) {
        this.carrierFrequency = carrierFrequency;
        this.offsetFrequency = carrierFrequency + this.beatFrequency;
        if(play) {
            sound.stop();
            sound = generateTone();
            this.play();
        } else {
            sound = generateTone();
        }

    }

    void play() {
        sound.setLoopPoints(0, this.samples.length / 4, -1);
        sound.play();
    }

    void stop() {
        sound.stop();
    }

    void setVolume(double volume) {
        sound.setVolume((float)volume/100);
    }

    private AudioTrack generateTone() {
        double sampleRate = 96000.0;
        int count = (int)(sampleRate * 2.0 * (1000/1000.0)) & ~1;
        this.samples = new short[count];
        for(int i = 0; i < count; i += 2) {
            short sample = (short)(Math.sin(2 * Math.PI * i / (sampleRate / carrierFrequency)) * 0x7FFF);
            this.samples[i+1] = sample;

        }

        for(int i = 0; i < count; i += 2) {
            short sample = (short)(Math.sin(2 * Math.PI * i / (sampleRate / offsetFrequency)) * 0x7FFF);
            this.samples[i] = sample;
        }

        AudioTrack track =  new AudioTrack(AudioManager.STREAM_MUSIC, (int) sampleRate,
                AudioFormat.CHANNEL_OUT_STEREO, AudioFormat.ENCODING_PCM_16BIT,
                count * (Short.SIZE / 8), AudioTrack.MODE_STATIC);

        track.write(this.samples, 0, count);

        return track;
    }
}
