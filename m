From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Fri, 10 May 2019 18:05:22 +0000
Subject: [PATCH 0/3] nvme-core: add user command filter
References: <20190508183634.4682-1-chaitanya.kulkarni@wdc.com>
Message-ID: <SN6PR04MB45272218338D99D53202D70B860C0@SN6PR04MB4527.namprd04.prod.outlook.com>

Gentle ping.

On 05/08/2019 11:36 AM, Chaitanya Kulkarni wrote:
> This patch-series adds a filter to allow only certain user commands.
> Right now we use this infrastructure to prevent the user get log page
> commands where RAE bit is cleared. We only allow get log pages to be
> read with RAE == 0 where we issue the uevent to the userspace so that
> user can clear the log pages.
>
> Here we white list the log pages which are only allowed when RAE == 0.
> We also allow Vendor Specific log pages irrespective of the RAE.
>
> Chaitanya Kulkarni (3):
>    nvme: introduce and use RAE bit macro
>    nvme: add sanitize log identifier
>    nvme-core: add filter for user commands
>
>   drivers/nvme/host/core.c    | 64 ++++++++++++++++++++++++++++++++++---
>   drivers/nvme/target/nvmet.h |  2 +-
>   include/linux/nvme.h        |  3 ++
>   3 files changed, 64 insertions(+), 5 deletions(-)
>
