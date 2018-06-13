From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 13 Jun 2018 01:09:59 -0700
Subject: [PATCH] nvme: block ioctls if controller not in a live state
In-Reply-To: <5c025bbe-f784-2bf6-3315-5d27c673afec@broadcom.com>
References: <20180507225558.5009-1-jsmart2021@gmail.com>
 <20180509051156.GB28673@infradead.org>
 <06b65874-8bc8-b532-ad98-44e64b8440b8@broadcom.com>
 <20180514141734.GA26302@infradead.org>
 <2b21ba25-e581-45a7-95ae-8b3f2fe6dcf8@broadcom.com>
 <20180514145318.GA24711@infradead.org>
 <5c025bbe-f784-2bf6-3315-5d27c673afec@broadcom.com>
Message-ID: <20180613080959.GA7429@infradead.org>

On Tue, Jun 12, 2018@04:11:14PM -0700, James Smart wrote:
> I was going to address this by adding the poll support.?? However, after
> reviewing the if_ready changes, they will fall into the USERCMD cases which
> will return the BLK_STST_IOERR and NVME_SC_ABORT_REQ.
> 
> In the nvme cli app, rather than keying retry off the EAGAIN, we could key
> off the ABORT_REQ status. I didn't like that initially as it may correspond
> to a real scenario that wasn't one of the
> reject-as-not-in-a-state-for-an-ioctl cases.
> 
> What do you think - continue with the poll interface and the EAGAIN block
> status, or revise the app EAGAIN check to NVME_SC_ABORT_REQ ?

How about just having an option in the ioctl interface to not mark
the I/O failfast?
