Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A24C46CD3
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Dec 2023 03:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kF+V1Jg1BXc6LruEx2QSeT3aVZaOhuhdq7yp1ywFjS8=; b=Yt36h80ojdbeXwPvGmXTGWHPRl
	NO2aTcaaQixD+fmiKDKMUsIfEHABdWKhthXlO+h3s1jNElFgwHoL8i9BKv/mOTJGTKLn4jnXjmDew
	+zN+Llz9yQfUC6vYqSu/23xdbuMI9i8Ho0MDW/c69S6HG6WPqNQ7JXNwa5y99eP06CBS7vLjJmSoW
	2f86fFkNV71apsVq1JYSA57ibrMIPIW/UtxD8DULC2eadHXvHBn9aHggC7qShZGp184kn7SwWgCSB
	MWtP2Mgo2LCep+e9WN0GwC95KOjxxx7IVsYj+8WJiluECPrfIYp1sPHugILP019yv2fMi+eDCcykk
	TmXhBe3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFn67-00G27m-2m;
	Wed, 20 Dec 2023 03:18:15 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFn65-00G27L-0H
	for linux-nvme@lists.infradead.org;
	Wed, 20 Dec 2023 03:18:14 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6d93cd747c6so89671b3a.0
        for <linux-nvme@lists.infradead.org>; Tue, 19 Dec 2023 19:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703042291; x=1703647091; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kF+V1Jg1BXc6LruEx2QSeT3aVZaOhuhdq7yp1ywFjS8=;
        b=lTX+602owv8C35uHdPmG4AmC+L4XaA4ym5cU/wz0bi++Kx9cZZIJmGhxPYv57wTZZU
         AfD8Ask70ZTqtuy2SuCC0Xfj/q2UCqueJ5vznkCpYB+1yc+hvSmN1hLXXwJg06WtcCMU
         h3nthDP/XBz2NBaOPSMIbEyPlQ5YOkIeE2gwH31VHMjP2EmpZe+XBhTf9hdIzOT7aCNz
         D2J1DBgoQUsnFKZfrPbs50yt5O/JnDiS0Go42P8BcisBBFGSV73mqgAidsrZaGEhxMaH
         A27YlBtJTd0CWMwQ6Hzk4dzYzU5wne8HmDGGcD55bWNnJxByusBtU8mQSfoFlC4ZRWhN
         OsAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703042291; x=1703647091;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kF+V1Jg1BXc6LruEx2QSeT3aVZaOhuhdq7yp1ywFjS8=;
        b=e0Ugt1BhTuKVuVQNEycNw3tcxEdiKLobA4H/BQVRrjA7PUA4PIaPeaAU8IjYNaD8pT
         ckXTzFv2QXKAfuoKCRYULLUMbgsSRGVstX+YGazrwAl16uCyvGD3stEnE0eoaWZv/H/M
         /NbIRwFLBkkFcrWTl59C3/b3I4hUbWx6xhHKWydbSmR9K0nqpSfgHUtmOcoUFTKtI8/a
         yx/9iuNviyDUEsCqwInaf7eLVo46aA4D3oQRtVdTaIKOm4amOlUssVAzsoFH5D05BcJm
         8NRVdIB+SHdeHkQbDm1WhpIF9LMVpa+cKQORpEdNPIrs7c75r4+Q66+HvB3+x6b0/lme
         iTVg==
X-Gm-Message-State: AOJu0YxvutuGPugNh5LuZ1LaysTJGuMUdeM93CIfymLw68OVxqnDSYGp
	eJR1qaBTqwo1l/ntn9OWly75Rw==
X-Google-Smtp-Source: AGHT+IGJy8KYnZyMHC+4fzSHET6hgmed+3GNH6+zA4QShlWQzZGtRyh4P66B+nvfNY4nmXMHOASd9w==
X-Received: by 2002:a05:6a20:3c8d:b0:18b:2020:8cd1 with SMTP id b13-20020a056a203c8d00b0018b20208cd1mr42952817pzj.3.1703042291622;
        Tue, 19 Dec 2023 19:18:11 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d6-20020aa78e46000000b006d088356541sm16958284pfr.104.2023.12.19.19.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 19:18:11 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Damien Le Moal <dlemoal@kernel.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, dm-devel@lists.linux.dev, 
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
In-Reply-To: <20231217165359.604246-1-hch@lst.de>
References: <20231217165359.604246-1-hch@lst.de>
Subject: Re: remove support for the host aware zoned model
Message-Id: <170304229020.683808.16849978519505449769.b4-ty@kernel.dk>
Date: Tue, 19 Dec 2023 20:18:10 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_191813_124172_B83FE52B 
X-CRM114-Status: GOOD (  12.39  )
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


On Sun, 17 Dec 2023 17:53:54 +0100, Christoph Hellwig wrote:
> hen zones were first added the SCSI and ATA specs, two different
> models were supported (in addition to the drive managed one that
> is invisible to the host):
> 
>  - host managed where non-conventional zones there is strict requirement
>    to write at the write pointer, or else an error is returned
>  - host aware where a write point is maintained if writes always happen
>    at it, otherwise it is left in an under-defined state and the
>    sequential write preferred zones behave like conventional zones
>    (probably very badly performing ones, though)
> 
> [...]

Applied, thanks!

[1/5] virtio_blk: cleanup zoned device probing
      commit: 77360cadaae562f437b3e98dc3af748d8d75bdc2
[2/5] virtio_blk: remove the broken zone revalidation support
      commit: a971ed8002110f211899279cd7295756d263b771
[3/5] block: remove support for the host aware zone model
      commit: 7437bb73f087e5f216f9c6603f5149d354e315af
[4/5] block: simplify disk_set_zoned
      commit: d73e93b4dfab10c80688b061c30048df05585c7e
[5/5] sd: only call disk_clear_zoned when needed
      commit: 5cc99b89785c55430a5674b32ad0d9e57a8ec251

Best regards,
-- 
Jens Axboe




