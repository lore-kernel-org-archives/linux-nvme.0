Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027F8C6FA82
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Sep 2022 18:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Ygx506LgmFK7L1KUAyuf5pe5qs+tRV+yvCiaInsACw=; b=indu3WKnvRz9xHhYjS/MidZA+c
	yjRtlIXN/Q5hizesgINIHt/t7hV2xFEYm+bdbSkcRr2A2xggihwBIxPF1SEdh7MoOwZ4C5WNgxmW4
	ZD9TQ1hc8KfRK0H1qSROIihiRJAk549fVAUUwF1mZu+LV4Ijvm0yfZEEPnt+CzSK7MR5PnL260Bdr
	CUhkJhxG+NkIMPOPyN3h8/NKRAPrXae04c33N5pmNC2/8A93BkIFG8ra0a5q3pTtYwVu43Uf4dTNY
	jMjgnyHtjYvi1SLW8IuQbnSFva+SKLB4xNOWmmpymACY30aiCAybMX9AWKsV3KMJO+UY+cHO/mu1t
	7rQgBeCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oUBde-009gbz-B1; Fri, 02 Sep 2022 18:43:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oUBdY-009gV6-Mt
	for linux-nvme@lists.infradead.org; Fri, 02 Sep 2022 18:43:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662144206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Ygx506LgmFK7L1KUAyuf5pe5qs+tRV+yvCiaInsACw=;
	b=JweQv4mpthRJ2JK5IxWu6Q4Bryn/BdJdJ6hqGWAxsCv1dByAzWBiqyoj/i/8wd2gci7cFN
	k932ZiUodqlmlz8pCe0jgoaP/RiTPvHkRrD37MQvUBSQoqupLyaeiz7cXSmERwkwDxZtb2
	4K8e8mblY0PDhcrvjMXs2NzkV8UW1F4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-651-nfrHuhu9NPu1FIjGN9GY3w-1; Fri, 02 Sep 2022 14:43:25 -0400
X-MC-Unique: nfrHuhu9NPu1FIjGN9GY3w-1
Received: by mail-qt1-f198.google.com with SMTP id h19-20020ac85493000000b00343408bd8e5so2166411qtq.4
        for <linux-nvme@lists.infradead.org>; Fri, 02 Sep 2022 11:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=7Ygx506LgmFK7L1KUAyuf5pe5qs+tRV+yvCiaInsACw=;
        b=Vj1mzBttGZ7Uqi1edVvZeoivhqrnG0tvJ0IsMiNNSVQDz4N2sqsdZ8X4ydz7UcA6B3
         J6nGc7HY8p7SnErZL1LLmQ78kF/rB7XzJsCgLUc5lOVif2VbNfWXld33aBshk1ykbvY4
         J015Ox1lVjaiT8mQNaK/yEIkptI1tTgY0YH63mB/r4unoEq8OmC7CQGbMhBcehg03LVe
         v5qxiPLhJplvSyPlLJoLiUHx0aTuLbITImBePQuDBozyo7h77d+r369xkcrcih8smdpO
         l94GHuuE98ALi6+ggcYPgKMsz9YXA0mdaZkocH+QPJ6yd3xhpUeh3h7SrivtHo8Wnc8m
         1SmQ==
X-Gm-Message-State: ACgBeo3xLdnrAubJQpAzLa6HBlf9AOzsmZP76yg+LcirmQ41l9G7s8M8
	ChariRnZj/NNEVomYJ4xJWHdrzmGNFOBBHbVYgYZYN28elNRgFH3e0AmyTxDBJSxsKbXENpO/h+
	Rs8GyZQim7x22hAz1ZKpMgoU7Gw==
X-Received: by 2002:a05:6214:c8f:b0:499:21eb:ba3b with SMTP id r15-20020a0562140c8f00b0049921ebba3bmr11683321qvr.97.1662144204585;
        Fri, 02 Sep 2022 11:43:24 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7K6nBjFNlybScTP7Kemi+J2G3yUcqV9Mva+4TXiBdaw+VSNZOrU4SppDL6kJQ3vHr68+qN5A==
X-Received: by 2002:a05:6214:c8f:b0:499:21eb:ba3b with SMTP id r15-20020a0562140c8f00b0049921ebba3bmr11683298qvr.97.1662144204338;
        Fri, 02 Sep 2022 11:43:24 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id c4-20020ac84e04000000b00344f936bfc0sm1406919qtw.33.2022.09.02.11.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 11:43:23 -0700 (PDT)
Date: Fri, 2 Sep 2022 14:43:22 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
	damien.lemoal@opensource.wdc.com, hch@lst.de, pankydev8@gmail.com,
	Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org,
	dm-devel@redhat.com, hare@suse.de, jaegeuk@kernel.org,
	linux-kernel@vger.kernel.org, matias.bjorling@wdc.com,
	gost.dev@samsung.com, bvanassche@acm.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v12 12/13] dm: introduce DM_EMULATED_ZONES target type
Message-ID: <YxJOyq8Pf2vIExFf@redhat.com>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121914eucas1p2f4445066c23cdae4fca80f7b0268815b@eucas1p2.samsung.com>
 <20220823121859.163903-13-p.raghav@samsung.com>
 <YxFOS8fq8AeE5mkf@redhat.com>
 <96f90e1d-aa0f-1c76-bfc9-a87e978ad655@samsung.com>
MIME-Version: 1.0
In-Reply-To: <96f90e1d-aa0f-1c76-bfc9-a87e978ad655@samsung.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220902_114328_838543_8E14D715 
X-CRM114-Status: GOOD (  18.13  )
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

On Fri, Sep 02 2022 at  8:02P -0400,
Pankaj Raghav <p.raghav@samsung.com> wrote:

> On 2022-09-02 02:28, Mike Snitzer wrote:
> > On Tue, Aug 23 2022 at  8:18P -0400,
> > Pankaj Raghav <p.raghav@samsung.com> wrote:
> > 
> >> Introduce a new target type DM_EMULATED_ZONES for targets with
> >> a different number of sectors per zone (aka zone size) than the underlying
> >> device zone size.
> >>
> >> This target type is introduced as the existing zoned targets assume
> >> that the target and the underlying device have the same zone size.
> >> The new target: dm-po2zone will use this new target
> >> type as it emulates the zone boundary that is different from the
> >> underlying zoned device.
> >>
> >> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> >> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> > 
> > This patch's use of "target type" jargon isn't valid. 
> > 
> > Please say "target feature flag" and rename DM_EMULATED_ZONES to
> > DM_TARGET_EMULATED_ZONES in the subject and header.
> > Good catch. I will fix it up for the next version.
> > But, with those fixed:
> > 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > 
> You mean <Reviewed-By> ? :)

Ah, yes Reviewed-By, force of habit ;)


