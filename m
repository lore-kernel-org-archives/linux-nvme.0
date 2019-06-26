From: joshi.k@samsung.com (kanchan)
Date: Wed, 26 Jun 2019 18:17:29 +0530
Subject: [PATCH v5 0/7] Extend write-hint framework, and add write-hint
 for Ext4 journal
In-Reply-To: <20190522102530.GK17019@quack2.suse.cz>
References: <CGME20190425112347epcas2p1f7be48b8f0d2203252b8c9dd510c1b61@epcas2p1.samsung.com>
 <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
 <20190510170249.GA26907@infradead.org>
 <00fb01d50c71$dd358e50$97a0aaf0$@samsung.com>
 <20190520142719.GA15705@infradead.org>
 <20190521082528.GA17709@quack2.suse.cz>
 <20190521082846.GA11024@infradead.org>
 <20190522102530.GK17019@quack2.suse.cz>
Message-ID: <00f301d52c1d$58f1e820$0ad5b860$@samsung.com>

Christoph, 
May I know if you have thoughts about what Jan mentioned below? 

I reflected upon the whole series again, and here is my understanding of
your concern (I hope to address that, once I get it right).
Current patch-set targeted adding two things -
1. Extend write-hint infra for in-kernel callers 
2. Send write-hint for FS-journal

In the process of doing 1, write-hint gets more closely connected to stream
(as hint-to-stream conversion moves to block-layer). 
And perhaps this is something that you've objection on. 
Whether write-hint converts into flash-stream or into something-else is
deliberately left to device-driver and that's why block layer does not have
a hint-to-stream conversion in the first place.
Is this the correct understanding of why things are the way they are?

On 2, sending write-hint for FS journal is actually important, as there is
clear data on both performance and endurance benefits.
RWH_WRITE_LIFE_JOURNAL or REQ_JOURNAL (that Martin Petersen suggested) kind
of thing will help in identifying Journal I/O which can be useful for other
purposes (than streams) as well.
I saw this LSFMM coverage https://lwn.net/Articles/788721/ , and felt that
this could be useful for turbo-write in UFS.   

BR,
Kanchan

-----Original Message-----
From: Jan Kara [mailto:jack@suse.cz] 
Sent: Wednesday, May 22, 2019 3:56 PM
To: 'Christoph Hellwig' <hch at infradead.org>
Cc: Jan Kara <jack at suse.cz>; kanchan <joshi.k at samsung.com>;
linux-kernel at vger.kernel.org; linux-block at vger.kernel.org;
linux-nvme at lists.infradead.org; linux-fsdevel at vger.kernel.org;
linux-ext4 at vger.kernel.org; prakash.v at samsung.com; anshul at samsung.com;
Martin K. Petersen <martin.petersen at oracle.com>
Subject: Re: [PATCH v5 0/7] Extend write-hint framework, and add write-hint
for Ext4 journal

On Tue 21-05-19 01:28:46, 'Christoph Hellwig' wrote:
> On Tue, May 21, 2019@10:25:28AM +0200, Jan Kara wrote:
> > performance benefits for some drives. After all you can just think 
> > about it like RWH_WRITE_LIFE_JOURNAL type of hint available for the
kernel...
> 
> Except that it actuallys adds a parallel insfrastructure.  A 
> RWH_WRITE_LIFE_JOURNAL would be much more palatable, but someone needs 
> to explain how that is:
> 
>  a) different from RWH_WRITE_LIFE_SHORT

The problem I have with this is: What does "short" mean? What if userspace's
notion of short differs from the kernel notion? Also the journal block
lifetime is somewhat hard to predict. It depends on the size of the journal
and metadata load on the filesystem so there's big variance.
So all we really know is that all journal blocks are the same.

>  b) would not apply to a log/journal maintained in userspace that works
>     exactly the same

Lifetime of userspace journal/log may be significantly different from the
lifetime of the filesystem journal. So using the same hint for them does not
look like a great idea?

								Honza
--
Jan Kara <jack at suse.com>
SUSE Labs, CR
