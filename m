Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA1AC54E41
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 11:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lFkoJxqj1/+gasfQHGu5eriqmw1xQ+7StkzXp3/w3R8=; b=eMfoUZzAupQ31yr18mlBzySR7m
	mS+PxtBYXS0nTX6ysAPgY24/0GNCvl77BV6ny79qpUtQdAFdxngsUojaRh3Fw3hqkb3VJ7+J8J0kj
	J3Z2bZGmhjaHElkjxBVGNUh6pcMWqgCtUTOkAL6LVQzLgdOdakjLX4xKhp9C0Xq/HECgoP7oDDMVI
	UC4DL/xUM8xUCNzzxlv0OxnAeCkFB2DtrJdgWPfWxA7WsOKS2F51sDtXJwsxrfe9LnNW4jnflnyJp
	epizy4vp6MX9BDnwpVPanVCILtjLLb+tJIkkSy1ty0/S7nh8qkRmOjBFa8GdTKufGupTa4Ry7qTUb
	qji3LlNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhSfB-0000000DGDX-2k2F;
	Tue, 05 Mar 2024 11:08:49 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhSf5-0000000DGA6-46gJ
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 11:08:48 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 180136AD6B;
	Tue,  5 Mar 2024 11:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709636921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFkoJxqj1/+gasfQHGu5eriqmw1xQ+7StkzXp3/w3R8=;
	b=yRktqfpgK1h45zxk5p2QiMYUPNgvGIFtbAQj2U1FXbMkhkjOGbbidK2ugRAJF4QSroTVZk
	OnE1zuqyHxmJNmWLqFDVxQLuxRzHq9xzSbeAJOmlsil5hbGnX51zCxYuatvRtL953h2iJB
	A8PiEnXvQJS/HanUWsXGrAnvUzs8Qsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709636921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFkoJxqj1/+gasfQHGu5eriqmw1xQ+7StkzXp3/w3R8=;
	b=SMmC2/i8dDCmLj25Sit7+PHD3WFmzJS5XBmo6GE6jd0bFrG8DH50n8mrTV5+JLfV/Crifv
	RO3bbYvR4Z3ujfBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709636921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFkoJxqj1/+gasfQHGu5eriqmw1xQ+7StkzXp3/w3R8=;
	b=yRktqfpgK1h45zxk5p2QiMYUPNgvGIFtbAQj2U1FXbMkhkjOGbbidK2ugRAJF4QSroTVZk
	OnE1zuqyHxmJNmWLqFDVxQLuxRzHq9xzSbeAJOmlsil5hbGnX51zCxYuatvRtL953h2iJB
	A8PiEnXvQJS/HanUWsXGrAnvUzs8Qsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709636921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFkoJxqj1/+gasfQHGu5eriqmw1xQ+7StkzXp3/w3R8=;
	b=SMmC2/i8dDCmLj25Sit7+PHD3WFmzJS5XBmo6GE6jd0bFrG8DH50n8mrTV5+JLfV/Crifv
	RO3bbYvR4Z3ujfBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0146013466;
	Tue,  5 Mar 2024 11:08:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id o1rkOjj95mVLDQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 05 Mar 2024 11:08:40 +0000
Date: Tue, 5 Mar 2024 12:08:40 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v1 2/2] nvme/048: add reconnect after ctrl key
 change
Message-ID: <3aeichb4fe6idz4zbdqunfp2kj72af64an6j3xvjdfka7fkx52@3shgtvvlaw4i>
References: <20240304161303.19681-1-dwagner@suse.de>
 <20240304161303.19681-3-dwagner@suse.de>
 <hidg7tztvsyak5kjlrvglwyd5kb4kaaqfwbztxcf7vzpmsv5rc@knbau5ucdigs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hidg7tztvsyak5kjlrvglwyd5kb4kaaqfwbztxcf7vzpmsv5rc@knbau5ucdigs>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yRktqfpg;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="SMmC2/i8"
X-Spamd-Result: default: False [-2.82 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.01)[87.25%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 180136AD6B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_030844_316758_1E87DF69 
X-CRM114-Status: GOOD (  14.78  )
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

On Tue, Mar 05, 2024 at 09:38:41AM +0000, Shinichiro Kawasaki wrote:
> On Mar 04, 2024 / 17:13, Daniel Wagner wrote:
> > The re-authentication is a soft state, meaning unless the host has to
> > reconnect a key change on the target side is not observed. Extend the
> > current test with a forced reconnect after a key change. This
> > exercises the DNR handling code of the host.
> > 
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> 
> This looks a good improvement of the test case. I have two comments:
> 
> - The commit title says nvme/048, but it should be nvme/045.

Indeed :)

> - The helper functions nvmf_wait_for_state() and set_nvmet_attr_qid_max()
>   are exactly same as those in nvme/048, aren't they?
>   Probably, it's the better to move them to nvme/rc, as a preparation patch.

I forgot that we already had those two helpers. Sure, will do.

