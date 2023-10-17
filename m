Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DA4CDB474
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Oct 2023 16:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=OfaufJN/tI1kKaObpwdjDHR2+x
	E6an+2EtOmG6c/Vm9ZgdSJCqpi8xy66wgMoSNiBoOEYKxbiSB+NVe1F+16QPSQR/aM22LPZW6p2T5
	uN5BhwtTJQPNNi6n/8JfSPuTN7m/baVTA3e5X5cn+t7iGPIz993R4vGdiOEH5/IguB9G/KOieem/N
	7FahtNnQVQj9UwGJQY1x2m4xBaTQn1FmYRqwyLIL0kJn6oxjwBxKZOU7nQNBzCi6Y1jIhBr60/0KU
	H/zRSCL1x2jWbtrT9dV+KAQshYBOaXZbh8oynC/je2hkyVhm/ABuV5W7Qw6AcOoP2tqwkQQoC98jl
	EnheOkfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsmfj-00CoNa-1T;
	Tue, 17 Oct 2023 16:11:55 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qsmfh-00CoNJ-0s;
	Tue, 17 Oct 2023 16:11:53 +0000
Date: Tue, 17 Oct 2023 09:11:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: hare@suse.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2] nvmet-auth: complete a request only after freeing the
 dhchap pointers
Message-ID: <ZS6ySaXGyoT9TLxS@infradead.org>
References: <20231017082845.545085-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017082845.545085-1-mlombard@redhat.com>
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

