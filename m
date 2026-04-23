Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAC7FDEE2C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2026 17:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F8OjiifSUP9cvyIslW1lWDGiYRWePP0kKo0n0x9C8Ik=; b=z8sgmjjl4AK+pCFwhQZNOP3mIL
	BvKi61LGcfjTTJZzmD5yGtt2rJwHPoVgu7LHj/NIeJYMFexx0j38qMAbl2yYgolbJbSJ9zosA44Pz
	u9TRTjkbfJCY2NW9zV8ehblc8trCRucb2iyQ6izY/wee7WuJ+34rY9ddaLlDYR8Oxj97TG52IlBn/
	APQ2Otu7V3sToovAGiX1plitydHa8WN32RXCv90SY87NWySuMgTFtOgiRHGzI4215Nd/QNFggeIMq
	yVIQxU0io9XPenIXR9LT8OugKn9lv8Sd7rzgnLyrpCE2JEDr127w7/5/bf/vVoSYmP1+5NEeoj1kj
	ixg1wwTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFxTj-0000000C0R3-3tBC;
	Thu, 23 Apr 2026 17:04:39 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFxTd-0000000C0Pj-357l
	for linux-nvme@lists.infradead.org;
	Thu, 23 Apr 2026 17:04:37 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9C1556A890;
	Thu, 23 Apr 2026 17:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776963867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F8OjiifSUP9cvyIslW1lWDGiYRWePP0kKo0n0x9C8Ik=;
	b=KggMeICjBS1sPUd6nxYbaYw3nUbMoIrLYhwt3fsK6di6KTwRUmhGzHOPvYg+aLIKcHdZjB
	+WWTG5wRgP4zQD35+uBVPuhNPNN1JDzrF0K0Q0oUaetNiiFYTtiRvsnbIY02ayOfPWTi3S
	AK7+5760aSKQ5Uk0hjQOIgblODX7OCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776963867;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F8OjiifSUP9cvyIslW1lWDGiYRWePP0kKo0n0x9C8Ik=;
	b=CKOgFlFShdYzUt2bTXJS0G5e9SVy7mwtlJa0ZpDnVbDjSNk4m+DQwDhDVJWr5RnWBC9cXh
	HhM7FjfV6Z8Qt3DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uOgRhLAx;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NKRQ40lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776963862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F8OjiifSUP9cvyIslW1lWDGiYRWePP0kKo0n0x9C8Ik=;
	b=uOgRhLAxpdnlMaVCzgX5Dg5KKKMPTOkTaH9CQw9y+q+uP9pzitfkDB00WT+QfW30V0ZPDv
	O/yq/Ml0mq872r9sqyBmSYHiywNO+8Fk8sIUljQqMdAKbt7GnzU7xb5vUL/9g6/yBxPqhk
	cAnSS7/3sVr31jX1jcCXkPBpnDkydLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776963862;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F8OjiifSUP9cvyIslW1lWDGiYRWePP0kKo0n0x9C8Ik=;
	b=NKRQ40ltN/nxL8Fyi7RZHyTryBeJkzik4i49i0pqyEWIxD1nInVKGoYRyDNcAPgxF2mGtm
	ddr1a/GQDaDNs/Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84E8E593A3;
	Thu, 23 Apr 2026 17:04:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KX3DHhZR6mmuBwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 23 Apr 2026 17:04:22 +0000
Date: Thu, 23 Apr 2026 19:04:17 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org, 
	mheyne@amazon.de, emilne@redhat.com, jmeneghi@redhat.com, 
	linux-nvme@lists.infradead.org, mkhalfella@purestorage.com, chaitanyak@nvidia.com, 
	hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V3 2/8] nvme: add sysfs attribute to change admin timeout
 per nvme controller
Message-ID: <ad70df1f-46e9-48ee-b5af-f6c1bb0c4e70@flourine.local>
References: <20260410073924.61078-1-mlombard@redhat.com>
 <20260410073924.61078-3-mlombard@redhat.com>
 <a3171007-7cfb-45b0-b0bf-01dcc7ba51ab@flourine.local>
 <DHZMXEY4JPEF.1HHTTEZPN53ZU@arkamax.eu>
 <e99f2ce9-e47a-432a-b6ea-795081de1f4d@flourine.local>
 <DI0JVXM1ZKET.3S7JP55JIPFHH@arkamax.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI0JVXM1ZKET.3S7JP55JIPFHH@arkamax.eu>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 9C1556A890
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_100433_919895_92F35211 
X-CRM114-Status: GOOD (  16.30  )
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

On Thu, Apr 23, 2026 at 02:58:25PM +0200, Maurizio Lombardi wrote:
> >> if the NVME_CTRL_STARTED_ONCE bit is set, we know that the
> >> initialization has been completed and that admin_q and fabrics_q will
> >> exist until the controller will be torn down.
> >
> > Yes, that is all fine but I think it would be good to be able to use
> > udev here as we have it other timeouts.
> 
> Ok I understand, what do you think if we swap the order in
> nvme_start_ctrl() so the flag is set before userspace is notified?
> 
> set_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags);
> nvme_change_uevent(ctrl, "NVME_EVENT=connected");

I doesn't look like there is anything else depending on this order. So
yes, that would make this race go away.

