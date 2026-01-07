Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AF7CF6BE3
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 02:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QcTQoUcIXWvvQGWuloMJzBEK7Hz6Zc+n1XoQykXAO6Y=; b=TNmBBbxCHqZFxnPsfdgQBfDI0s
	bvBnlPmgbhb2cmGMa/ZhbFT2FCnmfyZVXob7+nmg4nnAMXnaT2lypix1zc3/rZPA3kVhTjWq4eNl8
	rWICt3Xxm9EO91uZGOSkY6StslZ4X4JpOiQ2DNkva+EWCPilutCDS4/n08IoZT/B/8013A+wKKw2N
	5AGUKe0gGaIn9Ji019w/MhzK7piOE4vvw7Q5FIlgX31Kg3ZGO8azsta+iwxbaAiNsnLPg+bxJQJQr
	xG70U6C2XfdTyb+hEOMbJ9stCgGxQsiuVpEBs2ktbkM2Fw92PmZ9oaHPyo/m6yMwjLy3s7Q3EMkOs
	fNVQ11sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdJ0e-0000000E2ul-3W09;
	Wed, 07 Jan 2026 02:10:52 +0000
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdJ0a-0000000E2oq-3lrR
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jan 2026 02:10:50 +0000
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-7c7533dbd87so1180216a34.2
        for <linux-nvme@lists.infradead.org>; Tue, 06 Jan 2026 18:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767751848; x=1768356648; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcTQoUcIXWvvQGWuloMJzBEK7Hz6Zc+n1XoQykXAO6Y=;
        b=FoXrc9ik/MurZgFxwZUzOqxVjx5eQuu8o1QiZG5IbRvL7FjZBN/VR152mkyq5KHiHs
         OQ7xu2IVmorJDfer9bWK4l2LQzp/uKCQbgXCYQnq87gdqesNNXJi+BDgjABwKLBPIH2k
         F0BdK6X5xURji8R7kJm++EbQ73xUMakVQ7yfn6bVWjG5bAKiq7nKjTYloMASE2LFsCXp
         74IhjC3IP81KKyk/26EIbyiYZ+9y/Qhq86PrZDK1yiJPlJeoPfjBW9lch2WQf9RW7HHm
         RAOSOEbM4JbBER8R45iMou4iYWPplZ6GP2DYTlFVEXuzDAN6+rX2TqeRKq0U1w9w7jfP
         rRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767751848; x=1768356648;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QcTQoUcIXWvvQGWuloMJzBEK7Hz6Zc+n1XoQykXAO6Y=;
        b=CD8+R+LC7rtow9y9B3A3LUTzokjokoELaYzy1ESL6jJxMSkbtqm9MJCm3gjgbgYdje
         Hw6pXxMAHqnAhes2Q9HXzi3yJKiqmwC4ZNyat8FUiHWgRy/w0LZcAIXpJoOV6VURB8rY
         EoYeAP+7hcYdj5K5X1PCFcVN2N7koStrqb3KGlBeNqEKD9KqbKGe5uDA+4VnxXOscLnW
         fNCoCc8M1Z8BjjVA49ThrpqRK0SOkzljotUG9lSRllfKyIfWgOFtHa4xLb6xuiFg7jal
         wcEgBx8qgF5au2Vj7hY5DR5nBp/4VcGVIa7NBtu0fR3VHmW1xhvmLgg0rwjDHNc1MVqf
         tkZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0nwxkpRlZUcYlFaXhnRpw1fR20TJ16zfcpuG0Z5oNElXRvMOLJM80L6SNTbsYS7OSTK4Dv3pL6LU8@lists.infradead.org
X-Gm-Message-State: AOJu0Yx/TUiDLG9uwtUpvTh2OjC7MvmIXTY06J0TBtZUJs8o1GnwWqQh
	rYAIPYvYo+/pOwFHySeB19q8pmOnnw7uO7j9nSH5xq2qOZT32WKtCrk307ebq7OM1/c=
X-Gm-Gg: AY/fxX5ctI0QA3rKjsdzUFwdfsGaMm1oHP3CAko4xhJpLQDGvkzOxp44Wdmkgw/+r/2
	cpaZ2Ii/9Ii1CQagm+Ml9fnCvkpTENrXmfqeSpYeS3x57XgEJY2bILpLRAhm/JPN/QjWy8soSIy
	vfba09Xo77qmeNcrB0Wv+Fi4vjxOfmBcptoe89LMo9bTIdIkhCDqE7BbJ5Gfe6nPJBDrC+KGAzx
	SEJOhGBismhMeZTHdF/6cv25twDE/KNFdSXwiaacFHEfOgmPTGhJmVbji7/noEEiVxS522Mg4Kh
	svXMl/7ybqQ0SFboIEtdbySDl5RNfNxIIKU8+25bCglN96BC3Lr56SrPUatZj4A8Z5XQMMUagjX
	o1eLwXeGpRi5Gl/0VbVUrf+CEC5xC1RdK9IdNUU7UOQ84h49k69MSX/CQTUHQefsMAG3uSNQLIT
	uFstw=
X-Google-Smtp-Source: AGHT+IFJHePhw1jDwTbBMyvhpWIyliB0q51lm8NfZmuYk9ACWXlLP38woqs1kc+gNRVBKWouepc6FQ==
X-Received: by 2002:a05:6830:3c07:b0:7c7:68d6:5925 with SMTP id 46e09a7af769-7ce50bc2392mr551073a34.27.1767751847543;
        Tue, 06 Jan 2026 18:10:47 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478af8besm2460657a34.14.2026.01.06.18.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 18:10:47 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leon@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
In-Reply-To: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
References: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
Subject: Re: [PATCH v3 0/2] block: Generalize physical entry definition
Message-Id: <176775184639.14145.18318539882421290236.b4-ty@kernel.dk>
Date: Tue, 06 Jan 2026 19:10:46 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_181049_219099_AA40B7DD 
X-CRM114-Status: GOOD (  11.21  )
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


On Wed, 17 Dec 2025 11:41:22 +0200, Leon Romanovsky wrote:
> Jens,
> 
> I would like to ask you to put these patches on some shared branch based
> on v6.19-rcX tag, so I will be able to reuse this general type in VFIO
> and DMABUF code.
> 
> --------------------------------------------------------------------------------
> Changelog:
> v3:
>  * Rebased on top v6.19-rc1
>  * Added note that memory size is not changed despite change in the
>    variable type.
> v2: https://lore.kernel.org/linux-nvme/20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com/
>  * Added Chaitanya's Reviewed-by tags.
>  * Removed explicit casting from size_t to unsigned int.
> v1: https://patch.msgid.link/20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org
> 
> [...]

Applied, thanks!

[1/2] nvme-pci: Use size_t for length fields to handle larger sizes
      commit: 073b9bf9af463d32555c5ebaf7e28c3a44c715d0
[2/2] types: move phys_vec definition to common header
      commit: fcf463b92a08686d1aeb1e66674a72eb7a8bfb9b

Best regards,
-- 
Jens Axboe




