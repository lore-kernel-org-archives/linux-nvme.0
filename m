From: keith.busch@intel.com (Keith Busch)
Date: Fri, 26 Oct 2018 14:07:33 -0600
Subject: [PATCH 3/3] nvme-cli: fix header paths for new structure
In-Reply-To: <20181026170834.23457-3-chaitanya.kulkarni@wdc.com>
References: <20181026170834.23457-1-chaitanya.kulkarni@wdc.com>
 <20181026170834.23457-3-chaitanya.kulkarni@wdc.com>
Message-ID: <20181026200733.GA10403@localhost.localdomain>

On Fri, Oct 26, 2018@10:08:34AM -0700, Chaitanya Kulkarni wrote:
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> ---
>  plugins/wdc/wdc-nvme.c | 16 ++++++++--------
>  plugins/wdc/wdc-nvme.h |  4 ++--
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/plugins/wdc/wdc-nvme.c b/plugins/wdc/wdc-nvme.c
> index 5ef965d..d9c879c 100644
> --- a/plugins/wdc/wdc-nvme.c
> +++ b/plugins/wdc/wdc-nvme.c
> @@ -31,14 +31,14 @@
>  
>  #include "linux/nvme_ioctl.h"
>  
> -#include "nvme.h"
> -#include "nvme-print.h"
> -#include "nvme-ioctl.h"
> -#include "plugin.h"
> -#include "json.h"
> -
> -#include "argconfig.h"
> -#include "suffix.h"
> +#include "../../nvme.h"
> +#include "../../nvme-print.h"
> +#include "../../nvme-ioctl.h"
> +#include "../../plugin.h"
> +#include "../../json.h"
> +
> +#include "../../argconfig.h"
> +#include "../../suffix.h"

The Makefile has the include path set such that this shouldn't be
necessary. Is the new directory structure causing a problem in any
environments?
