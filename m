Return-Path: <SRS0=5VvL=N5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CDBC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 07:48:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D2D561102
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Sep 2021 07:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6D2D561102
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wesKekXvjnVlhaQ/A5U1q0FqgQKaXH+YIQ9/2aoH27U=; b=reMQ93pZtHQn9M
	bFO1CYqR/zFsjRLR1G2YxAUkP0HjmbpwTq8KQzlSoa3nou+1AO3dEpJZq224cua/ohd/eyOrPlqyO
	Y54PpSTnSBA3jbQ+UCF5eNb7Xn9kPZrlOucZMKJyT70NyBswIzK1UzRvQocXJDsFG3kYhoEzpoGdK
	8k06Gz4tasD6lYulSbVVkfsFR/Kkn9j9GAna2He7GQ+Ph6BWp0vKtFECedS6tjhEyrE9HJ/ragh6P
	Jz7kf8NXrbbSAR60r3hGAQMkQg9bxbUYMBXxNYt/3CVoj0xrHwq0PX3pXwM4EQGO5VVuJ/jEgORit
	Wd5US4Yym31bQbAYLgnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNVpt-002mXS-CT; Tue, 07 Sep 2021 07:48:05 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNVpp-002mWQ-W6
 for linux-nvme@lists.infradead.org; Tue, 07 Sep 2021 07:48:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 14DD667373; Tue,  7 Sep 2021 09:48:00 +0200 (CEST)
Date: Tue, 7 Sep 2021 09:47:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 anuj20.g@samsung.com, javier.gonz@samsung.com, hare@suse.de
Subject: Re: [RFC PATCH 4/6] io_uring: add helper for fixed-buffer uring-cmd
Message-ID: <20210907074759.GC29874@lst.de>
References: <20210805125539.66958-1-joshi.k@samsung.com>
 <CGME20210805125931epcas5p259fec172085ea34fdbf5a1c1f8da5e90@epcas5p2.samsung.com>
 <20210805125539.66958-5-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210805125539.66958-5-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210907_004802_219785_55BF330B 
X-CRM114-Status: UNSURE (   9.29  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 05, 2021 at 06:25:37PM +0530, Kanchan Joshi wrote:
> +int io_uring_cmd_import_fixed(void *ubuf, unsigned long len,
> +		int rw, struct iov_iter *iter, void *ioucmd)
> +{
> +	u64 buf_addr = (u64)ubuf;

This will cause a warning on 32-bit platforms.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
