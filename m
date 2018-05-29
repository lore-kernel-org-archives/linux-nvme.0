From: hch@lst.de (Christoph Hellwig)
Date: Tue, 29 May 2018 14:48:18 +0200
Subject: [PATCH 04/10] nvme: clear current path on ANA state change
In-Reply-To: <20180529101431.62271-5-hare@suse.de>
References: <20180529101431.62271-1-hare@suse.de>
 <20180529101431.62271-5-hare@suse.de>
Message-ID: <20180529124818.GD7376@lst.de>

On Tue, May 29, 2018@12:14:25PM +0200, Hannes Reinecke wrote:
> Whenever ANA state changes the path selection needs to be retriggered,
> so we should be clearing the current path here.

No, it doesn't.  We always check that the current path is optimized
in nvme_find_path, and trigger a reselection there if it isn't.
