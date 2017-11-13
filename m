From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Mon, 13 Nov 2017 13:34:44 -0700
Subject: [PATCH v3 0/9] Introduce per-device completion queue pools
In-Reply-To: <6af627c8-2814-d562-21a2-f10788e44458@grimberg.me>
References: <20171108095742.25365-1-sagi@grimberg.me>
 <1510245771.2608.6.camel@wdc.com>
 <d5820b65-b428-7cd1-f7f1-7d8d89d21cf5@grimberg.me>
 <1510248716.2608.17.camel@wdc.com>
 <6af627c8-2814-d562-21a2-f10788e44458@grimberg.me>
Message-ID: <20171113203444.GJ22610@ziepe.ca>

On Mon, Nov 13, 2017@10:31:26PM +0200, Sagi Grimberg wrote:
> 
> >>But I'm afraid don't understand how the fact that ULPs will run on
> >>different ports matter? how would the fact that we had two different
> >>pools on different ports make a difference?
> >
> >If each RDMA port is only used by a single ULP then the ULP driver can provide
> >a better value for the CQ size than IB_CQE_BATCH. If CQ pools would be created
> >by ULPs then it would be easy for ULPs to pass their choice of CQ size to the
> >RDMA core.
> 
> But if that is not the case, maybe we may have less completion
> aggragation per interrupt.

It is too bad we can't re-size CQs.. Can we?

Jason
