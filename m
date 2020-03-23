Return-Path: <SRS0=QV8n=5I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EF7C54FCE
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 16:21:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 887B72072D
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Mar 2020 16:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W8jxGGzA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gP7PYMbO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887B72072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cjVff3TtvBOOV7VGPkOqOm/xtb62RVt2T1wdysBykWA=; b=W8jxGGzASCFrYw
	TjGbtxp4IXvL78+VVgliS9xpca1tHZ3RIsmFVaZIU32GoflKrABeg1xpUXMzJKZ1YxtM17xK40CmT
	PJrerW+JBcpuoeN1WRUz2ItmdH7pCSxVcI7Tnz2KRlmAqpWCk24YtksWzSEOjvt/QgcGTgVNxbNqR
	pxGfh3nnoWCPxhLrPCZwhR29ERpnUqdB6L5F1R+rb3KFvyQ2wIZVTyvY4im/TesNmto+pLccWcf4s
	caO/Iuv3BYOlvicnfigFXFS8mL8z5iT/4m1VMRik/r6ibXjpb5JYjDEMHMW8dyotyZIIhlFhqJaiC
	n2om1LOA9LpLS/K/hqcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGPpJ-00063p-T2; Mon, 23 Mar 2020 16:21:21 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGPpH-000621-Lr
 for linux-nvme@lists.infradead.org; Mon, 23 Mar 2020 16:21:20 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F31A82051A;
 Mon, 23 Mar 2020 16:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584980477;
 bh=YQi6xUyl6MDt573g/J6EWjMYIn95HkagF7Fc18pvBm4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gP7PYMbOIJLx2WrRUwHSluVA0RU5Cs3MIVpd/gm1TJ90JWNDXGFpMUC/SFe4lpas5
 eTmVeqEIP4TO+COuTrJktvDmAPVY451g431FwUJaxW8uiAGWhlMtGou6yu073q1J9K
 g7SuW5sr715tUi7l9Lmo6SJZTo5/5YJTE4cd36Ho=
Date: Tue, 24 Mar 2020 01:21:11 +0900
From: Keith Busch <kbusch@kernel.org>
To: Israel Rukshin <israelr@mellanox.com>
Subject: Re: [PATCH 2/6] nvme-pci: Make nvme_pci_free_ctrl symmetric to
 nvme_probe
Message-ID: <20200323162111.GA24680@redsun51.ssa.fujisawa.hgst.com>
References: <1584899989-14623-1-git-send-email-israelr@mellanox.com>
 <1584899989-14623-3-git-send-email-israelr@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1584899989-14623-3-git-send-email-israelr@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200323_092119_736312_C5999A3D 
X-CRM114-Status: UNSURE (   9.73  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>, Shlomi Nimrodi <shlomin@mellanox.com>,
 Sagi Grimberg <sagi@grimberg.me>, Linux-nvme <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Mar 22, 2020 at 07:59:45PM +0200, Israel Rukshin wrote:
> +	nvme_release_prp_pools(dev);
> +	nvme_dev_unmap(dev);
> +	put_device(dev->dev);
> +	kfree(dev->queues);
>  	kfree(dev);
>  }
>  
> @@ -2875,8 +2877,6 @@ static void nvme_remove(struct pci_dev *pdev)
>  	nvme_dev_remove_admin(dev);
>  	nvme_free_queues(dev, 0);
>  	nvme_uninit_ctrl(&dev->ctrl);
> -	nvme_release_prp_pools(dev);
> -	nvme_dev_unmap(dev);
>  	nvme_put_ctrl(&dev->ctrl);
>  }

I think we actually need the nvme_dev_unmap() call to remain inline with
nvme_remove(). If you hot remove the drive while an application has an
active reference on it, we still need to release the PCI resources so
that they're available for the next device inserted.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
