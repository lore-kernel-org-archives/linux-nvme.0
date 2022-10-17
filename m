Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18668C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Oct 2022 07:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lQrbLXI+C5PxPpRTHu/QuKE1L6V6wD06mSYCJHIvy3U=; b=x/p1sSwef19jaEYm5FHN+V7MlC
	NZbHE0yN4VsjdmWBzYW2c9Ple4ENJ5uNI6xrxe9rCFRJiHxVSujR9LAPkAnHQ6FJpUaLP2BOjC0HG
	N3FQJ1y/bnrCZWuCuL6ntFb/8TM+uixBrwOV2khmUcD/ex0SgWEMGiMqzvGAhYH9eWyqq6AwLs4Ln
	tFKCpZHerrbLWmNyLVu7W74AN5eIUAzzl8e1fc+k/q+aQW1ziJUWCx9Bf6eViKrPjhPyA8PhZ04OT
	Qc/oBXDvhJ9sj3tXPJMQS7cdV/TiW1wa82fxhnkJcCt9mBFiKZfsaKN3gZM8ITEcc+O2uw2m4pkYc
	JelECJgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okKRD-008Qd1-8m; Mon, 17 Oct 2022 07:21:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okKQq-008QPq-Ew
	for linux-nvme@lists.infradead.org; Mon, 17 Oct 2022 07:21:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A9EBD68CFE; Mon, 17 Oct 2022 09:21:01 +0200 (CEST)
Date: Mon, 17 Oct 2022 09:21:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nvme: fix error pointer dereference in error handling
Message-ID: <20221017072101.GE30661@lst.de>
References: <Y0pulP9Xj/mQINCh@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0pulP9Xj/mQINCh@kili>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_002104_669985_A0075210 
X-CRM114-Status: UNSURE (   8.05  )
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

Thanks, applied to nvme-6.1.

