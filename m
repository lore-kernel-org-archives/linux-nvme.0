Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B03CD8C9D
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2026 15:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EbmT2FCWR0Gd4SX2RDsM30scSxrK+9c8gSano44Xlwg=; b=2x3i7hxcKvjtyHWs/ihbS8j2rS
	A2gYQFgaXPzxogZ6ZSsu3sjIQFWycAHSNIknTf3opUfYIiG4LOhF4CTINxiupkFjAySJpp5+CPlNv
	s0QNgKA8IqcjSti+phaa0nMnd1Xq2DKtGSkpy1IoRfx4sLOofMnoMYCrcV5PQ9XALyiWNCiNh1NFt
	fZ7uUCgB+NSM5Y4+KW+5hlPFsDV7BVE4bKfObmjvJt7llgQOkbRkOZVT8VhzaMAnEqCbsCCcDJKVt
	oHPkKzlZqD/5RyHEIkr/KEDfPXabU3irwgS3cE1r6JZ+fuXkKz6osiuLThjrhL8Yzr/EvYNUmSazG
	Pn5MsGpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWbmZ-00000003wsF-3AZZ;
	Mon, 08 Jun 2026 15:20:55 +0000
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWbmW-00000003wrb-2J7G
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jun 2026 15:20:54 +0000
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-69e8aa31e9fso472169eaf.2
        for <linux-nvme@lists.infradead.org>; Mon, 08 Jun 2026 08:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780932051; x=1781536851; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EbmT2FCWR0Gd4SX2RDsM30scSxrK+9c8gSano44Xlwg=;
        b=gj+hCyOqF0FAzetp/EcjlABJiWX/mXl9cHsJXchoejLl854JVymxnFmhG9glhnCDeZ
         T8Seg1TgmjHK4zn8xKgfqnt+rWv+HaZRpV+OlvdtwUgkuJLipZtPpQp0tKiVZKfS5G6N
         IdhpLuR6vNM4fj9tiOs3I03HaOa1yK5clqSPfGj85uAHQLwDBH7lI+U/VK+HtkUSRM68
         3l72U9Z2VEy+fn77+PocvDMPxBf9MC2M9i+0r8WqBgF9XZ9D0BTpdUd8WolHbK4EgLUH
         3gg5Eg83uM3TFkRJbN4I3n62Zg1FEJx2w3x3CTI39sRyuhNG/DXfPX/xvCAt57goV3vA
         cjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780932051; x=1781536851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EbmT2FCWR0Gd4SX2RDsM30scSxrK+9c8gSano44Xlwg=;
        b=Gk37wqhVpBQ1I3kv+pCXp+4pNdudG1W6sPpqjZ1PkxV/bKuRPVjBvPwHKGMPiVnQkR
         2MsM3Gm51+ht4ST+sovjQQXLxeTlBuml6Zz7wbKREWuhKzDilca/uVUvG1TlD6cYlA7s
         8zyoxZUQZ51dj9wO01wjsk5U2NY8qMC5OT1NXovzQt0nt0HyIUIAoiQZ4NzKmlBfPzS/
         95msYXRXutyAs7r0y0sb7kd7zlEAmYbxo5psJQrc+Zcjr4LqEPHqbts13YhvuS1r5wBQ
         Ejc9KnnQLmOY+gFz4WRaWjr/LO65o79qAduBoL2MVDOpcCoEvjQZk94RPmIQjcOHfiNV
         M9GQ==
X-Forwarded-Encrypted: i=1; AFNElJ8OJGRRFEY2ksB80hTPt3RGmqA/hz2qC9R/OqsA3hnK0W1Tj6W2xzf2V1LlHKc9euYtlG72OqnURtf+@lists.infradead.org
X-Gm-Message-State: AOJu0YyvZU/3G0zoMXxn0QC0TpuU6ZsoEWpjjakCrzsCkDgVJ1gjETFT
	ZeDgdjGVMEHcCv3WzhwHwxLOPRrrHdlPPyW8yQETJFmUBj6EEmSRkr4eUMguzKIcCKY=
X-Gm-Gg: Acq92OHCEdv3hzI6XA/vhId4VKT3vrAXdpz+zZzWrHjDR6C3V+aSl+TdmCJaFHflD9v
	u3Pj+mgpVqrDOqIBg2vLGGfJeaqF8eKdFj3etpYNxIE4Pw8GRG2L9Jb8XNkpv9Ond8a6QlMBB+0
	mAopUwPXLxbelFiZup4i6eFrx/mZU8+cz29ywetEI2nakZECA6u9nN2bznZGMxRpHqf2XyXjq2j
	XgpnUmqn1RUaYnMHuXnY+hAR9oNH4KIHPGbFl9sm+y3IsNd2DMxs1Zs0cXeFRE2lR8QWLoNALqG
	zRkmsiFggDyq+0SL4v1d3pWB3bKQ+TQ3ktfMeOT5j5umwk3z6k0wM9sZxTz1XVXcxeKhdzM6fLZ
	7z/en8nnVchZjZ/bF90vZkEriVi/lfsshqac1frJNkYT7/D6Ie18vW/HztrXvqqASCd6zOfDZBs
	4u7fQfGMmOudOV2iIArmxrRSl1ruvjkOUmRGIVGva0SD5f4Aycr3OLQUkzLMmHG+RRjwsAWvBOe
	Hhl7vyEQCwFM6pjaDFE
X-Received: by 2002:a05:6820:4cc5:b0:69e:5051:669a with SMTP id 006d021491bc7-69e68c7eb10mr9443238eaf.44.1780932050645;
        Mon, 08 Jun 2026 08:20:50 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e46267666sm10079215eaf.7.2026.06.08.08.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 08:20:50 -0700 (PDT)
Message-ID: <7aec5240-a09c-4e6b-b65a-6ca5b4b40db6@kernel.dk>
Date: Mon, 8 Jun 2026 09:20:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: avoid possible double completions for the same
 request
To: Keith Busch <kbusch@kernel.org>, Ye Bin <yebin@huaweicloud.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 yebin10@huawei.com
References: <20260608113425.3836619-1-yebin@huaweicloud.com>
 <20260608113425.3836619-3-yebin@huaweicloud.com>
 <aibdA7YtCt5OS1EQ@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aibdA7YtCt5OS1EQ@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_082052_615964_E9C22D49 
X-CRM114-Status: UNSURE (   9.06  )
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

On 6/8/26 9:17 AM, Keith Busch wrote:
> However, I'm really skeptical controllers actually behave this way.
> You wouldn't have a viable storage device if it was doing this.

Same, and I would be strongly opposed to including theoretical
work-arounds like this that just have fast path overhead for zero gain
on a valid device. If your device is broken, ask the manufacturer to fix
it. Let's please not burden the kernel with catering to broken
implementations.

-- 
Jens Axboe

