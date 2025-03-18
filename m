Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1775C282EC
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Mar 2025 14:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oMZsbt5FP/7lZCFP5G6rNOmyLmrJneszQ4p8hqVY674=; b=RLBRgzqsQcXsOio1MQLhxP128c
	8V0VFe+7zqAwHg3lWBYObtOI5/dfqfpQuaC5Igqgo2u/ERuCXfPXk2y8l6lVZu9cJ/qe8vom9MDTB
	LNKa20IVhInjTo7NT7yeInl7zpELwhaneHkx5Om4KYx37iXu7Yu8Icuxl5u2tdWOJhL7XnGzaV3hS
	w1bqUildDgcrVcapbL/d1gDKrzYwUtX7iMs5Vi3NAeB2NTD0A88JFADe/EC1KIHrhG+voVu1Wexub
	NyUMpKRgosG7y+EX3F+bsm4VHJuF1cGQmr2hPV/wr0fEn61D0fgdjmAMoBzXeVOR47y6LIqbzLx/r
	gKtyy5xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuXWP-0000000672D-0hxJ;
	Tue, 18 Mar 2025 14:02:21 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuXSn-000000066Ja-33Mm
	for linux-nvme@lists.infradead.org;
	Tue, 18 Mar 2025 13:58:39 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2D8161FB8B;
	Tue, 18 Mar 2025 13:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742306316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oMZsbt5FP/7lZCFP5G6rNOmyLmrJneszQ4p8hqVY674=;
	b=tCwU+aILtVfHcK6WpYY+q9K/jmIn29BF0LXmOcnvUvgAbNQs9pPxELPFsGmSdvl2N0YsO8
	LqsihYOZ15adcXS4TNByWsC7EPa/lOpLKGS1CM6CCzRmzHbkbi8zivGcJV+z5+7EgV7dJx
	2MveBvEVMGGiRceuykq334RuOslvQSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742306316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oMZsbt5FP/7lZCFP5G6rNOmyLmrJneszQ4p8hqVY674=;
	b=qhBm95KOjJ63saOpkLonqlpOO6G/iNm1iW7nKksQhEjUL69/G0kdBDL3t0fbKOSP1uQNGT
	BQBcF1Gk5+Q4WABg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742306316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oMZsbt5FP/7lZCFP5G6rNOmyLmrJneszQ4p8hqVY674=;
	b=tCwU+aILtVfHcK6WpYY+q9K/jmIn29BF0LXmOcnvUvgAbNQs9pPxELPFsGmSdvl2N0YsO8
	LqsihYOZ15adcXS4TNByWsC7EPa/lOpLKGS1CM6CCzRmzHbkbi8zivGcJV+z5+7EgV7dJx
	2MveBvEVMGGiRceuykq334RuOslvQSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742306316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oMZsbt5FP/7lZCFP5G6rNOmyLmrJneszQ4p8hqVY674=;
	b=qhBm95KOjJ63saOpkLonqlpOO6G/iNm1iW7nKksQhEjUL69/G0kdBDL3t0fbKOSP1uQNGT
	BQBcF1Gk5+Q4WABg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F1D613A82;
	Tue, 18 Mar 2025 13:58:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SlaZBgx82WcpfwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 18 Mar 2025 13:58:36 +0000
Date: Tue, 18 Mar 2025 14:58:35 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <wagi@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/18] nvmet-fcloop: allocate/free fcloop_lsreq
 directly
Message-ID: <984ea057-de15-472a-9be3-79594f6bfc00@flourine.local>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org>
 <20250318-nvmet-fcloop-v3-10-05fec0fc02f6@kernel.org>
 <603b438e-02f6-4f01-8ffa-12ab6ec8e745@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <603b438e-02f6-4f01-8ffa-12ab6ec8e745@suse.de>
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250318_065837_909083_01D3F07F 
X-CRM114-Status: UNSURE (   9.46  )
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

On Tue, Mar 18, 2025 at 12:17:11PM +0100, Hannes Reinecke wrote:
> > +	tls_req = kmalloc(sizeof(*tls_req), GFP_KERNEL);
> > +	if (!tls_req)
> > +		return -ENOMEM;
> 
> This cries out for kmem_cache_alloc() ...

Okay, will switch to this API. FWIW, in the same call path there are
more kmallocs.

