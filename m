Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6704D46BEE
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jan 2026 19:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/Ewob0WcwF4ifY/C+F0aEm6RImTdQFSMjpUMok2fO5s=; b=gVIwstIHoWBbhrx5Tud4aA8NZY
	XuW1vA9NYM4Nz6gppksfzufjgDXjqIbdIi8oeGegyX249DOE1WMUNMT2dCx/4WKZsBIoz+1BplPkP
	OH2hFWBlayyiJI4YcNE8KvzfkaN+g6GZFsKhN0iAkkkS06qBA9Cqe0QCXIgiCyJQHVPOMk83dJFwa
	Rs4wE1W3iynkpiwZD5COIZGx+qzf17MlvDDgXQxkq4fKQFzNBRng/8RaB2meSrCqlkAYJ2+tLajAz
	t0H5MjHTG2rs0asOpGM9eUDfXGnA+BsXEmut7Rs6FESK9HiwZmigHXLxMOFyk61kuTEP8dYxQdDUC
	QMTj9PJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlAli-0000000GepI-1H2g;
	Wed, 28 Jan 2026 18:59:58 +0000
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlAle-0000000Geom-3LJG
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jan 2026 18:59:57 +0000
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-124a1b4dd40so298766c88.0
        for <linux-nvme@lists.infradead.org>; Wed, 28 Jan 2026 10:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769626793; x=1770231593; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Ewob0WcwF4ifY/C+F0aEm6RImTdQFSMjpUMok2fO5s=;
        b=H9mA3CFEXLi3nWCAhQHbO42y1w7SmzobQvGg+MRoJZWQ9+KheiyronP7W1PbObKadH
         On8EDQnmXs7wlUNtOM2abBFMsma9mgdmX+mb/MzFJUEmkoEvmLEWnxvs54cDf2XtHmPc
         3z0IuVvjPHO22GLa7b/Cj/Tp3hGoJNNAgFt9NGf0378vaao1cy8pwVkNkWyasyqtPsxF
         TD/4++cLDf8THelLcYY9rg3+WL3xbvV5SU+2gqBRWzrq1dtfI33vjaoF5qJZ2QFd44xQ
         z+XPL7TfyOJf4L9X5JuhK3865VAWpu/3J44Qg3fYEYIb6tw2/IO6vF4LuIKWa3UaXRwE
         Tmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769626793; x=1770231593;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Ewob0WcwF4ifY/C+F0aEm6RImTdQFSMjpUMok2fO5s=;
        b=FdpoXebUjpiH0puIlFBqzkIUU7fTdp7fGlaHBJXTHvCzJ/ujBjkfpXMWgjwiP5NIvk
         K4K/0+cUnKrP3bW0jhzrHDwKbXtnAwLc7UhI7seOwsywA49L353dUDG1PkCosaVjg+lb
         ZA6gZRToCybWHLx+PKUsCz7nEPUjbZruMvjQv4k31yEqTR45PS9MZcpVKYVfvwWrw0ah
         YA+CSV6ZG0/pnQVtLlSRGdINT31kAByw7lnxd4x1Kni/C6h5WcOs+fEXznBdn/rXOqJn
         Hbkx3FrV+AY8UnyRJ32Wr2JLlfIij8sB0I9ZolPhkStGU7Io68gVqaR3Fkk9wrZh49Jl
         FCdw==
X-Forwarded-Encrypted: i=1; AJvYcCWWVhWgq5bWiSDE5WiyRhP6bPo0JWK7shgaUaHnNf01Je1k3RYzNa+JoWsZ4xVnRBH4CltYt632zr0e@lists.infradead.org
X-Gm-Message-State: AOJu0YxKmpY4Oz5dEvHklXoTTTcMi+uPPBG9Pcg3GbslhhawtOAuG9Ne
	Orrq2qdupMVXC5GXGtUSSYmcKAYWZDPxbxzBe1iPkC8MvZz6YLfZj/9gyydy52Arxq6VLeMh3mg
	LjE8q
X-Gm-Gg: AZuq6aJTVCqOikH1ASzbAD3CnvEIfz8iTfsuIfHqxGsu3faPvsuvUgNKIJ0RHlJe/Ez
	0LKzOka4ePQSboe9pYSNV5MLHFuwv+isw5sswQU+6tmZbxr1jLq+IO+7JnD9RTh0OFR/nmD9otj
	TBnUU29NqQ7u2ZksAKsmBvUtJsPbzFiLL/fAYNMQZcN6JKvDG8NpRT/sRaDDiLUqRnECK6EuGb/
	SbzGVwUTmYoOtpDOZ2iRDOSuT1OYjWilA1s9gTn8iVn7SLPAEx6QzXGdJbto7bz1vDsnmysT1CT
	q8R+vmCVGaaJkCjbuIdsjKsIfZK+WHgqHhMwroJ2J7jiu/6Thq8dI1FVMZZnUvCkIwuG57tYeEX
	ZwQNmfpkiz74Uu34xoiFAaJaMMVV6f9CGCFynY2wyQaOpAmlClvt7MM67PQA2edRJY3OKQ+Xzq4
	E6OGjKvWESooYbNdSxYags3wNZe26HqX6n9IcT/BTd/MhIbxwedylCj1n5r7Km/8i56Q2dGj1IH
	yW+hA==
X-Received: by 2002:a05:7022:238c:b0:119:e56b:9593 with SMTP id a92af1059eb24-124a00b0877mr3846465c88.24.1769626793468;
        Wed, 28 Jan 2026 10:59:53 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:122::1:58f5? ([2620:10d:c090:600::6cc2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9d6b663sm3453150c88.1.2026.01.28.10.59.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 10:59:52 -0800 (PST)
Message-ID: <f2df2ff7-386e-414b-8049-7c1a8a878889@kernel.dk>
Date: Wed, 28 Jan 2026 11:59:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for Linux 6.19
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <aXotHSsu33lw7PiE@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aXotHSsu33lw7PiE@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260128_105954_977300_72C23B12 
X-CRM114-Status: UNSURE (   9.38  )
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

On 1/28/26 8:37 AM, Keith Busch wrote:
> The following changes since commit e7e1cc18f120a415646be12470169a978a1adcd9:
> 
>   selftests/ublk: fix garbage output in foreground mode (2026-01-21 07:54:55 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.19-2026-01-28
> 
> for you to fetch changes up to a54afbc8a2138f8c2490510cf26cde188d480c43:
> 
>   nvme-pci: DMA unmap the correct regions in nvme_free_sgls (2026-01-28 06:58:10 -0800)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.19
> 
>  - Target completion race condition fix (Ming)
>  - DMA descriptor cleanup fix (Roger)

Pulled, thanks.

-- 
Jens Axboe


