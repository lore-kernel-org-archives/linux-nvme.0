Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04D7C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 00:20:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F21F23B54
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 00:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F21F23B54
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hX/APA93brUshZanjiKfWmPwJP8hBVLKv91FwglBnQA=; b=HjBcTsPjx2ow78EiW/YFOQzWc
	NGofJysdZ421AKKx/bJNW6vb9FiZlnVNSNoRrNtzt5Xug9o39ExV3k+Yjfo8RbGv9ahBAXxgsIu4h
	JeDxI4B4p0JZeFNaGcoIf5iUJfccN0Rw8bPxzdxRoA44vWIPbQpxU9Y+AFz0tqdg+LbdGcP/DGW8+
	aQDDjIW9WU5LFbVOYnrGUVA7ag4nXNujoEP7RXpSUB9CZA7QyS4zzeZJjmIIbbbMpapZLm7+e+/Gx
	WXZy2RjcwCOhckS4+AWQlpcL3TN60v4XqKBokoTmZZBNW9BMYwwrBBL1b2Fro5ZChOQcPmjV1D2/u
	7xCDJNLUQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmnDG-00071f-MR; Wed, 09 Dec 2020 00:20:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmnDC-00071K-VW
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 00:20:08 +0000
Date: Wed, 9 Dec 2020 09:20:02 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607473205;
 bh=Du80mT+RRgqL2DLjDKUW47IjTmqVg5VjQt5MJyztj7w=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=UmhRhgqmlUPYM79pqevmbs04yKuD/3X34jcm4PA5otx0u4t5OevfAAptlEdugYOCk
 H/bU6RDMaXaoFZEfBNvW3jtYE9GBGI8m1uc6EOBfOkF+tnz4Oq+/nD4y9TqTIZLdDe
 BhX7zxQwKS5p8s4qhgx5P4tZJ/GCk49QjH/r30woD6fQ+btXP5sx4sr6aEykjAEeFB
 CHtmC7y2kntyIv6IYmyDHjSNCLG+4rDSw1aNepQBxWA+ROD38ajr/ngEsyh5YLHBLZ
 USBNZHmUOpz1c2pTQgxeWI/rbaiBNgeX5zvjSENPZaBhwfsOD/ava6lEuM1phANPgk
 EZI8e11mAD93A==
From: Keith Busch <kbusch@kernel.org>
To: "Knight, Frederick" <Frederick.Knight@netapp.com>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Message-ID: <20201209002002.GA28830@redsun51.ssa.fujisawa.hgst.com>
References: <185CE0F5-617A-4446-A5C6-86A832D5A188@netapp.com>
 <DM5PR0601MB362496D2C29A18B3B1B77A61F1FC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201207152532.GA4527@lst.de>
 <DM5PR0601MB362473E145AC665C0DE96286F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208174033.GA27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB362465A52C0B59002A0867F4F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208183444.GB27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB3624104F7CC63DF394AD0772F1CD0@DM5PR0601MB3624.namprd06.prod.outlook.com>
 <20201208214650.GF27155@redsun51.ssa.fujisawa.hgst.com>
 <DM5PR0601MB36241CA22888CE6A6C66A702F1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM5PR0601MB36241CA22888CE6A6C66A702F1CC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_192007_140129_2537BF7E 
X-CRM114-Status: UNSURE (   6.97  )
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
Cc: "George, Martin" <Martin.George@netapp.com>,
 Hannes Reinecke <hare@suse.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "Meneghini, John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Dec 09, 2020 at 12:07:08AM +0000, Knight, Frederick wrote:
> If you want to make that a transition, then bring a TPAR to change it.
>
> When ANA Groups are created, they already have a state.  There is NO transition; there is NO AEN.

The requirement doesn't even mention the word "transition", so it's a
moot point. The requirement says "upon entry". Whether that entry occurs
because of a transition to it or because it sprung into existence
already having entered that state is not a disticition made in the spec.
If you want that disticition to be written in spec, then feel free to
bring an ECN to clarify it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
