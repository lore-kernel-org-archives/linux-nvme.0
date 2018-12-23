From: tom.leiming@gmail.com (Ming Lei)
Date: Sun, 23 Dec 2018 08:38:14 +0800
Subject: [PATCH 1/2] nvme-pci: add module param for io queue number
In-Reply-To: <1545372253-28025-1-git-send-email-shan.hai@oracle.com>
References: <1545372253-28025-1-git-send-email-shan.hai@oracle.com>
Message-ID: <CACVXFVMTxwM5EDZbrcVi=Dhy0Q=DN_yL77gTohY7AtKOpFb+uA@mail.gmail.com>

Hi Shanhai,

On Fri, Dec 21, 2018@2:05 PM Shan Hai <shan.hai@oracle.com> wrote:
>
> The num_possible_cpus() number of io queues by default would cause
> irq vector shortage problem on a large system when hotplugging cpus,
> add a module parameter to set number of io queues according to the
> system configuration to fix the issue.

Yeah, the default nr_io_queues is num_possible_cpus(), which can be a bit
big on some systems which supports small number of irq vectors.

But nvme_setup_irqs() may decrease nr_io_queues and try to allocate
again until it succeeds.

Could you share us what the actual issue is?

Thanks,
Ming Lei
