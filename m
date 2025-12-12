Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F20D49229
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Dec 2025 13:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=QmH3LVncjsZjnXy0pGkPAa4vLS
	dMd5grRMGQTTZVjbRK61ujRqjFuHfCQY0PKWy2a2iJFMEEoVdQgIZqAUShije0Yenrb/eRUNTs/6F
	iuxCH7fBMI6IYMuOfRqXcVRuv18QrZYs9cbTgVG2+li4IBjPtmHNKZrYVsv51NSsusJv5+9t8enE8
	JLJYse/+66O2i/RoHMxoAO+TFsS04OjjiOsX6uhdPVhjlu0+sSplf1/IHGB0IpKclK6ooaUp5Sf0/
	njDdmG06WeNH9tYAmrvgh05R+PQa5E6w/0zImSgHzQGqLpkhDdYV85WKRhHguRvzBt/ud4Vi9kYtF
	CPzP3I+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU3Vi-00000000ZvA-3hQF;
	Fri, 12 Dec 2025 13:48:42 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU3Ve-00000000Zug-3J2I
	for linux-nvme@lists.infradead.org;
	Fri, 12 Dec 2025 13:48:41 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so13818285e9.3
        for <linux-nvme@lists.infradead.org>; Fri, 12 Dec 2025 05:48:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765547317; x=1766152117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=N+ENgRfh+0Ywgmyi2G346yaTIftW3QtuYZ8x2ElngzSUKOoUEPd7AAD1H2M4TblyJA
         NIa05RKziyBC7A+5HmiAllkq7CKUZ4PpUhLfIEU3ir9ty3c3tEK2e9O0vh2KXQ441+zd
         POqBLeLrVXRZDgSlkcuY9Y3e7RL5Gj4nmUtjrK0Cj99BwZtxsjGCh+iILnbALDl766OY
         XU7KXAvXSR5/te6KwTO65YD8h4y0U+MaPquqALah8EcYZb6U9fL3mVCYu/XoBIkIgbTG
         KH3ivWEM8SpD0NAbCNDzipxfreJmc6q2OtTK7xaj3H/xREt/ZJvUJOugurGn/a8m2UDQ
         fBkA==
X-Forwarded-Encrypted: i=1; AJvYcCXdbfGXswSGHSdoe3sYP3vAvnmVWZjn1I/S/7oXNkDnBao9rrNL5X2R4XHMboIPfEWTjT7bmX7PfqtD@lists.infradead.org
X-Gm-Message-State: AOJu0YzVbJy375Q6gNelnXD5sI15YmWqpyl3YcXTOBW/HWQiqHs89VWm
	eJcvf5RAhdbiiXKAEiLRZKdpx2heU6agzg5L7V6lGZ6AX4MgJWFd+Swz
X-Gm-Gg: AY/fxX5ToAI0hQFa+8+FnDcTUkk2wMEKMnwGA6DVW44XUpsFcqxQCRkR6CcFEUP6xmi
	I3DRP0kCkAbqP6YGa+8+7xxJWGsu70X6Q3VYmWaWHhiu3p5W1MlH23MuOo9CKbQ+dW/vtxSt1u6
	Bhkyg6MN4ewE6Rwb68tvNAArujj9OeiOgkQwMYbIw7Kwzkpeh8HBVdvT/VOrgCxJkd6Yqhd2asR
	LhH56Zl+N1S/Hfe3Gcd8BqhKh/rOTsPaVNrEuy3SC0M04ssEJegQfYx3no0Aj5xca0uvKDGDdBQ
	VI6gWG/3b/yGsHOddnmchM6LkRobdKW5N+bBMwO9/uJg21Bv1XTMS8DftpJAXW73ovogSoVB2DZ
	LPpPkHybjNC8mpLc2idaUvK6TUbT2lSEz29Lc8KgOb9gQcf8tyEPI5VJ1FyftpuUTL+5t4tQgxM
	qciWL+WxFZ2pevbonTfSupfPdDbxuLvmDtmkYXchBijVtFCdF/+G1DR3Rf
X-Google-Smtp-Source: AGHT+IG2wQjAJkCTp9daH7wNb9pSM0ivL/TA3c0wzdxikbSVsU1QibOEwBhUCLjlR5gv2ndDK9pnRw==
X-Received: by 2002:a05:600d:6402:20b0:475:da13:2568 with SMTP id 5b1f17b1804b1-47a900bd6b7mr17071055e9.25.1765547316714;
        Fri, 12 Dec 2025 05:48:36 -0800 (PST)
Received: from [10.100.102.74] (89-138-78-197.bb.netvision.net.il. [89.138.78.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f8f3894sm32575275e9.15.2025.12.12.05.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 05:48:36 -0800 (PST)
Message-ID: <18d3f61d-b798-471a-9837-9dfa3efcaae5@grimberg.me>
Date: Fri, 12 Dec 2025 15:48:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] nvmet-tcp: Don't error if TLS is enabed on a reset
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 hare@suse.de, kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis
 <alistair.francis@wdc.com>, Wilfred Mallawa <wilfred.mallawa@wdc.com>
References: <20251202051755.1312158-1-alistair.francis@wdc.com>
 <20251202051755.1312158-2-alistair.francis@wdc.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251202051755.1312158-2-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251212_054840_114978_84C296B6 
X-CRM114-Status: UNSURE (   4.37  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

