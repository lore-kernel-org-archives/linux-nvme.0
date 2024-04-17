Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A38C4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Apr 2024 14:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cmhdd80IBGtBHBQ7EX1O8318OPiIAICrYzzkPRT7Ilc=; b=vyTsGIdTyt/q6XTYebS0vcBeOx
	OJMUcXFE9VDfNJ+gQEJLqr6rlCC3cDinyH+a79wB/bocb0865CGIM2bh19th2PkuKtSqMFdmrbaWj
	HdeIkpv70sDzQQ2SEoQkVtlb4HbxfMcRB6BhtQXCacP8LryoINxzBR3+mUgBx09uHf27csIk0PBKi
	+OegIzf7r4zJ4ZAAsY7F9u5fDJq1vN2b+OnoQEkNIp7Xi7E8aYFnkgM0e0iMSCv+CLnQ5VM8fdVP1
	IQ/obCf/aDZlT4qTQx/sS4bW01JAruN9rj89YolT5ml/IkldZvbv2QqIL28EVzAdKkcTSXdLMHsbF
	Oirk6wyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx6iy-0000000GSxu-3kbG;
	Wed, 17 Apr 2024 14:57:24 +0000
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx6iu-0000000GSwn-35te
	for linux-nvme@lists.infradead.org;
	Wed, 17 Apr 2024 14:57:23 +0000
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7d9c78d7f98so11745739f.2
        for <linux-nvme@lists.infradead.org>; Wed, 17 Apr 2024 07:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713365833; x=1713970633; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cmhdd80IBGtBHBQ7EX1O8318OPiIAICrYzzkPRT7Ilc=;
        b=mhWFxlBaASGY0q9f7XrahoFdl6tivj7CrP/2FwEFjGuY+zCe0YJxdBcl1cdoYH9hl3
         XNROwIsyDEfWg69n+0+YxvVtzDH4kAC2Ufxt66Zzw1M+UVWr8+1e1EBR8hB1cFH0QOQs
         rRFVfOkFtYPsfNzK/nvr3HiIXCqMeAUSkdF6O7wkJB/40ugid5OhLt7Z7MQ3WVVzy6dR
         NBKiNGcyGigX3D+MqRSaG5ZYDKGalbhseqBmTA28Cy/+C4Ed8nRK08hbTZ5RMVdwbRSd
         yuwNDiNplMT+nM4/L6eqhJ+d1VNWOVoKfIG21fMHysOEyvuwXg2YBc6/sdd08A2IMmVd
         T1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713365833; x=1713970633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmhdd80IBGtBHBQ7EX1O8318OPiIAICrYzzkPRT7Ilc=;
        b=boKG/1zS9SXTdKDog8z8HffO8nhjjs+ZVSabAjweIcG8EjbZUh+jlGQmSMNW4KsLHZ
         FWNNoXaDwl4HPp/NPBlRQ7eQbb16xZBVvrah7d6EVu2LLaujN0Bx1/tNZ6V8v5vpuPbJ
         hRLRqyM1mrQNI3G/WELL/0PpbtzLbtfdnL1D+QxaacB+DF3mTCR/L7b5CpKh4FAhNDFK
         vr8ub5Q2vB9fNFf5Mzu5eaV20mv8fx74h3gCayXrCAXyudg+ZT3b8uUNSeA5ljvdEv2j
         t32La6KzMmeMWX39SP+5jAzY9eFe9TdZmupFuANYi/XlSM2TdhM4HPY5eP4NTcvX3RN+
         mhsw==
X-Forwarded-Encrypted: i=1; AJvYcCXUWUzgo4ZTJ5ivhGCpYsz6qEFLLVfmU11JieyDcEjWmJdDiPkV6R/7olZZBvlID7OXyyVWXkRN2ZHjd/ekkJv8OWs2GwVvL4R9QuwzvfU=
X-Gm-Message-State: AOJu0YyC7pO0EeEseURN20uD4ME3vse0rUEbA7FPN17tWsBf+ksvBhfl
	FV9DeB+DEHSvYEQEAEEXs4Y3gexYkMv0+DWM5RIb2si8PndF1t7Ka34z39y0qvc=
X-Google-Smtp-Source: AGHT+IHgm43XJCf4NkhM+KyTD3XqvSl1d0osmjcGTg6fjXFwuQ6DC5qRoPycs0GHHCBhTfBB0832Ng==
X-Received: by 2002:a05:6e02:1563:b0:36b:3c29:8d19 with SMTP id k3-20020a056e02156300b0036b3c298d19mr152737ilu.3.1713365832757;
        Wed, 17 Apr 2024 07:57:12 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id q15-20020a056e0220ef00b0036afb9a1cc9sm3749148ilv.5.2024.04.17.07.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 07:57:12 -0700 (PDT)
Message-ID: <57262e48-628c-43df-8365-80763d9c2d3d@kernel.dk>
Date: Wed, 17 Apr 2024 08:57:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme-cli spdk plugin
Content-Language: en-US
To: Jim <jim@thebergstens.com>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Tomasz Zawadzki <tomasz.zawadzki@intel.com>, Sagi Grimberg
 <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
References: <7a926cbb-51f9-4e03-b737-b4434b1270dd@kernel.dk>
 <7C454EEA-9E92-4794-B887-738884FCEEF0@thebergstens.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <7C454EEA-9E92-4794-B887-738884FCEEF0@thebergstens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240417_075720_796488_FD24D359 
X-CRM114-Status: UNSURE (   5.93  )
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

On 4/17/24 8:39 AM, Jim wrote:
> This, right here, folks is why I’m glad I’m retired.

Thanks for your useful commentary.

-- 
Jens Axboe



