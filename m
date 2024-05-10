Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8433FC25B10
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 14:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dmTNhSQMHzNSswqOiPkvczjYYpGZjhC1nSM5AZr86CI=; b=3ytSZeJzLh/POE0LPB67X27YIG
	O4PwsdeUgcmJocWZfshssQKUC4oncS99CMycTaTuqnYU71nekh30qE+nTtgODVChizNjCv4Ig3mcs
	aPF8vcR6YvE5VLudMRrqsGKvJdixfmGMvr3lcTnCoggQYDl62FO7V/vEiX6nRWERqxSYKohiXzQxE
	AQ3lqZBdw61qewScrc7Mwld6LJFASH8hk7t3vHDXxB1eIV4yIsVm22HXPskjIGgBukgjyfYqHFvNV
	GstFEPYKa9mVy5ZPTxTN/DSVx9gu8YCYY8iu4t3vrCfxmKBibiBAPCSImG3XxTHcS+FMd6eIGwWM9
	Luy4S1tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Qx1-00000005VR7-1FY4;
	Fri, 10 May 2024 14:10:19 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Qwy-00000005VIB-2Ub6
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 14:10:18 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6f4178aec15so1847403b3a.0
        for <linux-nvme@lists.infradead.org>; Fri, 10 May 2024 07:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715350211; x=1715955011; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dmTNhSQMHzNSswqOiPkvczjYYpGZjhC1nSM5AZr86CI=;
        b=JLP7drloN7XDwRCO7q0z6/1s9EHtSEduJXeijPRxnS87Ww1xepe9BSsWGC4eIPK7ES
         n7yP39x8Xkh2oG3gSNc7QbadL3KPcu7i9u3CzhlEaxaIMvKGufhyErxptsd6nIDTpns1
         XpYpMAaUQGR0oBGIzlHTbRg95t/W8u6BbTQFLyBDEgHh2r8zuAIJaXFBbey+KZDU/6Hi
         DsF5sX/EJxVV168ltXP5azRWqDkrbNoWmr3FBEUEZYy3PkPav8WKEpKwE74L3h3iIlED
         klmjw8dXhkFpnNrvyO20D66e5nBJsdVQOy455r+Px4wdPMqzjCLMN+RSlhdorIZF6m/h
         n9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715350211; x=1715955011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dmTNhSQMHzNSswqOiPkvczjYYpGZjhC1nSM5AZr86CI=;
        b=m+djewg9s7CvVEeHzNnCb1X56+0DStB7lR1TNdqXJ0LsLWZo85jgOuvpchaKzeaG1c
         b+C3MSTgp9RKS9daA8XAgb5oct52eaGco4hw4T5AsmfwsWCaF4fxmsX+W0Wk/EB1JR87
         cmqxVmn292WD5n1AajcUlAkrjYZUdcbPFye/czDibWH0SXRFUKYYyaJNcYZ6gVoYYuj0
         nXLsiKDklB02mMhQnOag93wrWoJ3Nne2tTaEoxw3HOQ2V6AoKz/9GO1KVI41a/CW9CWm
         WcuyiF18r7gb8WLhcSO56eDOwISwMmqow3EZU/tH4Lelblm4iC55nV7plO3zDhpDHIoo
         iOuw==
X-Gm-Message-State: AOJu0Yx9oOysHf5ShHsbxr/ZjfpQDIt1YlJp9rkO8yvKYylDBIt04Mi4
	ZNt9O/338BZxGiushBQ29JsDNxQ9YOvMezwnVOUVNgUTkzdYaSDi
X-Google-Smtp-Source: AGHT+IGkbNZJrix9ks0aI4cBbuUKZQ3FxlUtcvstfynyKwnm+J+keyLzcR5W2utdQ6nZWY9PItbf6A==
X-Received: by 2002:a05:6a20:9c8e:b0:1af:d15a:6b60 with SMTP id adf61e73a8af0-1afde11bbafmr3224246637.28.1715350210731;
        Fri, 10 May 2024 07:10:10 -0700 (PDT)
Received: from [192.168.50.216] (ip68-109-79-27.oc.oc.cox.net. [68.109.79.27])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2ae112asm3094649b3a.112.2024.05.10.07.10.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 07:10:10 -0700 (PDT)
Message-ID: <714963a6-7fad-4e4e-84b1-795c7595abc4@gmail.com>
Date: Fri, 10 May 2024 07:10:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] nvme-fc: fix io timeout to abort I/O
To: Dan Carpenter <dan.carpenter@linaro.org>, james.smart@broadcom.com
Cc: linux-nvme@lists.infradead.org
References: <4561816b-bcae-4292-af42-e563f78cd805@moroto.mountain>
Content-Language: en-US
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <4561816b-bcae-4292-af42-e563f78cd805@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_071016_672244_36C458C0 
X-CRM114-Status: UNSURE (   6.76  )
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

On 5/8/2024 7:43 AM, Dan Carpenter wrote:
> Hello James Smart,
> 
> Commit 52793d62a696 ("nvme-fc: fix io timeout to abort I/O") from Oct
> 16, 2020 (linux-next), leads to the following Smatch static checker
> warning:
> 
> 	drivers/nvme/host/fc.c:3239 nvme_fc_delete_association()
> 	warn: mixing irqsave and irq
> 

Dan,

fyi - I'm taking a look at this.

Thx

-- james



