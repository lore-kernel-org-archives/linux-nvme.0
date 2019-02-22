From: keith.busch@intel.com (Keith Busch)
Date: Fri, 22 Feb 2019 10:07:15 -0700
Subject: [PATCH] nvme: Enable acceleration feature of A64FX processor
In-Reply-To: <20190220094610.GB3559@esprimo>
References: <20190201124615.16107-1-indou.takao@jp.fujitsu.com>
 <20190201145414.GA22199@localhost.localdomain>
 <20190205124757.GA28465@esprimo>
 <20190205143905.GG22199@localhost.localdomain>
 <AT5PR8401MB1169E9738C0A4754D0190F2FAB670@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
 <20190220094610.GB3559@esprimo>
Message-ID: <20190222170715.GA10237@localhost.localdomain>

On Wed, Feb 20, 2019@06:46:11PM +0900, Takao Indoh wrote:
> On Thu, Feb 14, 2019@08:44:48PM +0000, Elliott, Robert (Persistent Memory) wrote:
> > * how does this interact with an iommu, if there is one? Must the 
> > address with bit 56 also be granted permission, or is that
> > stripped off before any iommu comparisons?
> 
> The latter. A bit 56 is cleared in Root Port before pass it to iommu.

What if the intendend destination is a peer and never hits the root port?

Really, though, PCI device vendors need to just use the existing
capability as intended and not have arch specific work-arounds. I'm sure
nvme can't be the only device class you'd want this behavior.
