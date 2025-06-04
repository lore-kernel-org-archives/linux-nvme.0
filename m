Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA819C5B543
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Jun 2025 06:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pe1qJeegvXBPluoOlMRYoHImqkwDQRENHFRDQIDQpsY=; b=rIkVDT/tTlKSyFJWVFuCglvX7J
	8nj8DhB2yP9+DTIY/ni0fJRl6XipIuutDqwdeZguA1x4R/+OgfjEqQnlrKu8LPUuXuJuPMYY65JpL
	zJP5TMlozat/QzMLlKhFipT9+bRvE0/CVea4D5Gr+9kVfTarWcez7Kc4Xn+IYU0u+sss0iqbGHS5d
	I8V4NgqMiUL+aOvgBRK91whML1cikOGV04SNHrsLJ1zCU72hF8okbCvRNciSb5pHDn/OwgAp6hMj4
	vR9cSpBlJQhCMGymq9C3C+2VxgjEnyWyg7cuG7kvB9AfE95PNFp/7+mHYnEHTgyLVO/GR/2oC7YNf
	GLATOYiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMhn6-0000000Ch1t-0k8v;
	Wed, 04 Jun 2025 06:40:00 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMhmx-0000000Ch1g-32G7;
	Wed, 04 Jun 2025 06:39:51 +0000
Date: Tue, 3 Jun 2025 23:39:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v11 00/10] Read/Write with meta/integrity
Message-ID: <aD_qN7pDeYXz10NU@infradead.org>
References: <CGME20241128113036epcas5p397ba228852b72fff671fe695c322a3ef@epcas5p3.samsung.com>
 <20241128112240.8867-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241128112240.8867-1-anuj20.g@samsung.com>
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

On Thu, Nov 28, 2024 at 04:52:30PM +0530, Anuj Gupta wrote:
> This adds a new io_uring interface to exchange additional integrity/pi
> metadata with read/write.
> 
> Example program for using the interface is appended below [1].
> 
> The patchset is on top of block/for-next.
> 
> Testing has been done by modifying fio:
> https://github.com/SamsungDS/fio/tree/priv/feat/pi-test-v11

It looks like this never got into upstream fio.  Do you plan to submit
it?  It would also be extremely useful to have a testing using it in
blktests, because it seems like we don't have any test coverage for the
read/write with metadata code at the moment.

Just bringing this up because I want to be able to properly test the
metadata side of the nvme/block support for the new DMA mapping API
and I'm ѕtruggling to come up with good test coverage.


