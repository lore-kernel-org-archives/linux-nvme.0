From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 8 Jun 2019 10:57:10 +0900
Subject: [RFC PATCH V7 2/7] nvme: trace: move opcode symbol print to nvme.h
In-Reply-To: <20190607164614.GE7307@lst.de>
References: <20190606194512.11020-1-minwoo.im.dev@gmail.com>
 <20190606194512.11020-3-minwoo.im.dev@gmail.com>
 <20190607164614.GE7307@lst.de>
Message-ID: <20190608015710.GG1276@minwooim-desktop>

On 19-06-07 18:46:14, Christoph Hellwig wrote:
> On Fri, Jun 07, 2019@04:45:07AM +0900, Minwoo Im wrote:
> > The following patches are going to provide the target-side trace which
> > might need these kind of macros.  It would be great if it can be shared
> > between host and target side both.
> 
> And maybe for some nvme-cli tracing in the future..

If you mean some of IOCTLs rather than for the commands, than I
would be happy to go with them after this series.

> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>

Thanks for your review, by the way.
