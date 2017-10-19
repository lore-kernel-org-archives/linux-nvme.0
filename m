From: hch@lst.de (Christoph Hellwig)
Date: Thu, 19 Oct 2017 09:24:00 +0200
Subject: [PATCH 11/17] nvme: get rid of nvme_ctrl_list
In-Reply-To: <mqd60bb7gbi.fsf@linux-x5ow.site>
References: <20171018165258.23212-1-hch@lst.de>
 <20171018165258.23212-12-hch@lst.de> <mqd60bb7gbi.fsf@linux-x5ow.site>
Message-ID: <20171019072400.GA12233@lst.de>

On Thu, Oct 19, 2017@09:22:09AM +0200, Johannes Thumshirn wrote:
> I'm not sure if the removel of the major number module_param is good
> from an ABI POV. This could lead to some unexpected results for those
> poor souls that used it.

It's a completely broken interface, so I have no pity for them..
