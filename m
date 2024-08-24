Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF455C5472C
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Aug 2024 08:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7FshA0OFRG62v9S0vTNfqa0pWFIhlIYFeg6Xm7cv344=; b=aA4SKwcmpsWxnUObyC5FrfhjUC
	4sbEd7qS4qzzIyJx4WfLSYYQsVEAm90YcILn9+3a52XlHoamfaY/6tAZQRfAo5dgC8LTDYlzMwNsb
	eWnmUjNWdkHw8yn8RhJy0mpMb6mOt2uTG3JoYUYibDQCJb/QeyuOEmjXn5wHOHagbK3HQRMq4q7ii
	0MZ+vRqotELlxBw/6TxwC2pvfV+U8uV3xbPL/wM/vuwTnz/41ELGAkmmCUKhIqtpdy4Afna+RZIsB
	8d/6HqiEw+PWiS9bW6O6UQbCXnyJcFNMkLGz5tOSKY22o/Uxs/8OOqO6zLS8xedNeT3BF2i1QOMq0
	o2sKM3Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shmDm-00000001r7k-258N;
	Sat, 24 Aug 2024 08:34:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shmDj-00000001r7D-1fB4
	for linux-nvme@lists.infradead.org;
	Sat, 24 Aug 2024 08:34:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2D201227A87; Sat, 24 Aug 2024 10:33:59 +0200 (CEST)
Date: Sat, 24 Aug 2024 10:33:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, krisman@suse.de,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v3 06/10] io_uring/rw: add support to send meta along
 with read/write
Message-ID: <20240824083358.GE8805@lst.de>
References: <20240823103811.2421-1-anuj20.g@samsung.com> <CGME20240823104627epcas5p2abcd2283f6fb3301e1a8e828e3c270ae@epcas5p2.samsung.com> <20240823103811.2421-7-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823103811.2421-7-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240824_013403_655668_B0710308 
X-CRM114-Status: GOOD (  10.58  )
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

> +#define IOCB_HAS_META		(1 << 22)

.. METADATA?

Also the fs infrastructure should probably be split from io_uring.

> +/*
> + * flags for integrity meta
> + */
> +#define INTEGRITY_CHK_GUARD	(1U << 0) /* enforce guard check */
> +#define INTEGRITY_CHK_APPTAG	(1U << 1) /* enforce app tag check */
> +#define INTEGRITY_CHK_REFTAG	(1U << 2) /* enforce ref tag check */

This gets used all over the block layer.  I don't think it should be
in an io_uring specific header even if that is the initial user.

We might also gain a bit more flexibility by splitting the userspace
API from the in-kernel flags even if there is no strong needs for that
yet.


