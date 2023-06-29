Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EC3EB64DC
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jun 2023 05:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mr0oU4NhKob01UeFwVavf20se+hNBMRNJXeZURlCBrs=; b=pB8azE8l8DaV2EX2uLInaMK51s
	n3dQxiVJXgW9DszlCPrqNqn/833N66wo/lAuXUuXoUd6n1JPruirD+frGJFgf/0UZscT4h7avz9T+
	TM2P6eipSbVgB6JNcBRGXiKDrTCPb1BJCQ4X29uUazItOCJv+YiXZ/DhvcPKL7ayII9vCuqKHYu6c
	9FMJiUTng9oS50vB8h+6pgAavC0bZzuIsNsxAu9yVjEturKfXSNHHsoRU5m8xR/gLf7Rg3C8X2ACz
	mJ9mIxyW2mekjNdaDyckOlX+KKCWAHnUXiAXepmsg/+7JjcCzR0cgZJ/KxKaFxjC27nFpX5RlKEW5
	wrWFCPcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEk7M-00HalC-2f;
	Thu, 29 Jun 2023 05:22:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEk7J-00HakW-2X
	for linux-nvme@lists.infradead.org;
	Thu, 29 Jun 2023 05:22:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AAFC567373; Thu, 29 Jun 2023 07:22:45 +0200 (CEST)
Date: Thu, 29 Jun 2023 07:22:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	ming.lei@redhat.com, brookxu.cn@gmail.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/3] nvme: ensure unquiesce on teardown
Message-ID: <20230629052245.GA16819@lst.de>
References: <20230628145814.1068653-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628145814.1068653-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_222253_988616_A83038A8 
X-CRM114-Status: GOOD (  11.56  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 28, 2023 at 07:58:12AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The reset work is called on quiesced IO queues, so ensure these are
> unquiesced after a failed reset to flush out any pending requests.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

