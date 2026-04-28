Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDB2CCFA13
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Apr 2026 21:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oNmfGQaXydSNVp/wD+ZDk5eV1VFql8i87Ef0v+yEIJc=; b=hJ+cRZUrzFTLwNwcEraSADfgNN
	C9EgSLZeDacwsPkpMvMj7Yf2BnrUq5r1au0WcIEKKO/2rkUWLfPLXdlUDDqVKmZkyDIbLBE5rs6Tr
	A7zvPkA9pY2oP+h/RnJrTZheOJxjqsimH8KK5tJR7BZm1WHqndbQ7tJ1Kiqv4BqHDL23zVni5j/PL
	dLVz+DixYwW9kuVFnAf6YgqTxzRYYy+MmGNboX5Ytym4SHS5Bg3Fs/Ck4ExkvO/vP/dxtFHCW4Dqs
	L6zRrvYSABparSLmK1vboZkiQOWjLWH03xeMI3NefpzJ06HvrLzMVRRoO4HHXJhV29EPVHU+xqT7C
	MTlbu+CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wICBf-00000004DTS-1IsX;
	Wed, 29 Apr 2026 21:11:15 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHhwf-00000001TXR-3WXH
	for linux-nvme@lists.infradead.org;
	Tue, 28 Apr 2026 12:53:47 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 18BD55BD55;
	Tue, 28 Apr 2026 12:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777380824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oNmfGQaXydSNVp/wD+ZDk5eV1VFql8i87Ef0v+yEIJc=;
	b=cRSf4YjRjRT9SmsdPEk3zl2zvIS93JUJW4kvlYYer+UL/ehPBz68JiN6aeLXLDsErOFcdE
	hic8XTGYfwNANj8VwNlJIGjcn8tjAyGNtu+HqTL9J0y+E+0aNOhExWb2m/uO/LlvXk25L4
	+qoqTG+U03m0e1IRsSAyQ5vhDGUr2r0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777380824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oNmfGQaXydSNVp/wD+ZDk5eV1VFql8i87Ef0v+yEIJc=;
	b=dsHBhXA+c+Nr7Gwv+tgrjETsPTkf/4Pd/0f1FJj2eH+Y+kBsyjTaUJVvkyKkpDyioEpDoq
	z0siPCkKk+rFHyAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777380824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oNmfGQaXydSNVp/wD+ZDk5eV1VFql8i87Ef0v+yEIJc=;
	b=cRSf4YjRjRT9SmsdPEk3zl2zvIS93JUJW4kvlYYer+UL/ehPBz68JiN6aeLXLDsErOFcdE
	hic8XTGYfwNANj8VwNlJIGjcn8tjAyGNtu+HqTL9J0y+E+0aNOhExWb2m/uO/LlvXk25L4
	+qoqTG+U03m0e1IRsSAyQ5vhDGUr2r0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777380824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oNmfGQaXydSNVp/wD+ZDk5eV1VFql8i87Ef0v+yEIJc=;
	b=dsHBhXA+c+Nr7Gwv+tgrjETsPTkf/4Pd/0f1FJj2eH+Y+kBsyjTaUJVvkyKkpDyioEpDoq
	z0siPCkKk+rFHyAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3F2C593B0;
	Tue, 28 Apr 2026 12:53:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LRuNO9et8Gl9SAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 28 Apr 2026 12:53:43 +0000
Date: Tue, 28 Apr 2026 14:53:43 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Aaron Tomlin <atomlin@atomlin.com>, axboe@kernel.dk, kbusch@kernel.org, 
	hch@lst.de, sagi@grimberg.me, mst@redhat.com, aacraid@microsemi.com, 
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com, liyihang9@h-partners.com, 
	kashyap.desai@broadcom.com, sumit.saxena@broadcom.com, 
	shivasharan.srikanteshwara@broadcom.com, chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com, 
	sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com, ranjan.kumar@broadcom.com, 
	jinpu.wang@cloud.ionos.com, tglx@kernel.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, akpm@linux-foundation.org, 
	maz@kernel.org, ruanjinjie@huawei.com, yphbchou0911@gmail.com, wagi@kernel.org, 
	frederic@kernel.org, longman@redhat.com, chenridong@huawei.com, hare@suse.de, 
	kch@nvidia.com, ming.lei@redhat.com, tom.leiming@gmail.com, steve@abita.co, 
	sean@ashe.io, chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com, 
	nick.lange@gmail.com, marco.crivellari@suse.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com, 
	MPT-FusionLinux.pdl@broadcom.com
Subject: Re: [PATCH v12 05/13] blk-mq: add
 blk_mq_{online|possible}_queue_affinity
Message-ID: <c4927a2b-c18d-42ce-8a60-d6d388155671@flourine.local>
References: <20260422185215.100929-1-atomlin@atomlin.com>
 <20260422185215.100929-6-atomlin@atomlin.com>
 <20260427153416.MeVS8yxF@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427153416.MeVS8yxF@linutronix.de>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[atomlin.com,kernel.dk,kernel.org,lst.de,grimberg.me,redhat.com,microsemi.com,hansenpartnership.com,oracle.com,h-partners.com,broadcom.com,cloud.ionos.com,infradead.org,linaro.org,linux-foundation.org,huawei.com,gmail.com,suse.de,nvidia.com,abita.co,ashe.io,suse.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	R_RATELIMIT(0.00)[to_ip_from(RLkc91obuuiwe93nwph69c5cft)];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_GT_50(0.00)[52];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_055346_032148_5DDFF4C6 
X-CRM114-Status: GOOD (  14.42  )
X-Mailman-Approved-At: Wed, 29 Apr 2026 14:11:14 -0700
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

On Mon, Apr 27, 2026 at 05:34:16PM +0200, Sebastian Andrzej Siewior wrote:
> Which driver uses cpu_possible_mask? This mask is assigned at boot time
> once the kernel figured how many CPUs are possible based on ACPI or
> whatever the system uses. This mask does not change.
> 
> I only see drivers/scsi/lpfc/lpfc_init.c using it. Looking at
> cpu_possible_mask might not be the right thing. It is usually the same
> thing as "online" except on system where ACPI thinks that something
> could be added via hotplug _or_ if the admin shuts down a CPU via
> cpuhotplug _or_ boots with less (there a command line option for
> that).

These HBAs are used on PowerPC which supports lpar (CPUs can be added
during runtime) I am told it's properly the only driver which is caring
about this type configuration, thus a bit of an odd ball.

> In case cpu_possible_mask != cpu_online_mask the intention is to
> allocate memory and setup irqs for the offline CPUs?

I can't answer this. The lpfc driver has several strategies implemented
how it spreads its resources.

