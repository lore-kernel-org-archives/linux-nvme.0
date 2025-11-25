Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7081DD0E6FA
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 15:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cHJEDtarRWqOgXb1HtWmmk9rFMCN6Rpm5GLL00oUUdk=; b=PP1v87D6YuKTyUtvFn3OOBEpx4
	R1EDLnI+EVAG4mnJ/do0oMtNcATHqR180VcEr5dhEnJ9y2ujWFP71nOVs+NCjgPKAdVPd5m9La20W
	jyCN/wtuzaOhOn33hSJnHat3YhP1yKCof/TI2Hn9mJinvMmW3ZQRSzzqbm0k1RUY8lZJXGN4GkUm9
	3/lSBg0YBDcTgQLvttdQKHMl+J/Vc1+cug8K9G1Dk/JpotyXsjCvZob5+c2LWrOVmHvqvgnsbOPIn
	iQyM3xxPrWBa607OZBL/j78645r72u+VDDYMr7vEibZdKDr+j7mk+wZQl1pMtcioHKjvfqcS/S7HL
	cdTE5m7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNupS-0000000DUtt-2h8k;
	Tue, 25 Nov 2025 15:19:42 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNupQ-0000000DUtM-1qYr
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 15:19:41 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-b9da0ae5763so612906a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 07:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pkm-inc.com; s=google; t=1764083979; x=1764688779; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cHJEDtarRWqOgXb1HtWmmk9rFMCN6Rpm5GLL00oUUdk=;
        b=IyMR3ycB66wIc6SeyTmu3e0F55Ui+V0YSj+6EkGyk7N9d/LX4NTCR7ddxbORbUOFt7
         xKHij7PUA0akIyq62goYtHFIYs1fmv9rdYYengaPvTMJLQRwvNz9i0Nz28+BNYtsFsrm
         73JTSfoUv4G4ZXlfvPoDj0cj9acERRw2iBNQyObSKdNqOYLNk8LiZrR9Z33P48WWH/aL
         q0IzXt0hWEh3K1kVKz3o5VlgLuVavSvEJAC5WKWTdx2zhRC6jc1Ife8fEo2b3praPKhY
         f62nFWfEw9X7FGLQVgYg812M0vVzQ4M9Bw1WG62xE4tI/T6gn910miwxXazrzaRzqSOS
         Sz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764083979; x=1764688779;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHJEDtarRWqOgXb1HtWmmk9rFMCN6Rpm5GLL00oUUdk=;
        b=nC1IjTDwqd3lv2oXpdEHuWSXeBDDjsgRZbpueyl0OPxyc0RAfp39IA7dPBxii72YWo
         9lboL81UfpYvbJ/fdW7bwENsnrgHPMtNmtDKWdozb3jqDvmDVdrBQKiw5U2S3tqEDpuZ
         Moq+M/zx3LtquAL/niRnxtmeFyCecjdohi11z78tQskRiYVIf2n8c0SHrGFzTcF3MJVC
         O6oaJexS3whCCG5qja2qVM6ZhpNpYxeDfcy5IP8cQp+RdcPn6okDqFG8uiGyfEjQ6fOH
         8EUl00keXENvic0cixcSw2atPh5CyGGuNv9Mq7y+tSLAsDevNAUHPMNM1IatIqiDrXij
         2MHA==
X-Forwarded-Encrypted: i=1; AJvYcCWj1huPqQtj3DhHi6eOywgY/B9f4CRujxj8MG9+TJ1pBCx3bogY3CTvMvHNS9pUFFPJ+iUCSBYHxFqf@lists.infradead.org
X-Gm-Message-State: AOJu0YwIQL/ESZVomRfe4L3uFemvHzU75guWw/PXHkFFzc9XbnXmriec
	ho2SjLK/1qxer2IXvKgmAPN0njRFag3XZNsKMEnGONcj4e9UGiGh4UZjENpD047uKBsyMPAHCuo
	7ulRqlq2nbgPyCU9/84+hCYYxcLWEu6Q=
X-Gm-Gg: ASbGncsrdBSyowzB/J5aM81BcF4gfl/smcYZ/wy/3EVJrZI332bIu3fquOfGX5grf3F
	iK3faADdQ6EbYI86nRlMPr7BfOUZ1otTY8VO7UywdpKnLao4V+NQBJBAVny6vXpKz4g9mia24gF
	uV93BcqB5vUvwvVwM/wOJkl6Ouk59n/ptnFIz8RyhPTKM6P7hEqjnIgvhjsmQ3jGxTGhC7qSuUt
	dJPqUcT9bHDO3F0jwlXHNOULwyr+fRB7Cvz06RLHaezph5viWOkFT3Yvg==
X-Google-Smtp-Source: AGHT+IEsGpw71TAYt5Qx+xiPZwRdX9y2YPf86ws3cbvh1p1Ksz8fXR2cFJ6hSGISWXJbuAla2LVthHyeUTZN4xWYVZg=
X-Received: by 2002:a05:7301:1906:b0:2a4:3593:5fc9 with SMTP id
 5a478bee46e88-2a7192a30bfmr9837552eec.3.1764083979074; Tue, 25 Nov 2025
 07:19:39 -0800 (PST)
MIME-Version: 1.0
References: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
In-Reply-To: <CAO9zADxCYgQVOD9A1WYoS4JcLgvsNtGGr4xEZm9CMFHXsTV8ww@mail.gmail.com>
From: =?UTF-8?Q?Dragan_Milivojevi=C4=87?= <galileo@pkm-inc.com>
Date: Tue, 25 Nov 2025 16:19:27 +0100
X-Gm-Features: AWmQ_blcIVy5rRWTRzo2Xktts9TtQNTMQP5scAFdkld9uoxXMZx9jf6i_05fv_c
Message-ID: <CALtW_ajVLbtUfVkKZU3tsxQbHMZsJR=jHK7PQNmvmSgjVhiUyg@mail.gmail.com>
Subject: Re: WD Red SN700 4000GB, F/W: 11C120WD (Device not ready; aborting
 reset, CSTS=0x1)
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org, 
	linux-raid@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_071940_513582_4F2DB1A4 
X-CRM114-Status: UNSURE (   6.11  )
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

> Issue/Summary:
> 1. Usually once a month, a random WD Red SN700 4TB NVME drive will
> drop out of a NAS array, after power cycling the device, it rebuilds
> successfully.
>

Seen the same, although far less frequent, with Samsung SSD 980 PRO on
a Dell PowerEdge R7525.
It's the nature of consumer grade drives, I guess.

