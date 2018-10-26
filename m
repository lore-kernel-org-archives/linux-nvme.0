From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Fri, 26 Oct 2018 20:11:37 +0000
Subject: [PATCH 3/3] nvme-cli: fix header paths for new structure
In-Reply-To: <20181026200733.GA10403@localhost.localdomain>
References: <20181026170834.23457-1-chaitanya.kulkarni@wdc.com>
 <20181026170834.23457-3-chaitanya.kulkarni@wdc.com>
 <20181026200733.GA10403@localhost.localdomain>
Message-ID: <9E08CF92-63C8-4D55-AAF7-D1571D4DEF67@wdc.com>

No but, static analysis tool reported include path warnings, maybe we can ignore these warnings ?

?On 10/26/18, 1:10 PM, "Keith Busch" <keith.busch@intel.com> wrote:

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
    
