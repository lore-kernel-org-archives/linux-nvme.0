Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB28BC021A0
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Feb 2025 08:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LOrXzIuI1UlDZMFUfXdyYEqM3V4jNjjf7Y7SpXQzv70=; b=NYM8wzF0iOibT83EOL0d3VEVLp
	147+hvpWs0ffioYxyLzBHotta4ycqa0PYlrOf0JKSr5ehLyTRPHRBxovof0JyReCQtZsuF9p68nVf
	FedOkPF/F1q4C4VlQ7iixohUP1JRIVIjCW5Az6fTbdJbfMoWS/OJS73jXrnwNC6UBqT+99q5oOHJw
	m0m5cQh3F7jea0OtPiQIDscK4uPyHyTVsd213Cn2hqnq1mI/cSFWvbdCKRzz0jl0wYpMcmeCxAyPQ
	z4nIJ0FLlBve2l24g7OBTZXvg2Eii99YYhHjMjKymBbPhohaxHdw3xS6ZS1Ilur+fBgqyqwtCiV+5
	6z5fq/bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tjw5e-00000003geV-1poW;
	Mon, 17 Feb 2025 08:02:54 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tjw5b-00000003geB-3GsJ
	for linux-nvme@lists.infradead.org;
	Mon, 17 Feb 2025 08:02:52 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43932b9b09aso43188875e9.3
        for <linux-nvme@lists.infradead.org>; Mon, 17 Feb 2025 00:02:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739779370; x=1740384170;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LOrXzIuI1UlDZMFUfXdyYEqM3V4jNjjf7Y7SpXQzv70=;
        b=L9y0je6YEPKbbC/SjRDmBPnbme6qWjE5uPn3R68VlSZWwnwfsVBkLXFlOZUgkFY7oB
         P1wo3/e96Z1qHqJpSbGaxS/oRenw6zEzyigtVOkx/xD3zubCkwsn9G8KBEhxCKsnrStz
         wK8UL26cF2aJJormYIGIat6pFINWqiEk8PsZzNPVwP9jCWXXIgta2BjagQ1RNgthw7gF
         Vpn6AJYDuAs0okWuini487CY81o3lMoOTzID7b+X/wZxYq4wEp+gdm23LEj1hKfXlp/F
         DhOzSLjtX0ON+mcKiGLskwbU/wX8X5+nBA0hM2K6PWzMvsK+qNtI87aZUGCxiY8GtEtz
         3Zaw==
X-Forwarded-Encrypted: i=1; AJvYcCXkO2Ut/QULt7VR/dAa00ekjPgZHhHKlUmdC7Uzg+YgoBRgvKAoMZgQM2+vUS1Rrv8VQNFG8x71FZhq@lists.infradead.org
X-Gm-Message-State: AOJu0YyiuCPv0Qoedv4oP3Z+4VvsQ1ENDUbCCIYKlviJGB1EQ0CyZTxM
	XNYqHhIOlYsIn5LhBzLDGS8uWq1XKgLXTyzfKlt0kgqiUDXccyMsZFHB2g==
X-Gm-Gg: ASbGncsXoWr9cwKR9L6Wse32qwtGt8jXaKst76C2gbZ6rwLOdoNKY2m6iUNTM803UrZ
	yK+ad66Lgv+N8cnlGgQuN59ksFwom+ak5JVLenk/94Bhox7CaVJjbLbJGpQcm9GvYDwDj1Lb7Yw
	NyFvl5U02c2yPoPGcRJ+C+e8SiCiY2mcwSP6gwc1wgvpJ+3PORk9RZStJYWbazw8Rq4I5rm3Rt9
	P5ZGznFycjDL5zPqgSU3V5iVPZm67GNxR8pEOO3jgyT//FdM/F097n5lJBuL4+4/nUAgZRthEb3
	SywaPW2SKPXLYKrCHrUNKH1oziZYTtlgCxpRtwke0y49VhuGgpaXEVYHwA==
X-Google-Smtp-Source: AGHT+IF7+nPWpKznhz80m0wDsNv8TPxblrL9PvvYoioeTPZX5iWso3h5NUdU8BgGFu2xKDUAZrBK1w==
X-Received: by 2002:a05:600c:4f03:b0:436:18d0:aa6e with SMTP id 5b1f17b1804b1-4396e699263mr95835175e9.5.1739779369838;
        Mon, 17 Feb 2025 00:02:49 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4398a44264csm7794455e9.25.2025.02.17.00.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 00:02:49 -0800 (PST)
Message-ID: <c1dff948-dcbe-4c53-8d5e-0352e81a708e@grimberg.me>
Date: Mon, 17 Feb 2025 10:02:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvmet-rdma: recheck queue state is LIVE in state lock
 in recv done
To: Ruozhu Li <david.li@jaguarmicro.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de
References: <20250216124956.3881-1-david.li@jaguarmicro.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250216124956.3881-1-david.li@jaguarmicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250217_000251_820007_A11D3E82 
X-CRM114-Status: UNSURE (   8.11  )
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




On 16/02/2025 14:49, Ruozhu Li wrote:
> The queue state checking in nvmet_rdma_recv_done is not in queue state
> lock.Queue state can transfer to LIVE in cm establish handler between
> state checking and state lock here, cause a silent drop of nvme connect
> cmd.
> Recheck queue state whether in LIVE state in state lock to prevent this
> issue.
>
> Signed-off-by: Ruozhu Li <david.li@jaguarmicro.com>
> ---
> v2: Add comments and modify the code structure as Christoph suggested.

This looks good. Glad that we are not unconditionally taking a spinlock 
in the datapath.
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

