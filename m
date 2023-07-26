Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAF4C001DC
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 13:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2if9p+B6BuL4mtV3qXiIFZTjSWKgfp4gTVZLOBeCfsI=; b=itB6CywDLXHCP2Tn8SZ6dRBolQ
	RdqUHwzvZGY1A3JVnYZVxiDohWAPaGzv5dctDAY4jpsyaJoLFCPI+ZWdkerLlhVcdDFapLd2mxzKo
	QYp/q66WWVEkzll4xe2v2YLOrVIF957iWx7c17cxzbt+h7UDosVbpodJnRvB65uvAkvaNgJ9M8EKw
	7c3VKnkFjdkU5JtLfyNlF8S8A0cPde7J8fc2arJXePPimgZQZy7X/c02cGV7pGaWF2OJ7eqMqzPn8
	Jh910XDA3aA4lB9ZO0NYbJN/s9tVYKrtZCiBfYpyjgiLhLeRJNjBTFzMOePZzfQO3Eg1PsRzM8Zwq
	2MB3UKJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOeNm-00AVnX-2n;
	Wed, 26 Jul 2023 13:16:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOeNj-00AVmO-1M
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 13:16:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 13CEE6732A; Wed, 26 Jul 2023 15:16:44 +0200 (CEST)
Date: Wed, 26 Jul 2023 15:16:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Guangwu Zhang <guazhang@redhat.com>, Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: stack smashing detected with 'nvme sanitize-log /dev/nvme0'
Message-ID: <20230726131643.GA16186@lst.de>
References: <dckvq3ohgqdkxg7wz4vslf36gaivgldl742vew67oyh2buj5nr@7ypn5ydt6kss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dckvq3ohgqdkxg7wz4vslf36gaivgldl742vew67oyh2buj5nr@7ypn5ydt6kss>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_061647_602295_0F453A31 
X-CRM114-Status: GOOD (  19.52  )
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

On Wed, Jul 26, 2023 at 01:52:04PM +0200, Daniel Wagner wrote:
> FYI, I got a a bug report [1] with a 'stack smashing detected' when running
> 'nvme sanitize-log /dev/nvme0' on Debian. Originally, it was reported against
> udisk. udisk recently added libnvme which does now a sanitize-log call, so this
> problem might exists for a while.
> 
> We figured out that an older kernel such as 4.19.289 work but newer not (it's a
> bit hard for the reporter to test all combinations on his setup due to compiler
> changes etc.).
> 
> There was a bit of refactoring in v5.2 which could be the cause of the stack
> smash, because saw this recent fix:
> 
>  b8f6446b6853 ("nvme-pci: fix DMA direction of unmapping integrity data")
> 
> [1] https://github.com/storaged-project/udisks/issues/1152

If you think it is related to DMA, there are good ways to check for:

  1) force that an IOMMU is used for this device
  2) hack nvme or the blk-map code that we never do the direct mapping
     to user space but do the copy based version, and then enable
     all kernel memory debugging helpers, most importantly KASAN

