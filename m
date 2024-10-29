Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E623D3A66E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 15:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c+tJ9+pXjzfoMe27oQJxlEZYjN65qWA6DAx421PrG9Q=; b=zmrCt81+EmdkVMXQHlG8s6g0ky
	IWLE5u1M5mMNv58Ul4ZMJHn5UKlbLOPpsXxCOvrQonYq52wp1tseYex43W0XmuBYCXidZcIrNHpRk
	r/xfLLYHqkWLhmrY2IOjTIgibjR0d+buATI+yF1pFqSvm0HjMMhwK+0vGuAdehIsEBws1vq8leEmQ
	3kcGW8tUyZ6YG5BISqKoDWC1B54Y1+EN8I0Mm7yN7kfuJ8Wa+yliNJ1RT0HnXmzDNv0l9jTu1QDX4
	vo/x7DRioVsyWB4pxHFnzeyOxvfS/GJv2h1ges/4Ng4ygYMiDsiqZB3KnwLzfwy9xDZIspLROFOBV
	2BBJ6E4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5oPt-0000000EyeV-1lSq;
	Tue, 29 Oct 2024 15:45:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5o5K-0000000Eubn-41jo
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 15:24:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 856E2227A88; Tue, 29 Oct 2024 16:24:39 +0100 (CET)
Date: Tue, 29 Oct 2024 16:24:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, hch@lst.de, joshi.k@samsung.com,
	javier.gonz@samsung.com, bvanassche@acm.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv10 0/9] write hints with nvme fdp, scsi streams
Message-ID: <20241029152438.GB26431@lst.de>
References: <20241029151922.459139-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029151922.459139-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_082443_306295_B74C0901 
X-CRM114-Status: GOOD (  10.75  )
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

On Tue, Oct 29, 2024 at 08:19:13AM -0700, Keith Busch wrote:
>   Return invalid value if user requests an invalid write hint
> 
>   Added and exported a block device feature flag for indicating generic
>   placement hint support

But it still talks of write hints everywhere and conflates the write
streams with the temperature hints which are completely different
beasts.


