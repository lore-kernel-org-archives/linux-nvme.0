Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E21FC47DA9
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 10:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lmb621TIy0JJC199Ujr64g3PsFLKCNs+H6ZUZsUM9YI=; b=ujgmTkkitK9+tvbycT0rm3xPvp
	MYd80lFcks5ghVHffJsV2EOxJsrE0FiAP+jRgoN6WylEA606editnbS2SmWWc3GTarEgHtGyU6Ho2
	U+3VUyJonBVP/7BDFZjhqfF7H1FPc0yIcEo/hTsTapbe8iabYdtwmDTQCBMwzzF/2g6rYDaqeczs7
	ef0JI3QS+Nxqu4HzEjFed+gjwB51BSstbIdUs5PL8rvIwEoNC+9PBCzJsNECoySv6EKEUXkFIMRa+
	+tQ2QzKNc8okbgd076UCSP5bSJFK8dmnSSrwhIwOjgNkg46frH5EZMa+C8jyUALIxTSGdfgn7MRCy
	4pS0XRmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUPCD-0000000CIHx-3oM6;
	Mon, 29 Jan 2024 10:48:57 +0000
Received: from mail-lj1-f174.google.com ([209.85.208.174])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUPCA-0000000CIF8-3KDH
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 10:48:56 +0000
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cd3aea2621so4441951fa.1
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jan 2024 02:48:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706525331; x=1707130131;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lmb621TIy0JJC199Ujr64g3PsFLKCNs+H6ZUZsUM9YI=;
        b=UhDrZSagkVgpv1FFFiLIfQESx1i4Kee75R4Tax71ZqmlVPkE21NmNnXeqU+AJKSgpJ
         OLWCmyedd59tHo/Rq+k/m4Yq46mCONJAHhVu6+BmHwBFSl2FRWmBQ//riGtHADobI7MI
         iAR6V/vGjElBiUxvvgIh2yCyILL4HWKTnRRQr4tf0n6Z1vdv189VDNPjVE4MCBf/FJI4
         T+JdAv/bx2NhLDj7fxqZ14OuLCz/CdtqsYZaSQxFCxCrG4VMeV8gPwdofyjY3yZcGTIs
         CvfjdJEaQz5pwkH9nVSlsKxO5tWbN/m7VmSqjjSQEOk1BeIud+/NLrrbOM6gkX64EFQ0
         RxxA==
X-Gm-Message-State: AOJu0Yz5CFxAFX05Z64Dk8pkYJwnTZxZbzdMfPRLUSG5MKf1BVI7rBny
	N63PkAtSJ8hkH8oTxIhDzUJRWadHsJtMfXyx+TxSmycmMfB/7D+m
X-Google-Smtp-Source: AGHT+IFIvq5QcjwEWN2P7wx2z8ogqKrXlT4/SqG0PX1Fi3LFGBr8OXq/m8yV/UUhhheo19LJW9VsjA==
X-Received: by 2002:a2e:6101:0:b0:2cf:3247:c12c with SMTP id v1-20020a2e6101000000b002cf3247c12cmr3770919ljb.0.1706525331077;
        Mon, 29 Jan 2024 02:48:51 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d6350000000b0033aeb0afa8fsm3315029wrw.39.2024.01.29.02.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 02:48:50 -0800 (PST)
Message-ID: <c7b2670c-416e-4451-9c29-439595df5213@grimberg.me>
Date: Mon, 29 Jan 2024 12:48:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] nvme: sync the namespace scanning during ctrl start
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, oren@nvidia.com,
 israelr@nvidia.com, dwagner@suse.de, oevron@nvidia.com
References: <20240122145659.5574-1-mgurtovoy@nvidia.com>
 <20240122145659.5574-6-mgurtovoy@nvidia.com> <20240123090231.GD30773@lst.de>
 <f168e3d8-ddec-46cd-a032-2ca771b6cd23@nvidia.com>
 <20240124094832.GA31289@lst.de>
 <1315cf2b-038a-4830-87ac-5ac1fbd5a1e9@nvidia.com>
 <20240125144130.GA18804@lst.de>
 <d8f4c989-00a2-4545-87de-a70da312beff@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <d8f4c989-00a2-4545-87de-a70da312beff@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_024854_891373_2620A2D8 
X-CRM114-Status: GOOD (  15.81  )
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


>>> Even in this case of re-creation we must sync the namespace 
>>> identification.
>>
>> But a format is not a re-creation.
>>
> 
> we currently don't support format in fabrics so maybe I didn't use the 
> correct word during my answer.
> 
> because of the dynamic nature of controllers and namespaces we have the 
> identify ctrl/ns commands in the specification and we need to use them.

ns scanning has been notorious to cause issues when executing with
controller resets. So I don't think it is a good idea to make ctrl start
block until it completes, especially not for an esoteric case that
a ns that suddenly was reformatted between reconnects.

> Re-queue requests to a non identified namespace is bad behavior. It 
> might be even a spec violation (I need to dig into the spec for it 
> probably and try to find some description on that scenario).

It can't be a spec violation, the host cannot know if there is any
aen pending (for example NS_CHANGE) when sending *ANY* command to the
controller.

