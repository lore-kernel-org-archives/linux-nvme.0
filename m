Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE41C3ABDD
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 16:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=; b=4++o3jO/+vmHKLKL8yjZX8eveD
	yl9GPPQi5PX2bC6AqFfCQBSg51EGM4l/wwHJ/hgh+EdJhLq9PRlcm+1VgSxS39yVCR2OfeNx36aeF
	M9BYIu6MTWkSACzyWJxLRRbNCCTNxXL5wOj9j/akXsDNfJeIEIg4np8wAHzE2at6DdNwpuWykVAKS
	RCAw3CYFL6BoP6Wo6TrCgCk6kjPnSM5vgJH5/CXrRGvYCweyXaef7aE5+8214vrczQEFPP+Bjpbae
	aztX/BPYYHct06UFZXN9a6S7+0dyV62ZBKao8PM4+f1CxBOWZvhdlH1/qkBg2Jqm05cDjv4AfC6IV
	9GBrAL0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHPg9-0000000DVUP-2nzP;
	Tue, 20 May 2025 16:18:57 +0000
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHPJN-0000000DQ42-2tIQ
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 15:55:27 +0000
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3dc6f653152so7015235ab.3
        for <linux-nvme@lists.infradead.org>; Tue, 20 May 2025 08:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747756525; x=1748361325; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=PE1wl9MUKFVnwXUs2FpnlwCJFlAeGCC9IjExXN4zKFaC32+AOH7Uvdz3OrHbpuToTs
         Kj5WFMwAw0aQ9OUUMgDkZ/wxBK8Ct9wfxIZqB5y1SM78mpyCI47L46RlVXxZolwEtOPK
         fB33S0vickLNSS1QW2ZyDrIV1HWAIaJy+v4JmYBDH6NJXYxrl25fXuO1w2hZz57iQpsm
         cbEeub3TW6A4GlSbtpKh1vb8LQHN7Kqot8Fdy60j68sMhiCruWGh7KLdZkDlRW9gowWj
         h7/rwJ9pAwgnKwsnBzfGRuE3ujKbWIfPrUq7V+qq2R3x+FxTxm8A3qU5nPmyIiqyejgj
         PBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747756525; x=1748361325;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=h8SY5M7d8fw/wgWUqpBBbBtSIMmsAn4NA/ZC1lVfAByXyBDCfdSxiuncBgkXzGEKzI
         ezku3QyNc6vw8a2VhAnVoQgtctCe4jZpQbGqP6J/PeAzAfQ3/AwxcOT6Cm0aJgWn0UYP
         wHQtGX8Bohe0bnLLaCQtDcJfUY7EaiX6sExdb0rJ6ErX/LzmQd+hTkuiy+vM1Xtrxzh1
         PWWmSzQQnHLG7WLt1CLmcjFFGmRDR6XvfhD7VxLX8Bq5KaGKyXIfwmxl3lregBqVBWuv
         ETAmZydhC3E3lFLSpwRwQ+J93lUJYdJnAChtybYF3ib7Ix/g0pWGYBio+gd52TbR3vzb
         UcKA==
X-Gm-Message-State: AOJu0Yx3WgWBXLNmXBqocSwSvZU9Qw3udKxdc6V0dOhxdrWdIqCn9L8h
	3EgtXijgAGyDlhfffVXxOL8y+nPkUV25dS8ZCtbqGb+SMLN420QUV6Kc/mWzv1oh61w=
X-Gm-Gg: ASbGncvosXNjPnZcIqZdZh1PWG1ir2E8TFfYdnN6hTSFoSUOKoHM2wY4L/wFt6LkYn9
	zDlVk2ZT6Q0UMHp4hTT7KZ+LeAaTkwVX+lCyV3CRobYgeuKo4dFieMh/DeO69SH+E8LeUTKnEwL
	WRbHxzV8TzSq1H5gbxB9Gqd+H8f1FqD/HwwJnbprScAv0plP2sCptEPV2CHyK8DpnuG0K197LxP
	VQlbOO6HOkiHOtiLv42JC4kHMMU5JCbCRMmXjut2DBadMf3/rVxDbg0vD37zfbipDekbS2HfTXb
	oVdcGXJqg/N3V8cmq8UcsNpX19l4l5j50cBFMHM1jn/Rrg0=
X-Google-Smtp-Source: AGHT+IGkJ3Lau2TkDMCrfPsr++kIUKDivjQYRcr5J56zUWDp/QIZJuqvOcozvP3lLgxhTe75AbLTNw==
X-Received: by 2002:a05:6e02:2305:b0:3dc:79fc:acc5 with SMTP id e9e14a558f8ab-3dc79fcb012mr36214965ab.6.1747756524755;
        Tue, 20 May 2025 08:55:24 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc48c4ccsm2263044173.103.2025.05.20.08.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 08:55:24 -0700 (PDT)
Message-ID: <b65098b3-9530-436f-9789-e7f129bdf6b3@kernel.dk>
Date: Tue, 20 May 2025 09:55:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme: enable vectored registered bufs for passthrough
 cmds
To: Pavel Begunkov <asml.silence@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, dw@davidwei.uk
References: <8c7e05a68a041c5129c4659f574bed6bdc7602f1.1747754487.git.asml.silence@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <8c7e05a68a041c5129c4659f574bed6bdc7602f1.1747754487.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_085525_728989_0B44D8D0 
X-CRM114-Status: UNSURE (   6.79  )
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

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

