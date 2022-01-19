Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2DAC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jan 2022 06:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f3sqqwGYTxwB4h/WC7TEBnX5X8zEHCGQCnocQRWiENI=; b=rIDEqShhCBaKssVVOQnb/P8SlK
	VJzWNeyhXZaneRYBpoyNG3wXhAtw1XQuVxUqQ01vcxCPp1MvRjs6XlE4RhifN+Im3OLJYdGB2Pe90
	Qs8w2iIZv3KDSVB/9BeeqKnMJjcbbUcwW5bvts5iCxA240dwrWw/7PRpJcHN+HShZM4lMJbULLOor
	8aBVkTbd1clzf9zxuClMvys51emnoiH6S0dVNlJQ/PHXKG2Vo8yuHTKU/cnbtxHM48IqN99efRijH
	knjZl45jhT57L2aRXKOTcpA/0uiJ0nc9FlRPXygOs+ZaBzLJMORb4jr3Zr9TOX2+IjOAXpoiZDPed
	EUPt9m9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nA4Q8-003wmP-Ua; Wed, 19 Jan 2022 06:26:12 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nA4Q6-003wlV-Gu
 for linux-nvme@lists.infradead.org; Wed, 19 Jan 2022 06:26:12 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 l12-20020a7bc34c000000b003467c58cbdfso11816973wmj.2
 for <linux-nvme@lists.infradead.org>; Tue, 18 Jan 2022 22:26:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=f3sqqwGYTxwB4h/WC7TEBnX5X8zEHCGQCnocQRWiENI=;
 b=vQ5LdCBMfuXbQ1tUOR1Y8fEAFRHXsa3CdEY1C/Tt5goDXHvShjpaijP7atTjWbnzjG
 XFAIaEzWGTkpfLIeDzeE2KdQ1nNuv5gUmV7sc8uIxmVXqClQ4gWBth86P+qG1VHqMyU6
 xVPaXMxVy38kUg1LNKMgctassBg02eRpu+3uVSCwxVXPdp0c8Q0siS8d1h+BFD9T/IN4
 6I1arxm1q03rsCVKU3wL0y7vF0oldLuWc6+TNjDBStaNOZhIq26zudHZwLGy8dxn40E8
 vUOg4FpGxk6bZugu52OqukRJwbDZGWL1AIdSj5aWXn24pdhk0vKiaVPssI4czqYK45dT
 IofQ==
X-Gm-Message-State: AOAM5311mk9yYIbHHCFHVp44BYcfrHwnSEndDAX7SL6U/5oNwtXHp6iA
 D3tErDrlX+j8spEkdBih7dc=
X-Google-Smtp-Source: ABdhPJz1OomoY4nM/uYSjgzcCHSSrr+lIT/UCt/ryZeGX69XcrG4mQTLSEP2sAOZmqIaDkp9vAh2dg==
X-Received: by 2002:adf:f0cb:: with SMTP id x11mr2447196wro.222.1642573568910; 
 Tue, 18 Jan 2022 22:26:08 -0800 (PST)
Received: from [10.100.102.14] (85.65.248.190.dynamic.barak-online.net.
 [85.65.248.190])
 by smtp.gmail.com with ESMTPSA id h11sm397356wrf.101.2022.01.18.22.26.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jan 2022 22:26:08 -0800 (PST)
Subject: Re: [PATCH 5/5] nvme-fabrics: set ret to -ENODEV for error case
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
References: <20220112062101.90102-1-chaitanyak@nvidia.com>
 <20220112062101.90102-6-chaitanyak@nvidia.com>
 <20220113162840.GE3230285@dhcp-10-100-145-180.wdc.com>
 <09ae3d37-d22a-af44-9ea8-5d6f95c70ede@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e90fda23-5438-c250-b530-30590867217d@grimberg.me>
Date: Wed, 19 Jan 2022 08:26:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <09ae3d37-d22a-af44-9ea8-5d6f95c70ede@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220118_222610_603973_89D68FDC 
X-CRM114-Status: GOOD (  18.04  )
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


>>> From: Chaitanya Kulkarni <kch@nvidia.com>
>>>
>>> In function nvmf_dev_show() if we don't find the controller set the
>>> ret variable to -ENODEV.
>>>
>>> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
>>> Suggested-by: Sagi Grimberg <sagi@grimberg.me>
>>> ---
>>>    drivers/nvme/host/fabrics.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>>> index df0326db306f..ca23ac926710 100644
>>> --- a/drivers/nvme/host/fabrics.c
>>> +++ b/drivers/nvme/host/fabrics.c
>>> @@ -1097,6 +1097,7 @@ static int nvmf_dev_show(struct seq_file *seq_file, void *private)
>>>         ctrl = seq_file->private;
>>>         if (!ctrl) {
>>>                 __nvmf_concat_opt_tokens(seq_file);
>>> +             ret = -ENODEV;
>>>                 goto out_unlock;
>>>         }
>>
>> I missed the discussion on this. Doesn't the __nvmf_concat_opt_tokens()
>> already return parameters that indicate to the caller that no controller
>> was found?
>>
> 
> The function I found in the repo returns nothing, is that the one you
> are referring to ?
> 
> static void __nvmf_concat_opt_tokens(struct seq_file *seq_file)

This is the path that Hannes added for userspace to detect kernel
capabilities. So probably its not appropriate to return an error
here, but rather take care of the original warning instead.

