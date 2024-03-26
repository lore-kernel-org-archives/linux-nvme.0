Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A70C54E67
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 07:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RWp2bRkRBWf+atIlRY1FM/y0NODtqpGZQBFWoch/rCs=; b=tXmO3tMLxw7JEMbJNJsqIVQCT/
	OAxegjrNH9j0oRxr7VZUL546dp1nW3fn79pRuvNTPKUrdWXx8mLlx9WLFboHdaIOqrGva84tWX1F8
	S8l+W2THzQldW2PYDokOjoMUl/4xw+DS1km5zzo5XK0fp5NwmJl45V1XBwpK5FBKEremrIm1GcLLX
	suSV/qS6+htkaww+2RqNit3Zuhj+LUw1YXGp/lf1o0DIpo0Geu04SzMQ/n2hQMD2f/5bEDAUWlfNp
	5orgwlhYuv3EiV3YCw8aahf6WZ5Dh3XBIGkAfRND/JxwHdYgZ78Q0iJum7+4eU847lKEFmPv0Hw6Y
	NBn0uGnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp18g-00000003QGS-01Ei;
	Tue, 26 Mar 2024 07:22:30 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp18W-00000003QFJ-1t0g
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 07:22:24 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 042945D258;
	Tue, 26 Mar 2024 07:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711437739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWp2bRkRBWf+atIlRY1FM/y0NODtqpGZQBFWoch/rCs=;
	b=ExvYmlGwKX2X99nVrvqHHUFnXmgQk5XQfwJcBfXFzM8V/PmLLBdd6cljz/GPsh88S2sR7V
	le7QCH/M/zr8q8Iz2ewSnRSm0fhrlZGLaGEUaT9KkvSobg24OcJLzv6cuc7qShZCJ+Dxoe
	0MJ7knvDmmmEghl7SNPlEEctHEOMcDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711437739;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWp2bRkRBWf+atIlRY1FM/y0NODtqpGZQBFWoch/rCs=;
	b=APhaFTspquuXDBbjmBBi2sZ7ltAYVHT12egftPRnILd7AYYQTpNEZQJcb60IVAFK9/EUL4
	zKdSleNCjhnQZACg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711437739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWp2bRkRBWf+atIlRY1FM/y0NODtqpGZQBFWoch/rCs=;
	b=ExvYmlGwKX2X99nVrvqHHUFnXmgQk5XQfwJcBfXFzM8V/PmLLBdd6cljz/GPsh88S2sR7V
	le7QCH/M/zr8q8Iz2ewSnRSm0fhrlZGLaGEUaT9KkvSobg24OcJLzv6cuc7qShZCJ+Dxoe
	0MJ7knvDmmmEghl7SNPlEEctHEOMcDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711437739;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWp2bRkRBWf+atIlRY1FM/y0NODtqpGZQBFWoch/rCs=;
	b=APhaFTspquuXDBbjmBBi2sZ7ltAYVHT12egftPRnILd7AYYQTpNEZQJcb60IVAFK9/EUL4
	zKdSleNCjhnQZACg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E517013587;
	Tue, 26 Mar 2024 07:22:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id a/NwNqp3AmZnagAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 07:22:18 +0000
Date: Tue, 26 Mar 2024 08:22:18 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, 
	Redouane BOUFENGHOUR <redouane.boufenghour@shadow.tech>
Subject: Re: [PATCH 1/8] nvmet: add debugfs support
Message-ID: <dfjfcb6pwvl7hltfbu47ouugginyhzcdnup5ya3hf2xkd7nuq7@eu3ylcmrhbq3>
References: <20240322070333.3820-1-hare@kernel.org>
 <20240322070333.3820-2-hare@kernel.org>
 <yph2qil3t2wzdq4ogr2jkh7ybckyhapfmwacurixjozmtjhreb@7qdgjt4fgget>
 <b12d233d-8620-4c55-ba94-a4cb3d4a5fbf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b12d233d-8620-4c55-ba94-a4cb3d4a5fbf@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-5.04 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.24)[72.80%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_002220_688929_73E0E03C 
X-CRM114-Status: UNSURE (   9.51  )
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

On Tue, Mar 26, 2024 at 08:14:28AM +0100, Hannes Reinecke wrote:
> Weelll ... guess what the 'fatal' status does ...
> I can rename it to 'reset' if you'd like, but 'fatal' corresponds to one of
> the controller states, whereas 'reset' doesn't.
> But I can make it an alias if you really want to write 'reset' :-)

I am fine with 'fatal'.

