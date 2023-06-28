Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FE8EB64D7
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 07:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SNSJG1wpF0yWzw1FYlmyEHMcNQqoeziRj6beOYAojA4=; b=BaoVg09aZ1IIxxUUgJx0Ppadza
	Z9JB/ZhTieiWMWZkwHfKeKKAzPfljODS8Fva2msyfYIdHF1zq/seo1XJOVrfD3f8mscZHEDz6ikF9
	1JKwVd3ewOtDuW5k0hshj+rHMlfjRbIhd4gHv9SU1vJLLbJrtCeFonbgbfBuXyV85JuhPsrRhMKfj
	sLc+/kl11yJUF6+0lNWh8RjJXpBjZF3tfQH4tn+Xy0ILDgFy7R1xGBrSApaMeKSra+erh1v0iKUB1
	jmMnyn+u00/eRL9xJFM/cgBE1fj48wuYiaQwnrvcfLs/TFibQ2FWVCNgJGTRF8ltll0RTD6iNUBDm
	3Tvcd1qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEPmW-00F4qy-00;
	Wed, 28 Jun 2023 07:40:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEPmT-00F4qL-2K
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 07:40:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 00DDB68AA6; Wed, 28 Jun 2023 09:39:57 +0200 (CEST)
Date: Wed, 28 Jun 2023 09:39:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, Chunguang Xu <brookxu.cn@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme: mark ctrl as DEAD if removing from error recovery
Message-ID: <20230628073957.GB25314@lst.de>
References: <20230628031234.1916897-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628031234.1916897-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230628_004001_913417_3C8C55B5 
X-CRM114-Status: GOOD (  14.72  )
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

> @@ -4055,7 +4056,8 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>  	 * removing the namespaces' disks; fail all the queues now to avoid
>  	 * potentially having to clean up the failed sync later.
>  	 */
> -	if (ctrl->state == NVME_CTRL_DEAD) {
> +	if (ctrl->state == NVME_CTRL_DEAD ||
> +			ctrl->old_state != NVME_CTRL_LIVE) {

Style nitpick: this is really nasty to read, pleas align things
properly:

	if (ctrl->state == NVME_CTRL_DEAD ||
	    ctrl->old_state != NVME_CTRL_LIVE) {

But I'm really worried about this completely uncodumented and fragile
magic here.  The existing magic NVME_CTRL_DEAD is bad enough, but
backtracking to the previous state just makes this worse.

I think a big problem is that the call to nvme_mark_namespaces_dead
and nvme_unquiesce_io_queues is hidden inside of
nvme_remove_namespaces, and I think there's no good way around
us unwinding the currently unpair quiesce calls and fixing this
for real.
  T

