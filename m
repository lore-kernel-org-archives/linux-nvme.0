Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8461CF9C64
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Sep 2024 18:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yf2s7qcHCwR7F/4aj9u6T/uxm8HLZaqLu+5CEVi6GIM=; b=v44KaHt0aucYsT86ssLnKwzh8Z
	qgcZmfT4k4YCeFHBo6BdqhBL1lrvy5RQX+w8arqXCwIAyV6Bzfoaju2QznccubV9Mi+NJz0LuZ/ni
	OJbqTu4kVrh4/xrpQgCdZ/Qp5rRjlXFmSPMFptEi+du7gTZpMA7S/x7JrcaqSM59BxgFbp38SqVrr
	xI3tVESLWBRHA2IOeJGqi/DE/VLmu/TeGtzfhWaqLfa6G29YE5G5locptSnCEeNPdgvvFIBRPPEqm
	KadqlVvHd9D0ImGTBl6HYcyE/3K7pHLrKMOGVcCR/qkj3aVbMd817mPDq6iFpEy9hL8SlU1G8T/Xu
	QG1Ghdzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ssRfe-0000000FZsp-0Cd5;
	Sun, 22 Sep 2024 18:50:58 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ssRfb-0000000FZsR-1VeW
	for linux-nvme@lists.infradead.org;
	Sun, 22 Sep 2024 18:50:56 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-7197970e2aeso2495532b3a.2
        for <linux-nvme@lists.infradead.org>; Sun, 22 Sep 2024 11:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727031054; x=1727635854; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yf2s7qcHCwR7F/4aj9u6T/uxm8HLZaqLu+5CEVi6GIM=;
        b=M+wMJuHxofHd+5PreVJgFO57jid2LDPhbLNLbSy3q+NJb/naXv3ku3BpC1KC9sqwoR
         8KkSH0gzbx0rogePDvOv0hujnxjeGLyBOZb7aktzDzSEZoqfqvGBqhm+ls19929Hl+C4
         udasLxHv/PR4gqZ9UkLicERvGCYLWgJhelH+fr0f8qmH1Y+F0uiXcx93sXf1LAu+gWke
         rHuDGASlOjfp+sFrEFfcWaEDMlQBsRBK/gYWZBBY+PXohsuqmWAKQ1Upg2ZGbbSQcPrY
         L04y4RzHVHsVHbVdVY3kZG3zSMSSmN9hiSu+2uzOUdBcQK13qRH+W3kh4EExvnB9FOzs
         YPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727031054; x=1727635854;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yf2s7qcHCwR7F/4aj9u6T/uxm8HLZaqLu+5CEVi6GIM=;
        b=mSERv6GgsAg/oZdFmA5ULU8WkfiNgMy2mERaoRWmzeMbg3JvG2ef5WJ5MqVW+EJlmL
         +4VBwVm6h6zxaDkKJS6Igt1O/6lYn9NYD7h8rWj7tJqmuwz8YOxzthlHdWa9mqWkNELL
         jZkVN+nHXy7ECHEdBfN/DnCYAgAjMI94dnbNlBKnenRHSLMCKuD/bX+/3FfKh+gMbXpB
         gz/2Xy9GdKQ4GQJTdeAmGXrxdeZBXEub5cRFtH4GHZvtxIhWxJWFU+0w3wZuZcss0ENM
         OHDlWGBtS+FKBsDegzO10usVuQDk1LfLwDgbEbhFKYNFW36grtRJMPWejlyXkYrHaC42
         DBjQ==
X-Gm-Message-State: AOJu0YxIa45rT/apuDxg3F4CAmT090apFrttqAiAZjXydJxJ+hc7xZn2
	W8J3lGNBA6QufRnbRWA4kt2PAhqU0BtdSS2rkkAKAW4IZWI1XAoo2HQklQ==
X-Google-Smtp-Source: AGHT+IGFexkNxyRSEji5kbtH0osgfmCZMYKCoRg0/IKnsHCpagre6YyzAyrDcii98zqqsvkgfKaNPA==
X-Received: by 2002:a05:6a20:9d92:b0:1d1:17c6:7a34 with SMTP id adf61e73a8af0-1d30a9d0368mr14718739637.45.1727031054239;
        Sun, 22 Sep 2024 11:50:54 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:7cd9:6049:93c1:442? ([240b:10:2720:5500:7cd9:6049:93c1:442])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944a9831esm12701564b3a.24.2024.09.22.11.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 11:50:54 -0700 (PDT)
Message-ID: <9744ae62-9268-46f8-afef-fa775b00e249@gmail.com>
Date: Mon, 23 Sep 2024 03:50:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-sysfs: add 'fna' attribute
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20240921154707.4362-1-ikegami.t@gmail.com>
 <ZvA5m6D0_tA-qKC9@kbusch-mbp>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <ZvA5m6D0_tA-qKC9@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240922_115055_434369_842D7D32 
X-CRM114-Status: UNSURE (   9.89  )
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

There are many identify commands fields so if the nvme driver can be 
kept the field values seems can be reduced to run many identify 
commands. Thank you.

On 2024/09/23 0:36, Keith Busch wrote:
> At least for multi-namespace subsystems, I would agree knowing this
> value is important to understand the potentially undesired reprecussions
> of running a format command, but that logic ought to just go in tooling.
> And the meaning of the reported value here is not immediately obvious to
> a typical user without the spec in front of you, so I'm a little
> skeptical on exporting this attribute.
>
> nvme-cli already checks this on a format request, at least. You probably
> are not formatting very frequently anyway, so avoiding an identify
> command for such a low frequency event seems a bit overkill to me.

