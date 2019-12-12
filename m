Return-Path: <SRS0=hCdm=2C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C038FC43603
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 09:20:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F272214AF
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 09:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YZgaAoiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F272214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+0QcUgg+/LZy6dfckxK47MBb4YThOTrOVo+5oDgL8HI=; b=YZgaAoiW8IKWds
	1z61a9B5w1izWCoYJkkF5aIUsu0J/qEeCFDBeWmjIiIUI3uKJf8UenWIac3tg5olHYe+jeIU6kQSc
	WURBsQ4FYH19RKQ6T2Jxr/JklatnzGRI+WECCe9JNY0qdT+jdxKkIR6SlmPFB9Ykwmsa9fGWhvV32
	NQ7mTY3W5miprAb0cnPuSiRAG/BuagdgzDrzEoUaJT3OVrWBlLTsYH2qncLINqquQXlXCr07JFng6
	Ot9N/xA2WZzv/5yWiHXrbmhJcBQVnJzZCuyN4/LFeog4Mj42VZOq10BFWKlM4xGakiPFEQTlXxICI
	ckBF3DGC6gX9sMCuzOYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifKeH-0001PD-KY; Thu, 12 Dec 2019 09:20:41 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifKeF-0001On-1M
 for linux-nvme@lists.infradead.org; Thu, 12 Dec 2019 09:20:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3078268B05; Thu, 12 Dec 2019 10:20:37 +0100 (CET)
Date: Thu, 12 Dec 2019 10:20:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: Translate more status codes to blk_status_t
Message-ID: <20191212092036.GF2399@lst.de>
References: <20191205195730.5774-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191205195730.5774-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191212_012039_224307_B69E55BC 
X-CRM114-Status: UNSURE (   6.84  )
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
Cc: Hannes Reinecke <hare@suse.de>, John Meneghini <John.Meneghini@netapp.com>,
 hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Dec 06, 2019 at 04:57:30AM +0900, Keith Busch wrote:
> Decode interrupted command and not ready namespace nvme status codes to
> BLK_STS_TARGET. These are not generic IO errors and should use a non-path
> specific error so that it can use the non-failover retry path.
> 
> Reported-by: John Meneghini <John.Meneghini@netapp.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
