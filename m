From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 6 Apr 2017 09:15:58 +0300
Subject: [PATCH] rdma: force queue size to respect controller capability
In-Reply-To: <13B28543-5903-4CD0-ACA1-B34EC4D8F883@cavium.com>
References: <444159155.19898733.1477380154029.JavaMail.zimbra@kalray.eu>
 <df71b855-c133-b3ad-ec81-e36a6f851531@intel.com>
 <89695878-8e93-94ea-653d-6381b92e9cbd@grimberg.me>
 <13B28543-5903-4CD0-ACA1-B34EC4D8F883@cavium.com>
Message-ID: <bb5a5bbf-a8e0-8cfa-127a-b911f0001dee@grimberg.me>

> Sagi,
>
> Was the +1 issue resolved differently?  I?m looking at the current code and I still see MQES + 1 being used.
>
> I?m running into an issue where my target reports a MQES of 3fh.
>
> The original ctrl->ctrl.sqsize comes from the create ctrl which sets a 0 based size.
>        ctrl->ctrl.sqsize = opts->queue_size - 1;
>
> When host does the
>         ctrl->ctrl.sqsize =
>                 min_t(int, NVME_CAP_MQES(ctrl->cap) + 1, ctrl->ctrl.sqsize);
>
>  the comparison is  min_t(40h, 7fh)
>
> So sqsize is now set as a 1 based value.  When the IO q is created, the target rejects it since it is larger than the max size.

Hey Darren,

You're right, we are wrongly taking MQES + 1. Not sure how this slipped.

I'll send a patch, thanks for reporting!
