Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3CED3C92D
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2024 21:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/g9u9r+Oc3PrzXWPXDpTiinuWcr6pRGL0B1NNC3P9YU=; b=ZiKgd4g5XTdK1cdGeFB4WvTXEc
	1/uTs9R8EcTtG60Zn4aLUqpLYRF79+zI1PZC5RnKQqdiEeFeCK57XMvpBpMinuXmbrNjhf+Kx7+z4
	HojN6mQGPAwy0mKhh9XjS0/wkNJbDz0Sv6KJpliEUE6Aa8qb+isNIU6fg+95nQXKK7Uo9rYwmn67y
	YVerUHPvsOcuPOa1VaFJ2ZMA3DThoGI3JZ06NJSstfQweCLkpf2DEV5JFFw5bc35QI7XyOYd7T6VF
	ncMpp9Z6ODsrW+ovbD/nHbJgExnovEgwVJ0T82m25RExpR5YbO/wwv6JyjpoSJiUgT6RbXbopHpDc
	EQRdDaxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2dpx-00000005VuL-2lYg;
	Sun, 20 Oct 2024 21:51:45 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2dpu-00000005Vtv-4AZJ
	for linux-nvme@lists.infradead.org;
	Sun, 20 Oct 2024 21:51:44 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so3799805f8f.2
        for <linux-nvme@lists.infradead.org>; Sun, 20 Oct 2024 14:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729461101; x=1730065901;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/g9u9r+Oc3PrzXWPXDpTiinuWcr6pRGL0B1NNC3P9YU=;
        b=m8CvTKdD5vAKIjG2TPITprwEWhDTlanrwPwOWN8c0dOjksX4jydGwkpKRk16pe/1uY
         TBjXqJrLGnh4Lre5wdwd798LoVgd3xuwoX4yiRhoN0KHrOMSKIdwpW++NKBMMVMyrKJk
         /2hLOpQ45lCbC/wpsc1DAqjjm8vs9ve6AG1Hhq+EjdZrv2hdmEt/z0h8TzL0PAsnQsmL
         3K5Y5lQ0kqif2B/npVTV5ArxjTluNUNnfBUrZDFVZillBTXMK97ysAEpUPr/5fa7s28l
         lSDZcKNc/77f40N0kfBlLdp+6tJtANU5MjORXb5tBBLh947n4MKR/d6bCRTSi4VN+KfG
         q0Rw==
X-Gm-Message-State: AOJu0YzmNBJ3Hc54ijsP4BKOxhTAf6Tz1PD7XZs3GH2GOsAp7O20mg9L
	X+eLbSmifiqfOpZd8oXHvCtQx6muUNT755FogO+ZSUHHTOBwYFb4
X-Google-Smtp-Source: AGHT+IF4qHh/xeL+l9Kt+/VddCUf0iB0gSLRbeE2xhTaGZIokeXrb5iPpl1HTqFD0N+O41mDin08Yw==
X-Received: by 2002:a5d:468d:0:b0:37d:4cf9:e08b with SMTP id ffacd0b85a97d-37eab4d1253mr8833230f8f.31.1729461101035;
        Sun, 20 Oct 2024 14:51:41 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a37b71sm2653909f8f.14.2024.10.20.14.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 14:51:40 -0700 (PDT)
Message-ID: <14a85dd6-87ac-454d-9429-4142cd0ce9ff@grimberg.me>
Date: Mon, 21 Oct 2024 00:51:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] nvme: system fault while shutting down fabric
 controller
To: Keith Busch <kbusch@kernel.org>, Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, axboe@fb.com,
 chaitanyak@nvidia.com, dlemoal@kernel.org, gjoyce@linux.ibm.com
References: <20241016030339.54029-1-nilay@linux.ibm.com>
 <ZxFSkNI2p65ucTB5@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZxFSkNI2p65ucTB5@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_145143_141639_37A2FEF0 
X-CRM114-Status: GOOD (  11.16  )
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




On 17/10/2024 21:08, Keith Busch wrote:
> On Wed, Oct 16, 2024 at 08:33:13AM +0530, Nilay Shroff wrote:
>> We observed a kernel task hang up and a kernel crash while shutting down
>> NVMe fabric controller. These issues were observed while running blktest
>> nvme/037. The first two patches in this series address issues encountered
>> while running this test. The third patch in the series is an attempt to
>> use helper nvme_ctrl_state for accessing NVMe controller state.
>>
>> We intermittently observe the blow kernel task hang while running the
>> blktest nvme/037. This test setup NVMeOF passthru controller using loop
>> target, connect to it and then immediately terminate/cleanup the
>> connection.
> Thanks, applied to nvme-6.12.

ugh.. looks like I'm late (after a too long of a delay... I know)

I think we want to sort this out, it is not clear to me that the approach
taken is the correct one.

