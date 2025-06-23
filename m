Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468B9C77B7C
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jun 2025 15:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ikVgqWdtuSUd4CQr0OtF+Iw8Tj2TMu8yb1gnWCx4Do0=; b=nXIQOIUfUOBUl+m5rAw0uAqkbI
	4klxHYr5bU/2E6QBu8D9buL79s+G159ZugfqMowjPURlPF8F8t6n2pSU/mnUupNelOGayYMImvh9b
	rSb/1q2mAYsNbLxq5uPqpT3UaGDsIZWbgkc2kOLoSZKh6xD/qM3Hmxc8+eHwOGgGLS0yUsCoApjae
	faBj7HlhA30IH0YmmgCLegOwbET+mVBQuqI7sTNAsZbZY6e8jCCJKBGThKOmU6ft+mtgwjQb+KZXa
	HElP+QtVKxQbkzH4eUVKAz4JxuKiQixjhP2RfEMmkUboeRLG3HFs/cIdvoYXEneownbGjbCfKdqxJ
	f7zBVWCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTjP6-00000003Ilq-2zlk;
	Mon, 23 Jun 2025 15:48:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTgA0-00000002eiB-20em
	for linux-nvme@lists.infradead.org;
	Mon, 23 Jun 2025 12:20:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2725568C4E; Mon, 23 Jun 2025 14:20:20 +0200 (CEST)
Date: Mon, 23 Jun 2025 14:20:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
	sagi@grimberg.me, hare@suse.de, dwagner@suse.de, axboe@kernel.dk,
	shinichiro.kawasaki@wdc.com, gjoyce@ibm.com
Subject: Re: [PATCH 1/1] nvme: correctly account for namespace head
 reference counter
Message-ID: <20250623122019.GA22176@lst.de>
References: <20250620080257.27993-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250620080257.27993-1-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250623_052028_660389_5CECC980 
X-CRM114-Status: UNSURE (   9.65  )
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

On Fri, Jun 20, 2025 at 01:32:43PM +0530, Nilay Shroff wrote:
> During the failre

failure?

> To fix this, we now unconditionally release the nshead reference when
> the last nvme path referencing to the nshead is removed, regardless of
> the head’s state. Also during idnetify

identify

Otherwise this looks good.

