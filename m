Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC992C77B60
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 09:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+Kc+tjwYL39inuARMrwWencAkuigRPgOtOeBMjKidPQ=; b=PQN+4yEruIsxuVn2B6WVPcdoN6
	aiiXQWGtXZunC7BHkSh2PGMrZ+r+ODL+HaGEtPUUcp4SFGxh3wf1SGQtgjg224+BwLjAS7PuwSAeh
	RIHzmush1shI5J7aZPXDUbivkWfvr/wfNOv5eW+mPqTz9VtyvpQnC6rhJeIsnSGWuu3RSYiBxAc/L
	05/Lht4++R2ExESQ0SuEtx2kMFY9maKXM+BWaCe7EdWWtfi4lQcaxk2TICgdMq/6+t+AZDY39hW39
	CJHrHvpjqkb+E0orX2NE3W91DrDGfTUE9tC9sUjD6tEMSHF8NLuf+Ipi0qnvNKXUmepqk4mmhKKRL
	bLtIkbFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phRjr-00HGPL-2i;
	Wed, 29 Mar 2023 09:05:03 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phRjn-00HGLj-28
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 09:05:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680080699; x=1711616699;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ODmg3rPRGn4RIKplIt/ZC9RkflToL9LBuluXecNb92w=;
  b=C7Xj8STWxweEW0WXEgkbu2Pt+BE4MfDrYcUDpTrYmXp3Rn0dS1rzafRb
   hGQTICbaXLOmFxinbxAoJnAv41HeaoeobeGan7pEFLUPr9/8MEp20Jq7k
   isog+ct5w9SAJ8fzbSKqOOqZVJIf5Og8E+2pNdJTp/MzxpK6VaO+/JPPI
   KG3I4cDzbaYlUWXLx/xS2TzR/M6ugJeD5DdmF+z6o6fTh3BNAAVTEzZaD
   ndG3MNPWk0xVKe/O6HBNWVwjxrKcecTIHkgTef4v8j0yqbW8jDcTakMqy
   yFPnv2hfab54zgz5fi5x5pPdi7x6hNjSv7Sp98UhpGpqYOUMBm/NTsaBw
   g==;
X-IronPort-AV: E=Sophos;i="5.98,300,1673884800"; 
   d="scan'208";a="331215867"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2023 17:04:57 +0800
IronPort-SDR: FIRhi0E3OO9JJkmUP8SBnq6cmZLUeq2mOzgnPfEh/GzQwyNDu8xe1eeTf0R0hB69hHW63gzKVD
 rTmX6QDIlmf8nzr8CltPYymKzGyHirlc3LcRBXKTlRwL/Qk5oaH85l6v2JazMXvrTdvDSURVLl
 RvR1fM7sznb7R8Av/cSrGimWT4Qn3WHCw2vGIKi57W2vKvaFzePpVfhQFGILVkKjKZnBAnCluS
 l0YnwladR8qcl2r9TwC1PL8pGbTFsP0M9zqD8kdrXKF/kXIF15+EmpxeXgAzcUQHG3mhcYDHRg
 LLY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 01:21:07 -0700
IronPort-SDR: zCTrpvTfArBDKgY/Uy2KMonI5lEOO69jwJOCng/dVrHi7/BKJhR00WPorqkrmzRuBF1g/gN6SA
 Nr/GHAY885Z1ctJBv5VdbFHZ19dK0xuK/QgjKyJ/33a4J75wgfmaOMyz7HFtK3NABNinri4xVh
 H5dAezibpaf7hauHvwSyP+uSEhab94G3rs9A8FI55/+PlW9fh6M303yWSF7bCMrg2eNsapNLE5
 Kl2HTibrd+bwniU0NewatQ/JLLVsb3N754juKDqv/5/+HNG+JXkiQE12rs1v9WWdAEAfuFJfAX
 C6o=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 02:04:58 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pmgc90cF1z1RtVn
	for <linux-nvme@lists.infradead.org>; Wed, 29 Mar 2023 02:04:56 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1680080695; x=1682672696; bh=ODmg3rPRGn4RIKplIt/ZC9RkflToL9LBulu
	XecNb92w=; b=ek9+FWZIOUM0j8FYjqIFGu2FNvtxkIuaUDpxJppjKHuxRxiECWQ
	XX8+9cY4NJDFc1sTz0Kj8xdgnMbR7ze3HQOPBl8wCwLvm7ooyBQdPxzew5n74aAR
	jLo/gnamAnUNSM3d1agXwx7i5C6tGt/n1KgIdKm37YAYwrZ6tArpEUHgUo0zSrSm
	i80nEBbcwNLLSaofPCXt52XW3Y9ZN7jlqRvwG3WXHVUDEmT8mKjWJe8pO5rhaUlc
	EAsZ97xPJtwtkxCBZnIhNor8FWG8jPPbw1Q0EiMXboC6By/Pf5pF8D7UySUycXFP
	R6qGXT6WTVd5lBncEbrqSHvqIooKkMzF7bw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KRWRN-bzT_2P for <linux-nvme@lists.infradead.org>;
	Wed, 29 Mar 2023 02:04:55 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pmgc24vbRz1RtVm;
	Wed, 29 Mar 2023 02:04:50 -0700 (PDT)
Message-ID: <71d9f461-a708-341f-d012-d142086c026e@opensource.wdc.com>
Date: Wed, 29 Mar 2023 18:04:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v8 9/9] null_blk: add support for copy offload
Content-Language: en-US
To: Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com,
 joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
 Nitesh Shetty <nj.shetty@samsung.com>, Vincent Fu <vincent.fu@samsung.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20230327084103.21601-1-anuj20.g@samsung.com>
 <CGME20230327084331epcas5p2510ed79d04fe3432c2ec84ce528745c6@epcas5p2.samsung.com>
 <20230327084103.21601-10-anuj20.g@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230327084103.21601-10-anuj20.g@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_020459_772246_4962F178 
X-CRM114-Status: GOOD (  29.20  )
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

On 3/27/23 17:40, Anuj Gupta wrote:
> From: Nitesh Shetty <nj.shetty@samsung.com>
> 
> Implementaion is based on existing read and write infrastructure.
> 
> Suggested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
> ---
>  drivers/block/null_blk/main.c     | 94 +++++++++++++++++++++++++++++++
>  drivers/block/null_blk/null_blk.h |  7 +++
>  2 files changed, 101 insertions(+)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 9e6b032c8ecc..84c5fbcd67a5 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1257,6 +1257,81 @@ static int null_transfer(struct nullb *nullb, struct page *page,
>  	return err;
>  }
>  
> +static inline int nullb_setup_copy_read(struct nullb *nullb,
> +		struct bio *bio)
> +{
> +	struct nullb_copy_token *token = bvec_kmap_local(&bio->bi_io_vec[0]);
> +
> +	memcpy(token->subsys, "nullb", 5);
> +	token->sector_in = bio->bi_iter.bi_sector;
> +	token->nullb = nullb;
> +	token->sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
> +
> +	return 0;
> +}
> +
> +static inline int nullb_setup_copy_write(struct nullb *nullb,
> +		struct bio *bio, bool is_fua)
> +{
> +	struct nullb_copy_token *token = bvec_kmap_local(&bio->bi_io_vec[0]);
> +	sector_t sector_in, sector_out;
> +	void *in, *out;
> +	size_t rem, temp;
> +	unsigned long offset_in, offset_out;
> +	struct nullb_page *t_page_in, *t_page_out;
> +	int ret = -EIO;
> +
> +	if (unlikely(memcmp(token->subsys, "nullb", 5)))
> +		return -EOPNOTSUPP;
> +	if (unlikely(token->nullb != nullb))
> +		return -EOPNOTSUPP;
> +	if (WARN_ON(token->sectors != bio->bi_iter.bi_size >> SECTOR_SHIFT))
> +		return -EOPNOTSUPP;

EOPNOTSUPP is strange. These are EINVAL, no ?.

> +
> +	sector_in = token->sector_in;
> +	sector_out = bio->bi_iter.bi_sector;
> +	rem = token->sectors << SECTOR_SHIFT;
> +
> +	spin_lock_irq(&nullb->lock);
> +	while (rem > 0) {
> +		temp = min_t(size_t, nullb->dev->blocksize, rem);
> +		offset_in = (sector_in & SECTOR_MASK) << SECTOR_SHIFT;
> +		offset_out = (sector_out & SECTOR_MASK) << SECTOR_SHIFT;
> +
> +		if (null_cache_active(nullb) && !is_fua)
> +			null_make_cache_space(nullb, PAGE_SIZE);
> +
> +		t_page_in = null_lookup_page(nullb, sector_in, false,
> +			!null_cache_active(nullb));
> +		if (!t_page_in)
> +			goto err;
> +		t_page_out = null_insert_page(nullb, sector_out,
> +			!null_cache_active(nullb) || is_fua);
> +		if (!t_page_out)
> +			goto err;
> +
> +		in = kmap_local_page(t_page_in->page);
> +		out = kmap_local_page(t_page_out->page);
> +
> +		memcpy(out + offset_out, in + offset_in, temp);
> +		kunmap_local(out);
> +		kunmap_local(in);
> +		__set_bit(sector_out & SECTOR_MASK, t_page_out->bitmap);
> +
> +		if (is_fua)
> +			null_free_sector(nullb, sector_out, true);
> +
> +		rem -= temp;
> +		sector_in += temp >> SECTOR_SHIFT;
> +		sector_out += temp >> SECTOR_SHIFT;
> +	}
> +
> +	ret = 0;
> +err:
> +	spin_unlock_irq(&nullb->lock);
> +	return ret;
> +}
> +
>  static int null_handle_rq(struct nullb_cmd *cmd)
>  {
>  	struct request *rq = cmd->rq;
> @@ -1267,6 +1342,14 @@ static int null_handle_rq(struct nullb_cmd *cmd)
>  	struct req_iterator iter;
>  	struct bio_vec bvec;
>  
> +	if (rq->cmd_flags & REQ_COPY) {
> +		if (op_is_write(req_op(rq)))
> +			return nullb_setup_copy_write(nullb, rq->bio,
> +						rq->cmd_flags & REQ_FUA);
> +		else

No need for this else.

> +			return nullb_setup_copy_read(nullb, rq->bio);
> +	}
> +
>  	spin_lock_irq(&nullb->lock);
>  	rq_for_each_segment(bvec, rq, iter) {
>  		len = bvec.bv_len;
> @@ -1294,6 +1377,14 @@ static int null_handle_bio(struct nullb_cmd *cmd)
>  	struct bio_vec bvec;
>  	struct bvec_iter iter;
>  
> +	if (bio->bi_opf & REQ_COPY) {
> +		if (op_is_write(bio_op(bio)))
> +			return nullb_setup_copy_write(nullb, bio,
> +							bio->bi_opf & REQ_FUA);
> +		else

No need for this else.

> +			return nullb_setup_copy_read(nullb, bio);
> +	}
> +
>  	spin_lock_irq(&nullb->lock);
>  	bio_for_each_segment(bvec, bio, iter) {
>  		len = bvec.bv_len;
> @@ -2146,6 +2237,9 @@ static int null_add_dev(struct nullb_device *dev)
>  	list_add_tail(&nullb->list, &nullb_list);
>  	mutex_unlock(&lock);
>  
> +	blk_queue_max_copy_sectors_hw(nullb->disk->queue, 1024);
> +	blk_queue_flag_set(QUEUE_FLAG_COPY, nullb->disk->queue);

This should NOT be unconditionally enabled with a magic value of 1K sectors. The
max copy sectors needs to be set with a configfs attribute so that we can
enable/disable the copy offload support, to be able to exercise both block layer
emulation and native device support.

> +
>  	pr_info("disk %s created\n", nullb->disk_name);
>  
>  	return 0;
> diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
> index eb5972c50be8..94e524e7306a 100644
> --- a/drivers/block/null_blk/null_blk.h
> +++ b/drivers/block/null_blk/null_blk.h
> @@ -67,6 +67,13 @@ enum {
>  	NULL_Q_MQ	= 2,
>  };
>  
> +struct nullb_copy_token {
> +	char subsys[5];
> +	struct nullb *nullb;
> +	u64 sector_in;
> +	u64 sectors;
> +};
> +
>  struct nullb_device {
>  	struct nullb *nullb;
>  	struct config_item item;

-- 
Damien Le Moal
Western Digital Research


