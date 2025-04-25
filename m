Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE43C369D1
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 21:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ancaQo+gVremqZijq1n6QXEb4/
	smLfzPT6A7faNPuJn8CfU1Miiz38zvVzVV5Yt01rU2yan5/b+sTnUZ+P3f4wItyk4AZTJELqKZHuX
	SV6SFMonjWKpYKUA2zwdY8mLgg8GerhsvltCg6AwIDj3NMITtzU7i7J1Ew/Vbh1JoeDd79nSn8MUk
	m6EU9t+dnwPl5VtkK+GYH0hKZXO3JZmaz3avOgN7dhiJxzFkxyNU1nJcPIoPmLaQPfCtNarNp6T8I
	GVHDdU2vqPbbRjlgHECm2ttyFTYhBKB2h1U32fASvszqsuswyp+GdRz3M59T7C3qaNahlTvd2UKbw
	dll3AL1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Qm0-00000000wZc-3Kep;
	Fri, 25 Apr 2025 21:39:52 +0000
Received: from mail-yw1-f177.google.com ([209.85.128.177])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Qly-00000000wZ8-2WkU
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 21:39:51 +0000
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6ff27ad48beso27273057b3.0
        for <linux-nvme@lists.infradead.org>; Fri, 25 Apr 2025 14:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745617189; x=1746221989;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=XtVNSLHVb/AUQ08xatP/hyJmO2Go9Z3bg/ZyiN0Gd3NqOxF9hK6Kqzxm0fH+Co4cMj
         SKplEsOi1devS+8ow4pNTdhQ591Yvnr3l03OlDPNS/qr1w2X/arXQavWPUFyImVh/gYh
         bgbI9XWZ5rB0tEFRwUZ6B289Xk1sxJuvUG84AtWDECqSfwx9obCxM0Zcp8l6Wr1wCtEw
         fA53aDJrrcKp0OQE2Bu8jasSxzq4XDLqrC2V4b0w5layfZyRwtFHNGF+ZVUByLRGzvCC
         /3C5odTC8uPEZZ6MyBO5pK0jejHYa6UBbGVaAig9bIgge8/pd4CVqnsa9omM9aSQ02jR
         wg+A==
X-Gm-Message-State: AOJu0YyXxL9JyUwkPmN4KPyyObrV83L87Alb2bP446e/GhnVJUYL5xvl
	Zk14frk9Wci54l++pqr7Tm1Y40oJRVE+lkULyyx3FPmGCKBGMULa
X-Gm-Gg: ASbGncvXpSxsxrZf9YBtXofmwiTNPwenb2GrZ7ctGQpFGPe3Ky05QMW0pRZwefVtoCO
	vUBvzExpskb3gL9dWxaVVsplOU+XfZiE+dRA0W73BHGcSntv5lCRI2iXbV6RDW+HRIF6/OxXD/9
	iIFgNu4reTagUwYKEZDdFMu84+7yFgo9Yi8kJskEK+evcfEhwQxma5XsJkFMBVtYGW7kTXvFCVU
	yPNNrf4Q3QvC0wWE0GsL6ct2MIaE00CyOtXmVrMbvvy5tnj7z0dzmve5JFHiyD76GSlZUtXKzzT
	Esi7+RXhotr2xfbFAYCY+aM0Zycda2HMmpvgk5uX
X-Google-Smtp-Source: AGHT+IF4TrG0C0V3jSMel0JYpJKmjFKhrjvmL9BV0Vusr56pRZq+FiTE/fyScARGvN79oRmTL5lDMw==
X-Received: by 2002:a05:690c:25c4:b0:6ef:77e3:efe6 with SMTP id 00721157ae682-708540eef1dmr56306747b3.13.1745617189476;
        Fri, 25 Apr 2025 14:39:49 -0700 (PDT)
Received: from [10.100.102.74] ([95.35.174.203])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7084b9cbf7bsm8429567b3.110.2025.04.25.14.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 14:39:48 -0700 (PDT)
Message-ID: <bd155996-10f4-45ca-b4a0-dc54e497e3a6@grimberg.me>
Date: Sat, 26 Apr 2025 00:39:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/nvme: Add quirks for device 126f:1001
To: WangYuli <wangyuli@uniontech.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 zhanjun@uniontech.com, niecheng1@uniontech.com, guanwentao@uniontech.com
References: <5AE9DE3EEA7F8772+20250422121725.162229-1-wangyuli@uniontech.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <5AE9DE3EEA7F8772+20250422121725.162229-1-wangyuli@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_143950_634434_C9093595 
X-CRM114-Status: UNSURE (   4.72  )
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

