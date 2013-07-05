From: David.Darrington@hgst.com (David.Darrington@hgst.com)
Date: Fri, 5 Jul 2013 12:16:12 -0500
Subject: ioctls vs sysfs
In-Reply-To: <20130704143915.GE30142@linux.intel.com>
Message-ID: <OF4B1F3927.AEE5B447-ON86257B9F.005D7C1F-86257B9F.005EDE60@hgst.com>

I have been testing changes that expose the I/O queues through sysfs. At 
this point, I have the entry 'reset' under 
/sys/bus/pci/devices/<addr>/nvme_queues/Qn/ for each I/O queue.
Echoing a 1 to the reset file causes the I/O queue to be re-created as 
described in section 7.3.3 in the NVMe 1.1 spec. This could be extended to 
add other attributes of the queues, if there are any suggestions.
I'm planning on submitting a patch, but i need to cachup with the latest 
changes, and I think that some of Keiths recent patches may affect what I 
wrote. Specifically, he added the ability to suspend a queue. I was 
planning on merging what i have done in with Keiths changes, perhaps 
exposing  'suspend', along with 'reset' in sysfs
 

"Linux-nvme" <linux-nvme-bounces at lists.infradead.org> wrote on 07/04/2013 
09:39:15 AM:

> On Thu, Jul 04, 2013@11:06:51AM +0300, David Sariel wrote:
> > Hi Matthew,
> > I have several questions:
> > 
> > 1) Do you have plans to add nore SG_* ioctls to supports more commands
> > from sg utils package?
> 
> I don't have any plans to do anything further with the nvme-scsi driver
> myself.  I don't keep track of what is and isn't supported.  That said,
> if someone wants to send patches to add support for something that's
> missing, I don't have a problem with applying it.  For example, Keith
> added support for UNMAP.
> 
> > 2) Do you have plans to add/move more stuff  to sysfs?
> 
> I'm open to exposing more stuff through sysfs.  Did you have any 
requests?
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://merlin.infradead.org/mailman/listinfo/linux-nvme
