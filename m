Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021A9C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 13:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+m5/cujKwMFAcZEzABwtD4HnEsRVQblFere0jltpC4A=; b=OZHkfKZ2WUnGKxLiNs4UmYdAIS
	xhyfK4xiRBoOQIxmFc9NXuJBY/qiO5QEHZoJBl9jCXmyEp6tzxhXVjL4tK1fi6VUjxq9r0NDOwVdT
	BgEXXpWMUCagiivwiz0fpwIDIpIFYHx6OY4bQYn0OrcGWRpUfRypHulr3gl9mwyLADJ8HPfrsfdvV
	6s5knJDpgAEZTb+LE6Nr5hKpKdzTAqHUv7Vw45reJrr+0MOHzMf8lV8O2RSzhxr7JPHOcA6y5NcxC
	mDsWLylOn9uzo0NwMtQQc9AV/wR9GDN9kkRbCHBD/J4YMmnJ9JL8qM6KLvbTuD33xCjUjJdvn4tqg
	9oXf5V2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odtZ5-003Gon-7s; Thu, 29 Sep 2022 13:26:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odtZ2-003Gnm-P1
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 13:26:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F242568BFE; Thu, 29 Sep 2022 15:26:53 +0200 (CEST)
Date: Thu, 29 Sep 2022 15:26:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH for-next v11 07/13] block: add blk_rq_map_user_bvec
Message-ID: <20220929132653.GC27768@lst.de>
References: <20220929120632.64749-1-anuj20.g@samsung.com> <CGME20220929121653epcas5p4ee82ef35b46d6686820dc4d870b6588e@epcas5p4.samsung.com> <20220929120632.64749-8-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929120632.64749-8-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_062656_969793_95DF8A42 
X-CRM114-Status: UNSURE (   8.91  )
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

Please fold this into the next patch - adding a static helper without
users will cause a compiler warning, or even an error with pinheads
favourite -Werror setting.


