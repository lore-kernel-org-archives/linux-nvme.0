From: james.smart@broadcom.com (James Smart)
Date: Thu, 29 Nov 2018 09:01:47 -0800
Subject: Whenever running nvme discover command, syslog shows warning
 messages
In-Reply-To: <CY4PR1301MB2008564EA917C4FE4D63298585D20@CY4PR1301MB2008.namprd13.prod.outlook.com>
References: <CY4PR1301MB2008564EA917C4FE4D63298585D20@CY4PR1301MB2008.namprd13.prod.outlook.com>
Message-ID: <bdd5f3c7-8173-dd63-3a47-df87a9c2d14c@broadcom.com>



On 11/28/2018 4:50 PM, Ching-Chiao Chang wrote:
> Hi,
>
> Whenever running nvme discover command, i.e., nvme discover --transport=rdma --traddr=10.10.0.4, syslog shows the following messages,
> Nov 27 15:24:30 initiator-xxx kernel: [55897.822948] nvme nvme1: sqsize 128 > ctrl maxcmd 1, clamping down
> Nov 27 15:24:30 initiator-xxx kernel: [55897.822956] nvme nvme1: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 10.10.0.4:4420
> Nov 27 15:24:30 initiator-xxx kernel: [55897.823213] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
> ...
> I was wondering if there is any way to avoid these warning messages?
>
> OS: Ubuntu 16.04.5
> Kernel: 4.18.5-041805-generic
> nvme version 1.6.120.g5c8a
>
> Thanks.
> Andy
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

no there's not - currently.

I find them worthwhile to see, as it hints at what the admin or 
scripting is doing, as well as giving hints on when nvme? names may be 
reallocated. I would not remove them for normal storage controllers. 
Perhaps a discovery controller could be filtered out, but I still find 
it useful.

-- james
