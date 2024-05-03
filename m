Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF28C4345F
	for <linux-nvme@archiver.kernel.org>; Fri,  3 May 2024 07:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I0wEf1/Mod+aeygnXnr+/MpKpD/fWi5smqzxC4jKzwQ=; b=cfC1vPfUdusB4WE2W9WBdWJ4MI
	oK0Xyq6GTjZsEBhulUj822rLCVgBlIt9/AFF+G/9jXKgU93L813lnrat/AWw0Ni0VyNFTxFStDnKT
	LxjcWlgs98M0/hJv3s15i6RfbcwV5pUpl9MK5NsLP0DOmqdtvuGLXXHwxS3ENftVX4qahTG/C7On5
	H/MTQjCETDfXqghLvcbHGjWM1JVYkPXWJF3ceGk2C/gbezyfN/6VHp9jB5ukvslHxIsQmxVzvX0HZ
	w7MffHztxk5gsJySJNIbBcOX6tZfCXA9LlouvCRtNG9SPNzTkTHbysHwqhxouTWqa40lczIFy4wrw
	Bgp87mFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2nVQ-0000000FV3v-0EfP;
	Fri, 03 May 2024 07:38:56 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2nVN-0000000FV2z-1dUh
	for linux-nvme@lists.infradead.org;
	Fri, 03 May 2024 07:38:54 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-345606e8ac0so862696f8f.0
        for <linux-nvme@lists.infradead.org>; Fri, 03 May 2024 00:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714721928; x=1715326728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0wEf1/Mod+aeygnXnr+/MpKpD/fWi5smqzxC4jKzwQ=;
        b=QSVxsBrksl40uczbdbzsxWxm7Jf/JDJOqWvmvnUuckut81I+7rugmwv4j8de8U4iXO
         AXZFj6bEciGgNxuHY76fuWe55b0FbR86yuOeBPWqCuKXovcE5WoYsakXII8wv8bXvb/4
         THQP/Zo8aCuc+AadZ6PbOzkTRjn1eqBH+C3mqoF+MZtgAiZ0MHe50oeRRaapQpEgSFXV
         iHg4/hGQVdsY7hUSZFbnLCHrC9KEsW1N0TkSKih/Kw7Dlhfsb3olCYMk5INOEb5zS0bM
         8fTe/p28V/iSVoJQirJ49kQT/YATKD8dLVD24ssh4ABfQOYvgn+K8I1f9snu+jDhsZdV
         OZuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5LVVuN019UrbeD42LO+NEJtsfBnMa2MTLRXg5sBzEdHfrB/Q2erxrlxXh+8NhxPu0ncB4C6ppB9eV2FGe+2KqSkWb1fkPqTO88C6io3w=
X-Gm-Message-State: AOJu0Yxq4MAwHlLziZjSocpBIjyMc8RF5auLHTmL0LlpUlWA8IWhH9yg
	JAkprskcazcZDvYlAyln0JiVCPq6J7v391ohb4feVYsilXtNQp4c
X-Google-Smtp-Source: AGHT+IEVAHWXUAVQkmT1VamN37SaQIt7TgAn4QUJ3LrBEaYP83G9tTiFLMGbn9hfshlux/owVDYPnQ==
X-Received: by 2002:adf:ce83:0:b0:34d:7201:4616 with SMTP id r3-20020adfce83000000b0034d72014616mr1399904wrn.0.1714721927883;
        Fri, 03 May 2024 00:38:47 -0700 (PDT)
Received: from [10.100.102.67] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id i15-20020adfb64f000000b0034af40b2efdsm3056795wre.108.2024.05.03.00.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 00:38:47 -0700 (PDT)
Message-ID: <4038f7f6-4a2e-47b8-be17-d9f59300d26b@grimberg.me>
Date: Fri, 3 May 2024 10:38:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: reduce a repeated ZNS check
To: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org
References: <20240502063438.422046-1-joshi.k@samsung.com>
 <CGME20240502064151epcas5p3834c50bcaea2c8db2d24fc30b0957ff0@epcas5p3.samsung.com>
 <20240502063438.422046-3-joshi.k@samsung.com> <20240502071338.GC31379@lst.de>
 <3394a7a9-dda5-204e-dc5f-04a5512770a0@samsung.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3394a7a9-dda5-204e-dc5f-04a5512770a0@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240503_003853_468860_C9278838 
X-CRM114-Status: UNSURE (   9.07  )
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



On 5/2/24 11:44, Kanchan Joshi wrote:
> On 5/2/2024 12:43 PM, Christoph Hellwig wrote:
>> Not sure there is much of a point do de-duplicate two instances of
>> compile time condition + trivial const comparison?
>>
> I also don't see it as a [micro] optimization. But this if condition
> seemed too long to be present twice.

Seems a bit redundant to me.

