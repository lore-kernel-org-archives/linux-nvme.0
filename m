Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35F0C25B74
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 10:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qW/pTB21gkgRrK+hJF+k9TNP6E/0yI22RXhiZtqv3aM=; b=wEEPra4IU7e7umxfc7uzmclR0G
	J6DZQWtbgKiq9A1tHwLlf7MwIVyiK4UL7lQ8o38K+zGwUucpmbLa6PfDAZVefmCifl82v8rmG+fuR
	Qn8eQjBzUAJPsQYx8nvIqsJZqU9+EDR07ONgzqZMHy3P/qH8ZxqHv2QtYusYRDb1mPFyLbbK0q95a
	PmFe6pRME+NtSKc4zcbtAo9D+Mgi/yKwcxelDoOMhM//SNCh0qi3bxE6+DTjHtL0kol4fKePM1gR1
	ax0D/AO3DENnfDkQpm0Warm6sQoGuH8U60Nv1gXJH8aXwNtM4FKYeZYCUffyPxYsXR3/P8HuG+WOo
	8CaftN2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9MSt-0000000H0nM-2JS5;
	Tue, 21 May 2024 10:11:27 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9MSq-0000000H0mY-1vcQ
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 10:11:25 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-354c84d4604so489619f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 21 May 2024 03:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716286281; x=1716891081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qW/pTB21gkgRrK+hJF+k9TNP6E/0yI22RXhiZtqv3aM=;
        b=fFL5l8vTurFnTVYSNeyRpUQkkgMTMQWT71jUOkCjHXcQuRYSpk2fFQM22oWbMW01Co
         dPg44u4/l94qNvHzEldSsiaT0dFg9lO6OSJFZ07rbjAW+L4x/gIT8W+rX+33hoOVH5v6
         k/nW7rA7F5iGu4rGJE7EK1GsDVaR9yWL2Wsxy8pHX/7lNy3u7yy0W9032SbdaggimW6X
         h7gM5mSl2jCogSqjO+Z3RYZ5MWNI7usLDOxJVsoLNCeBG3YzIQgUkBb3UN5jFh/TpC6Q
         ldaKzm8YqPy3t9TlYcwhe4HfR3ceQxkkNGob+4yWjpTSWSbmTU1aa0oHvrPOQiyA90FQ
         I6Tg==
X-Gm-Message-State: AOJu0YwNKRIm6XR1kTXSVvWHzCWZL959Bgv1DoQPPmk2piLhO5GKw52I
	iBXdfH5J+EnfzdePQp6l77r7cUhVaVj3uIWgT2NRk1sZB7EpGnWyDiLdfw==
X-Google-Smtp-Source: AGHT+IE3wknQTChsi66LlBnMZL0t4LfufqdO8o1Kvxz+hZ2bhhl3LudndZWEz+t/RK1UoNyFsGGqkg==
X-Received: by 2002:a5d:69c5:0:b0:34d:a29d:a8d5 with SMTP id ffacd0b85a97d-3504a96c0d0mr21877968f8f.4.1716286280394;
        Tue, 21 May 2024 03:11:20 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbbf20sm31412435f8f.93.2024.05.21.03.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 03:11:20 -0700 (PDT)
Message-ID: <da35bc8b-6813-42c8-b446-8a07b08db156@grimberg.me>
Date: Tue, 21 May 2024 13:11:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: Nilay Shroff <nilay@linux.ibm.com>, John Meneghini <jmeneghi@redhat.com>,
 kbusch@kernel.org, hch@lst.de, emilne@redhat.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com>
 <945416af-3f8b-40b5-9681-49973beb2cb2@linux.ibm.com>
 <3b8d33db-f2c3-469a-bfa0-8fc52594f243@grimberg.me>
 <95fe3168-ec39-4932-b9fc-26484de49191@linux.ibm.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <95fe3168-ec39-4932-b9fc-26484de49191@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_031124_912998_DF7D380F 
X-CRM114-Status: UNSURE (   7.99  )
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


>> Don't think this matters because cancellation only happens when we
>> teardown the controller anyways...
>>
> I think in case if we reset the nvme controller then we don't teardown
> controller, isn't it? In this case we cancel all pending requests, and
> later restart the controller.

Exactly, nvme_mpath_init_ctrl resets the counter.

