Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53055C5DF97
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Aug 2026 22:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=plWtcZOEUMWG86EQE3aVQ94IaioEMHc8/AngcqnnZLg=; b=3Ux89gxAP+M9NBf/tZKSfdfyMK
	X56F+5EjCGvSsDre91Rpd48j1spWwCEyhXr1b7IJfJftRVOJXaA69yqFmqX2YscbRxLdFZN1IugZt
	0YtRNR/jLIa9k85k3tYyNL+PlhywELhuDfNRL4+KEs1MmL0FhzpSaqlxFO8fPVYmPa8PX/LbdIz07
	HzcSLKj6pgybDB6AzvR9lQsQBj/uS7ek9UTxe/n/we8b2PPinHLEM98ucel07yP59+UuoQL07pqUs
	BpD81ooLY8zRGv8cE90ZRVEQMMzWnISD6NKcladMWPjIO0wD2frvYq2tLp3XVhB0HaZdlaOCLvgz9
	nmQ78y0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxtxO-0000000Epps-1AmM;
	Sat, 22 Aug 2026 22:12:54 +0000
Received: from mail-ed1-f41.google.com ([209.85.208.41])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxtxL-0000000Epom-0qKk
	for linux-nvme@lists.infradead.org;
	Sat, 22 Aug 2026 22:12:52 +0000
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a3fda88184so3581123a12.3
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 15:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787436769; x=1788041569;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=plWtcZOEUMWG86EQE3aVQ94IaioEMHc8/AngcqnnZLg=;
        b=IsPxIpqvU9qyez3zrOXQhrNiGgfPRoI1s9RyvGLl1Np2Rrf2KhS31VFuS5gcpUvBOU
         BpHlLHaD+6L26Iai+45hmG0XLd9NgBxSxJduCpWrmwbIn10sdLMsr6ZgyDwEp9Zxu6Y7
         MlA7haaikxJkIq9F5bI9fAnNPpqAlGN8oCpXfFZ7NigfhrJyo0WlKgHm5Cn/nu545wDI
         glEG0PtpH5TWyLJvq5MDR23Cj/LjvbYbP2tBSiRq/K9NRgEZ0XDyMWijdHzEj5nwO3/X
         tCYoWVnj1mxKvC2sjOCr6xkt0rrytCBctK02XAIQZgqeLBPpej9OjibyKTaYqVIKXVSp
         Cqag==
X-Forwarded-Encrypted: i=1; AHgh+Rru3YNG5OqYBsexJjdSkDVZ1Jb4n1hq/YZB+XtvmoKPcSLzBWNC+UrU3kI3AoH8L51TUYgPRts7Xcqd@lists.infradead.org
X-Gm-Message-State: AFuF++mBEbRb8k9BnnSm0Wn1ZIeLiRLl7CtWpMPjoAGzVaz2cga/0/7w
	OMANq6jUBfQirf9LC+1/ZOUGFSBvQPKc7yokik8S0YSbnuJNuZgetRB8
X-Gm-Gg: AR+sD11/884xXY+rKXLe+aV36t8nbQjHVR4pLXMNSDF2Bke/YzYHA/zfVEoUqeKp8Fs
	Ig+j1lgcrFEne0Stu9oOi1cjumDLuesmX/+et4bqsElpoXVUtTouFYnwpI6v0I9Y3c90erxg12Q
	VNwAxD3GznKCNSm0QRg6cvZ5DLMfKNiG6KhOfHznhErRCyUnAUYMzl5jH2Ep+qFgtsAcFd/hvZB
	QyRWZx3BcnVLJrTEbo4Y5jeDIYR+CWeZ/CFd6/hhrj+kLgpqzO3rbpbphlVoGOp5ecVTeoFzOdC
	teost9btjA0VSOXQd5oGuVjb1QjINJvoAhTvvOSVSZaElKsKPnzwF6+pmn4sl+7zzczHe7AbnNu
	9utYg/2Uy0hmgy0KF6aX/57ppmKPdjm4YDlhkg5MGHWPhX2O+HvB/7AOzWp2x9gevkcrEIE6AlM
	lGPizrIU6NdDn0FXgkjg/GKbHyrbsb5jfvjeelFUD+OldNzxGjkIVC3AbJyc1eEPu25NgTKaL0Z
	T4Ql/IdyfBzsMn5lRekZx4=
X-Received: by 2002:a17:907:d649:b0:c19:6d4a:425b with SMTP id a640c23a62f3a-c246a626403mr1629413766b.18.1787436769066;
        Sat, 22 Aug 2026 15:12:49 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249672becesm520795666b.42.2026.08.22.15.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 15:12:48 -0700 (PDT)
Message-ID: <9886acc9-0bbe-4c18-a6a2-1e11b1e4a405@grimberg.me>
Date: Sun, 23 Aug 2026 01:12:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nvme-7.3 4/4] nvme-fabrics: add helper for DH-CHAP secret
 options
To: raoxu <raoxu@uniontech.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <29BB44C32FF06823+20260821062142.1932160-1-raoxu@uniontech.com>
 <A5B62A1BF62A33C2+20260821062545.1937266-1-raoxu@uniontech.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <A5B62A1BF62A33C2+20260821062545.1937266-1-raoxu@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_151251_251101_974173BF 
X-CRM114-Status: UNSURE (   3.84  )
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

ok.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

