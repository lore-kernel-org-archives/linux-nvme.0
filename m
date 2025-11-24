Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D547BCFA466
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 06:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Type:Subject:In-Reply-To:Mime-Version:Content-Transfer-Encoding:From:
	Cc:To:Message-Id:Date:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1v8DjKDZXbkovGdNkFJdKNL/RGUBInSERiXq+wqH6GE=; b=UTFNOxPQvdqpLsax7qB/VjuXXy
	kXvP9iowbyaho+bo4cV4S11tj3Oh+Pa52mF7V2wUelQDglhsOnjKG5ZO0DMi+Q4dyXFi/C67Xld6o
	+XMYuhTttXdM+fIOEpXTLR+6ZDrlAGiAs6DYATvHUutKsoO3Ni3OZNmXtROVyTASyc779in0+zU8b
	7B1cEhJiT0cvaI+vPY+nNsBnroQjBdFfdYfOwSKN5RHusZ1q5IlK8QFf1GwXBppj2rLI+fywTsgSA
	M8tBWza6B7cpeeH6owMZG7Ps4vJWJU3Q14iVBufoHNhCIfXCGMUB76ZBAhioZJJWfMiVktpDJHN63
	YutPw5Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNPzu-0000000B9Cc-0hiC;
	Mon, 24 Nov 2025 06:24:26 +0000
Received: from sg-1-17.ptr.blmpb.com ([118.26.132.17])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNPzq-0000000B9BU-2Aks
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 06:24:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763965451;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=1v8DjKDZXbkovGdNkFJdKNL/RGUBInSERiXq+wqH6GE=;
 b=NMaVJ26f6wCqj655OfZfLoFV8HUO5KA8eptMOPpNT59Q0VF84NED7z1T9jKNzaCerL0OU0
 Nt/skt4isLqE30nJINFcU89+VLzIkhsy1BzaJsFBA0qqUYfBYajIQk4uURYvp+hQkIQTXr
 wSXtzcxprblu4RivsUKndN7uQ7Hn3jwdNGx799dULSVIrM8/uTiR8NUwabxO5bWgt9WU8L
 5ccydH+OW7RoA9qXDY2udcI1niox7gGrCs0jN5CUMUYikBhxik8r4PkILp8Q6aIrP7Wt9C
 LDAIOg8YNaiOXZ9ZuFngyDKzRBhLWoyBSvEb8AQmiXL+rT2BvUX85HSJIZM/Jw==
Date: Mon, 24 Nov 2025 14:24:05 +0800
Message-Id: <d86b820a-46c9-43b6-9fe2-dbd991b76520@fnnas.com>
X-Lms-Return-Path: <lba+26923fa09+dcbe19+lists.infradead.org+yukuai@fnnas.com>
To: "Chaitanya Kulkarni" <ckulkarnilinux@gmail.com>, <axboe@kernel.dk>, 
	<agk@redhat.com>, <snitzer@kernel.org>, <mpatocka@redhat.com>, 
	<song@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>, 
	<jaegeuk@kernel.org>, <chao@kernel.org>, <cem@kernel.org>, 
	"Yu Kuai" <yukuai@fnnas.com>
Cc: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<dm-devel@lists.linux.dev>, <linux-raid@vger.kernel.org>, 
	<linux-nvme@lists.infradead.org>, 
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-xfs@vger.kernel.org>, 
	<bpf@vger.kernel.org>
From: "Yu Kuai" <yukuai@fnnas.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
In-Reply-To: <20251124025737.203571-3-ckulkarnilinux@gmail.com>
Subject: Re: [PATCH V2 2/5] dm: ignore discard return value
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
Received: from [192.168.1.104] ([39.182.0.153]) by smtp.feishu.cn with ESMTPS; Mon, 24 Nov 2025 14:24:08 +0800
Content-Language: en-US
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com> <20251124025737.203571-3-ckulkarnilinux@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_222423_484860_2720419A 
X-CRM114-Status: GOOD (  15.47  )
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

=E5=9C=A8 2025/11/24 10:57, Chaitanya Kulkarni =E5=86=99=E9=81=93:
> __blkdev_issue_discard() always returns 0, making all error checking
> at call sites dead code.
>
> For dm-thin change issue_discard() return type to void, in
> passdown_double_checking_shared_status() remove the r assignment from
> return value of the issue_discard(), for end_discard() hardcod value
> of r to 0 that matches only value returned from
> __blkdev_issue_discard().
>
> md part is simplified to only check !discard_bio by ignoring the
> __blkdev_issue_discard() value.
>
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> ---
>   drivers/md/dm-thin.c | 12 +++++-------
>   drivers/md/md.c      |  4 ++--
>   2 files changed, 7 insertions(+), 9 deletions(-)

mdraid and dm are different drivers, please split them.

>
> diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> index c84149ba4e38..77c76f75c85f 100644
> --- a/drivers/md/dm-thin.c
> +++ b/drivers/md/dm-thin.c
> @@ -395,13 +395,13 @@ static void begin_discard(struct discard_op *op, st=
ruct thin_c *tc, struct bio *
>   	op->bio =3D NULL;
>   }
>  =20
> -static int issue_discard(struct discard_op *op, dm_block_t data_b, dm_bl=
ock_t data_e)
> +static void issue_discard(struct discard_op *op, dm_block_t data_b, dm_b=
lock_t data_e)
>   {
>   	struct thin_c *tc =3D op->tc;
>   	sector_t s =3D block_to_sectors(tc->pool, data_b);
>   	sector_t len =3D block_to_sectors(tc->pool, data_e - data_b);
>  =20
> -	return __blkdev_issue_discard(tc->pool_dev->bdev, s, len, GFP_NOIO, &op=
->bio);
> +	__blkdev_issue_discard(tc->pool_dev->bdev, s, len, GFP_NOIO, &op->bio);
>   }
>  =20
>   static void end_discard(struct discard_op *op, int r)
> @@ -1113,9 +1113,7 @@ static void passdown_double_checking_shared_status(=
struct dm_thin_new_mapping *m
>   				break;
>   		}
>  =20
> -		r =3D issue_discard(&op, b, e);
> -		if (r)
> -			goto out;
> +		issue_discard(&op, b, e);
>  =20
>   		b =3D e;
>   	}
> @@ -1188,8 +1186,8 @@ static void process_prepared_discard_passdown_pt1(s=
truct dm_thin_new_mapping *m)
>   		struct discard_op op;
>  =20
>   		begin_discard(&op, tc, discard_parent);
> -		r =3D issue_discard(&op, m->data_block, data_end);
> -		end_discard(&op, r);
> +		issue_discard(&op, m->data_block, data_end);
> +		end_discard(&op, 0);
>   	}
>   }
>  =20
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 7b5c5967568f..aeb62df39828 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -9132,8 +9132,8 @@ void md_submit_discard_bio(struct mddev *mddev, str=
uct md_rdev *rdev,
>   {
>   	struct bio *discard_bio =3D NULL;
>  =20
> -	if (__blkdev_issue_discard(rdev->bdev, start, size, GFP_NOIO,
> -			&discard_bio) || !discard_bio)
> +	__blkdev_issue_discard(rdev->bdev, start, size, GFP_NOIO, &discard_bio)=
;
> +	if (!discard_bio)
>   		return;
>  =20
>   	bio_chain(discard_bio, bio);

--=20
Thanks
Kuai

