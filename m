Return-Path: <SRS0=pSM9=LQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE378C2B9F4
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jun 2021 19:16:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8E686128E
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jun 2021 19:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8E686128E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=opnQAkwwRMoJG5apwIKM3WhNnpVYQYlwPP8MWca76HU=; b=3tnAOh3+nffGh/
	GCReGRdPenIZrXMt7Z1Kr2vNy9xQYAbZ2FEkwWUIBd3d/Yp40WAzsVl6LVhHMlcUjjg6k0sB9KhwO
	wN2ItO3AfNUFdL36etWrJimToxh+EWq5uzGwwtaWAyUHM29aKZQQbWWvfPmzYNnJ9zYGbMWlA19Jr
	wbwVi7RMHvCUKP+Ulmkgaz6uSoDuWg+tO9cPsxo9O797NeFQYc+ztgB6oirAN38wVrzbdiw1KdYNp
	f0jBwpwsSM/IsMgdw1tbqzFAqdOaBgnQBq0wrAi0QoX6Pt2c+RE1o4pbHvBTH/XHcKZIikxzTJjNB
	+7cDQ/cF7QXtpNsosN/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvlsk-008DRd-Rh; Tue, 22 Jun 2021 19:16:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvlsU-008DRJ-P0
 for linux-nvme@lists.infradead.org; Tue, 22 Jun 2021 19:16:07 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id D050660E0B;
 Tue, 22 Jun 2021 19:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624389366;
 bh=xH/5R6ko538b1RMDlu3CzM4nz4O0GV2pe1wCObFfXUw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GptyQBk9fZlgIFhwi7fDOlNS0nKbo4G3RbbX2pg9oozK6omC49rJCV1kpGkeLeE4X
 xwCJcR1wQ0RiJX+mqWUGzL2MPOwdR0ceBS+Lh+NDocOnx9YPlKsoRIH1/R7mgpH1Ph
 aPylqP/M32wT88+A2QqV820jWx7WMSwr0mKYhiS/sLPtxfrWFc2xBy1+ZxK7Pigbwa
 RlZnHK/b2OtignjfcePxk5y+/77bw9E5a4gaHvAJDbyDXmlvkXahxaLLE+nFoSXJDB
 PXrAgNwoLpgRNawpCsPWGNroHxhWvDeIiVlz6ato+PTEUjjL3FKP9YtiK4lQvYyEEr
 ggRxosyzKrT9w==
Date: Tue, 22 Jun 2021 12:16:02 -0700
From: Keith Busch <kbusch@kernel.org>
To: Casey Chen <cachen@purestorage.com>
Cc: linux-nvme@lists.infradead.org, yzhong@purestorage.com,
 ashishk@purestorage.com
Subject: Re: [PATCH 2/2] nvme-pci: Fix UAF introduced by
 nvme_dev_remove_admin()
Message-ID: <20210622191602.GA2360166@dhcp-10-100-145-180.wdc.com>
References: <20210622002710.26591-1-cachen@purestorage.com>
 <20210622002710.26591-3-cachen@purestorage.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210622002710.26591-3-cachen@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210622_121606_867436_5C77625E 
X-CRM114-Status: GOOD (  16.25  )
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

On Mon, Jun 21, 2021 at 05:27:10PM -0700, Casey Chen wrote:
> nvme_dev_remove_admin() could free admin_q and admin_tagset while
> they are being accessed by nvme_dev_disable(), which could come from
> nvme_remove_dead_ctrl() by nvme_reset_work() during cleanup.
> 
> Commit cb4bfda62afa ("nvme-pci: fix hot removal during error handling") was
> to avoid requests being stuck on a removed controller by killing admin queue.
> But the later fix c8e9e9b7646e ("nvme-pci: unquiesce admin queue on shutdown"),
> together with nvme_dev_disable(dev, true) right before nvme_dev_remove_admin()
> could help dispatch requests and fail them early, so we don't need
> nvme_dev_remove_admin() any more.
> 
> Fixes: cb4bfda62afa ("nvme-pci: fix hot removal during error handling")

Thanks, this change looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

> upstream_status: upstream
> ---
>  drivers/nvme/host/pci.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 5abc4c3be454..49ef2027bcb0 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3023,7 +3023,6 @@ static void nvme_remove(struct pci_dev *pdev)
>  	if (!pci_device_is_present(pdev)) {
>  		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
>  		nvme_dev_disable(dev, true);
> -		nvme_dev_remove_admin(dev);
>  	}
>  
>  	flush_work(&dev->ctrl.reset_work);
> -- 
> 2.17.1

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
