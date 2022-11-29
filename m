Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D598C46467
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 14:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H12KLwGgXNlj5+xJglLipLNbKQPkjwGcnP5LSARIaXs=; b=BQklcEzCVrmz/gMaUeOjY+By/O
	0juPBFk504pdH/320Q9nys7em7J2sO+1DotsNfnsC4e4l2FJyUszl+/HpFlfMh2LS/4VSoZ55jDaS
	f2d8UCmylF5lXehpu6zm4eIwE9u4QUNLBs3nGpkuL1Fagbe/q5dg4F6W1+KY7Z90xwh2uEZ/Jpzix
	1EE8xpCZmilo2bfM+phTPCM8XRjqV9ug1xxJOeDZQ4OhTQ+ekzJquIGG9Ire58FpPvRd5M7vpRW/J
	e2CnHNnRti5HK1+F323J5cPRzhWXwVP6xxEhBSP50o03/a99zzwlo0ya9mJogR+YwoXItMdJ29Ej6
	mQDuVZrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p01bA-009Fvt-Fm; Tue, 29 Nov 2022 14:28:36 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p01b7-009Ftr-Dq
	for linux-nvme@lists.infradead.org; Tue, 29 Nov 2022 14:28:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 37C546176A;
	Tue, 29 Nov 2022 14:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 191BDC433D6;
	Tue, 29 Nov 2022 14:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669732111;
	bh=HkEU1+9tgYVEGam9m2b9sn+qf1Iht+T/ZI36+M1KNWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MXBEppicUuEOxUYAyZbyMLqN6XTvu8wNTnv2nrCgOSGync0rca16SCEJ8yIXciE9d
	 JjB0QtEZ0NekSE8xKTflRtaTP/YqtAUHg3hMz9wSRu02kcpuCoj27A2qSUuu3zYi6/
	 C5d8OhAGU90gVeYaoEq2sdMzuCZYLROtkJWEzFx9Yd1vl2cBPHggZg1JesANIlVGyH
	 ZFJvrny/nTfuBmtapYaeljv2WzmpOJaNu4Bc3ToIOEqNi2/zPehT8fg9XNuZwLRtSo
	 0NFlUWul1wgWbVN4C90fbgyuoX3aXNId1oecztxPevrghA5XNHh2Zu8NMNKI6R1JLK
	 iCwMu8aUGZBog==
Date: Tue, 29 Nov 2022 07:28:28 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nvme: introduce nvme_start_request
Message-ID: <Y4YXDAZDZQbnLIbF@kbusch-mbp.dhcp.thefacebook.com>
References: <20221003094344.242593-1-sagi@grimberg.me>
 <20221003094344.242593-2-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221003094344.242593-2-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221129_062833_521183_DF0D9C21 
X-CRM114-Status: GOOD (  10.86  )
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

On Mon, Oct 03, 2022 at 12:43:43PM +0300, Sagi Grimberg wrote:
>  
> +void nvme_start_request(struct request *rq)
> +{
> +	blk_mq_start_request(rq);
> +}
> +EXPORT_SYMBOL_GPL(nvme_start_request);

Looks good, other than I feel this should be a static inline function in
nvme.h instead.

Reviewed-by: Keith Busch <kbusch@kernel.org>

