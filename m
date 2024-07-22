Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F91C3DA59
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jul 2024 14:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=85e/su7iJAQzM7TzET902i1Cb1TCPibnz0maKB0G3SI=; b=tlqNXiqxZYuTNfidor7SYJPyTz
	5hFaX7AVrnPuxMt1PxeHZjE630z3FQ5poV8znHgQCknfD2lUFJAupdZwByBXLgV1f8dqTAjwMEiIi
	z39poIDLO4kTgKUPK6ee7ufRdhvTuUbCElw7U74LZMJbcf4rQZN62gFywmZwgZmO0E4zqvxyAiTqs
	19BZ7d/wNmCS5/+louJbUe5xPyhXa6XaWJEaBqsEimOh4Citc+q+atMbguSFXwBef1R9G5DgM9yno
	TmlFKmiZPcY3SL+evfjTX3v0BXiq1lT/lthfmytgkwPdB1EoqOYpvmQNZFXKgXRacPYxMP+L80Yyp
	rByEU5PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVts7-00000009kIH-13hW;
	Mon, 22 Jul 2024 14:18:39 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVts3-00000009kHK-1SKD
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jul 2024 14:18:38 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3AB0C21B8C;
	Mon, 22 Jul 2024 14:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721657912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85e/su7iJAQzM7TzET902i1Cb1TCPibnz0maKB0G3SI=;
	b=TNfxe50rIc+g0c5Sb5fgmRCdeqDxV+3DcIR1b+Q5sfS4S5eAH/m6Dnw0ltaXHm2lk8VSMt
	fhoOQiRfnHCa9O4obzagW5Hq4zS8Rf83wfGteKvdsgQG7ojA2wbIs6ArCzIl4Of2bioXvB
	0uf4Ya0nCRy8EFIUmTipG2SRqsKSPRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721657912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85e/su7iJAQzM7TzET902i1Cb1TCPibnz0maKB0G3SI=;
	b=DsQQiq3dThcGHT9t7lLqT/ii7DMOiFtRqeOBNTV+esAgfVUvx05t5Dlcyi1N6bv4P86S2m
	lxc0YB0AFHGvzZCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TNfxe50r;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DsQQiq3d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721657912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85e/su7iJAQzM7TzET902i1Cb1TCPibnz0maKB0G3SI=;
	b=TNfxe50rIc+g0c5Sb5fgmRCdeqDxV+3DcIR1b+Q5sfS4S5eAH/m6Dnw0ltaXHm2lk8VSMt
	fhoOQiRfnHCa9O4obzagW5Hq4zS8Rf83wfGteKvdsgQG7ojA2wbIs6ArCzIl4Of2bioXvB
	0uf4Ya0nCRy8EFIUmTipG2SRqsKSPRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721657912;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=85e/su7iJAQzM7TzET902i1Cb1TCPibnz0maKB0G3SI=;
	b=DsQQiq3dThcGHT9t7lLqT/ii7DMOiFtRqeOBNTV+esAgfVUvx05t5Dlcyi1N6bv4P86S2m
	lxc0YB0AFHGvzZCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 272BF138A7;
	Mon, 22 Jul 2024 14:18:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GNcGCDhqnmZ9SAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 22 Jul 2024 14:18:32 +0000
Date: Mon, 22 Jul 2024 16:18:31 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org, 
	sagi@grimberg.me, axboe@fb.com, gjoyce@linux.ibm.com
Subject: Re: [PATCH RFC 0/1] Add visibility for native NVMe miltipath using
 debugfs
Message-ID: <5nwflcpqoyknrruzdlvgnt5bpcoxh6nrirjwnjes4oazkr7nai@uwsynbuduibr>
References: <20240722093124.42581-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722093124.42581-1-nilay@linux.ibm.com>
X-Spamd-Result: default: False [-0.81 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 3AB0C21B8C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Bar: /
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_071835_560849_B14DB9F9 
X-CRM114-Status: GOOD (  16.06  )
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

On Mon, Jul 22, 2024 at 03:01:08PM GMT, Nilay Shroff wrote:
> This patch propose adding a new debugfs file entry for NVMe native
> multipath. As we know NVMe native multipath today supports three different
> io-policies (numa, round-robin and queue-depth) for selecting optimal I/O
> path and forwarding data. However we don't have yet any visibility to find
> the I/O path being selected by NVMe native multipath code.
> 
> IMO, it'd be nice to have this visibility information available under 
> debugfs which could help a user to validate the I/O path being chosen is 
> optimal for a given io policy. This patch propose adding a debugfs file 
> for each head disk node on the system. The proposal is to create a file 
> named "multipath" under "/sys/kernel/debug/nvmeXnY/".
> 
> Please find below output generated with this patch applied on a system 
> with a multi-controller PCIe NVMe disk attached to it. This system is also
> an NVMf-TCP host which is connected to NVMf-TCP target over two NIC cards. 
> This system has two numa nodes online when the below output was
> captured:

Wouldn't it make sense to extend nvme-cli instead adding additional
debugfs entries to the kernel, e.g. extending show-topology?

