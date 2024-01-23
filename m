Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D332AC47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 11:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=kUSY6MPqWKAk26Bx2+IIMOmSUe
	zY9f4JK5outEJonpnHP48u/mubxfsRw8uLbF1GzT5C+/V8bJd7jq7tisnZ0IvOZnn4xmc9mqqG5+c
	lFR7gzArN4e9SxuFTmc9Pdypnguof3JmNLszlg+VEE36Ly2LsOZlUFlDJntZZSWFaTkFVMV1nzhfA
	QOP/y/pw1Km85nzyPrM3pSxq8Tm3WmlnByFM7O6mRqyyPtD4ZZ6/v0uS/hYcLVrtV03T7OmPLGZBm
	egE4sExtz3uTpcq/5qSNGVv/YY/jfIyMzpGpO4Oj2JDcUvDLBRBiI8/V7Zg5VLwmu3oRqwL+abwx9
	OgqIl7Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSEuJ-00G8cy-1e;
	Tue, 23 Jan 2024 11:25:31 +0000
Received: from mail-ed1-f44.google.com ([209.85.208.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSEuH-00G8b8-0B
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 11:25:30 +0000
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55369c59708so777699a12.1
        for <linux-nvme@lists.infradead.org>; Tue, 23 Jan 2024 03:25:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706009126; x=1706613926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=V6FjHGBW4E1WVy6PpF3vSHdk3JjMlWPJ1K8eNfx7TA6y+MK6BFtI7r0Nt9biBlJj6M
         C45aUJKC3gsdCKtnwXdqUQsgitA17Vc5mkMmdMimmwWzA7IZ8YqfneeV6i5QmFnbDf5s
         R3TYknIRjdpLcIgtyUEzl2yC1hZSw9tgnjUmWag5lUmlWLvt7Dspfxq4k16K5j4I2fSt
         yopaS7vOctt060zlv410loNQslgqcJbQ0gUIXPtscRZEBc5atlJcTqQYOjOBRzZW9KiZ
         P3248mPoxRiIdj3YaF5KBG3rCU36abz8V9d3kYfUShuj9xkEJOBXRsgXRocX7RXdn0Zp
         Lo9A==
X-Gm-Message-State: AOJu0YxVR7mZREJzwcjC2os9DxvulHdWeEsOvM8JolyelYDES/fnT2Od
	YBFwjcbp3hTSm09Yr+nx3p8l3Y/+YpoCWz4BQUAs1i515JoIYc05
X-Google-Smtp-Source: AGHT+IGeQwmcV2+hvAUWVPIMtL8qvpWEGFVOwCOYRT9Hr2dJK/llpy4EJkzG94zSEFMZCUbvZXLhEg==
X-Received: by 2002:a17:906:f211:b0:a30:70ae:3338 with SMTP id gt17-20020a170906f21100b00a3070ae3338mr2719231ejb.5.1706009125905;
        Tue, 23 Jan 2024 03:25:25 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v24-20020a1709067d9800b00a2a4efe7d3dsm14343849ejo.79.2024.01.23.03.25.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 03:25:25 -0800 (PST)
Message-ID: <a4931489-e4a0-4ae6-b660-9d8200f25b50@grimberg.me>
Date: Tue, 23 Jan 2024 13:25:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH libnvme] libnvme: Add disallow_pi to connect cmd
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org, dwagner@suse.de
Cc: oren@nvidia.com, israelr@nvidia.com, oevron@nvidia.com
References: <20240122153341.20757-1-mgurtovoy@nvidia.com>
 <20240122153341.20757-2-mgurtovoy@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240122153341.20757-2-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_032529_094008_0FBC16A1 
X-CRM114-Status: UNSURE (   5.11  )
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

