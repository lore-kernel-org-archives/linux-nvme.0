Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4658C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Oct 2022 07:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uBJ6mWD5juUQ/CnR+9Opv614edZjh2hcpvyZnGqaOHE=; b=E6x8kURsyNNbUNRq96LwEzdJjH
	A9yZhyj2DhYOiOoxra4BGNbg8ZIw5YGX+jV8PRyMkUu7ERRbKb0tmkBhs2NRkbb7AkP32lL4JSCrc
	t+vijwsQ4zcOoGbInUoocjzBLlstPlKA0ZtFHhtdxBM0ffbh97go6tU2giY1Fxf2kQqJrnVSzVoct
	S0SQczBd2tRcekaiHkR5sRFZvHFx0D8hg0t5ftZesuTqNkVzN7Rh5nZFrOhubMwDmwK6y4rMaMlmz
	knvZ7jeKQU6XIoAoFuTZlpQuhNAFz+uLn2OAQrpxLp2oo/cP1HDYH6g7fJhKZtUJR7nxTUSqjsVEU
	o8nvliuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiWX4-007ETP-LN; Wed, 12 Oct 2022 07:52:02 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oiWX2-007ERh-28
	for linux-nvme@lists.infradead.org; Wed, 12 Oct 2022 07:52:01 +0000
Received: by mail-wm1-f44.google.com with SMTP id n9so4376919wms.1
        for <linux-nvme@lists.infradead.org>; Wed, 12 Oct 2022 00:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBJ6mWD5juUQ/CnR+9Opv614edZjh2hcpvyZnGqaOHE=;
        b=TrWtyymrOtuh/ZEgc1iFG7Qzkq89xStyVpQfYVkw7woo2mz82ZUOgFBhrp91te8+D2
         dwwZ2QUyiwcAOLiJuXY9xAcIb4gmwLyiSfEfh5Z1hsKsj5idukdeG1wQOHv1fRGdyT4Q
         0JCCWuBYwdvbExdP8oHKrMy/IVvpMkwugpdcxX0YIqotmNukpxlpwhOIgbtXcYErIuZj
         UxnfqkBpmZMyBr5jZvrzEXbGu9pMSUa408iVYvUSDES13hnLngO0WFL47H2rHtMWLmTU
         nc15/8AkyxnGbMbpsPLEftNpaCg/mEwuGhg2DVrFf0OkAGsRvRaNwBIWU7xBs2q/lYP6
         V3Zw==
X-Gm-Message-State: ACrzQf1CsvVju6Jzig7dQr+XTwn32LrRe3rzbDMwWzReJfbA7cawKpOC
	OJUZj/faL5iLn+LQxtukBFU=
X-Google-Smtp-Source: AMsMyM5RypV1V0SLxZJd0AM+jnGo9JkO0dDjKGl5SZh9OHtLF4RuuZbWPHIQaLAW1fePH9wy6qY8BA==
X-Received: by 2002:a05:600c:5407:b0:3be:d303:d352 with SMTP id he7-20020a05600c540700b003bed303d352mr1841978wmb.94.1665561115255;
        Wed, 12 Oct 2022 00:51:55 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d64a3000000b00228cbac7a25sm13286317wrp.64.2022.10.12.00.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 00:51:54 -0700 (PDT)
Message-ID: <975fcc5c-97cf-a6ee-b48d-e7503389365d@grimberg.me>
Date: Wed, 12 Oct 2022 10:51:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: nvme-tcp request timeouts
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Seth Forshee <sforshee@kernel.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <Y0WMXSv8REysoqFy@do-x1extreme>
 <40c9f99f-28ab-3fc0-f90a-b24f5dabe9a1@nvidia.com>
 <Y0XOoSmfwAdfOD9g@do-x1extreme>
 <f72fa6ba-e55a-6bb6-2efe-60458802c870@nvidia.com>
 <Y0XUFGXHciDCXRTs@do-x1extreme>
In-Reply-To: <Y0XUFGXHciDCXRTs@do-x1extreme>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_005200_633772_1034031D 
X-CRM114-Status: UNSURE (   8.84  )
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


>>>>> Can you bisect it ? that will help to understand the commit causing
>>>>> issue.
>>>>
>>>> I don't know of any "good" version right now. I started with a 5.10
>>>> kernel and saw this, and tested 6.0 and still see it. I found several
>>>> commits since 5.10 which fix some kind of timeouts:
>>>>
>>>> a0fdd1418007 nvme-tcp: rerun io_work if req_list is not empty
>>>> 70f437fb4395 nvme-tcp: fix io_work priority inversion
>>>> 3770a42bb8ce nvme-tcp: fix regression that causes sporadic requests 
>>>> to time out

btw Seth,

I've just looked at stable v5.10.147 and all of these fixes were taken
to 5.10 stable branch.

If you happen to use a 5.10 stable kernel (or a modified version of it),
let us know if you spot any missing fixes so we'll make sure they end up
there as well.

