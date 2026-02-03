Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A13E83041
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 03:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hj3xNrSuwF5PTi+VNv7uM5eZBnqgqRMaq5ykv6afO4g=; b=A99+zR/fPWIVjrS547Ln3/Zluq
	IM1YtfER8IP2eCksLfdwieITP2A6oeUVetA08rZijdlPeJHqQIKUllIymRa13oDHKo+BNr6aRwiZH
	6FuDRNteU6nNeeW+iSACVMY96zLbNVYbYhKt8vp7WvV4v1YRfiRrlSVgY3/Cb1V81ILVSgkU78yor
	W54cgxIq7j9sXvciP2gExfwAnsxeq/KckQr0t/JMgMCuH1jiC5iOiA2VITSZKujWkM5bDR2VOy6Lf
	N9kTXfhGSp3NJyRXSGQJsG6WlmWi8U6U6RCBpUTp9GyhEopFoSA/UY0hHHlfKdJQa/lFq/5SNDAdN
	pyOaLMcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn6hZ-00000005y5L-0Dmm;
	Tue, 03 Feb 2026 03:03:41 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn6hW-00000005y4r-1ehC
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 03:03:39 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 307E73E6CA;
	Tue,  3 Feb 2026 03:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770087816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hj3xNrSuwF5PTi+VNv7uM5eZBnqgqRMaq5ykv6afO4g=;
	b=rUJrifL/dtfjGR0p65tt9BD+9IbOCEOnFosUH00k4jO1QIAl5RZOzPVri4TzoWSGVZbe+f
	KunrW0J/0AgaNSab5nXe3RAzW3zD8vY7QWAu7oKbY3A4oQOqL29Ku9sUiyI6fv7BiV2SLE
	ZOHhliSiGtj3P8gKU2+R8E21slxvYzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770087816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hj3xNrSuwF5PTi+VNv7uM5eZBnqgqRMaq5ykv6afO4g=;
	b=P48IfYawKrG0Yl1xEU3O4bLG3h+/opTS+SulpV7KT5aY8P6v/G0V9mMaEUx9ePoJgwrGGr
	n9I5as2ArtYmOFCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="rUJrifL/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=P48IfYaw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770087816; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hj3xNrSuwF5PTi+VNv7uM5eZBnqgqRMaq5ykv6afO4g=;
	b=rUJrifL/dtfjGR0p65tt9BD+9IbOCEOnFosUH00k4jO1QIAl5RZOzPVri4TzoWSGVZbe+f
	KunrW0J/0AgaNSab5nXe3RAzW3zD8vY7QWAu7oKbY3A4oQOqL29Ku9sUiyI6fv7BiV2SLE
	ZOHhliSiGtj3P8gKU2+R8E21slxvYzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770087816;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hj3xNrSuwF5PTi+VNv7uM5eZBnqgqRMaq5ykv6afO4g=;
	b=P48IfYawKrG0Yl1xEU3O4bLG3h+/opTS+SulpV7KT5aY8P6v/G0V9mMaEUx9ePoJgwrGGr
	n9I5as2ArtYmOFCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4ADF73EA62;
	Tue,  3 Feb 2026 03:03:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lBfJOoFlgWkIbQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Feb 2026 03:03:29 +0000
Message-ID: <59a8d510-d06d-4d35-b911-c758c184df52@suse.de>
Date: Tue, 3 Feb 2026 04:03:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] nvmet: Rapid Path Failure Recovery set
 controller identify fields
To: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Justin Tee <justin.tee@broadcom.com>,
 Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
 Paul Ely <paul.ely@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
 Randy Jennings <randyj@purestorage.com>,
 Dhaval Giani <dgiani@purestorage.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
 <20260130223531.2478849-2-mkhalfella@purestorage.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260130223531.2478849-2-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[purestorage.com,broadcom.com,gmail.com,nvidia.com,lst.de,kernel.dk,kernel.org,grimberg.me];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 307E73E6CA
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_190338_588663_746EB13D 
X-CRM114-Status: GOOD (  34.69  )
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

On 1/30/26 23:34, Mohamed Khalfella wrote:
> TP8028 Rapid Path Failure Recovery defined new fields in controller
> identify response. The newly defined fields are:
> 
> - CIU (Controller Instance UNIQUIFIER): is an 8bit non-zero value that
> is assigned a random value when controller first created. The value is
> expected to be incremented when RDY bit in CSTS register is asserted
> - CIRN (Controller Instance Random Number): is 64bit random value that
> gets generated when controller is crated. CIRN is regenerated everytime
> RDY bit is CSTS register is asserted.
> - CCRL (Cross-Controller Reset Limit) is an 8bit value that defines the
> maximum number of in-progress controller reset operations. CCRL is
> hardcoded to 4 as recommended by TP8028.
> 
> TP4129 KATO Corrections and Clarifications defined CQT (Command Quiesce
> Time) which is used along with KATO (Keep Alive Timeout) to set an upper
> time limit for attempting Cross-Controller Recovery. For NVME subsystem
> CQT is set to 0 by default to keep the current behavior. The value can
> be set from configfs if needed.
> 
> Make the new fields available for IO controllers only since TP8028 is
> not very useful for discovery controllers.
> 
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>   drivers/nvme/target/admin-cmd.c |  6 ++++++
>   drivers/nvme/target/configfs.c  | 31 +++++++++++++++++++++++++++++++
>   drivers/nvme/target/core.c      | 12 ++++++++++++
>   drivers/nvme/target/nvmet.h     |  4 ++++
>   include/linux/nvme.h            | 15 ++++++++++++---
>   5 files changed, 65 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 3da31bb1183e..ade1145df72d 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -696,6 +696,12 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>   
>   	id->cntlid = cpu_to_le16(ctrl->cntlid);
>   	id->ver = cpu_to_le32(ctrl->subsys->ver);
> +	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
> +		id->cqt = cpu_to_le16(ctrl->cqt);
> +		id->ciu = ctrl->ciu;
> +		id->cirn = cpu_to_le64(ctrl->cirn);
> +		id->ccrl = NVMF_CCR_LIMIT;
> +	}
>   
>   	/* XXX: figure out what to do about RTD3R/RTD3 */
>   	id->oaes = cpu_to_le32(NVMET_AEN_CFG_OPTIONAL);
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index e44ef69dffc2..035f6e75a818 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -1636,6 +1636,36 @@ static ssize_t nvmet_subsys_attr_pi_enable_store(struct config_item *item,
>   CONFIGFS_ATTR(nvmet_subsys_, attr_pi_enable);
>   #endif
>   
> +static ssize_t nvmet_subsys_attr_cqt_show(struct config_item *item,
> +					  char *page)
> +{
> +	return snprintf(page, PAGE_SIZE, "%u\n", to_subsys(item)->cqt);
> +}
> +
> +static ssize_t nvmet_subsys_attr_cqt_store(struct config_item *item,
> +					   const char *page, size_t cnt)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item);
> +	struct nvmet_ctrl *ctrl;
> +	u16 cqt;
> +
> +	if (sscanf(page, "%hu\n", &cqt) != 1)
> +		return -EINVAL;
> +
> +	down_write(&nvmet_config_sem);
> +	if (subsys->cqt == cqt)
> +		goto out;
> +
> +	subsys->cqt = cqt;
> +	/* Force reconnect */
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
> +		ctrl->ops->delete_ctrl(ctrl);
> +out:
> +	up_write(&nvmet_config_sem);
> +	return cnt;
> +}
> +CONFIGFS_ATTR(nvmet_subsys_, attr_cqt);
> +
>   static ssize_t nvmet_subsys_attr_qid_max_show(struct config_item *item,
>   					      char *page)
>   {
> @@ -1676,6 +1706,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
>   	&nvmet_subsys_attr_attr_vendor_id,
>   	&nvmet_subsys_attr_attr_subsys_vendor_id,
>   	&nvmet_subsys_attr_attr_model,
> +	&nvmet_subsys_attr_attr_cqt,
>   	&nvmet_subsys_attr_attr_qid_max,
>   	&nvmet_subsys_attr_attr_ieee_oui,
>   	&nvmet_subsys_attr_attr_firmware,

I do think that TP8028 (ie the CQT defintions) are somewhat independent
on CCR. So I'm not sure if they should be integrated in this patchset;
personally I would prefer to have it moved to another patchset.

> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index cc88e5a28c8a..0d2a1206e08f 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1393,6 +1393,10 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
>   		return;
>   	}
>   
> +	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
> +		ctrl->ciu = ((u8)(ctrl->ciu + 1)) ? : 1;
> +		ctrl->cirn = get_random_u64();
> +	}
>   	ctrl->csts = NVME_CSTS_RDY;
>   
>   	/*
> @@ -1661,6 +1665,12 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
>   	}
>   	ctrl->cntlid = ret;
>   
> +	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
> +		ctrl->cqt = subsys->cqt;
> +		ctrl->ciu = get_random_u8() ? : 1;
> +		ctrl->cirn = get_random_u64();
> +	}
> +
>   	/*
>   	 * Discovery controllers may use some arbitrary high value
>   	 * in order to cleanup stale discovery sessions
> @@ -1853,10 +1863,12 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
>   
>   	switch (type) {
>   	case NVME_NQN_NVME:
> +		subsys->cqt = NVMF_CQT_MS;
>   		subsys->max_qid = NVMET_NR_QUEUES;
>   		break;

And I would not set the CQT default here.
Thing is, implementing CQT to the letter would inflict a CQT delay
during failover for _every_ installation, thereby resulting in a
regression to previous implementations where we would fail over
with _no_ delay.
So again, we should make it a different patchset.

>   	case NVME_NQN_DISC:
>   	case NVME_NQN_CURR:
> +		subsys->cqt = 0;
>   		subsys->max_qid = 0;
>   		break;
>   	default:
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index b664b584fdc8..f5d9a01ec60c 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -264,7 +264,10 @@ struct nvmet_ctrl {
>   
>   	uuid_t			hostid;
>   	u16			cntlid;
> +	u16			cqt;
> +	u8			ciu;
>   	u32			kato;
> +	u64			cirn;
>   
>   	struct nvmet_port	*port;
>   
> @@ -331,6 +334,7 @@ struct nvmet_subsys {
>   #ifdef CONFIG_NVME_TARGET_DEBUGFS
>   	struct dentry		*debugfs_dir;
>   #endif
> +	u16			cqt;
>   	u16			max_qid;
>   
>   	u64			ver;
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 655d194f8e72..5135cdc3c120 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -21,6 +21,9 @@
>   #define NVMF_TRADDR_SIZE	256
>   #define NVMF_TSAS_SIZE		256
>   
> +#define NVMF_CQT_MS		0
> +#define NVMF_CCR_LIMIT		4
> +
>   #define NVME_DISC_SUBSYS_NAME	"nqn.2014-08.org.nvmexpress.discovery"
>   
>   #define NVME_NSID_ALL		0xffffffff
> @@ -328,7 +331,10 @@ struct nvme_id_ctrl {
>   	__le16			crdt1;
>   	__le16			crdt2;
>   	__le16			crdt3;
> -	__u8			rsvd134[122];
> +	__u8			rsvd134[1];
> +	__u8			ciu;
> +	__le64			cirn;
> +	__u8			rsvd144[112];
>   	__le16			oacs;
>   	__u8			acl;
>   	__u8			aerl;
> @@ -362,7 +368,9 @@ struct nvme_id_ctrl {
>   	__u8			anacap;
>   	__le32			anagrpmax;
>   	__le32			nanagrpid;
> -	__u8			rsvd352[160];
> +	__u8			rsvd352[34];
> +	__le16			cqt;
> +	__u8			rsvd388[124];
>   	__u8			sqes;
>   	__u8			cqes;
>   	__le16			maxcmd;
> @@ -389,7 +397,8 @@ struct nvme_id_ctrl {
>   	__u8			msdbd;
>   	__u8			rsvd1804[2];
>   	__u8			dctype;
> -	__u8			rsvd1807[241];
> +	__u8			ccrl;
> +	__u8			rsvd1808[240];
>   	struct nvme_id_power_state	psd[32];
>   	__u8			vs[1024];
>   };

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

