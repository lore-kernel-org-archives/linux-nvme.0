Return-Path: <SRS0=vpxS=XN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2062C4CEC9
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 17:29:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 956E621907
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2019 17:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GWYM4rt+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1t5g0jOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956E621907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=w6YzTkCDrjjcId2eUAREXd3i50KY9dFctpR52gSY5OM=; b=GWYM4rt+tadQyG
	kYcsSggT0s3B/WPBGTFkSkOwncTUrnYM+xV0Ksck3mirLE7J7ybfPtN91/3jzzXyGUKQlSBxzWhmb
	AQHoYFUC3RE8cH4JZk2/goeknCzOqq8+AcG1vm2sFSWCzIRCfa7WsderusPI6OXp8bNVlre4XAKo+
	2EsitmxIHQBhvv3ZO9eZipucErCYDxtTFUMMMR+9dBlqQwnYWcTwPCpR4TGSn3LlcjliFJMRwgp5W
	7Yj8BUOZyNVivNXXX1OqmVLV8M4VHMbIA/vpBsxqXu7rOGFpllKbQfJGvMGDrZTMyuCLtFb9xxCM9
	3E1rA2iJyVYiWcYlQp7w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iAdlI-0003BS-GM; Wed, 18 Sep 2019 17:29:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iAdlG-0003Av-Eo
 for linux-nvme@lists.infradead.org; Wed, 18 Sep 2019 17:29:03 +0000
Received: from C02WT3WMHTD6 (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D55BB208C0;
 Wed, 18 Sep 2019 17:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1568827741;
 bh=M7SNZBXcCiFOmpNM1RhyX6kmDyGHg4qu/nFa+CO6J5k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=1t5g0jOYSizU0QAnxEcRb0YGK1Fa0yF/Sa4zBR6ZOzFbOJW1G32upZ9VbqXRgm/Ka
 1lD6GlVA7SNvHCgqk3OKQmROEglF1emr5Fhs+z+T+69nfpPoMf6hw5RDNxKjQlSZfT
 4RscS47PEHrlFiExw8REs7biCMuAUU/vO5SQBZLo=
Date: Wed, 18 Sep 2019 11:28:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mario Limonciello <mario.limonciello@dell.com>
Subject: Re: [PATCH] nvme-pci: Save PCI state before putting drive into
 deepest state
Message-ID: <20190918172859.GA51420@C02WT3WMHTD6>
References: <1568245353-13787-1-git-send-email-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1568245353-13787-1-git-send-email-mario.limonciello@dell.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190918_102902_526928_DEA4A8C8 
X-CRM114-Status: GOOD (  14.66  )
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
Cc: Crag Wang <Crag.Wang@dell.com>, Sagi Grimberg <sagi@grimberg.me>,
 sjg@google.com, LKML <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Ryan Hong <Ryan.Hong@Dell.com>, Jared Dominguez <jared.dominguez@dell.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 11, 2019 at 06:42:33PM -0500, Mario Limonciello wrote:
> ---
>  drivers/nvme/host/pci.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 732d5b6..9b3fed4 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2894,6 +2894,13 @@ static int nvme_suspend(struct device *dev)
>  	if (ret < 0)
>  		goto unfreeze;
>  
> +	/*
> +	 * A saved state prevents pci pm from generically controlling the
> +	 * device's power. If we're using protocol specific settings, we don't
> +	 * want pci interfering.
> +	 */
> +	pci_save_state(pdev);
> +
>  	ret = nvme_set_power_state(ctrl, ctrl->npss);
>  	if (ret < 0)
>  		goto unfreeze;
> @@ -2908,12 +2915,6 @@ static int nvme_suspend(struct device *dev)
>  		ret = 0;
>  		goto unfreeze;

We would need to clear the saved state here, though. You can also
infact remove the unfreeze label and goto.

>  	}
> -	/*
> -	 * A saved state prevents pci pm from generically controlling the
> -	 * device's power. If we're using protocol specific settings, we don't
> -	 * want pci interfering.
> -	 */
> -	pci_save_state(pdev);
>  unfreeze:
>  	nvme_unfreeze(ctrl);
>  	return ret;
> -- 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
