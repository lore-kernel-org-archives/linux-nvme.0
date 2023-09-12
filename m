Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7641CA0EC3
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 12:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F6UCSN/Lrjr2SjLNlrDr0vGhbie4QKl8HP9yXF7N05o=; b=dhz8z/Hs20zg7h+Rf0nUmnnpi+
	zW591OZriiYTcPdnGPF2AVTnncbChXm9ApY22/uU04CLmCyGgV6mMU1DBegyNLIyzTDqQPuulrI2f
	/fOs2qnWJynZtR7cfMfVwuRtdrr4WjqS/xn2132m08bWp5K0h6G7bmIl0vRYYdAJGBfqRxIhVbwqC
	OxVhBMElG/d9wPfdBvFQI8hGnLhbVbvo8zIaw1YoQcx9vRQTfjs4fzfwyS0MfWbL9Y5e+65uh2ZQp
	eeH9ZDEQn9OJ8tVdqzsIf7HmP3lxp9ngu0VB/gUCxS0jqJPrFIHsthmRduLsxui+OAQf+Jt/nDcxY
	Ku1d6Z6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg2LG-003JXL-1d;
	Tue, 12 Sep 2023 12:18:06 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg2LE-003JVk-10
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 12:18:05 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-401d61e9fecso17209015e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 12 Sep 2023 05:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694521081; x=1695125881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6UCSN/Lrjr2SjLNlrDr0vGhbie4QKl8HP9yXF7N05o=;
        b=LpEq7Q2wKG2GVV//wiYqSIos26mVnCWHjwM5whxtVdzJU1KYYhJ9lhopzIt+mOVSIx
         frnXa5lx2WYPT+VFzb7VeZR6tHXWPj3lsA4Ww04i+B35UMPOlpPo9Duj9QCU07z/8m0n
         oYXENeag+MxTVns41RVcB63ygPx19BXf863HqnVmu79mBg+n0tmJxOScxWu9H7/WuE5P
         VQIuGHnUrYhg31Bty1YUNEfOEOMofmynBR+oxj5ktYDz3T6tFj/Q2ACH6tnWuno0tFxw
         4B9haexrVYYBPNx3oKtM717tJNimSMQgEHRVNqKdGzYcHByGCVX9CxjbGqvFi0svzImU
         +Z9w==
X-Gm-Message-State: AOJu0Yyjrvb1NSaiMT15YQD6FiPbEjsyu79onK9mEDicqn0Hjuj042Bc
	c3EbQxsydQ5FLxETcJXOw+8nddESamE=
X-Google-Smtp-Source: AGHT+IEbQ+Wd94EcP/thsvGFv/l1QXQf555WtsAjQRG3uhGGkOVHZlhq2fn21JPXKaOBvyoPdduUDA==
X-Received: by 2002:a5d:67c2:0:b0:319:7624:4c8d with SMTP id n2-20020a5d67c2000000b0031976244c8dmr9218124wrw.0.1694521081450;
        Tue, 12 Sep 2023 05:18:01 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c18-20020aa7d612000000b005254b41f507sm5915865edr.32.2023.09.12.05.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 05:18:00 -0700 (PDT)
Message-ID: <b99aff9e-af66-eb41-c89b-6e8f345e20e8@grimberg.me>
Date: Tue, 12 Sep 2023 15:17:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/3] nvme-tcp: delay error recovery until the next KATO
 interval
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230908100049.80809-1-hare@suse.de>
 <20230908100049.80809-4-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230908100049.80809-4-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_051804_348456_E0603A67 
X-CRM114-Status: UNSURE (   8.93  )
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

Please see my questions elsewhere in the thread.
More information is needed on what exactly is happening.
It is not clear to me at all.

