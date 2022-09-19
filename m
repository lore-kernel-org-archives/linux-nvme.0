Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0930AECAAD3
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Sep 2022 17:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uutyCtcX/2LNEyVDlQFzRn2LRT7dUshU/FZisT8ltcU=; b=LX5iU5h1Wtw45ZsYYusUBEWuoe
	8R3zPXjx9Rub5sdb8GXmEiAL1NLBdvn6cvsmfT5pWMj8XbVMpkVIbP0/X1HFcCa7wyE3KSGXTVUW/
	9c+nc+BR+kcNBfIiMvR3mmnK7EFMHG7jy4olzkPrIOWhklT99Kcba62nOZUWo0LUJlbEqWPMsM2AZ
	+gC01HAiKAQBerMgoEPVr1TW/UqimaVojtJlJa3d8pqOQMHnu4217tz2iG9t2F46EsC+ajbCGXZCu
	sYVdJ+E+2gLMk5Z+iEnAuYNmLAODivslz1WFBToxN7DUbgL11/8bTA7rjOc+X2h4MrwPqF/Nm/Gsx
	xx+C9aaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaL1B-00DSKs-32; Mon, 19 Sep 2022 17:57:17 +0000
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaL17-00DSH7-6O
	for linux-nvme@lists.infradead.org; Mon, 19 Sep 2022 17:57:14 +0000
Received: by mail-qv1-xf30.google.com with SMTP id z9so264805qvn.9
        for <linux-nvme@lists.infradead.org>; Mon, 19 Sep 2022 10:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=uutyCtcX/2LNEyVDlQFzRn2LRT7dUshU/FZisT8ltcU=;
        b=Jk0CyBTmicWaTFAwTJHt8Nzm6jj2teSSINFaGIaKXMSEil0ghHvXHp6BRiQPpDL352
         w5snkvQf7Clwv7mAXXosfM+gEJw+NjUSceGuQ37v2uyX+IE/VrM7Q81GoxTwnxFo5Lu7
         xBdb5DgX1sPDw7ou0Kdlp7YFbETX14pWdsoJlH+GDiZ9dZEPB1SF6eTMwJCNRmkLxyDs
         dom+vOoLUeS4CmSaQ/Bg4F5zeJ+KxJqchPwNmlfHTIswqPGy9Udu/uDPedVkIIF46eOY
         LFzHL/LBm6PUHi7Hf3s+GB77zFrysITratHxX1Yle6keTbnsc4jeEGm0KwTUx6xXBB18
         oDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=uutyCtcX/2LNEyVDlQFzRn2LRT7dUshU/FZisT8ltcU=;
        b=om4jyQ998x/F1gZt0YkIm+zscIyTy+X38Sb+vhPItbThjxcRPK0GQvNHznyVGzLSDv
         psgBxoTQRoqjxSCqY4/Pv6os4x0wE2gvqZs1DCknajf7AbkuWa4yUKmeIlpg69mKcL7h
         S8lKQGgKi3wS/TeMpLACHPiYydNRRDfdaaSsQt6v57lnwuHiYNsmI5W1gREFgmhCbTRE
         v6Xfy0aPp+DoufdMOvQNqpf6qcxiyvn7cCPLoZ+D5ugIiMtL80BFK8WqN1RLACnr8wW5
         oJNYiRLaeILAhZW/EX8rt92wyuOj/q3/Q4XXjfOMAo5K0hQQaVc785v3KSMVyHoGiajo
         TZNw==
X-Gm-Message-State: ACrzQf2Ckck3HPwwZZIr+2/wnkgRmWPnI5UZtd0z5rBQ6FT6eljKyXt/
	bqap8F8fLz1WaSbJbPhSCRg=
X-Google-Smtp-Source: AMsMyM415iM0g/ejH9fCtYT9Talq4T+D5Diok+g12E3/w9bw8vHNiNBN1w3//0ctyXdOCaojPo5yFQ==
X-Received: by 2002:a05:6214:250b:b0:4ad:3338:bed9 with SMTP id gf11-20020a056214250b00b004ad3338bed9mr7012101qvb.13.1663610227884;
        Mon, 19 Sep 2022 10:57:07 -0700 (PDT)
Received: from [10.69.46.142] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m22-20020a05620a291600b006bba46e5eeasm13740273qkp.37.2022.09.19.10.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 10:57:07 -0700 (PDT)
Message-ID: <35339637-846a-2c7d-d414-fa05527a8cf6@gmail.com>
Date: Mon, 19 Sep 2022 10:57:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvmet-fc: Fix potential Use-after-free bug in
 nvmet_fc_delete_target_queue()
Content-Language: en-US
To: Liang He <windhl@126.com>, james.smart@broadcom.com, hch@lst.de,
 sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
References: <20220916082953.4095940-1-windhl@126.com>
 <5c965e81.13d6.183536d5bba.Coremail.windhl@126.com>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <5c965e81.13d6.183536d5bba.Coremail.windhl@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220919_105713_275732_14631095 
X-CRM114-Status: GOOD (  10.41  )
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

On 9/18/2022 6:46 PM, Liang He wrote:
>>
>> 		kfree(deferfcp);
>>
>> -		spin_lock_irqsave(&queue->qlock, flags);
>> +		spin_lock_irqsave(q_lock, flags);
>> 	}
>> 	spin_unlock_irqrestore(&queue->qlock, flags);
>>
>> -- 
>> 2.25.1
> 
> Sorry, my patch is totally wrong as the 'qlock' is embeded into queue.
> So if queue is freed, the 'qlock' will also be freed.
> 
> Now, we can only hope the 'nvmet_fc_tgt_q_put' in lin 941 will never really free the 'queue'.

Did you actually see that occur (line 941 freed the queue) ?

-- james

