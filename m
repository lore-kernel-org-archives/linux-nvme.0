Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE074C3064D
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jun 2024 06:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=atXS9rBIKkf5Fi2TtbmIR0lIk/MfA9rcZ91Tr2sl5Zs=; b=cb4PNaX5UKQLMhysVfJc9XcqCZ
	+oSizR8RpHsxqJvhsA6sWaFv++jE0cW2wjZzsrWsrWaMjybf3+vJf+/YGeXy+uORDwt2h9a6bNBh8
	SoOQHbKJMLhnrewB/rBdlGFRz4pt8yUcAKVX4NeAomytC8z6ffUrLaqbxzWngzuEYNUT5FrcLKFcN
	oD8RfHsAZkY8Sb99zsKliBQ5QVwX/G7vsQLXYdrLPLXU1OMgdkuobJgCqKK8sRNuf3W7eUyG5v3rq
	rSXJ/FMIqx+2uo2MIteWMwB/JqhOQZbVA9JwGA33HbCCNGrz/wFdC+izbOOypSPwZI66RV3qkPAoh
	4LwCH8+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sN4j4-0000000ChPC-20Pa;
	Fri, 28 Jun 2024 06:04:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sN4j2-0000000ChOW-0O3u
	for linux-nvme@lists.infradead.org;
	Fri, 28 Jun 2024 06:04:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 67D2D68D05; Fri, 28 Jun 2024 08:04:45 +0200 (CEST)
Date: Fri, 28 Jun 2024 08:04:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: Anuj Gupta <anuj20.g@samsung.com>, asml.silence@gmail.com,
	mpatocka@redhat.com, axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v2 02/10] block: set bip_vcnt correctly
Message-ID: <20240628060444.GA26351@lst.de>
References: <20240626100700.3629-1-anuj20.g@samsung.com> <CGME20240626101513epcas5p10b3f8470148abb10ce3edfb90814cd94@epcas5p1.samsung.com> <20240626100700.3629-3-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626100700.3629-3-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240627_230448_291942_5029DBE6 
X-CRM114-Status: UNSURE (   9.44  )
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

Jens, can you pick this one up for 6.11?  We can't really trigger
it as-is, but it would be good to get it out of the way and avoid
someone else triggering the issue (e.g. Mikulas with his dm-integrity
work).


