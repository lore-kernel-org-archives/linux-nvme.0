Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C888CCD192
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Oct 2025 15:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F8A3qJFyAoPJ74xRs6FjyyuYcjT3egO33pYLFdhe+9Q=; b=Sgau7DTKFReFn6gz5GBwLmN48A
	T2MbqDDYCb2lyg3US0n0peFLHMOS9nIwWsKVAg+O8Vn4Jh4M5wPXK3LvoY+aThzIFXDtLgjKGnVBC
	CYma4bBWr9A54qgpX1L9FiepTkOKmsnHvaRU/5KPdXPA+rtv0M1+EMZEVgOLriL9mtsd6B0lEruHP
	udq1m2OlKK2rV3TzcUhft3X2fvVEuS/dwhbPVYNw4+HGuJ+r9lWNPmSHHFmbctbXzJynh+iEVIdOo
	HQnC27JSjPAWIbIUdPcL2E5ySV1jeHO2Y1TeOCtqXEvYhvd/kvDLZztsgBQMo8wAfXkvOrgYbna3G
	p5bM2fKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8gyV-0000000GqVj-1jIO;
	Tue, 14 Oct 2025 15:30:07 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8gyQ-0000000GqTm-1jNE
	for linux-nvme@lists.infradead.org;
	Tue, 14 Oct 2025 15:30:06 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF17521B1D;
	Tue, 14 Oct 2025 15:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760455799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F8A3qJFyAoPJ74xRs6FjyyuYcjT3egO33pYLFdhe+9Q=;
	b=Gs5cXe0pik9dUwUd17TAljT1AdtE0CNM+aKsFY/reHCNcMHwjU1pYyaihw7x21A5cj/C28
	9QM7uviAxp5mhIUhYZr4rKQboXjNEUXFkAYsCs3YM/jMAQ/rmbnTUT1EEPX6Y/WwwPwi8p
	EG9pXwF7c5jdqisrMDTP5QVNq2/rhwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760455799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F8A3qJFyAoPJ74xRs6FjyyuYcjT3egO33pYLFdhe+9Q=;
	b=u9H+OhroVUC/xO5yU+gdNDPHm5HB2B956Z7GLLPtyeJytIEo/TmqKY+5SVJmLIjJ8uyWnR
	0wXdm5itz4l3AUBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=o2l+q95s;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ta43S23B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760455798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F8A3qJFyAoPJ74xRs6FjyyuYcjT3egO33pYLFdhe+9Q=;
	b=o2l+q95s1XXEq9ScosjmzCt8uIwo6VT3kLkh4oP9XDm9szGVfD6Jy6s/U7XL3eUx8GVeyv
	TW4iceqH4NfD3/qkkg2q6oMQ0Ta/Jys+0uRQw0r397rIeDTYukpAhl7fyB+FGbAbbR+df1
	OQAv5L3Gt1vnOPygClo4KkftyPtE4RU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760455798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F8A3qJFyAoPJ74xRs6FjyyuYcjT3egO33pYLFdhe+9Q=;
	b=ta43S23BNc6yXgrfTGZg8Uj+na5RMjkzVvO495CKAcehtNjFlNlNHqHG09DMaIurpPzIRs
	4ZkMKbZwbPlUCuDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E0145139B0;
	Tue, 14 Oct 2025 15:29:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2MvANXZs7mgbOQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 14 Oct 2025 15:29:58 +0000
Date: Tue, 14 Oct 2025 17:29:54 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: libnvme API design
Message-ID: <fd004033-5fd9-4533-97f5-c9e7462ef282@flourine.local>
References: <9812534f-6a15-4126-a4c0-7b4ae39e327b@flourine.local>
 <20251010072658.GA17812@lst.de>
 <204cb4cc-33b4-40ce-8554-13436048f8d4@flourine.local>
 <20251013064700.GA2140@lst.de>
 <0fe148ad-e2c9-4aee-9d2f-5c6eaefddca3@flourine.local>
 <46cc3fe6-e00a-4496-8fac-bb7f0d550fc4@flourine.local>
 <20251014042011.GB30344@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014042011.GB30344@lst.de>
X-Rspamd-Queue-Id: EF17521B1D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251014_083002_623281_B4A4FD4A 
X-CRM114-Status: GOOD (  21.33  )
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

On Tue, Oct 14, 2025 at 06:20:11AM +0200, Christoph Hellwig wrote:
> On Mon, Oct 13, 2025 at 04:22:32PM +0200, Daniel Wagner wrote:
> > Or we just keep the nvme_nvm prefix. I've checked the existing callssites
> > in nvme-cli for the Identify command. There are none.
> 
> For the NVM command set specific ID NS/CTRL I'd keep it.  Most of the
> Identify CNS values are not command set specifivc, so it won't affect
> much code anyway.

So after studying the spec a bit closer I updated the Identify command
API slightly so it follows the spec. That resolved the inconsistent
naming scheme and which arguments which function should get. Agreed, the
current function names are now a bit expressive but it makes it way
simpler to follow the code and the spec (also avoid inconsistent naming)

The change is unit tested, so I think most obvious bugs are gone. On the
callsite the change is straight forward:

@@ -439,6 +439,7 @@ static int test_admin_id_cb(struct nvme_mi_ep *ep,
 static void test_admin_id(nvme_mi_ep_t ep)
 {
        struct nvme_transport_handle *hdl;
+       struct nvme_passthru_cmd cmd;
        struct nvme_id_ctrl id;
        int rc;

@@ -447,7 +448,8 @@ static void test_admin_id(nvme_mi_ep_t ep)
        hdl = nvme_mi_init_transport_handle(ep, 5);
        assert(hdl);

-       rc = nvme_identify_ctrl(hdl, &id);
+       nvme_init_identify_ctrl(&cmd, &id);
+       rc = nvme_submit_admin_passthru(hdl, &cmd, NULL);
        assert(rc == 0);
 }

I am posting only a part of the code here, the full change is
here:

https://github.com/nvme-experiments/libnvme/issues/49
https://github.com/nvme-experiments/libnvme/commit/b96cdf71fa73761152816c54e56cc2cc3db237a0

/**
 * nvme_init_identify() - Initialize passthru command for
 * NVMe Identify
 * @cmd:	Command data structure to initialize
 * @nsid:	Namespace identifier
 * @csi:	Command Set Identifier
 * @cns:	The Controller or Namespace structure,
 *              see @enum nvme_identify_cns
 * @data:	User space destination address to transfer the data
 * @len:	Length of provided user buffer to hold the data in bytes
 *
 * Prepare the @cmd data structure for the NVMe Identify command.
 */
static inline void nvme_init_identify(
		struct nvme_passthru_cmd *cmd, __u32 nsid, enum nvme_csi csi,
		enum nvme_identify_cns cns, void *data, __u32 len)
{
	__u32 cdw10 = NVME_FIELD_ENCODE(cns,
					NVME_IDENTIFY_CDW10_CNS_SHIFT,
					NVME_IDENTIFY_CDW10_CNS_MASK);
	__u32 cdw11 = NVME_FIELD_ENCODE(csi,
					NVME_IDENTIFY_CDW11_CSI_SHIFT,
					NVME_IDENTIFY_CDW11_CSI_MASK);

	memset(cmd, 0, sizeof(*cmd));

	cmd->opcode	= nvme_admin_identify;
	cmd->nsid	= nsid;
	cmd->cdw10	= cdw10;
	cmd->cdw11	= cdw11;
	cmd->data_len	= len;
	cmd->addr	= (__u64)(uintptr_t)data;
}

/**
 * nvme_init_identify_ns() - Initialize passthru command for
 * NVMe Identify Namespace data structure
 * @cmd:	Command data structure to initialize
 * @nsid:	Namespace identifier
 * @id:		User space destination address to transfer the data
 *
 * Initializes the passthru command buffer for the Identify command with
 * CNS value %NVME_IDENTIFY_CNS_NS.
 */
static inline void nvme_init_identify_ns(
		struct nvme_passthru_cmd *cmd, __u32 nsid,
		struct nvme_id_ns *id)
{
	nvme_init_identify(cmd, nsid, NVME_CSI_NVM,
			   NVME_IDENTIFY_CNS_NS,
			   id, sizeof(*id));
}

/**
 * nvme_init_identify_ctrl() - Initialize passthru command for
 * NVMe Identify Controller data structure
 * @cmd:	Command data structure to initialize
 * @id:		User space destination address to transfer the data,
 *
 * Initializes the passthru command buffer for the Identify command with
 * CNS value %NVME_IDENTIFY_CNS_CTRL.
 */
static inline void nvme_init_identify_ctrl(
		struct nvme_passthru_cmd *cmd, struct nvme_id_ctrl *id)
{
	nvme_init_identify(cmd, NVME_NSID_NONE, NVME_CSI_NVM,
			   NVME_IDENTIFY_CNS_CTRL,
			   id, sizeof(*id));
}

/**
 * nvme_init_identify_active_ns_list() - Initialize passthru command for
 * Active Namespaces ID list
 * @cmd:	Command data structure to initialize
 * @nsid:	Namespace identifier
 * @list:	User space destination address to transfer the data
 *
 * Initializes the passthru command buffer for the Identify command with
 * CNS value %NVME_IDENTIFY_CNS_NS_ACTIVE_LIST.
 */
static inline void nvme_init_identify_active_ns_list(
		struct nvme_passthru_cmd *cmd, __u32 nsid,
		struct nvme_ns_list *list)
{
	nvme_init_identify(cmd, nsid, NVME_CSI_NVM,
			   NVME_IDENTIFY_CNS_NS_ACTIVE_LIST,
			   list, sizeof(*list));
}

/**
 * nvme_init_identify_ns_descs_list() - Initialize passthru command for
 * Namespace Descriptor list
 * @cmd:	Command data structure to initialize
 * @nsid:	The namespace id to retrieve descriptors
 * @descs:	User space destination address to transfer the data
 *
 * Initializes the passthru command buffer for the Identify command with
 * CNS value %NVME_IDENTIFY_CNS_NS_DESC_LIST.
 */
static inline void nvme_init_identify_ns_descs_list(
		struct nvme_passthru_cmd *cmd, __u32 nsid,
		struct nvme_ns_id_desc *descs)
{
	nvme_init_identify(cmd, nsid, NVME_CSI_NVM,
			   NVME_IDENTIFY_CNS_NS_DESC_LIST,
			   descs, NVME_IDENTIFY_DATA_SIZE);
}

/**
 * nvme_init_identify_nvmset_list() - Initialize passthru command for
 * NVM Set List data structure
 * @cmd:	Command data structure to initialize
 * @nsid:	Namespace identifier
 * @nvmsetid:	NVM Set Identifier
 * @nvmset:	User space destination address to transfer the data
 *
 * Initializes the passthru command buffer for the Identify command with
 * CNS value %NVME_IDENTIFY_CNS_NS_ACTIVE_LIST.
 */
static inline void nvme_init_identify_nvmset_list(
		struct nvme_passthru_cmd *cmd, __u32 nsid,
		__u16 nvmsetid, struct nvme_id_nvmset_list *nvmset)
{
	nvme_init_identify(cmd, nsid, NVME_CSI_NVM,
			   NVME_IDENTIFY_CNS_NVMSET_LIST,
			   nvmset, sizeof(*nvmset));
	cmd->cdw11 |= NVME_FIELD_ENCODE(nvmsetid,
					NVME_IDENTIFY_CDW11_CNSSPECID_SHIFT,
					NVME_IDENTIFY_CDW11_CNSSPECID_MASK);
}

[...]

If this is generally okay, we start with updating the other patches
accordingly.

