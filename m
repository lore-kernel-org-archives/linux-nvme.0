From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 6 Mar 2019 19:53:42 +0000
Subject: [PATCH 1/2 blktests] nvme: add udevadm settle before disconnecting
References: <20190306094643.10262-1-sagi@grimberg.me>
Message-ID: <SN6PR04MB4527274226646371E4486CF986730@SN6PR04MB4527.namprd04.prod.outlook.com>

On 3/6/19 1:47 AM, Sagi Grimberg wrote:
> otherwise we can see some I/O failures as udev didn't get enough time
> to do its thing.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   tests/nvme/008 | 2 ++
>   tests/nvme/009 | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/tests/nvme/008 b/tests/nvme/008
> index d73ec7d6d97a..04ff0bda42e3 100755
> --- a/tests/nvme/008
> +++ b/tests/nvme/008
> @@ -41,6 +41,8 @@ test() {
>   	cat "/sys/block/${nvmedev}n1/uuid"
>   	cat "/sys/block/${nvmedev}n1/wwid"
>   
> +	udevadm settle
> +
>   	nvme disconnect -n "${subsys_name}"
>   
>   	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
> diff --git a/tests/nvme/009 b/tests/nvme/009
> index a46168123c56..81e61f99aba5 100755
> --- a/tests/nvme/009
> +++ b/tests/nvme/009
> @@ -37,6 +37,8 @@ test() {
>   	cat "/sys/block/${nvmedev}n1/uuid"
>   	cat "/sys/block/${nvmedev}n1/wwid"
>   
> +	udevadm settle
> +
>   	nvme disconnect -n "${subsys_name}"
>   
>   	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
> 

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
