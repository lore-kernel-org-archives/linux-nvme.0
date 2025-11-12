Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F96CD4847
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Nov 2025 20:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=; b=ixhXIem3/ea7qh1NvKrSe21DFF
	TcdZBslZFT3wINi0Wz1C/holNaxrzcgQcOoTIH6bE49XzbO+7WEn313Adu+asqOT5jng0GyotU+5j
	Nt2EON5aWHn9LEC899Sep5JZXxRfn4AusumfNe8jzama9yIJ9zQ9iMQ8dWJceQC1Mz/EzFVOiXDbq
	aDKJ/sxMOJwZJHS+63RfwtjILULILRnQ8fArYmnz1q4fHck6hTxVkhkPVQK1ywtbS8C+5kPzDliqX
	3xRNkFFDd/XSt9V5/RePK1QbdOHYf8Ia6QBvt9kFFfpZBjttdBzNOCEzuzscOWAtevA4sG5QI1NEd
	ICtje/+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJHuJ-00000009VYi-2UDH;
	Wed, 12 Nov 2025 20:57:35 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJHuH-00000009VYH-0naf
	for linux-nvme@lists.infradead.org;
	Wed, 12 Nov 2025 20:57:34 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-7b80fed1505so49949b3a.3
        for <linux-nvme@lists.infradead.org>; Wed, 12 Nov 2025 12:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762981052; x=1763585852; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=W70FlfxseswdJHvzm1EGFbhRpy3yhkW48NYZ1hl42w93y7WVlVpsBwE2ZelvFEoBci
         RqRfxwV+H2iiPK+AyoBtzpSCJF7g7tCNb6j2EFLSDnbl4vrHceaTp9apsG1+8g5POJpA
         M2EpbrtRlzgTF2lqsVP1bw35mqdMZxfWX0/r+0Nw9RgsOZi9AX2E397WJGAv5ByG794S
         D6m2v4U8T7dPcJS9oWno6Q5pp+8FtPFZYpTLuNl0jOmvHm9GA+13H39Og48rn3/X3tbN
         hVCI9a6KMyQtvoBx74A+qsFK/fLekigvkSzxbsdKhHFSkxdJR6slFHxC0zSXV/fFENAp
         sKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762981052; x=1763585852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=GrtreUhJxy7XFhv8s/t14PJortX2vARya2ZpDgETslEi9GSXZyOzbH6DYPI2Kx0zP4
         VZgOrYPEmysbKkgScofEvo2+U5kCEqu04HxYTjB6BtNBWakN2OuhuQoE2DQtXBrDgL66
         BwvaMDEH9TEKg8OVC/CgnwVV+lR55jEuglTjPwNKIp7ImI+XEXgzsbJqdt6/PTOsiXws
         UHZprwFL3cbPo8BREvrQBR779gwikSJ5Nktd5NC3JTT9spiTR8N81D7S9u3/cHJ9wMbF
         +LsuFIX219i49+Cle4ZUC35rIeOqtuOdsPa/qxjZsEnqn88AtfU42KZ7q/7XGFOTAYNq
         lerw==
X-Forwarded-Encrypted: i=1; AJvYcCVpOYQvHZV+3NFx7MKgIz5ipOgWmCDbHWEyYo7GD4CBnAie2sEggHYxB6yFXoZr5VSxSgSRvPkd+WV7@lists.infradead.org
X-Gm-Message-State: AOJu0Yx+J8qq65oUaZT+ht46IBGBiuyl9qFSIW53apmvMRXYnxFS+x1A
	QqWrizyah+VcyCEeYmmXI+/BMiyJP/eyQFi7w3gBNmXOT5KMJb8+sQ5I
X-Gm-Gg: ASbGncsnC2Zh8oyWQDkiaBpWvEKRvrYpd5w0bCW8aXPOqmp84yXzD2dirKjRZENdJKV
	q9dRLZvb69G/kH+JJxlOEbgc6eHn7ZiYPu6T/RiYgK8qj9ol1zoHxpl830Q5ReNVT6e+LTDhju7
	nsyGxuyYEBx1881ZAiOsCrXodWuV45MXgyG9/obvbrrAWc7d/tZwle+yBbL1fs7JJjboqqLYbof
	yf9K7serUJSHCtfsEc600a9otp2XMbatPLAenGu59h3ZNIvtNKVyPxtR3xvftDCaJJckFK0vvrf
	hYpucPDB1BExuktCmMoUpwjam2LsYDJkR/erGOuZi5FmHszNfVw3FkydcP8jIxK6rSDMvqHVv6E
	fQ6DzWMQemd7llh3S6J2rvbVVL/XLSqoLb9Ga7ObYMAAElyaMNsbo3JqLlKIfEFVJpiaHeoj19D
	guUsLmv6jFCsrt324C
X-Google-Smtp-Source: AGHT+IGdMtp+09DXVYWSKyjJdioZZesgS/AZ7o755mfw+un+OTDPSYca4Rd680rwoglcSj+HIufhdw==
X-Received: by 2002:a05:6a20:7f9a:b0:344:a607:5548 with SMTP id adf61e73a8af0-3590be1055emr5921739637.58.1762981052263;
        Wed, 12 Nov 2025 12:57:32 -0800 (PST)
Received: from [10.230.2.0] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc3781866efsm4381a12.37.2025.11.12.12.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 12:57:31 -0800 (PST)
Message-ID: <532a289f-f10b-4d3b-9dfd-d5c5a5381dde@gmail.com>
Date: Wed, 12 Nov 2025 12:57:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: nvme-fc: Ensure ->ioerr_work is cancelled in
 nvme_fc_delete_ctrl()
To: "Ewan D. Milne" <emilne@redhat.com>, linux-nvme@lists.infradead.org
Cc: mpatalan@redhat.com, james.smart@broadcom.com, paul.ely@broadcom.com,
 justin.tee@broadcom.com, sagi@grimberg.me, njavali@marvell.com,
 ming.lei@redhat.com, stable@vger.kernel.org
References: <20251110212001.6318-1-emilne@redhat.com>
 <20251110212001.6318-3-emilne@redhat.com>
Content-Language: en-US
From: Justin Tee <justintee8345@gmail.com>
In-Reply-To: <20251110212001.6318-3-emilne@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251112_125733_222292_2D8571D9 
X-CRM114-Status: UNSURE (   4.25  )
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

