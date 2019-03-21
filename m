From: kbusch@kernel.org (Keith Busch)
Date: Thu, 21 Mar 2019 10:21:40 -0600
Subject: No subject
In-Reply-To: <20190321161239.GH31434@stefanha-x1.localdomain>
References: <20190319144116.400-1-mlevitsk@redhat.com>
 <488768D7-1396-4DD1-A648-C86E5CF7DB2F@nutanix.com>
 <42f444d22363bc747f4ad75e9f0c27b40a810631.camel@redhat.com>
 <20190321161239.GH31434@stefanha-x1.localdomain>
Message-ID: <20190321162140.GA29342@localhost.localdomain>

On Thu, Mar 21, 2019@04:12:39PM +0000, Stefan Hajnoczi wrote:
> mdev-nvme seems like a duplication of SPDK.  The performance is not
> better and the features are more limited, so why focus on this approach?
> 
> One argument might be that the kernel NVMe subsystem wants to offer this
> functionality and loading the kernel module is more convenient than
> managing SPDK to some users.
> 
> Thoughts?

Doesn't SPDK bind a controller to a single process? mdev binds to
namespaces (or their partitions), so you could have many mdev's assigned
to many VMs accessing a single controller.
