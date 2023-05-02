Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30F8C7EE21
	for <linux-nvme@archiver.kernel.org>; Tue,  2 May 2023 13:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cVyGvuVej8o6VtC2kw0WOrsF91VmhITkrYcbcgb8tfQ=; b=QUB6yJngO9/AfxH99B8whxz8Ev
	cSCbJh/CEPwPBKChZLxRceEOFbeqp1ncgqPTs6fYw8+h0wPNFQ3GgGihL3zJeJNk5+eplKDSMBi63
	d/pvn4lTgOXMEHcRJr24L/cF6Af34PNcw7PVvLNEH3N8PF0lR27giy8LQcy+5cs/Tiv77Ko6Q7JVz
	hBYHhBg5FlVHE5un232Eciz11QI49rPwTQg/OWoThK5Lb+2Vmpy0ZbcfkiiEqHlQOi8FTrk5CLgvH
	c5SAcrlTvudrz/c2ZaFP5Xskw6HlbnXj93lNindNnFYoP811RXkthZLS0JjVenjTjZbsO9WHyWN8U
	0aCT/ySQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptpyI-001auY-1c;
	Tue, 02 May 2023 13:23:10 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptpyF-001atu-0X
	for linux-nvme@lists.infradead.org;
	Tue, 02 May 2023 13:23:08 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E03531F8C4;
	Tue,  2 May 2023 13:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683033785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cVyGvuVej8o6VtC2kw0WOrsF91VmhITkrYcbcgb8tfQ=;
	b=DXWmvcU5Q9/vNjjgtDZTV6BiwPTBJb5GnDIkXZm5QbBCHynsVtsWmyPltOV1SBP2++OVsB
	8YmYzhsLUlKe//up2w3THeNhHZHdeRPA92TPRYec3ldnbP7id5SDIlJBL+WBJ5m+GncNVA
	Tn057kkhxPy3PD/WR63QQflh02t6ibc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683033785;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cVyGvuVej8o6VtC2kw0WOrsF91VmhITkrYcbcgb8tfQ=;
	b=xhYIpqPxD9R5VTPoYygRuVXNWWxm1z7Zyb4W8uD1N4Rhd2OlqIT70h+yZcI/+u6xH6/X7L
	Q5oBY1xQNs5kgoCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3B38134FB;
	Tue,  2 May 2023 13:23:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Tg+YM7kOUWT1WAAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 02 May 2023 13:23:05 +0000
Date: Tue, 2 May 2023 15:23:05 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 3/9] common-xfs: Make size argument
 optional for _xfs_run_fio_verify_io
Message-ID: <clh6gmnivvi5e4o7pzr3mxfale3vlymgepdntkjtvub4cazyvk@myovldb6bcnx>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-4-dwagner@suse.de>
 <le6qqxhkbdaacsifz4b3mody53gllg4rzhowm2j62y56y56y6k@pmlukhvwjw24>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <le6qqxhkbdaacsifz4b3mody53gllg4rzhowm2j62y56y56y6k@pmlukhvwjw24>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230502_062307_354559_10DEA30A 
X-CRM114-Status: UNSURE (   8.96  )
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

 > --- a/tests/nvme/035
> > +++ b/tests/nvme/035
> > @@ -32,7 +32,7 @@ test_device() {
> >  	port=$(_nvmet_passthru_target_setup "${subsys}")
> >  	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
> >  
> > -	_xfs_run_fio_verify_io "${nsdev}" "900m"
> > +	_xfs_run_fio_verify_io "${nsdev}"
> 
> On the other hand, this change for nvme/035 does not look good. It runs the
> test on TEST_DEV, which may take very long time without TIMEOUT config.

I'll add the nvme_img_size argument here instead (nvme: Make test image size
configurable)

