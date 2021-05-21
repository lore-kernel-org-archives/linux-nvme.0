Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0DEC04FF3
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 19:44:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EAF16140A
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 19:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EAF16140A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vdj/zRseahMVK/OWAyuFEBqExQ79b3EqnFwNjOPblwQ=; b=ZsrqW1+RwCI69T
	jjbxmGvI+9KKiijS+VjzzLErLCckYTRXflgqRfMyElFgM25eJ1laeK3MDD1RWzjdK7O/6RBzw7UOQ
	Jqp4EArS3twuGkQ029Ipdat5Q8rxy3Y/9FqvV1AM82BW1UohqyD/mUYDJGN0Hnz0CYv6gsCT0BKcM
	yTrWLK3HvqiKDwPbCWl8MA4Wm/MZxOgr7Oy9Wn4e0Rlcvt+eGwA2S9reiyB2CEQfsyGi/fCWzVl9H
	1W/JLQQ7enoVXD8C29NQo9IbEO6lDHmW8AmXp9sPlx0pJnDuIbOunEQWRq7DMmwAQKh4XY2qBC51q
	H6Amw02Wafb9MnM9LFDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llGUa-001iyz-Ce; Mon, 24 May 2021 19:44:00 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lk0fc-004S4D-MB
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 08:38:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=RVHzs0poOF+hVS1v1BAW6iRpurNI2FLCHK2qQooBQc8=; b=WE1YE1/bBlmboLG7v/Wkq8PHh0
 g0h8xT14rRSpF+bgtVoBMXJqzz5pHFYT9UDZGA6X171xLwo9JBo0DuivcPG/hqnMSLGaiGTqqEo0u
 1NeYmxiXK9d42O4RlVPMaenN8tC2A1OPO9HBQTMknVFCkw/yoyajsAtHrFThpDxah8SmVzKWjln+B
 li514DacQqEdlACMFgaIetQSEVSJJP3iF5CxmzsW/ybJomBpjMA0ecHuxTQPqjahrHaA1z9+8Iuns
 o6xNQ3TBQcEbGSfys0UE4SlBvMTECed8G0kaT9P6UbGEyW+eaDJ/f+VkMRp/VZFqGDZD9a6n7AjdN
 8J487vVQ==;
Received: from mail-vk1-f172.google.com ([209.85.221.172])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lk0fa-00Gx6N-8R
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 08:38:11 +0000
Received: by mail-vk1-f172.google.com with SMTP id m129so4124758vkh.9
 for <linux-nvme@lists.infradead.org>; Fri, 21 May 2021 01:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RVHzs0poOF+hVS1v1BAW6iRpurNI2FLCHK2qQooBQc8=;
 b=jUt9UuwizU7bJ6HM1OYg6Uqkf2cc/GU4SjYyWmeuVur2ZWP+cpuxsNhINd2mGtEu5w
 9gcGU3tSniT5/WooLNsRwihB7xRRSoH3cmzdm369olNKVU2WZAk4UqJYW0QON03uKUvN
 9E5GvhEIzkz8qBn3ztBVSzh1hLVjFPjmZWFhRB4jbdsq2ecsNBcSSh+gU8Zte/Jm+NbQ
 M3vNS4J+Xx0cZDofRuzK08qUQ8jJPNBlFXYfyZWp+QHePJpXEqwIYgS2L861sh1ZE/2e
 L9jgOyqNRF97nnhW/QwXvRpPZJiF+G7ypd3dQtxnE2Ugri4FkVauAeQ2teLP3XhBI4hx
 1fUg==
X-Gm-Message-State: AOAM530Gil6bmgu40FlfVsiQC6uhdzvEeaNwuQk74toDe2DBwRb9X7VL
 48Sh/Ci5Q+NLuYJNYhl0n0XdSN3/ns80CH2ywDE=
X-Google-Smtp-Source: ABdhPJzGTg0SxZhAyS6W3ANe8pj0R0i+6+zDbI/+BVCcJpHhTvw5AwmdUSLpxqeMfSWaogZWi2MJbcqhNDfvoXw93hU=
X-Received: by 2002:a1f:2504:: with SMTP id l4mr9071521vkl.5.1621586288105;
 Fri, 21 May 2021 01:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210521055116.1053587-1-hch@lst.de>
 <20210521055116.1053587-20-hch@lst.de>
In-Reply-To: <20210521055116.1053587-20-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 May 2021 10:37:56 +0200
Message-ID: <CAMuHMdUReZCGwii_rJuOOag+jmn4E3yfH+=P3a=5bJDf8CJvrQ@mail.gmail.com>
Subject: Re: [PATCH 19/26] nfblock: convert to blk_alloc_disk/blk_cleanup_disk
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 Jim Paris <jim@jtan.com>, Joshua Morris <josh.h.morris@us.ibm.com>, 
 Philip Kelleher <pjk1939@linux.ibm.com>, Minchan Kim <minchan@kernel.org>, 
 Nitin Gupta <ngupta@vflare.org>, Matias Bjorling <mb@lightnvm.io>,
 Coly Li <colyli@suse.de>, 
 Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>, 
 Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@de.ibm.com>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-m68k <linux-m68k@lists.linux-m68k.org>, 
 "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>,
 Lars Ellenberg <drbd-dev@lists.linbit.com>, 
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-bcache@vger.kernel.org, 
 linux-raid@vger.kernel.org, Linux MMC List <linux-mmc@vger.kernel.org>, 
 nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org, 
 linux-s390 <linux-s390@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_013810_312986_10438834 
X-CRM114-Status: GOOD (  18.80  )
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

On Fri, May 21, 2021 at 7:52 AM Christoph Hellwig <hch@lst.de> wrote:
> Convert the nfblock driver to use the blk_alloc_disk and blk_cleanup_disk
> helpers to simplify gendisk and request_queue allocation.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
