Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B23AECAAD8
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 10:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=WKYn+XYg1xQyLMAI9WxL06UKkJ
	TNy1UJ0GET2hAoSFbSvtPA99Nug6QACSEK0V61E23KievCgb9NlQPVwkdO8r5yyliLmycmA/TsUfD
	P0gKAzERd359Ae9EkX7RT2IUkrkTjQVjwSzuYE3kIybCMGPBj8MOsimw7f7nxaVY+GXpKlTt6bIm/
	L8/HB0G0sTBpOy2MQL/cr7VR539KSk7qwY9ELRmYUqqr2ksr7rKzZYUs/oManKA06BK+TaO6zQbhx
	zvEvGYVDk21ZNoZxNzg4wSKRg0BzL6CHcRBRpeS37vW8l1U2xilvP1pPFTcTePJ1spKr9th6jrZ3+
	ILRh/QmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaxH0-00Ax82-DE; Wed, 21 Sep 2022 10:48:10 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaw7j-00ARcF-Bq
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 09:34:32 +0000
Received: by mail-wr1-f50.google.com with SMTP id y5so8910951wrh.3
        for <linux-nvme@lists.infradead.org>; Wed, 21 Sep 2022 02:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=qfA3NUCxMhimOY1TVFqU81N8HDg/oqPPOwCC8pLLxxHI/KYGMPu6o4SfztK95uXLsL
         eKRoOOFTHrhTWpeX/Uva4Gur8x/gm2CoZW97rjfKnkC19aGFafvJ4McKpmUidpq0x6X4
         Nab+t8wDW+NoNugkO0mSPo/IQNQdamQfys+coI1ioLQsNy+gbhxRU9oAHDEsqSS8LA4U
         5pug0OnXOiqV9+hZtA77KwwGzpPmICTmKzVyBIoT4WEnwOWbXWE8joZ5PjLUJc/QZ6Y8
         FLpATnX1MAPX8M/EFEXABe6A/vkXD3BqpcvpAMb06JHJfVdXV9tL3WKLP4HYdlLpzwI3
         XHnQ==
X-Gm-Message-State: ACrzQf3lYt7MYWZsrTCpHuSUxlE7gWpUHwqNMlAGvA+NZtHCesRBa6FI
	bQXkm2Q8uCvvKL4H6SvTUI0=
X-Google-Smtp-Source: AMsMyM6xVMq0hWZ9JbyWCKnxIYrrYPBwdLQ/TYJWtyX9ij+IpHhNk7eTPrETcnZRMn5CadMf98UacQ==
X-Received: by 2002:a5d:64eb:0:b0:22b:fe0:98e2 with SMTP id g11-20020a5d64eb000000b0022b0fe098e2mr5330421wri.178.1663752868571;
        Wed, 21 Sep 2022 02:34:28 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 9-20020a1c0209000000b003b332a7b898sm2079445wmc.45.2022.09.21.02.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 02:34:28 -0700 (PDT)
Message-ID: <cd9069cd-84e0-465d-5bac-feb4726b6d46@grimberg.me>
Date: Wed, 21 Sep 2022 12:34:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 12/13] nvme-loop: use the tagset alloc/free helpers
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-13-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220920171611.1289361-13-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_023431_434053_8973C97B 
X-CRM114-Status: UNSURE (   7.43  )
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

