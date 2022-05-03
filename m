Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2934CC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  3 May 2022 20:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vZtmg3ivgVM9LV6DRPx09bLfZWnKvUtFH5l5CahMCz8=; b=bCOnME1g5eJ//rzgbYskuYZwNq
	QeM66N+ahM2kmBLoL2c8UUQuElHpPq/j8ZYxXWYPrEw+4VisYg6eTTi3X+fnj4UCr9EUgNvfSPyH+
	dphaKM8iMN7D5bm+gNzYPkI38mzzOn8rIG9P1wpnUldbzK7J3i2R39M3qp/X28D7UM/l87mQWbUH7
	WvWs0rDcqDE3rvQb0y1qcdpHM+CiSQNtFzNgavw6SRwu6NHUSbd8/ZPkQnYgGksa2gAVN7kOKcKN6
	IvTnoaEu6jLSa192BdhZCcNQ4njFZzGzdWy4tg5phMlD1NnioRqdJoySX+yTR/X0dyRbkOaKLGqBE
	EGO2LU5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nlzZV-007euq-MM; Tue, 03 May 2022 20:56:37 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlzZS-007etO-FR
 for linux-nvme@lists.infradead.org; Tue, 03 May 2022 20:56:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 65DE968B05; Tue,  3 May 2022 22:56:31 +0200 (CEST)
Date: Tue, 3 May 2022 22:56:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, asml.silence@gmail.com,
 ming.lei@redhat.com, mcgrof@kernel.org, shr@fb.com,
 joshiiitr@gmail.com, gost.dev@samsung.com,
 Anuj Gupta <anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v3 5/5] nvme: add vectored-io support for uring-cmd
Message-ID: <20220503205631.GD9567@lst.de>
References: <20220503184831.78705-1-p.raghav@samsung.com>
 <CGME20220503184916eucas1p266cbb3ffc1622b292bf59b5eccec9933@eucas1p2.samsung.com>
 <20220503184831.78705-6-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503184831.78705-6-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220503_135634_702438_D4249E77 
X-CRM114-Status: GOOD (  11.18  )
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

> +	union {
> +		__u32	data_len; /* for non-vectored io */
> +		__u32	vec_cnt; /* for vectored io */
> +	};

Nothing ever uses vec_cnt, so I don't think there is any point in adding
this union.

The rest looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

