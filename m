Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCE8C021BE
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2025 10:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=SDSqE6FX9yzqTI98N3aK3V0XMJ
	creYpg76gICge1sd5RTrFCc4kEk9daxbho0CdLNcREN8tvsy5YGAZtXhUNb6viFnwyjeFswk5YwM0
	XF9fcDQ0nwKtMdVkRAkzousX84aFArya6H169OGzUmh2FHSVBwkYoiAzi91ocr6ll85D03rVhGzGq
	IQU+V3nXkWzdGPqKBpAZ74jzcR4wQOlSi6v6A/pyU0Kl6wTgMXzmULJten/ZanNrDy1aXo+T9AzdF
	yKhLYjC12Q6IStGYUF9dPjlbI/7jvFMvC4n9+X+ZOGOcAq8iivEjWFBR1hMmONeeGvnw3pN20DPhA
	sTrDWcgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnasH-00000006xOn-2G7r;
	Thu, 27 Feb 2025 10:12:13 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnar3-00000006xFZ-34rS
	for linux-nvme@lists.infradead.org;
	Thu, 27 Feb 2025 10:10:59 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43984e9cc90so11555485e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 27 Feb 2025 02:10:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740651056; x=1741255856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=W9KYYRS7NGE1QMtvcX0mTg1XSr5FninXlQrEkQ31tv3o8a6o+n1D3+ixJoj58fraAR
         Yik+pOofWMvTZT4A+A8UOrHe4UFG4BfRsywRpI91JcUAw/gBkwP5w5bmsl9kL1BzDcpB
         aOmdWCh9q5dPd2cFczx92uP41ufz7pnpXWNQt3IK5BjzUqX1iSW/29/H88yxPaFBWGhK
         lsn1Tq4L5K1kSNUwEA8MtI6InuYckvtvL+6LZQ1c6fIm9fr4MMudKobhRvt+gDaL3994
         aDdAgSE7UeuybADzv2xSzQ8OGxPWNVTU4pB5lmwlhCC8g9e03aIAhH3+KORAX9KYdjyw
         dsew==
X-Forwarded-Encrypted: i=1; AJvYcCXMXSkgSzlKVsTm3Y/prHbacVAnClWikMo/z5jw9CfwcwapGXYj00AgA2gqpgipuYjwM3mf/8awDuxe@lists.infradead.org
X-Gm-Message-State: AOJu0YwfOSKE6vjfgldEMrWTqblzaLQbt0W7AI3VS7vqCWuxhC3g2TN5
	tKBJr4wNs7WRuxO8PrCtG6O8uS7Wpyy2hkewL/xS995SBw32+NOdZdwOK/Mt
X-Gm-Gg: ASbGncsJZTtuqkLx//bGCgmKOGCLLpTx952HRavzPCFUZkHiyJUNrVWqQZh4ten6Xeu
	6GhfhvzLU5eiaoL7293ppVM0t2XhqRRE9Lv0gMPaONtCsp24FZsH6yVB7iatbouMLEctOerVCIb
	HMuq/N8rXy07q+I4u4z+qxLAvCVBNL1u99m0fv827Ltzum3GjkROWCi5/2lJVQYFWazEvyY3Da0
	290Sv+Mvu19o8UAyg+8osRYaQ+pOjoL+dcCwmxFsn9fKiuklGg2pnyi6iH0L17ScgyQXlMoYTcz
	pXXjK+P6cVmyJD/VkPF2I5uN1zlVyIKtwymF1pwqqbuO9Oth3/coL7vNkuslXCT9jSCv
X-Google-Smtp-Source: AGHT+IETf1ydKJC64LpbkEUtHd/+rj/dNLC+JvQG2PFcKRXO1/PPRN1fU2EB+mSFMbb+gxeNxS4Zqw==
X-Received: by 2002:a05:600c:348f:b0:43b:a41b:ee7a with SMTP id 5b1f17b1804b1-43ba41bf043mr5335215e9.1.1740651055643;
        Thu, 27 Feb 2025 02:10:55 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5710b7sm49253495e9.25.2025.02.27.02.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 02:10:55 -0800 (PST)
Message-ID: <98535ea8-2355-41a2-bd2e-2fb4b494fece@grimberg.me>
Date: Thu, 27 Feb 2025 12:10:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: switch to using the crc32c library
To: Eric Biggers <ebiggers@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
References: <20250226062841.60688-1-ebiggers@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250226062841.60688-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_021057_762505_6C6D1137 
X-CRM114-Status: UNSURE (   5.74  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

