Return-Path: <SRS0=peCB=2B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812BAC43603
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 02:35:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FEB82073B
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 02:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ca297zlT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FEB82073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vVbW3FEAw7nw2jSuB4No6Q/rbVtDhFnApuqpFYsqwss=; b=ca297zlTIZNZdG
	xWzub9rENEWdnt9jn/M502dIuJJe6Il4K9MFPxzU41cpTIweMot0dgZ/pHYYZ+mlR2v34r5aWJUm7
	xjSqyqgzxrURb7PrjcjPztE+XIBikDPkWyNh3H9m9AkNAPakwnZIGZN2z+vAvJwzi7jyVQKDhj0tT
	27gox/a53QLCWtK9H6lDwtqKji9WwDfDNHU98BPGIVhUWrKb4PxLbL+8KkPbCIQJvJhjaYR2h3Y0v
	EjHIbS9KAltgWoO/FSYOEg4tftxhuZ5k1i9PqhlJgSZYshtARgRNOOo+il/Rxw4lB3KZeid94qjWj
	1a7R/7ed6+PUo9qGkWHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ierq7-0004lm-Nd; Wed, 11 Dec 2019 02:34:59 +0000
Received: from mo-csw1514.securemx.jp ([210.130.202.153]
 helo=mo-csw.securemx.jp)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ierq4-0004ky-Ie
 for linux-nvme@lists.infradead.org; Wed, 11 Dec 2019 02:34:58 +0000
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id xBB2YMFe019359;
 Wed, 11 Dec 2019 11:34:23 +0900
X-Iguazu-Qid: 34tMQJyII1go4Zgmp7
X-Iguazu-QSIG: v=2; s=0; t=1576031662; q=34tMQJyII1go4Zgmp7;
 m=ISw0x4fuHYyUyr3yEYu6Cb7tqY7Q8V2kAgcalyMrW6k=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
 by relay.securemx.jp (mx-mr1510) id xBB2YHDC026491;
 Wed, 11 Dec 2019 11:34:17 +0900
Received: from enc01.localdomain ([106.186.93.100])
 by imx2.toshiba.co.jp  with ESMTP id xBB2YG7s011965;
 Wed, 11 Dec 2019 11:34:16 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
 by enc01.localdomain  with ESMTP id xBB2YGIZ014826;
 Wed, 11 Dec 2019 11:34:16 +0900
From: <tsutomu.owa@kioxia.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <kbusch@kernel.org>, 
 <hch@infradead.org>
Subject: [RFC PATCH 0/5] to add more nvme reset functions
Thread-Topic: [RFC PATCH 0/5] to add more nvme reset functions
Thread-Index: AdWvyPOIQs9Y1uTsTWmA/qAYXNTemQ==
Date: Wed, 11 Dec 2019 02:34:15 +0000
X-TSB-HOP: ON
Message-ID: <346d379a5f9940dcba60242d2d9e119a@tgxml778.toshiba.local>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [133.118.176.119]
msscp.transfermailtomossagent: 103
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191210_183456_822697_D9406061 
X-CRM114-Status: UNSURE (   5.45  )
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
Cc: tsutomu.owa@kioxia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Sagi, Christoph, Keith,

This series of patch is to add support for nvme reset functions
described in NVM-Express specification 1.4 "7.3.2 Controller Level Reset" 
(conventional hot reset, link down reset and function level reset)
and "7.3.3 Queue Level" (queue level reset).

This series applies cleanly on top of linux-5.5-rc1. 

I'm still wondoring
	- if it's ok to export functions from drivers/pci.
	- if it would be better not to use CONFIG_NVME_PCI_RESET
	  and/or CONFIG_NVME_QUELE_LEVEL_RESET as these are noisy
	  and these features are based on specification anyway...
	- what is the best way to export nvme_pci_* functions in
	  drivers/nvme/host/pci.c to drivers/nvme/host/core.c.

Any comments would be highly appreciated.

It would be greate if this patch goes into mainline eventually.

thanks in advance.
-- owa

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
