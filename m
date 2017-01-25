From: keith.busch@intel.com (Keith Busch)
Date: Wed, 25 Jan 2017 18:39:57 -0500
Subject: Linux host behavior when CSTS.CFS bit is set to 1
In-Reply-To: <4a511c691bbe4e08ace7c92fd017dddb@bowex36b.micron.com>
References: <4a511c691bbe4e08ace7c92fd017dddb@bowex36b.micron.com>
Message-ID: <20170125233956.GC1729@localhost.localdomain>

On Wed, Jan 25, 2017@11:20:45PM +0000, Ken Chen (kchena) wrote:
> Hi All,
> 
> From a recent message exchange in this mail list, I saw the following statement:
> 
> "In the nvme Linux driver in function nvme_kthread() the CSTS register is read once a second to check for controller status failure." 

That's probably not a recent exchange on this list. We got rid of the
kthread almost a year ago. It was replaced with a per-controller timer.
 
> If this statement is true, is Linux supposed to initiate a reset to the drive if CSTS.CFS bit is set to 1?

Yes, that is correct.
 
> I am working on a SSD firmware. When certain hardware exceptions occur in the drive, the firmware sets CSTS.CFS bit to 1, expecting a reset by the host.  I am using Centos 7 with kernel 4.2.2-1.el7.elrepo.x86_64. In my tests, when firmware sets CFS bit, the host does not seem to reset the drive. That is, there is no transition of CC.EN bit from 1 to 0, there is no setting CC.SHN bit to 1, and there is no writing "NVMe" to NSSR register, etc. Is there anything else that firmware needs to do to trigger a reset from the host? Or is there any configuration (such as PCIe AER) that needs to be enabled in order for Linux to support this functionality?
> 
> Any advice will be appreciated.

There's no additional driver dependency required for this.

I've tested this part quite a bit, and it's always worked as designed
as far as I know. Are you sure the controller is really raising the
CSTS.CFS bit for the host to see? How are you verifying that it is
really set?

The only reason the driver may skip the reset if CFS is raised is if the
driver is already trying to reset the controller.
