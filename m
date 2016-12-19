From: keith.busch@intel.com (Keith Busch)
Date: Mon, 19 Dec 2016 16:59:54 -0500
Subject: [PATCH v3 4/5] nvme: Implement resume_from_suspend and SED
 Allocation code.
In-Reply-To: <1482176149-2257-5-git-send-email-scott.bauer@intel.com>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
 <1482176149-2257-5-git-send-email-scott.bauer@intel.com>
Message-ID: <20161219215954.GB10634@localhost.localdomain>

On Mon, Dec 19, 2016@12:35:48PM -0700, Scott Bauer wrote:
> +static int nvme_sec_submit(struct nvme_ctrl *ctrl, u16 spsp, u8 secp,
> +			   void *buffer, size_t len, u8 opcode)
> +{
> +	struct nvme_command cmd = { 0 };
> +	struct nvme_ns *ns = NULL;
> +
> +	mutex_lock(&ctrl->namespaces_mutex);
> +	if (!list_empty(&ctrl->namespaces))
> +		ns = list_first_entry(&ctrl->namespaces, struct nvme_ns, list);
> +
> +	mutex_unlock(&ctrl->namespaces_mutex);
> +	if (!ns)
> +		return -ENODEV;
> +
> +	cmd.common.opcode = opcode;
> +	cmd.common.nsid = ns->ns_id;

Should be:

	cmd.common.nsid = cpu_to_le32(ns->ns_id);

But now wondering how you can send a security command to different
namespaces. That's why I thought it'd make more sense to threa this
through block_device, but maybe Christoph had some idea on how to get
the same functionality without that?
