Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEA3C3ABBE
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 23:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QvpuwIvdkpUgNK2Yc7QLMkX1AqK9X+e1VKwAhKyAtxc=; b=Gqp9xI2+qztDVGp/lD6C9Df9lM
	m0pXHRZ3VjrpsRGFYGPKf5B36t6DyY29HglNxpdjvwXcvkW1DxKzQGAi0r3Puo/9N1f/CmE6L+2ea
	7u6O5wkXz1nkOQ5AFORuF8IJIh4GqoyI+26PSLUcUTWM8q8f2vP6TVQNgiilTEAfk+RQC/UEhElnG
	Q5cdUs2PzWz//cgmYtXH39UaVUP+/lD70FM/zADe41O7uQ2GQjekvp29ScDwiuT0PE+9nU+NRo4mR
	P1xiSQ6HtPH1vFowTi57sEmfT8hdQVq8Ypwi81VlVSAFcKYMiBAH7+Sd6aetA51uwCYPG/n/4onRU
	nTKvkkYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCS2y-0000000Djs4-2sPx;
	Tue, 06 May 2025 23:50:00 +0000
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCOFr-0000000DGc9-241S
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 19:47:05 +0000
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3d57143ee39so54377865ab.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 May 2025 12:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746560822; x=1747165622; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QvpuwIvdkpUgNK2Yc7QLMkX1AqK9X+e1VKwAhKyAtxc=;
        b=IrHhaWKQGaUS1KmqxAnDcv2tzD8+H//NaNQxiIbcU9MmM++VYkkYrqZtzA8UxweyX5
         bUdEM5tXVEIX3BapNp0COdGShZ/9VcjjpjcK65+31AGc8sXG1SOBQ6XjMbXnnta3ZqC0
         HH9qlhgKjYRhohM4Zct3/gDXT41Z7K3TUZKkj+iJH0btKHu2LYU22khPz5ImPR4Y01oU
         6FGPrZMo+rn85StYQvyFYbUJ/LdT3aGVleb1R23pYGxOdmDVkCxgCkEu7x/cTw62Nfie
         WuIZjcKjdNfnbXYGTVAIA8Tbw1A24tE1OEaoEvti+SvXAQOW7UQUrz4zryEXsuuY7vUR
         E3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746560822; x=1747165622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QvpuwIvdkpUgNK2Yc7QLMkX1AqK9X+e1VKwAhKyAtxc=;
        b=bK4RxmlTO6Bulhbg63DBNV9SUur5inC18C7Yb5nHFs2oz7AndSWVa1a4GrJWdZZifT
         3FZeThjillHLXm56yMwu5S4Dzn/vT8WBYj3AE9+ajPHSyXlIVogyYPcSMrXjXXNoLbnJ
         LepgLJM9FfiErC9tyRmOpcZJVIQdJ+bwl938SSot7dR9fYs5SNTt1GmvWtwLtw6/fgvi
         fbVa0QOC+CZ2IpUayNcAxb7eGtaBLiq8F8hIyrU8jQR1mDOGElt7MEBDVwzVGNd/24e3
         WqfuweKmocYHVm/qSBkhhvoRxmoMWnUjsF/l9p0+U7uGS6C+MYSJ6v76sHRNtKb33lrN
         fpWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDM/ywOBV058HmPO1mhJiChe3EpY/q42UqZcjXodlX7OaNUaQvMAGFy4+yqvSWvKEHrzPK0/tU5+UV@lists.infradead.org
X-Gm-Message-State: AOJu0YxXJMWWZaVXn9EAu5MG1T/P2q7yKqYcftcVW20DtIW9UQIce4gU
	cUYa7itRmWCp6jCVrEHxS9iNT0LAsJ8Avbp2PYgF3GbgbmOZK2hiKjvWXHIUMKE=
X-Gm-Gg: ASbGncv0XvA9LyD65sdATxj8pchHme4pJGW/Vqf+ixR7xerh0X/RzSx8AQ8oMVoFFXi
	qzgP2IjU75/+1s1gPiKEGJ4458q6jijrTguYN/ea/tAWM/YdAQSi9phfVHKQw311Gxu1PPSMgvr
	nbjRJN//Mss0P/n8nVC19ZxF3DOO7dEjraf8vVkEc/OXpjs9HiXSjRkQ1p7RArt7M6aMNCsIzpp
	rSTwALIyzIjIXCGDFvRr4GjDCAUc626yPTySNliVavwW2Pk+B+KQKc4Bfi0oOPSvPXRcs7DBKji
	8Q4HdGgg8Ft4f1srT30+WzE/pyf68d/DwSkU
X-Google-Smtp-Source: AGHT+IH/KKdeLMsJrfl2GNt0EmPfmCGYuhpX5R0KzpT71JVPHW/WMZh+dUa1DrrDkjVlTPWNDEKr2A==
X-Received: by 2002:a05:6e02:1445:b0:3d8:2187:5cea with SMTP id e9e14a558f8ab-3da738ed70cmr5137885ab.1.1746560822589;
        Tue, 06 May 2025 12:47:02 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d975e27c8esm27734305ab.1.2025.05.06.12.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 12:47:02 -0700 (PDT)
Message-ID: <07af392f-fe4d-4e96-bd2c-392f64e82261@kernel.dk>
Date: Tue, 6 May 2025 13:47:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: fix incorrect sizeof
To: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org,
 linux-nvme@lists.infradead.org
Cc: csander@purestorage.com
References: <CGME20250506185729epcas5p42c58afcb24ceb7be79babb63932677bb@epcas5p4.samsung.com>
 <20250506184843.25081-1-joshi.k@samsung.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250506184843.25081-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_124703_797418_E60A576C 
X-CRM114-Status: UNSURE (   9.98  )
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

On 5/6/25 12:48 PM, Kanchan Joshi wrote:
> The plid array, head->plids, is meant to store placement IDs, each of
> type u16. But its size has been incorrectly calculated, as the size of
> the pointer is being used instead of the size of the object it points
> to.
> 
> Use the sizeof(*head->plids) in kcalloc so that we don't allocate extra.

For some reason this isn't on lore, I hand applied it.

-- 
Jens Axboe


