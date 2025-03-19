Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECD4C35FFA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Mar 2025 16:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+CxAcNeItNgRHw+6R9MixJ9jJKAhVJkbqm0TieMIIcs=; b=BoMaTg+4A7XG1BWC1x3PI/5v+k
	sMA7xmuQCW+Yekfpt3Ls3CAo7s1Iq9F/Lx6uoL+lCfBTKOVJ3DY5U/Afmxg8Z3trSC/Xl5VPSe7Qw
	TD+KA6xFUQ4fPcvQcI3ipAVBZWsLPsP/+kmN0Pma8Lm68RSHev1afoxhC3jaixkaYm9ygN5E27A4u
	jtKce8iicpxjPiRcaEqSnIPg13kBreR1EEJRxM+92hloZYToGLLG3zhrQuuexa+a263FodF6MQjQg
	6KdOhqK/3uyyNlFiitov7vpRSm0GBTlz5UBjVijl0hZ5IBHtbzU3vvWea2iGqLcMM2CQuJ2SuZxtJ
	OSUGZTSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuwNG-00000009Z7z-19g5;
	Wed, 19 Mar 2025 16:34:34 +0000
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuwNC-00000009Z6w-2EgF
	for linux-nvme@lists.infradead.org;
	Wed, 19 Mar 2025 16:34:32 +0000
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5e614da8615so1741378a12.1
        for <linux-nvme@lists.infradead.org>; Wed, 19 Mar 2025 09:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742402068; x=1743006868; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+CxAcNeItNgRHw+6R9MixJ9jJKAhVJkbqm0TieMIIcs=;
        b=NkTM/NjqAx1gid3JxL0YqxNYmXPFo6na5J9Ls3KcUkR7oPBkxs12Dl/SUfVKri9kUY
         s2Y6zwrOuUMbNCbdyaYA+KdmlTCYZNyLEHZAvwnUdBGfz60Ngrno8xIEHCdlUcn1WrmF
         8XMPLSRhZYSJlAJ3fC2uANZ3AnrEcT2MtP8CM9Ksft2kHJXS3gAdZrqA2qk8y0ocZU6X
         5pVx5RfaiXozmGAmtNQ51F3L/unR2WYLVI2qTXXfiCqH6CAaWQoeEgLrS1HFYPj6Ry2O
         ckFT8ucJdTOhaBPaM9ydGtHNYhtpuEQqBD5j/bWvPUAw8uSLJ1oJrPfyw6QEZXxDI2EO
         AedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742402068; x=1743006868;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+CxAcNeItNgRHw+6R9MixJ9jJKAhVJkbqm0TieMIIcs=;
        b=A6gd5ERz6oXYBheE7eXuLe564jL2QStDU8H2jyEMXY2QdM1mtXcL24kt8rcU/i9867
         D9sBWZIAFBO4B32tQQgXou2sX816P2HQO3ECksUdMTMnGs2AySRP2hvLIebmgZe4cugI
         zFT6w3ZtFcfnPa05Qwbo9BTyLXy7zWq+9D/5CsyPoepVVyQlTJhVCs+6iLvn25ROL0v2
         BCvYZBF6ym+b7b1deKWV9UjLtBAUNsLbRXfYrDgWThAvwW7tfyTShdHyDFNNskxGe9Tc
         17qk1TWHVWGXU9IOZiP+YU1wK/voWFHsx1dhkQBJrVhv2ezp/epz53L+FMJVIkWk2YF6
         y7Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUghVelhwwwL7I4EvxEDCQcHIWIeRkvAFJMb0rwsW076r5r29aZptzT/OztTbDdc9MFyKZSPsT9mAwX@lists.infradead.org
X-Gm-Message-State: AOJu0YxjWa8QWSz2gD+ggX5K3U8Jg0lXUtOmjuzEERKMDGCvZN0FZmMB
	YFs21YABAwUT3p2Kf+/ZtscJxcN+j4/F8AqQqdzzs4EU6QVk9wtlQy7QXfGPH84=
X-Gm-Gg: ASbGnctOMHeMrY79Q5HoRcqjB6xLTT75xKhoIBrrOMqbN1UO+ZiLwERG90rRVewz+sF
	L3q/JzppUFbzidZokh4nIh5U54cF3x5k/j6/H2AAnfLrvjrkDvyqCmsYHob/U3e/k4jry4HvQDj
	sweEBEHHABoSR8gEM2tP7MVQyaoNZquWORXVDXrv5bzbe1vUJ27DH4zlFX6mJN8z7cr8uiqwcvD
	w2MOBJPip3v0rApZ6lkOQyeQNUNLE7y5mRTbDaxZ0FpGnQWYi4pPp7A9BuwcIGEhBT+isXa1+LE
	NAPgHwWOPWHhU9D2NTpLZDxzLHSW8HlsqmU4lJYiEucjfQQiHitcY/rvziA/EMd+IJIMXW+5qBA
	LARE65Ww=
X-Google-Smtp-Source: AGHT+IEjZhPDC9JVGHvBSu0G4bsjIRJ/jfFk3xfcr9ZDEkkV+RNoKj0oTQdj7JCnbnHbtcMPXmrIPg==
X-Received: by 2002:a05:6402:35ca:b0:5e5:ba3e:aaf6 with SMTP id 4fb4d7f45d1cf-5eb99741ec5mr112425a12.1.1742402068072;
        Wed, 19 Mar 2025 09:34:28 -0700 (PDT)
Received: from ?IPV6:2001:a61:2b12:fe01:4392:1ae2:7b50:54d7? ([2001:a61:2b12:fe01:4392:1ae2:7b50:54d7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816ad3921sm9617593a12.61.2025.03.19.09.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 09:34:27 -0700 (PDT)
Message-ID: <14e2779b-779e-4b91-bc6f-896c5dd6821e@suse.com>
Date: Wed, 19 Mar 2025 17:34:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/1] C2HTermReq support for nvmet-tcp
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: sagi@grimberg.me, mlombard@bsdbackstore.eu,
 linux-nvme@lists.infradead.org, kbusch@meta.com
References: <20250319162449.342649-1-mlombard@redhat.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20250319162449.342649-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_093430_568015_8AE79F9A 
X-CRM114-Status: GOOD (  18.27  )
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

On 3/19/25 17:24, Maurizio Lombardi wrote:
> Hello Hannes,
> 
> this patch adds support for C2HTermReq in
> nvmet-tcp as you proposed here:
> https://lore.kernel.org/linux-nvme/91041933-6a18-490c-8090-4e03d15d3cf3@suse.de/
> 
> Now, the question is how to make it possible to write a blktest script
> to test this feature.
> 
> I am thinking of adding a function to drivers/nvme/host/fault_inject.c
> that corrupts the digest in random packets to trigger a digest
> error in the target driver, so the latter will send
> a C2HTermReq PDU back to the host.
> Does that sounds like a good idea?
> 
> Maurizio Lombardi (1):
>    nvmet-tcp: add support for C2HTermReq
> 
>   drivers/nvme/target/tcp.c | 70 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 70 insertions(+)
> 
Hmm. It should be possible to have a debugfs attribute to always fail 
digest comparison, that should trigger it, no?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

