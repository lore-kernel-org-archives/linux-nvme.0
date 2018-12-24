From: shan.hai@oracle.com (Shan Hai)
Date: Mon, 24 Dec 2018 09:02:15 +0800
Subject: [PATCH 1/2] nvme-pci: add module param for io queue number
In-Reply-To: <CACVXFVMTxwM5EDZbrcVi=Dhy0Q=DN_yL77gTohY7AtKOpFb+uA@mail.gmail.com>
References: <1545372253-28025-1-git-send-email-shan.hai@oracle.com>
 <CACVXFVMTxwM5EDZbrcVi=Dhy0Q=DN_yL77gTohY7AtKOpFb+uA@mail.gmail.com>
Message-ID: <aa86c9e2-ccb1-7156-6903-52c5e539d36c@oracle.com>

Hi Minglei,

On 2018/12/23 ??8:38, Ming Lei wrote:
> Hi Shanhai,
>
> On Fri, Dec 21, 2018@2:05 PM Shan Hai <shan.hai@oracle.com> wrote:
>> The num_possible_cpus() number of io queues by default would cause
>> irq vector shortage problem on a large system when hotplugging cpus,
>> add a module parameter to set number of io queues according to the
>> system configuration to fix the issue.
> Yeah, the default nr_io_queues is num_possible_cpus(), which can be a bit
> big on some systems which supports small number of irq vectors.
>
> But nvme_setup_irqs() may decrease nr_io_queues and try to allocate
> again until it succeeds.
>
> Could you share us what the actual issue is?


On an 8-way NUMA with total 384 CPUs system installed with multiple NVME 
storage devices the CPU

offline operation will fail when the online CPU numbers drop to a 
certain value, the failure is caused by

cpu interrupt vector exhaustion because the irqs of the NVME have to be 
migrated to the online CPUs.


Thanks

Shan Hai

>
> Thanks,
> Ming Lei
