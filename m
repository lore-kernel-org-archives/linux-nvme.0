Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38806C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Oct 2022 13:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C1luhcQIdWeTFyljjKwh9u4O0/Z4ceTLk8DiwBDLN/E=; b=bXYmxiITLtZJ321vlPzc2DT5U6
	MFZRRpL1/oJghyYp65SfbLhzrUpufjCkbNwWRNlzfFdq6WiMX6xAejpPSQZr72rTGs+EyGQQdYCaR
	Jx689+D7Dj+9kEi9fGIhYrvL/17kudfQCUDmk7c46R1bmL+70oE1ROi+Xfy2+A3Kk6tJSRc5m//GS
	iJZNE5blqZldIDridqiZ8usfSXipmZXXcplEfSIVcYaE55Rfgn+4AdbJPhxKuJG/FNu4KxCMxhfqu
	cynBsZYjOIJeWUd08DwxFkH7xA3Q45OllOnKO2Q0wBzIc57Fyyt/KjLSMQujX8vBIaN3VJCa2LZLb
	aos2xftQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofiQJ-009qFB-Bu; Tue, 04 Oct 2022 13:57:27 +0000
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofiL1-009nY1-Ul
	for linux-nvme@lists.infradead.org; Tue, 04 Oct 2022 13:52:01 +0000
Received: by mail-qv1-xf31.google.com with SMTP id i9so5220189qvu.1
        for <linux-nvme@lists.infradead.org>; Tue, 04 Oct 2022 06:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=C1luhcQIdWeTFyljjKwh9u4O0/Z4ceTLk8DiwBDLN/E=;
        b=KKRsZsKcxSgT2NLqezYFAthVlqA7d1g+yzcqCgViHaLLoO1w2ABoTQwmeKSCkdW0g1
         /tiCDY/n3MyrT8MsACki5VUq9uHAmM3Or9D3cb8YhMJo8q3FdlLm6yyAUwOKeQ8sUutA
         OlzUHdKrSPgYXwui6EoPs4kjl7FPoL1hfvwC1GZ9r2VDg1JjTlqtNaflh/WTwVk4+9oo
         K1jFqMXNGvDOJYp+SNux4Pfkk4G/EnY7ujU7GO8NF76C9r2XwnpYet7wbCNbCVrkkGG5
         f8RswJCNFIG0wAo8m33D8iCDSNzLC1HQ8oEyl1+TFaIku27GrS/aIcvpVMeD5rJvY5jx
         +vPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=C1luhcQIdWeTFyljjKwh9u4O0/Z4ceTLk8DiwBDLN/E=;
        b=npWDMN+bNJ203ozmEI4HvHJjRWaQpQ9H+qfXP3ba/Lddc3/CHXY4M86/JwtK715BUm
         HCen7O3AknkvKfaX9s+yy6qKMYLTQ8WVbTUPRdMjieVR8iFts6cz6u4nLkGb3qai/FZy
         TQjK3euuf73UUvRSifD7IR/itA7pHqx+IfJQ2c/j05iAko0YE3Z4K6yeRQs4LG/aJ5LL
         H82RdwNbyXfHjiFSbDtgk/HglIccD7AQOVgTCzP3LW+2wAYvRaBHP2OkVjEYIRtuat2J
         6UBXrJdLbP7Sziww3OegEJZPCcqUuzID4yDRd45KgcbuSHPR3o4Qcd3ql2MaxPXynFgl
         9LXQ==
X-Gm-Message-State: ACrzQf2Cms8vp1wBCDIkxC5gxuEgyXGlKz5dgb77MvSKdSksYd3p/suU
	FM95QORvRYwFFEncFVEiQ+4=
X-Google-Smtp-Source: AMsMyM6/k3TW7BEqP8gGTNXfrlEjXBamdkbCU0olDw+0wfUvYKJ8JLckyAfopDYAKWLMlr87q9hkhA==
X-Received: by 2002:a05:6214:c43:b0:4af:97c6:e31c with SMTP id r3-20020a0562140c4300b004af97c6e31cmr20157208qvj.103.1664891517091;
        Tue, 04 Oct 2022 06:51:57 -0700 (PDT)
Received: from [192.168.50.208] (ip98-164-255-77.oc.oc.cox.net. [98.164.255.77])
        by smtp.gmail.com with ESMTPSA id s22-20020ac85296000000b00338ae1f5421sm11581469qtn.0.2022.10.04.06.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 06:51:56 -0700 (PDT)
Message-ID: <7bebb1cc-211a-dac4-3daa-ce005156f2f9@gmail.com>
Date: Tue, 4 Oct 2022 06:51:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] nvme-fc: fix sleep-in-atomic-context bug caused by
 nvme_fc_rcv_ls_req
Content-Language: en-US
To: duoming@zju.edu.cn
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 james.smart@broadcom.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me
References: <20221002001909.20070-1-duoming@zju.edu.cn>
 <305fbf18-6759-9b00-6fc0-93a4a2e40be2@gmail.com>
 <7bd9e071.1063f1.1839b89cefa.Coremail.duoming@zju.edu.cn>
 <2f36fa52-2dc3-21f3-b53c-d0a9186c3ceb@gmail.com>
 <8aeea62b-c947-6414-bca1-3bd3f427cd56@gmail.com>
 <118cdb2e.1067d5.183a2b07fa7.Coremail.duoming@zju.edu.cn>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <118cdb2e.1067d5.183a2b07fa7.Coremail.duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221004_065200_037939_0F0D6573 
X-CRM114-Status: GOOD (  13.25  )
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

On 10/4/2022 4:10 AM, duoming@zju.edu.cn wrote:
>> looking further...   lpfc_poll_timeout() should only be used on an SLI-3
>> adapter.  The existing SLI-3 adapters don't support NVMe. So I'm a
>> little confused by this stack trace.
> I found this problem through a static analysis tool wroten by myself.
> I think the hacker may simulate the hardware to trigger this stack trace.
> So, I send the patch to correct the problem.
> 
>> Can you describe what the system config/software setup is and
>> specifically what lpfc adapter is being used (dmesg attachment logs are
>> sufficient, or lspci output).
> Best regards,
> Duoming Zhou
> 

ok - so the patch is to the tool ? as the code path doesn't actually occur ?

-- james

