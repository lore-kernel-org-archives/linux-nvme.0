Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3CFC25B75
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 10:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=02gpweHNfk6o1OCbPBEfCdIF01f37RIcxSIg5M42u9A=; b=Z8xkxY/6ZXDznPZ2tJAQKUUjwT
	77lQzJuZHRj8GwSHFWmNQ06tWWhPmuKNQI/qC60YEaGvO7yVdQzKde4+hOUfUrGsVnIRI7iwMCvrl
	MValOPL9FXeDKfxMjwnisPNf5GnjqR9YqLFqwdQmgGK5jgkpyNTdEgChE+OLBc7J62fla9P6bp2AK
	rdgIbPdzPHkyHgnx36m6qJojuiE+BA0VLnUy98LybO4zooyWFnn/e6vrPPQ3EjkXSqFt13pH1ZY3G
	fRziujEXSYIk/mzUjSvEVbw8n+nYPu7ENadubnrfJ5S1C5B9Z2kvfOapdlkdCug5yul6ZzKCeNxat
	6FWb2cJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9Ma6-0000000H41B-2FCp;
	Tue, 21 May 2024 10:18:55 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9MY7-0000000H2Sv-0Wn2
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 10:16:53 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-34cb27f1f2dso101187f8f.2
        for <linux-nvme@lists.infradead.org>; Tue, 21 May 2024 03:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716286537; x=1716891337;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02gpweHNfk6o1OCbPBEfCdIF01f37RIcxSIg5M42u9A=;
        b=ZZdnovRWamWlbX6ZgNCoIH/2ELYGK4bnS4ObNau/8U3u8H86YIVb/wwWnrc1jCNicB
         JNvjq08jKnslA4N5RtikpaAHyqaKxv9/oNK29jpvlJpVv+MK4TGXIOORw54NfuOSPK6P
         G1KTyNlFaOibTeX/pyE7C0h4w1FyYt6+qnorKW1J4QI/EKBki3dMq9FQavvIajyv992g
         FOtxuY3VBR6rpBR09hz8tjZT85K7ldXltJrEePJt7ZPr9sBr2GrjuKWVt0N2LD64VFi+
         nPUfMQ+TmBhNuhANDf1jCDY7wiQcFuVESXkaPBV9VfNZZ5KLHhcapGvxEOtP8TTCsZKW
         RmOg==
X-Gm-Message-State: AOJu0Yx96c0roqPXD1oeM9gjNCOFAv8dCIs/Oh02MQY8RqJZ669Vqdgt
	3YF+RbMTyZtGzEGA0v8eGNRj7bPU3Qc16hsu/cg7tWUDCQPd1DZcU6vHgg==
X-Google-Smtp-Source: AGHT+IF4BXDJznls9ehBgndP4S1CgsuNMagJiUCcK7yhCwY/0ywrmv1mc2ukP92qRRaDBfRtgnvBig==
X-Received: by 2002:a05:6000:184f:b0:354:c5d5:295b with SMTP id ffacd0b85a97d-354c5d52d27mr4580284f8f.2.1716286536869;
        Tue, 21 May 2024 03:15:36 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351d2df8449sm15110023f8f.12.2024.05.21.03.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 03:15:35 -0700 (PDT)
Message-ID: <073ae18a-a80e-4a95-a093-36210a3bb230@grimberg.me>
Date: Tue, 21 May 2024 13:15:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
From: Sagi Grimberg <sagi@grimberg.me>
To: Nilay Shroff <nilay@linux.ibm.com>, John Meneghini <jmeneghi@redhat.com>,
 kbusch@kernel.org, hch@lst.de, emilne@redhat.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com>
 <945416af-3f8b-40b5-9681-49973beb2cb2@linux.ibm.com>
 <3b8d33db-f2c3-469a-bfa0-8fc52594f243@grimberg.me>
 <95fe3168-ec39-4932-b9fc-26484de49191@linux.ibm.com>
 <da35bc8b-6813-42c8-b446-8a07b08db156@grimberg.me>
Content-Language: he-IL, en-US
In-Reply-To: <da35bc8b-6813-42c8-b446-8a07b08db156@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_031651_579000_E5BA78BC 
X-CRM114-Status: UNSURE (   8.91  )
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



On 21/05/2024 13:11, Sagi Grimberg wrote:
>
>>> Don't think this matters because cancellation only happens when we
>>> teardown the controller anyways...
>>>
>> I think in case if we reset the nvme controller then we don't teardown
>> controller, isn't it? In this case we cancel all pending requests, and
>> later restart the controller.
>
> Exactly, nvme_mpath_init_ctrl resets the counter.

Except you're right, the counter reset needs to move to 
nvme_mpath_init_identify()
or some place that is called on every controller reset.

