Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA3CC2BD05
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jun 2024 10:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YctT1yCYHf5fMyFWIF405Mdg/P7R/LzL9pIYuKbHI3g=; b=b4fScRd/iA575oQSffiS3uBvAP
	8DJlvd1eZcbvSG2O7f7vmJTNUUjBQYRPo6BysgHtyvBgzh8L5TD8Z7ZDEvia9bhnfdqky41qpUAR5
	wuDqH1PmoOf5bXa7llBvzFnj+9L4owsbBoW0uff5hWGGYfrC0h8NNnmUlbmm8t5/0yF3v13yHKxox
	egXJny40icDRU4rHe+Cjh0RKxjXlArKcQzSdorNfh5yY496hpMDXbA6JJKn6TNytxVP/L+3Yc/RWQ
	VwnmT5ITERFZx1Bi2G3riW6dqtfR6rBETmM/gtkVrHmbLh9zMsCm46/3pkhyj83nY1v6JtMEahkCG
	Lg/mHH+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLgb7-0000000GMdE-3d6I;
	Mon, 24 Jun 2024 10:06:53 +0000
Received: from mail-lf1-f50.google.com ([209.85.167.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLgb4-0000000GMbx-3p6S
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jun 2024 10:06:52 +0000
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52cdf4e33c7so166302e87.3
        for <linux-nvme@lists.infradead.org>; Mon, 24 Jun 2024 03:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719223609; x=1719828409;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YctT1yCYHf5fMyFWIF405Mdg/P7R/LzL9pIYuKbHI3g=;
        b=LSpQ64mOaoUGHfloFsUcSZ9fxAoSCfkx+cqu/HN+5ts0rwGPApzquF+KKKCOXz0kKP
         FnMzsdHpHyywCeo23/sqiMD+Ni0FQbsLO90dLyU42pGyJKOoCHMDnslmwx353KrmY7+K
         O44rWD0tU58cnn7kv9eHIpRw442wHSv8kk+dqUfJubP3Jb+/uTqp2pTeEC3n2szXRLJy
         Lps+oWEcgM0JiuCbE+jh5/EsCuEsVG4NDKpR02NvHZpxHng8wTBzESnFzi8hlT4R+4RO
         Vj4HxMqrdP8F4kEZC5f2G00iN6GI8D9RhoBUA6DxZ0WW6C7/g0jGfe6e8h6EWBOZH7CX
         WBLw==
X-Forwarded-Encrypted: i=1; AJvYcCUHiouUPThNVNRn0VFLE99KlvNLOWf7B0CbkiOWwEDASp/hiVsQmKc0B/lX6vMqd74W+kvvc0akZseWO95h41TIR3avMGb+lBklaHYjJJQ=
X-Gm-Message-State: AOJu0YyybQzvNrOC0yToGe9rNnn55ZpJpd9l+pLLVF+sGLsUQ1Jf5Awh
	vWwPu0YCEfFQdPDAM6bAriYeejcph3LogaQ8wS7cUprcGlKlFG6CnnRuKQ==
X-Google-Smtp-Source: AGHT+IHmlM8H2k/cVrVpptV7kP+mrbif7otgvcvNDViBon4LSyzGvnxaRV2woM9QIsLFwXkElFDOIQ==
X-Received: by 2002:a05:6512:4018:b0:52c:af45:ed99 with SMTP id 2adb3069b0e04-52cdea4c7d0mr4383805e87.0.1719223608987;
        Mon, 24 Jun 2024 03:06:48 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3663a2f9924sm9600142f8f.72.2024.06.24.03.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 03:06:48 -0700 (PDT)
Message-ID: <50a62d8e-b45e-4ae0-81dc-f12c46a5a65b@grimberg.me>
Date: Mon, 24 Jun 2024 13:06:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] nvme-core: add a function to submit a cancel command
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@meta.com, hare@kernel.org, emilne@redhat.com, jmeneghi@redhat.com,
 linux-nvme@lists.infradead.org
References: <20240510163026.786898-1-mlombard@redhat.com>
 <20240510163026.786898-3-mlombard@redhat.com>
 <3d2dc04f-86ee-4802-98f7-fc948e813ac0@grimberg.me>
 <CAFL455=srQgXzME72mihwaRJ0P4nNfC7VWn8HLAEbdx6o6Jawg@mail.gmail.com>
 <CAFL455mu9gW4T72KkC8D--CxgLMapde5DqrzwrEhvfvnCgrcbA@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAFL455mu9gW4T72KkC8D--CxgLMapde5DqrzwrEhvfvnCgrcbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_030650_967238_D90FCDB3 
X-CRM114-Status: UNSURE (   7.52  )
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



On 20/06/2024 16:01, Maurizio Lombardi wrote:
> čt 20. 6. 2024 v 10:31 odesílatel Maurizio Lombardi
> <mlombard@redhat.com> napsal:
>> if we reach "cancel_limit" we can always fallback to a controller
>> reset.
> ... or wait for it to free up a slot, like nvme-pci does.

I think that the approach to have 2 is probably sufficient (one is a direct
cancel and one is cancel-all).

If we find that people need more, we may consider adding sysctl for it
or something...

