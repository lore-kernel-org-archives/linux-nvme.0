From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 21 May 2019 11:41:27 +0300
Subject: [PATCH] nvme: copy MTFA field from identify controller
In-Reply-To: <20190520174206.29464-1-keith.busch@intel.com>
References: <20190520174206.29464-1-keith.busch@intel.com>
Message-ID: <d73a5e9c-df4b-1670-2502-8ca9cbb89f5e@mellanox.com>


On 5/20/2019 8:42 PM, Keith Busch wrote:
> From: Laine Walker-Avina <laine.walker-avina at intel.com>
>
> We use the controller's reported maximum firmware activation time as our
> timeout before resetting a controller for a failed activation notice,
> but this value was never being read so we could only use the default
> timeout. Copy the Identify Controller MTFA field to the corresponding
> nvme_ctrl's mtfa field.
>
> Fixes: b6dccf7fae433 (?nvme: add support for FW activation without reset?).
> Signed-off-by: Laine Walker-Avina <laine.walker-avina at intel.com>
> [changelog, fix endian]
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>   drivers/nvme/host/core.c | 1 +
>   1 file changed, 1 insertion(+)


Looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
