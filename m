From: bvanassche@acm.org (Bart Van Assche)
Date: Fri, 21 Dec 2018 07:02:39 -0800
Subject: [PATCH 1/2] nvme-pci: add module param for io queue number
In-Reply-To: <1545372253-28025-1-git-send-email-shan.hai@oracle.com>
References: <1545372253-28025-1-git-send-email-shan.hai@oracle.com>
Message-ID: <677bfb90-c328-c707-a042-156f17cb426f@acm.org>

On 12/20/18 10:04 PM, Shan Hai wrote:
> The num_possible_cpus() number of io queues by default would cause
> irq vector shortage problem on a large system when hotplugging cpus,
> add a module parameter to set number of io queues according to the
> system configuration to fix the issue.

Is it possible to achieve this without introducing a new configuration 
knob? I think it will be much more convenient for users of large systems 
that they don't have to discover a knob like this one first in order to 
make the NVMe driver work on their systems.

Thanks,

Bart.
