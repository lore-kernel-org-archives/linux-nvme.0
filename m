Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B305ACD8CB2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 11:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KWnTRg+mjczQPC1dW7dIXNyJPlDFUHTGB3Kh2mwFLDE=; b=PGwm3X5Ow0C4fv6CPjjToyT3eG
	kMRURU6MlYrlvmW4yVSJdymJIGkyFGomfoTmktlBSzcosl6lPkho5w9UTKFw1Ozp7NHZvEu0+JHqC
	/pBQNTaGZ/2MY7CMVtn8q6EC9aENzHDJhpUR+2LPMShpgdF0bs+MAR0AsbBP5YaNID9ctJ3Uk+H2X
	Ta18PMD9Ejo5MNRPOsEm/1hK7OTfFe1BOA4syPdrsh5chpfUWFakr5Yh/yQ/ggVlLzVRktnq2wtu9
	4gUbnyWGyb/r1246zcWOR5tYZCetnfxrjNDJchpB8u8nvR70voZmwBajN/LFaxLAHMUe54IIz2b4A
	anwe3zng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXGuY-00000007VKE-09Hh;
	Wed, 10 Jun 2026 11:15:54 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXGuU-00000007VIy-2zSn
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 11:15:52 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2c168baac83so31268095ad.2
        for <linux-nvme@lists.infradead.org>; Wed, 10 Jun 2026 04:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781090149; x=1781694949; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KWnTRg+mjczQPC1dW7dIXNyJPlDFUHTGB3Kh2mwFLDE=;
        b=WBXTtnsASWX1aeay/1vuwqDXTtasYgAP3ussoR7bbGJ92GyJdq3slg7b0xrehub8Di
         xwjC8YcoG2bi0Nc1HpDTd3xZCVP5dmszu1wWy6fU2SUk2OAo4jpM4xGImseD0MZj9sau
         G5Q8DMI3IHgWP7UNH5msCsLmO0a9xN3GSUg6FROCchw1UbDj6PAB4OB5KRe0apFCGYSn
         G6zWm80r4J6svvO23OvWfMBMWHQll71TYkLuVw8JZxRtJJOTzWRaj1751TuHfa1dszEs
         hJcxzNYb/cL89HcHG0ZxuobiSflT6dC+OQ5XIzN2nyzvZII7d0X7h2qD5wrZPA2XbxSE
         fGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781090149; x=1781694949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWnTRg+mjczQPC1dW7dIXNyJPlDFUHTGB3Kh2mwFLDE=;
        b=cMmVgz5w5peioFdwy/fvhkQnZsSrdq3IKVTeQ6nwethRswRUgRbw9hkWAQBBg4ZkYd
         CB1Z734Xj3d1Tl21rMVIEr12k2tBLnmYbhL4GMMaKZPN8Q7fR8BnDKwSXytjTMXxq0Pc
         caOSLU+oMzpvO7D/24qcCqu5nFLxly3ANClHnIewr277IVE2/x8tO5JcDkHlJQ2bcond
         uaE6S3/nS3mNdwT81Ptb5qPsBrQvVnmhKbNaTrBZ8iHjguY1yKtl9CGHWc0HohE9V09o
         474TnsXVxdP89WrLtAdReAmmv5q/ccuS2ACdkUI1bW5FOo8wnAoLGvtG34bmC6gAnqaf
         Ie9w==
X-Forwarded-Encrypted: i=1; AFNElJ+dw+J5YwnCiIaVFsK1v8tnfjS2DKal5E+1DDV6/BVxgtUq4fr0y0Xm4MwCXHjy+E4lGMpmAUYQTu3j@lists.infradead.org
X-Gm-Message-State: AOJu0YzE9TOkR0g1ngr04PdqrIxBgAHcc7zYXcUh0+Vz9GctV5yyeytI
	F9u2SHvUraeixB7vMxFEd9OyL6c2kXbveFiWunbUqlysdABkuD+KC/B/r8Qqx0em
X-Gm-Gg: Acq92OE+fNVbGBYAzdsQ0R9vz7FSUO2SmL85i8s8Re7jGXPnjGn6n5vRK3kqHOWSy4d
	jihnYDREJc6cErl5/bTe2bvHMsG2du8NpBp0axp4tzaiCLHsTplQ8O36H8lkNu5C7yTCgW1iKHT
	azeQpuDti3EbS832LnrU2tbx0+43oMHL8CFrG8E40glsqPFNLnMxCtdoThjZGPJCTr8Dd5ql0QJ
	TeSUsKZerCugF7zP0CwebwIOYH55vIlddHs/yzeAIm6so4d02xYHIP5Iit2qov3RrGw0vju07y2
	OCT7hwUF5M3N3xIIsipFHO0pD3pf/byXaz1m8QSD5BtlNoLR7iiXq6H6ONJwq6+302zZWmHJt65
	OVy8odPfNvMstIB3+PEJ4yG2eY6T3l5SJAzDdAtPjydJ96OiD7CiSZB8wjuZIMkndJtXc4L55jG
	weBA+y7Rfc7ETQikOEKqLLGGboaNx2VpJr2OJUmYjRkHCGBNP/LfTg7fia4EYD3w==
X-Received: by 2002:a17:902:e848:b0:2c0:b6c7:2273 with SMTP id d9443c01a7336-2c1e79e29ebmr292674635ad.3.1781090149023;
        Wed, 10 Jun 2026 04:15:49 -0700 (PDT)
Received: from [192.168.1.116] ([223.122.38.120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e234sm251459075ad.53.2026.06.10.04.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 04:15:48 -0700 (PDT)
Message-ID: <4bef16f2-ad9d-4417-ae12-484ffd7a87a9@gmail.com>
Date: Wed, 10 Jun 2026 19:15:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-apple: Only limit admin queue tag space when
 with Linear SQ is present
To: Christoph Hellwig <hch@lst.de>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260606-prevent-tag-collision-t8015-v1-0-93ccf4eca550@gmail.com>
 <20260606-prevent-tag-collision-t8015-v1-1-93ccf4eca550@gmail.com>
 <20260610051146.GA559@lst.de>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20260610051146.GA559@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_041550_752890_70B166B9 
X-CRM114-Status: GOOD (  12.51  )
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


Christoph Hellwig 於 2026/6/10 下午1:11 寫道:
> On Sat, Jun 06, 2026 at 09:25:25PM +0800, Nick Chan wrote:
>> Apple NVMe controllers require tags of pending commands to not be shared
>> across admin and IO queues. However, on Apple A11 without linear SQ, it is
>> not possible for either queue to skip over some tags and must go from 0 to
>> the configured maximum before wrapping around.
>>
>> As a result, in order to prevent tag collision, dynamic tag reservation
>> while a command is in-flight becomes necessary. In this context, there is
>> no reason to limit the admin queue's tag space, as it is not helpful in
>> preventing tag collision.
> I'm not really into these Apple specific, but what does
> "dynamic tag reservation" mean here?

This version is based on an incorrect premise (v2 is correct and already applied)
so feel free to stop reading.

In this version, the incorrect premise is that it was not possible for either queue
to skip over tags and must go from 0 to the configured the maximum. 

Under this premise, the only way to prevent collision is to set a bitfield indicating
which tags are in use when submitting a command ("dynamic tag reservation").
If a tag is already found to be used when submitting a command, return
BLK_STS_RESOURCE so the caller retries later.

Best regards,
Nick Chan



>

