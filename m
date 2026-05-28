Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFD6CD6E45
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 03:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xjVsOQMWJ/idl7592wbOBDSCnbZK2DbV+SpTbRF46gk=; b=AWiuB188zCcI/DXj+DwchF8V6L
	YZ8tyILzMyZwkhEuU4D5t7s8g2Qh6WxSkshsqMzAa3f8r7aPGJwH9yr0UUpZC9LdSSrOP6lK++bbc
	c/ZG6NwkqZLzN3teP4m9XEKOrE7Eq8F5gZXD1oYuQjMpieksPTPeZcScovHTg9YQOfRYq3uxU2R50
	7wHSstqwA38DkVTwr8Bj5UBSuKadwKCt8axctO6ipcCf/Yc4PCVuxXXNdodvnWSlGsEOH8ONqfRTz
	uAJXfZDgCSAh1Qll0kAckUtLZGArluPlK7PeignNDLxHa9k2KZ5Myk968SX4t3cuWj8U95y81Tl3o
	sqTizkOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSRav-000000054L7-10G5;
	Thu, 28 May 2026 03:39:41 +0000
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSRas-000000054KL-1qp7
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 03:39:39 +0000
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-90fe17c157aso1315863585a.0
        for <linux-nvme@lists.infradead.org>; Wed, 27 May 2026 20:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779939577; x=1780544377; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xjVsOQMWJ/idl7592wbOBDSCnbZK2DbV+SpTbRF46gk=;
        b=pM0M9mUgOjvVef2KLZn4RvFPtv6Fa+rQENxt8gaD+8mI4BoQVCTppDYZbCP4smMVTk
         NFCZnfNReI6qbRX+0omVJKIA8V09VpQh27pzJQOLRYj6NTPcRvYwkF5QLvqR5VN7Bpp0
         0wW3A6KTtvcfErlXXD/G4NhfB6dceQ9k0poC2N2PM6AIPFrOSxqdaGZ8UHIyyPKcL77A
         bxIX506P2KkNIfkLthTx8GxQaNQRb15uvEIp6HpTOZ7u/sHhFL68+SUld1PEJDQyDLyG
         Bk+7LW5bAWsVSS5yOwIxz4CiZmDK2h4LW90kMS3L8YNpMh/EkFRrw+KxXAmEAsW4iFKh
         Gabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779939577; x=1780544377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xjVsOQMWJ/idl7592wbOBDSCnbZK2DbV+SpTbRF46gk=;
        b=eUmlGJURdjdK8Z0BKvBsPBw1i1ufFTladKuuEPnoPIp1vV4NHZ7jR2hiv+R6jLN0JA
         D5hVRib5DeETKlZ6mCvfcQ6s3i//zcTzDj9+Mb7gpHV7eRYVNlp5cqr1nn2f0n3epHUg
         F66klRhm3JaslxX0yExHMES4fu+UtoBWgu2gharuqjOwbk5JTRyufn65bszIcmLEHQMH
         P5OC+yUDiArvDbO9YcfBa+x7TKJtUu5uajcoVIFG2sm4d0w5mn4IEoZVn+4wIQ1w29DT
         0z/P7ZnEHMh1Q30ISPWgW0M/UcBwwTO+LsxTOgLjewCeSjpTMIXil/t0iVk3vyHAmoVM
         1IJA==
X-Forwarded-Encrypted: i=1; AFNElJ+XS+pVooky+FxXrXzrdEN8A4mGNdtjAQr/cJfFRtk4afb+whZtBD7DpWvifObEYJo6Pb5lxmW+zgir@lists.infradead.org
X-Gm-Message-State: AOJu0YyioXZBhTxo4czRDij2xdrxVKV7ILgBFnAzwiVJ0y39qAbZLPb4
	XFoWzqwoDxl2JKpmMzfpakp8212xufsd1yT6Nx6CozCOLaQZvxoYHTvZ
X-Gm-Gg: Acq92OFZxzNfYoq26Nxk6tDXaH6tuHwZpZ8vJkmyrUiBDIGlfbQw60oM/ETVyuNnP0s
	4rcTJzzVMA/J7KOC3ybuCgdEfXyNki3TUNtyA41Ffhag997n2Vo79iOfI02arjP+uikS/oGOxvF
	ollBAgA3slSczXd+OJN1ZNfTaAuOnCGQvhA4hWS64OrrqM2TuAAhsCz95616zWcZ+knkSYoFKvn
	+WfJghnhOFBsKvRle8EDUXudjwJEsmzK1RXZScB61FFZ3WYze1P8Qg1RxfGxa90Wwp/GOpEdA9t
	DLTxMoNU7uGJM3nNz7+T25svSIwUmkCbyBCmNvEahWqi2ur9kq/2HbfY71PiTUzi7fyCzM3HBsL
	elIKvHkt4d2oE3DJGdYk1yd5a6YnNtw5YihBysONKTKmfAObA45Ansn7Acb1gwwzkpyR31zN/r9
	aKRQ1rlWfG9yp78O02hrebnb7vADEFSRtiRUaCRJluTq/Ys1X7h6GEsbTeosanDgcfFfeJq6gdu
	tuJ/5Uu5L4fTnoqeiTie6EN+9XkQTWO
X-Received: by 2002:a05:620a:45a4:b0:913:7bc8:79b4 with SMTP id af79cd13be357-914b49f711dmr3672366385a.51.1779939577133;
        Wed, 27 May 2026 20:39:37 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80ffca70sm187161236d6.22.2026.05.27.20.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 20:39:36 -0700 (PDT)
Date: Wed, 27 May 2026 22:39:30 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bart Van Assche <bvanassche@acm.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/3] nvme-tcp: cleanup nvme_tcp_init_iter
Message-ID: <ahe48vG0zzOifp4e@fedora>
References: <20260527151043.2349900-1-hch@lst.de>
 <20260527151043.2349900-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527151043.2349900-3-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_203938_483139_B5D002E7 
X-CRM114-Status: GOOD (  12.71  )
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

On Wed, May 27, 2026 at 05:10:21PM +0200, Christoph Hellwig wrote:
> Split the two init cases based on code in the zloop driver.  This
> simplifies the code and makes it easier to follow.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks, 
Ming

