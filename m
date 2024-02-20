Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78F1C48BC3
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Feb 2024 08:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:Subject:From:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IuVcZkBm2zR7uVQ9DesXBwScKqqzvrFVA/hmHbxat2M=; b=NGSgjxoED/+k4FxHHe/oe8GVfQ
	i6toh3qxrmxGVJwCoZw8tdmzQ0DgpA6ZT1eTSBQjzguYaH2qmlRj9Y0jJwRSGOmcrI9GcPG6Ev68G
	3uFNZYFq6nPUChgpiZ8jmHFIhD//ea8i6HQxxKItvzx/bZn2kUFWftO+EGRkeATDSmw6Covs9KLkM
	JLQxzu4+iahcMCfM5Fll6AVrhvSOC+3/vSC7qV7T692TePIFry+YL8RelhnUd8Co/n/EYCmaKhEX9
	ARQAUX1VKezJsy33PfImp9+VR2fXu7DqHFC2R26xIPtDHzSwvCp5vXH7/7vofwG040MnEgY7zIH7k
	iA1lpQKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcL5w-0000000DbTs-2HeC;
	Tue, 20 Feb 2024 08:03:16 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcL5r-0000000DbRz-1TF2
	for linux-nvme@lists.infradead.org;
	Tue, 20 Feb 2024 08:03:14 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6661D21FB3;
	Tue, 20 Feb 2024 08:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708416189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IuVcZkBm2zR7uVQ9DesXBwScKqqzvrFVA/hmHbxat2M=;
	b=awqG6s9ri3OEw53aD2NGrCB1sGs77GBG57p7jlFvmH+ogALyHzJKLhQ4KIBaZH//YzyrGm
	6tVJa/YMcLjTWbO+54qfFc+mGDXzrmTH19QwzgxqbbbCsaJk2q6c5BgO6ONIPvJdTfVcRn
	lNSatLPEaTCGPqx5dxzu5S6ixopRwtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708416189;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IuVcZkBm2zR7uVQ9DesXBwScKqqzvrFVA/hmHbxat2M=;
	b=/kU5xjhfck9TmdzklGGlKPgRRu4tDyKbWSPeqs1uQ8XeAORqAs+oR6GO+OG6t7Vxf4zuCq
	HbJCkspv/atQhMCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708416189; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IuVcZkBm2zR7uVQ9DesXBwScKqqzvrFVA/hmHbxat2M=;
	b=awqG6s9ri3OEw53aD2NGrCB1sGs77GBG57p7jlFvmH+ogALyHzJKLhQ4KIBaZH//YzyrGm
	6tVJa/YMcLjTWbO+54qfFc+mGDXzrmTH19QwzgxqbbbCsaJk2q6c5BgO6ONIPvJdTfVcRn
	lNSatLPEaTCGPqx5dxzu5S6ixopRwtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708416189;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IuVcZkBm2zR7uVQ9DesXBwScKqqzvrFVA/hmHbxat2M=;
	b=/kU5xjhfck9TmdzklGGlKPgRRu4tDyKbWSPeqs1uQ8XeAORqAs+oR6GO+OG6t7Vxf4zuCq
	HbJCkspv/atQhMCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03777134E4;
	Tue, 20 Feb 2024 08:03:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RhaPObxc1GXRUAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 20 Feb 2024 08:03:08 +0000
Message-ID: <1817f06c-5b56-4646-b631-9887cd28aba4@suse.de>
Date: Tue, 20 Feb 2024 09:03:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
From: Hannes Reinecke <hare@suse.de>
Subject: [LSF/MM BPF TOPIC] NUMA topology metrics for NVMe-oF
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=awqG6s9r;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/kU5xjhf"
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-0.00)[43.88%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 TO_DN_EQ_ADDR_ALL(0.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6661D21FB3
X-Spamd-Bar: /
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240220_000311_564622_06FD9E02 
X-CRM114-Status: UNSURE (   8.58  )
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

having recently played around with CXL I started to wonder which 
impllication that would have for NVMe-over-Fabrics, and how the path 
selection would play out on such a system.

Thing is, with heavy NUMA systems we really should have a look at
the inter-node latencies, especially as the HW latencies are getting
closer to the NUMA latencies: for an Intel two socket node I'm seeing
latencies of around 200ns, and it's not unheard of getting around 5M 
IOPS from the device, which results in a latency of 2000ns.
And that's on PCI4.0. With PCI5 or CXL one expects the latency to 
decrease even further.

So I think that we should need to look at factor in the NUMA topology
for PCI devices, too. We do have a NUMA I/O policy, but that only looks
at the latency between nodes.
What we're missing is a NUMA latency for the PCI devices themselves.

So this discussion would be around how we could model (or even measure)
the PCI latency, and how we could modify the NVMe-oF iopolicies to take 
the NUMA latencies into account when selecting the 'best' path.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

