From: emilne@redhat.com (Ewan D. Milne)
Date: Mon, 13 Aug 2018 12:38:25 -0400
Subject: [PATCH v2] nvmet_fc: support target port removal with nvmet layer
In-Reply-To: <2461890d-1bf5-0a7e-0667-d16dbe365f4b@broadcom.com>
References: <20180809234814.14680-1-jsmart2021@gmail.com>
 <1533923638.7802.128.camel@localhost.localdomain>
 <2461890d-1bf5-0a7e-0667-d16dbe365f4b@broadcom.com>
Message-ID: <1534178305.14774.18.camel@localhost.localdomain>

On Fri, 2018-08-10@16:21 -0700, James Smart wrote:
> On 8/10/2018 10:53 AM, Ewan D. Milne wrote:
> > You need to add function declarations for nvmet_fc_portentry_unbind_tgt()
> > and nvmet_fc_portentry_rebind_tgt().  [-Werror=implicit-function-declaration]
> >
> > -Ewan
> 
> ??  They are all declared ahead of use
> 
> -- james
> 

They weren't for me, but that's because I applied the patch to my
working tree, rather than nvme-4.19, and the functions ended up
getting placed down further in the file somehow.

-Ewan
