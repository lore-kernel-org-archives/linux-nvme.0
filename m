Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E3EFEFB6E
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 16:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3KYrSln3d6erQNd6U1tMUmNFgQsJoupJL2VLPKb1DZ8=; b=rUgMF4WDNYGT03ThYXGNk+uYRn
	o12BBTud/IPwnmu9i80N15SOzn5nq9laXDtmIXHW4ZrqgQedFfrTiYcQdJhjy/qdmqz34RFyMK5Ra
	oGh8Lie+p/0CHAwuWA6STojWONdGJTuRYXBtjv2wzANZ5HtGk8iRwh9YdUSxGIfYjx42fl/dG9rpd
	9c0QaP0onSIfBOeUgBsIS5BvfU6gFK4MfZ5DxMco9Nj4WkACKC3fBfBIIuodI14yhMiULUmt7wCVM
	VSYSGnh2KCEOHgUyTO0PgN/y8HYeFwX5I/DNFGMs98AX5sulZnaBGRV3wLs3rrwI6DLu/g8dZV6C6
	3qo3nLDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw0jg-00000008jc5-0wVa;
	Fri, 27 Feb 2026 16:30:40 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw0jc-00000008jba-2GC3
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 16:30:38 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 581caa50 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 27 Feb 2026 17:30:30 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Feb 2026 17:30:29 +0100
Message-Id: <DGPVYCG1UFY8.2RRII8Y14TXZM@arkamax.eu>
Subject: Re: [PATCH v3 03/21] nvmet: Implement CCR nvme command
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Mohamed Khalfella" <mkhalfella@purestorage.com>, "Justin Tee"
 <justin.tee@broadcom.com>, "Naresh Gottumukkala"
 <nareshgottumukkala83@gmail.com>, "Paul Ely" <paul.ely@broadcom.com>,
 "Chaitanya Kulkarni" <kch@nvidia.com>, "Christoph Hellwig" <hch@lst.de>,
 "Jens Axboe" <axboe@kernel.dk>, "Keith Busch" <kbusch@kernel.org>, "Sagi
 Grimberg" <sagi@grimberg.me>, "James Smart" <jsmart833426@gmail.com>,
 "Hannes Reinecke" <hare@suse.de>
Cc: "Aaron Dailey" <adailey@purestorage.com>, "Randy Jennings"
 <randyj@purestorage.com>, "Dhaval Giani" <dgiani@purestorage.com>,
 <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
 <20260214042753.4073668-4-mkhalfella@purestorage.com>
In-Reply-To: <20260214042753.4073668-4-mkhalfella@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_083036_938072_4DDA4E03 
X-CRM114-Status: GOOD (  20.96  )
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

On Sat Feb 14, 2026 at 5:25 AM CET, Mohamed Khalfella wrote:
> Defined by TP8028 Rapid Path Failure Recovery, CCR (Cross-Controller
> Reset) command is an nvme command issued to source controller by
> initiator to reset impacted controller. Implement CCR command for linux
> nvme target.
>
> +
> +	new_ccr =3D kmalloc(sizeof(*new_ccr), GFP_KERNEL);
> +	if (!new_ccr) {
> +		status =3D NVME_SC_INTERNAL;
> +		goto out_unlock;
> +	}

Nit: kmalloc_obj is now the preferred function for this kind of memory
allocations, see commit 69050f8d6d075dc01a and 189f164e573e18d

scripts/checkpatch.pl is supposed to print a warning
but there must be a problem with the regex and doesn't catch it

Maurizio

> +
> +	new_ccr->ciu =3D cmd->ccr.ciu;
> +	new_ccr->icid =3D cntlid;
> +	new_ccr->ctrl =3D ictrl;
> +	list_add_tail(&new_ccr->entry, &sctrl->ccr_list);
> +
> +out_unlock:
> +	mutex_unlock(&sctrl->lock);
> +	if (status =3D=3D NVME_SC_SUCCESS)
> +		nvmet_ctrl_fatal_error(ictrl);
> +	nvmet_ctrl_put(ictrl);
> +out:
> +	nvmet_req_complete(req, status);
> +}
> +
>  u32 nvmet_admin_cmd_data_len(struct nvmet_req *req)
>  {
>  	struct nvme_command *cmd =3D req->cmd;
> @@ -1691,6 +1762,9 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
>  	case nvme_admin_keep_alive:
>  		req->execute =3D nvmet_execute_keep_alive;
>  		return 0;
> +	case nvme_admin_cross_ctrl_reset:
> +		req->execute =3D nvmet_execute_cross_ctrl_reset;
> +		return 0;
>  	default:
>  		return nvmet_report_invalid_opcode(req);
>  	}
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index e5f413405604..38f71e1a1b8e 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -115,6 +115,20 @@ u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off,=
 size_t len)
>  	return 0;
>  }
> =20
> +void nvmet_ctrl_cleanup_ccrs(struct nvmet_ctrl *ctrl, bool all)
> +{
> +	struct nvmet_ccr *ccr, *tmp;
> +
> +	lockdep_assert_held(&ctrl->lock);
> +
> +	list_for_each_entry_safe(ccr, tmp, &ctrl->ccr_list, entry) {
> +		if (all || ccr->ctrl =3D=3D NULL) {
> +			list_del(&ccr->entry);
> +			kfree(ccr);
> +		}
> +	}
> +}
> +
>  static u32 nvmet_max_nsid(struct nvmet_subsys *subsys)
>  {
>  	struct nvmet_ns *cur;
> @@ -1397,6 +1411,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctr=
l)
>  	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
>  		ctrl->ciu =3D ((u8)(ctrl->ciu + 1)) ? : 1;
>  		ctrl->cirn =3D get_random_u64();
> +		nvmet_ctrl_cleanup_ccrs(ctrl, false);
>  	}
>  	ctrl->csts =3D NVME_CSTS_RDY;
> =20
> @@ -1502,6 +1517,35 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char =
*subsysnqn,
>  	return ctrl;
>  }
> =20
> +struct nvmet_ctrl *nvmet_ctrl_find_get_ccr(struct nvmet_subsys *subsys,
> +					   const char *hostnqn, u8 ciu,
> +					   u16 cntlid, u64 cirn)
> +{
> +	struct nvmet_ctrl *ctrl, *ictrl =3D NULL;
> +	bool found =3D false;
> +
> +	mutex_lock(&subsys->lock);
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		if (ctrl->cntlid !=3D cntlid)
> +			continue;
> +
> +		/* Avoid racing with a controller that is becoming ready */
> +		mutex_lock(&ctrl->lock);
> +		if (ctrl->ciu =3D=3D ciu && ctrl->cirn =3D=3D cirn)
> +			found =3D true;
> +		mutex_unlock(&ctrl->lock);
> +
> +		if (found) {
> +			if (kref_get_unless_zero(&ctrl->ref))
> +				ictrl =3D ctrl;
> +			break;
> +		}
> +	};
> +	mutex_unlock(&subsys->lock);
> +
> +	return ictrl;
> +}
> +
>  u16 nvmet_check_ctrl_status(struct nvmet_req *req)
>  {
>  	if (unlikely(!(req->sq->ctrl->cc & NVME_CC_ENABLE))) {
> @@ -1627,6 +1671,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_al=
loc_ctrl_args *args)
>  		subsys->clear_ids =3D 1;
>  #endif
> =20
> +	INIT_LIST_HEAD(&ctrl->ccr_list);
>  	INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
>  	INIT_LIST_HEAD(&ctrl->async_events);
>  	INIT_RADIX_TREE(&ctrl->p2p_ns_map, GFP_KERNEL);
> @@ -1740,12 +1785,43 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_=
alloc_ctrl_args *args)
>  }
>  EXPORT_SYMBOL_GPL(nvmet_alloc_ctrl);
> =20
> +static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
> +{
> +	struct nvmet_subsys *subsys =3D ctrl->subsys;
> +	struct nvmet_ctrl *sctrl;
> +	struct nvmet_ccr *ccr;
> +
> +	lockdep_assert_held(&subsys->lock);
> +
> +	/* Cleanup all CCRs issued by ctrl as source controller */
> +	mutex_lock(&ctrl->lock);
> +	nvmet_ctrl_cleanup_ccrs(ctrl, true);
> +	mutex_unlock(&ctrl->lock);
> +
> +	/*
> +	 * Find all CCRs targeting ctrl as impacted controller and
> +	 * set ccr->ctrl to NULL. This tells the source controller
> +	 * that CCR completed successfully.
> +	 */
> +	list_for_each_entry(sctrl, &subsys->ctrls, subsys_entry) {
> +		mutex_lock(&sctrl->lock);
> +		list_for_each_entry(ccr, &sctrl->ccr_list, entry) {
> +			if (ccr->ctrl =3D=3D ctrl) {
> +				ccr->ctrl =3D NULL;
> +				break;
> +			}
> +		}
> +		mutex_unlock(&sctrl->lock);
> +	}
> +}
> +
>  static void nvmet_ctrl_free(struct kref *ref)
>  {
>  	struct nvmet_ctrl *ctrl =3D container_of(ref, struct nvmet_ctrl, ref);
>  	struct nvmet_subsys *subsys =3D ctrl->subsys;
> =20
>  	mutex_lock(&subsys->lock);
> +	nvmet_ctrl_complete_pending_ccr(ctrl);
>  	nvmet_ctrl_destroy_pr(ctrl);
>  	nvmet_release_p2p_ns_map(ctrl);
>  	list_del(&ctrl->subsys_entry);
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index a36daa5d3a57..b06d905c08c8 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -268,6 +268,7 @@ struct nvmet_ctrl {
>  	u32			kato;
>  	u64			cirn;
> =20
> +	struct list_head	ccr_list;
>  	struct nvmet_port	*port;
> =20
>  	u32			aen_enabled;
> @@ -314,6 +315,13 @@ struct nvmet_ctrl {
>  	struct nvmet_pr_log_mgr pr_log_mgr;
>  };
> =20
> +struct nvmet_ccr {
> +	struct nvmet_ctrl	*ctrl;
> +	struct list_head	entry;
> +	u16			icid;
> +	u8			ciu;
> +};
> +
>  struct nvmet_subsys {
>  	enum nvme_subsys_type	type;
> =20
> @@ -576,6 +584,7 @@ void nvmet_req_free_sgls(struct nvmet_req *req);
>  void nvmet_execute_set_features(struct nvmet_req *req);
>  void nvmet_execute_get_features(struct nvmet_req *req);
>  void nvmet_execute_keep_alive(struct nvmet_req *req);
> +void nvmet_execute_cross_ctrl_reset(struct nvmet_req *req);
> =20
>  u16 nvmet_check_cqid(struct nvmet_ctrl *ctrl, u16 cqid, bool create);
>  u16 nvmet_check_io_cqid(struct nvmet_ctrl *ctrl, u16 cqid, bool create);
> @@ -618,6 +627,10 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_all=
oc_ctrl_args *args);
>  struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
>  				       const char *hostnqn, u16 cntlid,
>  				       struct nvmet_req *req);
> +struct nvmet_ctrl *nvmet_ctrl_find_get_ccr(struct nvmet_subsys *subsys,
> +					   const char *hostnqn, u8 ciu,
> +					   u16 cntlid, u64 cirn);
> +void nvmet_ctrl_cleanup_ccrs(struct nvmet_ctrl *ctrl, bool all);
>  void nvmet_ctrl_put(struct nvmet_ctrl *ctrl);
>  u16 nvmet_check_ctrl_status(struct nvmet_req *req);
>  ssize_t nvmet_ctrl_host_traddr(struct nvmet_ctrl *ctrl,
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 7746b6d30349..d9b421dc1ef3 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -22,6 +22,7 @@
>  #define NVMF_TSAS_SIZE		256
> =20
>  #define NVMF_CCR_LIMIT		4
> +#define NVMF_CCR_PER_PAGE	511
> =20
>  #define NVME_DISC_SUBSYS_NAME	"nqn.2014-08.org.nvmexpress.discovery"
> =20
> @@ -1222,6 +1223,22 @@ struct nvme_zone_mgmt_recv_cmd {
>  	__le32			cdw14[2];
>  };
> =20
> +struct nvme_cross_ctrl_reset_cmd {
> +	__u8			opcode;
> +	__u8			flags;
> +	__u16			command_id;
> +	__le32			nsid;
> +	__le64			rsvd2[2];
> +	union nvme_data_ptr	dptr;
> +	__u8			rsvd10;
> +	__u8			ciu;
> +	__le16			icid;
> +	__le32			cdw11;
> +	__le64			cirn;
> +	__le32			cdw14;
> +	__le32			cdw15;
> +};
> +
>  struct nvme_io_mgmt_recv_cmd {
>  	__u8			opcode;
>  	__u8			flags;
> @@ -1320,6 +1337,7 @@ enum nvme_admin_opcode {
>  	nvme_admin_virtual_mgmt		=3D 0x1c,
>  	nvme_admin_nvme_mi_send		=3D 0x1d,
>  	nvme_admin_nvme_mi_recv		=3D 0x1e,
> +	nvme_admin_cross_ctrl_reset	=3D 0x38,
>  	nvme_admin_dbbuf		=3D 0x7C,
>  	nvme_admin_format_nvm		=3D 0x80,
>  	nvme_admin_security_send	=3D 0x81,
> @@ -1353,6 +1371,7 @@ enum nvme_admin_opcode {
>  		nvme_admin_opcode_name(nvme_admin_virtual_mgmt),	\
>  		nvme_admin_opcode_name(nvme_admin_nvme_mi_send),	\
>  		nvme_admin_opcode_name(nvme_admin_nvme_mi_recv),	\
> +		nvme_admin_opcode_name(nvme_admin_cross_ctrl_reset),	\
>  		nvme_admin_opcode_name(nvme_admin_dbbuf),		\
>  		nvme_admin_opcode_name(nvme_admin_format_nvm),		\
>  		nvme_admin_opcode_name(nvme_admin_security_send),	\
> @@ -2006,6 +2025,7 @@ struct nvme_command {
>  		struct nvme_dbbuf dbbuf;
>  		struct nvme_directive_cmd directive;
>  		struct nvme_io_mgmt_recv_cmd imr;
> +		struct nvme_cross_ctrl_reset_cmd ccr;
>  	};
>  };
> =20
> @@ -2170,6 +2190,9 @@ enum {
>  	NVME_SC_PMR_SAN_PROHIBITED	=3D 0x123,
>  	NVME_SC_ANA_GROUP_ID_INVALID	=3D 0x124,
>  	NVME_SC_ANA_ATTACH_FAILED	=3D 0x125,
> +	NVME_SC_CCR_IN_PROGRESS		=3D 0x13f,
> +	NVME_SC_CCR_LOGPAGE_FULL	=3D 0x140,
> +	NVME_SC_CCR_LIMIT_EXCEEDED	=3D 0x141,
> =20
>  	/*
>  	 * I/O Command Set Specific - NVM commands:


