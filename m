From: israelr@mellanox.com (Israel Rukshin)
Date: Tue, 12 Jun 2018 18:41:53 +0300
Subject: [PATCH 08/12] nvmet: mask pending AERs
In-Reply-To: <20180530164600.26856-9-hch@lst.de>
References: <20180530164600.26856-1-hch@lst.de>
 <20180530164600.26856-9-hch@lst.de>
Message-ID: <b0427eb1-5bba-4c2b-c7fd-8df3b6dad2cf@mellanox.com>

On 5/30/2018 7:45 PM, Christoph Hellwig wrote:
> Per section 5.2 of the NVMe 1.3 spec:
>
>    "When the controller posts a completion queue entry for an outstanding
>    Asynchronous Event Request command and thus reports an asynchronous
>    event, subsequent events of that event type are automatically masked by
>    the controller until the host clears that event. An event is cleared by
>    reading the log page associated with that event using the Get Log Page
>    command (see section 5.14)."
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/target/admin-cmd.c | 1 +
>   drivers/nvme/target/core.c      | 9 ++++++++-
>   drivers/nvme/target/nvmet.h     | 1 +
>   3 files changed, 10 insertions(+), 1 deletion(-)
>

Hi Christoph,

There is a backwards compatibility issue with this patch.
I tested the latest nvme target with an older initiator that doesn't use
the changed namespaces list log to clear ns data changed AENs.
The target doesn't send the second NS_CHANGED event because the
NVME_AEN_CFG_NS_ATTR bit is not clear.
I have a simple fix that clear the bit also at 
nvmet_execute_identify_ctrl().

What do you think? is there a better way to solve it?

Regards,
Israel
