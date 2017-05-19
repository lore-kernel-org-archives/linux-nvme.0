From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 18 May 2017 23:35:05 -0700
Subject: [PATCH] nvme: Change our APST table to be no more aggressive
 than Intel RSTe
In-Reply-To: <CALCETrUYutdtp5U7oYwf7-eNuB0MrwoC18mG5-S8iOP4ZEVDuA@mail.gmail.com>
References: <ddc5be5d81966effaf73e3cee54330c351bc8169.1494561654.git.luto@kernel.org>
 <CALCETrUYutdtp5U7oYwf7-eNuB0MrwoC18mG5-S8iOP4ZEVDuA@mail.gmail.com>
Message-ID: <20170519063505.GA15980@infradead.org>

On Thu, May 18, 2017@06:13:55PM -0700, Andy Lutomirski wrote:
> a) Leave the Dell quirk in place until someone from Dell or Samsung
> figures out what's actually going on.  Add a blanket quirk turning off
> the deepest sleep state on all Intel devices [1] at least until
> someone from Intel figures out what's going on -- Hi, Keith!  Deal
> with any other problems as they're reported.

I think we should just blacklist the 60p entirely.  It also seems to
corrupt data 100% reliable when used with XFS.
