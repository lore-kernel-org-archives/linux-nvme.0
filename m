Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B1BC43334
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 12:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dWSt263Qaw0m9Glsw02JwFApleRJFRb/cK5wUXMCZwk=; b=JnvnLzVW0TISYar9OIJ3Yqm1FQ
	ruqE5VJo9Eet7E7ItBoJEF0LmfgC3EYlrL+GP4n/3SOpJz02wPahjUd9XPBENdudIwEznAt5BZiSY
	oRO4J+nk5byFKoayeMJmYB6suJAty1GviZ2k+RT9Rg9h3x0cymimprpJmYbWQ45bhwRqu8XSGGbQO
	ASoIgtUVJE4l2YqujFpTSYDg2fMneXhnAwDoWmi8LuBLAfxoA8D0pkT3KidrMqAzHVRsjULTxa8Qj
	V6JU07iyZQSutyLsU9OTYhIfC6zZIF2MJ2n+qoMKkbd/gZp5SY+8m3ZQlzwuKllyDsEzGg38n4ulk
	Yjinj1rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o94Qx-00A0wn-26; Wed, 06 Jul 2022 12:47:11 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o94Qo-00A0rF-Gx
	for linux-nvme@lists.infradead.org; Wed, 06 Jul 2022 12:47:03 +0000
Received: by mail-pf1-x435.google.com with SMTP id a15so14241399pfv.13
        for <linux-nvme@lists.infradead.org>; Wed, 06 Jul 2022 05:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=dWSt263Qaw0m9Glsw02JwFApleRJFRb/cK5wUXMCZwk=;
        b=j+fmEXUn17byBaaEWJCYGcOxR5xOeuoirY/s0cZzZ6HyE6j7AkcULy2cduleOPB4vA
         1fUxIe212oQYbMmfWn1K7XGD3YgcL1lSmRzRKoedP2xZUo8xYwMpBgx1zzHsj90heXi1
         NQpwkZ4GGKRptHBBMzhAzmimFtumrG7off3e5NRG7G/XE+HS5luAc7mCXDNDU144O8pL
         mCMi5KYlhgxfDIhqTioswKyepbmMcqucUAWhJ5awFyF55whoeOD9ttJIXlqTVFWkch20
         +6ECSy4zrhbdbxV0u1vLH5x375l04xrY6/6D0X9EjFWRPY3uatnpbti8rLYdmCz9YyI9
         25KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=dWSt263Qaw0m9Glsw02JwFApleRJFRb/cK5wUXMCZwk=;
        b=ZmELY7E0bBzM+LKacw6eg6SVI7nRhdi/GgNl0cyOB+XBegBpmbSF/MTHcknIb32juU
         gBFBd0uu08wpJAf7rWHiuC983zJ+i56s4DziE9x4eHGiWId6kSPiU+3FGTupctQo+654
         IESB4oYahgu8cB1eRKLWB/OCflfzmcipGwVCyvqHmcOIePUCAmBoWdBgS+9v5eDXrbkp
         WYe7VCY8xkrrKk9bB42SVTatSMrgupQTbsJ+TGLDXklC34ZWzicQki9oVcbZ02SijglH
         O1r6t5tftXA2YfVWMHXFqJyUYfKn3NeD33vZWgQOuM0Gca/Xr6aQZ7d42+84+Aw1p6o3
         nkOQ==
X-Gm-Message-State: AJIora+SCtpFuXfPRR5tAVcV48zWQ8o3JW9sOuP6tLEfHCmCWZr9J+vG
	1fAcLeQ97hm8uTyhxCELZf312g==
X-Google-Smtp-Source: AGRyM1vbTy3ndf+pSCLNGkm7VeLniHNquKUECZA2Rht1+4+EvHZMthqZzry/qox4vZy8sRhwMJ6GMg==
X-Received: by 2002:aa7:94ad:0:b0:525:265b:991f with SMTP id a13-20020aa794ad000000b00525265b991fmr47728895pfl.30.1657111619892;
        Wed, 06 Jul 2022 05:46:59 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id by5-20020a056a00400500b0052521fd6caesm17610237pfb.111.2022.07.06.05.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 05:46:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: damien.lemoal@opensource.wdc.com, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, dm-devel@redhat.com
In-Reply-To: <20220706070350.1703384-1-hch@lst.de>
References: <20220706070350.1703384-1-hch@lst.de>
Subject: Re: clean up zoned device information v2
Message-Id: <165711161869.295759.6786523664338969947.b4-ty@kernel.dk>
Date: Wed, 06 Jul 2022 06:46:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_054702_601213_6BE23F62 
X-CRM114-Status: UNSURE (   9.94  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, 6 Jul 2022 09:03:34 +0200, Christoph Hellwig wrote:
> this cleans up the block layer zoned device information APIs and
> moves all fields currently in the request_queue to the gendisk as
> they aren't relevant for passthrough I/O.
> 
> Changes since v1:
>  - drop the blk-zoned/nvmet code sharing for now
>  - use a helper a little earlier
>  - various spelling fixes
> 
> [...]

Applied, thanks!

[01/16] block: remove a superflous ifdef in blkdev.h
        commit: f1a8bbd1100d9cd117bc8b7fc0903982bbaf474f
[02/16] block: call blk_queue_free_zone_bitmaps from disk_release
        commit: 6cc37a672a1e21245b931722a016b3bd4ae10e2d
[03/16] block: use bdev_is_zoned instead of open coding it
        commit: edd1dbc83b1de3b98590b76e09b86ddf6887fce7
[04/16] block: simplify blk_mq_plug
        commit: 6deacb3bfac2b720e707c566549a7041f17db9c8
[05/16] block: simplify blk_check_zone_append
        commit: 052e545c9276f97e86368579fda32aa1ac017d51
[06/16] block: pass a gendisk to blk_queue_set_zoned
        commit: 6b2bd274744e6454ba7bbbe6a09b44866f2f414a
[07/16] block: pass a gendisk to blk_queue_clear_zone_settings
        commit: b3c72f8138b5f967a9fa527af84b35018897aba3
[08/16] block: pass a gendisk to blk_queue_free_zone_bitmaps
        commit: 5d40066567a73a67ddb656ad118c6cfa1c4a6d71
[09/16] block: remove queue_max_open_zones and queue_max_active_zones
        commit: 1dc0172027b0aa09823b430e395b1116d2745f36
[10/16] block: pass a gendisk to blk_queue_max_open_zones and blk_queue_max_active_zones
        commit: 982977df48179c8c690868f398051074e68eef0f
[11/16] block: replace blkdev_nr_zones with bdev_nr_zones
        commit: b623e347323f6464b20fb0d899a0a73522ed8f6c
[12/16] block: use bdev based helpers in blkdev_zone_mgmt{,all}
        commit: 375c140c199ebd2866f9c50a0b8853ffca3f1b68
[13/16] nvmet:: use bdev based helpers in nvmet_bdev_zone_mgmt_emulate_all
        commit: a239145ad18b59338a2b6c419c1a15a0e52d1315
[14/16] dm-zoned: cleanup dmz_fixup_devices
        commit: fabed68c272389db85655a2933737d602f4008fb
[15/16] block: remove blk_queue_zone_sectors
        commit: de71973c2951cb2ce4b46560f021f03b15906408
[16/16] block: move zone related fields to struct gendisk
        commit: d86e716aa40643e3eb8c69fab3a198146bf76dd6

Best regards,
-- 
Jens Axboe



