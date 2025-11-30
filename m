Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39917CFD376
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Nov 2025 21:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GCun5ZjmRjUaLC9ytlpTYSHBDj2+AHDsiVj1mOnBQ8Y=; b=STz5z37EaSUbS80RFUL2/ExnyH
	sZlZCusIs+AoLWDJh9VTzOClokZSIPoe4U0K7owTrfcYAPjelihLSdUGlsaQQZqU7XzAOfQDGR9aK
	Wi2EflRCT/YOVxnUjYCTQ/pLV8qmrVeuk2EaHjinrnxS8gOMMeLEPNJBvgCcqA0tmWdOgmswNRgse
	XC79PPVcfSG6eZGmJpvk1a16tCOnfWpdTh40E746GnY6PYSOs1/VkzWoChERr/gNcmzVJ8mSBABUN
	6+iHgdznfOUtdLhFCx43ie/uBkXEJlbwuqsOl6JVoQgnS28vYg612JFMERzbZUqXTN7Pvu9P4Rv4H
	aygoFcTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPpBl-00000002afY-2r5S;
	Sun, 30 Nov 2025 21:42:37 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPpBj-00000002afB-2xwz
	for linux-nvme@lists.infradead.org;
	Sun, 30 Nov 2025 21:42:36 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42e2d44c727so389581f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 30 Nov 2025 13:42:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764538954; x=1765143754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GCun5ZjmRjUaLC9ytlpTYSHBDj2+AHDsiVj1mOnBQ8Y=;
        b=qfX/7EeiVPFCyicjZ5seS5/m3/t0OjKgra/J+YIzcsq0w5fS60S5/cWxVVNjJlMHIB
         5JI9CyPTYmOrg5hYDvp4CWEy0mEJwhKApw3lvD6e84KjVrgb8G4zQcMOf7O/OKuqj0td
         WaGWyY1RsXRjOKMcEedzB13jtJE0YaR08m7UirFfct/anp1kLJEYoNfXhITAK5grR7zx
         rFv63ner9Ep7JlZLkwbSCBd8gkYH/5E3Dmv2iwUTNfZWDDXomWMEA18KZeJByRaSIiJq
         8QWZBeFfQEWOlR+zKdiwUoi6mLjxU8QTaZNFWRM6+iXHNCoMAIa9aZzwwsz/7PnlY9lT
         vSMA==
X-Forwarded-Encrypted: i=1; AJvYcCUUIlv3uBEmUU9kmgPe52BqYqKh0iRfGfS1DVEfaXeEESmxtqTOxR3QeFbeVhyyHi4tivRY4vKhu0Oh@lists.infradead.org
X-Gm-Message-State: AOJu0Yy0wIJOU+s5mablAOHaQXYWaONfxzvQ1ufrL1Yn81Obm+bcfPFQ
	ATml8pCr0cGYgwwmG7KKqUuF+pd8CH4Fzmc4ypPgNaXiYQHNi6zJ0KC7
X-Gm-Gg: ASbGncvVWps/O6F0c/ShMZtL5qw9bsdToYLuBaknSDLwxBVh8uWA2Xn8a2X9M8M7sL1
	SwIhNkZDm4Fz4003h3Cg/Lkg4j3hNaDcbM0xNi/RBliChdHcF95tIe+kmTRTBXjbJOHBtf8WYyk
	O64d6mKNlLkcT0AOpxoUc3vIjJxRfl3DRsKFyvX0yFTGB60vW8HdsGS/5G3RmIymC1z8Xy7uhDu
	caLxd0Md8ONfq6qGBwW7nt2qVlqZYmAPNKx+JsZp5TCcWfOKV1ne0vy21HX1H/u03m9q05Nhnce
	MHw3M6x8MNfF6qEtzNFuGZitWd8ZAkYrK6VBLuBcEbYNiStyMm3UszqfkBPEIJ6kuQWWtJ1ufUu
	Y3XP3mPizi+0qjyvpwd6K/b/98DJTqxXbUvoYzd4HB/YTLXhH3LRFCdUjWGfG1Zgc9XgRofRCUf
	k1y5TMCySaO40CiJiSVdCvW3YQ1OKrQy/RCLW4NesT
X-Google-Smtp-Source: AGHT+IHDfLaBA0nQxUukZqj1BYxT9b0ctRIYCPIEW8NcLIqaCeZayS3DWNst+RYDGw+UdC249ylVKA==
X-Received: by 2002:a05:6000:240d:b0:42b:3c3e:5d2e with SMTP id ffacd0b85a97d-42cc1ab5bddmr38789344f8f.1.1764538953690;
        Sun, 30 Nov 2025 13:42:33 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a310sm22613550f8f.26.2025.11.30.13.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 13:42:33 -0800 (PST)
Message-ID: <3b10eee4-d2d4-4576-a63b-0ade6e23481b@grimberg.me>
Date: Sun, 30 Nov 2025 23:42:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] nvme-auth: modify nvme_auth_transform_key() to return
 status
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250528140517.3284-1-hare@kernel.org>
 <20250528140517.3284-2-hare@kernel.org>
 <c01b35d7-d1a6-467e-b3e8-a1aa3d613f2d@grimberg.me>
 <55a3dfe4-3c7d-4b05-9131-a7077b1b3437@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <55a3dfe4-3c7d-4b05-9131-a7077b1b3437@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_134235_758002_03CCB982 
X-CRM114-Status: GOOD (  14.55  )
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



On 27/11/2025 10:01, Hannes Reinecke wrote:
> On 11/26/25 08:39, Sagi Grimberg wrote:
>> Patch title is misleading. The addition is the transformed secret 
>> output...
>>
>> On 28/05/2025 17:05, Hannes Reinecke wrote:
>>> Modify nvme_auth_transform_key() to return a status and provide
>>> the transformed data as argument on the command line as raw data.
>>
>> The patch is missing the why explanation. I mean it looks fine, its 
>> unclear
>> why we need this change.
>>
> To keep the knowledge of key contents inside the kernel keyring only, 
> and avoid having to specify the key contents on the commandline (where
> it's prone to show up in audit logs).
> Also it allows for exteral provisioning of the keys; some other
> application can provision the keys in the kernel keyring, and
> nvme-cli can pick it up from there.

I wasn't referring to what the patchset is trying to solve for.
The "why" refers to "Modify nvme_auth_transform_key() to return a status 
and provide the transformed data as argument on the command line as raw 
data" What would help the reviewer is something along the lines of: 
"preparing for XXX" or "in a following patch the caller will be using it 
for XXX"

