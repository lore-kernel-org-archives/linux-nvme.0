From: hch@lst.de (Christoph Hellwig)
Date: Tue, 19 Jun 2018 07:40:56 +0200
Subject: [PATCH v4 0/3] NVMF/RDMA 16K Inline Support
In-Reply-To: <3f3b2259-b41b-59bd-c7b6-b5102849aec4@opengridcomputing.com>
References: <cover.1528219321.git.swise@opengridcomputing.com>
 <4f16cd07-015e-d1cf-f8fd-069c460ee2a6@opengridcomputing.com>
 <3f3b2259-b41b-59bd-c7b6-b5102849aec4@opengridcomputing.com>
Message-ID: <20180619054056.GB23184@lst.de>

On Mon, Jun 18, 2018@10:18:18AM -0500, Steve Wise wrote:
> 
> 
> On 6/18/2018 9:49 AM, Steve Wise wrote:
> > Hey Christoph,? will you merge patches 2 and 3 for -next?? I think
> > they're ready.?? I also have a nvmetcli patch I can send out for using
> > param_inline_data_size.
> >
> >
> 
> Or I can rebase on 4.18-rc1 and resend...

Yes, please do.  I'd also like to see at least an ACK from one or our
RDMA low level experts.
