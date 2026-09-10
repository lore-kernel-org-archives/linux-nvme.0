Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCC9DC79FB9
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2026 05:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bLaw+5j+/EBlwAC7CL1F9ozdwORQuvce0+Bc/EqWGGU=; b=b0rAhFo11LXPaRyopzCVoJV7zY
	Ou9q1krkWqgwg5DcJhSMRjbRlvdiHLTlfFvuuT9VBCojv4x1z4zMRg1PIietFxzYbzl3Xl1uN9/QX
	aGU114HcJfAF3fsf6mSXZoVPWIjoZZ5fR7B+Ob0c9xZ4TO/Q9yu3uVd2wbVA7LYED9ShT4HROzJ4/
	OSczpCKlWMpoxPwZ5+57Wlv+MbochIqw2B2qk+9yL4lzCJ8GIrTGoe2KjV2R9OBuhUJPydQnykEcJ
	L/gtM1gqqAWWYTL8hLNTJ1+8LdsrSblaQJsNphRlOkw7r44ivD3PQIQJFheZB3zTP/DmOJH8yckth
	90iM5sfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4XYX-0000000DTBk-1iyN;
	Thu, 10 Sep 2026 05:42:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4XYV-0000000DTB7-3wYb
	for linux-nvme@lists.infradead.org;
	Thu, 10 Sep 2026 05:42:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 422B368BFE; Thu, 10 Sep 2026 07:42:36 +0200 (CEST)
Date: Thu, 10 Sep 2026 07:42:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, armenx.baloyan@intel.com,
	james.p.freyensee@intel.com, ming.l@ssi.samsung.com
Subject: Re: [PATCH 2/2] nvmet: reject enabling a namespace without a
 device path
Message-ID: <20260910054235.GC27511@lst.de>
References: <20260908033519.2721210-1-sunjunchao@bytedance.com> <20260908033519.2721210-2-sunjunchao@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908033519.2721210-2-sunjunchao@bytedance.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_224240_131251_9A182FBD 
X-CRM114-Status: GOOD (  11.57  )
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

On Tue, Sep 08, 2026 at 11:35:19AM +0800, Julian Sun wrote:
> With buffered I/O enabled, nvmet_bdev_ns_enable() returns -ENOTBLK
> before validating the device path. Enabling a namespace without setting
> device_path therefore passes NULL to filp_open() and crashes in
> getname_kernel().
> 
> Reject enabling a namespace if no device path has been configured.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Can you add test for this to blktests?


