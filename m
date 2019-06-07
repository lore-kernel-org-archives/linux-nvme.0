From: hch@lst.de (Christoph Hellwig)
Date: Fri, 7 Jun 2019 18:52:44 +0200
Subject: [RFC PATCH V7 5/7] nvme: trace: filter out unnecessary fields
 for fabrics
In-Reply-To: <20190606194512.11020-6-minwoo.im.dev@gmail.com>
References: <20190606194512.11020-1-minwoo.im.dev@gmail.com>
 <20190606194512.11020-6-minwoo.im.dev@gmail.com>
Message-ID: <20190607165244.GH7307@lst.de>

On Fri, Jun 07, 2019@04:45:10AM +0900, Minwoo Im wrote:
> If the given command is for fabrics command, then it should not print
> out the following fields which are for the !fabrics commands:
>   1) "flags" (FUSE, PSDT).
>   2) "nsid" which is reserved in fabrics command.
>   3) "metadata" which is also reserved in fabrics.
> 
> To make !fabrics commands clear, don't print them out in case of fabrics
> commands.

Well, they are all reserved and shall be clared to zero.  So I really
don't see any harm in printing them if we can keep the tracing code
simpler and the output more regular.
