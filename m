Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4BFCCD183
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Oct 2025 13:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LBZ+Yr5U2lhJCVI5MKkBxT/HCJCSwbLJIcKfM0sPNpc=; b=EUVmFv0/5P5VjTBum7oy9KPzfD
	z32f3pgsSfQPgNdGEqmBoAlpzQJSgCl8zpPudpD0M6lfpwQ8Fhxi3B6q8RIC0vm9kjylHLbGQWnYk
	wLVGPTTRh2k0DhKSa19fqwj947qCpUN2HkxMXL15FVwaOma7WgSI7STUBxmiLQUyo6t1WSssB7xXy
	3QQsNoJWvGNwt47dIHGDzkVlRs4jxXI31gxaIPgcFb1GqlDl8yXlWQrtbk75divbnyLCWsdHbvCw2
	8ZXfROmHN8k3GbyDjqwf3RrHFAf/JNaA5S1AvItMVEptHvDkdDqt3jpb6nNZOi76FzYuu4Gwi/7QZ
	sKCUnwNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8IBu-0000000DBgs-0gyH;
	Mon, 13 Oct 2025 13:02:18 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8IBr-0000000DBgY-2ykW
	for linux-nvme@lists.infradead.org;
	Mon, 13 Oct 2025 13:02:16 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ADCDA21967;
	Mon, 13 Oct 2025 13:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760360532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LBZ+Yr5U2lhJCVI5MKkBxT/HCJCSwbLJIcKfM0sPNpc=;
	b=sDZtm6LGxxP3WhHf3F3F7jSjelV/ouNNAj5Q6bsBLeL3E9YLqRCQNCcq0HoTMfGD7/xyJV
	xQlAzRs8LfERaphzElkUnDPfE1tKFStE+WQ0hGdCze+BDKCHSac7eF7hLBwEHJMddEs6Ur
	A0WGVAkzU/eegvZixEFdjBHqPDZHwO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760360532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LBZ+Yr5U2lhJCVI5MKkBxT/HCJCSwbLJIcKfM0sPNpc=;
	b=IrUluUYBeYyIJn5+TW21dl/2ISa7P2E4gF2wO1DRqc9gi+6JGHjfDkb7t4QrnevoUO0nPb
	s0Z062nBGizB6vAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="uLkrn/7U";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="4AU8iiO/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760360531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LBZ+Yr5U2lhJCVI5MKkBxT/HCJCSwbLJIcKfM0sPNpc=;
	b=uLkrn/7UVtlUaAW8p2ZNbSWtaCo7AluET25lIH3GSK76Q5RflrG/0Nh0+Va+d2L6wS5tno
	SuYrgNM474/zuuHux9shbLJ2xU/GDFU59yAR/Se8qeHQ3+J+Ul080Stndk2uw9PX/2AvRU
	w6i5aQCuG/ciW/O3oIt84l9AuISmTWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760360531;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LBZ+Yr5U2lhJCVI5MKkBxT/HCJCSwbLJIcKfM0sPNpc=;
	b=4AU8iiO/2qyP0nJ0poCDfDi5IUwesKkSdvabmO1Ew8XpbfgKTRkNVavu15hmq1GMS8zdY+
	Sg2wEiMzAypbs9BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A04B21374A;
	Mon, 13 Oct 2025 13:02:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7MTuJVP47Gg/QgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 13 Oct 2025 13:02:11 +0000
Date: Mon, 13 Oct 2025 15:02:07 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: libnvme API design
Message-ID: <0fe148ad-e2c9-4aee-9d2f-5c6eaefddca3@flourine.local>
References: <9812534f-6a15-4126-a4c0-7b4ae39e327b@flourine.local>
 <20251010072658.GA17812@lst.de>
 <204cb4cc-33b4-40ce-8554-13436048f8d4@flourine.local>
 <20251013064700.GA2140@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013064700.GA2140@lst.de>
X-Rspamd-Queue-Id: ADCDA21967
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,flourine.local:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_060215_898740_DDD711AA 
X-CRM114-Status: UNSURE (   9.04  )
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

I am not a big fan of the repetition but at least now tab completion
works, so it's not too bad.

#define NVME_FIELD_ENCODE(value, shift, mask) \
	(((__u32)(value) & (mask) << (shift)))

#define NVME_FIELD_DECODE(value, shift, mask) \
	(((value) >> (shift)) & (mask))

static inline
void nvme_init_identify(struct nvme_passthru_cmd *cmd,
			__u32 nsid,
			enum nvme_identify_cns cns,
			void *data, __u32 len)
{
	__u32 cdw10 = NVME_FIELD_ENCODE(cns,
					NVME_IDENTIFY_CDW10_CNS_SHIFT,
					NVME_IDENTIFY_CDW10_CNS_MASK);
	__u32 cdw11 = NVME_FIELD_ENCODE(NVME_CSI_NVM,
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

static inline
void nvme_init_identify_allocated(struct nvme_passthru_cmd *cmd,
				  __u32 nsid, struct nvme_id_ns *ns)
{
	nvme_init_identify(cmd, nsid,
			   NVME_IDENTIFY_CNS_ALLOCATED_NS,
			   ns, sizeof(*ns));
}
[...]


In this version here I decided to replace the 'nvme_nvm' with just
'nvme_'. I don't want to duplicate for each CSI value the API.
The question if we want to introduce something like an update macro for
the case, where only CSI fields needs to be changed:

#define NVME_FIELD_ENCODE_UPDATE(cdw, value, shift, mask) \
	(cdw & ~((mask) << (shift))) | \
	NVME_FIELD_ENCODE(value, shift, mask);


static inline
void nvme_init_identify_nvmset_list(struct nvme_passthru_cmd *cmd,
				    __u32 nsid, __u16 nvmsetid,
				    struct nvme_id_nvmset_list *nvmset)
{
	nvme_init_identify(cmd, nsid,
			   NVME_IDENTIFY_CNS_NVMSET_LIST,
			   nvmset, sizeof(*nvmset));
	cmd->cdw11 |= NVME_FIELD_ENCODE(nvmsetid,
					NVME_IDENTIFY_CDW11_CNSSPECID_SHIFT,
					NVME_IDENTIFY_CDW11_CNSSPECID_MASK);
}

nvme_init_identify_nvmset_list(cmd, nsid, nvmsetid, nvmset);
cmd->cdw11 = NVME_FIELD_ENCODE_UPDATE(cmd->cdw11,
				      NVME_CSI_ZNS,
				      NVME_IDENTIFY_CDW11_CSI_SHIFT,
				      NVME_IDENTIFY_CDW11_CSI_MASK);

Thoughs?

