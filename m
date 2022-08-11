Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD16C00140
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Aug 2022 01:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+eGeuzVwyZ8JHC613iGhql/j0fZ3InA5RuEnc5KLYQ4=; b=pWXX/CQsVyJQYtdXmWM06O52j1
	yyjsDG8FSwlvfYdoVZxU+2yEsLGhwjz0c6o7YHiWvHvvfbZ8MBROsCvbPgYEwiLUs/2bpHpWnEHu3
	IJupSkYTqzgzP2zumseSDz1hJYyqEDgMWsbQExXGHyUmj42FVQgXafBpzhDc7WqS3ZziC98SnIjdW
	ybbN6M3AfTbwRzFkxeaczjajFpyS0tAdEcZJbQxzCOZC7m5JwrAZl3ds9SZif3/4mH+75k6FOu3qE
	DWsoMlmRNCUHY+ArYZNxej2P9wN8TioKztBl9Buw4uplEtPsu4jVZj/w05ULYRMM/jyNhGBXkHl3A
	Ce0dxRVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLx46-0020mx-7b; Thu, 11 Aug 2022 01:32:50 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLx42-0020eq-Nf
	for linux-nvme@lists.infradead.org; Thu, 11 Aug 2022 01:32:48 +0000
Received: by mail-pj1-x1029.google.com with SMTP id s5-20020a17090a13c500b001f4da9ffe5fso3903077pjf.5
        for <linux-nvme@lists.infradead.org>; Wed, 10 Aug 2022 18:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=+eGeuzVwyZ8JHC613iGhql/j0fZ3InA5RuEnc5KLYQ4=;
        b=ldtzIJVL9OdFPhvQYX9czaLpmOGvcddU/O6lKJWvryU6wZJWNIoovHYx8nJuzfflnq
         DI308wjGenQk7eSba5jIzzThkyEczTAwJUIqFCfRO89m6WML+md9h1p5gIEHNxf5IItU
         YjbYjHXo607k5v/LZCkpkQ3Am0TNBUBUPwm8B79eMZbObJLPyRJfl1kV3WeDHriZkmcr
         T3gTqB9QIIHtYGV4qdPTzZyePM75Q9tZ63Khjb7aUykHwqJXnwB9d4X8gYyo3ZKTUkrc
         GfOtZ+/TNILhXngksl6qexJ75MRsuRoi54mR1k+Kel0xAX77W6AWEK0Albmlok6xQGVp
         +OPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=+eGeuzVwyZ8JHC613iGhql/j0fZ3InA5RuEnc5KLYQ4=;
        b=cFaNDAd/sJXAc0E+MIGSRlaT7taPeNr6mjpICG1DkFj5LNttuuL/73e6xyRBYjohul
         PEeV4FLrdiktbWdUDQ7tY+iQMUudUIjyASbK7DHmwya+ZpzjlrZFSKnGCJuUyYpqzFMa
         K35Ec2Jx+8uvkpE09s/bY+XpR2XtvS9ZhQKA+mdt/zCLeUvVVRZ/sqSPBN5imfYhxFZ8
         jPlpx/tXVWWLWgRStFjX0SB1Ve0mlcyVJtWOTJDgzWxcp5ZgQL3ZvmzyCEEVD8kcl+6n
         GnYvt6MUPdMee/Tt3izIdKCf8+TSSRfAgVQ7fL1pGMxcd/c+gwypdgjbnH5xRP4gXvkH
         c4NQ==
X-Gm-Message-State: ACgBeo0WD0gFsxBitTRuQ9Rp581X9fZ5otCEEzTeDQj65WGc8Gq5q4yT
	ksX0oO2Zc0t0EE7GSXQ8VlDIhA==
X-Google-Smtp-Source: AA6agR6fn+1voFpXMK3KlITaLtqXCqizTUPK6nfTMbJAESE+ahVS1gu/NcY/s/Pug7PGBg043S3o2g==
X-Received: by 2002:a17:90b:3b4f:b0:1f5:82c1:4f46 with SMTP id ot15-20020a17090b3b4f00b001f582c14f46mr6510262pjb.71.1660181563004;
        Wed, 10 Aug 2022 18:32:43 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d15-20020a170902cecf00b0015e8d4eb1d7sm13803327plg.33.2022.08.10.18.32.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 18:32:42 -0700 (PDT)
Message-ID: <fd6af173-4530-5bb3-db61-6612e5d574bb@kernel.dk>
Date: Wed, 10 Aug 2022 19:32:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH linux-next] nvme:Use the function kobj_to_dev()
Content-Language: en-US
To: cgel.zte@gmail.com, kbusch@kernel.org
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, ye xingchen <ye.xingchen@zte.com.cn>,
 Zeal Robot <zealci@zte.com.cn>
References: <20220811012910.15820-1-ye.xingchen@zte.com.cn>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220811012910.15820-1-ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_183246_797603_792DF60B 
X-CRM114-Status: GOOD (  11.44  )
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

On 8/10/22 7:29 PM, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Use kobj_to_dev() instead of open-coding it.

This:

> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);

just makes the code harder to read, imho. The original line, I can tell
what it does. The new line, I have to go look it up.

Is some tool suggesting these transformations? Because they look like a
bad idea to me, and we should fix that rather than make the code worse.

-- 
Jens Axboe


