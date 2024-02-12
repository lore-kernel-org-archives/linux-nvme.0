Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9762FC4829B
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 15:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G0mXhrpRS+p0F3dgHMjFx7EMsz8T+uz8plxGpEvyFag=; b=WxwAYXDZSYUo/i50UUGnKaVYJy
	JNwvTXiwYtU3FoTmcsS+kg2usN0VdthCDWzMRYb6FqcDvJYzYc6Ub3hjN6JfL/xW/DI5EZRyljRAe
	WoDBElcDt3aZEpwN4lQBlQJBljGVVmJklZfWgp2yEMHxXPSITUG18pvMXjlKoE6sb8I+fwTXwvLH2
	6emHia9VyG2cLxJ//Oa571TISFPaEe9X2bXzUp+lHiG79/WY/uU1dH1fYgaL6z6yadiv02OAmpYXF
	+gxlEim5BnJ/ugGZczKi2CzAnaVPzmnaLSbreQ5yGc08XJkJujcmmto4z9TX8Sl9BddkG8Fh70WIH
	vV5CEkrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZYRF-000000060Gj-0z72;
	Mon, 12 Feb 2024 15:41:45 +0000
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZYR9-000000060GI-3d8F
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 15:41:41 +0000
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-363d6b409b1so2511565ab.1
        for <linux-nvme@lists.infradead.org>; Mon, 12 Feb 2024 07:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707752498; x=1708357298; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0mXhrpRS+p0F3dgHMjFx7EMsz8T+uz8plxGpEvyFag=;
        b=kgObQHVoNGaPYrUzElY/Cgw8ssdr9pLMHGnEDVo1ODKmSDoAA1ybdkmIkbbJAdSQGh
         Gxe8cG+JxjLUj4tmsmvj/zcg8BfH1+PUHfztQaoMp5plcjCBRN1t7ex0V2MWUiFXv9jv
         17pHtW6o+i8kPn6dFPvz8UNI9mDoLSOrTKzR3MYkiSOXA3sxKBET2RuVKu5mjXr7fo8j
         Ff6ES7t0PRYWBdzuGHYNT41OnoPibnS4VAFPly9zhXxrcQA58wOQHhd5NwGcdZ7ovPAt
         kLCPewYdfLYn35gYv9kHr5PSi71k+6ANZH/n10Ldu4WUVAH8to00inAIb7VDisTO74ng
         hfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707752498; x=1708357298;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0mXhrpRS+p0F3dgHMjFx7EMsz8T+uz8plxGpEvyFag=;
        b=i9n9e2dBubrrbPEIGximQDknUUU8MBr8VCjrDInqREoVTQCcejtHhuCOHJjMPU7Am8
         GzMN4xXWgSbtmkxKSpxEnAcoid9RVljnGzcHotAKZRraZvBgfwhxxMhJsF4pK/37YzwI
         YmbPO0g7fjVjht2sG4wKPhVtby6BtDaNrLUMkU9JIj4pe3dfBdDggbDIFMxFIOie1kYF
         VXB7ssR+HEF8tLmJ9TCso5wMUZ04wBPGiIsuRyv/kMs6hZS+MQOeG7AeV7QSmWcBA/pG
         UuP54BSNH4JtyADlVcfVTGrbCwKyoxkP7iDKWvg+7lbm3ZDHVEq2lXwOwshy3CAmMudU
         c3Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVp6X/YpjRKqZBHTzKVGjYTfUx6dC10dcC4yPWxDx2vh0qMJiSF88LF5p7phharlMRPy7+VPnk+0aK5bz+F1uzdd+/9jGfNxdHwTeHL0J4=
X-Gm-Message-State: AOJu0YzuiCSgTzmw8GX0YMxYGpGGljugbZRewDXVnlyP7exYsRWbJFK2
	rLkXQAeHC+S2jw78lTZDc/BwO6YB3fDgV2ENFXcQdr/Lnyi0s+cUFpLGILbFkxA=
X-Google-Smtp-Source: AGHT+IEnm3ePbL8fRCn1bW7XxydRwFQeu0nYxrSBLL9n45bkvISdrumwN+YpZk9VT+q4F3sMK0GEkg==
X-Received: by 2002:a05:6602:1235:b0:7c4:4e3d:36ce with SMTP id z21-20020a056602123500b007c44e3d36cemr6321073iot.0.1707752498059;
        Mon, 12 Feb 2024 07:41:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWnVzGOtmdX7AszrJhRBwMaathZlE7sOIhhmBCZ172Waj/mNt1jVoILjXxsGEIpU2TQcVluLp7cNz/UtFbkni0EEdCOEBsy/xjyiNN/ght5OTEHQGRjxcAlTGlfhtrYbg3hw+98adb+8nL6IVMAAdlU5lTU5EMAAbXgYb1397xO6lrjdnnTP69LWHcEoBVSq9uifg1lQQ9Ljz/8jHJ3IKlWa5Mx1nZXHyLPSF1uiYtAt13KF5itfaSyN9/vDJFXPojaV54onxtzBNZLDWpmBUHVv6moas9okmEo0rIUPz456FSRkUNBLBCQlDnRzZMpsaO/RZkw+TBhPRGJA1oLMS5He4v/Ih2pvl6T9uB988xPxT+TKw7HrN6VyXeP2HkOu+x92KwNyb1cX7tCV7BZ8axVukDGWSvzLjHyfNghSq6t5+2VF2GvOLv8pcXWDwCiqCxajdZ8jKz0iLniEYWXEpLOzgVKGnWA5Kl1UiZvYR8PslSJ7A6DIv7vFdsrJOdn/B9UWWWz2VH4LT+taUOVnIfIddOSfNHB78L9qrXbAmYHMPq7wmT7+C8mZQVNJDyqZwF0UBwGVxnx11Jn9i4gYo/B389dXczXZ8oahlKZYLTMuN0na4Xb4SUUEogYLcOT+oFjiYIu7JWMeiTv
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id d62-20020a0285c4000000b0047148f44e27sm1464516jai.2.2024.02.12.07.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 07:41:37 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, dm-devel@lists.linux.dev, 
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, 
 Chao Yu <chao@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
In-Reply-To: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
References: <20240128-zonefs_nofs-v3-0-ae3b7c8def61@wdc.com>
Subject: Re: [PATCH v3 0/5] block: remove gfp_mask for blkdev_zone_mgmt()
Message-Id: <170775249673.1914864.6863373275533824749.b4-ty@kernel.dk>
Date: Mon, 12 Feb 2024 08:41:36 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_074140_158123_A1569928 
X-CRM114-Status: UNSURE (   9.67  )
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


On Sun, 28 Jan 2024 23:52:15 -0800, Johannes Thumshirn wrote:
> Fueled by the LSFMM discussion on removing GFP_NOFS initiated by Willy,
> I've looked into the sole GFP_NOFS allocation in zonefs. As it turned out,
> it is only done for zone management commands and can be removed.
> 
> After digging into more callers of blkdev_zone_mgmt() I came to the
> conclusion that the gfp_mask parameter can be removed alltogether.
> 
> [...]

Applied, thanks!

[1/5] zonefs: pass GFP_KERNEL to blkdev_zone_mgmt() call
      commit: 9105ce591b424771b1502ef9836ca7953c3e0af4
[2/5] dm: dm-zoned: guard blkdev_zone_mgmt with noio scope
      commit: 218082010aceb40b5495ebc30028ede6e30ee755
[3/5] btrfs: zoned: call blkdev_zone_mgmt in nofs scope
      commit: d9d556755f16f6af8d1d8ebac38b83a9263394c5
[4/5] f2fs: guard blkdev_zone_mgmt with nofs scope
      commit: 147ec1c60e3273d21ea1f212c6636f231d6d2771
[5/5] block: remove gfp_flags from blkdev_zone_mgmt
      commit: 71f4ecdbb42addf82b01b734b122a02707fed521

Best regards,
-- 
Jens Axboe




