Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DCCD6A228
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 18:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5zoVo4+kQN+ueQlCG959/cYwJc5u2ZL3E8/8KA9E2yA=; b=NSWMAbE8RQ/5BeaMNO5jHCtWgC
	TNhAx6XOGBy4TbC+kaGnw69IGXZvntiLwJtqIwN4kDXbEDOywfNNnemKcGBJrTOWa7dLWQa+VN21M
	GQZi3+gRrF0Mur86TPWYZSimgsZXLWZZnRh1XhXs5BpAY/OaX75+Uyf01GvM/T/J7Njgg22eEeuP0
	mBRzlBtYrV6ZFj+Q/3Cm2+HKmRz8jwII1a15pW927CIuyuUvzVLPFYjFfMy41cyUi9/h8ZAxty22w
	BN44xoqIEPXuf54FMpU5MQp0m3uMJYDyjTUkKF+IoFPzMhm6+xOeLUs+IU/4PJG6kfRtixIZ6o3sq
	/4LhlmAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBeqM-00000000WK7-0qQw;
	Thu, 14 Nov 2024 18:45:26 +0000
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBeqJ-00000000WIh-10yq
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 18:45:24 +0000
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-295cee3a962so578389fac.3
        for <linux-nvme@lists.infradead.org>; Thu, 14 Nov 2024 10:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731609922; x=1732214722; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5zoVo4+kQN+ueQlCG959/cYwJc5u2ZL3E8/8KA9E2yA=;
        b=e86OyN93z23QI3m4AsgHdYLpHsM/9gdTwC4hFqRBktpFUKOwxAesE1OzrBrJ1pdk5+
         edoWCm7XZ72+EJQmbM56giDHhujMiIzzkG4hMa5jWU177KjTkv5sj+l8SJ4fnv84yI1F
         SREKcjHRpXjCHYDYxTWOWJnOBV39MihdUjhfEG5hgi4Ywf3771kFMS2/K23kmQJ759GI
         f+nlr+J4m0U9EcpswguqduxDKgy8CzDamCLueJuloH1yYPHRmk6mfhTLWJo4jm1ggQ6a
         DdOAzs/CmDGQwZoidVSxpeN2rYsvbPBMotAVLtBFQm0zs2DcLt3D5lMj3l02d33UmuiA
         46wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731609922; x=1732214722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5zoVo4+kQN+ueQlCG959/cYwJc5u2ZL3E8/8KA9E2yA=;
        b=cxl1Dhqnc0WAGJljg760cKIuEH9++ioKAzG7mjdu5sd8p8bsT4BfsRMUSUKW3SMqnh
         yLBtqhZeelIpbVPnAgSrLR5ZepkE7RlEIHaYBaGaSO6IvGua4zNHygrs4OMJ2nZCs5By
         qlrYuIVxgfrjvi2DQD9UJmcXMVYbS8rWE6OVekNiWFb/hbLDNT1lwYt0WLWQ/PHQIthq
         dy1DueVCqqjMHCAt7Lvnxjniirsqyx0A0FNrA2nmaSXyfbNEaOGetFr1So2EKgmsMwei
         eTxdujN+VlBE8RzlLRRo8w0pXVAr4dPFadbX+ebnG6ge194xII9KN3PKO8ixThMyRbz6
         o+wA==
X-Forwarded-Encrypted: i=1; AJvYcCWYcOmHVypy6KZiUdCF1ZDnW1jud6QWsxZwCkBRaaXNOIvkA9Mxe9U/uswztXFJP4FPHoIIOb/IDZbm@lists.infradead.org
X-Gm-Message-State: AOJu0YyhMz2jJXc2NVxOu+giqN86xD0oUg4kzOcgPMxCG118tyH2k79p
	XrgyWhksfKxhI3s8bd0HA52F/9cysDdpU2X3FL22wLCAOP8Rxkm1xKJfOoLBHBM=
X-Google-Smtp-Source: AGHT+IFp6pKo/EUOhSRljF/9P3IFp6ALYZg+0RNRX4Yt0/ItbxHZ8Ni5Hrc8veYcx79IP4iwLpT5eA==
X-Received: by 2002:a05:6870:6111:b0:278:1c68:9c03 with SMTP id 586e51a60fabf-2955ffeaab2mr22952722fac.8.1731609921883;
        Thu, 14 Nov 2024 10:45:21 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5eea014f3f7sm513857eaf.22.2024.11.14.10.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 10:45:21 -0800 (PST)
Message-ID: <7eab621b-e1cb-4ad2-aba4-2e2552544dc1@kernel.dk>
Date: Thu, 14 Nov 2024 11:45:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fix for Linux 6.12
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <ZzY_Q785-p12Bl14@kbusch-mbp>
 <058d94f1-da1d-49d4-aeb9-10fda3069c99@kernel.dk>
 <ZzZEZ2AJDl4U7vxl@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZzZEZ2AJDl4U7vxl@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_104523_291922_35E6016E 
X-CRM114-Status: GOOD (  15.81  )
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

On 11/14/24 11:41 AM, Keith Busch wrote:
> On Thu, Nov 14, 2024 at 11:28:15AM -0700, Jens Axboe wrote:
>> On 11/14/24 11:19 AM, Keith Busch wrote:
>>> Same fix as the last week's nvme fix, but for nvme-multipath. It should
>>> have been included with our previous pull-request, but I did see the
>>> message in my queue until too late.
>>
>> Just to avoid yet another merge conflict, can we please just push this
>> to 6.13 instead and just mark it stable? We probably should've done that
>> with the other one as well, it's not like they are important fixes.
> 
> I was sending this now because I thought it would make it easier for
> stable to pick up without having to back out unrelated 6.13 conflicts. I
> just tried to merge upstream with this and block-6.13, and it actually
> looks like there aren't any conflicts anywa, so it doesn't matter.
> 
> So yes, let's drop this and I'll send it with the next nvme-6.13 pull
> request next week.

OK if it merges cleanly, then we may as well do it. I'll check in a
second.

-- 
Jens Axboe


