Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32A6FA3741
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 17:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QvNep+e2yKSEBYVKe7DLkide1xIn6PHZfRvLmQfyjfc=; b=2cr78xf7ZzTlV4Loj+utdesXDN
	Rkdwf7x6XjdOZPmpe+JTykm5KQY3ilyZ6pkJ8/iAgQVq1FGyq93aWc+zAWLgdHV3c1pHOsq7NMyfE
	FuSzDtrNn5T+24Y1k/W3qjdO+GAhjhM+Rm1VfpkXRnNbZf9dujjffQVyTesn8IU9WfiRYX+eeQ3VN
	U0NXH6zxs1qVIxKGOFUwyXreMNbNfhYqk8hcnxpH2dngliUVGJ/+bORgjI+UVs52moff2BNbb+oc/
	wSf3JmwzkfFYi/ZPK4/Phe/WYxNuynmi48i1CKuIgRkBcpyhvMCHCAo9Z8ugA4bTnCoFijMgL+jgp
	NBz7QsDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onNxX-006WdE-Ke; Tue, 25 Oct 2022 17:43:27 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onNxV-006Wcl-DH
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 17:43:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id BC9E6B81DD9;
	Tue, 25 Oct 2022 17:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A60C433C1;
	Tue, 25 Oct 2022 17:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666719802;
	bh=YNgbDZ+9Bj/bdArQbW/AFPuoyi2XdEQpN6TkyJvj/E8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j0AQvRajMGjv2hZP9KQNo1Cc2Pag0tNf6Nq83fD1rCZiG8fnieaEjPwGXpEVFTgCX
	 ATHaBO1F9C9KNftS/fAk4gd+0/tlUoKN2cvNRXEUcPnXU1Dt+8Yd465Rbz0dmhRs+x
	 S59MIshFFjAv12R1zDnH3sCdPSBPriR5PKqrXIWPfRa+4UQD5iwOj+1p3VZsXKeEQm
	 PFDZ1r9V1Ym+EKa5sKY/COrq5GdCURL6jsgYGCANdlPceRmGGb6Mn9eSz3aKXa8m1I
	 bquHQRotN7cnt+NmBXozMBJ6UWGsGy1b0nqBsF+A2bwJulyLSUXRfEwc/X3EdPqyNU
	 9QOqr7Y5YqFRQ==
Date: Tue, 25 Oct 2022 11:43:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>, Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 04/17] nvme: don't call nvme_kill_queues from
 nvme_remove_namespaces
Message-ID: <Y1ggN68V/mbAw1q2@kbusch-mbp.dhcp.thefacebook.com>
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025144020.260458-5-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_104325_608501_D72F8DB6 
X-CRM114-Status: GOOD (  22.21  )
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

On Tue, Oct 25, 2022 at 07:40:07AM -0700, Christoph Hellwig wrote:
> @@ -4560,15 +4560,6 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>  	/* prevent racing with ns scanning */
>  	flush_work(&ctrl->scan_work);
>  
> -	/*
> -	 * The dead states indicates the controller was not gracefully
> -	 * disconnected. In that case, we won't be able to flush any data while
> -	 * removing the namespaces' disks; fail all the queues now to avoid
> -	 * potentially having to clean up the failed sync later.
> -	 */
> -	if (ctrl->state == NVME_CTRL_DEAD)
> -		nvme_kill_queues(ctrl);
> -
>  	/* this is a no-op when called from the controller reset handler */
>  	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
>  
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index ec034d4dd9eff..f971e96ffd3f6 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3249,6 +3249,16 @@ static void nvme_remove(struct pci_dev *pdev)
>  
>  	flush_work(&dev->ctrl.reset_work);
>  	nvme_stop_ctrl(&dev->ctrl);
> +
> +	/*
> +	 * The dead states indicates the controller was not gracefully
> +	 * disconnected. In that case, we won't be able to flush any data while
> +	 * removing the namespaces' disks; fail all the queues now to avoid
> +	 * potentially having to clean up the failed sync later.
> +	 */
> +	if (dev->ctrl.state == NVME_CTRL_DEAD)
> +		nvme_kill_queues(&dev->ctrl);
> +
>  	nvme_remove_namespaces(&dev->ctrl);
>  	nvme_dev_disable(dev, true);
>  	nvme_remove_attrs(dev);
> -- 
> 2.30.2
> 

We still need the flush_work(scan_work) prior to killing the queues. It
looks like it could safely be moved to nvme_stop_ctrl(), which might
make it easier on everyone if it were there.

