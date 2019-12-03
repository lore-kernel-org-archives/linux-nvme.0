Return-Path: <SRS0=ysN4=ZZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524BEC432C3
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 16:19:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2387D2080A
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 16:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dETBjG6h";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d1mATu0T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2387D2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OFND+eNEFrlftBaAOAftRj28UONOgaVmqdIxHQOFrh8=; b=dETBjG6h6fo2mIZBqD2d5Lnd2
	3afbwfUXE8wEO2Ay5gc6XP0i3kM2lEVL8vjFZ+9JuicWedSoNb8PHjGuElUkmGAEbWpIUfniuag2a
	1cqIS7en/+YL30/8P6LmGQPUg8H/xaSJRyxt4GR1QCKAbjgnxU4taCIezEdlri5t6iz9QDhIM44k0
	2sGexS3SUdmKx7rUEi8S7cD15n646+M8Q2DoRHVU3e+HQtdcMiUSQwA0Llw+4d6SSBKRXFFXW0Eet
	cQnV6uuAOM/ENov06nlEER5kXvBvfn3+e8JZYt4bFWt2PFM35KjuaDvk91UJ4G0fgSmeivASOrqDN
	WaESwHidg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1icAtk-0004nM-GB; Tue, 03 Dec 2019 16:19:36 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icAth-0004ml-G6
 for linux-nvme@lists.infradead.org; Tue, 03 Dec 2019 16:19:34 +0000
Received: by mail-wr1-x442.google.com with SMTP id y17so4407482wrh.5
 for <linux-nvme@lists.infradead.org>; Tue, 03 Dec 2019 08:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=Fe0+1ySyUSEKUxfVKJHkZnpx+cG34Az8ttdTOzEtESA=;
 b=d1mATu0T2SSiqGDW/io2RRnqintMOF3x3XsvqClB2kJlItdYh8CNJRxf945jw/OLXy
 lNcL6Lk5Kb9lfhwWgzL4skjT5/DNegv5er1+gIh83s8mp0MUmweEKuBkQKBKHDMDTdxO
 4JTLQ++Jd+1RxUZZFuBumgGue18JpJJDX4wtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=Fe0+1ySyUSEKUxfVKJHkZnpx+cG34Az8ttdTOzEtESA=;
 b=ekSEEEHRhMXBSgcScj6AI7MLsWXvnIpId3TiM6Il3SSlaSUlGPBjTi5GPGwqvZY8pc
 Y9YgyQFRH7krkTEgLODrvQG9UF7VUtysGWCByc2DD9lwWe0DXd9q2xtrhLrnx39PhfBR
 j/8Ytv893Br1WVPUQI94Z2DJxPM31gbVHIEN3x4rvZxDDCqh3fov8xO36elLNgP1jEby
 i2qInwkgLMPOM2ro5RLNyv65F38Skd3ww5OgZKvaotR1qwEUXn2RJC3rUhaD631dXGXS
 HMcBmppJnDvLakOiiu/H3OoS2KW0odo4ATrKUX8kvXRFIpe2k4oMffQjIPQKDcAJWWqF
 7IGQ==
X-Gm-Message-State: APjAAAXtPcugYDwdTIt0gjDg/Ep0kQNqXJGIrOcakZqA4Sz53sOtU0ZA
 nBHOg4ibttVLx9OF+X5E91AB0fP+ygszAVj9+18lsJp5BOhdHafqdKWi0eDhgt7NPe7nCYTI/eZ
 k0o24LWOva/eNHZj8ORacPZv0LLFF9HFVHlUyUa6ZiTgpkdB2oQjcRZuw9W8ETTSxWKNcr3S3uk
 EfHnNlMw==
X-Google-Smtp-Source: APXvYqylUCJed/cBpvdaa/zNpgzqMr3uc2Gdf8MS8/3O8IX04a8KaXvytNUg538xOTcV1eeEzBd4xA==
X-Received: by 2002:adf:e301:: with SMTP id b1mr6081466wrj.280.1575389970322; 
 Tue, 03 Dec 2019 08:19:30 -0800 (PST)
Received: from [10.230.29.90] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id q6sm4497919wrx.72.2019.12.03.08.19.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Dec 2019 08:19:29 -0800 (PST)
Subject: Re: [PATCH] nvme-fabrics: reject I/O to offline device
To: Victor Gladkov <Victor.Gladkov@kioxia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <2caa40133c444771b706406b928ad88a@kioxia.com>
 <78d980de-b2b8-bd47-fc3f-20314653598e@broadcom.com>
 <c625b332ee124b038da1ae59b02f4e21@kioxia.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <9a73a895-7d6b-21e9-9008-816117be1ff4@broadcom.com>
Date: Tue, 3 Dec 2019 08:19:27 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <c625b332ee124b038da1ae59b02f4e21@kioxia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191203_081933_539179_9F8248ED 
X-CRM114-Status: GOOD (  10.49  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 12/3/2019 2:04 AM, Victor Gladkov wrote:
> On 12/03/2019 00:47 AM, James Smart wrote:
>> O
>> James, thank you for the suggestion.
>> But let me explain it differently.
>>
>> Applications are expecting commands to complete with success or error
>> within a certain timeout (30 seconds by default).
>> The NVMe host is enforcing that timeout while it is connected, never the less,
>> during reconnection, the timeout is not enforced and commands may get stuck for a long period or even forever.
>>
>> The controller-loss-timeout should not affect IO timeout policy, these are two different policies.
>>
>> Regards,
>> Victor

Ok - which says what does make sense to add is the portion:

   !(ctrl->state == NVME_CTRL_CONNECTING && ((ktime_get_ns() - rq->start_time_ns) > jiffies_to_nsecs(rq->timeout)))


But I don't think we need the failfast flag.

-- james


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
