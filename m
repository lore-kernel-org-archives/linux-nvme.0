Return-Path: <SRS0=ttKb=YA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232C5C47404
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2019 18:28:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDAE5206BB
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2019 18:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Z+T1D4dx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bo5MCDgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAE5206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XaMO1P+wRsHgOLi14b1vqzXVDf4WE/Pase3ajCYNMnk=; b=Z+T1D4dxqAkU7H
	WbS0K3ZuAzp3p7u/IX3dWU/B0udllrr6d85uWhqs43p1gUN7AR4M5Qcjse0yYyYrduARcDy+pLt5Q
	gHNlgBSKeyjR3g9Y9Bc+DLQ7HRW4EbwFpmTLEQR6XzivVo6n/YaUKoY0nyPwFFu0iT4V3wcX2yQOi
	yEyZ7eWMPpblJazgqmG20YM1iteWOOoDZqOUu1be3wRzRStBTRzS1Bz6c1GMElTbNDtmx8/ZWrXvE
	SxR7wUXfU+Ncf+lvpxddvnF+y4awd/m9WrBSD7cC14+FObVkASGzFNxYobeNWQw3tq8a6Y/OOViRX
	CtM/MCagT8lxHda0TmCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iHXk1-0004BD-O1; Mon, 07 Oct 2019 18:28:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHXjz-0004At-Lz
 for linux-nvme@lists.infradead.org; Mon, 07 Oct 2019 18:28:16 +0000
Received: from C02WT3WMHTD6 (rap-us.hgst.com [199.255.44.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3BD1F206BB;
 Mon,  7 Oct 2019 18:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570472894;
 bh=GCojsMxQn10tgSiueLPPGM61PEMejhrPHTmNDbqeo3I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bo5MCDgqgvG2usng8PEml0Sdlc4SAjEU6X+c6XUEdu/ey+U0elRbqGSAT17xNnuP5
 ETyGhtnlNbZsZpOFM1qEz/kwTthmMcd3CQhSvPoEQF1tGi+vqyovP+/7WTe8X2YmQS
 kLuHZ3p7vjpn/U05sk+oNd7m6LTt4F+wtQklbpug=
Date: Mon, 7 Oct 2019 12:28:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Tyler Ramer <tyaramer@gmail.com>
Subject: Re: [PATCH v2] nvme-pci: Shutdown when removing dead controller
Message-ID: <20191007182812.GB13149@C02WT3WMHTD6>
References: <20191007154448.GA3818@C02WT3WMHTD6>
 <20191007175011.6753-1-tyaramer@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191007175011.6753-1-tyaramer@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191007_112815_736910_E96FC425 
X-CRM114-Status: GOOD (  16.42  )
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
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Oct 07, 2019 at 01:50:11PM -0400, Tyler Ramer wrote:
> Shutdown the controller when nvme_remove_dead_controller is
> reached.
> 
> If nvme_remove_dead_controller() is called, the controller won't
> be comming back online, so we should shut it down rather than just
> disabling.
> 
> Remove nvme_kill_queues() as nvme_dev_remove() will take care of
> unquiescing queues.


We do still need to kill the queues, though. The shutdown == true just flushes
all pending requests. Killing queues does that too, but it also sets the
request_queue to dying, which will terminate syncing any dirty pages.
 
> ---
> 
> Changes since v1:
>     * Clean up commit message
>     * Remove nvme_kill_queues()
> ---
>  drivers/nvme/host/pci.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c0808f9eb8ab..68d5fb880d80 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2509,8 +2509,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
>  static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
>  {
>  	nvme_get_ctrl(&dev->ctrl);
> -	nvme_dev_disable(dev, false);
> -	nvme_kill_queues(&dev->ctrl);
> +	nvme_dev_disable(dev, true);
>  	if (!queue_work(nvme_wq, &dev->remove_work))
>  		nvme_put_ctrl(&dev->ctrl);
>  }
> -- 
> 2.23.0
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
