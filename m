From: felipe@nutanix.com (Felipe Franciosi)
Date: Mon, 25 Mar 2019 15:44:56 +0000
Subject: No subject
In-Reply-To: <20190322153025.GA31194@localhost.localdomain>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <488768D7-1396-4DD1-A648-C86E5CF7DB2F@nutanix.com>
 <42f444d22363bc747f4ad75e9f0c27b40a810631.camel@redhat.com>
 <20190321161239.GH31434@stefanha-x1.localdomain>
 <20190321162140.GA29342@localhost.localdomain>
 <E217011E-C273-442D-AF99-84D3CD63FE77@nutanix.com>
 <8698ad583b1cfe86afc3d5440be630fc3e8e0680.camel@redhat.com>
 <0E8918CB-F679-4A5C-92AD-239E9CEC260C@nutanix.com>
 <20190322153025.GA31194@localhost.localdomain>
Message-ID: <0C3E7CCF-DD56-4129-A6F6-4A181AA2D102@nutanix.com>

Hi Keith,

> On Mar 22, 2019,@3:30 PM, Keith Busch <kbusch@kernel.org> wrote:
> 
> On Fri, Mar 22, 2019@07:54:50AM +0000, Felipe Franciosi wrote:
>>> 
>>> Note though that SPDK doesn't support sharing the device between host and the
>>> guests, it takes over the nvme device, thus it makes the kernel nvme driver
>>> unbind from it.
>> 
>> That is absolutely true. However, I find it not to be a problem in practice.
>> 
>> Hypervisor products, specially those caring about performance, efficiency and fairness, will dedicate NVMe devices for a particular purpose (eg. vDisk storage, cache, metadata) and will not share these devices for other use cases. That's because these products want to deterministically control the performance aspects of the device, which you just cannot do if you are sharing the device with a subsystem you do not control.
> 
> I don't know, it sounds like you've traded kernel syscalls for IPC,
> and I don't think one performs better than the other.

Sorry, I'm not sure I understand. My point is that if you are packaging a distro to be a hypervisor and you want to use a storage device for VM data, you _most likely_ won't be using that device for anything else. To that end, driving the device directly from your application definitely gives you more deterministic control.

> 
>> For scenarios where the device must be shared and such fine grained control is not required, it looks like using the kernel driver with io_uring offers very good performance with flexibility.
> 
> NVMe's IO Determinism features provide fine grained control for shared
> devices. It's still uncommon to find hardware supporting that, though.

Sure, but then your hypervisor needs to certify devices that support that. This will limit your HCL. Moreover, unless the feature is solid, well-established and works reliably on all devices you support, it's arguably preferable to have an architecture which gives you that control in software.

Cheers,
Felipe
