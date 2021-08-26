Return-Path: <SRS0=DYpX=NR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37BFC432BE
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Aug 2021 21:50:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98E3C60F39
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Aug 2021 21:50:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 98E3C60F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=h1OfcEdn7fJBobe+395mn404E7Aqh+bzbKvcgT0HIXE=; b=1y+l3yNWV1fptG
	ysgWk5SyFMlHYSFGf/Yi0LkpTsuUcvRAGMxXTc8KHSUVfOArUpfCIGq9fEuHHzJoKS9MJAiNLYlPz
	Nfx8ln0OfGsngzbFk/ie47StUU/3AW9u8O78LrnIgMaIG5FhRcWXCgr+qY5DHRyIbsi4kVJYoNGgM
	6PwVOTxzt9ePw8YKJUwBzS4zq4fczQFizYHWdJINV3dMRrTvPzi2Tz0HD8gLLG4HCPDxrIbe0oziB
	QvlnW2Ar39zqaYRfTDTG76gb0sSaSuexMZhxu3Hh7b50PqMWEhhVAydgvW2KM4d3QYz+XE0aWt4vH
	QTr8fufIB4fsbCT9sSWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mJNGG-00AyHT-Oj; Thu, 26 Aug 2021 21:50:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJNGE-00AyGw-66
 for linux-nvme@lists.infradead.org; Thu, 26 Aug 2021 21:50:11 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32AF760F4A;
 Thu, 26 Aug 2021 21:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630014609;
 bh=hC7ZzrqCtbXGsVzPqLaOoa81+2MI7Xu6zHkd5OCUP/I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A8bgQG2VYWIjLv0SfzTNOe802IG8Gezo89RDmoqzG06mPTpEceRga82osrD2gHJMX
 R51NfJjRl95hoyX0zozzbws9S2D8WK/QUbZ0BbJuO2J6e7bhw5wRouyQn2GvecLgA4
 tkavCAPhKLXALgnnGAxuPXKE6vAW7kS8nd34jgLe89aKR5F/kq4wuGHLw6JPS2Lqam
 0BXO5/G30cyU2MPp0o2DU38/C3Dc1kdV0JCqwG1CfqPDKPa5USZH4xpvJYmpM7pSCY
 WoST8Utu/YGjiNNXkCwDczUUcYwuUdqk5Y8VELPPbV1wQvgOeOoSC55XzpZ/rmecx2
 6heM9gGC4xhxA==
Date: Thu, 26 Aug 2021 15:50:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Adam Manzanares <a.manzanares@samsung.com>
Cc: "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Make nvmet_init_cap dependent on passthru controller
Message-ID: <20210826215007.GA58085@C02WT3WMHTD6>
References: <CGME20210826211546uscas1p1fc876392e5aaf990eeb480cc74508852@uscas1p1.samsung.com>
 <20210826211522.308649-1-a.manzanares@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210826211522.308649-1-a.manzanares@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210826_145010_290319_EC5717F7 
X-CRM114-Status: GOOD (  11.29  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 26, 2021 at 09:15:45PM +0000, Adam Manzanares wrote:
> nvme_init_cap unconditionally sets support for one or more command sets. When
> using a passthru controller this may cause a conventional namespace to be
> ignored when checking the namespace identification descriptors which must
> include the command set identifier when the cap is set to support one or more
> command sets. Since the namespace identification descriptors come from the
> passthru controller they may not include the command set identifier causing the
> namespace to be ignored.
> 
> Adam Manzanares (2):
>   nvme: move nvme_multi_css into nvme.h
>   nvmet: use passthru cntrl in nvmet_init_cap

Looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
