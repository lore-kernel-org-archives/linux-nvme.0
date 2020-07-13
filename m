Return-Path: <SRS0=Gozd=AY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074E6C433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 07:42:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9AA320674
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 07:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xt9R+te/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9AA320674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=74KSDC6H8ldcoCo5DSGh34sf6A2aqyI4HckcBzFGu4M=; b=xt9R+te/jpkbk5lwY95PsqqtB
	7ixCCRTd5wnJMMI0n6uGgeyh3WWet+qDSEgpwzXyIg1qf7MyFTyZUL1QOL5LfOLkLfLpa272AFNgq
	XoI0uzKpvHqsDUhUNV09yC61yJ2nK1LN4a8SItO4UbAHdNx6Y3X0DKNadFGm7uNVqhfLvx2/5vJ/0
	CFi9tTa3xa81O5ko7Wf+e7clW0udTPbRP17xQ+Yseqn3t7wajYNhBa1Y0w1oIl9L6/SMkHPDC65aX
	/fhCIA/KMNk4V9JrtdMs1oNWskC0H7Hq8UyqFwBdLI12efR33nw27MdLDSnnWiw+yFoHdIxVVq7GI
	Tm018dGeg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jut6S-0007Wn-08; Mon, 13 Jul 2020 07:42:20 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jut6P-0007W5-EA
 for linux-nvme@lists.infradead.org; Mon, 13 Jul 2020 07:42:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 40E6368BEB; Mon, 13 Jul 2020 09:42:11 +0200 (CEST)
Date: Mon, 13 Jul 2020 09:42:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V2 1/2] nvme-core: replace ctrl page size with a macro
Message-ID: <20200713074210.GB14676@lst.de>
References: <20200709234025.10673-1-chaitanya.kulkarni@wdc.com>
 <20200709234025.10673-2-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200709234025.10673-2-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200713_034217_595008_D1856674 
X-CRM114-Status: GOOD (  13.89  )
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
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 09, 2020 at 04:40:24PM -0700, Chaitanya Kulkarni wrote:
> +/*
> + * Default to a 4K page size, with the intention to update this
> + * path in the future to accommodate architectures with differing
> + * kernel and IO page sizes.
> + */
> +#define NVME_CTRL_PAGE_SHIFT	12
> +#define NVME_CTRL_PAGE_SIZE	4096

NVME_CTRL_PAGE_SIZE can be defined as

(1 << NVME_CTRL_PAGE_SHIFT) instead of duplicating the value.

> index 45e94f016ec2..68f7c090cf51 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -348,8 +348,8 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
>   */
>  static int nvme_npages(unsigned size, struct nvme_dev *dev)
>  {
> -	unsigned nprps = DIV_ROUND_UP(size + dev->ctrl.page_size,
> -				      dev->ctrl.page_size);
> +	unsigned nprps = DIV_ROUND_UP(size + NVME_CTRL_PAGE_SIZE,
> +						NVME_CTRL_PAGE_SIZE);
>  	return DIV_ROUND_UP(8 * nprps, PAGE_SIZE - 8);

This looks like the existing code here is wrong, as DIV_ROUND_UP already
adds the page size itself.  But that is better left for another patch..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
