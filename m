Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F395FC43334
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Jul 2022 02:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QTtUd0Tb9e3+bEMzaVWDyIca5YM3VB2lsHEMbsECvwc=; b=ArrAn4lRs2x0R0EXTV2Kyf2kIV
	9tNDtpbzRzhivlqmVWhoYuj1CjZ6trLMM/HXvk9YbIGLMpjRbFpiVKO4K6n9QqTaVSay5xdgTME2+
	tN9VdIu9OnhPV+tLP3ZRzenIZ/bIFSjNUB8zhAJ8TPJjaZ6ITV928U57Or6pHzRpHPiTyxIZ9BcyZ
	Z5EqWgmP3AXNPlSOGMqiXmEwwYego0Gcc7wN4VyhAqIQ9YjYAiKXvxiRNJiyh0s74NXxRxgdo189m
	JLjOYODwKJSLX+9XaJyVsRXXR6gef75/Fam5UYumeaVtZKI9jSBg++cQcTWh3Du8KdAOywTYravAI
	RB52ghhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o76aY-002RuF-Fz; Fri, 01 Jul 2022 02:40:58 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o76aV-002RsZ-RI
	for linux-nvme@lists.infradead.org; Fri, 01 Jul 2022 02:40:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 36A1CB82D88;
	Fri,  1 Jul 2022 02:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3014CC34115;
	Fri,  1 Jul 2022 02:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1656643249;
	bh=5CG6PQNhFAVSniQ+OiaKwGEwxvQrcazv+VzD2hwP9Bw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rAJ7IVXDFORay0N5IbRdF31i77wtc1E8/FSV4BLVdfWuH+HKuPDsOKgSO5W2+A0Kk
	 p033exPTScRkdNMu+hIeVvnAerqis/+bzWIMxJMx0B9oUTE5HQNo0ym6plmwkBAREl
	 Tf4QrMWG2ctr76pxY7LcSXDoiPTX8amzrYeCYAejfA1/+5/eL5MgO8f1nsPyCQ3zwv
	 fn6P3DhKBEhjGTAh5wovPzMcxXudoLQv6qWvHT7GDxDOiwXkoK4quJA/MRMuZ0yWxL
	 /mG7Q3LNxRKSE30RWn+XbcbETuhiOxfL0J37ykeZib9hcCLeDcXNpP7NrCO4AQwAsF
	 wj5XmPxXFeyYw==
Date: Thu, 30 Jun 2022 20:40:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@fb.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	Kernel Team <Kernel-team@fb.com>, hch@lst.de, willy@infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCH 07/12] block: allow copying pre-registered bvecs
Message-ID: <Yr5erjAN/NTdIG78@kbusch-mbp.dhcp.thefacebook.com>
References: <20220630204212.1265638-1-kbusch@fb.com>
 <20220630204212.1265638-8-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630204212.1265638-8-kbusch@fb.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220630_194056_064488_931E45B3 
X-CRM114-Status: GOOD (  11.01  )
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

On Thu, Jun 30, 2022 at 01:42:07PM -0700, Keith Busch wrote:
>  void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
>  {
>  	size_t size = iov_iter_count(iter);
>  
>  	WARN_ON_ONCE(bio->bi_max_vecs);
>  
> +	if (bio->bi_max_vecs) {
> +		bio_copy_bvec(bio, iter);
> +		return;
> +	}

Obviously the WARN_ON_ONCE needs to go away with this.

And with the follow on users in this series, there's also a bug with putting
page references on these at bio_endio, so don't try testing pre-registered
buffers with this series. I'll send a fix in the v2 if we get that far.

