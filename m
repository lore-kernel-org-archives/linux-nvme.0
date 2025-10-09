Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F25FCCD185
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Oct 2025 11:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yyurMpYVOLtJSv0XZc6vUdxEOJD8S0+A7pf0rjN/ufg=; b=aD9RLyAGb4eR7ycVIVYVLwiN14
	ijXQ01LRzGpkX6hkZfEuavSomBKzaJZMOZrYS/f92oEMq9LYoH8Or7pmbExEBXf/pguB1+TzABd4P
	r39LUG7jo2r+eT3K9uOq0elKmkamiCijUB1ddY8AIwG7aoehN5yrAsyJUX0wHCA2ujo3axuwQGGIo
	/dYC4G9vsN5NbZfh9QfW56+rGqZ6S7VqvIZx1cAyZORWwP1BtGmE2NXmcxtcOxnjcWLlGrbIY53Ib
	HVTghUEYUEQwVjssPNIGq13TstBnz9cmW8brl+Y9dUfGfBr4+HkNRNDIPZQUlYSVrY8g3kFlQXr7J
	V1jzo+Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6oV0-00000005uFz-06ID;
	Thu, 09 Oct 2025 11:07:54 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6oUx-00000005uFK-2G5X
	for linux-nvme@lists.infradead.org;
	Thu, 09 Oct 2025 11:07:52 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 41EB71F78B;
	Thu,  9 Oct 2025 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760008068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=yyurMpYVOLtJSv0XZc6vUdxEOJD8S0+A7pf0rjN/ufg=;
	b=sveurntvXSWCuuKFQiYrv3u1cplQgdKv35hk+TqX+IT6O+C5jXaTY8RKaSj3PXRrDNROu1
	bLF6+hMwxc3jTUDLHEjrHjgba0BFgG8WB93XCqJ8AShkQL5w1MEIi9isa2pT4VSFrvAI2Y
	ya+vFkB0QDn+Yy8QUR9dGMlmYJLfm88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760008068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=yyurMpYVOLtJSv0XZc6vUdxEOJD8S0+A7pf0rjN/ufg=;
	b=D/hCYnV0D6cWxYjGszIBgXe4h4Tl89Q/C2wgMsFniVg7UykKGSN0mlqY9x8AEbdE/HoSN4
	+k6PRMREyk1kK7Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760008068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=yyurMpYVOLtJSv0XZc6vUdxEOJD8S0+A7pf0rjN/ufg=;
	b=sveurntvXSWCuuKFQiYrv3u1cplQgdKv35hk+TqX+IT6O+C5jXaTY8RKaSj3PXRrDNROu1
	bLF6+hMwxc3jTUDLHEjrHjgba0BFgG8WB93XCqJ8AShkQL5w1MEIi9isa2pT4VSFrvAI2Y
	ya+vFkB0QDn+Yy8QUR9dGMlmYJLfm88=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760008068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=yyurMpYVOLtJSv0XZc6vUdxEOJD8S0+A7pf0rjN/ufg=;
	b=D/hCYnV0D6cWxYjGszIBgXe4h4Tl89Q/C2wgMsFniVg7UykKGSN0mlqY9x8AEbdE/HoSN4
	+k6PRMREyk1kK7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33E8713A61;
	Thu,  9 Oct 2025 11:07:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5N63C4SX52gBTAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 09 Oct 2025 11:07:48 +0000
Date: Thu, 9 Oct 2025 13:07:47 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: libnvme API design
Message-ID: <9812534f-6a15-4126-a4c0-7b4ae39e327b@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251009_040751_724821_202B099B 
X-CRM114-Status: UNSURE (   9.14  )
X-CRM114-Notice: Please train this message.
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

Hi Christoph,

As you have suggested the command API should be inverted, that is the
only stable API will be nvme_submit_admin_passthru and struct
nvme_passthru_cmd and a bunch of helpers to initialize the cmd.

I've done updated a bunch of the identify commands and below is the
result. I think we could reduce the number of helpers a bit,

  nvme_nvm_init_identify_ns vs nvme_nvm_init_identify_ns_csi.

Is this what you had in mind (obviously I haven't gone the whole way to
macros only, I like some type safty)?

Cheers,
Daniel


static inline
void nvme_nvm_init_identify(struct nvme_passthru_cmd *cmd,
			    enum nvme_identify_cns cns,
			    void *data, __u32 len)
{
	__u32 cdw10 = NVME_SET(cns, IDENTIFY_CDW10_CNS);
	__u32 cdw11 = NVME_SET(NVME_CSI_NVM, IDENTIFY_CDW11_CSI);

	memset(cmd, 0, sizeof(*cmd));
	
	cmd->opcode	= nvme_admin_identify;
	cmd->cdw10	= cdw10;
	cmd->cdw11	= cdw11;
	cmd->data_len	= len;
	cmd->addr	= (__u64)(uintptr_t)data;
}

static inline
void nvme_nvm_init_identify_ns(struct nvme_passthru_cmd *cmd,
			       __u32 nsid, struct nvme_id_ns *ns)
{
	nvme_nvm_init_identify(cmd,
			       NVME_IDENTIFY_CNS_NS,
			       ns, sizeof(*ns));
	cmd->nsid = nsid;
}

static inline
void nvme_nvm_init_identify_allocated_ns(struct nvme_passthru_cmd *cmd,
					 __u32 nsid, struct nvme_id_ns *ns)
{
	nvme_nvm_init_identify(cmd,
			       NVME_IDENTIFY_CNS_ALLOCATED_NS,
			       ns, sizeof(*ns));
	cmd->nsid = nsid;
}

static inline
void nvme_nvm_init_identify_active_ns_list(struct nvme_passthru_cmd *cmd,
					   __u32 nsid, struct nvme_ns_list *list)
{
	nvme_nvm_init_identify(cmd,
			       NVME_IDENTIFY_CNS_NS_ACTIVE_LIST,
			       list, sizeof(*list));
	cmd->nsid = nsid;
}

static inline
void nvme_identify_allocated_ns_list(struct nvme_passthru_cmd *cmd,
				     __u32 nsid, struct nvme_ns_list *list)
{
	nvme_nvm_init_identify(cmd,
			       NVME_IDENTIFY_CNS_ALLOCATED_NS_LIST,
			       list, sizeof(*list));
	cmd->nsid = nsid;
}

static inline
void nvme_identify_ctrl_list(struct nvme_passthru_cmd *cmd,
			     __u16 cntid,
			     struct nvme_ctrl_list *cntlist)
{
	nvme_nvm_init_identify(cmd,
			       NVME_IDENTIFY_CNS_CTRL_LIST,
			       cntlist, sizeof(*cntlist));
	cmd->cdw10 |= NVME_SET(cntid, IDENTIFY_CDW10_CNTID);
}

static inline
void nvme_nvm_init_identify_nsid_ctrl_list(struct nvme_passthru_cmd *cmd,
					   __u32 nsid, __u16 cntid,
					   struct nvme_ctrl_list *cntlist)
{
	nvme_nvm_init_identify(cmd,
			       NVME_IDENTIFY_CNS_NS_CTRL_LIST,
			       cntlist, sizeof(*cntlist));
	cmd->nsid = nsid;
	cmd->cdw10 |= NVME_SET(cntid, IDENTIFY_CDW10_CNTID);
}

static inline
void nvme_nvm_init_identify_ns_descs(struct nvme_passthru_cmd *cmd,
				     __u32 nsid,
				     struct nvme_ns_id_desc *descs)
{
	nvme_nvm_init_identify(cmd,
			       NVME_IDENTIFY_CNS_NS_DESC_LIST,
			       descs, sizeof(*descs));
	cmd->nsid = nsid;
}

static inline
void nvme_nvm_init_identify_nvmset_list(struct nvme_passthru_cmd *cmd,
					__u16 nvmsetid,
					struct nvme_id_nvmset_list *nvmset)
{
	nvme_nvm_init_identify(cmd,
			       NVME_IDENTIFY_CNS_NVMSET_LIST,
			       nvmset, sizeof(*nvmset));
	cmd->cdw11 |=  NVME_SET(nvmsetid, IDENTIFY_CDW11_CNSSPECID);
}

static inline
void nvme_nvm_init_identify_primary_ctrl(struct nvme_passthru_cmd *cmd,
					 __u16 cntid,
					 struct nvme_primary_ctrl_cap *cap)
{
	nvme_nvm_init_identify(cmd,
			     NVME_IDENTIFY_CNS_PRIMARY_CTRL_CAP,
			     cap, sizeof(*cap));
	cmd->cdw10 |= NVME_SET(cntid, IDENTIFY_CDW10_CNTID);
}

static inline
void nvme_nvm_init_identify_secondary_ctrl_list(struct nvme_passthru_cmd *cmd,
						__u16 cntid,
						struct nvme_secondary_ctrl_list *sc_list)
{
	nvme_nvm_init_identify(cmd,
			     NVME_IDENTIFY_CNS_SECONDARY_CTRL_LIST,
			     sc_list, sizeof(*sc_list));
	cmd->cdw10 |= NVME_SET(cntid, IDENTIFY_CDW10_CNTID);
}

static inline
void nvme_nvme_init_identify_uuid(struct nvme_passthru_cmd *cmd,
				  struct nvme_id_uuid_list *uuid_list)
{
	nvme_nvm_init_identify(cmd,
			       NVME_IDENTIFY_CNS_UUID_LIST,
			       uuid_list, sizeof(*uuid_list));
}

static inline
void nvme_nvm_init_identify_ns_csi(struct nvme_passthru_cmd *cmd,
				   __u32 nsid, enum nvme_csi csi,
				   __u8 uidx, void *data)
{
	nvme_nvm_init_identify(cmd,
			       csi,
			       data, NVME_IDENTIFY_DATA_SIZE);
	cmd->nsid = nsid;
	cmd->cdw14 |= NVME_SET(uidx, IDENTIFY_CDW14_UUID);
}

struct nvme_passthru_cmd cmd;
__u32 len = NVME_IDENTIFY_CNS_CTRL;

if (partial)
	len = offsetof(struct nvme_id_ctrl, rab);

nvme_nvm_init_identify(&cmd, NVME_IDENTIFY_CNS_CTRL, &id, len);

rc = nvme_submit_admin_passthru(hdl, &cmd, NULL);

