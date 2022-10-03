Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F19C43217
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Oct 2022 16:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QWh/Tqk2tJQtRYQ726tnbmZWfj8cF9PavtxUc5cOs/g=; b=drJgT+Io5kzUaVX+3Dwvz3X8ax
	GRmovqXigRH9kWm36pNgZ3ATzthKi77nSb95Vi+rrdmR1AAus4xSilTzDod5MXqRQdipSeZ0v8iUW
	QNt1XiMqzxI7/qM9+RBJtSd0S2PnRtIRdq0jiBvOOBkaPVhr+JfSXbG0Ippx+ylo4pjSYCnReHP0u
	SdYbBHO4Sy4S2RTlao0UFQE4Pz4ixvbnx884C5M7GD8z7CUxpCskin/gnzfpYryBRMUY6EK41OBwp
	slQlI/9Hi1kEDrsb+Pwxi1lSQrNFlcmTkcbh/nOz8913599jWe9JMEbw+DuRaPvUPdiknlxZC3Q3g
	z3hBy1Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofOB8-006idQ-31; Mon, 03 Oct 2022 16:20:26 +0000
Received: from mail-pf1-f176.google.com ([209.85.210.176])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofOB0-006iTU-Ul
	for linux-nvme@lists.infradead.org; Mon, 03 Oct 2022 16:20:24 +0000
Received: by mail-pf1-f176.google.com with SMTP id c3so5743456pfb.12
        for <linux-nvme@lists.infradead.org>; Mon, 03 Oct 2022 09:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QWh/Tqk2tJQtRYQ726tnbmZWfj8cF9PavtxUc5cOs/g=;
        b=Ql1sm9Obkf35s1ESPOAphCv3KE5olZ0QDayLFOy0NeBw3Yf4JGZpg2hJt004SAhO/b
         3gTzZiORGTMk37HOv/FooSVU2GqvDsbwlS3Apz/stkEe15WxESeTqRu+YDDqZ3/Ow0Pd
         7wBulu09pOP8Sv1FnBm8rh8ZqaBUfKzkcmAYzTbjKuiOyPDtGk9tXdELuHh91Al4YqgA
         tkqRWx9Rca+F6yr/oR+OZxcfsvw6p5OtIB4PqcUgax9/XOLCpzda3m3fhvPwSkjL/Svw
         RswxSl1v5UZMNnG44MpBel8r14vjrb+ttbMJA/Vy7B55g5UhUfYHej48t5XawVkf0T9T
         jiPw==
X-Gm-Message-State: ACrzQf0yT9dzf8p3x9tDoy83SkCI3lBbMdaS85/TId9tADpQjUVxGdbR
	NHQNaLxfjrAIV33NeOEtBTI=
X-Google-Smtp-Source: AMsMyM7Pl75fUudRdxvD9Q77QRaS6QjmkNeFmeOCUsiUn50G6uufCwKMUlPPCK/bCtmcDnzrYlIpRg==
X-Received: by 2002:a63:20f:0:b0:43c:1ef6:ebd6 with SMTP id 15-20020a63020f000000b0043c1ef6ebd6mr19550527pgc.217.1664814003161;
        Mon, 03 Oct 2022 09:20:03 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id nn10-20020a17090b38ca00b0020669c8bd87sm6263884pjb.36.2022.10.03.09.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 09:20:02 -0700 (PDT)
Message-ID: <bc7db586-0413-1e16-8710-bfafc9d1262e@acm.org>
Date: Mon, 3 Oct 2022 09:19:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] nvme-pci-disable-write-zeros-support-on-kingston-SSD
Content-Language: en-US
To: Xander Li <xander_li@kingston.corp-partner.google.com>,
 paulburton@kernel.org, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: ralf@linux-mips.org, jhogan@kernel.org, christian@brauner.io,
 jeff_yang@kingston.corp-partner.google.com,
 dora_chueh@kingston.corp-partner.google.com,
 james_liu@kingston.corp-partner.google.com, vincent_wu@kingston.com.tw,
 xander_li@kingston.com.tw
References: <20220930091401.14862-1-xander_li@kingston.corp-partner.google.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220930091401.14862-1-xander_li@kingston.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221003_092019_040549_8E76E01C 
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

On 9/30/22 02:14, Xander Li wrote:
> [ ... ]

corp-partner.google.com e-mail addresses must not be used for posting 
patches. Please use your kingston.com e-mail address when posting patches.

Thanks,

Bart.

