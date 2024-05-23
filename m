Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D1DC25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 17:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EKtIjo3ysw0jBQm9VxfXUyp0QzbJDMT/ES8FUaWr9hY=; b=gv7Zmmpa/+5CzvEYTuyyLWobyr
	APgp1C8jvq1QNHj0ck/tpzV8qhpUlXvc7p+69T6LEZDbJVEtx84ronrKH8rTvCmj7u+Hw9JQ9lMqh
	QkXKF2+zGCdNGclhGOVx0IzQG7LCcvvA6lPceioXB5kcBp+48ZqLA4eJQ9/GI9xftlsd/zR8wXNQG
	3XTiZSeX7bv92wywUtavSz8yslbSjOyYduApYescQiDMWJGmfe0FiDRkRpda+WLdBgCUag61QOqlA
	K7K+xh50w0nFs2hnHfhRSpDKnbuMXDFG42ZGJ4Mfuurr+ncfuKt/Idv9sw1+aGGqZ8Nd46U969etz
	LLUNsIJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAC6H-00000006sXv-0B3S;
	Thu, 23 May 2024 17:19:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAC6E-00000006sVy-0F9Z
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 17:19:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3014068CFE; Thu, 23 May 2024 19:19:23 +0200 (CEST)
Date: Thu, 23 May 2024 19:19:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Mike Snitzer <snitzer@kernel.org>, Milan Broz <gmazyland@gmail.com>,
	Anuj gupta <anuj1072538@gmail.com>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2 v3] block: change rq_integrity_vec to respect the
 iterator
Message-ID: <20240523171922.GA5892@lst.de>
References: <a1d8771a-70ad-9eed-476c-af696d2f9ac2@redhat.com> <d27da881-e615-b081-d8db-17ac9b91d4be@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d27da881-e615-b081-d8db-17ac9b91d4be@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_101930_259115_244FCEFE 
X-CRM114-Status: GOOD (  19.09  )
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

On Thu, May 23, 2024 at 06:54:47PM +0200, Mikulas Patocka wrote:
> 
> However, the function rq_integrity_vec has a bug - it returns the first
> vector of the bio's metadata and completely disregards the metadata
> iterator that was advanced when the bio was split. Thus, the second bio
> uses the same metadata as the first bio and this leads to metadata
> corruption.
> 
> This commit changes rq_integrity_vec, so that it calls mp_bvec_iter_bvec
> instead of returning the first vector. mp_bvec_iter_bvec reads the
> iterator and advances the vector by the iterator.

mp_bvec_iter_bvec does not advance the bvec_iter, it just uses the
iter to build a bvec for the current position in the iter.

Also please fix the commit log to not use more than 73 characters,
as-is it will be unreadable in git show output or email replies.

> -static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> +static inline struct bio_vec rq_integrity_vec(struct request *rq)
>  {
>  	if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
> +		return (struct bio_vec){ };
> +	return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
> +				 rq->bio->bi_integrity->bip_iter);

The queue_max_integrity_segments check can go away now.  Once you
use the bvec_iter the function works just fine for multiple
integrity segments and always returns the one at the current iter
position.   That should preferably also documented in a comment.

(I'm also pretty sure I've already written this in reply to Anuj's
version of the patch)


