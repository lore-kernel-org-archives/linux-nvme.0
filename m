Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2176ECAAD2
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 07:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1d+1CW7iGn/kfXeiiD6H7BSnpSLFLax05WElNSSyCpg=; b=V25QvI5sVXbi+ePomdhTYReVPk
	GUjiI1djisVfg0yyHXUAO8tUXKcFTPdKBpqgt1C5kcflaa34T4OMZOAuUlQl0AcODZ2jCiohA0MUF
	ozHNRfxAGQHG7+K4pg6IxNYfBxT+A1RePibYZiPs86vjAUugkLSWiG6HRSLQjH2t9JBb5mQOU3PGI
	x0ZURWiQ06ES4niJ7cXm2o4elDcwEkFvQiKu7AzaC2hjoB98WDAEH0mlu+gTZw+1xoDoArhxhc0x3
	3gy2qq7cY4Q8j+WTTC2eW6pmsQGfcBC120cLut0JFCUZQgYP8EooAEtIviNu1PT66pJy3w0/YyZvu
	3KsgH9+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSZTj-005ncj-0r; Mon, 29 Aug 2022 07:46:39 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSZTX-005nTR-3l
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 07:46:31 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 46A8D1F8CD;
	Mon, 29 Aug 2022 07:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661759177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1d+1CW7iGn/kfXeiiD6H7BSnpSLFLax05WElNSSyCpg=;
	b=emP7ZH4F8AoFVBVvKBO0SVmHyJzsP2kMjCYHUUM6Wyd50ktp6K7pIjZx0EFqGjvfxazrB6
	tITV0wGSn6KkWpjdHzlB4mraPNtJpL4TA4pl0MNmZvxluhg5UpQnkNTRtQ38oksueXDOFW
	/IwfZTP3LkOSeRI2z6p5vnguGoEIZeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661759177;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1d+1CW7iGn/kfXeiiD6H7BSnpSLFLax05WElNSSyCpg=;
	b=T4bvVlvB80phtEBaVIs4C5Hpw9az3ZNEVZH24QbhM3RAHDKKeDSykBY/21j4lPaI8XDArX
	U0PShEycRC1/GWCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 37A07133A6;
	Mon, 29 Aug 2022 07:46:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id C/JWDcluDGPSdQAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 29 Aug 2022 07:46:17 +0000
Date: Mon, 29 Aug 2022 09:46:16 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 2/3] nvme-tcp: Handle number of queue changes
Message-ID: <20220829074616.czv6uyxkpy7b6tbl@carbon.lan>
References: <20220823074451.12170-1-dwagner@suse.de>
 <20220823074451.12170-3-dwagner@suse.de>
 <840dab46-6cdd-1204-3642-2b67d04cd212@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <840dab46-6cdd-1204-3642-2b67d04cd212@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_004628_284595_4B5505AE 
X-CRM114-Status: GOOD (  12.77  )
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

On Sun, Aug 28, 2022 at 03:25:09PM +0300, Sagi Grimberg wrote:
> > -static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
> > +static int nvme_tcp_configure_io_queues(struct nvme_ctrl *nctrl, bool new)
> 
> Lets not change the name here, it creates some churn...

Sure thing

> 
> >   {
> > -	int ret;
> > +	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
> 
> Why do you need the tcp ctrl?

Because I was blind and didn't see ctrl->tagset ...

> > +	if (ret)
> > +		goto out_cleanup_connect_q;
> 
> You need to go to out_wait_freeze_timed_out as IOs pending have
> possibly restarted with nvme_unfreeze...

Copy & paste error.

Thanks for reviewing!
Daniel

