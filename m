Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39277C54E58
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Mar 2024 14:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LxefT6WnEEQJVl/KbV2+9X+VpTvqc9bIIRFfXtqPbTA=; b=IuY+iRQcRlJJcXlvZFwUEFhOVU
	V2/5BGg8KquCzvDw1c5qbFv7x/tYhElgqBl1V/Mu416x1T2FywXqLaiT356xtQoGbQuM1DzzqKtk3
	LKO5krTpjrwonSqx52VUY5VBfrKW7Q9esi67xtDKzVuvTyaORLMjrIpInDqXvoOK86L7Bi5xSrLpj
	LUpCY34lF5x6v4ZobY/56Ynw0WJdKy8NKwc9BH3v8OhpILWsXqIvAwdP1l64IFFi0sxj+1S6GyS8l
	FfgMdNebHrWGLYu4fCDmmmlkDaXQz3O55befnlM3mFeuXp7GTFL3ZTNEyUK0+Dyn+IPkUqLbViQ0f
	kWr/ZoTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3Tk-00000006EeR-0XxQ;
	Tue, 12 Mar 2024 14:51:44 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk3Tg-00000006Ech-3inx
	for linux-nvme@lists.infradead.org;
	Tue, 12 Mar 2024 14:51:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4372CCE17FD;
	Tue, 12 Mar 2024 14:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A58C433C7;
	Tue, 12 Mar 2024 14:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710255098;
	bh=n0TYN4RvuzeQqnNR/vv0ZdbV8Ix0JgbwOfvQ3mcDu7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S8u0Ho8AbaZNPjM11cS15TedAW9WeOIWLQgS0Rb87I5ZdB6vFzp7l9USSdrSULAee
	 kLz9TXFZvZqTkLA8ovfQ2O0rNApC392+3lv1BNxNIoxxsLX2ULaRDeF2r5UPsjNEIg
	 dsaBrBAIl92m4d69nKNt4+9EDmqc1UQ3cPGCj//NTrWwljiEPfaGHIJlXjXtK/E6T+
	 PCitxrxv4VWFaKe1SEeGWUrG1X3EDKcR+jBrdZ8lTPfNUQmLyI9oOj4Hvx1U6LbV5J
	 Cmc1qtgCIFWWop9ZMdO4sl1UxcW7hhDaL5/HFHOO8lBXWXzOFTeYNSN5PQjEaNjquy
	 D4l3wRVTtHm4A==
Date: Tue, 12 Mar 2024 08:51:35 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Chandan Babu R <chandanbabu@kernel.org>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/5] block: add a bio_chain_and_submit helper
Message-ID: <ZfBr91m4oQS_VYFg@kbusch-mbp.mynextlight.net>
References: <20240312144532.1044427-1-hch@lst.de>
 <20240312144532.1044427-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312144532.1044427-3-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240312_075141_279008_81826031 
X-CRM114-Status: GOOD (  13.50  )
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

On Tue, Mar 12, 2024 at 08:45:28AM -0600, Christoph Hellwig wrote:
> +struct bio *bio_chain_and_submit(struct bio *prev, struct bio *new)
>  {
> -	struct bio *new = bio_alloc(bdev, nr_pages, opf, gfp);
> -
> -	if (bio) {
> -		bio_chain(bio, new);
> -		submit_bio(bio);
> +	if (prev) {
> +		bio_chain(prev, new);
> +		submit_bio(prev);
>  	}
> -
>  	return new;
>  }
> +EXPORT_SYMBOL_GPL(bio_chain_and_submit);
> +
> +struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
> +		unsigned int nr_pages, blk_opf_t opf, gfp_t gfp)
> +{
> +	return bio_chain_and_submit(bio, bio_alloc(bdev, nr_pages, opf, gfp));
> +}

I realize you're not changing any behavior here, but I want to ask, is
bio_alloc() always guaranteed to return a valid bio? It sure looks like
it can return NULL under some uncommon conditions, but I can't find
anyone checking the result. So I guess it's safe?

