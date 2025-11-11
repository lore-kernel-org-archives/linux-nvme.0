Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E0ECCF9E3
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Nov 2025 10:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Mime-Version:Date:References:Content-Transfer-Encoding:Message-Id:Cc:To:
	Content-Type:Subject:From:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mk2NvXdhmW/ZG3o7XVavD3RsK8Qw1U9yYdZYzIdwkVk=; b=2Z/tFjINoReOEyDGCn4LFhu9LO
	iO/YNnh8q7aXcQhHGvFacDPxp8W9RCX8ajx6X8paeDEiHgiaQ5Y5a8BZvAh839Xp2F/hBNmSANY3V
	hw8Paf6iAHJuO07Owj4qAKzB9EQHfVkdLVvY9N6hPS1sD8Tsr90Zru4y0Kg5jUaZjpU0y0RyROmHa
	89oPjq6Pw9EiYUMWL7B8FrBPG6VFT2uvkW/nXkHR2PkIBRty3PENgL05UZtNoTxeU5pnuOsuLNhLy
	LvmiJSUoJmi5D399bwXUDBeCpv6gdEPOCjiHtS8r638sJodkuFV8n6jTeT8u5pcmoQpKaOH1+pYaf
	mMUYmdoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIlOY-00000006v42-08G7;
	Tue, 11 Nov 2025 10:14:38 +0000
Received: from sg-1-18.ptr.blmpb.com ([118.26.132.18])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIlOV-00000006v2l-2mVb
	for linux-nvme@lists.infradead.org;
	Tue, 11 Nov 2025 10:14:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1762856068;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Mk2NvXdhmW/ZG3o7XVavD3RsK8Qw1U9yYdZYzIdwkVk=;
 b=tZnf10uNZs2z8d5dg1/jstkMLp2gd2NPrQrOKOTUOisgwsCASwurGiWN/SqzggyjVSX1cj
 kDhNNvUArikNoOxHXKSbCCIBw/J056THKk5WAA0YI0W0C02+tzHuVInSFHSb5xk52l9MR+
 +440w9G3RZUo2T5UL3Y6Q26kH7sNokO85eQEayUnEn91/oZ3WkzuNGuExSYJRkgcCkb1FZ
 Rkj+IptozB3s5yUSXeMrLn8tXhHTgNm66tuJtiZNGokxpvZ0JALcIod/iR1r2GV7JyhxE7
 ur2msrRYa4Zmz+dyEykjfluURMVHhhIDRhay/EoCz5KIWFK14Ruz/1J9PxREnQ==
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
X-Original-From: Yu Kuai <yukuai@fnnas.com>
To: "Christoph Hellwig" <hch@lst.de>
Cc: "Keith Busch" <kbusch@kernel.org>, 
	"Matthew Wilcox" <willy@infradead.org>, "Keith Busch" <kbusch@meta.com>, 
	<linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>, 
	<axboe@kernel.dk>, <yukuai@fnnas.com>
Message-Id: <c82cd0f1-f56e-445b-8d78-f55a0c3b2b4c@fnnas.com>
Content-Transfer-Encoding: quoted-printable
References: <20251014150456.2219261-1-kbusch@meta.com> <20251014150456.2219261-2-kbusch@meta.com> <aRK67ahJn15u5OGC@casper.infradead.org> <aRLAqyRBY6k4pT2M@kbusch-mbp> <20251111071439.GA4240@lst.de> <024631dc-3c65-49a8-a97a-f9110fd00e9a@fnnas.com> <20251111093903.GB14438@lst.de>
Organization: fnnas
Received: from [192.168.1.104] ([39.182.0.168]) by smtp.feishu.cn with ESMTPS; Tue, 11 Nov 2025 18:14:26 +0800
Date: Tue, 11 Nov 2025 18:14:24 +0800
Mime-Version: 1.0
In-Reply-To: <20251111093903.GB14438@lst.de>
X-Lms-Return-Path: <lba+269130c83+80b61a+lists.infradead.org+yukuai@fnnas.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_021436_051509_A867524B 
X-CRM114-Status: GOOD (  14.39  )
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
Reply-To: yukuai@fnnas.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

=E5=9C=A8 2025/11/11 17:39, Christoph Hellwig =E5=86=99=E9=81=93:
> On Tue, Nov 11, 2025 at 05:36:39PM +0800, Yu Kuai wrote:
>> This can be reproduced 100% with branch for-6.19/block now, just:
>>
>> blkdiscard /dev/md0
>>
>> Where discard IO will be split to different underlying disks and then
>> merge. And for discard bio, bio->bi_io_vec is NULL. So when discard
>> bio ends up to the merge path, bio->bi_io_vec will be dereferenced
>> unconditionally.
> Ah, so it's not a NULL req->bio but bio->bi_io_vec.
>
>> How about following simple fix:
>>
>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index 3ca6fbf8b787..31f460422fe3 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
>> @@ -740,6 +740,9 @@ u8 bio_seg_gap(struct request_queue *q, struct bio *=
prev, struct bio *next,
>>           gaps_bit =3D min_not_zero(gaps_bit, prev->bi_bvec_gap_bit);
>>           gaps_bit =3D min_not_zero(gaps_bit, next->bi_bvec_gap_bit);
>>
>> +       if (op_is_discard(prev->bi_opf) || op_is_discard(next->bi_opf))
>> +               return gaps_bit;
>> +
> I think the problem is how we even end up here?  The only merging
> for discard should be the special multi-segment merge.  So I think
> something higher up is messed up
>
At least from blk_try_merge(), blk_discard_mergable() do return false,
however, following checking passed and we end up to the back merge patch.

blk_try_merge
  if (blk_discard_mergable())
    // false due to max_discard_segments is 1
  else if (...)
   return ELEVATOR_BACK_MERGE

Perhaps are you suggesting to change this to:

  enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
  {
-       if (blk_discard_mergable(rq))
-               return ELEVATOR_DISCARD_MERGE;
-       else if (blk_rq_pos(rq) + blk_rq_sectors(rq) =3D=3D bio->bi_iter.bi=
_sector)
+       if (req_op(rq) =3D=3D REQ_OP_DISCARD) {
+               if (blk_discard_mergable((rq)))
+                       return ELEVATOR_DISCARD_MERGE;
+               return ELEVATOR_NO_MERGE;
+       }
+
+       if (blk_rq_pos(rq) + blk_rq_sectors(rq) =3D=3D bio->bi_iter.bi_sect=
or)
                 return ELEVATOR_BACK_MERGE;
-       else if (blk_rq_pos(rq) - bio_sectors(bio) =3D=3D bio->bi_iter.bi_s=
ector)
+       if (blk_rq_pos(rq) - bio_sectors(bio) =3D=3D bio->bi_iter.bi_sector=
)
                 return ELEVATOR_FRONT_MERGE;
         return ELEVATOR_NO_MERGE;
  }

And the same for other callers for blk_discard_mergable().

Thanks,
Kuai

