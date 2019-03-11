From: osandov@osandov.com (Omar Sandoval)
Date: Mon, 11 Mar 2019 13:36:43 -0700
Subject: [PATCH 1/2 blktests] nvme: add udevadm settle before disconnecting
In-Reply-To: <20190306094643.10262-1-sagi@grimberg.me>
References: <20190306094643.10262-1-sagi@grimberg.me>
Message-ID: <20190311203643.GB1315@vader>

On Wed, Mar 06, 2019@01:46:42AM -0800, Sagi Grimberg wrote:
> otherwise we can see some I/O failures as udev didn't get enough time
> to do its thing.

Thanks, applied this one. I'll wait for your response on patch 2.

> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  tests/nvme/008 | 2 ++
>  tests/nvme/009 | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/tests/nvme/008 b/tests/nvme/008
> index d73ec7d6d97a..04ff0bda42e3 100755
> --- a/tests/nvme/008
> +++ b/tests/nvme/008
> @@ -41,6 +41,8 @@ test() {
>  	cat "/sys/block/${nvmedev}n1/uuid"
>  	cat "/sys/block/${nvmedev}n1/wwid"
>  
> +	udevadm settle
> +
>  	nvme disconnect -n "${subsys_name}"
>  
>  	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
> diff --git a/tests/nvme/009 b/tests/nvme/009
> index a46168123c56..81e61f99aba5 100755
> --- a/tests/nvme/009
> +++ b/tests/nvme/009
> @@ -37,6 +37,8 @@ test() {
>  	cat "/sys/block/${nvmedev}n1/uuid"
>  	cat "/sys/block/${nvmedev}n1/wwid"
>  
> +	udevadm settle
> +
>  	nvme disconnect -n "${subsys_name}"
>  
>  	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
> -- 
> 2.17.1
> 
