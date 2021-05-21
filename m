Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670AEC04FF3
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 19:48:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B06E61004
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 19:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B06E61004
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2EsGy0xRn04GxEqlV1e9q/ZGmt5nehTzuuggh/d2Sls=; b=vYfkzEmlvse9OW
	Kigw/DaR9y7oiJf4IUr+lVhc6bzIwGkpN2jDok6yQ8ervcaJ/RBo4s+X49O+zjxfrqacx00yEDJ40
	1Bt74jEw4guKUhBz01Q3MHSK9UI2OSlHNSqyvnCWlvlULyx1y+cfw2E+h2c8A0C1W7+ZguF9i0Sgu
	CtZ9LeDFVmeguPsxD4aATDArdXzYFuPDZfuMkuGUPtUNUNg1XPjim/Xe+mtyOJJvkudtTs5nbyoLh
	kfjWm8scOlt2TEjwbGxJRCXoL00f8pnam7ymKp4vqvbOXKz8T8ko4RIOylV/VQ/X+/7Um8cmLDqcI
	7huqv31Z8WTCzLQyYf3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llGYZ-001jib-Gv; Mon, 24 May 2021 19:48:07 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lk8x5-000VMI-2t
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 17:28:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=B30rffgHFLYBI6xwi77IEdIESyslCgwa8HluqL6arQs=; b=YqEjjq2peiqHtyW91B7+33KW8/
 KaLPzj0E8jm/KMW24364NEMcnpFpUd4z1Gi7+py/r3iUcWlDcNWHtXHprqzXpUeYCwLCIsMzDMnAf
 8E4EQwLgTEChDq5YWnbfpmxW/+tt5NX93GCiO/k0Mpotpm4Y1bHfYU2MitQfYSyFFg/ziw9RqS92h
 Ult3bMGtkYDMR4MW1oEilchExJF1Ik+8Ro+w6Qt3vZzjIZPBnNy9BT6+9rB+uMg+TU3lax95TJhvJ
 bq/1LUDCkYAijbZqUlwIth47r6X8HKcu+MaeVXIqOeYcswb6DaZeIfAqZqb3RWU7/ju0e3CqLU9FC
 6+bC0pfQ==;
Received: from mail-pj1-f45.google.com ([209.85.216.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lk8x2-00HJTd-LL
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 17:28:45 +0000
Received: by mail-pj1-f45.google.com with SMTP id
 cu11-20020a17090afa8bb029015d5d5d2175so7702066pjb.3
 for <linux-nvme@lists.infradead.org>; Fri, 21 May 2021 10:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=B30rffgHFLYBI6xwi77IEdIESyslCgwa8HluqL6arQs=;
 b=fPNFRdsoCIf5ToGsHO2213yzkLbczYEmskzlL2hAhITYA9SKYN4IDee9FFgnXZb4dV
 s1D1CdvFDlXrBk8WA5zLDFU/8ydBhcdn0Aen69tmxUr2PVmdS2JbusbpdBpuWz4fvend
 63UK67YZkj4cfY9TlHnjKHMy/A2x0DJR4CrMURgjqAyQAqBVJYRiC2duMaYrASMftu6U
 eEopn/UKe/j0QgOmqhZq2NacsIBm1085tYr3tL5R/cMZe7ggK2hUwvlViIZ3/TYl5t5g
 /T/09EognEUIJmF6POvX48OMMWtYOr3EJ4Ncy/LAwIQlI2oavpXCJppjIcKz1WvhUkQB
 YFrQ==
X-Gm-Message-State: AOAM532S7HnMS45ErCmD6P90H+CQcDL2QC6/KyIUeQiPaVj5Oxy7YCBk
 u04m4Eu3x9ALs9y8pRq4hjU=
X-Google-Smtp-Source: ABdhPJyrNWjuuiPeUt5pQpc8nPl0WeqbdGuJLCj1G2mOrwbN4glaACuKyX0vSa0sudDl68ZR50luTQ==
X-Received: by 2002:a17:902:e8c8:b029:ee:f249:e416 with SMTP id
 v8-20020a170902e8c8b02900eef249e416mr13149158plg.3.1621618124047; 
 Fri, 21 May 2021 10:28:44 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
 by smtp.gmail.com with ESMTPSA id p19sm2008772pgi.59.2021.05.21.10.28.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 May 2021 10:28:42 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
 id 77877423A3; Fri, 21 May 2021 17:28:41 +0000 (UTC)
Date: Fri, 21 May 2021 17:28:41 +0000
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
Subject: Re: [dm-devel] [PATCH 04/26] block: add a flag to make put_disk on
 partially initalized disks safer
Message-ID: <20210521172841.GA25211@42.do-not-panic.com>
References: <20210521055116.1053587-1-hch@lst.de>
 <20210521055116.1053587-5-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210521055116.1053587-5-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_102844_718264_2B044646 
X-CRM114-Status: GOOD (  13.68  )
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

On Fri, May 21, 2021 at 07:50:54AM +0200, Christoph Hellwig wrote:
> Add a flag to indicate that __device_add_disk did grab a queue reference
> so that disk_release only drops it if we actually had it.  This sort
> out one of the major pitfals with partially initialized gendisk that
> a lot of drivers did get wrong or still do.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
