Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42593E77180
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 09:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QJos5pjsS11dqpP1/LKCrF/uaDsRBuQz+S5oMePxHAA=; b=zT5O72M/QEKUN3sf1XObbxHj6k
	14KefM2i4fa32PB1Q1pduF/HHf+U2MqsVtJrk77cRnpD2Jgxbp9CX8hUi2Qm7X+wMusen/tdloNQt
	viPl4RA59y4aOrrn62/aQugvnwyoY285WIE8o2GQ2jp/338uok+zzSFRELvx2ve3/5hWL1qcXtpw5
	4YucZEsJMLJlOVdH4cmFLXwFflxKchRsVWOVbt4L1gIepypzlmXawTgUAk4Ry/3eYkocP6G6B7C4s
	sJSeGb3/E6w+Beu/flP6KLI36NReSKdG1RQZiLTIRQ1AqgXgJadVuL+FDFGql5riTNA3p5kJx9KxT
	SwIECrKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKwgn-0000000Avd7-2Ckr;
	Tue, 10 Dec 2024 09:37:57 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKwdi-0000000AuP6-2DDR
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 09:34:48 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EB44A21167;
	Tue, 10 Dec 2024 09:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733823285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJos5pjsS11dqpP1/LKCrF/uaDsRBuQz+S5oMePxHAA=;
	b=SXGQw1fc9dfynOq6JPaqeR+PVpHV8HaVWEr4m74APZ6vqKOqxZK0NORhmomSpLN0FnagMr
	ZmBMmsPrr3fuzS2StRdLncaKLQ4Z1T5GT+8O8bRIJpvTPxn4ucjecWki2/wSgSzuMIVoFp
	ebDT+0Liw4yOCOEnP9GgAFBDRGFmDZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733823285;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJos5pjsS11dqpP1/LKCrF/uaDsRBuQz+S5oMePxHAA=;
	b=OYzThrGNCG5T9bvgFaJ3JIcWBaelnIdzEf1Ccn0hw7QtAwwPSYXSMDAPEx+PDl/5JCBiBD
	AwJXWoai1G+3OyDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733823284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJos5pjsS11dqpP1/LKCrF/uaDsRBuQz+S5oMePxHAA=;
	b=VEso+E225CwAeQGjWXPL7XW7yoACRxvlsIIUodsHB9Z0W99tFjZPdGM8JCseVtWfO+GHqL
	C5L21sUQetqy5hIjaYSHY61brJZZ4LF8Eg4qU8SqOThSSmw0BKxi7Apl8c0Z71CnGjOyYi
	bXQK6GaHwVvGiwvMA0L40Nt1mFklY5c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733823284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QJos5pjsS11dqpP1/LKCrF/uaDsRBuQz+S5oMePxHAA=;
	b=TBvlXTSMNkSIMB6X/Mg/l8TIGQciNTe+GIsR3raoILEmUgLf3MLs1/pm6mpPUygDZsCPzO
	duSQfPRDG44hxaAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCFAC138D2;
	Tue, 10 Dec 2024 09:34:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rSgDNTQLWGcLNAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 10 Dec 2024 09:34:44 +0000
Date: Tue, 10 Dec 2024 10:34:44 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
	hch@lst.de, gjoyce@linux.ibm.com, "axboe@fb.com" <axboe@fb.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCHv5 RFC 0/3] Add visibility for native NVMe multipath using
 sysfs
Message-ID: <699ab169-daed-4c83-9ae9-65f6542ba9e6@flourine.local>
References: <20241030104156.747675-1-nilay@linux.ibm.com>
 <10f38d85-e9ac-46b0-9a3e-dcbae26b36d8@linux.ibm.com>
 <46e833ef-5536-4528-8a13-4b79f13e1acf@linux.ibm.com>
 <dd45a4d8-a6c6-4a9c-961d-4bdf251658c3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd45a4d8-a6c6-4a9c-961d-4bdf251658c3@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_013446_719908_D9189F69 
X-CRM114-Status: GOOD (  12.65  )
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

On Tue, Dec 10, 2024 at 12:33:45PM +0530, Nilay Shroff wrote:
> >>> As we know, NVMe native multipath supports three different io policies
> >>> (numa, round-robin and queue-depth) for selecting I/O path, however, we
> >>> don't have any visibility about which path is being selected by multipath
> >>> code for forwarding I/O. This RFC helps add that visibility by adding new
> >>> sysfs attribute files named "numa_nodes" and "queue_depth" under each
> >>> namespace block device path /sys/block/nvmeXcYnZ/. We also create a
> >>> "multipath" sysfs directory under head disk node and then from this
> >>> directory add a link to each namespace path device this head disk node
> >>> points to.
> >>>
> >>> Please find below output generated with this proposed RFC patch applied on
> >>> a system with two multi-controller PCIe NVMe disks attached to it. This
> >>> system is also an NVMf-TCP host which is connected to an NVMf-TCP target
> >>> over two NIC cards. This system has four numa nodes online when the below
> >>> output was captured:

Looks good to me from libnvme's perspective. I just my question on the
lifetime of the new link, but I might just miss the point.

