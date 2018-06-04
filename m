From: hare@suse.de (Hannes Reinecke)
Date: Mon, 4 Jun 2018 08:15:51 +0200
Subject: [PATCH 08/12] nvmet: mask pending AERs
In-Reply-To: <20180530164600.26856-9-hch@lst.de>
References: <20180530164600.26856-1-hch@lst.de>
 <20180530164600.26856-9-hch@lst.de>
Message-ID: <20180604081551.3a6967f4@pentland.suse.de>

On Wed, 30 May 2018 18:45:56 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Per section 5.2 of the NVMe 1.3 spec:
> 
>   "When the controller posts a completion queue entry for an
> outstanding Asynchronous Event Request command and thus reports an
> asynchronous event, subsequent events of that event type are
> automatically masked by the controller until the host clears that
> event. An event is cleared by reading the log page associated with
> that event using the Get Log Page command (see section 5.14)."
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/target/admin-cmd.c | 1 +
>  drivers/nvme/target/core.c      | 9 ++++++++-
>  drivers/nvme/target/nvmet.h     | 1 +
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
