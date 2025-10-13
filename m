Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD44CCD18D
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Oct 2025 14:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pfvcs57ZK7V+dNZolZoc6X89HW3eiy+RDjpSq/4LM4Y=; b=VniILFB0Rs95RPqkym0eIy2Dce
	wQMIJn3oI3B7p7fvWwwbodqYuvzG77nV7LnjhtssVylsNzMe52aZsQuXj4cSSmF7MAjNqFdf33iws
	uSQkbENncIC5Ar2+9iynAKPRfAMuHOXmfgsWToKUNEAujv/gsCgfBDdoaTJa0yM87G3KMaF+/ZVQ4
	4rNsNL6ezIAFo1gDBP7XCjTWZPTJ1CbJG09YB9Z4r4fkqDAQyKVtTeZjPTx2joXAsY7cb0kIL5vpz
	OWIvllP6Az+Q1O5UqEtU1u8l90vqWoDR7Jn4+Zl21anLbHwYg9/8AZrNT4wN7xtqeMSyM/OfbG0s4
	+YgVsCpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8JRi-0000000DNq5-2A3E;
	Mon, 13 Oct 2025 14:22:42 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8JRe-0000000DNp9-3DFl
	for linux-nvme@lists.infradead.org;
	Mon, 13 Oct 2025 14:22:41 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C659B1F397;
	Mon, 13 Oct 2025 14:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760365356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pfvcs57ZK7V+dNZolZoc6X89HW3eiy+RDjpSq/4LM4Y=;
	b=yY1MjSPv+Gmik3MfLkFgJiEvI5Rkv/DyD/TakGtU4QIl2wDVM3qmnmIRTCY2p1eP9L5aoq
	UdZ5QYvL6JZo0zzB6IarI4pHRCGSlytXOaQ7vzQS/Z2ui+2/MYft7RYnkQ1cgvaFZFcrJr
	9qhehJ3mpRHAGnSUcra/OiJKCef77MU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760365356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pfvcs57ZK7V+dNZolZoc6X89HW3eiy+RDjpSq/4LM4Y=;
	b=qQfwcauNEN7RHED2q1XG2noFH+RQ+i3cC/cu6Vmu1PV0Mpcb5+eQyNHZOvulPcQmkUOKzV
	Pv+psFatHFzFWLCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760365356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pfvcs57ZK7V+dNZolZoc6X89HW3eiy+RDjpSq/4LM4Y=;
	b=yY1MjSPv+Gmik3MfLkFgJiEvI5Rkv/DyD/TakGtU4QIl2wDVM3qmnmIRTCY2p1eP9L5aoq
	UdZ5QYvL6JZo0zzB6IarI4pHRCGSlytXOaQ7vzQS/Z2ui+2/MYft7RYnkQ1cgvaFZFcrJr
	9qhehJ3mpRHAGnSUcra/OiJKCef77MU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760365356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pfvcs57ZK7V+dNZolZoc6X89HW3eiy+RDjpSq/4LM4Y=;
	b=qQfwcauNEN7RHED2q1XG2noFH+RQ+i3cC/cu6Vmu1PV0Mpcb5+eQyNHZOvulPcQmkUOKzV
	Pv+psFatHFzFWLCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADAC613874;
	Mon, 13 Oct 2025 14:22:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qkhrKSwL7WhbEwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 13 Oct 2025 14:22:36 +0000
Date: Mon, 13 Oct 2025 16:22:32 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: libnvme API design
Message-ID: <46cc3fe6-e00a-4496-8fac-bb7f0d550fc4@flourine.local>
References: <9812534f-6a15-4126-a4c0-7b4ae39e327b@flourine.local>
 <20251010072658.GA17812@lst.de>
 <204cb4cc-33b4-40ce-8554-13436048f8d4@flourine.local>
 <20251013064700.GA2140@lst.de>
 <0fe148ad-e2c9-4aee-9d2f-5c6eaefddca3@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fe148ad-e2c9-4aee-9d2f-5c6eaefddca3@flourine.local>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
X-CRM114-CacheID: sfid-20251013_072238_979281_78878377 
X-CRM114-Status: GOOD (  14.13  )
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

On Mon, Oct 13, 2025 at 03:02:11PM +0200, Daniel Wagner wrote:
> In this version here I decided to replace the 'nvme_nvm' with just
> 'nvme_'. I don't want to duplicate for each CSI value the API.
> The question if we want to introduce something like an update macro for
> the case, where only CSI fields needs to be changed:
> 
> #define NVME_FIELD_ENCODE_UPDATE(cdw, value, shift, mask) \
> 	(cdw & ~((mask) << (shift))) | \
> 	NVME_FIELD_ENCODE(value, shift, mask);
> 
> 
> static inline
> void nvme_init_identify_nvmset_list(struct nvme_passthru_cmd *cmd,
> 				    __u32 nsid, __u16 nvmsetid,
> 				    struct nvme_id_nvmset_list *nvmset)
> {
> 	nvme_init_identify(cmd, nsid,
> 			   NVME_IDENTIFY_CNS_NVMSET_LIST,
> 			   nvmset, sizeof(*nvmset));
> 	cmd->cdw11 |= NVME_FIELD_ENCODE(nvmsetid,
> 					NVME_IDENTIFY_CDW11_CNSSPECID_SHIFT,
> 					NVME_IDENTIFY_CDW11_CNSSPECID_MASK);
> }
> 
> nvme_init_identify_nvmset_list(cmd, nsid, nvmsetid, nvmset);
> cmd->cdw11 = NVME_FIELD_ENCODE_UPDATE(cmd->cdw11,
> 				      NVME_CSI_ZNS,
> 				      NVME_IDENTIFY_CDW11_CSI_SHIFT,
> 				      NVME_IDENTIFY_CDW11_CSI_MASK);
> 

Or we just keep the nvme_nvm prefix. I've checked the existing callssites
in nvme-cli for the Identify command. There are none.

NVME_CSI_ZNS used in the zns plugin which use the nvme_zns_cmd_mgmt_send
opcode, which is ZNS specific.

No need to make it more complex than necessary. If none is objection
now, we start updating the patches.

