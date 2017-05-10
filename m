From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 10 May 2017 10:05:58 -0700
Subject: [PATCH] nvme_fc: remove extra controller reference taken on
 reconnect
In-Reply-To: <20170504180654.5356-1-jsmart2021@gmail.com>
References: <20170504180654.5356-1-jsmart2021@gmail.com>
Message-ID: <20170510170558.GB15161@infradead.org>

On Thu, May 04, 2017@11:06:54AM -0700, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> remove extra controller reference taken on reconnect

I think proper fix would be to move the kref_get into nvme_fc_init_ctrl
just after the call to nvme_fc_create_association.
