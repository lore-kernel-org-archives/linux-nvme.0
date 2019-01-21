From: hch@lst.de (Christoph Hellwig)
Date: Mon, 21 Jan 2019 14:49:52 +0100
Subject: [PATCHv2] nvme: handle static ANA groups correctly
In-Reply-To: <01d7d14f-2ff8-737b-af4d-2a6444efc38d@grimberg.me>
References: <20190117073854.40462-1-hare@suse.de>
 <01d7d14f-2ff8-737b-af4d-2a6444efc38d@grimberg.me>
Message-ID: <20190121134952.GA25858@lst.de>

On Mon, Jan 21, 2019@01:15:13AM -0800, Sagi Grimberg wrote:
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
>
> This seems like 5.1 material, anyone thinks this should
> go into 5.0?

Well, we underallocate a buffer without for a certain controller
feature set.  I think we should merge Hannes' initial patch after
all which is a trivial two liner, and that seems spot on and safe
for 5.0.
