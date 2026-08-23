Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB606C5DF97
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 00:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Jry3bhto94EkXUrpTyY/2+6huY
	bJT+vtTeA69S7gPFuPD98/1Ye95pdNxeqrwwcFavRcQ6fIonQMTSwVgUi5u51gPe6Uc1bdvdRbd+U
	2UsaLEPoO8l8jyykNC529BI1jnEeus04yqFs8jq5VWr62MCTSQeChVRSFkyHK+bf6MK0w1/YGoBFS
	NfSUNDNifE10CKeTnPxQc0YQlDPytfrINyYpbOWQNJ8Ey+jxJv3BkeGVO1HF/SRblPLnImLGJedl6
	pt8mbDEqQv4x3dZiwc83CAfWIXhkLLw5V13uTW4af0DjiX5Et0eJfNJ4NIWzz+qL2ieZgg5Gn1yM8
	NJMZjUCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxw17-0000000EvN0-1OpT;
	Sun, 23 Aug 2026 00:24:53 +0000
Received: from mail-ej1-f54.google.com ([209.85.218.54])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxw15-0000000EvMO-06Kp
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 00:24:51 +0000
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1c26d7e951so329079366b.0
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 17:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787444689; x=1788049489;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=U4QJjivJIqb/Jurgj6neD6CdZGAKVH4G4z8EjEtlpqAKdQcgk5DZY0R5HQChteqJTT
         JpwcoWxlDuIMaZl5+AJyazWZ3JV5b/mexZOLypyrnOtB82xOrxwhl5QTszGF7koKD5i0
         zSPfs/NFIGGEjqNWakYDvmOJnQm5JPHRfn14To4cY2VA3Y1Gg787NsApmrhZo21becPT
         htq9OwLEqejn9NNbLWM+lwCzYkhdnDpJ0TeChQnAhatTquldlHhu/11VtX5Zl/Efl/f5
         MWWsd4/XJqDEA3RM3C/MzxHt5D9nVZizaugqEU0nvD/TAsQpXR4kflhW4/5tDmTm0WeJ
         bPpw==
X-Forwarded-Encrypted: i=1; AHgh+Ro1R7/5sg4FJkD3JdETpRsfRPLLRKKC0oj+gnu+4SZTElNmqwb7vZKJ7YpWgngKQ4WEc4f7RNWcatR9@lists.infradead.org
X-Gm-Message-State: AFuF++khGi80L47GImrrUUih9BEXJ9pWMaA2dfBQN1Cp4OWqSFNNuM1b
	oPJ/g54qtAn1oUhaWkzEFwO7WuA7u12cC9PVF+NufxMkEFiJb9nDpI98
X-Gm-Gg: AR+sD11iyRDAD4wY6n5Ze/xU+OUKmeq0sorU1LKjqZkVCPS8mYHBrkhcNOcWq8uZdY6
	1s6pGG/xmM82KUlcCoGZOz2UrGhNk499C0nd/SOgP0i7mkmPof09+xcAYIpxrVeNyRVC2LX0YRg
	TFLYS4cvcA1ro8OiBfNku7AqJ7IaIOOrv0IPApeBwBMU3DpVsRrqK6FUVgcKRkDfPbRPXchcIb6
	Zbz/QF9joq/zC8SqyFeumHQsb3mzeB6ddveHGq2ukTXo6Cp9DS6rIGDx9FnPv9XznscLY+eML1u
	ss7E5QRIh93rbiHrcaeBPwYXCIPGumGHStn2LXSoffLcdlSQLyTTBtj6Ytd8LuO1hLn0/ww67WZ
	EWMALW7b139mIXg70bB6ZDOgrwnAmXwbRRP+sOMAHnEZ/H+a85KxSsn1navKhJLXdkSrwM2Zq7r
	bq1dt5CN/s1nLnCZ3eA3CbNXlkrvov0T+HS4fuNXXkE17JzQi6Hxp6TdA64Cb9S6TG6Fuu1/rtW
	MIXVEZExzioLZCcV7pGXYk=
X-Received: by 2002:a17:907:8b8a:b0:c05:b9db:68cc with SMTP id a640c23a62f3a-c2469f7b668mr1795736066b.0.1787444689196;
        Sat, 22 Aug 2026 17:24:49 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24962a3c13sm578040866b.26.2026.08.22.17.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 17:24:48 -0700 (PDT)
Message-ID: <1c876ab3-e0ec-4c03-bb06-1f67dc4383fa@grimberg.me>
Date: Sun, 23 Aug 2026 03:24:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] nvmet: avoid recursive configfs open for passthru
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Jianhao Xu <jianhao.xu@seu.edu.cn>
References: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn>
 <20260819155228.84938-1-runyu.xiao@seu.edu.cn>
 <20260819155228.84938-4-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260819155228.84938-4-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_172451_061197_2C28B80D 
X-CRM114-Status: UNSURE (   5.07  )
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

