Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127D9C74A5B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 06:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gg20VuxotjIBrApcqYsHTz75BAKs5arxadou0gRz/c4=; b=swrGZstjjj9A4ILOHVAqQzDkTc
	N0sYWf2IfB9yWCyCN3+yrd8syF7feEDpkBLvYC1k0hFpvApJIqvhDC6S6+EKABWcgD/Ndbc4Hel3R
	Bg95TedNmT7UW76ksvLHaIrQLyVWmN/rdpnsiJHnO8VrFbnEbQiGe5z3Up/HAmRiNZ9sw2g4njA6e
	stB8+7c8Q8/LzqDZ8aBBJgP9H1Vus08DDaK0MdD+dcy3IeLQUmSS04bqrTDzshWd1i9C1+++iKCg8
	leVg8VsCBl7cAu8aGV69ioHUUhfLk7dMdatoY50Ve5cXWrMXrg08x8ktFGlbqOpSmGBg/jnEyZTe4
	BxWCDgGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phPG5-00Gnny-02;
	Wed, 29 Mar 2023 06:26:09 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phPG1-00Gnmb-3D
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 06:26:07 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 868091FE31;
	Wed, 29 Mar 2023 06:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680071160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gg20VuxotjIBrApcqYsHTz75BAKs5arxadou0gRz/c4=;
	b=SrbO0Tz9m0noLJPnRR10xf0Fq5bDbC8bq7OrKWb9CLoy/Mm8m4NBQuy37rf3G9VdB86C3c
	HV/m5+H4KxuGAO2o0x25RX3wrDsHqYO7kETddYADnE3vwTLEifA74Jhay746h0p5HLjdVc
	RzNxKSB6rn87/R/kLvloMJeIgY2aP5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680071160;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gg20VuxotjIBrApcqYsHTz75BAKs5arxadou0gRz/c4=;
	b=KlfZjoClu3k1HvaT9iLgT0TlbdxDOhwaywF2a3mzObtwau3ZWd2S0TB6xjElsbmN9U0fxO
	C3Rztw45+Ym5fRBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63C70139D3;
	Wed, 29 Mar 2023 06:26:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WE9NGPjZI2SRHgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 29 Mar 2023 06:26:00 +0000
Date: Wed, 29 Mar 2023 08:25:59 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests v2 0/3] Test different queue counts
Message-ID: <20230329062559.k4qltulx4oldx3pa@carbon.lan>
References: <20230322101648.31514-1-dwagner@suse.de>
 <ZCMzjVs26imnywgo@kbusch-mbp.dhcp.thefacebook.com>
 <6dcf501f-8863-b448-01fa-1252e73a87f5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dcf501f-8863-b448-01fa-1252e73a87f5@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230328_232606_193884_961340F7 
X-CRM114-Status: GOOD (  17.61  )
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

On Wed, Mar 29, 2023 at 03:30:17AM +0000, Chaitanya Kulkarni wrote:
> On 3/28/23 11:35, Keith Busch wrote:
> > On Wed, Mar 22, 2023 at 11:16:45AM +0100, Daniel Wagner wrote:
> >> Setup different queues, e.g. read and poll queues.
> > If you wanted to add a similar test for pci, you do it by echo'ing the desired
> > options to:
> >
> >    /sys/modules/nvme/parameters/{poll_queues,write_queues}
> >
> > Then do an 'nvme reset' on the target nvme pci device.
> >
> > I'll just note that such a test will currently fail, and fixing that doesn't
> > look like fun. :)
> 
> then we should definitely add it ;) ha ha.
> 
> I was actually wondering about pci based on the discussion on this thread
> was mainly focused on tcp and rdam, thanks for the suggestion Keith.

The test is fabric centric because we configure the queues via the 'nvme
connect' call, something we can't do for PCI. It look likes it needs another
new test for PCI. Let me get this one sorted out first though.

