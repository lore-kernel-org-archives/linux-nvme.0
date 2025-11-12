Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19156CD4847
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Nov 2025 20:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=; b=U0bwyZIzrsZIa9lR/pINes+Cz7
	mZ5DuLoJKxFeELM/uf72t0WrOPd8d+vMh9xwO52ITyltoDhHQotuSRSbxouYSg6lQ8R6+OgmW6KtL
	vBk+UQXIhhC9TnyJlQ90Fdw1iTOvJnOQShijlDMKz3L+pL/P+OQvvM5ByExr/3OARv/yfAjzjMb13
	KfPwL0xyGAxagbPPal9bC03H05SlK+U2elk5eZ7qZMxImm6gmWL8Dd8IEBsTXoi3y8nXCC/AR/QLz
	HiZp/vNUWaX19wppQGwqwrpOTZdhJoSQDwO9lIHe7/qJKcgB59uqHQ59j9dfZlsoFGpT1HnpydQDT
	uIUO5ksw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJHtd-00000009VUm-0ngS;
	Wed, 12 Nov 2025 20:56:53 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJHta-00000009VUO-18KJ
	for linux-nvme@lists.infradead.org;
	Wed, 12 Nov 2025 20:56:51 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-3437c093ef5so85856a91.0
        for <linux-nvme@lists.infradead.org>; Wed, 12 Nov 2025 12:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762981009; x=1763585809; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=TklcyLbfRN6abFbZAnAVL1NM8KfbEGZS069xubErQVRNziQ74x+XPyET68nxEa/WAR
         Znz+hYkjs7Us+3rVURpALNp4kIOaawIVFVjfipa94tVRdg9Ss0S0VnoIG7vxx+UQbUEl
         1yRZFNEC9rnEVmyMn0U3CTs2uSBenLyIpFRqW7hQ99PWuY/0CVE2/wf7KXj29tpjavsw
         GY7usy9sXvsnu5HhusbfvfO3qjJ3uO5xZrA195dM/euU0bavBpExZYgMZhVXlxxUWMhn
         R0M3r5UTrrdCh5Ubeafhd3QcRMtzKKIUzXwvTHIgdvDBaH2eUsdMcNsZecyswNYO/kZX
         3gTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762981009; x=1763585809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eo8mcJx96u8VH4jn7nXN0WzI3pTAqmoosY5GMUzgLRE=;
        b=htlzOORYT8gZIe4TH/XhjLA2cwqptKjEyBNHAx3miUszGRqRMEbhe/zzkBE6MNsIZo
         AETUyKgqlNv35rAzaBuaKDD4HHZT2PnX6nkDuhQdxnl0d6lH2pBqGwaCjm89fTeMxWRn
         XWpUjubQYTowHM5hWAIKp8wbN3MQixzyok84rMlkw13toa+Je5CUIJX4jcI/QWkZGas3
         mIqKX04op8/UrtYg0Ad3i0uQfj70b7hcbyNd6bm0aYikpKzEPgm4T3Q2KFhl6PTISdSX
         gdmiGw9+P1wf02XrCNe+1RrJUEOy6TNYuFxwVfBnL4xOZyAYOXT2S3HluoWQGjj97pyi
         +5mw==
X-Forwarded-Encrypted: i=1; AJvYcCVLAm2gY/LuWK3aa6+pfT8dCKd+z5vKgUnA0VONIvMfnbSFIOUU2U4yJ2bhSJXZYTr6gBF96Ni274hj@lists.infradead.org
X-Gm-Message-State: AOJu0YzDwpj9lpHLHSg2DqHWzi2j0/jUgrIAiqIXvayYfOMtLZz8BQMy
	qfvy5YIlOGjsahJsRjtsRioQKyJ3sVaYH+Lzt0xjLjfF8n93oaJXqJF3
X-Gm-Gg: ASbGncstv7xV8K6lFTuzIoMWe0PFkyWaYuZKFP3NPsDd9/TJfbOy26GtcydYPTNocQy
	/o3j4ZOjviuphag+HBJwGHFwz39xKr5fKUc+ov2kCbBaMK8U1DQkfTBNGhsMYaouwjFKqDiYXhU
	g5oSlCic8QmgLbwbDqVjMzCa12GefjB5wcqATgsbTBRcxb3hlhSq4058QjDqBarNs9b5CxIatIY
	GVWMCooylgXViQylMnPI6BPyRw7ARZRf+8OSGKYZghEmm8IZyST1fGRb45I6N72K651f8l3nSb2
	Xg7+qoAFB+0aRy1WWrT907QMajf5tuvXOA3tR9Md0IPmduVdagIIg/HYWvYR8t9SvbWHze/9+uj
	8BEHE8oBiA5nEYyXLKy073mqRCpbffIfkbHZFrtHYYuYrv67Qto1LpI1c1Zh5iJWtDbk6tG2sHJ
	QWBVV5UiwF+T4mXrnb
X-Google-Smtp-Source: AGHT+IE2fgQkfTD0gRJw99RJWxiwbFp4l27hkS6vTDSReOBDj42MRuxQP1iVXicme5fnrFTgDr3jcg==
X-Received: by 2002:a17:90b:3885:b0:343:6611:f21 with SMTP id 98e67ed59e1d1-343dde0febbmr4302742a91.1.1762981008917;
        Wed, 12 Nov 2025 12:56:48 -0800 (PST)
Received: from [10.230.2.0] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e071571fsm3599170a91.7.2025.11.12.12.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 12:56:48 -0800 (PST)
Message-ID: <f93a4dc9-0969-459d-b767-5feef0f5ed90@gmail.com>
Date: Wed, 12 Nov 2025 12:56:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: nvme-fc: move tagset removal to
 nvme_fc_delete_ctrl()
To: "Ewan D. Milne" <emilne@redhat.com>, linux-nvme@lists.infradead.org
Cc: mpatalan@redhat.com, james.smart@broadcom.com, paul.ely@broadcom.com,
 justin.tee@broadcom.com, sagi@grimberg.me, njavali@marvell.com,
 ming.lei@redhat.com, stable@vger.kernel.org
References: <20251110212001.6318-1-emilne@redhat.com>
 <20251110212001.6318-2-emilne@redhat.com>
Content-Language: en-US
From: Justin Tee <justintee8345@gmail.com>
In-Reply-To: <20251110212001.6318-2-emilne@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251112_125650_341552_64C4BD1F 
X-CRM114-Status: UNSURE (   4.27  )
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

