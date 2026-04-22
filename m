Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEDDF9EDC9
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 13:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lX3E3l+CUAgEBuMjhKQAoF+ulmwAQm3ydVikfG8HXnA=; b=y8deNKPrQmgpJA0E44rV3z2KzZ
	SjGfG9RJhupCmCuoJSo5xphKGB0wrQCShg0vsX7fEsa2RhRiLi4jOw7W3kcZTdVQZeYRueXkjb2tL
	UOx5DNntHPNCD2cQg/c8PYL0/N+BiHh7urkQkD4PfC30B52MH1sxnvxXEUmWfuAI8S281vTQlbf+s
	B95gtypMI+356YQerB+/4c9Q96A5TqCVufzQ2X7uy/RxHQ+HSYgvD8TK1bwftcKmlm5jem15f49R4
	EW073d/wuoom627JFrMsEgthz35n0uMfMPIQrGsOMVRnAuMWO1hfIfuAPdk38FwHY/UMxxGyApdOj
	hMcsx+1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFXO1-0000000AGlQ-3b76;
	Wed, 22 Apr 2026 13:13:01 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFXNu-0000000AGka-0Q7n
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 13:13:00 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-c76c60c7502so2370639a12.0
        for <linux-nvme@lists.infradead.org>; Wed, 22 Apr 2026 06:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776863573; x=1777468373; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lX3E3l+CUAgEBuMjhKQAoF+ulmwAQm3ydVikfG8HXnA=;
        b=BFfHQYYzpnne7LOlCWVxia2Q/zy+UK+yuMzF6HdYpRnx1TuIA5jxD5B9o+xMB0C1Q5
         bETKlqTd86ytVsf6+KvMXBQn/J80XZwt5K/0A7EPB1SgGgCbUV3F/u+LgowK/O1NOXk6
         QnDoZdX/vx0mhrgZXh8KwKv/2jrKc2FiQGSE3y5AiUimo0ZP4qPWcSoL/xc+jxtmgu91
         mFmpK+lxPSJdLNU0z4Vz+QsaV2rKTFNvPNCo6J69txBQIQICuXP7gOS372w2neE99yy4
         DVMpFpJmv2Bpmb8i+4fanycJXO4ZTbKkpQAxi9SDCIeT8eqq47Vm+mS8+CNcOxgiKmdV
         ou3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776863573; x=1777468373;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lX3E3l+CUAgEBuMjhKQAoF+ulmwAQm3ydVikfG8HXnA=;
        b=pjfSk12ZOWkDI6Jwxqw6CLRlhjfevTrbBSul+gDjr9vlC5jZAHx70poCg22uWQopRa
         Oaz2O85a2BXfY/PaO3mvTvMe3hgcshzi2M556+x7y0BpQmeTwe4wYxZ1i3Nr1jWwbsaW
         lxn2vs83EzOwDTjZjyuOe65se895UW/xbOIHlb4AWo3JAnBKdUzwL/xPJjU7lk0gORZk
         G1OCcTIcrtVD4486Z1L9eTAuajREqxy4apnZBHTHTHhXwYw8E74sldxYtFoy/TCgnCi+
         DXXFGuEKbvtVYgU/qHY2X29PRSVkXIadSQonjHJEpcVAaOpHKABXYA4Rse6phsyRX4UY
         JsQA==
X-Gm-Message-State: AOJu0YxfXZm0U5+XB+iVsEMAsnk82e2MZUV/67O2WMx814mh8CLFrsxA
	GTyF+s+d3xzUv+KKGe3NvuLt3tGWVDdyNI0PTx+HGVLCt/xIap6whofEbR64Wg==
X-Gm-Gg: AeBDieu70Uw2igdLmQbuyrJ6yphb3eeNl/d8yld1VXKFc6pT6e70QWAOxzbG92mauvO
	JrYPkDZbE2ATq1m1skW0hK3Xr3VoX7pXQTuKHAriGyq1PkZoBIU7eLdreUvZ4cT4Ohz+Kk4EiHE
	cqdjMoPC571kie4YITlKW//uOMn8OrzT16XJ4KfJ2x7rJHZMwUYcNT6zXtnYAavQl6CkctzHIUL
	12H/eCJhB7oCpp9KKg6SJKyRhF/lbDMGRCK1vNUpplgnF1Wg5zXl0FJbdFpqgOlTkzV/l5cDToT
	pB+e9vfMtlUYeA9m4ltnPstvZ58xH/hM68OLRs3Sv3ecB8wJ3Lj8f7MlZXaZHly9z0RUB5g3Vq4
	lj7mIfJ8BnyyLThEYwjVM93svolGuuKlgSI00epY9aDYFsSJ3feJX9q/3dSkSHSzN+O5RINCjL8
	Re5omAgXi+zAmiCgr/6QXz17DKjYcmfDxuIxoIfuOCebXz7l/mgJNnxWFYryAhb1KMklfqHiB2t
	+8SMLE=
X-Received: by 2002:a05:6a20:7d9f:b0:39f:3559:750d with SMTP id adf61e73a8af0-3a08cca99ddmr20161621637.31.1776863572986;
        Wed, 22 Apr 2026 06:12:52 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:5cdd:bd85:7f37:6252? ([240b:10:2720:5500:5cdd:bd85:7f37:6252])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f8fcbdsm12674035a12.6.2026.04.22.06.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 06:12:52 -0700 (PDT)
Message-ID: <00eaa0f4-365f-4f23-8e81-6c3c96e8d175@gmail.com>
Date: Wed, 22 Apr 2026 22:12:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: set NCC and NIC effects for NS mgmt and attach
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org
References: <20260418130604.23441-1-ikegami.t@gmail.com>
 <aehkG9i9yisZgRR0@infradead.org>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <aehkG9i9yisZgRR0@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260422_061254_425163_9DED6279 
X-CRM114-Status: UNSURE (   7.76  )
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

On 2026/04/22 15:00, Christoph Hellwig wrote:
> The subject here looks mistleading and the commit message is way to
> spare.
I will do update the commit subject and message. Thank you.


