From: joshi.k@samsung.com (kanchan)
Date: Fri, 17 May 2019 11:01:55 +0530
Subject: [PATCH v5 0/7] Extend write-hint framework, and add write-hint
 for Ext4 journal
In-Reply-To: <20190510170249.GA26907@infradead.org>
References: <CGME20190425112347epcas2p1f7be48b8f0d2203252b8c9dd510c1b61@epcas2p1.samsung.com>
 <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
 <20190510170249.GA26907@infradead.org>
Message-ID: <00fb01d50c71$dd358e50$97a0aaf0$@samsung.com>

Hi Christoph, 

> Including the one this model causes on at least some SSDs where you now
statically allocate resources to a stream that is now not globally
available.  

Sorry but can you please elaborate the issue? I do not get what is being
statically allocated which was globally available earlier.
If you are referring to nvme driver,  available streams at subsystem level
are being reflected for all namespaces. This is same as earlier. 
There is no attempt to explicitly allocate (using dir-receive) or reserve
streams for any namespace.  
Streams will continue to get allocated/released implicitly as and when
writes (with stream id) arrive.

> All for the little log with very short date lifetime that any half decent
hot/cold partitioning algorithm in the SSD should be able to detect.

With streams, hot/cold segregation is happening at the time of placement
itself, without algorithm; that is a clear win over algorithms which take
time/computation to be able to do the same.
And infrastructure update (write-hint-to-stream-id conversion in
block-layer,  in-kernel hints etc.) seems to be required anyway for streams
to extend its reach beyond nvme and user-space hints.
  
Thanks,

-----Original Message-----
From: Christoph Hellwig [mailto:hch@infradead.org] 
Sent: Friday, May 10, 2019 10:33 PM
To: Kanchan Joshi <joshi.k at samsung.com>
Cc: linux-kernel at vger.kernel.org; linux-block at vger.kernel.org;
linux-nvme at lists.infradead.org; linux-fsdevel at vger.kernel.org;
linux-ext4 at vger.kernel.org; prakash.v at samsung.com; anshul at samsung.com
Subject: Re: [PATCH v5 0/7] Extend write-hint framework, and add write-hint
for Ext4 journal

I think this fundamentally goes in the wrong direction.  We explicitly
designed the block layer infrastructure around life time hints and not the
not fish not flesh streams interface, which causes all kinds of problems.

Including the one this model causes on at least some SSDs where you now
statically allocate resources to a stream that is now not globally
available.  All for the little log with very short date lifetime that any
half decent hot/cold partitioning algorithm in the SSD should be able to
detect.
