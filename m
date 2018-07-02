From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 2 Jul 2018 05:43:14 +0000
Subject: [PATCH V4 0/2] nvmet: implement flush all support
In-Reply-To: <20180628144206.GA17432@lst.de>
References: <20180626221717.19992-1-chaitanya.kulkarni@wdc.com>,
 <20180628144206.GA17432@lst.de>
Message-ID: <BYAPR04MB4502F79155D2D089E041CD1086430@BYAPR04MB4502.namprd04.prod.outlook.com>

Hi Christoph,

It allows NVMeOF host to just send one command and complete the flush per-ctrl
basis as opposed to per-ns basis.
In the current implementation, the host needs to execute nvme-list-ns or a variant of the
nvme-cli command per-ctrl and iterate through the ns-list, whereas we can make user's
life easier by providing the option present in the NVMe spec.

This is especially useful when you have many NVMeOF controllers configured on the
host with multiple namespaces.

Also given that NVMeOF ctrl can have different types of namespaces 
(bdev, file, and file-buffered-io and each type can have different behavior for flush)
this feature will not require host to keep track of each ns type in order to execute flush
depending on the ns type.

I didn't understand the "unnatural" comment, are you implying that this feature is not
that desirable for NVMeOF ctrls as compare to other types of ctrls?

If you still think this is not a target kernel code's responsibility and should be done in the
management tool like nvme-cli on the host side we can drop this patch.


From: Christoph Hellwig <hch@lst.de>
Sent: Thursday, June 28, 2018 7:42 AM
To: Chaitanya Kulkarni
Cc: linux-nvme at lists.infradead.org; hch at lst.de; keith.busch at intel.com; sagi at grimberg.me
Subject: Re: [PATCH V4 0/2] nvmet: implement flush all support
? 
 
On Tue, Jun 26, 2018@06:17:15PM -0400, Chaitanya Kulkarni wrote:
> Hi,
> 
> This implements the flush command behavior described in
> "NVMe 1.3a? TP 4035" for NSID value of FFFFFFFFh. Now flush command
> applies to all the namespaces attached to the controller processing the
> Flush command when the value 0xFFFFFFFF is set in the NSID field. 

Why?? No other I/O command supports 0xFFFFFFFF, and sending an all
namespaces flush is entirely unnatural.? Unless we have a very strong
use case I don't want to carry this code around.
    
