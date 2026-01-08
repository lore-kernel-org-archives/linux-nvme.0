Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8235FD232C2
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jan 2026 22:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=; b=30EXU+OhoO2mgIrLcL4cdwGEcQ
	aaWWOgpWACqdMludnnkULkB+l12oyW/5rEXDwPvrxpxu7FDlHWA6XjHl9xWpZbEUso5t/1IaSNli9
	+y1Od5xiz+uuT7YLW6Wi56Wx0m41UmFLQaB8iWDVcxWmOy4lKk2CCwA0j05W4zTorXp6tFjuzNTcU
	GKqaCM3VTOQdz94MBPmGMFzDZPU4Tvd7+2rxjL4FfYw0YwbbwqEOWED1iIS7M7mF/fofQs6wCF5Sl
	dCVnbvqoqVSy8HSHwZN6bAHxKkYYQa/PmW5IIhYBYitMDZbP0yVJK66clee5wEJFxemIwthoVcGXf
	y/qWiKww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdyrs-00000000xsS-48YW;
	Thu, 08 Jan 2026 22:52:36 +0000
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdyrp-00000000xrp-38ck
	for linux-nvme@lists.infradead.org;
	Thu, 08 Jan 2026 22:52:34 +0000
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-121bf277922so4052380c88.0
        for <linux-nvme@lists.infradead.org>; Thu, 08 Jan 2026 14:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767912753; x=1768517553; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=gHrVQTIuMhpnCO7/s231RS3L2+Sge7gmKruX26Ftro4rfwx+dtuQ5rRGUSWxQcGD+Q
         SryST7lKjCmN3Ap+/IDidNQtGPsf7YsbgPeGRX1Kb02ahMfGaO/PDelQU3Gap6O4LtBV
         6eEIURt2Xnr0FZjFW1asc0oabW+APjlPjzxI64+ZYkqKFNZlCgktpQOiIMmkRfBTSGAB
         KNtNrJmyB1m6d7JJePANeiAo4Xrqwu5kYEkB428EFfszfRZp1Kojd0hPDyAuWmMF2sIm
         AQUFyq0gIHHixM3BkFveOWLQ7TVseQNRjH4hZpa+lkNHovfYBt5mtVoPqyiuPZ8xuiRc
         MQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767912753; x=1768517553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=PZLyIifeIxGXMIn1bjL/0QzJCCU1Xz0hgoy30T5o5ijt8QoiU8bQdI7ne4dZS9niI5
         weBVgoyUG70DVoTEO7JlfEpdCYUHJiWiJB+mb9qyeF4UgnW3nY/BCf1AW0ArT4Dwwjgq
         PWiEz1LIMaQ6WTaxdVW+6Auggh0knWN3u8/XFHSsQOZ+fc2YQAFtgNUiamJ0u20kEsm8
         SJeXgK4KIJf7D6run2uMAe0+v6iWazKwGG/FHxvg2H8SxyHHH5eaAss6c25F0AqZTrZ8
         4UB6yQyR3xGreMFDWA0WkW07YUmpiB0PFqeCtYFaN8AXCkCPDUdvhkRIxv7QbRdejhHR
         UQgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVzpXKH4/2ZTa36+jxh2P+Sos1KAG2CBQjCLDAfRr7YdhgDliRBOwQZc8C1LSvZDOBLCLwWXlbV4sE@lists.infradead.org
X-Gm-Message-State: AOJu0YzNsYZHMkeBx2GvtoIc1l8exDjZdD9NjvU+jnv8EczLWpLiuzB4
	hBjwwE5iGnnAEUPWmMCYDnIvL4n6Alm+u6K74YViwFX26BEPYxpCwFsk
X-Gm-Gg: AY/fxX7RIibaOpdPjYw6KItbxl6GEiDK+q7L+yLOHWX6iSzHsI7qRQPVGMC4K8AUuUD
	cKhLVq++hxAMGeuxWqJQhylL2gpFcz51Hccyn1cYP376ELiNiORYDVdx7ZAcZhX98fHL7UVxCNt
	f5p59UgQnT+KqFNK0IlHIQK5wogXfkIBZ/diXJqcHlRc0g3uC23TTBwDg2zVrYIHpghbeFh+UsV
	hAchE5wqE+dzfxcS7yM14uJtjG/vquvRnpk6gfYuYO9I1SnjUpzABIXmqIr3SbhqAFrWoQnT4yZ
	VdMl4u/cbCqI2O6j27D+b22n7P8UwYlT1HnfdTJi+cDXNTxjHEykfwkY0Jl+r0V+Fh6LRfdFni8
	9ib71eFj+lw85xtwuO2D2V8X/skVu6V25r5CUlwZ55h82wtzH5T1JVRgMYdXJROkAKe78YJF6xv
	FdeeFhqKVvhxi3f3mmQQtbSHSF5IHKow==
X-Google-Smtp-Source: AGHT+IGlqgmTtOoS2+TZEKJuOrJ6aXRxbxy+iJoASEkWrVvVZ/F+w3vRg82HwR/dalJcvzjaw5wHOA==
X-Received: by 2002:a05:7022:6723:b0:11b:9386:8267 with SMTP id a92af1059eb24-121f8b9bef5mr6056925c88.44.1767912752488;
        Thu, 08 Jan 2026 14:52:32 -0800 (PST)
Received: from [10.69.70.117] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707b13bdsm9413169eec.24.2026.01.08.14.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 14:52:32 -0800 (PST)
Message-ID: <d0580b5e-23e5-4a1b-8983-734978aa7037@gmail.com>
Date: Thu, 8 Jan 2026 14:51:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG FIX PATCH COMPILE TESTED ONLY] nvme-fc: release admin tagset
 if init fails
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 linux-nvme@lists.infradead.org
Cc: justin.tee@broadcom.com, nareshgottumukkala83@gmail.com,
 paul.ely@broadcom.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, yi.zhang@redhat.com
References: <20251220001842.6027-1-ckulkarnilinux@gmail.com>
Content-Language: en-US
From: Justin Tee <justintee8345@gmail.com>
In-Reply-To: <20251220001842.6027-1-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260108_145233_787720_FDD6EA64 
X-CRM114-Status: UNSURE (   3.62  )
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

Reviewed-by: Justin Tee <justin.tee@broadcom.com>

Regards,
Justin

