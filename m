From: kbusch@kernel.org (Keith Busch)
Date: Mon, 11 Mar 2019 09:42:39 -0600
Subject: [PATCH 4/5] nvme: Fail dead namespace's entered requests
In-Reply-To: <671edb24-d3a7-988e-c1e5-3ba140da5451@oracle.com>
References: <20190308174006.5032-1-keith.busch@intel.com>
 <20190308174006.5032-4-keith.busch@intel.com>
 <671edb24-d3a7-988e-c1e5-3ba140da5451@oracle.com>
Message-ID: <20190311154239.GB10411@localhost.localdomain>

On Sun, Mar 10, 2019@08:58:21PM -0700, jianchao.wang wrote:
> Hi Keith
> 
> How about introducing a per hctx queue_rq callback, then install a
> separate .queue_rq callback for the dead hctx. Then we just need to
> start and complete the request there.

That sounds like it could work, though I think just returning
BLK_STS_IOERR like we currently do is better than starting a completing
it. But adding a new callback that can change at runtime is a more
complicated, and would affect a lot more drivers that I am not able
to test.
