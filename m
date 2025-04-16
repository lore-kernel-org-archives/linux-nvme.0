Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FAAC369C2
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 22:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=urTlDNi6wNlnDQZcAqCrbf5dwpRtrlP5FbhK2ehxjWc=; b=Fx+IqyfF0PfeFj70EYUD8UM2Ze
	8yHLAt3wL+0DwCXY4Df4HH+dHjruw9w04ynKjdKVL+pKF3+HOi8539caMEOEhVlfpu542hINXJNq/
	gpmdWjpnAEHqyo8N3Avp5H/tTaPolw1WnoUjG0yYFPqm62SpebQceWBXMuktuAhfZa9uthLZwINJ9
	whepaKQZnKlIrSAtf34/o6+jiQ5ffUrwFHdekY41xuPBFFXdTz9x5G7ohhqsNYnQrM8nrNTX7MXTQ
	p52kj9mkFg/JCldMTLF5I6aaVXqhagRiTf8pkiq+OyfgXjWI42Rl0ixFdJX5jCFNbFKt1regaftvZ
	zcD8w94A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5B2Q-0000000B1Wr-3cIf;
	Wed, 16 Apr 2025 22:15:22 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5B2O-0000000B1WN-0yWl
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 22:15:21 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso1009215e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 16 Apr 2025 15:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744841718; x=1745446518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=urTlDNi6wNlnDQZcAqCrbf5dwpRtrlP5FbhK2ehxjWc=;
        b=UGZiFS/LQTRhuvgGQHhTpGppz9u5MLc35vHtCvAeKL+VRst8U3FJ+R9vO6f4mvXAeY
         cKPo9VySP70wGf/tk5WUOsQFo75xftqa7qR9PiU8AQST+5M1sFw/r2qUXeHmUud4aQ9P
         oAjyuZ47U+h7sJhv4Gw6fmm8+6KhpkvA1gzH2P666d5lHs5ZEQPBZHeJ9wzZdnQi4CPf
         4ueMMTIcNWPLSYQkGtQAYYg3U89pG3vPDz8b8K0yQaplXVQABjvsoIO5sdamUX6djL8w
         bdF1Ia/njxu2Z3ex58s8SIQrK4ZHlmscyaV6RuB0ZLwdYTpZhZKv39Q7VNMBwyi1D/ex
         STDg==
X-Forwarded-Encrypted: i=1; AJvYcCVJRwF6JAMNpbiFyaaan2I+q86bhqIlRJNvGXoIDHUoHWwuxrzTPI3H4Ew53LNA5mJ6NkBMCP2aRCVH@lists.infradead.org
X-Gm-Message-State: AOJu0YzQvdN4VDYGXGcGdrS0zhS1rczpzAaWz/J2h+4ldQlQhYku9jkU
	Z2qrA5ULh1FdnPwkJNze2APD9PVUZygNf0EOFTI8lIbPZgsgJPYt
X-Gm-Gg: ASbGncupoMdoWhw82M0lB9ZD68x3d0pPcEMHlUqwmfvmdjldRn+H1OCnvkuFGkMDzUW
	z4rYvPZxtATBjP9OmHTUb/Vy97pRLxCR5cnLavRb2BwoIUU2zFpnZUi0Y2rIsY8+WWgsWBxRElb
	sgyhgH5rJr1w89ocfqzuxOaNas+h8ppNWMnfdskzlTQc1gRpLwtutrdQb7nmFk90/CnIU+HW1lf
	Xi5y3xUURtvLMRys57YLLeUKwHhSH7763fzHqeekeW2Y4TiiJZv9EGDOttAPCLSIW0l828jtpl8
	6iP2JczPlco0YvNzyj0DfdwFnNIX56hgg7+f9PimtlAecyINnYwFNvyWW3xBciS4adjyBUpCWBf
	y5+UBYCk=
X-Google-Smtp-Source: AGHT+IEouzx8PT34zhwgAamNvnQSIVYaNgoDyTEr2XAiwMCGDWCjNdamH+nXhtp8UCoea2oUza6dmw==
X-Received: by 2002:a05:600c:384b:b0:43c:f629:66f4 with SMTP id 5b1f17b1804b1-4405d5bdf96mr37147625e9.0.1744841718089;
        Wed, 16 Apr 2025 15:15:18 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b4f25bbsm33081345e9.17.2025.04.16.15.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 15:15:17 -0700 (PDT)
Message-ID: <945f4ee5-3d9b-4c4c-8d45-ec493a9dcb4c@grimberg.me>
Date: Thu, 17 Apr 2025 01:15:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
To: Randy Jennings <randyj@purestorage.com>
Cc: Daniel Wagner <dwagner@suse.de>,
 Mohamed Khalfella <mkhalfella@purestorage.com>,
 Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 John Meneghini <jmeneghi@redhat.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250324-tp4129-v1-0-95a747b4c33b@kernel.org>
 <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
 <20250410085137.GE1868505-mkhalfella@purestorage.com>
 <738a41ca-3e4a-48df-9424-2950e6efc082@grimberg.me>
 <4cd2cbb4-95ff-4f3b-b33b-9c066147d12b@flourine.local>
 <4c334216-74d7-4a30-add1-67b6e023d8d2@grimberg.me>
 <CAPpK+O0tmewK7pH458TOxjtimjO9on=4YDRFbS=FPTgM+KFTzQ@mail.gmail.com>
 <8ac6cc96-8877-4ddc-b57a-2a096f446a4c@grimberg.me>
 <CAPpK+O2SBm6-zqbiDbUB0yubVTvTrXWn1R+GAPne_+LGvVXp6g@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAPpK+O2SBm6-zqbiDbUB0yubVTvTrXWn1R+GAPne_+LGvVXp6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250416_151520_282553_2BC43B1A 
X-CRM114-Status: GOOD (  11.41  )
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


>> CQT comes from the controller, and if it is high, it effectively means
>> that the
>> controller cannot handle faster failover reliably. So I think we should
>> leave it
>> as is. It is the vendor problem.
> Okay, that is one way to approach it.  However, because of the hung
> task issue, we would be allowing the vendor to panic the initiator
> with a hung task.  Until CCR, and without implementing other checks
> (for events which might not happen), this hung task would happen on
> every messy disconnect with that vendor/array.

Its kind of pick your poison situation I guess.
We can log an error for controllers that expose overly long CQT...

Not sure we'll see a hung task here tho, its not like there is a kthread 
blocking
on this, its a delayed work so I think the watchdog won't complain about 
it...

