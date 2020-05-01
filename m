Return-Path: <SRS0=VrRv=6P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94011C47253
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 14:24:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6D720836
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 14:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fDni51cw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6D720836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QbcPFYHet1a3L6EmIQcp8t3waVuRq9O18PlvoSFRISE=; b=fDni51cwXD9GQo
	7Kjn6Jr6yIqbCv6G6ttG4r1i3QVg2mZfx5LytxkLCXsm1iP67XyKR64vbCzxuWeIDOoI3h7x8FFwL
	PVtQ7VzhdoWGJY/Vl/6T1lb1d6Iw07znfMvnrdPpcVSe4uwV54wC9NeOJAP/BKzT1aEwsMDBd3pnv
	AkTikEITI1R+sv+6E8kxTpIH1AfoVa5Stb/xJfcVMqc75Zclp72TGxFn7cEgxVfByE/mrxZfeEYON
	oRXfq0NaZPqVBGDk8y/OMFRrEsgPL6PZGA+O/BzFv/yDiOv8LCqR9JVPR7hYN5B8mFSMonwh3/dD/
	3j9nCMjEF+0Ki+a99DGg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jUWaG-0003Ql-5Y; Fri, 01 May 2020 14:24:08 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUWaD-0003Pn-KE
 for linux-nvme@lists.infradead.org; Fri, 01 May 2020 14:24:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 66C4A68BFE; Fri,  1 May 2020 16:24:01 +0200 (CEST)
Date: Fri, 1 May 2020 16:24:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 01/15] nvme: introduce namespace features flag
Message-ID: <20200501142400.GF7197@lst.de>
References: <20200428131135.211521-1-maxg@mellanox.com>
 <20200428131135.211521-2-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200428131135.211521-2-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200501_072405_813378_F7860C3C 
X-CRM114-Status: UNSURE (   4.51  )
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
Cc: axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
 martin.petersen@oracle.com, shlomin@mellanox.com, israelr@mellanox.com,
 vladimirk@mellanox.com, linux-nvme@lists.infradead.org, idanb@mellanox.com,
 oren@mellanox.com, kbusch@kernel.org, nitzanc@mellanox.com, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VGhpcyBzZWVtcyB0byBicmVhayBsaWdodG52bToKCmRyaXZlcnMvbnZtZS9ob3N0L2xpZ2h0bnZt
LmM6IEluIGZ1bmN0aW9uIOKAmG52bWVfbnZtX3JlZ2lzdGVy4oCZOgpkcml2ZXJzL252bWUvaG9z
dC9saWdodG52bS5jOjk2NDoxNTogZXJyb3I6IOKAmHN0cnVjdCBudm1lX25z4oCZIGhhcyBubyBt
ZW1iZXIgbmFtZWQg4oCYZXh04oCZCiAgOTY0IHwgIGdlby0+ZXh0ID0gbnMtPmV4dDsKICAgICAg
fCAgICAgICAgICAgICAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52
bWUK
