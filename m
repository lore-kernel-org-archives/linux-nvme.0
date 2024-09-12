Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74467EED601
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 13:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=92E95GgMB5Tc32uKx/B5XehC2VJBVYHrSJ2+MqfgsMc=; b=G+pOEwIT/ZpJsPakfI5XNKgPqR
	LvGnCUkc+cEqNfpQnAKg9HyIegwRID7r+qFFmrCBq+wtIQzKVWvzyYoP+jNikTFPnsac8lR3ObVvk
	xcXhneotE062nLvOUzuQiOM2MV+1xgCtxYqW7W/crnecXm2OnWg+C4n+tbYkVfW8R3TAF3yMxoAwX
	JDmsVdKm78HGV41y3eF9Q68hUJx+CAQUmY27OjG7y7zAHnJe28DyhWH0QNNsp/BjLkStzWeGioX/P
	kVLboTgybe7k2Cq4ZZKoRsihw07SXJilfblXYMLiDvsbHXJQynaFs5IM7eH3yfK3IP9AOjPaAetgW
	AWvnb7uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sojgz-0000000DAca-2Ai3;
	Thu, 12 Sep 2024 13:17:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sojgw-0000000DAbn-3KA5
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 13:17:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 43F69227AAF; Thu, 12 Sep 2024 15:16:56 +0200 (CEST)
Date: Thu, 12 Sep 2024 15:16:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, song@kernel.org, yukuai3@huawei.com, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me, James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC 3/4] block: Support atomic writes limits for
 stacked devices
Message-ID: <20240912131656.GC29641@lst.de>
References: <20240903150748.2179966-1-john.g.garry@oracle.com> <20240903150748.2179966-4-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903150748.2179966-4-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_061658_993880_125B5FAC 
X-CRM114-Status: GOOD (  12.08  )
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

On Tue, Sep 03, 2024 at 03:07:47PM +0000, John Garry wrote:
> +	} else if (t->features & BLK_FEAT_ATOMIC_WRITES) {
> +		t->atomic_write_hw_max = min_not_zero(t->atomic_write_hw_max,
> +						b->atomic_write_hw_max);
> +		t->atomic_write_boundary_sectors =
> +					min_not_zero(t->atomic_write_boundary_sectors,
> +						b->atomic_write_boundary_sectors);
> +		t->atomic_write_hw_unit_min = max(t->atomic_write_hw_unit_min,
> +						b->atomic_write_hw_unit_min);
> +		t->atomic_write_hw_unit_max =
> +					min_not_zero(t->atomic_write_hw_unit_max,
> +						b->atomic_write_hw_unit_max);

Maybe split this into a helper to make the code more readable?

Otherwise this looks good to me.

