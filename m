Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BA9C54F32
	for <linux-nvme@archiver.kernel.org>; Fri, 23 May 2025 13:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h1KpPzL1dWxSEeKlxImuzJ8AVw4Y8yO1E36HDTirAaI=; b=1dRFXe0E35PGbM9oTbHZhE4dS5
	SpPFNrLf2EaqTrcZ74zGo/Po8uQZ9IXJdRZo0VK3DudOnyNkrgSoad5okHbHQgDZTxKcDSY+4+f3O
	UCieCuxKiLrl829FaSzli+W/Ljb3u/uh06R7j0a68QSNjddLXsEuC8Nefik5xzcvncqd5d5rN71Ey
	w19Cdntp0UCJDZSS5xgLd/EjSbrpw0jAeMHXl7ntoRdGlY7rHwLe/MSgDi5OBDNMAvTY4J2EpFWWj
	ALIsdti3x0HCqzLAloGoCJcPVUC2lVebgV5fWX/T9R2Qr34H3Pp3TYlR7h625zQv1pkZpANblGWk3
	iSp78khw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIS1n-00000003slA-3Q2T;
	Fri, 23 May 2025 13:01:35 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIRnd-00000003qds-49uF;
	Fri, 23 May 2025 12:46:58 +0000
Date: Fri, 23 May 2025 05:46:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/5] block: add support for copy offload
Message-ID: <aDBuQbsBRVjOc5wU@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521223107.709131-3-kbusch@meta.com>
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

On Wed, May 21, 2025 at 03:31:04PM -0700, Keith Busch wrote:
>  struct bio_vec {
> -	struct page	*bv_page;
> -	unsigned int	bv_len;
> -	unsigned int	bv_offset;
> +	union {
> +		struct {
> +			struct page	*bv_page;
> +			unsigned int	bv_len;
> +			unsigned int	bv_offset;
> +		};
> +		struct {
> +			sector_t	bv_sector;
> +			sector_t	bv_sectors;
> +		};
> +	};

Urrgg.  Please don't overload the bio_vec. We've been working hard to
generalize it and share the data structures with more users in the
block layer.  If having a bio for each source range is too much overhead
for your user case (but I'd like to numbers for that), we'll need to
find a way to do that without overloading the actual bio_vec structure.


