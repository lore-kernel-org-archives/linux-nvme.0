Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3636C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 09:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sccpZFYvzNhcph+z2VBJpUseqtR95SmCVosVES2vX3I=; b=RYpSUP5OVT9yrs1oskaA4pSuNB
	CLkhejrHt+m6kj3EY4uW9gmzP2rDJnPmJ2RXLVTS2cl6imvs7V0B3UCCp8CLyL0aGwxgxGbXUaLwm
	Zb8BdRb9auFh0NJqpjkBwIW8/sqhLUvTHWjtl+8IfM+RxDIKdv0Ncn4iz8UXIlCcvMxFQD1BBa93v
	rIkgIDy6p4l6PyDlDcVebi10uJxPGOhByEvTQke1ztIV0qZrfePXudGACTZoZFswq8FTK2Yo0F0pd
	tGTwC2zm15yR8oeZ8Wmn/rG6hZvJDcB3JE6t0EoU2zr0tMWX9rQsybQ6XE1mH3LybFwASvzTGoyki
	S1Lk9RGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol5TJ-00HO6v-9P; Wed, 19 Oct 2022 09:34:45 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol5TF-00HO5j-SC
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 09:34:43 +0000
Received: by mail-wr1-f45.google.com with SMTP id n12so27955209wrp.10
        for <linux-nvme@lists.infradead.org>; Wed, 19 Oct 2022 02:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sccpZFYvzNhcph+z2VBJpUseqtR95SmCVosVES2vX3I=;
        b=sTt3fqbNgPksZAd1X5BTOpuzbQ1aQgzlBTOoN0xFc3qXPh3Nu2BKTabBRXgXw8AVMl
         tlj5jxSq4v2ANl96lCLxqY1QxFnN/PN+O8CsziLEwavmUn4RNEZ710J1xOf+FOlMbSH7
         4pR+Tymmw7wSNvHWA5O5gHRa0Ob8au5wUeIcYgzMXs5mQGzsxEInk2VtOMxgh2ilFVpx
         wD+zkWMyJItRdmrM771sBrOcmgqQuN+me+bp+9AR347Xl76lFU/R35nEdQrRY8u1g4EX
         K/F6zsj3P9nrGYEUoDdzhGJwgdZlJD5RSJ6d1VkwdPTeKmATs4mYPPHifI4pBc6rzj8/
         x31g==
X-Gm-Message-State: ACrzQf0SFcJdTsIG7P7x2Z6oXvkjbiN6cKcPU/DVRzUSCA1ZD1GQhwlQ
	Cp5lSY6AZ6IUat1piTOFhUAPsevh+Zo=
X-Google-Smtp-Source: AMsMyM6L2WqbjTUIg/6SApdSBwoZQCF9ya0ePmoIYr7S71GuzBIS6yyDVRPtPIiMw6FoQ9vVodGURg==
X-Received: by 2002:adf:cf10:0:b0:22e:4e50:9161 with SMTP id o16-20020adfcf10000000b0022e4e509161mr4231803wrj.587.1666172075218;
        Wed, 19 Oct 2022 02:34:35 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6acc000000b0022ae0965a8asm12892182wrw.24.2022.10.19.02.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 02:34:34 -0700 (PDT)
Message-ID: <7d02c3b8-09df-f5d8-6065-f1caa8f5d643@grimberg.me>
Date: Wed, 19 Oct 2022 12:34:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH, RFC] nvme: add Guenther as nvme-hwmon maintainer
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, linux@roeck-us.net
Cc: linux-nvme@lists.infradead.org
References: <20221018150056.681478-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221018150056.681478-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_023441_935322_C9DCBDE7 
X-CRM114-Status: UNSURE (   6.99  )
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


> Given that non of the overall NVMe maintainers knows this code very

none

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

