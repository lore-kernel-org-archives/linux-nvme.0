From: hch@lst.de (Christoph Hellwig)
Date: Fri, 28 Oct 2016 07:29:11 +0200
Subject: [PATCH v4 0/3] nvme power saving
In-Reply-To: <CALCETrVuAfpavqkyfKeqBtcCyZuThNxvOorcvmEzwTxyDrzEpg@mail.gmail.com>
References: <cover.1474049701.git.luto@kernel.org>
 <13b0fe95-01b8-89d7-df76-efc1aa14b27a@fb.com>
 <CALCETrV6GAZFG+cjdQrJpP7wVphfeRd=+UeTQcs5-iQYxNk6XA@mail.gmail.com>
 <0a2ffd51-6e0f-7db3-8135-84317d8f77bc@fb.com>
 <1474580016.15303.31.camel@linux.intel.com>
 <CALCETrUgU6Od9iKr87GMs7ZOd-xb5GL7GR-EH4DEo22uzKuPSA@mail.gmail.com>
 <CALCETrVuAfpavqkyfKeqBtcCyZuThNxvOorcvmEzwTxyDrzEpg@mail.gmail.com>
Message-ID: <20161028052911.GA8999@lst.de>

On Thu, Oct 27, 2016@05:06:16PM -0700, Andy Lutomirski wrote:
> It looks like there is at least one NVMe disk in existence (a
> different Samsung device) that sporadically dies when APST is on.
> This device appears to also sporadically die when APST is off, but it
> lasts considerably longer before dying with APST off.

Judy, can you help Andy to find someone in Samsung to report this
to?

> So here's what I'm tempted to do:
> 
>  - For devices that report NVMe version 1.2 support, APST is on by
> default.  I hope this is safe.

It should be safe.  That being said NVMe is being driven more and more
into consumer markets so eventually we will find some device we need
to work around inevitably, but that's life.

>  - For devices that don't report NVMe 1.2 or higher but do report
> APSTA (which implies NVMe 1.1), then we can have a blacklist or a
> whitelist.  A blacklist is nicer, but a whitelist is safer.

We just had a discussion about advertising features before claiming
conformance where they appear in in the NVMe technical working group.
The general concensus was that it should be safe.  I'm thus tempted
to start out with the blacklist.

>  - A sysfs and/or module control allows overriding this.
> 
>  - Implement dev_pm_qos latency control.  The chosen latency (if APST
> is enabled) will be the lesser of the dev_pm_qos setting and a module
> parameter.
> 
> How does that sound?

Great!
