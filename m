From: hch@lst.de (Christoph Hellwig)
Date: Fri, 25 May 2018 15:28:40 +0200
Subject: [PATCHv2 08/11] nvme: add ANA support
In-Reply-To: <20180522091004.39620-9-hare@suse.de>
References: <20180522091004.39620-1-hare@suse.de>
 <20180522091004.39620-9-hare@suse.de>
Message-ID: <20180525132840.GB24601@lst.de>

On Tue, May 22, 2018@11:10:01AM +0200, Hannes Reinecke wrote:
> From: Christoph Hellwig <hch at lst.de>
> 
> Adding sypport for Asymmetric Namespace Access (ANA)
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Signed-off-by: Hannes Reinecke <hare at suse.com>

I just did a quick diff, and this really doesn't look like my
old code.  Quick difference I spotted:

 - lots of code in core.c instead of multipath.c, where it should
   be
 - adds a per-ns ana_state value, including all the crap to main
   it instead of the simple per-controller state table
 - fucks of the sysfs attributes to also who on the multipath
   node, where they can't work, and probably even corrupt
   memory
 - adds a get_log_page call per namespace, which is completely
   counter to the ANA design to not have craptons of roundtrip

And probably a few more things I didn't notice due to all the code
moves.

> ---
>  drivers/nvme/host/core.c      | 335 +++++++++++++++++++++++++++++++++++++++---
>  drivers/nvme/host/multipath.c |  41 +++++-
>  drivers/nvme/host/nvme.h      |  17 +++
>  3 files changed, 366 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b4408e1e677f..0d8167c68dff 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -68,6 +68,10 @@ static bool streams;
>  module_param(streams, bool, 0644);
>  MODULE_PARM_DESC(streams, "turn on support for Streams write directives");
>  
> +static unsigned long ana_log_delay = 500;
> +module_param(ana_log_delay, ulong, 0644);
> +MODULE_PARM_DESC(ana_log_delay, "Delay in msecs before retrieving ANA log");

Why?  There really is no point in delaying reading the state information
and just messing things up.
