Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E5DD111A8
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Nov 2025 22:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v2wHMLmab1VFhTQ8chRcPZDH+xYL8GZmJ1+LG5WAhQg=; b=Srl0WL9SXzSzzh+05Kn3QWHuLQ
	1cuAFb8pCtCVE7hojMPpExcM7rbSmHenH2rV8oZAFusL9Qm5STUaa2mD8hBmD9J9EXcsFE5PwcA7O
	fG4IYSwuqsh5rkeWcYmk9GnLsOO9xt1JZthlKLX7YXzu6G13F3CybZF0BqPrbDoTVfNBb41t87iEq
	RerbkmhSSdIkOQai5SLqQzMkEHDeVXblQA3ZZmtQWs4n21J10lpCksf/ejMHnkCNh2GRoxUL6sV1Y
	ZwAZIFDVBDRq5ghBZZEZGkdtOTgPD7Cip8vsvKPAB/4JnNPzQRESongZwwCknmx6oHl2uhVZNVUSi
	L9Sz5MyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPpdr-00000002byn-1YF6;
	Sun, 30 Nov 2025 22:11:39 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPpdo-00000002byS-03py
	for linux-nvme@lists.infradead.org;
	Sun, 30 Nov 2025 22:11:37 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso30794405e9.3
        for <linux-nvme@lists.infradead.org>; Sun, 30 Nov 2025 14:11:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764540694; x=1765145494;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2wHMLmab1VFhTQ8chRcPZDH+xYL8GZmJ1+LG5WAhQg=;
        b=smQk1JRazopsefRkw78shVd8r8MBgmALQX1cJ/1MmkdLV3Fs+pTSnI36Vf6CKVmfub
         Ztg5um3Akj/YlKNq3LiF5ZTKZtN27sDPTgN4sN40vpEcezmXSN4zlwEhwTWsxS847Lxc
         //m16bw2uEvcuXkB5C3ejKJQB8zs7BRu0mcQ4d3zBI2DRzG0pxiydF+C+qx98wofvJc9
         z/WlGKg/nCCJ83xfwZS7uTlx+SL5+H5h8uQtxPgNd5BFsD/pwMC0VcoInqJY47twWY6t
         giB/YMZyVsIpCgZIYIbREuZ+++zxOQbeYcHDvvz4ShhtxyatapVNVuUoX//mRN1tR7n+
         9rXA==
X-Forwarded-Encrypted: i=1; AJvYcCVmNRujk/WvJD+GgLZds1bnX9KRTp+pSK81PH9Sbf1fKQY44tFhF8NlmjZp3sVDyOB1dwvoCdpbm2/0@lists.infradead.org
X-Gm-Message-State: AOJu0YyhWTplllbaUD0JApQ8y06P/O8iALWtCtGy9yMl9cuGj1Xn65hD
	LYNpYwFZVn2qgyMGn0N4zImFAwMCp8dlXC93QtmKuSftAN0saqo43A5/
X-Gm-Gg: ASbGncu1VX7Jhyzw8At2yhgZkTLQZgtMTovEByCFFxL4zQMPYLBYVElsfT4CtnB/AAL
	G06zP8jINTya3zbK0xHYjCEz/rJlvxJl2xyKEU7SZBWbRcdX1CwPsYbqfN4aw3iZ/cu3MYuhgu6
	9MtaJ2NghSw11JjfxCRsguj1/A3XTnygAHFgHvfIxoWCD/emir4Ghzt5d3CDzfvEnE7z5jCUOXg
	0YAisD/yfueqmrnBxKrYgELyIXGM469RVwj9BR62XN+zh1Gy0GQfKkiZXlZj3fPRcIAgRRnzkrx
	qRHC6hFUYE2iUewrJWwiwkFOXHChf/fOMWwtad6UAqoy6QIwsz37bpqKbDiKSXnXB9jtvl439Xi
	g4kgxfxjdaCzvxGm/BPim+TVbl21W65rNsru2pcnOcFHMLx0fcdsktJlI8KetvL+cIi0cMH0nWb
	tJU6u9FKrja2ZEUBMWYZXPsMrzLtMflI5HCmbe40Aa
X-Google-Smtp-Source: AGHT+IHjHWBJeNafhQEE53x5zw6XLsQlYF1pOpZesR4ph3SNAjlONOX7nWdVL6F7gc6ZpbXwmp9i3A==
X-Received: by 2002:a05:600c:4443:b0:475:da1a:5418 with SMTP id 5b1f17b1804b1-477c017484bmr365630745e9.1.1764540693900;
        Sun, 30 Nov 2025 14:11:33 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca9aea3sm21695019f8f.35.2025.11.30.14.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 14:11:33 -0800 (PST)
Message-ID: <1765525d-b4fe-4029-a98f-947025595c8b@grimberg.me>
Date: Mon, 1 Dec 2025 00:11:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] nvme-fabrics: allow to pass in keyring by name
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250528140517.3284-1-hare@kernel.org>
 <20250528140517.3284-9-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250528140517.3284-9-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_141136_064502_3AB86219 
X-CRM114-Status: UNSURE (   8.22  )
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



On 28/05/2025 17:05, Hannes Reinecke wrote:
> The JSON configuration should be system independent

What JSON configuration are you talking about Hannes?
if it is the one that nvme-cli expects you should say so, and describe 
what how it is
used today. Don't assume that people just know.

> , so we cannot
> list any key serial numbers. So this patch allows to specify the TLS keyring
> by name and not only by key serial number.

Other than that, its a very nice change.

