From: linda.knippers@hpe.com (Linda Knippers)
Date: Fri, 30 Jun 2017 16:31:30 -0400
Subject: [PATCHv2] nvme: Remove SCSI translations
In-Reply-To: <20170630193840.GA12428@localhost.localdomain>
References: <1497987223-3119-1-git-send-email-keith.busch@intel.com>
 <AT5PR84MB00825BA1A84C313BE26C1099ABD30@AT5PR84MB0082.NAMPRD84.PROD.OUTLOOK.COM>
 <20170630193840.GA12428@localhost.localdomain>
Message-ID: <4a1e20a7-c162-d767-d1ce-612add511acc@hpe.com>

On 06/30/2017 03:38 PM, Keith Busch wrote:
> On Fri, Jun 30, 2017@12:44:11PM +0000, Elliott, Robert (Persistent Memory) wrote:
>>
>> As Linda and Micah mentioned, this violates a cardinal linux kernel rule -
>> it breaks user space.
>>
>> Please:
>> 1. Incorporate the TEST UNIT READY bug fix now.
>> 2. Add a WARN_ONCE printing a message that the interface that was just
>> used is deprecated and will go away, and modify the CONFIG description
>> to include that warning too.
>> 3. Wait a few kernel cycles before really removing it.
> 
> I really want to emphasize a few points here:
> 
> The linux nvme driver support for SG_IO was never really working in the
> first place. We can't break what's broken.

It was working well enough that people are using it.

> We're not making any nvme features unreachable by deleting broken
> interfaces. The driver has supported a real NVMe management interface
> since day 1, and open source tooling for it is freely available. These
> tools are also part of many distribution's package repositories.
> 
> The NVMe translation for TUR has been broken for years and you didn't
> notice. 

As I said, it was working well enough until recently.  We noticed
the problem when the recent code was pulled into an enterprise distro
where we do most of our production/customer testing.  David Milburn
posted a simple patch to fix at least the part that we're using.  I
can't speak for other people who may be using other parts.

> Your WARN proposal won't do you any good in that case, but
> it certainly puts a burden on the developers trying to progress and
> enhance NVMe.

I don't see how this prevents enhancing NVMe.  It seems like a
reasonable transition.

> The distributions supporting SCSI translations for NVMe are already
> applying out of tree patches to enable them.

All of them?  Are you sure?

-- ljk
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
