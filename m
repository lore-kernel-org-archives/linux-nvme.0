Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A142BFF885A
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2026 22:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7JLfYgvrluu/tH65f4QxUd2+ma64ZL3ycvpZJo5hsjU=; b=DNPODZufmS2FQ3E7FQO78fZ2f4
	W+JEGn06ZNsPZX06z5T9802Z1dX6fMGtD0bIBcj6XYjoxfgHgnK6w4b6jznxYC+SB2Do9nEyaJpwJ
	xLPq0eD1i6OCZ3qPwPFCVY9+NiwXMeVPXMZKpzqF/4+k7qtN7TxURmaxKXYu6u22gsax54C9xJ8QK
	sxqgQ85tUEdpGQtxRlzjkACiXKCHt7cgmIEgGBvYe/SrsAddsgn84gDE8com72GASJwJxfyCCU3ac
	M3RXFzp9hhmdrETAdpQqg56BEKbMidmxlNLFzErR6D2d951BEv9X2VeRfQmu0jdjKdjSXq04EXbiW
	vgOEtGlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGPTN-0000000Drd5-3PQj;
	Fri, 24 Apr 2026 22:58:09 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGPTL-0000000DrcK-1uyG
	for linux-nvme@lists.infradead.org;
	Fri, 24 Apr 2026 22:58:08 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso68693165e9.3
        for <linux-nvme@lists.infradead.org>; Fri, 24 Apr 2026 15:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777071485; x=1777676285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7JLfYgvrluu/tH65f4QxUd2+ma64ZL3ycvpZJo5hsjU=;
        b=YyRiMzfNzy8P2tMl1hTIJzCUcOvrmxInqDgTd/qNw8tlqi8ryhdO2VV8F5L6vsKqFI
         ksWKt1D7Dd/pcNIZM52bdleixEbtzSFG6MIaNh3CGJmX26AIIW1bCG1VZluv4xUVKCwQ
         KnBQV//TJlL5drUO5iZeWFoCRmD970ApV+RkD2Y7mIIG+h0NlTD2/lEw+HPgTVpxZevH
         5kP6o3iuHAVrKD9459g9uJC5JqEDTwCjVsnbMCV639RYQUlhKjMiT27o85hPn8iOpBIc
         7wQpHKKGOdQXr331noDTLbEqGQnbNY3G2pNQ5Lsx70T/zD6SfFk7cv7K+DVChaLaBlCT
         lrNA==
X-Forwarded-Encrypted: i=1; AFNElJ/vcWsgaDyMbz0ECtdg0H59x+NEGCMX1tJVRJbJOK9sGmtAUtnUqlAv2GXnvGQml8oL94nKI5Q2U+Rx@lists.infradead.org
X-Gm-Message-State: AOJu0YzeeaBla0lZ8n0iamjMKeMS/ErgwbltTS7j5N5Ic9Ytw2ef8xxw
	g/9T94IhHoA0vL694MBU1vTTrUFJCNlQQF8CeO08AnS/RbPzjVIYI4eT
X-Gm-Gg: AeBDiesJROMHMNp+jjUPvmn280lW4bE+854ywLVU/ZaydAmg7dumybjoBlk1IDN7X7z
	YYqtVX3eMekAzOLoRvPMOPHBef/GO/inil/WPa1bvyPIeaLsr/9QLJqdSjJ96MSKaPxHE8olwz4
	jN9659ow9AaK1VNPCtfuq9qzGnKvo6L7/ICkq6HpIa9wp1cFcEfhdNcrRRIuPdGsxEpZ7k5D5pZ
	DuUEYBT6SoKMCQCUf0HPljwlmuak1bW1qqhdVkRYqDxioaBaNxMTrG5tohqKD58jszWsj/Bg42O
	92yP8nbii4I6J+ztFVSRY1Lg980JAsEMv2i9KEcmnNkUg5iQEN0QVdlE5vovrKL9SAlqVpxs5R6
	lJjgXrwo+My/VOT0P8iJd1jDcNFhiIX+E1uLeUdVKK8IsDyCQKamyv5+CIUEbbKlCv56E+Spmwt
	Gfh3NQRRlOqCTwUv8XeaDXEmgJsp2oqlFF9dxpEhvRdr4TwZVuyxvSaQGdXwp7JNYNrBb4YJyZ9
	CVwvwg=
X-Received: by 2002:a05:600c:3110:b0:487:243f:dc3e with SMTP id 5b1f17b1804b1-488fb739cf6mr492860025e9.6.1777071485357;
        Fri, 24 Apr 2026 15:58:05 -0700 (PDT)
Received: from [10.100.102.74] (89-138-71-216.bb.netvision.net.il. [89.138.71.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5aa3ae83sm431083595e9.12.2026.04.24.15.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 15:58:04 -0700 (PDT)
Message-ID: <9bb1d1bd-2acc-453d-970e-762e173d230f@grimberg.me>
Date: Sat, 25 Apr 2026 01:58:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-auth: Include SC_C in RVAL controller hash
To: Alistair Francis <alistair23@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, kch@nvidia.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260415230824.2790058-1-alistair.francis@wdc.com>
 <20260416051627.GC14802@lst.de>
 <CAKmqyKON1MoOU-MQNK8EEVwVWmSJZ9OmxH2M_mmYTadmcbVyTw@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAKmqyKON1MoOU-MQNK8EEVwVWmSJZ9OmxH2M_mmYTadmcbVyTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_155807_503898_C65F0AC0 
X-CRM114-Status: GOOD (  11.83  )
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



On 16/04/2026 8:25, Alistair Francis wrote:
> On Thu, Apr 16, 2026 at 3:16 PM Christoph Hellwig <hch@lst.de> wrote:
>> On Thu, Apr 16, 2026 at 09:08:24AM +1000, alistair23@gmail.com wrote:
>>> From: Alistair Francis <alistair.francis@wdc.com>
>>>
>>> Section 8.3.4.5.5 of the NVMe Base Specification 2.1 describes what is
>>> included in the Response Value (RVAL) hash and SC_C should be included.
>>> Currently we are hardcoding 0 instead of using the correct SC_C value.
>>>
>>> Update the host and target code to use the SC_C when calculating the
>>> RVAL instead of using 0.
>> This looks correct.  But I guess this breaks existing implementations
>> in the wild now?
> It would break an implementation that is using non zero sc_c and
> updates one of the Linux target or Linux host but not the other.
>
> Note that similar changes have been made recently to "HostHost" and
> didn't seem to break everything
>
> 7e091add9c43 nvme-auth: update sc_c in host response
> 159de7a825ae nvmet-auth: update sc_c in target host hash calculation

Still doesn't mean that it does not break folks.

I don't see how we get around not breaking other than introducing some
compat mode under some sysctl (yukk).

Perhaps secure-concatenation is new enough that the breakage surface
is very small.

> Alistair


