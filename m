Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14316C001B0
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Aug 2023 08:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hoap7EnZXwKvf+DQNkeM03/j4vVFE5l4+Md+nWghcNA=; b=thVs36gVRMv8rmyqTRNg+NZ9OR
	dnDnw2DhsajpUznlaZFuT3KQ6uOREHptS+C1FvZNKbE3L1lYZSVU29ocK0tFdHuHb/t0BEG8VOp9l
	ElTGfzCqLNfM+zDhGt7kW4j/9thhyzu/V0Qjgbw7xZp6OuXJHhUQ52J06jCIK+cQOcSBSjx8gnSf/
	j3Cb0CRKNcYYPZDioNdaKzB/mOMMijO0D/ifFwUmesdfktffDfj26yH8Zh0pgFtKgCdUaB8sEnexT
	c+xnMU7QsK7wdYI5kbPspt8mKVgStHzcKeCzo/7xJ/AXt3DVzvGVY6RIlze/1tgmG8W7mNw5Ajpfi
	d9+4BzmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qU0en-006o03-18;
	Thu, 10 Aug 2023 08:04:33 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qU0ek-006nzN-1S
	for linux-nvme@lists.infradead.org;
	Thu, 10 Aug 2023 08:04:31 +0000
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3177b6bd875so140483f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 10 Aug 2023 01:04:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691654668; x=1692259468;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hoap7EnZXwKvf+DQNkeM03/j4vVFE5l4+Md+nWghcNA=;
        b=dFaCdiQ/NfbTV6odkrKt14M1qDkeUKS2pSjb9TbgDP7py4ZqNW5oHmZRmJsldyAP3z
         VVg9INWEKk/JSHa3hjrPe8/CfgVhg7JOfeaCjLhuRucxpUpWofNRoE9eTkYrdQFdaUyy
         KYvQRgthCUzya1WrmNHIqU2ObPN6hMI1caI/tsJKfXWv7SBye2WCR91YPvGy3pZuEGhM
         22Vpc0s6QfvEQ8G3Ac6Jhf8NxQl8WFb4JxeEPWypIcICZfJ9ACMZMnM2EchLCBCQ3cty
         cXqz03Nj7pn/4Yzd4cklwQezoexJkmri3snuw1xrVnapPymGM1vv7wV6Dp42qM2A2LVs
         aPCA==
X-Gm-Message-State: AOJu0YxG112mYShsoCv4Xai/SRWtB/oiX028TVuDO41ddRMMivdPxqSY
	BZVwHWQpTn8KuEPcDM7v8JQ=
X-Google-Smtp-Source: AGHT+IGRkTR1XS9rjV8eKrTs3k84NEkS6tZQCB1hHjw450jVx1yaETm4S4jbbjl+U4ULAlxp7vNovQ==
X-Received: by 2002:a5d:4202:0:b0:317:5de0:8ba8 with SMTP id n2-20020a5d4202000000b003175de08ba8mr1366526wrq.1.1691654668385;
        Thu, 10 Aug 2023 01:04:28 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j13-20020a5d452d000000b003179d7ed4f3sm1303791wra.12.2023.08.10.01.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 01:04:27 -0700 (PDT)
Message-ID: <90d17660-6ca5-e603-cacc-a8c10bb8e874@grimberg.me>
Date: Thu, 10 Aug 2023 11:04:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 15/16] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230808165354.123499-1-hare@suse.de>
 <20230808165354.123499-16-hare@suse.de>
 <e28dffb6-66bd-2724-6c9d-f06e5da75aeb@grimberg.me>
 <2b202cb8-7543-1c2b-4d5c-bbe4822c9e68@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <2b202cb8-7543-1c2b-4d5c-bbe4822c9e68@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_010430_492030_F2EC65A8 
X-CRM114-Status: GOOD (  14.37  )
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


>> On 8/8/23 19:53, Hannes Reinecke wrote:
>>> Add functions to start the TLS handshake upcall when
>>> the TCP TSAS sectype is set to 'tls1.3' and add a config
>>> option NVME_TARGET_TCP_TLS.
>>> And move the 'state' lock to an irq-safe lock as the 'done'
>>> callback from the TLS handshake will be running in interrupt
>>> context.
>>
>> Really.. that is surprising. Can you describe how exactly?
>>
> Ho-hum. Yes, I can, and it seems to be related to my test setup.
> I'm running nvme and nvmet over the loopback interface, and with that
> nvme_tcp_stop_queue() induces a softirq triggering a socket state change
> on the target.
> Which means that nvmet_tcp_schedule_release_queue() is called from 
> softirq, triggering the spin_lock warning.
> Probably warrants a separate patch, though.

If this is driven from the network stack, it should be spin_lock_bh.

And yes, this is a separate patch, and probably with a fixes tag,
and preferably separate from the patch set because this is an
unrelated fix.

