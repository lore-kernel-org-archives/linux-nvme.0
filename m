Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA109C531DC
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 07:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8rDmBd9HLhTDJUrGMnLYVq8vzoOuYeZb7dst6tqcz9Y=; b=W3xERXBU8atWBoSM+3Hc1qdBQx
	KucmvK2Tn0//xvBtT4nhICesDrGKVhBQRnqmi8Bq91YrRyZsteDFXgo94QSa8TwqpRU8wslkT/ESh
	gklAOnph8eGX77weZWfcHT2idMbIiVRJiHnQrCOhp+9LbiVflXn/kcuF/PWhmYL0GmK3ayhRN1wwO
	3HvBRGfFQi43DWOuVWZvDMiuit8pabQi5YXQLrMp1QEfczvnVYNaLE+CXoEeeGk7HrmIq1sejv1xm
	0Y4nNLbzeAhI/dbCJeWkL9IWiTq5pl7cs6ZtLCeksHxUKraAptiQfEPoPBe5J+fNL+V66YL1lnAA0
	ItJZDazA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shOVg-0000000FbtO-08Uj;
	Fri, 23 Aug 2024 07:15:00 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shOOu-0000000Fa66-1aqM
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 07:08:01 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 088B31F770;
	Fri, 23 Aug 2024 07:07:59 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFCDB1333E;
	Fri, 23 Aug 2024 07:07:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id URfJNE41yGbecQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 23 Aug 2024 07:07:58 +0000
Date: Fri, 23 Aug 2024 09:07:58 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Martin Wilck <mwilck@suse.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] blktests: nvme: skip passthru tests on multipath
 devices
Message-ID: <faa71c11-94b5-4375-a645-b4eb5011ed75@flourine.local>
References: <20240822193814.106111-1-mwilck@suse.com>
 <d1282549-f037-4556-93f7-adb3d890db82@flourine.local>
 <1106fb07918468cb8cacb35ef0448573ec7be156.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106fb07918468cb8cacb35ef0448573ec7be156.camel@suse.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 088B31F770
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_000800_590411_EC192089 
X-CRM114-Status: GOOD (  15.03  )
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

On Fri, Aug 23, 2024 at 08:41:59AM GMT, Martin Wilck wrote:
> On Fri, 2024-08-23 at 08:35 +0200, Daniel Wagner wrote:
> > On Thu, Aug 22, 2024 at 09:38:12PM GMT, Martin Wilck wrote:
> > > +_require_test_dev_is_nvme_no_mpath() {
> > > +	if [[ "$(readlink -f "$TEST_DEV_SYSFS/device")" =~ /nvme-
> > > subsystem/ ]]; then
> > > +		SKIP_REASONS+=("$TEST_DEV is a NVMe multipath
> > > device")
> > > +		return 1
> > > +	fi
> > > +	return 0
> > > +}
> > 
> > Just a nit: what about _require_test_dev_is_native_multipath?
> 
> The intention was to require a device that is _not_ a native multipath
> device. Change it to "_require_test_dev_is_not_native_multipath"?

I confused mpath with dm-mpath when I read the function name. Doesn't
make any sence obviously but still got me confused. I prefer the more
explicit function name you suggested. But let's here what others say.

