Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093A4C04FF3
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 19:47:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1FEC60FF1
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 19:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FEC60FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QRrl6QO9+swvbaFgGy/Ie3JQm6XUudb2wAxlrd+doys=; b=G6gUhijbYdkprQ
	zd0F94ujUkFuRgz/oT+H3siusdzsO9xTOQtI3LmyXpiuT9D8A+fKPsC8C/8z0XTRGK5jHoREFuG1e
	RX5ZmRGc/eDJXdDmYPH8hrnWFz6us7xDjjI0yRZxB2Fo3+sSTxvjj+ulMlQRyULh/WdCXKGmdfINy
	cNFOTncMtgVg+W/YwFfeNzb0HOb7ZjBFjYZXlxGUnOxCq7Eb11THwCiKaFcwNFXcBnjRn6gdRrcPk
	An62Lw10KpFbW8/TMn5zr5DTYxztqJ+W57MJyiyrJS35Y+uIfLS1nhsGLzifW+gFrA/z9eboQ85j6
	xxY23GT4jWNnzVhp6ykw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llGXW-001jYr-5o; Mon, 24 May 2021 19:47:02 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lk8rD-000TYX-GH
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 17:22:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=4xwt7H3ydSynAZjOEHISSkaEhx58URrfefqnsYajrYo=; b=vpkVnXoz73vKmMsEysOI32mybZ
 kRpv4JGPx9LBNNyMZGw8RlDu8tCriWRQqPDlYYtjU5zmN5/OHNbODpDDSn8OhSvFeF36lpCw6lX/a
 xMkKHYU/mPLjb1KEkUBBLPBSdBoEe5qZMtyh/xGcFMwKKTFfzmK6mfpdAolI++HAY1QKWcWDOe0fX
 GzHx1lnl1EZRRnoYJIFzEdZHAj48Critl+YVQx02/AUCbfbosI2EZB42rkBW9p9Hu1Jfc0MVqOvXl
 Mdgq6T4VyAQ6lo1B95d3O5d07H1NECAhpK+tRML3ImO6f/CGQ6Jp9K/MSUVkToX37oMhTOFLGgdML
 cIEEMKqw==;
Received: from mail-pf1-f177.google.com ([209.85.210.177])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lk8rB-00HJEQ-4X
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 17:22:42 +0000
Received: by mail-pf1-f177.google.com with SMTP id g18so13724017pfr.2
 for <linux-nvme@lists.infradead.org>; Fri, 21 May 2021 10:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4xwt7H3ydSynAZjOEHISSkaEhx58URrfefqnsYajrYo=;
 b=eKnZv3kU5Mhp8mOhkqSyO4wZF06KCORJdpxQe8BW1WD6TC9pe1vjCp/ciDTR72lMbO
 4MMZq5oGyhVvvRHZJBciVH3rDGIO0K3ynrUv7TL1zPdxgJ5BPwaM6LWtvy/X1ckJaWtK
 i6iEm6YfCPkeuhtk5TgnxPMz1Yd94OnLOQXL3tAyvivEJJBIu1BBWA1lnZiR2EPHuh1/
 mK6RWlurSh9cwIOAsb2RnLxckUYS7GWG4zQs674/6XEUNrv6AwefrTRwOObYywOb2FO8
 xR2NuPJL3XLkg3Cs7brr2FwrjmGXLFU23tcH0zaHoJI/ISVXfksugjYuYgGaBH975qw3
 KqoA==
X-Gm-Message-State: AOAM5312yF6xOtKvigrk4VnFHtfBEJcRxfaVYeVk7FHD5mfWXWjcJrxH
 b/B/0ZX6ehVqxA8AtMwg0D4=
X-Google-Smtp-Source: ABdhPJwN/SKOVHqzTq8eMNvLlpfI5p0TUMMcGqBBBfFtPi25TxwCtdfeNJoGCkAE3FkaxK6OlRwjhQ==
X-Received: by 2002:a63:bc19:: with SMTP id q25mr11009138pge.211.1621617760179; 
 Fri, 21 May 2021 10:22:40 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
 by smtp.gmail.com with ESMTPSA id o10sm4951196pgv.28.2021.05.21.10.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 May 2021 10:22:38 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id F13FE423A3; Fri, 21 May 2021 17:22:37 +0000 (UTC)
Date: Fri, 21 May 2021 17:22:37 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Jim Paris <jim@jtan.com>, Joshua Morris <josh.h.morris@us.ibm.com>,
 Philip Kelleher <pjk1939@linux.ibm.com>,
 Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
 Matias Bjorling <mb@lightnvm.io>, Coly Li <colyli@suse.de>,
 Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
 Maxim Levitsky <maximlevitsky@gmail.com>,
 Alex Dubov <oakad@yahoo.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 linux-xtensa@linux-xtensa.org, linux-m68k@vger.kernel.org,
 linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-s390@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-bcache@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 drbd-dev@tron.linbit.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [dm-devel] [PATCH 03/26] block: automatically enable
 GENHD_FL_EXT_DEVT
Message-ID: <20210521172237.GA25156@42.do-not-panic.com>
References: <20210521055116.1053587-1-hch@lst.de>
 <20210521055116.1053587-4-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210521055116.1053587-4-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_102241_193620_9AC408C8 
X-CRM114-Status: GOOD (  12.72  )
X-Mailman-Approved-At: Mon, 24 May 2021 11:59:45 -0700
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

On Fri, May 21, 2021 at 07:50:53AM +0200, Christoph Hellwig wrote:
> Automatically set the GENHD_FL_EXT_DEVT flag for all disks allocated
> without an explicit number of minors.  This is what all new block
> drivers should do, so make sure it is the default without boilerplate
> code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
