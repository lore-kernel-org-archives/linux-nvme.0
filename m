Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA7ECA5FFC
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2026 14:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zk6NZYWXvab4VmQlOnV5l9gJVbd9ezlfU6KyVPu+Xp8=; b=FdDrcPfZH5cz+XJ9Oj8Lqm0cMp
	EiWAK+z6l5u66aFZNVVQxSqknSImZF6J07/mPVXi65YkGWzH/hsUx5OA6eJTI2Y667iNtZ1V0IfBu
	3LmRnUtOsSv8a2ZCcV4DEqhUUqHapZ9vNbKSQp4qEYb6iiQr9V4WvHuGyUKApv/MscG8wkjld6CQj
	eU1FgC+UormKh4Rb2t7o5XqVP1nju40ydtQiMbftaaVLAI6EThFZzTBRGAEhxOKxTfY8ueIQERYph
	YV61wJCi9/7LC2lVU72KNEzwEfSpM4DqAv8GXy0osmQ1PpE+DwROTKAG+Yd/lsVYupf2m5KLMxsNm
	wsqFNI1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDjyF-0000000GfhM-49mF;
	Mon, 05 Oct 2026 14:47:15 +0000
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDjyB-0000000Gfge-3X3i
	for linux-nvme@lists.infradead.org;
	Mon, 05 Oct 2026 14:47:13 +0000
Received: by mail-dl1-x1232.google.com with SMTP id a92af1059eb24-15354aa70e8so4299891c88.1
        for <linux-nvme@lists.infradead.org>; Mon, 05 Oct 2026 07:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1791211630; x=1791816430; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zk6NZYWXvab4VmQlOnV5l9gJVbd9ezlfU6KyVPu+Xp8=;
        b=xoZibYy2MKuCdkOwBkJWll2OsRTgXvXDG9Ddeu+oq5fRUDqRJYtLfBP3D4DG51R7WQ
         GzCiIzswJyr0kKaUSoAgvW8D4LTcgygAWnLJt2OViT5MuwnKguE975Nuuq6v/lzFPkGQ
         o8q+nK4h7UvMcZH/BseSagGE99Rm0IP9+ceDbG74sh1ADhfCikyfisUu+yFfx/pcm4fg
         didBtPalgUWAPneuUrKzraeBsNE8+sycP4AS8xzbN9g+1RP5AQR1dNaHEEbiaJ5a0ZW6
         uMfdy8Wkn3JBQGx9juzltBGO3SjUlZ8gYALrlXuOaXkDT96YTeE6SVagJrVGGBEfv0Nq
         kuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791211630; x=1791816430;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zk6NZYWXvab4VmQlOnV5l9gJVbd9ezlfU6KyVPu+Xp8=;
        b=EBkCXeLV5h10vYXPwTunvMGyct2t4ySzLuFueGu1daHy6PxZaMNz/rDtKMXeVuyPQg
         1kODQl6N3gnvLNOMugl5aw4KXPQwRzJf0LQwNYQweYojJLNX5CcIK6RXJvypHw1WiwDM
         O1B+eAVOfZFKK4oZPdG4NLUQf2wBYCqnl4xs8SMyQGfEFBI8b/1HXZyURVanXW8Bv8/S
         VIUR5TTg2lWfVq59BkuD08B0p+Cie368KaWm1ywvTqEw/dvU/9q7H8SJMDuYRvJTyxJk
         pUXg2DRcGUFbBDziXAJzm2P18qRBsAG/RU4rQmgRY7NCQqf6FUd3/vXuydZ77phlkvce
         I4mA==
X-Forwarded-Encrypted: i=1; AKwUvBzygQyjT4/X30T6mMIOKtH352uoX8DtETtM1o65HCu+S8lwuT76hbUMf7mMReji7szekbMxbptzk39V@lists.infradead.org
X-Gm-Message-State: AFuF++nU+An7VuswsnU1RVkpT+FXgpWpubLT3V6qWcAXmNwIzMLJ4yau
	9MSu2liMUlNkQUIrsuTUfrL57Om60LRjMH+SuKbgn/Dtl/4S3coa6gC+nEHEpUBa7O0=
X-Gm-Gg: AYBFou1fabRhYVlpHtIELjOCPHdY+qhR7GUwNolWwYw7IHxUquD0+o0hmAyzcy1QOWe
	1WAbeWrPRzMBA4GiXoWQWe+KYASJrDvLnb4lwjySKJyEtfl/fKV/nfXsy24OkNkCb2K0DeDgeC9
	TWBpaAvfHmKtOWDoWBaeTFl/Ju4s+GAaHdiT5WL87peoJqHYg4Unqg6jfPsbzWs/iUPUdVY/mRd
	FqHFKyIgPNwD7/4zG2yIkPkwxHubpOJyGv7KqYYERcEuKASY3I+Vy8nbTOrstZFeH2DbJDqUz/R
	xio+wtVYOS2dNs4/uvGNuBG5W7PzDpxGyLVgHWciV/z011aB/wtEpjWaEYqsLESR5nJtDNa9r9b
	jP1YAp5BV2BgCoBa3hVNhpJ0O0m4gqQLnpq0hawUCRrJxhuWDyWilf7ixf1fys0vgTqHdiCnaGv
	QF2hL4345ojkkSbviWWM68FWPu+UOv4Z3PrPvPKitlHWH6pzntLcFPRXhsTdzpYPfUKHG/TiVyn
	6pY4VGz8bxHPpwedseZXSKBcBrBDTTj33JPD1A3XA4H3Pq+EhT1jb30Vw==
X-Received: by 2002:a05:7022:3f85:b0:151:e843:345e with SMTP id a92af1059eb24-151e84334c5mr13941437c88.29.1791211629486;
        Mon, 05 Oct 2026 07:47:09 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fa74fa1csm25648175c88.1.2026.10.05.07.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 07:47:08 -0700 (PDT)
Message-ID: <cf6376be-e5bb-4c7d-9850-c11b4bbf1e07@kernel.dk>
Date: Mon, 5 Oct 2026 08:47:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for 7.3
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, linux-nvme@lists.infradead.org
References: <asOjta815QimaDcN@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <asOjta815QimaDcN@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261005_074712_151496_5E9DCE6A 
X-CRM114-Status: GOOD (  13.88  )
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

On 10/5/26 7:18 AM, Keith Busch wrote:
> Hi Jens,
> 
> Sending the nvme PR earlier this week as it doesn't look like I'll have
> any other chance for maintenance duties.
> 
> The following changes since commit 684b413b5483f57c890c171b9400076a0143b918:
> 
>   virtio_blk: set the zone write granularity (2026-09-29 12:54:47 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-7.3-2026-10-05
> 
> for you to fetch changes up to 5755f1bd0217ffe3c5cf85467bf6b0680f398265:
> 
>   Revert "nvme: do not reset controllers in NVME_CTRL_NEW state" (2026-10-05 06:07:37 -0700)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 7.3
> 
>  - Fix lock ordering revalidating zoned multipath heads
>  - Fix swapped ZRASF zone state values for full and read only
>  - Fix target p2pmem cleanup when the metadata allocation fails
>  - Fix target status code for invalid NSIDs on reservation features
>  - Revert the NVME_CTRL_NEW state change, which broke the Apple driver

Pulled, thanks.

-- 
Jens Axboe

