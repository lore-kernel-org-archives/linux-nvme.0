From: Darren.Trapp@cavium.com (Trapp, Darren)
Date: Wed, 5 Apr 2017 17:48:51 +0000
Subject: [PATCH] rdma: force queue size to respect controller capability
In-Reply-To: <89695878-8e93-94ea-653d-6381b92e9cbd@grimberg.me>
References: <444159155.19898733.1477380154029.JavaMail.zimbra@kalray.eu>
 <df71b855-c133-b3ad-ec81-e36a6f851531@intel.com>
 <89695878-8e93-94ea-653d-6381b92e9cbd@grimberg.me>
Message-ID: <13B28543-5903-4CD0-ACA1-B34EC4D8F883@cavium.com>

Sagi,

Was the +1 issue resolved differently?  I?m looking at the current code and I still see MQES + 1 being used.

I?m running into an issue where my target reports a MQES of 3fh.  

The original ctrl->ctrl.sqsize comes from the create ctrl which sets a 0 based size.
       ctrl->ctrl.sqsize = opts->queue_size - 1;

When host does the 
        ctrl->ctrl.sqsize =
                min_t(int, NVME_CAP_MQES(ctrl->cap) + 1, ctrl->ctrl.sqsize);

 the comparison is  min_t(40h, 7fh)

So sqsize is now set as a 1 based value.  When the IO q is created, the target rejects it since it is larger than the max size.



Darren Trapp
Senior Director - Engineering
darren.trapp at cavium.com <mailto:darren.trapp at caviumnetworks.com>
T 949-389-6273
M 949-212-8576
26650 Aliso Viejo Pkwy, Aliso Viejo, CA 92656
www.qlogic.com <http://www.qlogic.com/>
 <http://www.qlogic.com/>

On 10/26/16, 1:36 AM, "Linux-nvme on behalf of Sagi Grimberg" <linux-nvme-bounces@lists.infradead.org on behalf of sagi@grimberg.me> wrote:

    > I believe there's an off-by-one (or two) lurking here.
    >
    > It looks to me like ctrlr->ctrlr.sqsize is intended to be 0's-based:
    > - sqsize is passed as HSQSIZE in the Connect private data, which is
    > 0's-based
    > - sqsize is set to opts->queue_size - 1 earlier in nvme_rdma_create_ctrlr()
    >
    > However, this new change assigns opts->queue_size (non-0's-based value)
    > the current value of ctrlr->ctrlr.sqsize (0's-based value) without any
    > adjustment.
    >
    > This is probably because there is another bug in
    > nvme_rdma_configure_admin_queue(), where sqsize is set to a value based
    > on CAP.MQES + 1.  MQES is a 0's-based value, so if sqsize is also
    > supposed to be 0's based, no addition should be necessary.
    >
    > I think it is currently working only in the case where the original
    > sqsize is already smaller than MQES, because then the min of MQES and
    > sqsize will pick sqsize, which is already 0's based from the initial
    > queue_size - 1 assignment.
    >
    > If I'm not missing anything, the correct fix should be removing the + 1
    > adjustment of MQES as well as changing this patch to consider the 0's
    > based nature of sqsize:
    >
    >     if (opts->queue_size > ctrlr->ctrlr->sqsize + 1) {
    >         ...
    >          opts->queue_size = ctrlr->ctrlr.sqsize + 1;
    >     }
    
    Your correct Daniel. I'll fix that in the patch itself.
    
    Thanks!
    
    _______________________________________________
    Linux-nvme mailing list
    Linux-nvme at lists.infradead.org
    http://lists.infradead.org/mailman/listinfo/linux-nvme
    
