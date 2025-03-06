Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9D1C282D1
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 12:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TDXOM0HVB2Fki46L7KtBT6vscKjRNjPU1nUatxlj9a4=; b=M26S3PfuzYxdiPPdvZmfixz9Jz
	goJfT3/sBcInmAQLNlp53fR/Ac07lnZIOYZT9h/5jtqVTmOF0Y9fDGSX6gQ/+kEqOXdqvHOLKQoH0
	5rEtagtguZOpvSRsTiQzJiSUp1nWP3BVByqmLM9GlzExCapAhYGJOiMzN8s3vJpRoKP8TBnHEYrJ4
	UhDug+p7he/nac4Z1zBmcUPl1nNT5Ml1UtjTDSBZGGWVwUwlAWsCVJWo3qEVItfVtuPu9m3E+R/GR
	Aw3tWZ6KRmctQNN63KIW3Cbm97K7ntB+sJAB5GaCko5EFKt/BO2L7ugqBB3nCpYmYjhR4QfCPNBOT
	6GkHMbAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqAB7-0000000AtWN-0iki;
	Thu, 06 Mar 2025 12:18:17 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tq9Te-0000000AnBx-0YCk
	for linux-nvme@bombadil.infradead.org;
	Thu, 06 Mar 2025 11:33:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=TDXOM0HVB2Fki46L7KtBT6vscKjRNjPU1nUatxlj9a4=; b=IhLDkjEb8Y01vIeL5sBpjvO5/N
	/gzHQNhh1KhQJGPRwbHToCpkIV5vMFrUhkPVC0bGv9M3HldzVgAK2PlUP0lfVqMDvpff7uRd0LD97
	lQRttw/lEAyRmekz6qVggXw1wGQ1jpyZjQYuriJBqMM5/7+ww/PfueLC8H4nhyTzv1THdWhomevvU
	yd2XphyqUlePHIZyKOstp7CFbTU2rlfiAUjri75K/E8MQu7hNcLJ1Vb82sqyedQw/ZVsUTZ8nDDwS
	ChzvI4Kml7E1EC+n4UVPsfBls4vJGsfHsncycf8gGioVdfLgTDDHJoPI2MU4uOA80q89G5goHeVF2
	IFo8DozQ==;
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tq9Tb-000000012p1-0FOr
	for linux-nvme@lists.infradead.org;
	Thu, 06 Mar 2025 11:33:21 +0000
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-85add67e9c1so21738739f.0
        for <linux-nvme@lists.infradead.org>; Thu, 06 Mar 2025 03:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741260796; x=1741865596; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TDXOM0HVB2Fki46L7KtBT6vscKjRNjPU1nUatxlj9a4=;
        b=N4i43DkFmVFcaxnB2cKliB5TVpdMfYgRocBejdZX+7PVDAjnpdAwdj5I5oVSX2mIiz
         QUFS3HQ6EX92yE1Pv7gD2yR7trvdQvKuo29mEBu8+dW7RB+lPBYeiirDgsjjtHff2Msz
         hmynKgRaT6QGUugQoV397oi5+QAkAjH960OUQyd0P0BTVncxfkxYHHo/8vg/L7j3AeG0
         e7DazErLnIuTT/3/S5iKzRIJoqcDVTwuSbl6ys14G/Euaoci+dXtolOwm1lsNioqU6dF
         Yuvms8p8U7z1AgiD9a1ImRO4XINy48qH/8dRod4NityNvJ8d4W9o5Iy87UG5VDUW1b3m
         7MGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741260796; x=1741865596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDXOM0HVB2Fki46L7KtBT6vscKjRNjPU1nUatxlj9a4=;
        b=mgZmDNFMWDTR47/fUCRqBa33jd64GXa97Pz+fFg8+PgLGv+s4RQ7OK1FgyO2ZitorT
         Cu/FjjveI17sWxfYaHLlvLqSnRRZnqf8XL63p+mBTQ1Ng//1hGxgJ8Zl96QKWPjM4j3M
         7T+fx8VcAUXPlUQXCelNVb0iRm51BISBjfcZ+/pkUDwL6jgMyj8J+x8ikX430mpwtQhs
         m0QVacmkg1/G+Yp5v8g5/TAwQNp04k2hWPq0E+OeejUrbpg4AhUJBu4UX5xrI7lrvgK6
         5w4R07+oLe+F80si0N22MD22x6yK5tqb0/FkCo3XStOAIKtsZ4kkyinw5ZD8bo+By6Ma
         ySXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOyWiBcVOjZQ8OsY2Fw23Sr+I5RX1z6Zz3f3gDfeHRHM01wXDgt9zxsJQpEGl8P0EBn/BkQCc2/bVM@lists.infradead.org
X-Gm-Message-State: AOJu0YwEOrtomRPsztIllKOWBxTMXR4gQkFg7s3bnySps1fzB82AmBol
	ZJCgR4ZJ9FpqYwBtBWUuCnlmdKkbGLUJtL8a840k9Wms1wIRCDKlYq0Xkzo2Sss=
X-Gm-Gg: ASbGncsMnoKTkZC5lIDhv8eX8JO5fNYBxsPQJJsC3R6kkcn6OwjKqGDjf9hiWKWo9pp
	hi+RylYXZbiQ0ub/q8t+HBHj4Vi72afVGVFcaPG0NRDGSwr2IG0Dpl3/xIiOxp/GD/LTGZ9o6Q4
	XyETHW3NzdywdTznLz460PBF8rHH89/xti05U94QEcEDzmn7QTVydTCgPXXlr2eIJ0AgNy8PkvF
	cpsS5qOJ+iaEps7bdGJFOX40lY9NLhmkkusgn7wW9PnzxqBi8K9ht+hNTFIDT61KZqVpqaDMeQh
	8CKE06c1bGqwTDZ9S9zGj6N3nrb9mi1pqiMptcxZeQ==
X-Google-Smtp-Source: AGHT+IEKRkRnbC1L8baQJRdvM+CpLfR9bm61DA2WcJhbz4LECuoVyafrfj91k13rCopIlL+o+Az7Mg==
X-Received: by 2002:a05:6602:491b:b0:85a:e1ae:135f with SMTP id ca18e2360f4ac-85b0ea6709cmr246066239f.1.1741260796230;
        Thu, 06 Mar 2025 03:33:16 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f209df53aesm291746173.22.2025.03.06.03.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 03:33:15 -0800 (PST)
Message-ID: <e3f64ff3-99d8-4a2c-8f65-47f0eef7697d@kernel.dk>
Date: Thu, 6 Mar 2025 04:33:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.14
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <Z8j800qyBDDkQcDh@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z8j800qyBDDkQcDh@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_113319_310046_92C8D51C 
X-CRM114-Status: GOOD (  10.39  )
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

On 3/5/25 6:39 PM, Keith Busch wrote:
> The following changes since commit 70550442f28eba83b3e659618bba2b64eb91575f:
> 
>   Merge tag 'nvme-6.14-2025-02-20' of git://git.infradead.org/nvme into block-6.14 (2025-02-20 17:43:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.14-2025-03-05
> 
> for you to fetch changes up to 528361c49962708a60f51a1afafeb00987cebedf:
> 
>   nvme-tcp: fix signedness bug in nvme_tcp_init_connection() (2025-03-05 10:37:01 -0800)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.14
> 
>  - TCP use after free fix on polling (Sagi)
>  - Controller memory buffer cleanup fixes (Icenowy)
>  - Free leaking requests on bad user passthrough commands (Keith)
>  - TCP error message fix (Maurizio)
>  - TCP corruption fix on partial PDU (Maurizio)
>  - TCP memory ordering fix for weakly ordered archs (Meir)
>  - Type coercion fix on message error for TCP (Dan)

Pulled, thanks.

-- 
Jens Axboe


