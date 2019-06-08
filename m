From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 8 Jun 2019 10:35:07 +0900
Subject: [RFC PATCH V7 3/7] nvme: trace: put cid with le16_to_cpu()
In-Reply-To: <20190607164723.GF7307@lst.de>
References: <20190606194512.11020-1-minwoo.im.dev@gmail.com>
 <20190606194512.11020-4-minwoo.im.dev@gmail.com>
 <20190607164723.GF7307@lst.de>
Message-ID: <20190608013507.GC1276@minwooim-desktop>

On 19-06-07 18:47:23, Christoph Hellwig wrote:
> On Fri, Jun 07, 2019@04:45:08AM +0900, Minwoo Im wrote:
> > The CID(Command Identifier) is in 16bits so that we need to convert it
> > to cpu's one.
> 
> The command identifier is 16-bits wide, but it is a field that the
> controller just passes through and never interprets.  Because of that
> it isn't marked as __le16 in nvme.h either.
> 
> > -		__entry->cid = cmd->common.command_id;
> > +		__entry->cid = le16_to_cpu(cmd->common.command_id);
> 
> This will actually create a sparse warning.

This is a horrible mistake that I made.  Sorry for making confusions.
Please ignore this patch in this series.

Thanks,
