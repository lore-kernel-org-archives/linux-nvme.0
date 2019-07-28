From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 28 Jul 2019 12:15:44 +0900
Subject: [PATCH 4/4] nvme: lightnvm: trace opcode name of I/O commands
 for 2.0
In-Reply-To: <97cbcbd3-5887-ec8e-dd43-ef08d612372c@lightnvm.io>
References: <20190727184155.18014-1-minwoo.im.dev@gmail.com>
 <20190727184155.18014-5-minwoo.im.dev@gmail.com>
 <97cbcbd3-5887-ec8e-dd43-ef08d612372c@lightnvm.io>
Message-ID: <20190728031544.GB24390@minwoo-desktop>

Hi Matias,

> It can not be assumed that it is an nvme opcode for any other device than an
> OCSSD 2.0 device (the command opcodes are allocated from the vendor-specific
> range of the NVMe specification). The trace code should be updated to take
> that into account before using the lookup value.

Okay!

> As a side note, I appreciate the work being put into supporting OCSSD, but
> for broad adoption, the OCSSD interface is superseded by the Zoned
> Namespaces (ZNS) technical proposal that is under standardization in the
> NVMe workgroup. We do expect a lot of adoption in this area, and have the
> kernel code ready when work is ratified (only at that point is the TBD
> values allocated). I hope that the energy that is now being put into OCSSD,
> can be put onto ZNS, as that is where we will see broad adoption and
> long-term support in the kernel.

Sure, Once it gets ratified, that would be great to put the energy on
it.  Thanks for the info, Matias.

Thanks!
