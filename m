Return-Path: <SRS0=uiYz=4W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6ABC3F2CD
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 11:04:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D9C02073B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2020 11:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jdicydfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9C02073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PGj58ikX4Bo55Y16moJIpLGqw+MbOb4T1WMxyTfvtq8=; b=jdicydfSwaUKPs
	uDRsmpVQSkmnXJ/vZ17+fEfsT4DkoSMXDiYSskRm2EI+OTDRztdMEh8+/QdBGhpsNEQiI+GM0ngXH
	VbiTWQHZVizJwYaRlDfqjopCP00Y+CBLiBn6rts4/mqBHEcr/3GKLdxO+dCelUDGE/TNJnfhGeLUU
	TCF9En8Td/JJHcFHhRcmK3L9U8ynCwrMcP5ccrqsdE2ucN4cf3M049T6lSKcP0b/0CFkJcB9TSYYA
	QYhzcz093c06RwyTfdBczLlNOa2QA5cBz4Mem7wkq99mhFwionrJC3wlkJaIuJFe4Alf/Sde1wJm+
	fckXN9+m9JvPunVB3spg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9oJ1-0001Mv-GC; Thu, 05 Mar 2020 11:04:43 +0000
Received: from mo-csw1514.securemx.jp ([210.130.202.153]
 helo=mo-csw.securemx.jp)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9oIx-0001M3-Nv
 for linux-nvme@lists.infradead.org; Thu, 05 Mar 2020 11:04:41 +0000
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 025B4DCI005604;
 Thu, 5 Mar 2020 20:04:13 +0900
X-Iguazu-Qid: 34tKIIhGyyktrZlkUi
X-Iguazu-QSIG: v=2; s=0; t=1583406253; q=34tKIIhGyyktrZlkUi;
 m=qVuwNcuxOzDkksuSilLCPobt7vXxKE/1sSG+5jF+1CA=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
 by relay.securemx.jp (mx-mr1513) id 025B4BSt010847;
 Thu, 5 Mar 2020 20:04:11 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
 by imx12.toshiba.co.jp  with ESMTP id 025B4A3v016619;
 Thu, 5 Mar 2020 20:04:10 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
 by enc02.toshiba.co.jp  with ESMTP id 025B4Adf007560;
 Thu, 5 Mar 2020 20:04:10 +0900
From: <masahiro31.yamada@kioxia.com>
To: <hch@lst.de>
Subject: RE: [PATCH] nvme: add a compat_ioctl handler for NVME_IOCTL_SUBMIT_IO
Thread-Topic: [PATCH] nvme: add a compat_ioctl handler for NVME_IOCTL_SUBMIT_IO
Thread-Index: AdXwWtP+3uT/YWciSkKTlF+qgQWgkQBmYx6AADpE/zA=
Date: Thu, 5 Mar 2020 11:04:09 +0000
X-TSB-HOP: ON
Message-ID: <42c9a559129f4608b809a3fc093a1d6b@TGXML281.toshiba.local>
References: <c0d7091c43154d9ea7a978c42a78b01a@TGXML281.toshiba.local>
 <20200304161317.GA11268@lst.de>
In-Reply-To: <20200304161317.GA11268@lst.de>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [133.116.224.115]
msscp.transfermailtomossagent: 103
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200305_030439_990827_D90FEDB6 
X-CRM114-Status: UNSURE (   3.88  )
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
Cc: kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>This should not be exposed in the UAPI header.  I think it should just
>go into the #ifdef CONFIG_COMPAT block in core.c near the comment and
>the compat_ioctl handler.

Thank you. I tried to describe it.
Please correct me, if I am misunderstanding what you mean.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
