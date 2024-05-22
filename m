Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB31C25B77
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 10:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n56g6uLn9XHCQVlQi59pqGIFNFw6rViiab33YGUq9tI=; b=i7s1oe6IH/23En59jt+Pz+9+VR
	wM0PZokSuDR558h66SSFOormLL5oShAWj/5VncJVf+BrU1OaRiv8cPahWoUkILur0Gq6nO+j76oRz
	W/ZNyVk6DHV1WhgzWdWCc+fWK3wb2hubAKrriJUXv3mJ5niHsRLMKHjtH4DcKgFeJ6t+c+eLLFFY6
	bZaWqc63BCvcZSH2I44BHdAqTkSLR5WTzcVTlKM8LaKAHgoW8v0KcjNSDCAMvqep61XHfwv0zg1tK
	3eYEHZ1aJunbKGlxettNoHa8xR14rR9KI4NUrpx1pacFUjjQYW4Uoq5tVbAXSG7J4SlrUr3CDR9uD
	m5qBxyKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9jZr-00000002h1d-3ZQi;
	Wed, 22 May 2024 10:52:11 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9jZp-00000002gzH-1npU
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 10:52:11 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-34ef40fae25so180936f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 22 May 2024 03:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716375125; x=1716979925;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n56g6uLn9XHCQVlQi59pqGIFNFw6rViiab33YGUq9tI=;
        b=RQtP7b506rfHoZVt0oKonk1ZIpoJ1nLXjW2ODJ8xOuf9bdogADxfaVsCbLmbTHiXC0
         wTXZoAsply3AXHRh6Cw+tqo2Oeh4q50xnW+CM+5lsjGuEihp+/kGtATkrQnhUdq3K5SZ
         yGpNKhi4JuSg6D1PzCJsBylCRvDnxPdzOJcqH80t7djjMgf+SfpVJyf00L8ACdIgFqtS
         F+l0HSp6fi7syRQW16ES/j+qcWkIIy2qnTWqewaCB4Sc8s3RSHoIC2gS92Xf4x4DFrH8
         p+vFFO9tHrKMlx86gLQS2IXW9fgwue2yR9Z81/z2MPMZW8Ndy+BEsW/Vk/n1qxX65jvZ
         TQKA==
X-Gm-Message-State: AOJu0Yx/5RjjfLyI5YwZBJsoNogPzOaxWmKUV1Modj2CfysQ93F9u0yJ
	C3Vg1EPH1En5f+kYztkQkXJDFRlTukRj7gC0Q9hqXzyhlpV2x/II
X-Google-Smtp-Source: AGHT+IEZJBgVSrF/9DB5H155p+7sN7q4DxBtkVsX5am/DrbLl8psEfn4k669Y88n9u6iZh/wjeiBXA==
X-Received: by 2002:a05:6000:4021:b0:34f:42d5:1897 with SMTP id ffacd0b85a97d-354d8d8de53mr1418462f8f.3.1716375124688;
        Wed, 22 May 2024 03:52:04 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbbf9esm33855151f8f.91.2024.05.22.03.52.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 03:52:04 -0700 (PDT)
Message-ID: <b4302ee2-584d-48b1-b0fe-77035879c15e@grimberg.me>
Date: Wed, 22 May 2024 13:52:03 +0300
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
 <da35bc8b-6813-42c8-b446-8a07b08db156@grimberg.me>
 <073ae18a-a80e-4a95-a093-36210a3bb230@grimberg.me>
 <ba2a6973-ba58-492c-9785-31e50ab40957@grimberg.me>
 <8f5ad047-be0b-471c-a708-f2bc464d29ef@redhat.com>
 <b3ea2812-1110-47f6-88f0-0e9c028c350f@linux.ibm.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b3ea2812-1110-47f6-88f0-0e9c028c350f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_035209_576115_CD004C6B 
X-CRM114-Status: GOOD (  16.25  )
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



On 22/05/2024 13:48, Nilay Shroff wrote:
>
> On 5/21/24 20:14, John Meneghini wrote:
>> On 5/21/24 06:16, Sagi Grimberg wrote:
>>>>> Exactly, nvme_mpath_init_ctrl resets the counter.
>>>> Except you're right, the counter reset needs to move to nvme_mpath_init_identify()
>>>> or some place that is called on every controller reset.
>>> This however raises the question of how much failover/reset tests this patch has seen...
>> I has received quite a bit of testing with failover and controller resets.  I shared some of the testing that was done at LSFMM last week.
>>
>> It has received enough testing to make me confident that this code is safe.  That is: it won't panic, corrupt data, or otherwise do any harm.  We believe the error paths will not be affected by this change... but I agree that running the error paths could negatively impact the accuracy of the nr_active counters... which could lead to an inaccurate outcome with the queue-depth policy.
>>
>> I agree the nr_counter initialize should move to nvme_mpath_init_identify(), or maybe be done there in addition to in nvme_mpath_init_ctrl(). I'm will to make that change now... if that's what people want.  I don't think it would require any extensive retesting.
>>
>> /John
>>
>>
> I think with Keith's recent proposed patch for fixing io accounting on failover, the
> nvme_mpath_end_request() would be called even for cancelled IO and so the nr_active
> counter shall be adjusted correctly for cancelled IO requests. Having said that, IMO
> you shall consider moving initialization of nr_active counter to nvme_mpath_init_identify()
> as that's common function invoked from regular controller initialization code path as well
> the reset code path.

Yes, and preferably with a comment explaining why its there (despite 
having nothing to do with identify...)

