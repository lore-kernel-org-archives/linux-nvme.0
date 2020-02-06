Return-Path: <SRS0=EBwi=32=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C52DC33CAC
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Feb 2020 18:28:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EF3020659
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Feb 2020 18:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HmGs7nPq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="pnKe/KgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF3020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:MIME-Version:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=rRBFd5IYEtMbgRXv8AZxk1iLVAdcaYmalOfCFfNZcX8=; b=HmGs7nPq0TNJ4f
	qnOt5ziZq+PDkQEphyeazuxX5d7SVVQVY3KHtaiGCAzo07se+FpamhCzD2xhqr/yvQZrhTxAurGtC
	Do74uxThKZ5efUgz56wtZTtUQgbw9xWG/rCATdW24d67lU4ImKW2MuhKNtTyFcmuu/ZHM+myW5ef2
	yrF9/9q06ITJkLAjFp3qVOX5LdB+fg/BanxZSjVyTQNVZTe0SDk/HijQeKQ7GAIYlLN9xqFEKU1Kk
	KAI9JQsq5eQ95B1bD5V9Y/pf19+mLBDH1W0MAbsOnB5gXuKq5R/j1Tm5clfAACUaI/Kyh/aECEFx6
	XZTP2cOqBSZOMmoDiX5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izltF-0007ht-RG; Thu, 06 Feb 2020 18:28:37 +0000
Received: from forward105j.mail.yandex.net ([5.45.198.248])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izltC-0007h2-4l
 for linux-nvme@lists.infradead.org; Thu, 06 Feb 2020 18:28:37 +0000
Received: from mxback21g.mail.yandex.net (mxback21g.mail.yandex.net
 [IPv6:2a02:6b8:0:1472:2741:0:8b7:321])
 by forward105j.mail.yandex.net (Yandex) with ESMTP id 117EFB20CE1
 for <linux-nvme@lists.infradead.org>; Thu,  6 Feb 2020 21:28:28 +0300 (MSK)
Received: from localhost (localhost [::1])
 by mxback21g.mail.yandex.net (mxback/Yandex) with ESMTP id t8MYF2Q5yK-SR285CI8;
 Thu, 06 Feb 2020 21:28:27 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1581013707; bh=PC+alwCg+6LT4ZdapG18qDq0R3JEA21mdDgfirl2IJo=;
 h=Message-Id:Date:Subject:To:From;
 b=pnKe/KgYmsbzZEn8eiRoNlrf1ooQn2VJ63gNrbozy3q2/ureNHRAJchJwyb9+J0YT
 QEsGjZJqbAmHpTmVtphymfOw2mt99GC95EZxWQUldTcYrxYgM73mqXSb/Tzp7sx/aZ
 KF6tFEdANAdVE+OkbeFs2079kPRlaqO90e/mGa58=
Authentication-Results: mxback21g.mail.yandex.net;
 dkim=pass header.i=@yandex.ru
Received: by iva7-8a189d9308a6.qloud-c.yandex.net with HTTP;
 Thu, 06 Feb 2020 21:28:27 +0300
From: Talker Alex <alextalker@yandex.ru>
Envelope-From: alextalker@yandex.ru
To: linux-nvme@lists.infradead.org
Subject: NVMe/FC compatible hardware
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Thu, 06 Feb 2020 21:28:27 +0300
Message-Id: <5657351581013707@iva7-8a189d9308a6.qloud-c.yandex.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200206_102834_509923_0395DFE6 
X-CRM114-Status: UNSURE (   4.91  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

Could anyone kindly clarify if NVMe/FC Linux drivers would work with any FibreChannel HBA?

I've connected ATTO Celerity FC-162E and ATTO Celerity FC-82EN cards(on subsystem & host respectively) and successfully managed to setup a port
but I struggle to connect to it, issuing the following command:

> nvme discover -t fc -a nn-0x20000010860370a4:pn-0x10000010860370a4  -w nn-0x2000001086036870:pn-0x2100001086036870

I get this error:

> [4164487.114514] (NULL device *): queue 0 connect admin queue failed (-111).
> [4164487.114519] nvme nvme0: NVME-FC{0}: reset: Reconnect attempt failed (-111)                                                                                           
> [4164487.114522] nvme nvme0: NVME-FC{0}: Reconnect attempt in 10 seconds
> [4164487.114535] nvme nvme0: NVME-FC{0}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
> [4164487.114672] nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"

and nothing on subsystem(controller?) side.

I expect that if addr_tractive attribute of the port in ConfigFS equals 1, it means that selected port/HBA capable in utilization for NVMe-oF.
Am I wrong in that too?

Would anyone kindly provide hardware list where the FC driver works properly?

------------------
Best regards,
Alex

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
