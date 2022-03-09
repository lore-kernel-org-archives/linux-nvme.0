Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0137EC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 22:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=krEU2aav5fOEs4Oaq3uYbNgmZCgHjq70EByBaZwYXis=; b=sHqN+p2+3mBWtoNy6RizN5ZIpy
	ND7ZciR7QOBEJnBtrCMTolbqBMcWA5oQxIlMbUs6bHGayvDxHO83qTcAHRvoCpKYgLJ6B7NVhzwGq
	yiQ2lVN1+OV7wLHTtQyLZ/LNr45BqqOpStPGmMLdcLCRB64dGlbWi2WpPk5737Outd9nIjyt/viWC
	0ie0LSxXiUm3f6zbMjdF01wewgt9TYiHDM+mrqzM+5mS/wVpZghhYA9g4I3TLzqn/gUbhXIKjjdHt
	AXFTC996aMYVZKVovo87TnxIzFmQOVGi6YS0WiaMo4crAzvm5Wb/gt8I5nBt+7vlHwG6T7WjMsGhq
	DVsa29gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nS4p3-00AfcE-Jz; Wed, 09 Mar 2022 22:30:21 +0000
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nS4p0-00AfaQ-PK
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 22:30:20 +0000
Received: by mail-ed1-x52b.google.com with SMTP id s10so4758796edd.0
 for <linux-nvme@lists.infradead.org>; Wed, 09 Mar 2022 14:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=krEU2aav5fOEs4Oaq3uYbNgmZCgHjq70EByBaZwYXis=;
 b=FElSMGq/nzxPH40kPyDlCTcH0QFgMhq7rcyP4yWZ16/rn8Lt7k218kk0iOmXs6kayD
 HnOuCa4f9mlf6PVN+m6a2RX+Cz5VWWEi03M36cgJPT7q0qxDvLocNtJ7UiHv8yfweeG9
 R5Ui+PzDcTniVE+alGysbSVDsH36y/krDeMCpaAk5QjO3DsKApOGvtQ7zfbhUchmpw5N
 /0wxppqJ1u/AO4IPdLAt/xoUjbpBqlidUxP8PLDxBeF6BP9BT/2HFBDa+z11FN6SRfxB
 JJu7//uV3CUjNpebUP6Rw+LQCw3EUEZhlLcboj6r8gUg0r0krECeWtcVO70LP+/Upag7
 LIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=krEU2aav5fOEs4Oaq3uYbNgmZCgHjq70EByBaZwYXis=;
 b=JQ0zhodiKm9M7uvIoCMavRSP4q9TdwfKQL4stVsDTn699hKSweGPu7zZpmuYSEr2RK
 YvfmwAulQCHWVzWJhklsMLuhXMcWBrHkUk89032kr1CDTI2XkHrojVcYNrI4NSfsePo+
 7AyiIuaZZ9/zefikoULJFfuqDJ21GJOLfzzl8ytU4FUPRiJHwSEZKQ04g52z7CkV1REo
 +v9W0D5EQPSQMZ7p7R9fHAGApdvu0aUhrSRgbaGwzfPGXEGn8ahMJRv/IAM+WQOuJH0U
 idl8EkWXqLuLr7GIbv+sVc8D6WBAHyDDNXZ5CdJEthUPS/fcLuyEPLbho1K1nwcok+8t
 1irA==
X-Gm-Message-State: AOAM533hSrDXShK+Y6DUICJDbNf2Sb55wXPhf2sDlQlCVTlB1s3Sqs2a
 4BCi/DZvedjvZfldQJOgoKoZUf76u02+Bw==
X-Google-Smtp-Source: ABdhPJzRpmjTu5SwxwG0kpWB2yWcqLbmrmeWP6Q6PHGnCq5dKOL/6zml+Lknmd+Kjn5Srti63z1CCg==
X-Received: by 2002:a05:6402:11ce:b0:416:7b5a:a1cc with SMTP id
 j14-20020a05640211ce00b004167b5aa1ccmr1546186edw.327.1646865016121; 
 Wed, 09 Mar 2022 14:30:16 -0800 (PST)
Received: from ?IPV6:2a02:1811:cc83:eef0:7bf1:a0f8:a9aa:ac98?
 (ptr-dtfv0pmq82wc9dcpm6w.18120a2.ip6.access.telenet.be.
 [2a02:1811:cc83:eef0:7bf1:a0f8:a9aa:ac98])
 by smtp.gmail.com with ESMTPSA id
 p7-20020aa7cc87000000b00410ee30cefbsm1355949edt.71.2022.03.09.14.30.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Mar 2022 14:30:15 -0800 (PST)
Message-ID: <09c807d0-1aaa-b5c0-65cb-05700059e5d0@gmail.com>
Date: Wed, 9 Mar 2022 23:30:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] nvmet: add missing locks around nvmet_ns_revalidate
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20220309203449.63125-1-dossche.niels@gmail.com>
 <dd679ebd-dba9-219b-20c4-21f0270138da@acm.org>
From: Niels Dossche <dossche.niels@gmail.com>
In-Reply-To: <dd679ebd-dba9-219b-20c4-21f0270138da@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_143018_879585_2FD784D7 
X-CRM114-Status: GOOD (  14.46  )
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

Hi,

On 09/03/2022 23:27, Bart Van Assche wrote:
> On 3/9/22 12:34, Niels Dossche wrote:
>> nvmet_ns_changed states via lockdep that the ns->subsys->lock must be
>> held. The only caller of nvmet_ns_changed which does not acquire that
>> lock is nvmet_ns_revalidate. The only 2 callers of nvmet_ns_revalidate
>> which do not acquire that lock are nvmet_execute_identify_cns_cs_ns and
>> nvmet_execute_identify_ns. Add a lock for around the call to
>> nvmet_ns_revalidate in those 2 functions.
>>
>> Both of those identify functions are called from a common function
>> nvmet_execute_identify, which itself is called indirectly via the
>> req->execute function pointer.
> 
> Please mention in the patch description whether this has been discovered by studying the source code or by software (static source code analyzer? runtime data race detector?).

This was discovered by first using a static analyzer and then verifying it by manual inspection of the source code.

> 
> Thanks,
> 
> Bart.

Thanks,
Niels

