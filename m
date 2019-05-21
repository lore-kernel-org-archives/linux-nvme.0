From: jack@suse.cz (Jan Kara)
Date: Tue, 21 May 2019 10:25:28 +0200
Subject: [PATCH v5 0/7] Extend write-hint framework, and add write-hint
 for Ext4 journal
In-Reply-To: <20190520142719.GA15705@infradead.org>
References: <CGME20190425112347epcas2p1f7be48b8f0d2203252b8c9dd510c1b61@epcas2p1.samsung.com>
 <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
 <20190510170249.GA26907@infradead.org>
 <00fb01d50c71$dd358e50$97a0aaf0$@samsung.com>
 <20190520142719.GA15705@infradead.org>
Message-ID: <20190521082528.GA17709@quack2.suse.cz>

On Mon 20-05-19 07:27:19, 'Christoph Hellwig' wrote:
> On Fri, May 17, 2019@11:01:55AM +0530, kanchan wrote:
> > Sorry but can you please elaborate the issue? I do not get what is being
> > statically allocated which was globally available earlier.
> > If you are referring to nvme driver,  available streams at subsystem level
> > are being reflected for all namespaces. This is same as earlier. 
> > There is no attempt to explicitly allocate (using dir-receive) or reserve
> > streams for any namespace.  
> > Streams will continue to get allocated/released implicitly as and when
> > writes (with stream id) arrive.
> 
> We have made a concious decision that we do not want to expose streams
> as an awkward not fish not flesh interface, but instead life time hints.
> 
> I see no reason to change from and burden the whole streams complexity
> on other in-kernel callers.

I'm not following the "streams complexity" you talk about. At least the
usecase Kanchan speaks about here is pretty simple for the filesystem -
tagging journal writes with special stream id. I agree that something like
dynamically allocating available stream ids to different purposes is
complex and has uncertain value but this "static stream id for particular
purpose" looks simple and sensible to me and Kanchan has shown significant
performance benefits for some drives. After all you can just think about it
like RWH_WRITE_LIFE_JOURNAL type of hint available for the kernel...

								Honza

-- 
Jan Kara <jack at suse.com>
SUSE Labs, CR
