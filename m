Return-Path: <SRS0=PNO/=FP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22FCC433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 18:05:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 786BC23ED2
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 18:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786BC23ED2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hJ795bAYt9zI72gU+xX+p/nm80RUWK6O0A9mLri3pv8=; b=f+fLlHwSJ/XGAsH4P3BltnkOs
	cILkrj2sUj3n1uuRAwO5Bh30kfYgY7vKKf/cqi4RMc07U7HwaxC1F4Pb1IKe+f3SF+Z1HAPBvW5jj
	bZG+ypB5MYWuUTc5BvpbR80AsSEGDBrIFJpN0PiWZoYcZ4zLYyuyiMAbqg6JXS9V9owq/ZhZgjsA2
	uI+AO6bRCH2szFZIwMweKiA0ZpsLgDzK2v7FN1a7wW4vDaKtRIyZE71yTUf81y0Qyn8JWOnuY2VO1
	jyTWeoTuT3i5MWFAvLand6kcgc00GrF5OvmhZVYYmhizcvTeOCjefw2KP++ALKOgS/7IdDAx+R6Ry
	g801sogfA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knmmv-0001uT-00; Fri, 11 Dec 2020 18:05:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knmmr-0001tR-Cs
 for linux-nvme@lists.infradead.org; Fri, 11 Dec 2020 18:05:02 +0000
Date: Sat, 12 Dec 2020 03:04:51 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607709900;
 bh=Ib27xs5IAcJ0qL2DAfNKgNMEdNLfkeQEpcKwRi5G7mA=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=kr+OWHANq+KjPZyzOGZUSiSgISj2y2/sM3LVsR+TeJNbyhdOL5EPWLwqo3LgfIz0J
 iZT1rjJMfVaRNo+Ll3fmlXWFWu7OFedFVeINgnAOFETfIhgwFcfhadAg7uOGxlLNcb
 FraBSV2iiM+YEzGBDvclal9L8zJ2hwW6UbQX2eV2EluwptM99dVpO3mJ0pKVuYK6mJ
 izig/qX+Var2q3VcIYh0RTphDxuSJX5vJmKCyB3kOcjbg+Cj7uQaFkWlJ709U4DeDK
 2MsWIicLLhd+VS2Elg7zMfuCCn3IKTxb4Nu6EsgNsP4vHyL4gprdLYPaBB89v5g8mo
 d2ff2xkWDbhng==
From: Keith Busch <kbusch@kernel.org>
To: SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [RFC PATCH v3 1/2] block: add simple copy support
Message-ID: <20201211180451.GA9103@redsun51.ssa.fujisawa.hgst.com>
References: <20201211135139.49232-1-selvakuma.s1@samsung.com>
 <CGME20201211135200epcas5p217eaa00b35a59b3468c198d85309fd7d@epcas5p2.samsung.com>
 <20201211135139.49232-2-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201211135139.49232-2-selvakuma.s1@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201211_130501_558347_FBDD20F4 
X-CRM114-Status: GOOD (  15.54  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, damien.lemoal@wdc.com, sagi@grimberg.me,
 linux-scsi@vger.kernel.org, selvajove@gmail.com, Johannes.Thumshirn@wdc.com,
 snitzer@redhat.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, nj.shetty@samsung.com,
 linux-block@vger.kernel.org, dm-devel@redhat.com, mpatocka@redhat.com,
 hare@suse.de, martin.petersen@oracle.com, joshi.k@samsung.com,
 javier.gonz@samsung.com, hch@lst.de, bvanassche@acm.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Dec 11, 2020 at 07:21:38PM +0530, SelvaKumar S wrote:
> +int blk_copy_emulate(struct block_device *bdev, struct blk_copy_payload *payload,
> +		gfp_t gfp_mask)
> +{
> +	struct request_queue *q = bdev_get_queue(bdev);
> +	struct bio *bio;
> +	void *buf = NULL;
> +	int i, nr_srcs, max_range_len, ret, cur_dest, cur_size;
> +
> +	nr_srcs = payload->copy_range;
> +	max_range_len = q->limits.max_copy_range_sectors << SECTOR_SHIFT;

The default value for this limit is 0, and this is the function for when
the device doesn't support copy. Are we expecting drivers to set this
value to something else for that case?

> +	cur_dest = payload->dest;
> +	buf = kvmalloc(max_range_len, GFP_ATOMIC);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < nr_srcs; i++) {
> +		bio = bio_alloc(gfp_mask, 1);
> +		bio->bi_iter.bi_sector = payload->range[i].src;
> +		bio->bi_opf = REQ_OP_READ;
> +		bio_set_dev(bio, bdev);
> +
> +		cur_size = payload->range[i].len << SECTOR_SHIFT;
> +		ret = bio_add_page(bio, virt_to_page(buf), cur_size,
> +						   offset_in_page(payload));

'buf' is vmalloc'ed, so we don't necessarily have congituous pages. I
think you need to allocate the bio with bio_map_kern() or something like
that instead with that kind of memory.

> +		if (ret != cur_size) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		ret = submit_bio_wait(bio);
> +		bio_put(bio);
> +		if (ret)
> +			goto out;
> +
> +		bio = bio_alloc(gfp_mask, 1);
> +		bio_set_dev(bio, bdev);
> +		bio->bi_opf = REQ_OP_WRITE;
> +		bio->bi_iter.bi_sector = cur_dest;
> +		ret = bio_add_page(bio, virt_to_page(buf), cur_size,
> +						   offset_in_page(payload));
> +		if (ret != cur_size) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		ret = submit_bio_wait(bio);
> +		bio_put(bio);
> +		if (ret)
> +			goto out;
> +
> +		cur_dest += payload->range[i].len;
> +	}

I think this would be a faster implementation if the reads were
asynchronous with a payload buffer allocated specific to that read, and
the callback can enqueue the write part. This would allow you to
accumulate all the read data and write it in a single call. 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
