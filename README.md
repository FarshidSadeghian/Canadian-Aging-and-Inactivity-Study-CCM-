# Inferring-the-BP-EMG-causal-direction

Convergent cross mapping (CCM) is a non-linear technique for measuring the bidirectional causal relationship between two time series X 〖(x〗_t,t=1,…,L)  and Y (y_t,t=1,…,L), where L is the length of the time series.
To infer causation, CCM uses state-space reconstruction (system state representation using successive lags of a single time series) and Takens' Theorem, which stipulates that if X causes Y, then the historical values of X can be reconstructed from the variable Y alone.
Practically speaking, this is achieved via the "cross mapping" technique: a time delay embedding is generated from Y, and the ability to estimate X from this embedding reveals how much information about X has been encoded into Y.
As a result, how efficiently Y cross maps X determines the causal effect of X on Y.
