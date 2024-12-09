Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35823E7717D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 15:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yPlELuruizFX5QOOUUgGzm92Ru1d2UzZRwbOui4sm8A=; b=HHR5EuTKarBhIoqpYekj5UaZDu
	/DRi++bx3d5+bJStBVKk/1zzqdUmlvMINq6P8VQcoMxajUA6EgJEzRHAKW5RodFVTu5VoP17cpaeZ
	o3vGtTJIM1QxWw8VTqjOWgGDw7sHfYZ312ilJqn1SBj8+Kn9arg5PirlWsFlRUwfXOR+0PafFVg9G
	wwvm2cDM44k/CwkuzW8as76AGb1+AF/zmZw1ckjAQUi+uzcx+pM+Ik0PJgcaI0WsQ5PfwQZKvmqLE
	biZ9ueNwk94RnYFvIcyyiXSRk8LBMUmK5EsWcxsAYeZCv6HgjlJlWNOt8RrFv1f24qxxsoxQPUTbE
	VBidE+bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKfwx-00000008QYd-0BSH;
	Mon, 09 Dec 2024 15:45:31 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKfw0-00000008QTE-2EXQ
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 15:44:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A91DA5C5AD6;
	Mon,  9 Dec 2024 15:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D38C4CED1;
	Mon,  9 Dec 2024 15:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733759071;
	bh=ZGnipZ8rEfx0lgHzjHdDuDH1iQU65FbOHq9TJXnQC5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j3taj1Ot9RW10fKZ7tJEavFkfwkPRt9gS39s9sA2bnpglEBF8K5E6k8aZzgs3t9V7
	 2s3/J7n8BU3du+1xtsQtpQUXEZHf7eHXA7LdlFZ1gotKwK5sXmqRYTJtFJLVLuyru/
	 QcMedLCL1hK9rmWlzgHzP1tRU5wRlTbn4fZra9oz1XXILbqR/PraOUBmxc9lT/tGUW
	 bla0Op3PJMfXeZF/gu8ajYObAHiBw2c18PygxICzqluFIH39juHSvIX+aM0zct6Lm5
	 Iu3aMGjxjZXriSza58GgzyOrME3gWXylb9mk1EWvTwAqRxU1f80kuuO3pkx46V/WWE
	 iEN01PFqBsAZA==
Date: Mon, 9 Dec 2024 08:44:28 -0700
From: Keith Busch <kbusch@kernel.org>
To: Yongsoo Joo <ysjoo@kookmin.ac.kr>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: change the return type of nvme_poll()
Message-ID: <Z1cQXGWGRZ5dcWOW@kbusch-mbp.dhcp.thefacebook.com>
References: <20241209133343.125885-1-ysjoo@kookmin.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209133343.125885-1-ysjoo@kookmin.ac.kr>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241209_074432_611817_A65E5CA5 
X-CRM114-Status: UNSURE (   9.30  )
X-CRM114-Notice: Please train this message.
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

On Mon, Dec 09, 2024 at 01:33:44PM +0000, Yongsoo Joo wrote:
> -static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
> +static bool nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>  {
>  	struct nvme_queue *nvmeq = hctx->driver_data;
>  	bool found;
> -- 

This function is registered with blk_mq_ops, so you would have to change
the prototype there too, and every other driver that also registers a
poll op. Honestly, it may not be worth the effort.

