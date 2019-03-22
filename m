From: kbusch@kernel.org (Keith Busch)
Date: Fri, 22 Mar 2019 09:30:25 -0600
Subject: No subject
In-Reply-To: <0E8918CB-F679-4A5C-92AD-239E9CEC260C@nutanix.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <488768D7-1396-4DD1-A648-C86E5CF7DB2F@nutanix.com>
 <42f444d22363bc747f4ad75e9f0c27b40a810631.camel@redhat.com>
 <20190321161239.GH31434@stefanha-x1.localdomain>
 <20190321162140.GA29342@localhost.localdomain>
 <E217011E-C273-442D-AF99-84D3CD63FE77@nutanix.com>
 <8698ad583b1cfe86afc3d5440be630fc3e8e0680.camel@redhat.com>
 <0E8918CB-F679-4A5C-92AD-239E9CEC260C@nutanix.com>
Message-ID: <20190322153025.GA31194@localhost.localdomain>

On Fri, Mar 22, 2019@07:54:50AM +0000, Felipe Franciosi wrote:
> > 
> > Note though that SPDK doesn't support sharing the device between host and the
> > guests, it takes over the nvme device, thus it makes the kernel nvme driver
> > unbind from it.
> 
> That is absolutely true. However, I find it not to be a problem in practice.
> 
> Hypervisor products, specially those caring about performance, efficiency and fairness, will dedicate NVMe devices for a particular purpose (eg. vDisk storage, cache, metadata) and will not share these devices for other use cases. That's because these products want to deterministically control the performance aspects of the device, which you just cannot do if you are sharing the device with a subsystem you do not control.

I don't know, it sounds like you've traded kernel syscalls for IPC,
and I don't think one performs better than the other.

> For scenarios where the device must be shared and such fine grained control is not required, it looks like using the kernel driver with io_uring offers very good performance with flexibility.

NVMe's IO Determinism features provide fine grained control for shared
devices. It's still uncommon to find hardware supporting that, though.
