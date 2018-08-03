From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri, 03 Aug 2018 20:59:57 +0900
Subject: [PATCH V3 2/2] nvme-cli: add ana-log documentation
In-Reply-To: <20180802032819.6558-3-chaitanya.kulkarni@wdc.com>
References: <20180802032819.6558-1-chaitanya.kulkarni@wdc.com>
 <20180802032819.6558-3-chaitanya.kulkarni@wdc.com>
Message-ID: <1533297597.2982.12.camel@gmail.com>

Hi Chaitanya,

Here's my review on this doc.

On 18-08-01 20:28:19, Chaitanya Kulkarni wrote:
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> Reviewed-by: Hannes Reinecke <hare at suse.com>
> ---
> diff --git a/Documentation/nvme-ana-log.txt b/Documentation/nvme-ana-log.txt
> new file mode 100644
> index 0000000..3514504
> --- /dev/null
> +++ b/Documentation/nvme-ana-log.txt
> @@ -0,0 +1,45 @@
> +nvme-ana-log(1)
> +===============
> +
> +NAME
> +----
> +nvme-ana-log - Send NVMe ANA log page request, returns result and log
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'nvme ana-log' <device>

This verse can have argument options like all the other docs.
'nvme ana-log' <device> [-o <fmt> | --output-format=<fmt>]

> +
> +DESCRIPTION
> +-----------
> +Retrieves the NVMe Asymmetric Namespace Access log page from an NVMe device
> +and provides the returned structure.
> +
> +The <device> parameter is mandatory NVMe character device (ex: /dev/nvme0).
> +
> +On success, the returned ANA log structure may be returned in one of
> +several ways depending on the option flags; the structure may parsed by
> +the program and printed in a readable format or the raw buffer may be
> +printed to stdout for another program to parse.
> +
> +OPTIONS
> +-------
> +-b::
> +--raw-binary::
> +	Print the raw ANA log buffer to stdout.
> +

It can be deprecated due to a reason mentioned in the first patch comment.

> +-o <format>::
> +--output-format=<format>::
> +??????????????Set the reporting format to 'normal', 'json', or
> +??????????????'binary'. Only one output format can be used at a time.
> +
> +EXAMPLES
> +--------
> +* Print the ANA log page in a human readable format:
> +------------
> +# nvme ana-log /dev/nvme0
> +------------
> +
> +NVME
> +----
> +Part of the nvme-user suite
> --?
> 2.17.0

Thanks,

	Minwoo Im
