Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9513DC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 13:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=02HMc5IuJLVgVwifqtF7lVyS4XBTNP1Rrj2XsXGDS2U=; b=Eao1IXaztaOqFEH+9qZsZWzi4C
	WV4NYFVN2ZsmAqqZuuTJxv3MVpTgN6XNYOFtPlWy2ncxC1xfXf8n+oqaulpS1Gq3qC6m6oEQ9QmcZ
	Mq+OodWCNYdFps8iZG/V8cvEYfeEjhX6opUDFXfPRM1D7OB2Ygg4BHkIlHJiNRXR/UlLshb01yNII
	eS0zUAMtRVNFtn+XlEqm3xl7bs3ypD6Tgt9979xrTwWVjXQYgH0gRjFNnlgMmfN7rqOkvN6hjkDi7
	vxKsF8G2iOTDtRWe4lo9Oc9u/7s77x+42jzivUQD7UHZqS4T+EFLPp813jOsAKHZ1yMYAeaFcYFq0
	ghhBtHvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol90W-0026jI-AX; Wed, 19 Oct 2022 13:21:16 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol90R-0026hZ-6I
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 13:21:15 +0000
Received: by mail-pl1-x631.google.com with SMTP id i6so17198979pli.12
        for <linux-nvme@lists.infradead.org>; Wed, 19 Oct 2022 06:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=02HMc5IuJLVgVwifqtF7lVyS4XBTNP1Rrj2XsXGDS2U=;
        b=UpspIVIXlFFSX8J5UAn/cqAQwRAgnbzjY3FhC7fiaajPMIK49IW+Oc6CM7t0MN1Tuj
         ZP+uH0eEOgwQmp5Y5AShlzuAU0fMUk4n+C6f6Sga+VGoXiOvOd/sXrgbNfU3BEVx1R15
         2fampG235xBRpQq3vNwof8eoCIvK9NaGvrFEc7oFKFXNY0QOuyFGSNa8tm15nRK2dTaP
         txrzoQGT81l/3a+L6y26K5RUIaiUeZrarEdCN2Ie27A0egIhWMv8qK9qwPEQSSRtzUbj
         4lrMfxuVxi2I8RU5LOTm8ei6OG7uLNfnT8GvWE3pa7OI6oY8U51FTv9Kt7xlFRSGk8PM
         cWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02HMc5IuJLVgVwifqtF7lVyS4XBTNP1Rrj2XsXGDS2U=;
        b=godUTK15d+c1ZtMgj20nt6zZeMvj95/4RvsFsItrXvOl2h4mUF9AYjSiJRFCVELeeE
         XwrA5yDs2sPuWc2bZuZRrqogt+CoLPFad8aS4AniTVoeLuZbuT/Ye00+8XLj9SPNhX0S
         /hBEY4cT3OjnUR2vikUPuBXIFB6HkCMQDOan7bVvU3GQuTVQBl/OF0vExPMAntj5X2al
         +pZ6Miv+4hgI5dbXe+Nt6CQtwahlyqJrWGkxj1Ka80mj69dswQe2ybYm0QLV8WrrtRru
         2ga5zNMsROPcyiFCh7m6NVylzlHEN3GJvzzWWKagq/M/v40QGgQ02/woUB+ITu6GcQBE
         S9DA==
X-Gm-Message-State: ACrzQf3dTteM8TcPZ/a0AVrBFALEncnxDTeLbFkTEEP+KwyZ//+ANTQR
	mkPRQN/ouOgF7sG37vLFu/c=
X-Google-Smtp-Source: AMsMyM51LIc9x8VknUpeaDLAHqK0/L1+2c3a7yy3BWTqy4hOoALnSvTXVNWetB3LWNzJwyGM/KrdxA==
X-Received: by 2002:a17:903:245:b0:178:e0ba:e507 with SMTP id j5-20020a170903024500b00178e0bae507mr8614236plh.115.1666185668244;
        Wed, 19 Oct 2022 06:21:08 -0700 (PDT)
Received: from [192.168.50.208] (ip98-164-255-77.oc.oc.cox.net. [98.164.255.77])
        by smtp.gmail.com with ESMTPSA id i3-20020aa796e3000000b005625ef68eecsm11282861pfq.31.2022.10.19.06.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 06:21:07 -0700 (PDT)
Message-ID: <3005030d-ab99-200f-aee3-c7ee74b55506@gmail.com>
Date: Wed, 19 Oct 2022 06:21:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: linux-next: Tree for May 17 (drivers/nvme/host/fc.o)
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, Christoph Hellwig <hch@lst.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org
References: <20220517194118.2caa01b8@canb.auug.org.au>
 <5958ccea-d89c-8b1a-15d3-19d8cacd141d@infradead.org>
 <20220518045704.GA30131@lst.de>
 <e2f636e1-33ff-3d9f-a793-960f239d0bc2@infradead.org>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <e2f636e1-33ff-3d9f-a793-960f239d0bc2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_062111_239806_2B2D1C45 
X-CRM114-Status: GOOD (  13.14  )
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

On 5/17/2022 10:21 PM, Randy Dunlap wrote:
> 
> 
> On 5/17/22 21:57, Christoph Hellwig wrote:
>> The patch that adds nvme_fc_io_getuuid need something like this
>> folded in:
>>
>> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>> index a11c69e681180..3c778bb0c2944 100644
>> --- a/drivers/nvme/host/fc.c
>> +++ b/drivers/nvme/host/fc.c
>> @@ -1911,7 +1911,9 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
>>   	struct nvme_fc_fcp_op *op = fcp_req_to_fcp_op(req);
>>   	struct request *rq = op->rq;
>>   
>> -	return rq->bio ? blkcg_get_fc_appid(rq->bio) : NULL;
>> +	if (!IS_ENABLED(CONFIG_BLK_CGROUP_FC_APPID) || !rq->bio)
>> +		return NULL;
>> +	return blkcg_get_fc_appid(rq->bio);
>>   }
>>   EXPORT_SYMBOL_GPL(nvme_fc_io_getuuid);
>>   
> 
> Thanks. You can add
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> to the patch.
> 

looks good

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james


