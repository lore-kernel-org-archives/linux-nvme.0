From: keith.busch@intel.com (Keith Busch)
Date: Fri, 30 Jun 2017 15:38:41 -0400
Subject: [PATCHv2] nvme: Remove SCSI translations
In-Reply-To: <AT5PR84MB00825BA1A84C313BE26C1099ABD30@AT5PR84MB0082.NAMPRD84.PROD.OUTLOOK.COM>
References: <1497987223-3119-1-git-send-email-keith.busch@intel.com>
 <AT5PR84MB00825BA1A84C313BE26C1099ABD30@AT5PR84MB0082.NAMPRD84.PROD.OUTLOOK.COM>
Message-ID: <20170630193840.GA12428@localhost.localdomain>

On Fri, Jun 30, 2017@12:44:11PM +0000, Elliott, Robert (Persistent Memory) wrote:
> 
> As Linda and Micah mentioned, this violates a cardinal linux kernel rule -
> it breaks user space.
>
> Please:
> 1. Incorporate the TEST UNIT READY bug fix now.
> 2. Add a WARN_ONCE printing a message that the interface that was just
> used is deprecated and will go away, and modify the CONFIG description
> to include that warning too.
> 3. Wait a few kernel cycles before really removing it.

I really want to emphasize a few points here:

The linux nvme driver support for SG_IO was never really working in the
first place. We can't break what's broken.

We're not making any nvme features unreachable by deleting broken
interfaces. The driver has supported a real NVMe management interface
since day 1, and open source tooling for it is freely available. These
tools are also part of many distribution's package repositories.

The NVMe translation for TUR has been broken for years and you didn't
notice. Your WARN proposal won't do you any good in that case, but
it certainly puts a burden on the developers trying to progress and
enhance NVMe.

The distributions supporting SCSI translations for NVMe are already
applying out of tree patches to enable them.
