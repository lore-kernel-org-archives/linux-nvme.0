Return-Path: <SRS0=y1aL=4R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AA9C3F2D7
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Feb 2020 05:54:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20FFE2468A
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Feb 2020 05:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tiNlfHsF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nidP6PGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20FFE2468A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OFAI0Y2AHy4GTp1MJ4lN2bZxivikX+Qieag4XoYGRlQ=; b=tiNlfHsFSYnyVb
	epMJM3eA3jZQo584iHIB/r2CvxHkcUcV8UQbE1s8jQRMSsreZE7nzJeOCh62ek65Oj1Xj7tGctkbt
	rP5goRCPNNtja2l4Poe9x2f7hay/R+NFB5Pki3NdgvDMu5W9yVyW+HO6iNH9V+EGCL64TPpikjFCY
	yAERy72Jd+fkyHNX9lZVdJ8WBYViwhgOsxuQmdexNCi8Nn6Fz47H+0a0/JTU5VZ8TRiOmmTlelskF
	uekCYhA4kkyzamUiAj90pFTQHYUUpp8WP0wNhGYWuRnuNKxMi5FJJzK28TmRKFcKuQAwSmCOy+TVB
	2oMexsTWeHvKHSJmnuqw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j7v4Y-0000sU-Lb; Sat, 29 Feb 2020 05:53:58 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j7v4V-0000rk-SZ
 for linux-nvme@lists.infradead.org; Sat, 29 Feb 2020 05:53:57 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0B3542468A;
 Sat, 29 Feb 2020 05:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582955633;
 bh=ruzyK7UpHx6ugn0FDSQ5RuK5pAVzSpFuYGBk7gC4g34=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nidP6PGED6M7aoZkHS9EiQEjlBKoTzUTsbZJDznO6yrCajoMdBJXLWf51gPO7mim0
 qNNMZmyIEq+kBX5SAY8bvQcha6nlD3ygC36LpNMHRBQTg3V/Zfx/jb3WagWzFKJ4Nm
 FNLzTX4cYpPCZPoHEujHcikzA2M7uuNYNj+Qb6YE=
Date: Fri, 28 Feb 2020 21:53:51 -0800
From: Keith Busch <kbusch@kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] nvme-pci: slimmer CQ head update
Message-ID: <20200229055351.GA542920@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200228184519.GA2281@avx2>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200228184519.GA2281@avx2>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200228_215355_945744_7845EB00 
X-CRM114-Status: UNSURE (   9.55  )
X-CRM114-Notice: Please train this message.
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
Cc: axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Feb 28, 2020 at 09:45:19PM +0300, Alexey Dobriyan wrote:
> @@ -982,11 +982,9 @@ static void nvme_complete_cqes(struct nvme_queue *nvmeq, u16 start, u16 end)
>  
>  static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
>  {
> -	if (nvmeq->cq_head == nvmeq->q_depth - 1) {
> +	if (++nvmeq->cq_head == nvmeq->q_depth) {
>  		nvmeq->cq_head = 0;
> -		nvmeq->cq_phase = !nvmeq->cq_phase;
> -	} else {
> -		nvmeq->cq_head++;
> +		nvmeq->cq_phase ^= 1;
>  	}
>  }
>  

Looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
