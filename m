Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6D8C83F25
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jul 2025 11:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q8mQgNDfj9/DCSMwSj4e+eU/AqdUmKFCb2rpaObipto=; b=ehQxA+R1vvD9IJz45inr6pH3KH
	30c6j0/4N0LJUSGJW7GdrGsgttW+oaqB2zvHSnySHvOGFLBvSwzwdCXYpSs2jNLTryfJoFDsKlJK2
	X8DHYDbcPl++9Feil1j6WfOd5CLcqWHv7nsIwgC9znRRGeZ7POwky8evykD3x6SR3qTbRzIpU2ZH5
	b/0AfnrA8AK4UGq6JtNfU4GXVW4aJEBi4h1GQXyCuJ/+hJzXYxgyjEFFc9TnO7+J1UQunxGjJTia5
	njpiBssLINwdbpxy58PVUlAsJjzLHzEWnk7ybJvtt4A1QtycYfLxSYfihjRS3/03U4VUGkCRRdsBU
	Ej/9z7kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueAmF-00000002Dyo-14uf;
	Tue, 22 Jul 2025 11:03:19 +0000
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueAeL-00000002Clr-3hgL
	for linux-nvme@lists.infradead.org;
	Tue, 22 Jul 2025 10:55:11 +0000
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-86cf3dd8c97so483032539f.2
        for <linux-nvme@lists.infradead.org>; Tue, 22 Jul 2025 03:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753181709; x=1753786509; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q8mQgNDfj9/DCSMwSj4e+eU/AqdUmKFCb2rpaObipto=;
        b=twxiN04q4oygtP/tweeKeq6u+UbEURt2asP/SvDEphN0zPHJBhhBFhryiUAY4O9pDO
         4tCx3vDBFL+GN7YBRAII6cVAXcI7I5VJ8kYpbxTenBWgvtYY9u0xQfpwc61ti+oisnsU
         br4LJYQ5cDRzzpquqLexlzBzBCR044BhNsmCvMWcUNcxxGhWZGhUrAk08UzKMZVdQxb+
         dHyP46Ph9gbwOl2aSUrS2XlPZK8hpoKUc/6R3cqvjwoWc8CqmsWWBEWfT1xKFgmakSTU
         82dxneyg4PiGQvG4N/lr0vdmMPNp0DQLJNY49O0JhtHdlrifDq1hW/aEvgU9XpbHRuX6
         PduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753181709; x=1753786509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q8mQgNDfj9/DCSMwSj4e+eU/AqdUmKFCb2rpaObipto=;
        b=nQncjkZCvWCZhiGDb3PVTJSuaEjCW7XvILGf1dP4PLRgGOfSY7zjxU/Z3UWHD4FHv8
         Wjv/tdhWJoYW7N/4mQjY7ZYGrk1OymN+y7rExNl88QgorcsNAuvHfsHEHKCkOBEBUMGR
         mpfeiYI2cM2cRwmVTuDSvC7bxlxKD8/zbJRkZO2vcrAVVDTEW8TwTqiuCIcZtFGPbuby
         JHgRUq9EbWn0jQHaw5e6Oxzmg05sc/g5jMN3ydtWR0dTC53mezMFJYQQSsZ3571mr+Ai
         PRAPLiPQoo317nE1eRnvc/fCYhEODWXQgsuzMvWwvAJgvndDsihOp1voECB7S0m6cvL+
         TOkg==
X-Forwarded-Encrypted: i=1; AJvYcCXNqmDb0rPhb1ICBZRS/l1SBl+0CDvmQb6MHz9ovFTXaVskVDzUz3ddVdiy+Gv5Mi3BrXG2RqZ8qdzh@lists.infradead.org
X-Gm-Message-State: AOJu0YxcASPacewC2AX9Ii6+t0mJcmSnbDRLUWoup9/SzmJuIxisRLsm
	vLk2EaiYZF+wNy1+ezxKs4RP1WquCFpKbpBoszoQ4T1uPfegZgGCk7GcmMs/blrgKfg=
X-Gm-Gg: ASbGncvq5xbdNT/jL50vrEMfp7NsfLDxrSw7NSMlesnlU9/HmrioGVEViFwtZGaCDAp
	6MFyl0wgaRB487yJrml8w9iXc4FGoq0po4a4o/Pk7qTNzRdyRM8vyLyWfJelh6hOGhqR4ua39W0
	OXftMcOtV0ef4ji9wubtYRCBxELAyKicQqGJgR2gPb5a8Zi7Sh6nK5TkHQkWcC4LRULIjxAdmyT
	VnSSubwNyo+JCQMT4ehOkpUQpulT7iZ+S7pte78jsJzEqpY0yJ/Znze5o5SOtVr9/oYxNLav7Pz
	NyfdVpIn8aOvGgkE1kQfMmhKsTzomOxw0mGiMWJ54tLgj07rC0edGSsjXAjJJUX4tzK3l60TC+k
	UdouEywjPZcZKplqfIj4=
X-Google-Smtp-Source: AGHT+IFg4g8uCoZqaZi2cgFfI8SmZnEMwMa0z6ZfpKmCt/Qia/PM+IeeQoX8fzecqzLOKJrgT8ciiQ==
X-Received: by 2002:a05:6e02:180b:b0:3df:29c8:49ff with SMTP id e9e14a558f8ab-3e282ef06b8mr312674345ab.22.1753181708591;
        Tue, 22 Jul 2025 03:55:08 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e2a86bb755sm20270715ab.57.2025.07.22.03.55.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 03:55:07 -0700 (PDT)
Message-ID: <252e6af4-7024-4805-807f-ac8407808c24@kernel.dk>
Date: Tue, 22 Jul 2025 04:55:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 6.17
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org
References: <aH8qCeSvpt3eH5g_@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aH8qCeSvpt3eH5g_@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250722_035510_067189_18BA8697 
X-CRM114-Status: GOOD (  12.09  )
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

On 7/22/25 12:04 AM, Christoph Hellwig wrote:
> The following changes since commit ab17ead0e0ee8650cd1cf4e481b1ed0ee9731956:
> 
>   block: fix blk_zone_append_update_request_bio() kernel-doc (2025-07-16 10:02:18 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.17-2025-07-22
> 
> for you to fetch changes up to 5b2c214a95942f7997d1916a4c44017becbc3cac:
> 
>   nvme-pci: try function level reset on init failure (2025-07-17 17:46:33 +0200)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 6.17
> 
>  - try PCIe function level reset on init failure (Keith Busch)
>  - log TLS handshake failures at error level (Maurizio Lombardi)
>  - pci-epf: do not complete commands twice if nvmet_req_init() fails
>    (Rick Wertenbroek)
>  - misc cleanups (Alok Tiwari)

Pulled, thanks.

-- 
Jens Axboe


