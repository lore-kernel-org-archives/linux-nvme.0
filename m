Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837FEC3DA49
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jul 2024 07:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4i3qQlUhX+mc9+73TL0GC3OSseEBlN3qBlkF7YrlDjU=; b=Q7iXyBzImuny2S2j9iN1ycIfoF
	waUEdqPlQ0JYe/HwtDSZD6QPA+dRnX9uMBk/ui7HN5c2FScXOBJn+2281d0lmw/sBYccs15+NT7t7
	I6lCsG4dpcCaYfQEi2spHY2wtAnD8lcgUrBIF5djR44eR3/JTCS2ihNF/tFz7L/EWXdPB5+TdVjEa
	G5Tqsy7WXzEdIXnPutXXej+h1KxSCt9S350l9UkcMd7U05Wn1qD1SGCdQN3qX9regFpVymR5dUFuL
	5qorS0XbwhDhC5lEjAS9kpfuXF0HdGZ3qNH+XnqD0Sg+hOMyrBK209p3Pyh14VVWvA1lm97caNDGD
	HLqSRdvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWA8x-0000000BkK3-0CR4;
	Tue, 23 Jul 2024 07:41:07 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWA8s-0000000BkIq-1H3I
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jul 2024 07:41:05 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CE4F41F387;
	Tue, 23 Jul 2024 07:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721720460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4i3qQlUhX+mc9+73TL0GC3OSseEBlN3qBlkF7YrlDjU=;
	b=OquijDk13X+Z1cw2N66rx3QAjj/vpPLhIFWjtBYlOpFs4Xy0oZ4043xbAruZHeuxmzAq42
	rKib+NJvWshDIHfjTsSyVv6x68Ftsm66w+g+Oira8RzR6Acfcu9czcRKL/KJ2TiY9ggOZx
	0V/zbLMQ9PFWY3cOCjApR5e2KYn7om4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721720460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4i3qQlUhX+mc9+73TL0GC3OSseEBlN3qBlkF7YrlDjU=;
	b=1ly58XWAJI4S2xOdgrCSpbbZHraP34hHibNMI5sz63mm1SRueytEQgV0WuQBOHI/sWVdqy
	+GwfMotNM0a6nrBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721720460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4i3qQlUhX+mc9+73TL0GC3OSseEBlN3qBlkF7YrlDjU=;
	b=OquijDk13X+Z1cw2N66rx3QAjj/vpPLhIFWjtBYlOpFs4Xy0oZ4043xbAruZHeuxmzAq42
	rKib+NJvWshDIHfjTsSyVv6x68Ftsm66w+g+Oira8RzR6Acfcu9czcRKL/KJ2TiY9ggOZx
	0V/zbLMQ9PFWY3cOCjApR5e2KYn7om4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721720460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4i3qQlUhX+mc9+73TL0GC3OSseEBlN3qBlkF7YrlDjU=;
	b=1ly58XWAJI4S2xOdgrCSpbbZHraP34hHibNMI5sz63mm1SRueytEQgV0WuQBOHI/sWVdqy
	+GwfMotNM0a6nrBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECC0513874;
	Tue, 23 Jul 2024 07:40:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ynARIYten2aLWQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 23 Jul 2024 07:40:59 +0000
Date: Tue, 23 Jul 2024 09:40:55 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org, 
	sagi@grimberg.me, axboe@fb.com, gjoyce@linux.ibm.com
Subject: Re: [PATCH RFC 0/1] Add visibility for native NVMe miltipath using
 debugfs
Message-ID: <dpwafli2lwjlita6pcxwg5ilvxbqm4c4tckjcawhzzwfqywpow@o47xxyrwcmmw>
References: <20240722093124.42581-1-nilay@linux.ibm.com>
 <5nwflcpqoyknrruzdlvgnt5bpcoxh6nrirjwnjes4oazkr7nai@uwsynbuduibr>
 <831af264-7f8a-495e-99b0-51f294e0948f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <831af264-7f8a-495e-99b0-51f294e0948f@linux.ibm.com>
X-Spamd-Result: default: False [-0.60 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240723_004102_523917_C1B2E8F7 
X-CRM114-Status: GOOD (  24.59  )
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

On Tue, Jul 23, 2024 at 10:48:02AM GMT, Nilay Shroff wrote:
> On 7/22/24 19:48, Daniel Wagner wrote:
> > On Mon, Jul 22, 2024 at 03:01:08PM GMT, Nilay Shroff wrote:
> >> This patch propose adding a new debugfs file entry for NVMe native
> >> multipath. As we know NVMe native multipath today supports three different
> >> io-policies (numa, round-robin and queue-depth) for selecting optimal I/O
> >> path and forwarding data. However we don't have yet any visibility to find
> >> the I/O path being selected by NVMe native multipath code.
> >>
> >> IMO, it'd be nice to have this visibility information available under 
> >> debugfs which could help a user to validate the I/O path being chosen is 
> >> optimal for a given io policy. This patch propose adding a debugfs file 
> >> for each head disk node on the system. The proposal is to create a file 
> >> named "multipath" under "/sys/kernel/debug/nvmeXnY/".
> >>
> >> Please find below output generated with this patch applied on a system 
> >> with a multi-controller PCIe NVMe disk attached to it. This system is also
> >> an NVMf-TCP host which is connected to NVMf-TCP target over two NIC cards. 
> >> This system has two numa nodes online when the below output was
> >> captured:
> > 
> > Wouldn't it make sense to extend nvme-cli instead adding additional
> > debugfs entries to the kernel, e.g. extending show-topology?
> > 
> Yeah we may extend nvme-cli to print this(multipathing) information however from
> where would nvme-cli retrieve that information? AFAIK, today this multipath information
> is not exported by NVMe driver. So we have to first make this information available from
> driver either through sysfs or ioctl and then nvme-cli could parse it and show it to the 
> user. If everyone thinks that it's worth extending nvme-cli so that it could display this 
> information then yes we can certainly implement it. Please suggest.

debugfs might always be available. IIRC when lockdown is enabled, debugfs
is not available or parts of it.

I'd suggest going the full way and add expose the relevant information
via sysfs and extend libnvme and nvme-cli. But this just my take on this.

