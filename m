Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4837BECAAD8
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Sep 2022 18:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+1Y0WCFyP/xwaopES4fLdWeNPtgD6wFT9927YdVHjxA=; b=obEKl2okPMzxW3Fb9/Bq4HOEZA
	19PYuyqhs4XrQ1yEj0l1STcHalBD+xzeG7mNCBiwz7IE/HXFtmNeRpLc6FcOf8B5FlPfP1nXN8unx
	U3hpvwF0kS6xD1hktR2UvbF2XyNQBksBII9VC1bU8Debfody0vwLCE77TgpdFB878VXtVlIA5pxIt
	rMEkQ1BgH7Ujg3ap3PfmNwifQba5S0+WhX7lnwmk2qiV4kX3wASqDAvv/5I+VVpT7tS9BDDYzsLY7
	E6TUNWtxIGmpaUsBNVJ3MMyprzdRiFDWQcIj27QfRNJKzD0A9ITZHQ+GKhi6LPctu9RJwGyAqHXbv
	W41HGwHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZFha-00Ffh1-Ny; Fri, 16 Sep 2022 18:04:34 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oZFhP-00FfZy-1r
	for linux-nvme@lists.infradead.org; Fri, 16 Sep 2022 18:04:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663351457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+1Y0WCFyP/xwaopES4fLdWeNPtgD6wFT9927YdVHjxA=;
	b=UakwEG+Sp8g12BeZSFvhDuja50TUp9BXtc0l0XVNeW/dtYGOKcAFVGswNvFb0xuMKN3Vi/
	SXLy+5O8hlmHEeSxUhkQpbl5u8/Z2T8GobFjpeZEijzGsTp0rZqdjKF5tF+L7IBEUB6GOK
	GFpoRCoHh77OqJJotx0TQKc4z/M3Dt0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-613-t6GEoE9wO0CM1HUrBt0BMQ-1; Fri, 16 Sep 2022 14:04:11 -0400
X-MC-Unique: t6GEoE9wO0CM1HUrBt0BMQ-1
Received: by mail-qk1-f199.google.com with SMTP id d18-20020a05620a241200b006ce80a4d74aso7715463qkn.6
        for <linux-nvme@lists.infradead.org>; Fri, 16 Sep 2022 11:04:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=+1Y0WCFyP/xwaopES4fLdWeNPtgD6wFT9927YdVHjxA=;
        b=4bfYvuXQS05zOh5zPeWn7d8X3wI+/EW9RrftInHECu86nSGVlmqKYK+6KZo5deQeg1
         hmB+fBSiRIaMB5RXnXUW+h+iaj1uN3OucdHErvVpQ/Tac9o5mKqaWS7fkuWjRVITHn5l
         Q1juPwDiUG4PXsAKndqEtwVN6djqCN23kXbSfC/Zfjgc2w3X+lV9/YqGoL9vONg3j0Xk
         0RLwx9UhWi5jr/1JceVJg7RAx2FGHQT430CAC8KDFqEM8u3z3z7yHoqlgDYeRj30851p
         zNTUfK3gFn/1Y+/vAnfumQhclvRsAjOQ/VEYrytswe+JZNTOSzhVY9CLqbwU5l6EVcMu
         7yyg==
X-Gm-Message-State: ACrzQf1aVCs3YTf5s/9C0SkMBEHPjBaQfAzVpI3HMx0NujJmXBUvnrMK
	4v+qe5u0Exc9OsvxNnrQNN+vDnA605nEFRwlNDkpPVdoL/QIMj+t7t96/lS01AaeRzNKmG7/bC5
	MOjJZtX4SdXSN2ElICMk9J+lkzA==
X-Received: by 2002:a05:622a:310:b0:344:89e4:cf8a with SMTP id q16-20020a05622a031000b0034489e4cf8amr5512058qtw.206.1663351450929;
        Fri, 16 Sep 2022 11:04:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4avfW/4YAwR1npdBqO0O8h7AEDzFTbb8jsyKyqwPyhkUAoMtuvNzFwbiGDh+VRZqHyNgc5tQ==
X-Received: by 2002:a05:622a:310:b0:344:89e4:cf8a with SMTP id q16-20020a05622a031000b0034489e4cf8amr5512014qtw.206.1663351450637;
        Fri, 16 Sep 2022 11:04:10 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id j15-20020a05620a410f00b006b5df4d2c81sm7417854qko.94.2022.09.16.11.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 11:04:10 -0700 (PDT)
Date: Fri, 16 Sep 2022 14:04:09 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: hch@lst.de, agk@redhat.com, damien.lemoal@opensource.wdc.com,
	axboe@kernel.dk, snitzer@kernel.org, linux-kernel@vger.kernel.org,
	Johannes.Thumshirn@wdc.com, linux-nvme@lists.infradead.org,
	pankydev8@gmail.com, matias.bjorling@wdc.com,
	linux-block@vger.kernel.org, bvanassche@acm.org,
	gost.dev@samsung.com, dm-devel@redhat.com, hare@suse.de,
	jaegeuk@kernel.org, Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH v13 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Message-ID: <YyS6mUzqjq9P0+OG@redhat.com>
References: <20220912082204.51189-1-p.raghav@samsung.com>
 <CGME20220912082220eucas1p24605fdcf22aedc4c40d5303da8f17ad5@eucas1p2.samsung.com>
 <20220912082204.51189-14-p.raghav@samsung.com>
 <YyIG3i++QriS9Gyy@redhat.com>
 <e42a0579-61b2-7b77-08cb-6723278490cc@samsung.com>
 <622ae86d-39ad-c45e-ec48-42abf4b257d2@samsung.com>
MIME-Version: 1.0
In-Reply-To: <622ae86d-39ad-c45e-ec48-42abf4b257d2@samsung.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220916_110423_214024_FCFF5C26 
X-CRM114-Status: GOOD (  14.51  )
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

On Fri, Sep 16 2022 at  1:57P -0400,
Pankaj Raghav <p.raghav@samsung.com> wrote:

> >>
> >> Are you certain you shouldn't at least be exposing a different
> >> logical_block_size to upper layers?
> >>
> > To be honest, I tested my patches in QEMU with 4k Logical block size and on
> > a device with 4k LBA size.
> > 
> > I did a quick test with 512B LBA size in QEMU, and I didn't see any
> > failures when I ran my normal test suite.
> > 
> > Do you see any problem with exposing the same LBA as the underlying device?
> > 
> 
> Do you see any issues here? If not, I can send the next version with the
> other two changes you suggested.

That's fine, I just thought there might be special considerations
needed.  But if yo've tested it and upper layers work as expected then
obviously my concern wasn't applicable.

Thanks,
Mike


