From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Sep 2016 10:33:33 +0200
Subject: [PATCH v3 1/3] nvme/scsi: Remove power management support
In-Reply-To: <714df91022b06c6799afb315962769f22b8ab9f4.1474002926.git.luto@kernel.org>
References: <cover.1474002926.git.luto@kernel.org>
 <714df91022b06c6799afb315962769f22b8ab9f4.1474002926.git.luto@kernel.org>
Message-ID: <20160916083333.GB2415@lst.de>

On Thu, Sep 15, 2016@10:24:19PM -0700, Andy Lutomirski wrote:
> As far as I can tell, there is basically nothing correct about this
> code.  It misinterprets npss (off-by-one).  It hardcodes a bunch of
> power states, which is nonsense, because they're all just indices
> into a table that software needs to parse.  It completely ignores
> the distinction between operational and non-operational states.
> And, until 4.8, if all of the above magically succeeded, it would
> dereference a NULL pointer and OOPS.
> 
> Since this code appears to be useless, just delete it.

Yes, please!

Acked-by: Christoph Hellwig <hch at lst.de>
