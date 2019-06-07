From: hch@lst.de (Christoph Hellwig)
Date: Fri, 7 Jun 2019 18:46:14 +0200
Subject: [RFC PATCH V7 2/7] nvme: trace: move opcode symbol print to nvme.h
In-Reply-To: <20190606194512.11020-3-minwoo.im.dev@gmail.com>
References: <20190606194512.11020-1-minwoo.im.dev@gmail.com>
 <20190606194512.11020-3-minwoo.im.dev@gmail.com>
Message-ID: <20190607164614.GE7307@lst.de>

On Fri, Jun 07, 2019@04:45:07AM +0900, Minwoo Im wrote:
> The following patches are going to provide the target-side trace which
> might need these kind of macros.  It would be great if it can be shared
> between host and target side both.

And maybe for some nvme-cli tracing in the future..

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
