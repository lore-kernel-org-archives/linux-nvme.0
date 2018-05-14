From: osandov@osandov.com (Omar Sandoval)
Date: Mon, 14 May 2018 13:02:52 -0700
Subject: [PATCH blktests 1/3] nvme: move _find_nvme_loop_dev to common code
In-Reply-To: <20180503150054.14022-1-jthumshirn@suse.de>
References: <20180503150054.14022-1-jthumshirn@suse.de>
Message-ID: <20180514200252.GA13417@vader>

On Thu, May 03, 2018@05:00:52PM +0200, Johannes Thumshirn wrote:
> _find_nvme_loop_dev is quite useful for all nvme test, so move it over
> to common code.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  common/nvme    | 10 ++++++++++
>  tests/nvme/004 | 14 ++------------
>  2 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/common/nvme b/common/nvme
> index c6718f04811b..c4a44065cd9f 100644
> --- a/common/nvme
> +++ b/common/nvme
> @@ -93,3 +93,13 @@ _remove_nvmet_subsystem_from_port() {
>  
>  	rm "${nvmet_cfs}/ports/${port}/subsystems/${nvmet_subsystem}"
>  }
> +
> +_find_nvme_loop_dev() {
> +	for dev in /sys/class/nvme/nvme*; do
> +		dev="$(basename "$dev")"
> +		transport="$(cat "/sys/class/nvme/${dev}/transport")"
> +		if [[ "$transport" == "loop" ]]; then
> +			echo "$dev"
> +		fi
> +	done
> +}
> diff --git a/tests/nvme/004 b/tests/nvme/004
> index 65bcd40d86d1..2f970b366d41 100755
> --- a/tests/nvme/004
> +++ b/tests/nvme/004
> @@ -27,16 +27,6 @@ requires() {
>  		_have_configfs
>  }
>  
> -_find_nvme_loop_dev() {
> -	for dev in /sys/block/nvme*; do
> -		dev="$(basename "$dev")"
> -		transport="$(cat "/sys/block/${dev}/device/transport")"
> -		if [[ "$transport" == "loop" ]]; then
> -			echo "$dev"
> -		fi
> -	done
> -}
> -
>  test() {
>  	echo "Running ${TEST_NAME}"
>  
> @@ -59,8 +49,8 @@ test() {
>  
>  	local nvmedev
>  	nvmedev="$(_find_nvme_loop_dev)"
> -	cat "/sys/block/${nvmedev}/uuid"
> -	cat "/sys/block/${nvmedev}/wwid"
> +	cat "/sys/block/${nvmedev}n1/uuid"
> +	cat "/sys/block/${nvmedev}n1/wwid"
>  
>  	_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-1"
>  	_remove_nvmet_subsystem "blktests-subsystem-1"
> -- 
> 2.16.3
> 

Thanks, Johannes, applied. I split patch 1 into two, though; one fixing
the test, and one just moving the function.
