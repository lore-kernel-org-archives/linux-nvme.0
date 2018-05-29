From: hch@lst.de (Christoph Hellwig)
Date: Tue, 29 May 2018 14:48:31 +0200
Subject: [PATCH 05/10] nvme: retry nvme_get_log_ext() when processing
 ANA log
In-Reply-To: <20180529101431.62271-6-hare@suse.de>
References: <20180529101431.62271-1-hare@suse.de>
 <20180529101431.62271-6-hare@suse.de>
Message-ID: <20180529124830.GE7376@lst.de>

On Tue, May 29, 2018@12:14:26PM +0200, Hannes Reinecke wrote:
> When we can't fetch the ANA log page we should retry to ensure
> that we really have nothing to read.

Why?
