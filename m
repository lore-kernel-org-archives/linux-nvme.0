Return-Path: <SRS0=+gr8=AS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,TVD_SPACE_RATIO,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D278C433DF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 10:55:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E688206DF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 10:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yt+SzeCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E688206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SmS6hiQHxps+3lUjMAuDXmKFbNXA3of4Pkkxg527Q/U=; b=Yt+SzeCMibMkpyStI7cr//wmC
	O/HlAEdAp8lSD17CyxQxMBiJtTf61SitT/V/2VnaJHXP8pzC80TgPa5nQj6EtCmUtfJm6olwpXphD
	NTzyfpPzkQ1BZ7lmYIBHPndmCWxR8jSnNK80uIIL90jUdI9bJQ+qXCPX0Lrf1yYGGXa1h0S/VCcSj
	nJedVcXpKPajg95tB29BoPL/fG8SLUxi4aUFxEdu3vAPEzNW1ZCtHksEW5OaBolrIgbQ44g1Tu3MT
	wdTY15C9fkarPDHZm5yffLes3EVuvdNnstxvG3hZKlx558G/KSmkIi1ql4gr5W2LJFRK8FcyQYsCi
	mrF5MCA8A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jslGO-0000vp-UZ; Tue, 07 Jul 2020 10:55:48 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jslGM-0000vH-Fc
 for linux-nvme@lists.infradead.org; Tue, 07 Jul 2020 10:55:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7869968AFE; Tue,  7 Jul 2020 12:55:43 +0200 (CEST)
Date: Tue, 7 Jul 2020 12:55:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: kernel test robot <lkp@intel.com>
Subject: Re: [linux-nvme:nvme-5.9 34/40] drivers/nvme/host/core.c:3567:1:
 sparse: sparse: symbol 'dev_attr_ctrl_loss_tmo' was not declared.
 Should it be
Message-ID: <20200707105543.GA4560@lst.de>
References: <202007071822.30Odtc0k%lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202007071822.30Odtc0k%lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200707_065546_652140_ECA9D7B0 
X-CRM114-Status: UNSURE (   5.26  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: kbuild-all@lists.01.org, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Fixed and force-pushed.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
