Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 880D2C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 06:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=TN4EYeTiHlnlX0uxfnitSpOJ0S
	zt6BTTFu1UVp50sjlGng4Yxb8V2cIaJRsbQAUIcdHNNtHaNSsftchS77SHjIC7dOIWK2y2aeYgArR
	HvgM5OoxYKbyRzIwsg1IWUD0FVfZ9Mw4QnENh3fX3oVkDC0yUC9zRGcxHe9EDeSJltXUNz23ewV6f
	15R1b1gs2m5VGVlzX01l+swGlO3s14DfRtC3z+O0IZR881Ntpv0gWtl6J2XyrRWy0F90GULmZ336t
	xqOHe2/kVhq+bx3HRKOJ5fyisD9SIUIY3DMd8vfL/DJWAUV/R9XSjHKiDJGxrvuN8CSkNlVdLFx1F
	QPexTr8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV3x8-00000001cnn-3etZ;
	Wed, 31 Jan 2024 06:20:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV3x3-00000001clt-1Oim
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 06:20:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5DADE68B05; Wed, 31 Jan 2024 07:19:52 +0100 (CET)
Date: Wed, 31 Jan 2024 07:19:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jeremy Allison <jallison@ciq.com>
Cc: jra@samba.org, tansuresh@google.com, hch@lst.de,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/5] nvme: Change 'bool shutdown' into an enum
 shutdown_type for nvme_dev_disable().
Message-ID: <20240131061952.GA16030@lst.de>
References: <20240129181953.1183084-1-jallison@ciq.com> <20240129181953.1183084-4-jallison@ciq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129181953.1183084-4-jallison@ciq.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_222001_532920_987610FB 
X-CRM114-Status: UNSURE (   8.52  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

