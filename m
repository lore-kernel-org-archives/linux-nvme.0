From: keith.busch@intel.com (Keith Busch)
Date: Wed, 28 Jun 2017 13:00:34 -0400
Subject: Query on metadata formatted NVMe Drive
In-Reply-To: <CAEMH6P7=kFd2zh47G4keqMG0Qx0ytjnN3ZQS9VTBJ35xFvwjGw@mail.gmail.com>
References: <CAEMH6P7=kFd2zh47G4keqMG0Qx0ytjnN3ZQS9VTBJ35xFvwjGw@mail.gmail.com>
Message-ID: <20170628170034.GB2650@localhost.localdomain>

On Wed, Jun 28, 2017@09:26:06PM +0530, Adhrit P wrote:
> 
> As i understand, current NVMe driver can support working with
> different metadata (extended/separate) size formatted drive and the
> same can be verified using IOCTL path with user metadata.
> Is there any way to verify the same (all metadata sizes with
> extended/separate buffer)  through block layer/kernel IO path using
> fio or any other application ?

Metadata through the block layer is for kernel use, and only if
separate. Extended is not supported through this layer.

If you need to access these regions from user sapce, the NVME_SUBMIT_IO
ioctl is the only way to do that, which can work with both separate
and extended.
