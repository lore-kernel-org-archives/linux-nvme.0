From: scott.bauer@intel.com (Scott Bauer)
Date: Mon, 19 Dec 2016 15:23:12 -0700
Subject: [PATCH v3 4/5] nvme: Implement resume_from_suspend and SED
 Allocation code.
In-Reply-To: <20161219215954.GB10634@localhost.localdomain>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
 <1482176149-2257-5-git-send-email-scott.bauer@intel.com>
 <20161219215954.GB10634@localhost.localdomain>
Message-ID: <20161219222311.GA2056@sbauer-Z170X-UD5>

On Mon, Dec 19, 2016@04:59:54PM -0500, Keith Busch wrote:
> On Mon, Dec 19, 2016@12:35:48PM -0700, Scott Bauer wrote:
> > +static int nvme_sec_submit(struct nvme_ctrl *ctrl, u16 spsp, u8 secp,
> > +			   void *buffer, size_t len, u8 opcode)
> > +{
> > +	struct nvme_command cmd = { 0 };
> > +	struct nvme_ns *ns = NULL;
> > +
> > +	mutex_lock(&ctrl->namespaces_mutex);
> > +	if (!list_empty(&ctrl->namespaces))
> > +		ns = list_first_entry(&ctrl->namespaces, struct nvme_ns, list);
> > +
> > +	mutex_unlock(&ctrl->namespaces_mutex);
> > +	if (!ns)
> > +		return -ENODEV;
> > +
> > +	cmd.common.opcode = opcode;
> > +	cmd.common.nsid = ns->ns_id;
> 
> Should be:
> 
> 	cmd.common.nsid = cpu_to_le32(ns->ns_id);
> 
> But now wondering how you can send a security command to different
> namespaces. That's why I thought it'd make more sense to threa this
> through block_device, but maybe Christoph had some idea on how to get
> the same functionality without that?


I went back and reviewed the spec 1.2.1:

http://www.nvmexpress.org/wp-content/uploads/NVM_Express_1_2_1_Gold_20160603.pdf
Section 5.18 (page 140->141)

Describes the security send command type and it doesn't have any reference of
a namespace ID. Anecdotally, I just removed the ns->ns_id line from the code and
everything still works as intended. Is there another portion of the spec or errata
that requires ns_id? (I can't access 1.2.1 errta the link doesn't work).
