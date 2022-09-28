Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5147C04A95
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 07:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=skKyfxnzt+9oZSzW5AZfUSfMHy
	f/W+nw6jArck9MhKJbbCzQem0wlJgpp9QRtcHoyc7cTtDQk/vyWdn4R5hAcYELLFf7ZjIZ5VQwzPA
	Vkkim9clICnXBGzOY2QrsOtICiD46ZT/NyxHqNiSGB7JKHcarwy5D5C695ZDXt3+buZFJrTQDhZMd
	VDm3OTCfuVJkWED3R9kJWJ0hdIcCAco9y2v253yK7PevM5U7Ww98X6QXAqB9EzaRm1Z27kiEr/NIm
	dSWlw9f6mJauXv6xeJTDlRBbRD4f91wTTjmagVOKNT9kIo4pNAoyPWQV5Jf0eJy4GsPPp0+G0+UFy
	wumkQ4eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odR4V-00EOqG-VD; Wed, 28 Sep 2022 07:01:31 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odR4U-00EOpp-10
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 07:01:31 +0000
Received: by mail-wr1-f46.google.com with SMTP id r7so18291348wrm.2
        for <linux-nvme@lists.infradead.org>; Wed, 28 Sep 2022 00:01:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=By75q8jtz60d7o9g163RHhmc0w+VPB0VCJZGLIogavA+HfX4LVGI+VTKPcgKXwaim1
         z0+yHIav2SC9dzsZd9PH7nj5rMloqjm7ea53qhHu4FVw+nsntrWSqkenzRo8Ei90oiRb
         93sFjBOQnyQf0t/G5P/fwBElSjop3S879lS0BypWVUIYwbgKDfr9WnFHJTPltgYys0ag
         /WsPfgFAm6wfIU1Lvt2lsB7aAM2Wt6cQY6kAlSJXU9KN8hl59eaoAKupFrvbdzITuTCw
         YSgYpxY1zEns83BfL61kyJ5aR9Q+G5oOjGptc1Yk7j5NFl0PgjgGg85k3haMmK8Q98XV
         38Fw==
X-Gm-Message-State: ACrzQf2rKrb3L0ojyFoO/cGmV0/LMxRl1r5aM3A0U97JsJBJpPDE/IWi
	UuSLiKwIhyTL/vRlhKuaG6Gucp+yA6Q=
X-Google-Smtp-Source: AMsMyM6zHKphkAJuzkIbcP84tog7XKA4qS0N9c7f78Hpmj7A8qR6eGJIyeWBw5V08jkYkrG7+KPw7g==
X-Received: by 2002:a5d:4284:0:b0:22a:291e:fa8f with SMTP id k4-20020a5d4284000000b0022a291efa8fmr19572836wrq.553.1664348488825;
        Wed, 28 Sep 2022 00:01:28 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q6-20020adff506000000b0022a839d053csm3357397wro.98.2022.09.28.00.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 00:01:27 -0700 (PDT)
Message-ID: <6b5d5173-e18e-0f36-2f60-e145152835fc@grimberg.me>
Date: Wed, 28 Sep 2022 10:01:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme-pci: report the actual number of tagset maps
Content-Language: en-US
To: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>
References: <20220926210107.1677422-1-kbusch@fb.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220926210107.1677422-1-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_000130_071232_5D945712 
X-CRM114-Status: UNSURE (   6.77  )
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

