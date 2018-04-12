From: james.smart@broadcom.com (James Smart)
Date: Wed, 11 Apr 2018 17:12:25 -0700
Subject: [PATCH v4] nvme: expand nvmf_check_if_ready checks
In-Reply-To: <2d2526bc-0514-ec1b-1294-9c9c0a68425e@grimberg.me>
References: <20180329215617.14592-1-jsmart2021@gmail.com>
 <2d2526bc-0514-ec1b-1294-9c9c0a68425e@grimberg.me>
Message-ID: <c73e338f-1c37-ffd0-7754-7c09007d3e1a@broadcom.com>

On 4/4/2018 6:42 AM, Sagi Grimberg wrote:
> Oops, here it looks better...
>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>

Thanks Sagi. However, I identified another issue, with ioctl cmds being 
issued while the queue was live but the controller not yet enabled.

Revised patch which plugs this hole on the way. I think this is the last...

-- james
