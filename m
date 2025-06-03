Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B1FC61CE5
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jun 2025 15:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iFaVKSeVDuU8dQaldfMzU+gKmJroS7Q/UI0ReFlo5es=; b=oyRJYtl8zFx+Ijkpc+J9iWq8zY
	om6+cARR5uVnZz/cPJhogIgYPo8NVNVgKtiXtLAjXRRCeYM2A37safjLkPEWhdtj0uGzjiuLGWgN8
	d5ORylJUx9biGxAcUaXj8lYNgGo+0ZB/R4zYeMroCQvv8cOFQnLaMStyB6C0TuF83TYXUiRNhdNDt
	3Lqa4ECH3xRCuIeSn2qEFLuB023yv8NVIwk4UNI8Pri5Tb/T9b4QxhJFXvbTDbw3137PXhBmynP1r
	y1W+3F2sMKQcGJxPvPMmf/J19XoZPdnIpfs9UejLClrmPhuWVj39mlQi0hP1wfES+wItKgu+kADRo
	Ydakwd2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMTZ3-0000000BHWH-3Xd0;
	Tue, 03 Jun 2025 15:28:33 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMSLQ-0000000B8nY-2Jyk
	for linux-nvme@lists.infradead.org;
	Tue, 03 Jun 2025 14:10:25 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-23526264386so39885295ad.2
        for <linux-nvme@lists.infradead.org>; Tue, 03 Jun 2025 07:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748959824; x=1749564624; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iFaVKSeVDuU8dQaldfMzU+gKmJroS7Q/UI0ReFlo5es=;
        b=RrFvbnvsyQ+KIG5JMRZAVMeoBFtLAlUOXCqMJTm044zdFd2hll5a5oKSM4kUw0OTMF
         8pEUXTyWI8khp8VLAGlCA7xrbpM062XDT2STCgY9UOZzAJyn+Olz4b4VZa5+zP9zMivx
         +vbIMPzAk9GX6tsTqsO4WcLJTiezMJsAmX617yV/X4xxP6idLYkYhqrAwAeiEUD8NDgV
         laDG2KTSz+I4wEeAltE7u/GC+NxmQBOKvD/i1y6Wd4N19YuTmTe96YLlXJ+A9+CvdIKZ
         tYCS9Sx8Qpk4CiRZQ7R58xW7Hgq224Yp4ghY/AoSbIKocffTV9nzV1jrXOL+WjMYZgda
         i7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748959824; x=1749564624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iFaVKSeVDuU8dQaldfMzU+gKmJroS7Q/UI0ReFlo5es=;
        b=k1j8TB0Xewb/jsM8ojkw0wZILYc6RgaXvaYWZq3knW9LbChxzvdPyTQLM6v9F11JOt
         zLRoy9HoLLju3gBpc3dCSYqq6Nw+9Me17fyygekjb5vBS/xmP4sZiRgTLdzWL9lHXy1S
         HJu2OFXixH4Tq6qvKRNMha7hRZwEqkm/55gPvMEloQOWn9W0F3sOO7kWs8T/2rV2dwEH
         5InGPFkm8Vz1TJfPHDShSMvggjpBg4kwJ1Hlv3oPdlr3KsfEVHr1FnT8cUjb2Wem7Rd/
         sLN5u5M2CEZLM154aFF9tIY6cono0dXmusytnzMxYSBtsublOr1VLYzUxIZjgTA+4LuT
         usjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVSCTjoiMBDK8FJcxQggYng6PtEx5sg+Iqa46KOb/4IB90HO5FUO7Zcs8sBr5d/a4LifiVcgNLk9k5@lists.infradead.org
X-Gm-Message-State: AOJu0Yxod0SjsRd5sk3w7J4odEnd0ocWGnKyEJrg7SqwWhmD8Wcn4xQf
	eO4rakvDX+p3txYMMpzFJ4WUmeL+dIoKH0ozrVwzd2NgKM8SuF7dduPBHajS+Q==
X-Gm-Gg: ASbGncuDfhbCi/FZFjezi2D+HHdHWO7VOh7uBHWJb6YAq6ZBwhyzZI0QQps096o6BG5
	LpQ0bVquWyg/sh0TedlyhdmJ3eWpJgrEUb1GCWlG6F7ZZOCBVNL4SaSvQfVpcrtvd9eNUx6DdMt
	S5dUYnagXqyjuBz5SeVX3nY0ruWh7tF5L9jmdIjRb9lPcP0dxzOOyBwuPsg3iG7grwQh0Hm97TW
	nhwKw+7E93myjiAj3kXedGrDkwbPn/qC78bmzJ+ISaBa++4wkG6quY2zP6IIzhimBxsUPOUd3hm
	VCKw2kGvMxU2ggc0/QTF9LzT51Tzr4SpPDHtml0FqjUYJz8QsfRJJp5sExjp+tlRQDSskh133jM
	WSSEX0LVbsTQkJNVgvX0o9w==
X-Google-Smtp-Source: AGHT+IGRDdmF15TkrB2o3ftV7GQ6ZJwU4ae+MH7oGnIKy9CTtgWI7LJox9BzbCpAq1n+iDcMwHg6+A==
X-Received: by 2002:a17:902:d488:b0:234:d359:7ec0 with SMTP id d9443c01a7336-2355f9d7959mr158217195ad.30.1748959823564;
        Tue, 03 Jun 2025 07:10:23 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:f673:8e3f:62c4:400f? ([240b:10:2720:5500:f673:8e3f:62c4:400f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bd9705sm87603885ad.87.2025.06.03.07.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 07:10:23 -0700 (PDT)
Message-ID: <c1e8cb8d-855a-4c0a-9ea8-1e13c2571ca5@gmail.com>
Date: Tue, 3 Jun 2025 23:10:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-pci: add NVMe controller statistics
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20250529172954.5217-1-ikegami.t@gmail.com>
 <66e31639-d516-4d33-b51d-eafc77697ef6@nvidia.com>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <66e31639-d516-4d33-b51d-eafc77697ef6@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250603_071024_598347_EC3F3B8D 
X-CRM114-Status: UNSURE (   8.90  )
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

On 2025/06/03 9:51, Chaitanya Kulkarni wrote:
> can you please update the commit log with why you want to
> count the events at the first place, what kind problem
> it is solving and any impact on performance because of it ?
Just done by the version 3 patch. Thank you.


