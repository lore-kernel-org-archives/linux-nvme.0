Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A96ECCFA0D
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 15:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pmEA5UIRtFUkoJTebXPiJtfqEeDxZBhUOtjCk6lwm1Q=; b=tr5eMVLDN8beDIsiEDtuUZlfQu
	pr8WP0GfNjjWhI+AJYo9CDtqYWaAvPBaYkUZBpmzpAu3xSBrAHEYxzbvFmg8F54wBDAKhIHjMrc5t
	1EKx3NALt9KLejNpyabnRxRt662iVYioS2SjCZCpxUD4BgHJtpmKfVEJp5tZb76Jjh4CzihdCd80w
	b5pL1XmQGfwIW+mP1RuO4HInMkcVAjxsYIR1YBSYhpeBFQw+vh9BQdKWekDjOjOzJ9bML71vtV+9C
	BgAiOJJJWbzMHm8vBtt1qFGxdSVJsHoTyQ3iqD2P0uQYhlf1OEPDR0ILlAcPRoi57kqmzZihE/kcS
	omAhX8CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGfhA-0000000DyRd-0aJk;
	Wed, 05 Nov 2025 15:45:12 +0000
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGfh7-0000000DyQz-2Vt1
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 15:45:11 +0000
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-43321629a25so43848085ab.3
        for <linux-nvme@lists.infradead.org>; Wed, 05 Nov 2025 07:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762357507; x=1762962307; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pmEA5UIRtFUkoJTebXPiJtfqEeDxZBhUOtjCk6lwm1Q=;
        b=Jelm1qoKRDfW3aee+c6wiUyN6U0v95NHRCY4eRWZgM+qUjG0jgcd52uoRi9hmmFFp1
         UDMTqiSpx8mjNI0kIZWrVqdONXqzb4PC3hjALtbKldHVSKSHWS04rMTmtyGNIhUBMI2A
         Nwe3lW6gRn1ms4toNBa2RxrDb3o7ZoKuBOzAe7MbXmOp/rSt8ZEdSfcqWZatpx3ibtip
         R45D2lxlsKWahKF5Xb6Rxe4moaxS0/lk5THvxd7zdPatCEaduMFHuKCQqkl8d12Qn4Ov
         oGN6cXk7fCuXKZyM6TE7VgdRFIvJeUxW+AgTWktXv2COzJXsRXj/cpLIlKtfIpQL2Cdn
         0QlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762357507; x=1762962307;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pmEA5UIRtFUkoJTebXPiJtfqEeDxZBhUOtjCk6lwm1Q=;
        b=UDreDhSKjWhr8APQ0C/BeuczVMZGaQEJwhzuhScXhrwWI2G9WFuDcLNjP7qoT65V/+
         LTqvl23WPMcKc2hcExyu4eyggjCJLemS9wpzyRhDsIPLffxEM3sdrlCzUHoINeFucO38
         rrP9XptfN+PaW5ffTYpSZWLsVxVqZXWo7hj8HAzbm0vKAnnpuiBRHowCutGbUfg0SZPT
         oAihnLTWfU+HXmi7YaGh+w70k7oHllRYFrqlZyeyo9IPOfhTAgWljbYUCbl6+iilmb6p
         stI8FKN2CyDivUtQcllB8hf1w9Eh6yOTP1hrd/reNgxVHlpx6YnkNRJi7fG8nvN2ELqh
         VemQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE3H71C17jo19r5U44yTkqQ2l7Pr/xiLtbCKn7u/aPJbV8AZTCItDCzkXUpTVOdA99Fa4nq+pgBDIO@lists.infradead.org
X-Gm-Message-State: AOJu0Yz/cDy4mIqu3aPxsWJE088NM1iWkUeC3BappCjNhqcWfm8jQP/P
	zl0tcPOcdH+tN3hYe2RF9gH/gqlV4mfYFF4Dzkd+UZE6jtImdUhcSFkd2MfIBPbou1w=
X-Gm-Gg: ASbGncvX9afC9v8nCveJZAFRWQF5zPocBtOSiGP2BTM3v7RWoGhBmDODdo3h8A9liUs
	0ndk0I8AoStwo5r5rxDKBUpWx47vLjwnJ1CT40hpx+pAraw32xHXhmyYzhbyaOxL7KtGscRUR1G
	JJso6lsFBcUKH+AH3dRNwFucjL0JrPgrsPsQ2iCUv6GIPjZHDV8ka+yf/T/oddmoq9Lvq4ldTg7
	YGGMirkYYm3sEF7C2yxFqU7dYY1UwfC1ucN3/MfEBfa+Ujqxwo51Pswzur0tXqDVq2jAXuzuShZ
	efJHl+NnJzniyKnnwUiTxkYMj95yiqR5FQjVHwI1Yq8u+DRyd1j6HYAhZvCkNRwtQBsO46U8b/d
	uAolc7rVji2r7xtzYXRaO/Cvt9RHwdlH4PqPsIs9HosA8NgUZDOqkGjt2/G5nQ8/OIWVOcgvWxG
	heHQ==
X-Google-Smtp-Source: AGHT+IGRprlY0B/j7MFC0euD5DLU4VAIhfixS9xB+G6Pb3CIfQJOwUgjuW1G2xa98UfKd2ncVWvKMA==
X-Received: by 2002:a05:6e02:1a85:b0:433:2957:2e87 with SMTP id e9e14a558f8ab-433407d98e4mr47454155ab.28.1762357507117;
        Wed, 05 Nov 2025 07:45:07 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b72258d4e8sm2521439173.3.2025.11.05.07.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:45:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>, 
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 "Martin K . Petersen" <martin.petersen@oracle.com>, 
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org, 
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org, 
 David Sterba <dsterba@suse.com>, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20251104212249.1075412-1-dlemoal@kernel.org>
References: <20251104212249.1075412-1-dlemoal@kernel.org>
Subject: Re: [PATCH v4 00/15] Introduce cached report zones
Message-Id: <176235750606.190479.10317258805246349798.b4-ty@kernel.dk>
Date: Wed, 05 Nov 2025 08:45:06 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_074509_652185_CD0446D4 
X-CRM114-Status: UNSURE (   8.23  )
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


On Wed, 05 Nov 2025 06:22:34 +0900, Damien Le Moal wrote:
> This patch series implements a cached report zones using information
> from the block layer zone write plugs and a new zone condition tracking.
> This avoids having to execute slow report zones commands on the device
> when for instance mounting file systems, which can significantly speed
> things up, especially in setups with multiple SMR HDDs (e.g. a BTRFS
> RAID volume).
> 
> [...]

Applied, thanks!

[01/15] block: handle zone management operations completions
        commit: efae226c2ef19528ffd81d29ba0eecf1b0896ca2
[02/15] block: freeze queue when updating zone resources
        commit: bba4322e3f303b2d656e748be758320b567f046f
[03/15] block: cleanup blkdev_report_zones()
        commit: e8ecb21f081fe0cab33dc20cbe65ccbbfe615c15
[04/15] block: introduce disk_report_zone()
        commit: fdb9aed869f34d776298b3a8197909eb820e4d0d
[05/15] block: reorganize struct blk_zone_wplug
        commit: ca1a897fb266c4b23b5ecb99fe787ed18559057d
[06/15] block: use zone condition to determine conventional zones
        commit: 6e945ffb6555705cf20b1fcdc21a139911562995
[07/15] block: track zone conditions
        commit: 0bf0e2e4666822b62d7ad6473dc37fd6b377b5f1
[08/15] block: refactor blkdev_report_zones() code
        commit: 1af3f4e0c42b377f3405df498440566e3468c314
[09/15] block: introduce blkdev_get_zone_info()
        commit: f2284eec5053df271c78e687672247922bcee881
[10/15] block: introduce blkdev_report_zones_cached()
        commit: 31f0656a4ab712edf2888eabcc0664197a4a938e
[11/15] block: introduce BLKREPORTZONESV2 ioctl
        commit: b30ffcdc0c15a88f8866529d3532454e02571221
[12/15] block: improve zone_wplugs debugfs attribute output
        commit: 2b39d4a6c67d11ead8f39ec6376645d8e9d34554
[13/15] block: add zone write plug condition to debugfs zone_wplugs
        commit: 1efbbc641ef7d673059cded789b9c8a743c17c9a
[14/15] btrfs: use blkdev_report_zones_cached()
        commit: ad3c1188b401cbc0533515ba2d45396b4fa320e1
[15/15] xfs: use blkdev_report_zones_cached()
        commit: e04ccfc28252f181ea8d469d834b48e7dece65b2

Best regards,
-- 
Jens Axboe




