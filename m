From: keith.busch@intel.com (Keith Busch)
Date: Fri, 6 Feb 2015 20:02:42 +0000 (UTC)
Subject: discard cmd through ioctl
In-Reply-To: <CAB7xdi=CDHmc1p-jRnTKfh1fhpVE9wY1i8ZrB6ZxO4rU9iAfvA@mail.gmail.com>
References: <CAB7xdi=CDHmc1p-jRnTKfh1fhpVE9wY1i8ZrB6ZxO4rU9iAfvA@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1502061845360.15481@localhost.lm.intel.com>

On Fri, 6 Feb 2015, sheng qiu wrote:
> Hi,
>
> May i ask is there a way to issue data set management cmd from
> application to achieve discard function with current NVMe driver?
>
> i see there are regular IO or Admin interface for ioctl at driver
> side. Is this also applicable to dsm cmd?

Sure, you can use the NVME_IOCTL_IO_CMD to submit any arbitary IO command
you like.

It would probably be easier to use sg_unmap or blkdiscard to achieve the
same thing unless you require using the DSM command's other attributes
in addition to deallocate.

> Thanks,
> Sheng
