From: jsmart2021@gmail.com (James Smart)
Date: Thu, 4 May 2017 12:24:34 -0700
Subject: [RFC 0/7] nvme_fc: add dev_loss_tmo support
In-Reply-To: <20170504180737.5472-1-jsmart2021@gmail.com>
References: <20170504180737.5472-1-jsmart2021@gmail.com>
Message-ID: <38787b57-5778-5e26-5fd0-0159568e9c6b@gmail.com>

On 5/4/2017 11:07 AM, jsmart2021@gmail.com wrote:
> Also, a reconnect window only makes sense if
> the target stays alive for the duration of the window. Currently,
> there is no attempt to set KATO so that it is aligned with the window.
> In fact, in most cases, KATO is set far smaller than reconnect windows.
> There's also no way currently, other than snooping, for the transport
> to know the KATO value set in the connect command.

I should give some additional context.

Currently, if there is an error or connectivity loss, the existing 
association is torn down immediately. Therefore, it is independent of 
KATO and KATO doesn't really matter as a new association will always 
replace the old one.

But, in the future, FC-NVME will support retransmission. Meaning we 
would not immediately delete the existing association and terminate all 
i/o. Therefore, it would be preferred if the association stays active at 
the target at least as long as our connectivity window (if possible), 
and i/o resumes, perhaps with retransmission to recover from errors that 
occurred during the loss of connectivity.

So, the first solution could ignore KATO, but I'd like to discuss it for 
the future.

-- james
