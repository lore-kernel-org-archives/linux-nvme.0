Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EAAC77B7C
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 20:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aJD7oYsuXClF0OaOzgGxIKveGu4NfGDAhJ8FOTY5Umk=; b=Y+nCe5OXw/s8GftkfhqpCzj1zC
	ZviX3CdOs9z9PiO8zmcXmj89wrr2YZ0DXI72zlAUXDw3CEAk0jAPz+/FXG+t+2iX+SAZN4Ne2vnWf
	wD63y0f5MSIoK9OHBsi3W9gX6cQe5SBZJ/MZyEuC017G/zSCoUf+VqGrcTNdAbElX6G6hiwC6Uodc
	Ox7TxXOofPqVxN4s4mAgwXVG2w3D9e+fr9GqkGKIuUtmIJV+/V+4Jl7ut531Tb5RvvN7dESfCd7wc
	DkM20WwVjLGaIFayDkvSWKHJhm8mxkbhPNi4DlgsxB8rsv142jjCZywPafTZMbzW+zEPJDOfUzMuN
	L8JR+mdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUWpU-00000009qw8-2EHS;
	Wed, 25 Jun 2025 20:34:48 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUT96-00000009KhS-3itg
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 16:38:50 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-23508d30142so1824485ad.0
        for <linux-nvme@lists.infradead.org>; Wed, 25 Jun 2025 09:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750869528; x=1751474328; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJD7oYsuXClF0OaOzgGxIKveGu4NfGDAhJ8FOTY5Umk=;
        b=o8xw0UCScspdhZQxfldbgQnHRjD2XDeHjsbHS86fK53wDRWaWJ7VVWD/gW42BXY1za
         LvUpg8IeyxUCKsghrynjs/6EWMetExIrBW1xl1AquREOYW56acAp3gNr7Rimh1SSd/S9
         eciKJlh3rKi1YJmZhAbjoayWmwT4CS/UHxNPgSw6Gmk0pD9S4pCoLN/r70CGHgUx/TXn
         9FGySenm5vi+e+z0LZ5Uw1RBF7mU3Yd+bdNQYTQ8z9co4StstMHgyinqERSHPs7sVQBl
         4XV23tD+QWeJi3aGALLp/0EVIc37/f0QIPS6dG/+VuX1FkJZ7Vjz/kR5Mr+gnRX0gwJy
         yZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750869528; x=1751474328;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJD7oYsuXClF0OaOzgGxIKveGu4NfGDAhJ8FOTY5Umk=;
        b=gaLFbDJ0hdE3hRooHWNL7EaAR9qPyepKgJp0jGdWuWuEG4ysSOtoHkfaHC+ZWP+tcA
         EP9YgyoUAQ+eB28kiynncs540AWrBetz5R/08iZYFtwUddrH13ilEXcweYg5aHIdpGZ9
         uuY0zxc3VTej93AD5gkS9/5v+6lQYALrvRtn9SAkRjxeLpVx4wddTKNGlKL6DJVZMES+
         eEAViHDmq/4QoebPVKCVGFVgmVGccMxsNfoHdiplU9C/vStIDCe/rM3//kh3rauWcgCK
         fNbhDuMXZIpOSQ5cOItnrqR9y3I4GJ8gmwYyfZ//izdKTov6Fy9s6tAoW+dp1ArxIdJz
         RU9A==
X-Forwarded-Encrypted: i=1; AJvYcCVdV7S1LKHkumGi/lJ7uPYf8UA44kAFFw/+gcmVnqmGh2UaIrxxL186xu7RYCP86pxCc9+USyPh1arP@lists.infradead.org
X-Gm-Message-State: AOJu0YxKNdu+6Tgpp/YNv3s6Z6FAhAcQ5tIub43JklOyWhJF1vVcpgBU
	iYbeKu3xAmMcFxQACHlkQT8xzUC/adVpNZv90fnWyY4ZvLdzj9NVSf3g/ZuKZJ6rFG2DjT1vA+f
	d42vE
X-Gm-Gg: ASbGncva1YO4i1oA0wS/3L1w69MJsuy7tsDiGWvu9QWp0xTX4NtKT+IJaoJGrhTf8uI
	MK1oZwGcsZBZyKUe/9wz3m7NyQxAS6tFOIwUjknG3nOhF0oSiE7EUGqDuwnAKNB09A+66DbJVyl
	vZnguTrtDpFnEQEP9h6TS1GiMmludKQlLhkQaWZQnKaw/0vC46LCHCL/B8Tdfs117CVaYROGW2j
	pqfNIq/wWcY2f6RROf/fA81NwcNyiMeG5Jefn7nXXoacJycd1E0dGerNGL5tpfS6SmBv5zQLLFn
	/LJ91WQBAkxu4GjzLoFnUfEH+IwhRrQJ6tmAxswpPf8CtvsDpGx9lw==
X-Google-Smtp-Source: AGHT+IGDhM9kiTgBHa5GA1KZysJZpg4uphx08kK+xQdK6jAIhu2+Nfg5iHkJwNuyHtRWpoMjNzaLjQ==
X-Received: by 2002:a17:903:1a67:b0:234:f200:51a1 with SMTP id d9443c01a7336-23823f94c1fmr57933555ad.9.1750869527845;
        Wed, 25 Jun 2025 09:38:47 -0700 (PDT)
Received: from [127.0.0.1] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8673e1dsm140580495ad.163.2025.06.25.09.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:38:47 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>, 
 Leon Romanovsky <leon@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>, 
 Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org
In-Reply-To: <20250625113531.522027-1-hch@lst.de>
References: <20250625113531.522027-1-hch@lst.de>
Subject: Re: new DMA API conversion for nvme-pci v3
Message-Id: <175086952686.169509.6467735913091492336.b4-ty@kernel.dk>
Date: Wed, 25 Jun 2025 10:38:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_093848_927044_473747E3 
X-CRM114-Status: GOOD (  10.85  )
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


On Wed, 25 Jun 2025 13:34:57 +0200, Christoph Hellwig wrote:
> this series converts the nvme-pci driver to the new IOVA-based DMA API
> for the data path.
> 
> Chances since v2:
>  - fix handling of sgl_threshold=0
> 
> Chances since v1:
>  - minor cleanups to the block dma mapping helpers
>  - fix the metadata SGL supported check for bisectability
>  - fix SGL threshold check
>  - fix/simplify metadata SGL force checks
> 
> [...]

Applied, thanks!

[1/8] block: don't merge different kinds of P2P transfers in a single bio
      commit: 226d6099402d8de166af60b2794fc198360d98fb
[2/8] block: add scatterlist-less DMA mapping helpers
      commit: d6c12c69ef4fa33e32ceda4a53991ace01401cd9
[3/8] nvme-pci: refactor nvme_pci_use_sgls
      commit: 07c81cbf438b769e0d673be3b5c021a424a4dc6f
[4/8] nvme-pci: merge the simple PRP and SGL setup into a common helper
      commit: 06cae0e3f61c4c1ef18726b817bbb88c29f81e57
[5/8] nvme-pci: remove superfluous arguments
      commit: 07de960ac7577662c68f1d21bd4907b8dfc790c4
[6/8] nvme-pci: convert the data mapping to blk_rq_dma_map
      commit: 235118de382d6545d3822ead0571a05e017ed8f1
[7/8] nvme-pci: replace NVME_MAX_KB_SZ with NVME_MAX_BYTE
      commit: d1df6bd4c551110e0d1b06ee85c7bca057439d28
[8/8] nvme-pci: rework the build time assert for NVME_MAX_NR_DESCRIPTORS
      commit: 0c34198a16a88878aba455bebe157037c9ab52c5

Best regards,
-- 
Jens Axboe




