Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260AFC3ABBF
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 18:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TEcI7sDX0OWA6gk5yPVb7rPX7fg7OI5cS235CBI5z60=; b=YYVpeSKye6kBb9jx2YsGq3GW7Q
	mlwTtjd25WuekgX7KhsrTyziDmK6DaIJRmRw9KqciCkocd5splbrFRdS8kWIUmhD7112bf4j4Do2B
	Ml2tKzGLkukyEaOFEl6d0dgA0u7HVKlfyNR7C0gA9aW0odycgcxjwwZBwrOVS2oAnt7Vixj/jkKTR
	YnWFCsC8N6Ehoj29HT7DRm6U8OlclBSjLCM5v99dAynS8tSlMe8njihb8sBS9Xbu/bIs+SEC5JZl3
	HupjrJFPWxuusCyIEAazBEiwET6RxIaXQivGucG7kQDE50xwPVPUz6R6rW7hvlTnHQu7T6KZre5HQ
	4Ua70Xtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCjgk-0000000GVhQ-2HSb;
	Wed, 07 May 2025 18:40:14 +0000
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCjeB-0000000GVSN-3u6c
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 18:37:37 +0000
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-86135ac9542so10084239f.1
        for <linux-nvme@lists.infradead.org>; Wed, 07 May 2025 11:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746643054; x=1747247854; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TEcI7sDX0OWA6gk5yPVb7rPX7fg7OI5cS235CBI5z60=;
        b=WSJ6EjiK/eR1/8xUTWnCBok1pakV6cyPT5RLejHGtMH7pd2JzxnieeSDq1MRUctDhH
         oVfsqDpvBNZLyo5o/XciG3WFrsrGX3SWiwNq0L9taBDNdmX6W3XG4ysG4mu+hNIj3dcG
         c/COnBxxYsfyY/Y9MV2tuA8vMlqWoEomyo/cNtEXf64XFKO+AYK36HFpsdQ6vlD31vIC
         uGcdEE51/vFNCFEGUxgrusOWtKWA+0bFq4Wyl/mp9g7lMIupyGEh7H2Ms12TxsXPv/gn
         qs+tWwrFKamlHOf/csb9mB9YG+jRbTcu/ZM8sdXpvF6oRFvqyQEC2lgYCHYHrUBsphAV
         K2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746643054; x=1747247854;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TEcI7sDX0OWA6gk5yPVb7rPX7fg7OI5cS235CBI5z60=;
        b=pQyNCM8NeNvbkfnv7BRUOEya/aCimoFKhMxJnFic9MCHjEtrWdPExGpWzl+9YGXHKf
         gjOkIXabjmvHHMF473lpLEqFVyq0Ozt2yu7cvQUQItj0iyjksQgI63c9d3H3YzsiqfYI
         OZHO77P9m9jQaoB+CyuEZkS7WGqMVCLf6x4+h6nXgrtjDs44I0qQk4UFEIcyH4pa8wWn
         mSU5KM0nQqjX/gccb6zfUrvRM9fQ+gXq9ZpJbNmU0CXiSQaxTgSJ5hH0IlWTKWI28WEq
         N0V+qYrQNa4OZss2gk+efZifMKLc5YmXyg3KRP+hSIijpLjOZRXf+C+d1Q9xfcX58zX0
         jCpg==
X-Forwarded-Encrypted: i=1; AJvYcCWwlU37uRugOeOX2Rhoodul4jh1lCk+bgG1b3zbIEwPJC7hPGt0x5xpqjuCcs2XaK1i1imKK0Cp6JVC@lists.infradead.org
X-Gm-Message-State: AOJu0YyhJJSE1CIyhj+cwAAV3e8syblwDWrogXR41CnuWTEep7lQmvRx
	PrxBPyHrJdtmrhbYmrSl3orpCtrj8vCVUqUnyFqnebBNan3NrHFjGSda64lmgMk=
X-Gm-Gg: ASbGncvaLyGZqOH/b/WohDRJxCXKGwjKWHUmPCo/U3PFVlvUZUjGFqvyE6u9YLCBVz/
	LQDcyizT8UFB7DSFLrNokj6TU67JuALPFZtzshbP5IPKs6qrB9ndNhHS1fTVKfS/Kc3wEVqiubP
	QAEp/uWGE/FL9ymFX2qv9enfdyzR3cj3IadRq1+o/HgZeAzsP1zco1OgmQXUyPN0AuI+26MXb+6
	P1wTlGfWZwpXF/q+GCQz5Bth53gYDTyExAfZYjS53ZvfCLOKAXLKK/nCcng441t8MrIxBEGM8sL
	yoaKeaWJefGocgLsRRz7WWkRiAeS5cKyGNM3smtxF9H86Ys=
X-Google-Smtp-Source: AGHT+IHmhzsaM3dtqXyTjAWLIJ/GqFxmnMQ0emMAew6ONSaSkY4xnPFzS7leVgfuOfhwElDFM5ODdQ==
X-Received: by 2002:a05:6602:150b:b0:864:a1fe:1e4a with SMTP id ca18e2360f4ac-86754f9a09fmr90482039f.3.1746643054533;
        Wed, 07 May 2025 11:37:34 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-864aa585a1fsm269038939f.44.2025.05.07.11.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 11:37:33 -0700 (PDT)
Message-ID: <c74d4b0e-0c2a-4990-815e-479db037d4df@kernel.dk>
Date: Wed, 7 May 2025 12:37:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: always allocate integrity buffer
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 martin.petersen@oracle.com
Cc: hch@lst.de, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>
References: <20250507153759.1199895-1-kbusch@meta.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250507153759.1199895-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_113735_973638_53717BC9 
X-CRM114-Status: GOOD (  10.56  )
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

On 5/7/25 9:37 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The integrity buffer is mandatory for nvme formats that have metadata
> whether or not you want it generated or verified. The block integrity
> attributes read_verify and write_generate had been stopping the metadata
> buffer from being allocated and attached to the bio entirely. We only
> want to suppress the protection checks on the device and host, but we
> still need the buffer.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

