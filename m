Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB279C77B7F
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Jun 2025 15:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7ClQUO/3whpnhDQ2xXD+ZbYMmVy5dR5s+G/B6dkc9Qc=; b=BRz49TX8Gy/+nBcz6D6rTbm/v1
	7a4fozcB5dBbXLVPiO83gTYdlGm/pmkjcXn+8u6+MFHB2a6LMfSMMTg/EE+znGfc6sjpODm6a/5xN
	xAeB+kKqveQ+YQ9o45ttYKSKj64f6zyS7HPzkg7RXSYf6y5M3xXfcp26nazMRm77aWvJCkXx6kQBz
	DgHr8Ol76L0JCGinc3x1TrmV/85n0T0Ptqh4NTgTU/EeyYErxVH1uP3hwil9yYRyfIXfu+GMdWFob
	VhK4OXG2baSZLyv71CMecZ3YA0VigUYVe1ydAE/xWMYgFEHX7IfhaQ4bpF9dtJULy0kZg0VZ5NCQM
	LFMltc5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVArN-0000000F3ab-41ev;
	Fri, 27 Jun 2025 15:19:25 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAVI-0000000EyaR-0pyP
	for linux-nvme@lists.infradead.org;
	Fri, 27 Jun 2025 14:56:37 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-7490acf57b9so1839317b3a.2
        for <linux-nvme@lists.infradead.org>; Fri, 27 Jun 2025 07:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1751036195; x=1751640995; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7ClQUO/3whpnhDQ2xXD+ZbYMmVy5dR5s+G/B6dkc9Qc=;
        b=woiLr9ZZkayZ3Lnh7e1iETZsyznaXpk+rUriFVcc55VD6532gmZO3ep8lmFT+A9ue3
         FV1pvzehv+YWDHP78p3DI2OYslxz+5p67AzoazgPE3Wgui2vRQN1eiNNZFilrJ9gFfRd
         Ya51EY6HGvSrKXMvDHgOqcqhK/nIQ5gxma66ZPiXXOh4P0595E1klLlpYvAX5hNLqOUN
         48mNwe78Z9fZbQQcB6jDjQuDYiACA0sYpvoBMhegx1u/mCpgtqb0fFakSAnR03SRDaQu
         3I77cyfVPwQqpHVgESI9eRzE63Lar0Ym8Yt4vG7QRQLcNuc4k5Y1gbG3EYud7kjdjPDM
         zcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751036195; x=1751640995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ClQUO/3whpnhDQ2xXD+ZbYMmVy5dR5s+G/B6dkc9Qc=;
        b=I9/B76d59TUfZtvykEqXvybUGZDLbh19RudMAG/BiHtzQMKeo6OmRR7OITckvLj6c+
         umU0kKck4HWDS4DKc380VUewdhE63ar0B5pv5Tm3eKkf+LwylH2iL7lURyi4QwjA6Oab
         6mh1WDMPww7yv/0T5xH2nLEyOuwOayP4sP2g1IITzDwpyZWdaSGk1WsWtjMZm5sbwFW4
         RB4ywuRVQ8lJ9hlnwPNKQP4qNlGjolMEB25ZKzjlxewzWTSUxPQOjT8ovySQK7lc90+f
         wP3Y/HzD76SxpblfmNbVsHTeLQLaqtYEc90SfI/TEvOJu77q4T+SIkdWB4ZVDfLoDG3Z
         Midw==
X-Forwarded-Encrypted: i=1; AJvYcCX/pGdgvkKb2ziL0sKfe/zotC2xlcqrla2DWF6SehQOWU31x471yznYoWaXtvOTCA0TcA4sPqFWK6FN@lists.infradead.org
X-Gm-Message-State: AOJu0Yy9C0kCV9mXGYu5MfDqZr+FGhCBVXtkaXPBeNmND/YudAyijWtZ
	toYlItDO/vMrQHqf5ei09j6lTnY0zsUtpVmSSsO6nyTS2a0pFZSXY35hjvcrYt2WVZs4gzcKKS7
	2ljmm
X-Gm-Gg: ASbGncsTL/XkW4T217jIEHoLo6EeukHx6MoumqiIjLj7nXKBnnW274oXpfPTENDr8N/
	zxux53hJuClTD/rcUCSPMnODRp5eeEbnYiBItSHiPoVWpKv7XjSl5S6PYly1b7SBSGH6eMimO//
	JcuCclMDZmFUaYDYqhOrozMkfMVHxmc2NiGaBM4QTqJuofUi6A0usNYffxGHnngQWfcyd4IkH5k
	p2z158aOhxoG43pBMIWJMVmULDAKoG5fZFRxGG5m3anZoAUiV8UK2WptN+bvxKnoh5SkLMh3HtU
	FSojm8Ys8moxJTzeIOGFF44rb+1irWG7cYS3bIpibdyyYhL1/r/jzorT6A==
X-Google-Smtp-Source: AGHT+IENYqjOMvnWJfrPfV9o3wXHwLOcA7uYdHN41zZNj32DgqZLSIlL3LVi2mMEJdiUibUomTRfbg==
X-Received: by 2002:a17:902:ce8d:b0:235:e1d6:f98b with SMTP id d9443c01a7336-23ac40f5e37mr65803145ad.22.1751036194749;
        Fri, 27 Jun 2025 07:56:34 -0700 (PDT)
Received: from [172.20.0.228] ([12.48.65.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39b9f2sm19417835ad.99.2025.06.27.07.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 07:56:34 -0700 (PDT)
Message-ID: <42d8df98-65c7-4a4f-b931-ea32fe357fbf@kernel.dk>
Date: Fri, 27 Jun 2025 08:56:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: new DMA API conversion for nvme-pci v3
To: Daniel Gomez <da.gomez@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Leon Romanovsky <leon@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>,
 Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250625113531.522027-1-hch@lst.de>
 <175086952686.169509.6467735913091492336.b4-ty@kernel.dk>
 <cddf9f29-c2e1-4b9c-b3b7-c64e3a513bf4@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cddf9f29-c2e1-4b9c-b3b7-c64e3a513bf4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_075636_246584_FD89BE0A 
X-CRM114-Status: GOOD (  12.82  )
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

On 6/27/25 1:37 AM, Daniel Gomez wrote:
> On 25/06/2025 18.38, Jens Axboe wrote:
>>
>> On Wed, 25 Jun 2025 13:34:57 +0200, Christoph Hellwig wrote:
>>> this series converts the nvme-pci driver to the new IOVA-based DMA API
>>> for the data path.
>>>
>>> Chances since v2:
>>>  - fix handling of sgl_threshold=0
>>>
>>> Chances since v1:
>>>  - minor cleanups to the block dma mapping helpers
>>>  - fix the metadata SGL supported check for bisectability
>>>  - fix SGL threshold check
>>>  - fix/simplify metadata SGL force checks
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/8] block: don't merge different kinds of P2P transfers in a single bio
>>       commit: 226d6099402d8de166af60b2794fc198360d98fb
>> [2/8] block: add scatterlist-less DMA mapping helpers
>>       commit: d6c12c69ef4fa33e32ceda4a53991ace01401cd9
>> [3/8] nvme-pci: refactor nvme_pci_use_sgls
>>       commit: 07c81cbf438b769e0d673be3b5c021a424a4dc6f
>> [4/8] nvme-pci: merge the simple PRP and SGL setup into a common helper
>>       commit: 06cae0e3f61c4c1ef18726b817bbb88c29f81e57
>> [5/8] nvme-pci: remove superfluous arguments
>>       commit: 07de960ac7577662c68f1d21bd4907b8dfc790c4
>> [6/8] nvme-pci: convert the data mapping to blk_rq_dma_map
>>       commit: 235118de382d6545d3822ead0571a05e017ed8f1
>> [7/8] nvme-pci: replace NVME_MAX_KB_SZ with NVME_MAX_BYTE
>>       commit: d1df6bd4c551110e0d1b06ee85c7bca057439d28
>> [8/8] nvme-pci: rework the build time assert for NVME_MAX_NR_DESCRIPTORS
>>       commit: 0c34198a16a88878aba455bebe157037c9ab52c5
>>
>> Best regards,
> 
> Do you still accept new tags/trailers?

Even if they don't always end up in the git tree, please do provide
them. This thread is linked from there anyway, so it still provides
value.

-- 
Jens Axboe

