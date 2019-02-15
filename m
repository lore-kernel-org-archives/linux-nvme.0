From: felipe@nutanix.com (Felipe Franciosi)
Date: Fri, 15 Feb 2019 22:14:35 +0000
Subject: [LSF/MM TOPIC] NVMe Performance: Userspace vs Kernel
In-Reply-To: <20190215214714.GA11307@localhost.localdomain>
References: <DAB8A2DA-37D3-4CBE-8AD7-356E3CE8B0D3@nutanix.com>
 <20190215214714.GA11307@localhost.localdomain>
Message-ID: <694B95F6-290C-4065-B6D6-38B4858C71B8@nutanix.com>

Hi Keith,

> On Feb 15, 2019,@9:47 PM, Keith Busch <keith.busch@intel.com> wrote:
> 
> On Fri, Feb 15, 2019@09:19:02PM +0000, Felipe Franciosi wrote:
>> Over the last year or two, I have done extensive experimentation comparing applications using libaio to those using SDPK. 
> 
> Try the io_uring interface instead. Its queued up in the linux-block
> for-next tree.

I just read about that based on the other response from Bart. Thanks for pointing it out.

> 
>> For hypervisors, where storage devices can be exclusively accessed with userspace drivers (given the device can be dedicated to a single process), using SPDK has proven to be significantly faster and more efficient.
> 
> It doesn't work so well for file based or multi-device backing
> storage. But if you are sequestering an entire controller over to a VM,
> direct-assign/device-passthrough is usually also an option and that
> ought to be even faster.

The advantage is to dedicate a controller to "the hypervisor" (ie. one userspace process responsible for mediating access between multiple VMs). Some VMs may choose to use userspace drivers, too. Others can use traditional kernel datapaths. The average overhead we have measured from virtual machines in this setup is neglectable.

I did not experience problems with multiple devices, but surely careful thought is required for the data format.

Cheers,
Felipe
