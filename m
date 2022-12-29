Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D27BAC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Dec 2022 18:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xOEXS143QV3/C3dDkbpYWDD9wF91rFC08l2WJiezbn0=; b=SglvWH9ogyiJ9CyLe1D9+gtCAJ
	Yfopym5WGisVveCFPOGFSslrSGlpnrhcVju/s03H+oz36dMRLaa4KYlrRukyMT21T9OdEOfVgoEsP
	RqM4cJWPbJQaaYIiWOlADvIeMbxVm+u+6csiI2m3nrCijHUz3YRB7DwZJoUJizvbK8jWAiQncrUl8
	8M/sF7PZEECq29s8m7b6hnyOjdoIPakNjBV8mZSktxfVi7NMcJhgm9jrT18V/9ir66ah0iAn78vVE
	Sl6UM03F2JUagldXiMuTZPOS2erE9HoFiNJxJlf1SdBvvFT6evKUbvhB2k2qnK/npyWIzF3EganKl
	b63MZd4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAxGo-000bS1-HD; Thu, 29 Dec 2022 18:04:46 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAxGi-000bPk-6x
	for linux-nvme@lists.infradead.org; Thu, 29 Dec 2022 18:04:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id A2ADCB81A26;
	Thu, 29 Dec 2022 18:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2A9C433D2;
	Thu, 29 Dec 2022 18:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672337077;
	bh=zE2PL61SyVmgZLzrsWmVw2XuVVi926GhweLinTybOLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jp2dXz3ydvsUA8LGHkb7kvEyKuTA7eYSKNmcI3tQAC3dZurUY7magETTNkkPO77aJ
	 cMZRBW0ePy0QshrVYxKlyFloUVJiLWdWY29RLmqWsiLa3y+vbJdmK17jjMe88/UbXd
	 4IfWVm+GnMp5JRyL/kI3qjUSNBQ+RI5iwfumvAXK4gm2aTpu/OyGmNKbv27BkfHDPe
	 ZWjFNjICYyeHXwAoTGSUzGUyHha50E9wUG6Ofx2PJaHw7Kb6zYllRheB31iDMo4gEE
	 dQChsry1iUXlLdNQDpsXCbg5E9AlbXLa8SpScYe5cABR/HI7hZLIPxHNEelKeyZjzy
	 F0f5IX8yvCWLQ==
Date: Thu, 29 Dec 2022 11:04:33 -0700
From: Keith Busch <kbusch@kernel.org>
To: Tong Zhang <ztong0001@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, t.zhang2@samsung.com
Subject: Re: [PATCH] nvme-pci: free irq properly when cannot create adminq
Message-ID: <Y63WsX8Hvxep/dtN@kbusch-mbp.dhcp.thefacebook.com>
References: <20221229060549.3976570-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229060549.3976570-1-ztong0001@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221229_100440_423362_D77CA9CD 
X-CRM114-Status: GOOD (  17.47  )
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

On Wed, Dec 28, 2022 at 10:05:49PM -0800, Tong Zhang wrote:
> nvme_pci_configure_admin_queue could return -ENODEV, in this case, we
> will need to free IRQ properly. Otherwise following warning could be
> triggered
> 
> [    5.286752] WARNING: CPU: 0 PID: 33 at kernel/irq/irqdomain.c:253 irq_domain_remove+0x12d/0x140
> [    5.290547] Call Trace:
> [    5.290626]  <TASK>
> [    5.290695]  msi_remove_device_irq_domain+0xc9/0xf0
> [    5.290843]  msi_device_data_release+0x15/0x80
> [    5.290978]  release_nodes+0x58/0x90
> [    5.293788] WARNING: CPU: 0 PID: 33 at kernel/irq/msi.c:276 msi_device_data_release+0x76/0x80
> [    5.297573] Call Trace:
> [    5.297651]  <TASK>
> [    5.297719]  release_nodes+0x58/0x90
> [    5.297831]  devres_release_all+0xef/0x140
> [    5.298339]  device_unbind_cleanup+0x11/0xc0
> [    5.298479]  really_probe+0x296/0x320
> 
> Fixes: a6ee7f19ebfd ("nvme-pci: call nvme_pci_configure_admin_queue from nvme_pci_enable")

Right. It's really only needed when called from probe as the reset_work
handles the cleanup when called from there, but this is safe for both
cases.

> @@ -2584,8 +2584,13 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>  	pci_enable_pcie_error_reporting(pdev);
>  	pci_save_state(pdev);
>  
> -	return nvme_pci_configure_admin_queue(dev);
> +	result = nvme_pci_configure_admin_queue(dev);
> +	if (result)
> +		goto free_irq;
> +	return result;

Since you're already in this function, you should also add a "goto
disable" if pci_alloc_irq_vectors() fails. Right now it just returns
with the pci device still enabled, and it won't get disabled from probe.
  
> + free_irq:
> +	pci_free_irq_vectors(pdev);
>   disable:
>  	pci_disable_device(pdev);
>  	return result;
> -- 

