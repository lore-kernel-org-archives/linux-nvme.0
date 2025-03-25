Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA17DC35FFC
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Mar 2025 13:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=86XTbjdHZToTO9vFgFMOUGoOt+ekVajyxhh4sxGzdh0=; b=Uwlr2W08SO8b1M74XMCdc0+aKq
	GRe1Zga3q0yvubuTGcr4/7/fRcetd97pWXiWYUfi1gdUjLMJfaJx+ehCRDvAkglijUss6nBpTCQ08
	2goqWCbr9WycIeVJCjfawvaJ3pgG1q2hbBnHOpq+mDCogWVxZppjm5ZZARtV9cpOGNKMP2bXIg2kX
	28r3PqbG6fGGSVMP9PBa+HEkTgG/XPeUo4NQNi4A6J1njDp1b9chQNIi9M3ty3fbbS+jQm3oT5wZ2
	PFD5pkAiShe38lWQDBeyZcQVFzlscu6eVR0z9y+JkddrpSfIfcrDlBG7Wi7EKzmG89LAqK3CIzZpy
	Zw9s+c3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tx3wD-00000005xn7-0Kr0;
	Tue, 25 Mar 2025 13:03:25 +0000
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tx3jy-00000005voh-0Kdg
	for linux-nvme@lists.infradead.org;
	Tue, 25 Mar 2025 12:50:47 +0000
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-6ecfbf1c7cbso30877606d6.2
        for <linux-nvme@lists.infradead.org>; Tue, 25 Mar 2025 05:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742907045; x=1743511845; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=86XTbjdHZToTO9vFgFMOUGoOt+ekVajyxhh4sxGzdh0=;
        b=tU9hUukt4hWXX+kzTucX/J14cDK9aUw2ls1HvulBj7fVAiYcKzjnNnIPZ1L++64D+s
         4yCmDtQdYONhvHOAuyabELbbOwr0LIKFOG6FZsdC6YJb3ccdPckwshtkRS1NMupXmry3
         eXdIxPjAyJIClmzUlqogTJzZO0OcnSeqXL4fVfJQ3VJXGacsVrJAigZcTgr/iELeLVC0
         lp0ct0YVIyMtqgb3mb3enxSEW8Z/Lv2OJLctNOcqtppoxaO1mH4AqWn6RVh13VTGwoaE
         LtKHVLK0LKwF2OXcVM5Jdb3VrewaZNS/87RA0HSDwehxsxJ9Vzb02m6iuQkP6wz3f9D7
         13QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742907045; x=1743511845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=86XTbjdHZToTO9vFgFMOUGoOt+ekVajyxhh4sxGzdh0=;
        b=H8FTgs53MiE0qv7c5DvDIv2PmrvUptOlxQJ2BujkEU561xV7fsZ77hJ64nxZDWAMVu
         3S0taqGRKT/P3y3wNd1/CZ0iZIJT1xYU4KvuJHKJqIbHqDx1M40PUucGMop2UkzbogPk
         EeQ/Wt55wHdIOKY3D+y4hzvO15kGZKo+GSkt8rmWfi3MmoKxSBsfylO4/E5rv63hTuvs
         ikmrkOxuC+E1gX2uzW8oLazvuvwAkoBAC5CIVm6AKb3xOzMaVXtVJ5ciG8eLPI0PthYT
         nlnxNS2EgZuuLloKyvUEazPwsHCUCWHb/LNOABigmCYsfrsvVoZYrFCWondDDtkFwSmm
         nLCg==
X-Forwarded-Encrypted: i=1; AJvYcCWzWGmLC4odJmrZvyLbW9IBJlgt/r0EM/H6FEAHr6mKyYO/ac8FrIUJTUA0nkvoFjWbl5oluQN8haZc@lists.infradead.org
X-Gm-Message-State: AOJu0YzwLFIPNlvSNFBSmoOC2hqegaOUkiPImABXy8dyKs8yCEH5hzCM
	9k5BuVr/lnh1ybZBW/S8LwA00Fzpk/gs+JUFd6hsUGnmBMe1rSr5Voj4DaE+5JY=
X-Gm-Gg: ASbGncstOYpL7dVeJNSt9zNH42g4bI3Sj/+uoGCUCEfYvFaR4J1+YISXjr/5pTU9JFu
	zspOs5/Nbd6Ur49jWBtjE2WBeWtZKv1yyaRE5hvH8vsT1N4qetVE22XWe1mdeEdfJ68WRFL5eik
	6PXupNOlMKGr2Onq6VdFGRn+JtimkDqQSW7rtI38OKoHRCQbk8h6mu1vUN8KXRELx9tH8heiAqy
	RGEcvH+s3Js1DKxnKy6/z7dvMIIs3INQAiUSteQglDGD4NCKNbfBuC2173OaauZu/CJSWdwSM0b
	FCgC3BB0IufMrplx8OSd4+suaIuU9L8e1LzcDiqHYw==
X-Google-Smtp-Source: AGHT+IGuLsKAsZriQ88efYyaOks4mTlTOIy6vgScpsPY432E17wHEpRLiv45zRl6y2rkbK9/IlgDcw==
X-Received: by 2002:a05:6214:212a:b0:6ea:d40e:2bc5 with SMTP id 6a1803df08f44-6eb3f2bb5fcmr272837256d6.9.1742907044676;
        Tue, 25 Mar 2025 05:50:44 -0700 (PDT)
Received: from [172.22.32.183] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef317fdsm55908016d6.62.2025.03.25.05.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 05:50:43 -0700 (PDT)
Message-ID: <80ac818e-33e0-4b91-9207-74da182de025@kernel.dk>
Date: Tue, 25 Mar 2025 06:50:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] nvme/ioctl: don't warn on vectorized uring_cmd
 with fixed buffer
To: Caleb Sander Mateos <csander@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Pavel Begunkov <asml.silence@gmail.com>
Cc: Xinyu Zhang <xizhang@purestorage.com>, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250324200540.910962-1-csander@purestorage.com>
 <20250324200540.910962-2-csander@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250324200540.910962-2-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250325_055046_127511_8670D83B 
X-CRM114-Status: UNSURE (   8.03  )
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

On 3/24/25 2:05 PM, Caleb Sander Mateos wrote:
> The vectorized io_uring NVMe passthru opcodes don't yet support fixed
> buffers. But since userspace can trigger this condition based on the
> io_uring SQE parameters, it shouldn't cause a kernel warning.

Looks good to me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


