From: chuck.lever@oracle.com (Chuck Lever)
Date: Thu, 13 Jul 2017 13:19:00 -0400
Subject: [PATCH rfc 3/3] nvmet-rdma: assign cq completion vector based on
 the port allowed cpus
In-Reply-To: <20170713155003.GB2577@lst.de>
References: <1499007694-7231-1-git-send-email-sagi@grimberg.me>
 <1499007694-7231-4-git-send-email-sagi@grimberg.me>
 <20170713155003.GB2577@lst.de>
Message-ID: <C2439AB7-BC2E-4B71-87CA-3F8313282828@oracle.com>


> On Jul 13, 2017,@11:50 AM, Christoph Hellwig <hch@lst.de> wrote:
> 
> We really shouldn't be doing any of this in NVMe I think.  We'll need
> to go back to the cq pool API first.  The last version I had was here:
> 
> 	http://git.infradead.org/users/hch/rdma.git/shortlog/refs/heads/rdma-cq
> 
> and then do the affinity in common code.

This seems to address the problem I mentioned to you with properly
estimating send CQ size when using the rdma_rw API. If these are
going to be merged soon, I can drop the new API I proposed here:

http://git.linux-nfs.org/?p=cel/cel-2.6.git;a=commit;h=2156cb956101da854f64918066710ff4e7affc5b


--
Chuck Lever
