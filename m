From: james.smart@broadcom.com (James Smart)
Date: Fri, 16 Feb 2018 09:42:08 -0800
Subject: [PATCH] nvme-pci: quiesce IO queues prior to disabling device HMB
 accesses
In-Reply-To: <22af82dd-0f20-f68b-2725-59b0da259e69@grimberg.me>
References: <1518440244-696-1-git-send-email-jianchao.w.wang@oracle.com>
 <22af82dd-0f20-f68b-2725-59b0da259e69@grimberg.me>
Message-ID: <60dcb8f0-7139-3c3e-1838-2347ce67dbcc@broadcom.com>

On 2/12/2018 10:40 AM, Sagi Grimberg wrote:
> Thanks, I picked this up for 4.17 (unless someone thinks
> this is 4.16-rc material?)
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

Note: I really hope that we can eventually commonize all the 
quiesce/unquiesce logic and points relative to controller state.? We 
have just enough differences to be interesting.

-- james
