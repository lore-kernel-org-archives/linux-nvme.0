Return-Path: <SRS0=qdm1=MO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0CEC4338F
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 21:00:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2BD960EB5
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Jul 2021 21:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A2BD960EB5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1uMroxtqg4Oyw1fmh6rR4jDhm8D2aBLm0A8DSa3Syq0=; b=TsAHbxA4StPEck
	atWiFGs38wS8W7mcH0sgLeOmsP4zTAFkxZ9edT5kSXx8J9bSOmnNEKrSwsvbz/JbpGCisY/feZPG3
	ls2h/ECivfj7yTaEWALKVMD3xYIBwxBy/QtmUUEL1Zg+PrXjFk3Zg728I1bQKIKG6kAMofFkA0GUk
	7JnbhV03ffUparXp/gmRI7rIPxEmAtvAjvFR+RAp+IJo7g03tikKBSukH53NFi9yBWJcHR8HCoBP7
	jr4BeOR+gg6MSHu3w2D+Mopc3ZN1j+Gy6zGSx0GaefuJnswQi7yQZrmjGYcZC9FshnupdmcDBBVA3
	uc+5+zQpZ3ua0lM/Gu6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6foG-002lMT-M1; Thu, 22 Jul 2021 21:00:48 +0000
Received: from zeniv-ca.linux.org.uk ([142.44.231.140])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6fo8-002lKY-AX
 for linux-nvme@lists.infradead.org; Thu, 22 Jul 2021 21:00:41 +0000
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1m6fj8-002yyA-IB; Thu, 22 Jul 2021 20:55:30 +0000
Date: Thu, 22 Jul 2021 20:55:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Boris Pismenny <borisp@nvidia.com>
Cc: dsahern@gmail.com, kuba@kernel.org, davem@davemloft.net,
 saeedm@nvidia.com, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
 kbusch@kernel.org, edumazet@google.com, smalin@marvell.com,
 boris.pismenny@gmail.com, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, benishay@nvidia.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, Boris Pismenny <borisp@mellanox.com>,
 Ben Ben-Ishay <benishay@mellanox.com>, Or Gerlitz <ogerlitz@mellanox.com>,
 Yoray Zack <yorayz@mellanox.com>
Subject: Re: [PATCH v5 net-next 02/36] iov_iter: DDP copy to iter/pages
Message-ID: <YPnbQvKgA8Fun9Ky@zeniv-ca.linux.org.uk>
References: <20210722110325.371-1-borisp@nvidia.com>
 <20210722110325.371-3-borisp@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210722110325.371-3-borisp@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_140040_408019_48A5F94E 
X-CRM114-Status: GOOD (  12.11  )
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

On Thu, Jul 22, 2021 at 02:02:51PM +0300, Boris Pismenny wrote:
> From: Boris Pismenny <borisp@mellanox.com>
> 
> When using direct data placement (DDP) the NIC writes some of the payload
> directly to the destination buffer, and constructs SKBs such that they
> point to this data. To skip copies when SKB data already resides in the
> destination we use the newly introduced routines in this commit, which
> check if (src == dst), and skip the copy when that's true.
> 
> As the current user for these routines is in the block layer (nvme-tcp),
> then we only apply the change for bio_vec. Other routines use the normal
> methods for copying.

Please, take a look at -rc1 and see the changes in lib/iov_iter.c in there.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
