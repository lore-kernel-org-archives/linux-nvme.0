Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C52DC531C9
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2026 16:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cUrnWy2WKVTXvQRFpa4Dg33IG19qhdXuCbSecbj9/ww=; b=W/Aj7ylZScgHnCHhVHu4iyvCeo
	4GI9xEwdBHHis+XQA4dQk26XiZ/20VFKKFtvsAZm1+5m2A6BiwWTEN2yM5newwnWua54n9/x/VvNF
	5Zh5N9rhjG4whfG+rY8dGTK7yvX22IMF6DnCPE+bGH7trYviGlErJo47++Yq+seEoAlhCgkFCejP1
	CBW2aBbnt+uPG27Qp73eEUh7dX5VFIY3qtzN3R/goFJuDMHPzQohCa89mXJe4EDlD+jiXDAQ5dthu
	ob1KOU/ck6E5JUpPZww+wzePwvwPXIdIY2lI8kxxcdHzXonzWmuixgcDWNt2r+kPj/QPva5EEF10R
	frvp/E5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnJCW-0000000GtYk-2kmE;
	Fri, 24 Jul 2026 16:56:44 +0000
Received: from out-171.mta0.migadu.com ([2001:41d0:1004:224b::ab])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnJCT-0000000GtWt-0mXS
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jul 2026 16:56:43 +0000
Message-ID: <94ed42ce-895d-4197-994b-60fc1d3f040c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784912197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cUrnWy2WKVTXvQRFpa4Dg33IG19qhdXuCbSecbj9/ww=;
	b=Epciqs5yfiRz6u6HGHqSg2CDRdAPPD2qTeNhYpUfxlt4tyVplFWCPZJTERcKUlRTR9DICd
	O+xLXrvBLWYvPwmSi4c1SuSXIp39vebQL541e4rtC+fWoHyYr+cP1RVNJmfoolbNRuxvxk
	9T7jv2kla5l9ZTEy9iV6lJWczJEAPt4=
Date: Fri, 24 Jul 2026 17:56:35 +0100
MIME-Version: 1.0
Subject: Re: [PATCH RFC] nvme-multipath: fix diskstats for partitions
To: Keith Busch <kbusch@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>,
 sagi@grimberg.me, axboe@fb.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20260721114553.1657841-1-john.g.garry@oracle.com>
 <20260724050152.GA3680@lst.de>
 <987782a9-e12a-4098-b438-a54a5765c2ae@oracle.com>
 <amNegPEvRX99EvPN@kbusch-mbp>
 <f76e9466-4b66-4a32-a491-728e24d34052@linux.dev>
 <amOGxr3rxvDflHLv@kbusch-mbp>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: John Garry <john.garry@linux.dev>
In-Reply-To: <amOGxr3rxvDflHLv@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_095641_519552_86A73364 
X-CRM114-Status: GOOD (  19.01  )
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

On 7/24/26 16:37, Keith Busch wrote:
> On Fri, Jul 24, 2026 at 04:29:08PM +0100, John Garry wrote:
>> On 7/24/26 13:45, Keith Busch wrote:
>>> Can we just thread through partitions for the bio's block_device instead
>>> of assuming part0? I know the hidden path devices skip partition
>>> scanning, but maybe if we let it happen, then those will have the same
>>> partition setup as the head gendisk. Then we can go right to the
>>> disk->part_tbl for what we provide to bio_set_dev() for both submission
>>> and failover, and everything should work out from there.
>>
>> I guess that we would just scan through the per-path gendisk->part_tbl and
>> match somehow to lookup the partition. Maybe vs start address of
>> bio->bi_bdev. Or is there a simpler (and quicker) way?
>>
> 
> This is the idea, assuming we can get the partition tables of the head
> and path disks to be aligned:
> 
> ---
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -543,7 +543,10 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
>          srcu_idx = srcu_read_lock(&head->srcu);
>          ns = nvme_find_path(head);
>          if (likely(ns)) {
> -               bio_set_dev(bio, ns->disk->part0);
> +               struct block_device *bdev;
> +
> +               bdev = xa_load(&ns->disk->part_tbl, bdev_partno(bio->bi_bdev));
> +               bio_set_dev(bio, bdev);
>                  /*
>                   * Use BIO_REMAPPED to skip bio_check_eod() when this bio
>                   * enters submit_bio_noacct() for the per-path device. The EOD
> --

ok, got it.

And I think that we would need to do the reverse lookup in 
nvme_mpath_start_request() and nvme_mpath_end_request() to get the head 
disk partition, like:
bdev = xa_load(&ns->head->disk->part_tbl, bdev_partno(bio->bi_bdev));

I suppose that the tricky part now would be have the per-path disk scan 
run but keep those per-path disks hidden.

I experimented by stop setting GENHD_FL_HIDDEN for the per-path disk, 
and the diskstats look ok, FWIW.

