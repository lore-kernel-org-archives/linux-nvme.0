Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FA3E77170
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2024 17:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h1Z7B6rrTrqZ0JQtHBEGOPeYDQJyEKnNN9wRChz07DQ=; b=Xo3XuY9juPduDlDKTra9yDqTPp
	jmflLhl0oEuLe6ULoSIwG1URj5i8vDi4tmkiNJLaIsV757kbiZp7SKBSO0WPs+IrsrJpeuylWEQQn
	jnC05+pFlmexsRG1kTsP8bdMatDnP0lCUCkgHoCHjE3vdXbVFT5mrPzBWSZ9cGHBgFJ3hrY9OeN0J
	5E4bcSMPbK/6J3YL0YTgAnYcwtXmCj0DaTuEwN//d+A5CZgdRjQg4g3b0BzSsH4W2C6rMWpyZfe1O
	Gso48+0HTxot9YMvcoAxqog4R1OXm+c1Dz0ZiQsbKIS6w+nvkWqopehq+ybeHfVc1/iGDN0mk1MZp
	m20WECWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJFa8-0000000Gw53-0GiK;
	Thu, 05 Dec 2024 17:24:04 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJFRQ-0000000GtyB-0XEc
	for linux-nvme@lists.infradead.org;
	Thu, 05 Dec 2024 17:15:05 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-724f41d520cso829775b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 05 Dec 2024 09:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733418902; x=1734023702; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h1Z7B6rrTrqZ0JQtHBEGOPeYDQJyEKnNN9wRChz07DQ=;
        b=dhgGdQugkzKJ+gyo3nTjI+w5nouJMxp5+WKXGS48kO74cAfi/TPdmJxYCBQ2YJVjyN
         emsOTuQvpQxFJf0HAwa/cCYP+hp1RTFiez0wHFCNQkuSjuhRrjKVZ1skhooO2uNfJYYU
         O112MhkyZwmx2/cK9zAN6mDsoDr9u4/EUVO6fogEfDvgWA8HQPMF6vnsxYx0xyrpbpbZ
         JMbu9gptyUeBjAXhNcaoP2UyRUG5er7QtLtrEIVVBMQbZRND6AsZi77yg7oC+qUUXeGu
         OKZkzSLthCBx8neDFSNMz91xQqyj+nk/ncCKg6NyS/t3KvXsm+TlU3NlnKy59+ZPjnBi
         yTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418902; x=1734023702;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1Z7B6rrTrqZ0JQtHBEGOPeYDQJyEKnNN9wRChz07DQ=;
        b=fFqwN/7w4HujzrT/1wIqwqg+dm7Ly3CxwZew/RArH6ieBz2EoTu8zdakmea5VO+Xik
         qVc9FeEQiBC5/u3ifDeOUH2iHUKFUrR+iigQ1Bil3EyjFjy0+MNE7YXB2fKMCwSqa9HW
         +UOASMtHWFz7M4NI50F/MMAa2rb3fQ4+P4d9NkHGefIMAgld17W9l6agr/uXQCKrnO5x
         eevT/usPlfKndcUK/jqcLe/tSGYgbTN5HunjZdf3cAO8EEhFuGiYGASdSP4cg10RDE83
         0CpopZAGS/+VBx5zAlQ+xrVQuczRhIE7hVgX0klUTSmYNKXWJMv36uDU81fNAYyfQfH8
         Sq8w==
X-Forwarded-Encrypted: i=1; AJvYcCVQZVwyhFyTInukwuTu2utOJHsyOX84qbmTeZhfgEfbDtLia4qnUEf5gt3TZRa79ZLwcQ/w9MZRQQDF@lists.infradead.org
X-Gm-Message-State: AOJu0Yzbf7mTkjkvtgo3d8O0ICbICxrGKP5cdUolLKoRHNJRulrxMS2g
	4IrcavDy75HRv278gBoTAYsaYc9Adpq1BeTPyVZ8jERSpBG2Rbq9cidjRmSK0gU=
X-Gm-Gg: ASbGncs7B+gbaPEkpPhETtH9Z9PJ/wn0n7uo8UfvALpb/7gLxyKYc7uXEWRibGvvZWT
	E5c531w0f8jqNZAygedS096QGTJpOKai1BHXnaBCaerPoJj+AOEHDkI/8HxPo8XCxnXxZ14TTX+
	3Pc7mThg3aYQe8NSfYqvmm31u7aRhPv/WgXwzVaDXp+00EMSN801Hh9UrKNYz7ZhpL5HG37jA7B
	Pe5grZybouwXbwxDCyXaazNyRj5+AH8prYDbXnSf1Wg/8kRBxC343iLbg==
X-Google-Smtp-Source: AGHT+IEIFLXLe2+sgRo95u2XcttT45HBI1Yg8rzpKSeuOktcKJdtuj8S6xJxFIx4psW9+BsZyXsZnA==
X-Received: by 2002:a05:6a00:1791:b0:725:996c:3a17 with SMTP id d2e1a72fcca58-725996c3f24mr8269907b3a.8.1733418902476;
        Thu, 05 Dec 2024 09:15:02 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:122::1:2343? ([2620:10d:c090:600::1:dea0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725a29eb23esm1481220b3a.76.2024.12.05.09.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 09:15:01 -0800 (PST)
Message-ID: <5b656b9b-2d3c-4ae0-8a73-6eaf1971ef62@kernel.dk>
Date: Thu, 5 Dec 2024 10:15:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.13
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <Z1HeockCWHXRcvGb@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z1HeockCWHXRcvGb@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_091504_167997_1DCE48DF 
X-CRM114-Status: UNSURE (   9.79  )
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

On 12/5/24 10:10 AM, Keith Busch wrote:
> The following changes since commit ec9b3ac6e5630e320d926ea13a06d86d2a6bdde1:
> 
>   Merge tag 'nvme-6.13-2024-11-21' of git://git.infradead.org/nvme into for-6.13/block (2024-11-21 10:57:34 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.13-2024-12-05
> 
> for you to fetch changes up to b4e12f5728ff963ca5590c48b85a20d076bf517d:
> 
>   nvme-tcp: simplify nvme_tcp_teardown_io_queues() (2024-12-04 10:15:46 -0800)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.13
> 
>  - Target fix using incorrect zero buffer (Nilay)
>  - Device specifc deallocate quirk fixes (Christoph, Keith)
>  - Fabrics fix for handling max command target bugs (Maurizio)
>  - Cocci fix usage for kzalloc (Yu-Chen)
>  - DMA size fix for host memory buffer feature (Christoph)
>  - Fabrics queue cleanup fixes (Chunguang)

Pulled, thanks.

-- 
Jens Axboe


