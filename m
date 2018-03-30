From: logang@deltatee.com (Logan Gunthorpe)
Date: Fri, 30 Mar 2018 11:46:35 -0600
Subject: [RFC PATCH 0/8] nvmet: implement target passthru commands support
In-Reply-To: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
References: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
Message-ID: <4b512e2c-95ac-98ee-9bf2-2deef3a6737f@deltatee.com>

Hi Chaitanya,

I'm very much in favor of the concept of this patchset but I think it
still needs some work. I'll post some notes on the following patches
shortly.

On 30/03/18 12:57 AM, Chaitanya Kulkarni wrote:
> This patchset implements NVMeOF target passthrough commands support.
> 
> In current implementation on the target side, NVMe command is mapped on the
> block layer request which allows the target to use generic block device.
> 
> With the help of passthrough interface, it can now identify the NVMe controller
> and allow the host to issue NVMe commands along with the VUCs on the
> target side. For example with this feature, depending on the target controller
> support host can issue namespace management commands,
> Vendor unique commands etc.

I'm already aware of what this patchset is trying to accomplish but I
find this description confusing and hard to understand. I think you need
to say something along the lines of:

"This patchset aims to enable passing through entire physical NVMe drive
through an NVMe over fabrics interface. This implies that all
namespaces on the target drive are passed through to the initiator
one-to-one and all admin commands from the initiator are forwarded back
to the target drive. This allows for exposing Vender Unique Commands
(VUCs) over the NVMe-OF interface."

Logan
