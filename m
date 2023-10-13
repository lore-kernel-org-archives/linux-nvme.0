Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8BCCDB47E
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Oct 2023 04:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tKsMFcvQ2/C/GCkQiPDHY33nvyRv6IR8Prq3AbjvPeQ=; b=HVh5t/ckt8zKFFWF2xkfYfGvgs
	R4koJE7OUPQrzJn9+vqutodHhBzAZZW3BqYd/DJVBakV8vPmSLUw3QHYwIhfOIU6u35BYfkHb9pkZ
	PQ+b2kkOo7S3WLTlaznx2j2ot+Bbkke+bCmhAVT+02wI2oiFIqa9o8jy12Q4mOR1piJQnLVy+9nBb
	ssQCpMdfZEpEYSPR+qJyml27S55tXFZwX2J7yiI6JLEi9OJS72zMGw2QTE22gbBoZoVDyinPJ7lk/
	1yIgwvcF/Ox7YlMDN/Rp1/IbOoSWEBXjk4w/Rimtg++mm465SCG1iLDbY8RqarL+5zr45Po7pmmss
	8ymd9EkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qr9pg-002SYn-1s;
	Fri, 13 Oct 2023 04:31:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qr9pc-002SXl-1B
	for linux-nvme@lists.infradead.org;
	Fri, 13 Oct 2023 04:31:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6346167373; Fri, 13 Oct 2023 06:31:17 +0200 (CEST)
Date: Fri, 13 Oct 2023 06:31:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>, welsh@cassens.com
Subject: Re: [PATCH] nvme-pci: add BOGUS_NID for Intel 0a54 device
Message-ID: <20231013043117.GA5718@lst.de>
References: <20231012182934.2042397-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012182934.2042397-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231012_213124_550661_FB441EF4 
X-CRM114-Status: GOOD (  10.12  )
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

On Thu, Oct 12, 2023 at 11:29:34AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> These ones claim cmic and nmic capable, so need special consideration to ignore

*sigh*.

The patch looks fine except that the above line should be trimmed a bit.

Reviewed-by: Christoph Hellwig <hch@lst.de>


