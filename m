Return-Path: <SRS0=1Z+t=GE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A09DC433E0
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Jan 2021 22:50:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2746521E92
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Jan 2021 22:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2746521E92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Z73tZ99jlf+AibT34G5o0vlvB1CKCrct2ayEM4VbTuk=; b=ZFKd59VDkyUoIhKAxFYdRAKfm4
	ZxKAy0pAZQF+0yZNmDBMWRTi19/Mjiyv9u4n9dsEwfe11jFeD/B494oz6HiuM3b7E96KxoUFpI/85
	h4mycJd7lWgB5xGbjqTsKc/HLaNvz/sLEg0NVG4cwNDteahwH8WAg/Nuv9p9snSob3GnlNY1phFqS
	WHY53LMD4TncwY9L8HUqHS9vVqel/yrH22q4GQ7zpbXdPr8sLSuoJYs7KBVdIS/MzKBxLwvyY+ZJh
	AjSn+v+Kf7MKwRdoSvNxhlU/YydCSAKUsOTZoc74M3/QJuA3PU5uVvtM/vPja5vjDl3KwGgRQ1mcv
	mPMe5aHw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kvTFh-000378-2m; Fri, 01 Jan 2021 22:50:33 +0000
Received: from hera.aquilenet.fr ([185.233.100.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kvTFa-00036Y-0V
 for linux-nvme@lists.infradead.org; Fri, 01 Jan 2021 22:50:27 +0000
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id B38AE53A
 for <linux-nvme@lists.infradead.org>; Fri,  1 Jan 2021 23:40:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jKhJY45jIlz7 for <linux-nvme@lists.infradead.org>;
 Fri,  1 Jan 2021 23:40:30 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr
 (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr [90.50.148.204])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id EF55DF2
 for <linux-nvme@lists.infradead.org>; Fri,  1 Jan 2021 23:40:29 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
 (envelope-from <samuel.thibault@ens-lyon.org>) id 1kvT5w-004f2m-Mm
 for linux-nvme@lists.infradead.org; Fri, 01 Jan 2021 23:40:28 +0100
Date: Fri, 1 Jan 2021 23:40:28 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: linux-nvme@lists.infradead.org
Subject: Are AER corrected errors worrying?
Message-ID: <20210101224028.4akud7meibjavvtf@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 linux-nvme@lists.infradead.org
MIME-Version: 1.0
Content-Disposition: inline
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210101_175026_173422_6C45F600 
X-CRM114-Status: UNSURE (   6.73  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,

Our lab has bought a new Dell Latitude 5410 laptop, I installed debian
bullseye on it with kernel 5.9.0-5-amd64, but it is spitting these
errors now and then (sometimes a dozen per a minute):

Jan  1 23:30:53 begin kernel: [   46.675818] pcieport 0000:00:1d.0: AER: Corrected error received: 0000:02:00.0
Jan  1 23:30:53 begin kernel: [   46.675933] nvme 0000:02:00.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
Jan  1 23:30:53 begin kernel: [   46.676048] nvme 0000:02:00.0:   device [15b7:5006] error status/mask=00000001/0000e000
Jan  1 23:30:53 begin kernel: [   46.676140] nvme 0000:02:00.0:    [ 0] RxErr

Since it's corrected it's not actually an issue, but how worrying is it
to see such errors on new hardware? Documentation/PCI/pcieaer-howto.rst
is not commenting whether we are really supposed to see some of them. I
see forums telling to use pci=noaer to stop the error logging, but is
that really something to do?

Samuel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
