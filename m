Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2208ECD983
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Feb 2026 15:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rkr95X8plFoob0OOQYzANjE1jpTBHc9xrcrDHUBHuvc=; b=eLV10uyx4sV3jg/7FUcgpkS21X
	bKWu8Gy1SQxh3nuWND397M8a9MyC4mYfxtMM1D6y16Ie5o0Y+6sVpWZd1VULMX5nNLbYIva+ZyNNp
	otv2NrY43HwtMzWqu9MV5Veb06ge6BI+h3qgdI52XueAijAdm20DZQWhBGdfLLKdll+c4mnGIQKk6
	bWpEXP4/7YLAGuDhgpCB+fLZynZLTQpZD2ch2IIMczk2pq+Xd72lauZtZmPpLeEI8N1J2GylF69ZB
	hHglEjvtEMd+SG1Lx9dznZawJa0VCmCnCVEHClJGB6otUWLpK0A+XtPCprB9qHg9QOfZH/a5lBK0B
	D0joWdHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo1aG-0000000AAIO-0GJT;
	Thu, 05 Feb 2026 15:47:56 +0000
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo1aC-0000000AAHC-1gnc
	for linux-nvme@lists.infradead.org;
	Thu, 05 Feb 2026 15:47:54 +0000
Received: by mail-ot1-x344.google.com with SMTP id 46e09a7af769-7d44b2df00aso443446a34.3
        for <linux-nvme@lists.infradead.org>; Thu, 05 Feb 2026 07:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770306469; x=1770911269; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rkr95X8plFoob0OOQYzANjE1jpTBHc9xrcrDHUBHuvc=;
        b=vgxKkJ3731sSUcLcqQeHlXrf+VX3Z/VzjN/CVfJdWSVTF8qOVZ/Mm/n/QWUeiJ9HFO
         6wfTnqQKQwfDW4j9hEXilDeAd4G9/qZbU8p9u0BNaiZdzRfm1tjRfo4Q8eREQLpzCGBE
         6tPs8Tsq9IDYOECmIt8H5N7MzEoWKXfGaxvhVfkssUlI4SzYOkmHavUjyGAj1yLcf3Cd
         u9Ws+P0vJdVLE50v56kKGjBd+tZvuHx6auejUNdP05Kms4+ifDVUrvRGrkYonnpLk5vl
         gGedB9uwI3jWp54B/uaKLNiGMn53SOoDMfU68yH+CM7xfUH9oZooqbJTvOkDcOMGAEW5
         vUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770306469; x=1770911269;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rkr95X8plFoob0OOQYzANjE1jpTBHc9xrcrDHUBHuvc=;
        b=Y9yTpMa81FyJQwJfvzxzb+PS3OZdHFRMtkVbfg0uoiJuW/ltSbNcAf2c6qNwPK7nrl
         5OqL8Ec4+/pAh/8tdvENKU03H5bixVJiRVl0WEeoc3I9wkPNOfu9biAlnsOXORrvzHHD
         ArhNu+HAVZJJGk1NhnUkWvUuLatYKhtWMhDScHbu/qozxbfnqQzrnIRTaG+x5fTJBItK
         QRGQCyKDSi7lAJKaC2K4Wm/C/e5mZ7Nh4ql/vcbjjHOrhdHisYwU01xVYBaOdVA1O/7d
         ZSueQ/1+1lzRjhfXr7cH+VLE1MXZzmD2+k6HUsyDcCKi7ptm9tSsNrUafR1kSgxdV5iu
         1NXQ==
X-Gm-Message-State: AOJu0YxyfN0JN1W37lN6Wg+NM6r+Hw0BZZ2WYtuYHRTVbe2MRbikNQAl
	7qDoB6MxAxvOZLlM/zXXWchldL6/LRM8grkJ1u75DnyQlzstmYTMlguCnWokeNc42Hs=
X-Gm-Gg: AZuq6aLUitGhLL3EY/xTLxW4yoaSDyQh8pIYKZRW3c8+nFLdAwnFrwI/4TU4VTX24HU
	KlR4IIKyiAhlY/3E8rGtZ1kM1z8A89kLKVW5Yjekv2ipOKp1dUyf4UG8xZYdcL0hiFWFmgCGOu7
	Dv4ZqiEEJgjyomCvXCzerIekkBrGQ5lbGZZxr6vpSixW7OfpDkNjiAy9J/kSQytvwUww8GMesb4
	TYXaf69h5Vp03LPRLfcs0TuLAKxt3v2ZL7ZdkYdDQQGwgmmUyg1NkwcKMy1GSdemziSXvmMvNx0
	g1Y7zbnyRIGwMM6CtQpWXURtBAqngtVvOeK3W8tIjrNg1J+cNVxIj+Sdw51/QkLj1B1Dbt0qSTu
	uwqdn4mN+GmNJgo+1lt6+IgZ917tUOXZTsvptCLYw9Ba2yAnB+WX8XheCsDN9h/OC035lSg9xb+
	qCOEQU2wwMrQ+6nBzXvvxiTxeRRTtYeZN08l22d3XmgLCzSgseqRC9AiXMswN9zZZwHtJrARAIx
	7eQKE1K
X-Received: by 2002:a05:6830:3c8a:b0:7c5:2e2a:d386 with SMTP id 46e09a7af769-7d448ab5e2bmr3399491a34.21.1770306469315;
        Thu, 05 Feb 2026 07:47:49 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4492299cbsm3615966a34.21.2026.02.05.07.47.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 07:47:48 -0800 (PST)
Message-ID: <d114450b-2405-4ed0-bcda-03e08f48ba1d@kernel.dk>
Date: Thu, 5 Feb 2026 08:47:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for 6.19, final
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, linux-block@vger.kernel.org
References: <aYS5ZlwruxpNCdTL@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aYS5ZlwruxpNCdTL@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_074752_712762_B2022AC7 
X-CRM114-Status: GOOD (  12.51  )
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

On 2/5/26 8:38 AM, Keith Busch wrote:
> Hi Jens,
> 
> Some late fixes for nvme that should go in this release. One for a pci
> regression that causes a kernel panic during certain dma conditions. The
> other fixes a vulnerability in the tcp target.
> 
> The following changes since commit 4da7c5c3ec34d839bba6e035c3d05c447a2f9d4f:
> 
>   bcache: fix I/O accounting leak in detached_dev_do_request (2026-01-28 19:06:55 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.19-2026-02-05
> 
> for you to fetch changes up to 52a0a98549344ca20ad81a4176d68d28e3c05a5c:
> 
>   nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec (2026-02-05 07:29:10 -0800)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.19
> 
>  - Fix NULL pointer access setting up dma mappings (Keith)
>  - Fix invalid memory access from malformed TCP PDU (YunJe)
> 
> ----------------------------------------------------------------
> Keith Busch (1):
>       nvme-pci: handle changing device dma map requirements

After this one, iod in nvme_pci_prp_iter_next() is now unused, which
will trigger a compiler warning...

-- 
Jens Axboe


