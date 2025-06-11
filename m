Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EA0C71141
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 21:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:MIME-Version:Date:Message-ID:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LJdY97oBOFmkrzTZ00vwdAJipUoD7h4TKZBdAWF9EYs=; b=Sw6g0+GtJLhDIfZ5ATMUt5uPZv
	qC/i0IAi+KTJ1GOCsINEX7kI9kLO3XvQVHOUJnNn4XzHUApUYBugosT40XHPUFZJTfILbLDLrjoEV
	WT3WyKmvRa4cYiRRMVAPj244wUSGZQt6yyr2znPi52mrNlKeJ0WYX6IWmhg0ZW6f7stuaqQFKfTrP
	favZfZM9MY1D/DxjlzdOYeXnwXOEhWNX9MwFVCVOG6hmiwBHvMK2F50TvE1DwpCnmHzC3yxS8SqkR
	SVvpPEOjyZk2xj7IQKefoqL8mIRD84n7v8vgtbcxZgWhVlA/jzuVptTmXf4WXzZX1/Fg387ayzplm
	gbn2BtpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPSh7-0000000BFVH-2qLK;
	Wed, 11 Jun 2025 21:09:13 +0000
Received: from smtp-fw-52005.amazon.com ([52.119.213.156])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPNAs-0000000ALvu-3ziJ
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 15:15:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1749654936; x=1781190936;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=LJdY97oBOFmkrzTZ00vwdAJipUoD7h4TKZBdAWF9EYs=;
  b=s7iOeCuUBRDLWM701u2O9pdXejgGZujXEiNZ7S7vCpmBo+RUJ2q2fAPr
   5T69nbI61uMlhS4ybkt8gz7/6Duq1OXz/nHVys87zhjFS6nBj2X/hv25Z
   AFDlEtcyjYZpkTHErFtT2dwEoVAE8+g/m3QwWIIKi1qB+92SeAvCv1cw7
   hz8wMQESdYTSzdpweA8YHZRYnNKkS3QTb5HnsdX+BbYkzdJzIzKYTQiZy
   c+bRujf4vuVRFWpaixMxzEyuAulz4TYeiL/Y2vjkBMbfAs2MYn1i4wrCZ
   iy/7PHggcjKp3EsAntABzZFbJpO94bVX1JKdS79/aCODRcJP9Nf7zP4YW
   A==;
X-IronPort-AV: E=Sophos;i="6.16,228,1744070400"; 
   d="scan'208";a="754307810"
Subject: Re: [PATCH] Revert "block: don't reorder requests in blk_add_rq_to_plug"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 15:15:31 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:5574]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.36.246:2525] with esmtp (Farcaster)
 id e1a08913-2abb-4193-ad77-3ba6edd6ef77; Wed, 11 Jun 2025 15:15:29 +0000 (UTC)
X-Farcaster-Flow-ID: e1a08913-2abb-4193-ad77-3ba6edd6ef77
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 15:15:28 +0000
Received: from [192.168.11.154] (10.106.82.32) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 11 Jun 2025 15:15:27 +0000
Message-ID: <f9976d55-f418-45b8-82ac-e0557e713b4c@amazon.com>
Date: Wed, 11 Jun 2025 16:15:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jens Axboe <axboe@kernel.dk>
CC: <stable@vger.kernel.org>, kernel test robot <oliver.sang@intel.com>, Hagar
 Hemdan <hagarhem@amazon.com>, Shaoying Xu <shaoyi@amazon.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>, "Christoph
 Hellwig" <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<virtualization@lists.linux.dev>, <linux-nvme@lists.infradead.org>
References: <20250611121626.7252-1-abuehaze@amazon.com>
 <ed33ffb7-31bf-490c-b1ae-304a6e4b9a0f@kernel.dk>
Content-Language: en-US
From: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
In-Reply-To: <ed33ffb7-31bf-490c-b1ae-304a6e4b9a0f@kernel.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.106.82.32]
X-ClientProxiedBy: EX19D005EUB002.ant.amazon.com (10.252.51.103) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_081535_219843_36478CFC 
X-CRM114-Status: GOOD (  15.18  )
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

On 11/06/2025 13:56, Jens Axboe wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
> On 6/11/25 6:14 AM, Hazem Mohamed Abuelfotoh wrote:
>> This reverts commit e70c301faece15b618e54b613b1fd6ece3dd05b4.
>>
>> Commit <e70c301faece> ("block: don't reorder requests in
>> blk_add_rq_to_plug") reversed how requests are stored in the blk_plug
>> list, this had significant impact on bio merging with requests exist on
>> the plug list. This impact has been reported in [1] and could easily be
>> reproducible using 4k randwrite fio benchmark on an NVME based SSD without
>> having any filesystem on the disk.
> 
> Rather than revert this commit, why not just attempt a tail merge?
> Something ala this, totally untested.
> 
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 3af1d284add5..708ded67d52a 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -998,6 +998,10 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
>          if (!plug || rq_list_empty(&plug->mq_list))
>                  return false;
> 
> +       rq = plug->mq_list.tail;
> +       if (rq->q == q)
> +               return blk_attempt_bio_merge(q, rq, bio, nr_segs, false) == BIO_MERGE_OK;
> +
>          rq_list_for_each(&plug->mq_list, rq) {
>                  if (rq->q == q) {
>                          if (blk_attempt_bio_merge(q, rq, bio, nr_segs, false) ==
> 
> --
> Jens Axboe

I thought about that solution before submitting the revert and I believe 
it will help with the case we are discussing here  but what about the 
case where we have raid disks for which we need to iterate the plug 
list? In this case we will iterate the plug list from head to tail while 
the most recent requests (where merging will likely happen) will be 
closer to that tail so there will be additional overhead to iterate 
through the whole plug list and I believe the revert will also be better 
for this specific case unless I am missing something here :)


