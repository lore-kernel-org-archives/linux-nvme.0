Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD6EC87FCB
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Aug 2025 11:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2S6Yfw8MWYSCw6PdDhatVOkzHx1Z3BuEhZk13Etx5uQ=; b=ksQ+9KA1kpA+V6WysYx5VS5GlJ
	BgRiyX0MGxIBCV2Uw+rt4a6kWNw8+wY6j9aY72MEyEbP9FN7QSVMv+RhNH+6LxYfGvKjCGAwp86/f
	sRC4C0KtcvMGDQWvigKaj3kJcr7/K18hmE3g07rsPhM8RwRjU2OQPw3WR8cihJUMTc+VVupryPGtM
	HwgDDhjPRDpbwrmwKghjqK9cMK9sAiB/520qj61g/BaSh7MyIrSNS/o7cXNFElee/02lKNcvej6HF
	bOchXDXU8FFQ4aVDd5iwbe59zrKm5/Z32J2BX5jUvJ/dPwz6XFwGVRfSAVOP98Gi+2+kR2G9q1lS7
	59u8w8Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujFSQ-0000000CYgi-342X;
	Tue, 05 Aug 2025 11:03:50 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujFEc-0000000CX4K-0ABf
	for linux-nvme@lists.infradead.org;
	Tue, 05 Aug 2025 10:49:35 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D4CFC2174B;
	Tue,  5 Aug 2025 10:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754390971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2S6Yfw8MWYSCw6PdDhatVOkzHx1Z3BuEhZk13Etx5uQ=;
	b=qfnsShoHAMQ6tcOEIv07quDbnGgWwuIHHmcocwXHvl8NaGZEIMX9bjkty90G9MkImBso3N
	yZZwEMmEseQmzc1oAC6nPNH7DqkJt62YJSGXTou4/y4QRreRxsGqGr0Nnm6N0jdnEZvzM7
	7ykoHKJIxb3SrDiENEglCbBcn7FggeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754390971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2S6Yfw8MWYSCw6PdDhatVOkzHx1Z3BuEhZk13Etx5uQ=;
	b=NQlUfPSJNTpLIO5Ir58xC3mR98TBYcO68/G53Nsk4UQbWLyGhvLCRlZpHLs3b4hi3nd/zu
	Z34rfdslScnYDZCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WnpSvl+U;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9xBHzjBT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754390970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2S6Yfw8MWYSCw6PdDhatVOkzHx1Z3BuEhZk13Etx5uQ=;
	b=WnpSvl+UJbvK0Oc1q/pp5UFH9HWdHVTqG+Nb3mEkYlSqypoC3gZPcpjXon9Tp2Ip0gYaUB
	Sxs0DuFrSC/DYYLu5g3XxbPElCjKe5WKMbUATUu3ZpCGuDR+/oTlhdw7NHnbgyjlhBFpzQ
	TaoxWbcYAUdd8sykBgFDIfx5LzVz1nY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754390970;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2S6Yfw8MWYSCw6PdDhatVOkzHx1Z3BuEhZk13Etx5uQ=;
	b=9xBHzjBTnuqguE1qNw2pGiPKBLhWqFqEeiMDkTe3E6yWV5S8L9Y9/ymgwL+40+ZLlxYHfn
	l5oTD76vX40HGbAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C715B13A50;
	Tue,  5 Aug 2025 10:49:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DaLpL7rhkWhPZgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 05 Aug 2025 10:49:30 +0000
Message-ID: <e34213df-4e76-4b91-97b3-5014e7c00990@suse.de>
Date: Tue, 5 Aug 2025 12:49:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Hannes Reinecke <hare@suse.de>
Subject: MD raid scrubbing and NVMe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: D4CFC2174B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_034934_230094_5573061C 
X-CRM114-Status: UNSURE (   6.01  )
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

Hi all,

now there's a question from one of our partners, who was complaining
that running 'mdcheck' on an NVMe RAID array was particularly slow.
While this could be resolved with fine-tuning MD parameters, it kept
me wondering:
How useful is RAID scrubbing on NVMe?
 From my perspective scrubbing is useful if one wants to avoid excessive
recovery latency on bad sectors (eg TLER).
But the FTL on NVMe already does a quite heavy remapping / rewriting /
garbage collecting for every write, and so it should be detecting
(and correcting) faulty sectors far earlier.
So how effective is RAID scrubbing for NVMe? Can't we delegate the
task of detecting faulty sectors to the FTL and _not_ scrub at all?

(Especially as modern file systems like btrfs do an internal scrubbing
_anyway_...)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


