From: rrandall@micron.com (Robert Randall (rrandall))
Date: Fri, 21 Oct 2016 17:14:22 +0000
Subject: NVMeoF Linux GIT repo
In-Reply-To: <1476990145.30641.18.camel@linux.intel.com>
References: <f5eefaea1d4b4d24945fdfb12da5a6ab@bowex36e.micron.com>
 <1476990145.30641.18.camel@linux.intel.com>
Message-ID: <cdacb4b29a894c82826f4d058074cee1@bowex36e.micron.com>

Thanks , yes, we have our NVMeoF host driver for Windows working nicely.  The IO path is very stable and very fast.  We are seeing issues with disconnects.  When we disconnect se see the problem in the attached log.  Any ideas on what is causing it would be much appreciated.

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of J Freyensee
Sent: Thursday, October 20, 2016 2:02 PM
To: Robert Randall (rrandall) <rrandall at micron.com>; Keith Busch <keith.busch at intel.com>; linux-nvme at lists.infradead.org
Subject: Re: NVMeoF Linux GIT repo

On Thu, 2016-10-20@15:36 +0000, Robert Randall (rrandall) wrote:
> Sorry Keith, I'm back to the same question again.? I've tried using 
> the released 4.8.2 kernel and I'm seeing errors in the Linux RDMA 
> layer.? Log file is attached.? My guess is this may have been fixed 
> already but since I'm not writing code on Linux it is difficult to 
> keep up with which repo and which branch I should be using.
> 
> It reports a syndrome 5 which appears to mean "work request flush 
> error".
> 
> Setup is stable 4.8.2 kernel with Mellanox RoCE v2.
> 
> So, where do I grab the latest and greatest code these days?

Robert,

Are you still doing that Microsoft Windows NVMe fabric host, Linux kernel target solution?

I'd try to see if you can get the mlx5_1 driver working on a Linux NVMe Host, Linux NVMe Target solution first.

Or alternatively use a RoCE v1 NIC+driver on the Windows NVMe fabric host and Linux target.

My concern would be since RoCE v2 is rather new'ish (first appeared in Linux kernel roughly 4.5), there is some interpretation/implementation difference between the two OS's.

But to answer your question, if you are interested in stable
latest+greatest, kernel.org has 4.8.3. ?If you want a bit more bleeding
edge, try the mainline kernel at 4.9-rc1 at kernel.org.

J
> 
> Thanks,
> Robert
> 
> 
> ROBERT RANDALL
> NVE Device Drivers
> Micron Technology, Inc.
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: linux.txt
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20161021/cdcaaf72/attachment-0001.txt>
