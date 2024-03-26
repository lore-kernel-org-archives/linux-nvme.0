Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A4DC6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 15:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gKYzTkBq29JWn9vbtRe7cFqGTmVoYmuCk2kjNnF1OS8=; b=MyQ0OV7GUWrjwlUWuWYXQjafgv
	BNOjGEJsNBdJE9b0zlIexLbTHRwh5P7Q/BNluZ1OaIXCNQy667mUmy66X9ByWC1NEgjdBWR0G3Mh6
	0VSa7Z1XgIGOqGIR3eTDo8imFaAVr2m77BhQtzKpLBmxsC5jCG70xXDSyM6Sxu9XuGZtcd4mTlIaH
	dxIA/rQwQktQqt2umzbWRT6UDeqJxKaowOKBeP1cKP9TMuwPzNQPm45LohtAMN2Bp5hHOgotER/PR
	3enfIp/KRZJjrvqr6KZcUpfgdHANEQnS9Zbk6L+mgygDkQWqOtSzU0MskCf4f08M8SjNxYHhdDNAs
	cbVLbunw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp9Az-00000005LeB-3pNm;
	Tue, 26 Mar 2024 15:57:26 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp9At-00000005LWm-3E2U
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 15:57:21 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1e0f0398553so7359035ad.3
        for <linux-nvme@lists.infradead.org>; Tue, 26 Mar 2024 08:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711468626; x=1712073426; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gKYzTkBq29JWn9vbtRe7cFqGTmVoYmuCk2kjNnF1OS8=;
        b=Pi0pwFC3+iun405FkrcRqfteipkNGk+wjrF9IzCFt5+DP5HLqC9EknwynNrAfVGNcW
         Al5v16F0MRn7OGWBM6PXNl29lJqWbebZ5OhCfJ0/n3CAnFMThTxJT7I02bOq+M7zJc6o
         DFMpv5YIBBPOmfKS3d1EA6VbloZgfvfm/mkqlSHlLuXQzTRQdGkQNOcd6huZKlepTa2v
         +Y6hl2tSo+Tp3IitYKuW2CtLK5nMTCMmwE54NzwO1rCRVXrSyHIgsQGuIqIcGkInbz+b
         BxrkpiKvkwJM76ks1DccHGVvtnWA/9oDd0oJCRunKwkp/1xP6EVsr87nLoBnFOoIO/ND
         pGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711468626; x=1712073426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gKYzTkBq29JWn9vbtRe7cFqGTmVoYmuCk2kjNnF1OS8=;
        b=tb2M0L+bHjhOdKnd+fpbOF9hLTFBJLUVxtHu4eN26gQ1OeFr5Q/ltP6227OyCystpE
         PSf1fKL6+n1lXc4iyMM6mgy7VcR2slcQkinUQ1h8sHk+q1eV4/1SmAyh59FRJHVpGDr6
         lmmEWPYAY8iIDiziASwAwMJA0o9KjzFxZZpf9NUdKhRcGGvSEtCwvs7S2vpSgvTmFVTx
         Hpy6LNaCk17aXOW9lU1J1Og5fSBG4e038yXDwhOjwLFHWJY1hvzeBvq+2xfA+1hLgfaP
         s06fPTA10o54M6B3D/dPZdKgbFzdfvJ89vB9tMex7uqOASv7uNz/ErsJtCJBwJBE2E0m
         pOJQ==
X-Gm-Message-State: AOJu0YzVbM61yr4Xw+C71VCrvt0grRr0DLgrteXK+T0rVLdnQ5nObVWd
	rtSeaHGnBn5IeKbdI1wmq5amIme37iQmv4+xAUz6dNgXNG/ZcWTOhpaMF8/S
X-Google-Smtp-Source: AGHT+IEUryvV8VtG5HJjXWAN2u/WS+oVVkgMol7Kv59QjsXIVwLqmvj+LdNZveeQF4KxcIDKoKHXrQ==
X-Received: by 2002:a17:902:e842:b0:1e0:b1a7:4732 with SMTP id t2-20020a170902e84200b001e0b1a74732mr10084274plg.24.1711468625739;
        Tue, 26 Mar 2024 08:57:05 -0700 (PDT)
Received: from [192.168.1.18] (122-222-218-215.tokyo.ap.gmo-isp.jp. [122.222.218.215])
        by smtp.gmail.com with ESMTPSA id f1-20020a170902ce8100b001dd6ebd88b0sm6993654plg.198.2024.03.26.08.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 08:56:45 -0700 (PDT)
Message-ID: <cf8d2f4e-8259-4625-ab05-84e2669a5238@gmail.com>
Date: Wed, 27 Mar 2024 00:54:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: initialize identify ns data to NULL
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20240325154503.11510-1-ikegami.t@gmail.com>
 <ZgLro-TUD821wu16@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <ZgLro-TUD821wu16@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_085719_869852_B3E27D18 
X-CRM114-Status: GOOD (  11.51  )
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

Okay I see. The nvme_identify_ns_nvm() version only sets the memory 
allocated to the output parameter nvmp before the return success so if 
the nvme_identify_ns() also changed as same the NULL initialization 
works correctly. Thank you.

On 2024/03/27 0:37, Keith Busch wrote:
> On Tue, Mar 26, 2024 at 12:45:03AM +0900, Tokunori Ikegami wrote:
>>   static int ns_head_update_nuse(struct nvme_ns_head *head)
>>   {
>> -	struct nvme_id_ns *id;
>> +	struct nvme_id_ns *id = NULL;
>>   	struct nvme_ns *ns;
>>   	int srcu_idx, ret = -EWOULDBLOCK;
> This is a redundant setting. The first thing that happens to "id" is
> reference passed to nvme_identify_ns, and the first thing it does is
> this:
>
> 	*id = kmalloc(sizeof(**id), GFP_KERNEL);
>
> So either kmalloc succeeds and overwrites your NULL setting, or malloc
> fails and sets it to NULL again.

