Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5030AC02193
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 08:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r1r6plQaRoAy1Nxbdg0BWrNM7QAkG9cm/NIMqGIem9Y=; b=lVtZ+ZHS9ehMmdFaOWf3k3vfRp
	QWNPPjpjV063zbfVYwBTgy1ZCKtyRhikv58jAru95Eheb49dsVmBrvCqqnJcD2CphK5itcRlo0Ml1
	qJAbRWSYCXLxuhyHRV+sObKUWsrM7PdqRFlRW5owwd/4u8Md+RnOCeMpThgge5G1b1Qv2DVnNzPF3
	jLPLOsAT7OJDkkD2BPE7tAmw403DEUZ5ssQioXulGS/kW10i8+R74NpYMFgfNA990XVOcFrZR3Oag
	h5TVXSpudi1ppr9aCmhi7b/sTNTMAaWg4ZJRkzJsdFKKvcJ3cNZjaVklTkd2EG7dI0YsjgBdZ6ph0
	3RGflQ1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1terTj-0000000Else-3UiY;
	Mon, 03 Feb 2025 08:06:47 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1terTh-0000000ElsK-1hgZ;
	Mon, 03 Feb 2025 08:06:45 +0000
Date: Mon, 3 Feb 2025 00:06:45 -0800
From: "hch@infradead.org" <hch@infradead.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	Kanchan Joshi <joshi.k@samsung.com>, Theodore Ts'o <tytso@mit.edu>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
Message-ID: <Z6B5FdXwhXs76B5H@infradead.org>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
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

On Mon, Feb 03, 2025 at 08:04:42AM +0000, Johannes Thumshirn wrote:
> Well for the WAF part, it'll save us 32 Bytes per FS sector (typically 
> 4k) in the btrfs case, that's ~0.8% of the space.

It saves you from the cascading btree updates.  With nocow this could
actually allow btrfs to write with WAF=1 for pure overwrites.  But even
with data cow it will reduce a lot of churn, especially for O_SYNC
writes.


