Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEE8ECAAD3
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 19:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=AAfw1Fft2EIWaSkOL4761KvnB7
	txCLbaWMI1UtNLMPK7rK3BtPOS5NRtMuZFBvPlNTdNCW3LTQEtjWM1qZJEdTnqzNb3TMYj6Z79Bal
	h2gvr1r0wOfliEv6ltG2MXoo2exErmGDQ/8DR1hLrJSFth2erwbCU6PLVbXYJU0Jl4mXw+4wpBGF/
	KbJk32ztIo7dvd+dY+Q3TT77lF8ui/C1P52JLbmW0cDSvQouuSiow8gDtQ2HyvFjA5lUvuUgudy8R
	CcchecmPrTlRkBZl9l29FamVoFcIKSCy+2qr+Pbr3ALCZzNL2cBCzSv4nS3ZKyeoRXhmMDuJPBBaf
	OA8xuktw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVHq2-009NFJ-4R; Mon, 05 Sep 2022 19:32:54 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVAes-001bcV-KQ
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 11:52:56 +0000
Received: by mail-wm1-f54.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so5533755wmb.4
        for <linux-nvme@lists.infradead.org>; Mon, 05 Sep 2022 04:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=1tmmPSZxJWqY6RtdCaaLZS8oM9cTcalAjTa74tOxUYylxeXFXlOLDMVfIvYN8dvd16
         e2lyJOfNW4pYe9n/9DlkeiJ35RdSHuzVaqll2+6Eycoh5hk9BgW9YQLTQKqTggsl9iKp
         dj0NTuIuUx9qxV7ICHkPP1aIRbWM0bImwB9lUJ4kBQOz2vDKqo1oIIzPfT7WojYo15LC
         gSMMFFXIG9tbZVlX1FGkH5XzyGUhHGcZ5yHpOp8dlNOnQi0mW/tl9olGRtC3Epd13iVp
         9m9Q78FYCIoZ1HLWIYLmp8o9lDHdcIQ3DHQ1yz7M+R/vxpbm2Y1b0ZdY+8meKG857pNh
         iA6w==
X-Gm-Message-State: ACgBeo2ZvdYt7qvo+AJ6kXDc+RWrqLHlNNl4+mSLTrcNH4y2CMUxq5kf
	fqchHcGmGkaraCao+Whim5k=
X-Google-Smtp-Source: AA6agR7zDYMSh/owHsnxLhDNQi8ZbaqeQetH0K6KJJkzqroxW6/5LFKAG1iGm1cqUbm9Q1/yGs02UQ==
X-Received: by 2002:a05:600c:3551:b0:3a5:dcf3:1001 with SMTP id i17-20020a05600c355100b003a5dcf31001mr10415299wmq.58.1662378772724;
        Mon, 05 Sep 2022 04:52:52 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f1-20020a7bcd01000000b003a35516ccc3sm10399162wmj.26.2022.09.05.04.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 04:52:52 -0700 (PDT)
Message-ID: <f60fa86b-83cd-91bb-9aaf-b0dd29d7e30b@grimberg.me>
Date: Mon, 5 Sep 2022 14:52:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] nvme-auth: set the DNR bit if authentication failed
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220830124925.40711-1-hare@suse.de>
 <20220830124925.40711-3-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220830124925.40711-3-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_045254_952972_0AC81A87 
X-CRM114-Status: UNSURE (   7.32  )
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

