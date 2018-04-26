From: ckulkarnilinux@gmail.com (chaitany kulkarni)
Date: Thu, 26 Apr 2018 09:53:12 -0700
Subject: [PATCH 00/19] nvmet: add support for file backed namespaces
In-Reply-To: <20180424173336.GA30777@lst.de>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
 <20180424173336.GA30777@lst.de>
Message-ID: <CAK0tqi=Q1khb-duvAPCpKNTUbzHufsDvJ6vAQKptkW4WEMbGVQ@mail.gmail.com>

Thanks for the review comments.

I'll send the O_DIRECT single patch first with your review comments
incorporated.

On Tue, Apr 24, 2018@10:33 AM, Christoph Hellwig <hch@lst.de> wrote:
> Hi Chaitanya,
>
> I've been through the patches that implement the simple O_DIRECT
> file support.  I think all these can in fact be merged into a single
> patch and would be easier to review.  Can you resend just that merged
> patch for the next respin?  I think we want to review the buffered
> I/O support and the namespace management support as incremental series
> on top of that to keep things a little smaller and easier to review.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
