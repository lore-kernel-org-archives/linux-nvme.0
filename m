From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 2 Jul 2017 12:14:31 +0300
Subject: [PATCH v2 0/3] Allow ib_clients to nullify .add but still get
 .remove events reliably
In-Reply-To: <1498983652-18250-1-git-send-email-sagi@grimberg.me>
References: <1498983652-18250-1-git-send-email-sagi@grimberg.me>
Message-ID: <8927ea7d-c6ba-4f32-4ede-0897e83bcda2@mellanox.com>



On 7/2/2017 11:20 AM, Sagi Grimberg wrote:
> Some ULPs are just interested in device removal notification with no specific
> association because they work over RDMA_CM so no need for detecting appearance
> of the devices. That wasn't the because the corresponding ib_client_data
> was never added to the device clients list when the ib_client registers,
> Patch 1 fixes it. Patches 2-3 just removes the empty .add callout nvme(t)-rdma set.
>
> Changes from v1:
> - reword patch 1 change log title
> - collected review tags
>
> Note that this will create a conflict with jens's for-4.13 which we added
> ib_client registration to nvmet-rdma.
>
> Sagi Grimberg (3):
>   RDMA/core: make ib_device.add method optional
>   nvme-rdma: remove redundant empty device add callout
>   nvmet-rdma: remove redundant empty device add callout

All these patches looks fine to me,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
