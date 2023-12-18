Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0AAC35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 08:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3I1ehkMojAVFjvqI2yCdN2Ogepy4Pl6kypWAAGMz6hE=; b=IyJxqnVZlxks/NkOGzVf3EMvOW
	VDZf/Wva+T/80lKOFcyEu1rnboMGyKaEyu7YEIqrMQUOaDA7rQg5NiWepxzAj+AP94OHw4hAHw7aa
	AblnFkT+N6R0F0LqDcmXmGzNKM74Nj4vYVIHL9dWRESrAhExjEDnatuQhPt4wF88Ef4bUHQNwTutd
	zdk+j+kcnK25sWsTj+k1dmQE8K4JGLgFY8j4Xjlrdtw2bFRHpWwnd4yqGk9CsGUGIb/wK6ciEwAHb
	UWu1sg7aMeRDSx+vRFpl6nhDnNT6Iynd+koWC7QefRBvs2efsLmbiUTi3ooO8Xl9UVCia7HcM3FKF
	M94NgYLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rF8cc-009QOD-0e;
	Mon, 18 Dec 2023 08:05:06 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rF8cZ-009QNS-1P
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 08:05:04 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c79b61904so4570615e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 18 Dec 2023 00:04:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702886698; x=1703491498;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3I1ehkMojAVFjvqI2yCdN2Ogepy4Pl6kypWAAGMz6hE=;
        b=rbUZxdxYgq0Nq9uvUj2Lko0rA7ryLK4qLxy2hDd7vbcpZ/ob40s/gJGVO6iz045JCC
         YBMif/Wh0W867VzDyqlbxPekT1oRczw+QWAnSrnGoDXgUyawi6S1KHKK+qlmFM7n3ct4
         tmypQCu3BrQHOIFFoaBz0OlXG/P9hzRHNDPD5cj8DfQFXADICHy2jd9LAKFFf5ZnWLnY
         gBIWmumU2jHuy08OEXt6rMpB8Wv3sxWUAM5H/XTgwnlMzbKw5FDqcxYtChf6aUfBrVFJ
         j309Zo/X9FRNVTUYxrdn9JpfTIS6UorP4U3f1+RIIhVYzGIa52voFxfXjqHwddbmYlGu
         Fjnw==
X-Gm-Message-State: AOJu0Yyflx8GIPR0CwJ1xW8itig8cutJmwPj7qcZsWJk/9gXJqtS8kzw
	9n+x/42zNpGNKXUIzXzMqNujwy4ffVk=
X-Google-Smtp-Source: AGHT+IFCuvTBp7tYN9rXboN6iUr5V+zZgrsn0JMzJI0hJDybzs9aXXqXWx+isdtMo1XZwkztZg2rpw==
X-Received: by 2002:adf:ff8e:0:b0:336:6654:9a9d with SMTP id j14-20020adfff8e000000b0033666549a9dmr1600397wrr.7.1702886698073;
        Mon, 18 Dec 2023 00:04:58 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l1-20020a5d5601000000b00336630c31b5sm3887841wrv.9.2023.12.18.00.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 00:04:57 -0800 (PST)
Message-ID: <0bbe10a1-da33-4682-a416-e121df7c7c49@grimberg.me>
Date: Mon, 18 Dec 2023 10:04:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: validate maxcmd before use it
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Guixin Liu <kanie@linux.alibaba.com>
Cc: james.smart@broadcom.com, kbusch@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org
References: <1702629808-96718-1-git-send-email-kanie@linux.alibaba.com>
 <20231218055628.GA16928@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231218055628.GA16928@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_000503_474830_CAB5FAA2 
X-CRM114-Status: UNSURE (   8.24  )
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


>> According to the NVMe specification, if the 'maximum outstanding
>> commands' (maxcmd) field is not utilized, it must be set to 0h.
>> When a host connects to a target that does not employ the maxcmd
>> field, the queue size (sqsize) gets set to an excessively large
>> value due to the calculation (u16)(0 - 1) = 65535.
>> As a result, such a misconfiguration leads to the failure of the
>> connection establishment.
> 
> MAXCMD is mandatory for Fabrics.
> 

Indeed.

