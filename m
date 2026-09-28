Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A636C9833E
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2026 05:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ly/xSxxKXsojK2iqA+gghoIofrYayNWjZjuMFAs9Sp8=; b=JVLR2Ocstv7u5uGID1evRHLqxs
	V9ICTm8Olt5xlTq/cpNJIxlUuwL734MDhvaomEnbIuaDHIPm71bMPAmTklIzMgZSOFIuwJ8ct14Kj
	vEy8WIenkw6a/B9SveR/YVyrvnnxxQ6w3CkoG6AQ+aOvft2odcJR0KIewLyHSr4G5VUxoZqdYdQ+P
	cM7cKSTQp3yZDD6id8I8ozwzzHiyYOy19Eu/KHu17/vPqSfxv4btObkP/kU8M22+i3LbdO3PUymqh
	Q7eLZtqBZrFxj//ej7Wi/DnRnhzSg0yIX0UxkEuSiAvYr7/LH7pUsyZw/maUxhZutCtYmahOXld8q
	w0QR3sLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB3dA-0000000HLUk-1h9Y;
	Mon, 28 Sep 2026 05:10:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB3d7-0000000HLUM-0UtJ
	for linux-nvme@lists.infradead.org;
	Mon, 28 Sep 2026 05:10:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B122868B05; Mon, 28 Sep 2026 07:10:11 +0200 (CEST)
Date: Mon, 28 Sep 2026 07:10:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
	sagi@grimberg.me, gjoyce@linux.ibm.com, chaitanyak@nvidia.com
Subject: Re: [PATCH 1/2] nvmet: introduce struct nvmet_passthru
Message-ID: <20260928051011.GA18753@lst.de>
References: <20260925112120.790530-1-nilay@linux.ibm.com> <20260925112120.790530-2-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925112120.790530-2-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260927_221021_312007_AECE86FE 
X-CRM114-Status: GOOD (  11.80  )
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

On Fri, Sep 25, 2026 at 04:51:09PM +0530, Nilay Shroff wrote:
> Currently, passthru parameters are grouped under struct nvmet_subsys.
> Since passthru can be configured through configfs and all passthru
> parameters are exposed under a separate configfs subdirectory, group
> these parameters under a new struct nvmet_passthru.
> 
> Grouping passthru-specific parameters in a separate structure makes
> the code easier to maintain and reason about.
> 
> There are no functional changes intended.

If the fields are move out anyway, should they be a separate, dynamically
allocated object so that non-passthrough users don't pay for the memory
allocation?


