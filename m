Return-Path: <SRS0=hrUZ=HW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BAAC433DB
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Feb 2021 03:37:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D69964ED7
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Feb 2021 03:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D69964ED7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=P+S9rrpxHw0UNNP0EZU4r1xxGC8qi4fH7Ney+PgUrDY=; b=mjDfjUJeav5lv8k12ytRMSCl4
	Hsc0eL6zSZcSdhoEdwnWHUUxCjFXP1e3YLBpXdrVnk1j0J0WS+7/rbR8dDo6lsEqYIZg6WddOH5PY
	0bYGlTWMObS6fKgzq7YqqbepfkYkBXgzqJn6PpjrQS+Te8y6aQ93rtnhTqytiDGG1bER3TzcqzV1S
	jMKvmJf2YWPRv7Rw/uqvg4NzXDEo7v8LZPjs3o5fAt0hH7N7kWwJCs2jEuGCsMcYYbKANS1f70nUd
	pmAYyKFz7E61NYv6Htpktb/bbFtmkWMBbvdQYPGDJWwWCqeI64gIyxSh5plfhJGlxPpwBYhIXnGvz
	Ql8+S3pAg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lDJ51-0006AV-NK; Sat, 20 Feb 2021 03:37:15 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lDJ4y-0006AO-Gi
 for linux-nvme@merlin.infradead.org; Sat, 20 Feb 2021 03:37:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=BVvSTy4Ph1YhvWKdzvOR3CYS1ZzHodAH4zck7F/I9So=; b=iOuAFPLXlVR9yXhHEn49dj0XHV
 34VeudUAA30kub6pjTR/kgAfiVwLgagCpSxGgR+KlhRTUSVexeBMW9vEuEYZ41FFw0BsCfebZ0/CS
 TwnqgYlyUGbiXF2tcEL5VRe5BmmoMJnkYeQ/iBAVvj2Iug9g9GYRPDkw2sGUncVjHFqv4h0AnzxEx
 Rq6AUYa0+Oqeyk0qr8Vg5huuZ7u0WW4qACGFntkRXtRsNDW/QyhRVq4DTxThQ4Cr1myiWVwyb25HA
 jr96yA9BRwHIjkVj255aEi0j+QB7ZvVfCU+ppB8E+FFvIQvYe6Vd23S42bCRbskvayo3M+Z90Nwih
 EVofeSww==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lDJ4P-003aOy-38; Sat, 20 Feb 2021 03:36:48 +0000
Date: Sat, 20 Feb 2021 03:36:37 +0000
From: Matthew Wilcox <willy@infradead.org>
To: SelvaKumar S <selvakuma.s1@samsung.com>
Subject: Re: [RFC PATCH v5 3/4] nvme: add simple copy support
Message-ID: <20210220033637.GA2858050@casper.infradead.org>
References: <20210219124517.79359-1-selvakuma.s1@samsung.com>
 <CGME20210219124608epcas5p2a673f9e00c3e7b5352f115497b0e2d98@epcas5p2.samsung.com>
 <20210219124517.79359-4-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210219124517.79359-4-selvakuma.s1@samsung.com>
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
Cc: axboe@kernel.dk, damien.lemoal@wdc.com, kch@kernel.org, sagi@grimberg.me,
 snitzer@redhat.com, selvajove@gmail.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, nj.shetty@samsung.com,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 dm-devel@redhat.com, joshi.k@samsung.com, javier.gonz@samsung.com,
 kbusch@kernel.org, joshiiitr@gmail.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Feb 19, 2021 at 06:15:16PM +0530, SelvaKumar S wrote:
> +	struct nvme_copy_range *range = NULL;
[...]
> +	range = kmalloc_array(nr_range, sizeof(*range),
> +			GFP_ATOMIC | __GFP_NOWARN);
[...]
> +	req->special_vec.bv_page = virt_to_page(range);
> +	req->special_vec.bv_offset = offset_in_page(range);
> +	req->special_vec.bv_len = sizeof(*range) * nr_range;
[...]
> +struct nvme_copy_range {
> +	__le64			rsvd0;
> +	__le64			slba;
> +	__le16			nlb;
> +	__le16			rsvd18;
> +	__le32			rsvd20;
> +	__le32			eilbrt;
> +	__le16			elbat;
> +	__le16			elbatm;
> +};

so ... at 32 bytes, you can get 128 per 4kB page.  What happens if you
try to send down a command that attempts to copy 129 ranges?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
