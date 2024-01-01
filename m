Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8D0C47074
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 09:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=qtW/xAo9q30ZJAjpVBa1eo1pPX
	/gtBqsIHzdPaf88nvnkp1if0tT5ZconvMYMPyPGziBPNimuFOX/Aju4ObyFk6COLPbahbIL9Oi6Kf
	Pod+nzl/ai6E1r9BwA81E5CG8HVenGQhmLeTHaUc/QxXlENlB2Uc3R9wpyqcsRQy2gkRLWi+FI42w
	YOdOqudW5Es522qIs1Ggg/ccZh+V61XtGV3x+GH1TLKRkhizCXipkXBVw7FcROHW/XPPWjsq4w8d5
	HUtjh6l25090TtEUk7Elj/jQeJoEOnXS+RvyZ8cy/nJXWHYdSZIjE1TOn1kMqCuMVM9iAJRORw5K2
	z6/0mX/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEeI-005pdH-2V;
	Mon, 01 Jan 2024 09:31:54 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKEeG-005pco-0I
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 09:31:53 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d855d0e40so2690795e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jan 2024 01:31:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704101510; x=1704706310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=JlfXNJSvuzCOsA3NPwNhgdPJoDDMFpyvnzFeG+9DfkhXH6kyNpzwurZQXCy5v0ipOt
         1YYWSqiY1yj90vVgLmS8NcmMN+fdvRHR/jbrbiuK0r0GqAKEw7+PyuDuzLBPovU5Wo9L
         iZu6FQmJOJliChcl5Yj889UoV6hkwGHw/NDtTygirLDhHAcnKfv9sC7i5tHx9UqvQdqK
         EDhWy3NMYzm/cpEYUJxSEnF5N+cgzRKJSDSlvbAg4kjLYRKrijyVYCM4oXF7iXS4hNyQ
         fuVSbi9GMEpjvdnYgSrAuthuTzlmPvFOZhtXz1pKyKTcLxjngWhn8MHQxYxcchPiD71g
         D1Wg==
X-Gm-Message-State: AOJu0YyDp7YkkKiO4rxWpMMgql2PjhcgaEeXuNvrAw06DfqVZZfLwKuX
	SFkRLKTizF38dBWzEtT+kkI=
X-Google-Smtp-Source: AGHT+IGlf7aUPnQLQNAoqQaxRcs+YwCAnJDd/j+bEfaFrMRT0m6C6QjEyT+DbBrakmxfjCMvLlCszw==
X-Received: by 2002:a5d:6e0c:0:b0:337:39c6:a911 with SMTP id h12-20020a5d6e0c000000b0033739c6a911mr2413284wrz.2.1704101510503;
        Mon, 01 Jan 2024 01:31:50 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m12-20020adffe4c000000b0033677aae2e2sm25302409wrs.107.2024.01.01.01.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 01:31:50 -0800 (PST)
Message-ID: <1c0aaa4e-6e65-423c-b8a5-21574f89d26b@grimberg.me>
Date: Mon, 1 Jan 2024 11:31:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] nvmet: set ctrl pi_support cap before initializing
 cap reg
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: kanie@linux.alibaba.com, oren@nvidia.com, israelr@nvidia.com,
 kch@nvidia.com
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
 <20231231005249.18294-7-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231231005249.18294-7-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_013152_131888_526464DB 
X-CRM114-Status: UNSURE (   5.06  )
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

