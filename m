From: james.smart@broadcom.com (James Smart)
Date: Fri, 10 Aug 2018 16:21:32 -0700
Subject: [PATCH v2] nvmet_fc: support target port removal with nvmet layer
In-Reply-To: <1533923638.7802.128.camel@localhost.localdomain>
References: <20180809234814.14680-1-jsmart2021@gmail.com>
 <1533923638.7802.128.camel@localhost.localdomain>
Message-ID: <2461890d-1bf5-0a7e-0667-d16dbe365f4b@broadcom.com>

On 8/10/2018 10:53 AM, Ewan D. Milne wrote:
> You need to add function declarations for nvmet_fc_portentry_unbind_tgt()
> and nvmet_fc_portentry_rebind_tgt().  [-Werror=implicit-function-declaration]
>
> -Ewan

??? They are all declared ahead of use

-- james
