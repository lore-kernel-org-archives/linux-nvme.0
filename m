Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CF4D68BCD
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2024 17:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pOosko4/B9hDXm+FZ48t1HnwH7MKNWWv7XYHSEVLDFc=; b=a3HmsHb2Oz69vb8oppI4065WPJ
	Qqsx7MW1Jzofx+qTkx5Th5K+htcnlAPb6ucjMirj1nKtFXbCW1w/UnnWWDhj1lWKcztCxo5ad6XoU
	mjumTBMTlLnD8LovUmpLhUGkqOJR8PSMu0DSkCOjx8qAIJfWfQM1TC7m4rdHIum2TygrbNydphxlu
	au17KzYsXA0g5tgfjO6KAaS/e+vTBmgYQcHu5DAc3ScpsU5DmiAuHOO1MfDn9LcyIks26Pe9IEDa/
	bP4ouI52U7j4taW3KuNop/YusD/ksq1nT8uCe8RPlg5mOnbP9Ssu5lweIQbjkD6GSp8dtx+0gg/y0
	Hq7Hzo7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBzk2-00000003TtW-03Va;
	Fri, 15 Nov 2024 17:04:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBzjz-00000003Tt5-3iVW
	for linux-nvme@lists.infradead.org;
	Fri, 15 Nov 2024 17:04:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 374C868D0A; Fri, 15 Nov 2024 18:04:11 +0100 (CET)
Date: Fri, 15 Nov 2024 18:04:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme-core: auto add the new ns while UUID changed
Message-ID: <20241115170411.GA23437@lst.de>
References: <20241115083727.30005-1-brookxu.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115083727.30005-1-brookxu.cn@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241115_090416_062274_39629406 
X-CRM114-Status: GOOD (  13.66  )
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

On Fri, Nov 15, 2024 at 04:37:27PM +0800, brookxu.cn wrote:
> From: "Chunguang.xu" <chunguang.xu@shopee.com>
> 
> Now spdk will change UUID of ns while restarted if we have not
> specified one. At this time, while host try to reconnected to target,
> as UUID have changed, we will remove the old ns, but not add the ns
> with the new UUID.

And that is broken behavior.  The host must assume the namespace has
been deleted and recreated when the eui/nguid/uuid change, and we need
to catch this.  Fix your broken target code instead.


