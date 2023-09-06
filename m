Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC03EB8FAF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Sep 2023 08:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eBNWBZeFhh/iXD8952Q1ruU9rljb6K7/zzx/5z/MaMY=; b=AiqkZLIPRrFQL1rwPNc7COYIBA
	KdL3GVB/z2H4rZ5bLboyF+3Xm/lmwWU03USar4CbOYWz3ap9xeEgQJFcToQQ+7zdNkbUKg2NHCCDk
	3AzYUfb28OZ5oQryfAlfSHS2PiRJ1vrCuJcDzHFqttJb3RhqB4aTPtVJHYENCvtt5Gy/0Ba1jiRtX
	/OLt5WM4LkmBQ0+gi8aKt5m1jWIBXx5TSpYo+lYcCtzApfYOeaj582ImbtBEUEj/vmu2LYpvwUnJk
	wyn/KjgJLdVocrmlP3bZGa6QGQ6TSHjQkLd8lWhf5ue/r1zoid2YEEBy3Su7tQAd7z21bHNS8af/W
	Q6jU95YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdoJ5-007ojD-0W;
	Wed, 06 Sep 2023 08:54:39 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdoJ2-007oik-2s
	for linux-nvme@bombadil.infradead.org;
	Wed, 06 Sep 2023 08:54:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eBNWBZeFhh/iXD8952Q1ruU9rljb6K7/zzx/5z/MaMY=; b=CMko+TpLMNlsnrDUhO/98zvK+O
	gSuW0CvrEAgJV64oBSp4qeWBQIqfEzfcF0PUK0Xwq050S0H/zw6NjMnq175H6QB771RLg0dPoT2HP
	MnC2HgQ92hM39j4cc1c7w4W3c0hjhYFf0BpmIJfJ3+f5tE30CTikUAqAkhoupBmWXtuNRc+eT3Iw4
	TFD4cn3El11esPBUELupjYYWRryMEgmi0C5UgbwoR8JMRUD+UnG9mL0CvsjPpJ3iOdCVPgTdkcxG4
	T8dRwnZHPmr8FNiTW3sy0pcBEi36ecj+Xwef7OmYR3Pnq24Qs80FOTbl9zLwreqpOD2I6BLJvWGJ9
	xpdObNIg==;
Received: from smtp-out2.suse.de ([195.135.220.29])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdoIu-000zkr-2k
	for linux-nvme@lists.infradead.org;
	Wed, 06 Sep 2023 08:54:35 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 407DE20293;
	Wed,  6 Sep 2023 08:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1693990467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eBNWBZeFhh/iXD8952Q1ruU9rljb6K7/zzx/5z/MaMY=;
	b=UdfAi9hzXY8TguA04qmRopOyjQZYTtcdBFrtUa3d3I93HU6DFe0T9QwBB6VHl9LBg+mGA3
	pV/JV2dC+BtQ6H5tucZmQUktdRHaqe/iFOo/oJq5eyCtY4x48zSWnz5q9yYjmlQshzjB/Z
	6V/XjhI0nBHq/I95xoiUsZ1kb8xCl4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1693990467;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eBNWBZeFhh/iXD8952Q1ruU9rljb6K7/zzx/5z/MaMY=;
	b=ujhp3XYwi8qSAbTfM2maftWVW6Jsg4Qe+i903Cj0bPyD2+HZV/cQKOVcWn2hOTZ27UZxfG
	KMnVCYen088ucjBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3235F1333E;
	Wed,  6 Sep 2023 08:54:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id loA7DEM++GRGeAAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 06 Sep 2023 08:54:27 +0000
Date: Wed, 6 Sep 2023 10:54:56 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2] RDMA/cma: prevent rdma id destroy during
 cma_iw_handler
Message-ID: <sqjbjg7cwcpjx6yn7tmitx6ttxlb4pkutgfbhdgxa2hi4hy6wp@ek7z43bwtkso>
References: <20230612054237.1855292-1-shinichiro.kawasaki@wdc.com>
 <ZIcpHbV3oqsjuwfz@ziepe.ca>
 <3x4kcccwy5s2yhni5t26brhgejj24kxyk7bnlabp5zw2js26eb@kjwyilm5d4wc>
 <ZIhvfdVOMsN2cXEX@ziepe.ca>
 <20230613180747.GB12152@unreal>
 <iclshorg6eyrorloix2bkfsezzbnkwdepschcn5vhk3m2ionxc@oti3l4kvv4ds>
 <ZIn6ul5jPuxC+uIG@ziepe.ca>
 <l3gjwsd7hlx5dnl74moxo3rvnbsrejjvur6ykdl3pxiwh52wzp@6hfb4xb2tco3>
 <g2lh3wh6e6yossw2ktqmxx2rf63m36mumqmx4qbtzvxuygsr6h@gpgftgfigllv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <g2lh3wh6e6yossw2ktqmxx2rf63m36mumqmx4qbtzvxuygsr6h@gpgftgfigllv>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230906_095432_733121_4599E58F 
X-CRM114-Status: GOOD (  12.53  )
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

On Tue, Sep 05, 2023 at 12:39:38AM +0000, Shinichiro Kawasaki wrote:
> Two month ago, the failure had been recreated by repeating the blktests test
> cases nvme/030 and nvme/031 with SIW tranposrt around 30 times. Now I do not see
> it when I repeat them 100 times. I suspected some kernel changes between v6.4
> and v6.5 would have fixed the issue, but even when I use both kernel versions,
> the failure is no longer seen. I reverted nvme-cli and libnvme to older version,
> but still do not see the failure. I just guess some change on my test system
> affected the symptom (Fedora 38 on QEMU).

Maybe the refactoring in blktests could also be the reason the tests are
not working? Just an idea.

