From: osandov@osandov.com (Omar Sandoval)
Date: Mon, 15 Jul 2019 16:07:13 -0700
Subject: [PATCH blktests 02/12] nvme: More agressively filter the
 discovery output
In-Reply-To: <20190712235742.22646-3-logang@deltatee.com>
References: <20190712235742.22646-1-logang@deltatee.com>
 <20190712235742.22646-3-logang@deltatee.com>
Message-ID: <20190715230713.GA5449@vader>

On Fri, Jul 12, 2019@05:57:32PM -0600, Logan Gunthorpe wrote:
> Comparing the entire output of nvme-cli for discovery is fragile
> and error prone as things change. There's already been the
> long standing issue of the generation counter mismatching
> and also some versions of nvme-cli print an extra "sq flow control
> disable supported" text[1].
> 
> Instead, filter out all but a few key values from the discovery
> text which should still be sufficient for this test and much
> less likely to be subject to churn.
> 
> [1] https://lore.kernel.org/linux-block/20190505150611.15776-4-minwoo.im.dev at gmail.com/
> 
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> ---
>  tests/nvme/002.out | 6001 --------------------------------------------
>  tests/nvme/016.out |    7 -
>  tests/nvme/017.out |    7 -
>  tests/nvme/rc      |    4 +-
>  4 files changed, 2 insertions(+), 6017 deletions(-)

[snip]

> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 22833d8ef9bb..60dc05869726 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -120,6 +120,6 @@ _find_nvme_loop_dev() {
>  }
>  
>  _filter_discovery() {
> -	sed -r  -e "s/portid:  [0-9]+/portid:  X/" \
> -		-e "s/Generation counter [0-9]+/Generation counter X/"
> +	sed -r -e "s/Generation counter [0-9]+/Generation counter X/" |
> +		grep 'Discovery Log Number\|Log Entry\|trtype\|subnqn'
>  }

This can be done in a single sed command instead of sed + grep:

sed -rn -e 's/Generation counter [0-9]+/Generation counter X/' \
	-e '/Discovery Log Number|Log Entry|trtype|subnqn/p'
