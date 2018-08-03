From: keith.busch@linux.intel.com (Keith Busch)
Date: Fri, 3 Aug 2018 11:40:13 -0600
Subject: How /dev/nvme numbers are allocated/mapped to BDF
In-Reply-To: <85bec04c520848a9aa388e4334bb13ce@ausx13mps321.AMER.DELL.COM>
References: <073447516980487e950bbc428225ae02@ausx13mps321.AMER.DELL.COM>
 <20180803071820.GA22003@infradead.org>
 <20180803144025.GA4381@localhost.localdomain>
 <097442158bb64b9cbf07cc6e6c25ef1a@ausx13mps321.AMER.DELL.COM>
 <20180803165411.GA4551@localhost.localdomain>
 <85bec04c520848a9aa388e4334bb13ce@ausx13mps321.AMER.DELL.COM>
Message-ID: <20180803174013.GA4675@localhost.localdomain>

On Fri, Aug 03, 2018@05:20:39PM +0000, Alex_Gagniuc@Dellteam.com wrote:
> DEVPATH=/devices/virtual/nvme-subsystem/nvme-subsys2/nvme2n1

Must be CMIC controller with CONFIG_NVME_MULTIPATH=y, otherwise you
wouldn't have a a 'virtual' DEVPATH. We can't make by-path links
for these.
