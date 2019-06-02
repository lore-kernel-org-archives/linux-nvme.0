From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 2 Jun 2019 16:41:06 +0900
Subject: [PATCH] nvmet: fix data_len to 0 for bdev-backed write_zeroes
In-Reply-To: <69cfebd4-1e32-b86e-b02d-a92566f9d2db@grimberg.me>
References: <20190602034339.11246-1-minwoo.im.dev@gmail.com>
 <69cfebd4-1e32-b86e-b02d-a92566f9d2db@grimberg.me>
Message-ID: <20190602074103.GA15902@minwooim-desktop>

On 19-06-02 00:32:43, Sagi Grimberg wrote:
> Is this a regression? IIRC write-zeros used to work...

Hi Sagi,

The following outputs are a looping basic tests with a single command:
(I think you can find the commands will easily be failed.)

root at target:~# nvme list-subsys
nvme-subsys0 - NQN=nqn.2014.08.org.nvmexpress:80861af4foo
QEMU NVMe Ctrl
\
 +- nvme0 pcie 0000:00:04.0 live
 nvme-subsys1 - NQN=test
 \
  +- nvme1 loop  live
root at target:~# nvme write-zeroes /dev/nvme1n1
NVME Write Zeroes Success
root at target:~# nvme write-zeroes /dev/nvme1n1
NVME Write Zeroes Success
root at target:~# nvme write-zeroes /dev/nvme1n1
NVME Write Zeroes Success
root at target:~# nvme write-zeroes /dev/nvme1n1
NVMe status: Unknown(0x600f)
root at target:~# nvme write-zeroes /dev/nvme1n1
NVME Write Zeroes Success
root at target:~#

The write-zeroes command has been requested with SLBA 0 and NLB 0 as a
default options.  This might happen with status code 0x600f which is
NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR which happened due to:
	req->data_len != req->transfer_len

The transfer_len is always 0x0 for write-zeroes, but data-len is never
initialized in this case.

Please correct me if I'm wrong here.

Thanks,
