Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9624AC4707B
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jan 2024 17:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LxY8BKhJn5bUePEorS+A2UQ9mFD6xJQ02cgPBUv28CI=; b=mNEypSZEOxGXZ/xCLbUazN7OaK
	dz0ktVcJkb1ZIxLJuziAbG4684l+CpGdrgpW/1a67YlrjL5qTv6FRwZYe+WNQvHReZfOZO3i32t0Q
	nC5PuB/Q8880I1OrYKl4ZRlizeNGWy6P7csyYiDzSeFg3bOI/6X43R+SMHMJ5tbOaMIq3j661/y7z
	4h8CaitwRXqlN7br0Zd6Mt5F2kbSvoGkyu4pb+hsthcJJidcj2xTFX+ESPM7DVmKgsBB6IlzV7cNX
	dVTy/wWGzRSiAsMlUgxQmdtSK0b8/96jROJFjrBCPb8NOKMXQ2oIQ5nr7Nr9qrJ/Z4tjNvsup1pgK
	434tPRiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rNFTd-008wHJ-0d;
	Tue, 09 Jan 2024 17:01:21 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rNFTZ-008wGX-1Q
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jan 2024 17:01:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 7A54EB81BB2;
	Tue,  9 Jan 2024 17:01:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B55C433C7;
	Tue,  9 Jan 2024 17:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704819674;
	bh=T74Ew0dYFmg5KwF9JDTvj19hMc95AT9UudQHaZP8bX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tEyAai7YyRsfwuJCL718BbPVt/qKFS5GVRVPxZ3RvFpRpKFSilhYyTILTjLNuUJJu
	 zXeejwDJ+tmowZITR1KcXtUCr6PWt6sjybl4WEWNxRg0D5p/dn6UnmhUjdl3NiqSfI
	 i8B+D1sTktKODLAHvdzPqHCvnu9c9yHjdjGCOBRMvdHZeb5Bxaiz3yQpZMOvF3Y/hQ
	 bzk4fq9RkVr6nCGeiZ2yY81Lf+S1bpslJxg+u1jdLaLXA5pnDLgjO7XXAr5/jcrWrr
	 dG3Eo9BQ97LPmXfOD2yOn/NmL8m8uzIlIiJKQYdTIbmjWZzgtmyRGQg77poYg8rCUQ
	 VjrmNamC3Hktg==
Date: Tue, 9 Jan 2024 10:01:11 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: support reservation feature
Message-ID: <ZZ1713_D7MojvHUu@kbusch-mbp>
References: <20240109121008.15925-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109121008.15925-1-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240109_090117_794584_7C4E2CED 
X-CRM114-Status: GOOD (  25.50  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jan 09, 2024 at 08:10:08PM +0800, Guixin Liu wrote:
> This patch implements the reservation feature, includes:
> 1. reservation register(register, unregister and replace).
> 2. reservation acquire(acquire, preempt, preempt and abort).
> 3. reservation release(release and clear).
> 4. reservation report.
> 
> And also make reservation configurable, one can set ns to support
> reservation before enable ns. The default of resv_enable is false.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> Hi guys,
>     I've implemented the NVMe reservation feature. Please review it, all 
> comments are welcome.

Why? If you have a real use case, let's add a blktest example added to
that project.

>     In addtion, I didn't implement event reporting because I didn't see
> any handling of these events on the host side. If these events are mandatory
> to report, please let me know so that I can implement them.

User space could be listening for them. The driver doesn't have any
particular action to take on a PR event just send a uevent.
 
>  	 */
>  	id->nmic = NVME_NS_NMIC_SHARED;
>  	id->anagrpid = cpu_to_le32(req->ns->anagrpid);
> -
> +	id->rescap = NVME_PR_SUPPORT_WRITE_EXCLUSIVE |
> +		     NVME_PR_SUPPORT_EXCLUSIVE_ACCESS |
> +		     NVME_PR_SUPPORT_WRITE_EXCLUSIVE_REG_ONLY |
> +		     NVME_PR_SUPPORT_EXCLUSIVE_ACCESS_REG_ONLY |
> +		     NVME_PR_SUPPORT_WRITE_EXCLUSIVE_ALL_REGS |
> +		     NVME_PR_SUPPORT_EXCLUSIVE_ACCESS_ALL_REGS |
> +		     NVME_PR_SUPPORT_IEKEY_DEF_LATER_VER_1_3;
>  	memcpy(&id->nguid, &req->ns->nguid, sizeof(id->nguid));
>  
>  	id->lbaf[0].ds = req->ns->blksize_shift;
> @@ -1017,6 +1023,12 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
>  	if (nvmet_is_passthru_req(req))
>  		return nvmet_parse_passthru_admin_cmd(req);
>  
> +	ret = nvmet_pr_check_cmd_access(req);
> +	if (unlikely(ret)) {
> +		req->error_loc = offsetof(struct nvme_common_command, opcode);
> +		return ret;
> +	}

You're checking this before validating the opcode. I don't think pr
access violation should have error precedence over an invalid opcode.

> +static bool nvmet_is_req_write_cmd_group(struct nvmet_req *req)
> +{
> +	struct nvme_command *cmd = req->cmd;
> +	u8 opcode = cmd->common.opcode;
> +
> +	if (req->sq->qid) {
> +		switch (opcode) {
> +		case nvme_cmd_flush:
> +		case nvme_cmd_write:
> +		case nvme_cmd_write_zeroes:
> +		case nvme_cmd_dsm:
> +		case nvme_cmd_write_uncor:
> +			return true;
> +		default:
> +			return false;
> +		}
> +	}
> +	switch (opcode) {
> +	case nvme_admin_cap_mgmt:
> +	case nvme_admin_format_nvm:
> +	case nvme_admin_ns_attach:
> +	case nvme_admin_ns_mgmt:
> +	case nvme_admin_sanitize_nvm:
> +	case nvme_admin_security_send:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +static bool nvmet_is_req_read_cmd_group(struct nvmet_req *req)
> +{
> +	struct nvme_command *cmd = req->cmd;
> +	u8 opcode = cmd->common.opcode;
> +
> +	if (req->sq->qid) {
> +		switch (opcode) {
> +		case nvme_cmd_read:
> +		case nvme_cmd_compare:
> +		case nvme_cmd_verify:
> +			return true;
> +		default:
> +			return false;
> +		}
> +	}
> +	switch (opcode) {
> +	case nvme_admin_security_recv:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

You're checking opcodes that we don't even support. I suggest we stash
the Command Effects Log in our target and trust what that reports to
deterimine if a command violates a reservation so that this function
doesn't need to be kept in sync as new opcodes are created.

Speaking of effects, you also need to update nvmet_get_cmd_effects_nvm()
so that it reports support for NVMe reservation opcodes.

> +u16 nvmet_pr_check_cmd_access(struct nvmet_req *req)
> +{
> +	struct nvmet_ctrl *ctrl = req->sq->ctrl;
> +	struct nvmet_ns *ns = req->ns;
> +	struct nvmet_pr *pr;
> +	u16 ret = 0;
> +
> +	if (!ns) {
> +		ns = xa_load(&nvmet_req_subsys(req)->namespaces,
> +			     le32_to_cpu(req->cmd->common.nsid));

This could be the broadcast NSID, 0xffffffff, in which case you have to
check all the namespaces for reservations.

> +	/*
> +	 * The Reservation command group is checked in executing,
> +	 * allow it here.
> +	 */
> +	switch ((u8)pr->rtype) {
> +	case NVME_PR_WRITE_EXCLUSIVE:
> +		if (nvmet_is_req_write_cmd_group(req) ||
> +		    nvmet_is_req_copy_cmd_group(req))
> +			ret = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
> +		break;
> +	case NVME_PR_EXCLUSIVE_ACCESS:
> +		if (nvmet_is_req_copy_cmd_group(req) ||
> +		    nvmet_is_req_read_cmd_group(req) ||
> +		    nvmet_is_req_write_cmd_group(req))
> +			ret = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
> +		break;
> +	case NVME_PR_WRITE_EXCLUSIVE_REG_ONLY:
> +	case NVME_PR_WRITE_EXCLUSIVE_ALL_REGS:
> +		if ((nvmet_is_req_copy_cmd_group(req) ||
> +		    nvmet_is_req_write_cmd_group(req)) &&
> +		    !nvmet_pr_find_registrant_by_hostid(pr, &ctrl->hostid))
> +			ret = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
> +		break;
> +	case NVME_PR_EXCLUSIVE_ACCESS_REG_ONLY:
> +	case NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS:
> +		if ((nvmet_is_req_copy_cmd_group(req) ||
> +		    nvmet_is_req_read_cmd_group(req) ||
> +		    nvmet_is_req_write_cmd_group(req)) &&
> +		    !nvmet_pr_find_registrant_by_hostid(pr, &ctrl->hostid))
> +			ret = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		break;
> +	}
> +
> +unlock:
> +	read_unlock(&pr->pr_lock);
> +out:
> +	if (!req->ns)
> +		nvmet_put_namespace(ns);
> +	return ret;
> +}

