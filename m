Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED7FE7717D
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2024 15:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bunxl9aQMgx28QPwDNSeso5EOkCFGJz3ivE1sjmt6nk=; b=McYCJ+CtZM0liVtiwnnWEr/PUn
	YLdQTIcVmBmCeUaoeVNGbDRu8PrMVBteuF/qENCHjQycg2tatveuhq229wLARukPzDbjBA1ST3+cw
	lOewdgZ72CR5rhjy8xNgZQQGNs+e54JnrL4AvFulbV9twNYzD9AFDjUzbH0ZzhJo+G3Bz477DLuZI
	5iVsNegMaabmZvzaYaz8eQOaRFS0e1zzrDPv9ajQZgRgnuGFvbQfdEE8o7VzIB/nP61ag2tDcyE4E
	Eymzz1gKCetijykxdN5tn2zerRd8RwpcOgtyv0121v2G49zMmyrXkkC6PWJU89XMuTpbwKuVwb9Jz
	OerS8pWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tM7mF-00000004IYV-172i;
	Fri, 13 Dec 2024 15:40:27 +0000
Received: from ms.lwn.net ([45.79.88.28])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tM7mC-00000004IXL-3AG2
	for linux-nvme@lists.infradead.org;
	Fri, 13 Dec 2024 15:40:25 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B05B4403FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1734104420; bh=Bunxl9aQMgx28QPwDNSeso5EOkCFGJz3ivE1sjmt6nk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ptwlDFzDRPwST+tJiUhRYwbDVMWGrAv1PeQFrptB0rS5pKqqqYlkwFiEbdt5iapfy
	 yEEimu5l3TCxr7g6MErodPijyTmX/oZ09j9XwhdhP/4YUiLVQJIReAKTqAGPswZtAZ
	 QO3EtupaAihkVyicjpq5CTQMMuzhbnqk6MASI2oi8dPDCg71HGxuF2SMmAqfjySkaX
	 25q0SD2VDiBgeiu4wCYy6WUYLF9FehREgGuNvmQ7W3zmzbbxjbhDUlOqcZijXs3TFz
	 +C1MxnyevsCHQm7a169qYFcZAsLjmLeFLWnRE67LajFoEPXPd6wTYW2W7WTX4OKOxi
	 rHX3JH7WqSTFw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B05B4403FA;
	Fri, 13 Dec 2024 15:40:20 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Christoph Hellwig <hch@lst.de>, Guixin Liu <kanie@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH separate v3] docs, nvme: introduce nvme-multipath document
In-Reply-To: <20241212080835.GA7862@lst.de>
References: <20241209071127.22922-1-kanie@linux.alibaba.com>
 <20241212080835.GA7862@lst.de>
Date: Fri, 13 Dec 2024 08:40:19 -0700
Message-ID: <87h677y4kc.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_074024_793650_144B69B1 
X-CRM114-Status: UNSURE (   6.50  )
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

Christoph Hellwig <hch@lst.de> writes:

> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

I've applied this, thanks.

jon

