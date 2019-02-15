From: keith.busch@intel.com (Keith Busch)
Date: Fri, 15 Feb 2019 14:47:14 -0700
Subject: [LSF/MM TOPIC] NVMe Performance: Userspace vs Kernel
In-Reply-To: <DAB8A2DA-37D3-4CBE-8AD7-356E3CE8B0D3@nutanix.com>
References: <DAB8A2DA-37D3-4CBE-8AD7-356E3CE8B0D3@nutanix.com>
Message-ID: <20190215214714.GA11307@localhost.localdomain>

On Fri, Feb 15, 2019@09:19:02PM +0000, Felipe Franciosi wrote:
> Over the last year or two, I have done extensive experimentation comparing applications using libaio to those using SDPK. 

Try the io_uring interface instead. Its queued up in the linux-block
for-next tree.

> For hypervisors, where storage devices can be exclusively accessed with userspace drivers (given the device can be dedicated to a single process), using SPDK has proven to be significantly faster and more efficient.

It doesn't work so well for file based or multi-device backing
storage. But if you are sequestering an entire controller over to a VM,
direct-assign/device-passthrough is usually also an option and that
ought to be even faster.
