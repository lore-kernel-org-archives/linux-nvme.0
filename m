From: hch@infradead.org ('Christoph Hellwig')
Date: Mon, 20 May 2019 07:27:19 -0700
Subject: [PATCH v5 0/7] Extend write-hint framework, and add write-hint
 for Ext4 journal
In-Reply-To: <00fb01d50c71$dd358e50$97a0aaf0$@samsung.com>
References: <CGME20190425112347epcas2p1f7be48b8f0d2203252b8c9dd510c1b61@epcas2p1.samsung.com>
 <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
 <20190510170249.GA26907@infradead.org>
 <00fb01d50c71$dd358e50$97a0aaf0$@samsung.com>
Message-ID: <20190520142719.GA15705@infradead.org>

On Fri, May 17, 2019@11:01:55AM +0530, kanchan wrote:
> Sorry but can you please elaborate the issue? I do not get what is being
> statically allocated which was globally available earlier.
> If you are referring to nvme driver,  available streams at subsystem level
> are being reflected for all namespaces. This is same as earlier. 
> There is no attempt to explicitly allocate (using dir-receive) or reserve
> streams for any namespace.  
> Streams will continue to get allocated/released implicitly as and when
> writes (with stream id) arrive.

We have made a concious decision that we do not want to expose streams
as an awkward not fish not flesh interface, but instead life time hints.

I see no reason to change from and burden the whole streams complexity
on other in-kernel callers.
