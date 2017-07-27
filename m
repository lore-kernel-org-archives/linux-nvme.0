From: keith.busch@intel.com (Keith Busch)
Date: Thu, 27 Jul 2017 14:09:38 -0400
Subject: [PATCH 2/2] nvme: Provide option to disable ASPT feature
In-Reply-To: <5DFAE162-66C5-4860-8330-8B5F34517E60@amacapital.net>
References: <1501174721-8253-1-git-send-email-keith.busch@intel.com>
 <1501174721-8253-2-git-send-email-keith.busch@intel.com>
 <5DFAE162-66C5-4860-8330-8B5F34517E60@amacapital.net>
Message-ID: <20170727180938.GK11979@localhost.localdomain>

On Thu, Jul 27, 2017@01:28:20PM -0400, Andy Lutomirski wrote:
> 
> 
> > On Jul 27, 2017,@12:58 PM, Keith Busch <keith.busch@intel.com> wrote:
> > 
> > Similar to PCIe's APSM, the NVMe driver needs the ability to not use APST
> > feature so that users have a way to prevent this feature from making their
> > machines unusable. This patch makes that possible via module parameter
> > "apst_off".
> 
> Isn't this redundant with default_ps_max_latency=0?

Ah, thanks, so it is. I thought this wasn't considered through
nvme_init_identify, but ctrl->ps_max_latency_us would be 0.

This patch isn't needed, but we still need patch 1 in this series.
