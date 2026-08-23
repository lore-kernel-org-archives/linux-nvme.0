Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728D9C5DF97
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 00:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PXD5E45wc0M6cedzY5kSWRxZkYs/VgGILi+wUz8cYPc=; b=yLEypwjvdyMUKfI2MJNS+vvZMS
	avp7BIPh8O1KQPbgK0RRVfSxMQpUHq9cOUESD+bvYG4wI27osEwBRIG3vHNGXt2JCrZYSQ9NwsCK7
	yxGNugUjvNCvR0f8wQvGgzNQx+Jjp7tD3CWkMtsG0O7hnZzbQ/SLPWELiURv3NQ7td2SOgI6hSk3q
	iFNtPv5r/xzzNl0XTxUYyPS0x/86IJj3smiuhSzSEvs7/Yr0jVfYLYoBFigxAi9uTSuqC828OAOTG
	U4ita39kclEYOp8KiduzWLsB96frUuRlHnreZ00lpYuq+1EXl+35dYub5gOpXa/26CztjitP2inYP
	8GpNTWwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxvxG-0000000Ev3G-24c9;
	Sun, 23 Aug 2026 00:20:54 +0000
Received: from mail-ej1-f50.google.com ([209.85.218.50])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxvxE-0000000Ev2v-2ejP
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 00:20:53 +0000
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15e2dab83eso433945366b.1
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 17:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787444451; x=1788049251;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PXD5E45wc0M6cedzY5kSWRxZkYs/VgGILi+wUz8cYPc=;
        b=DXralknLOSVT8ChUXKDTld3yklvcDYdV46hPFwjl9u9ByJ/R2CSm40hQBNZPeBZQVF
         HTtJ1GEtflbMPqjF4iVkxpVphO32mLbQ0cpLeshWZiSVCYAK87M3VKsq2IOcgpXrdcAd
         XMTJO9A7+tQmTC/A9s3saDgV3xy4s5zHRvDxfut61np7kT8cPdB9Y4DfHF3zLDQrcBJ8
         xjAVNatTpaKePxIQDzm6vcPfL67JRzINH/4ZeYXrT5Ppburraw7GKZ/yMqOpCrIhQKaJ
         PLyT0wTgFZesT2dZ81SjQWjUL7y3BobwQBVKAB5RLfoKQhwlCrOBy71w7n0O/+VL9nN1
         /WpQ==
X-Forwarded-Encrypted: i=1; AHgh+RojpHohbSbosZIIiL00oRf+Yj3Ud7MoUjEJETKND4U9ARQtPQ054AFN9YCViAUPEp9KB3M/ynZ9G0Zz@lists.infradead.org
X-Gm-Message-State: AFuF++n1F+El462I/y4TNIqHabygog3IXpS9wyNUkWSRUFO3rWx3ArIe
	JcwPMmgptYTod5DjXONbF4N1shT9R9TH6990qPkv/D0q5FXnA1t6me+F
X-Gm-Gg: AR+sD12XIdGNocQtPqhoiUuLycoyUC+LRtsAtxtItjxjmAcZgXtN1ayexr5+SDR7IfM
	wH0LehXtBTNtHnRnD5eraUWYdUFs2dTE7EJmxnzS2/5DFg5vQ+OtRgr8vKeadxdtF69VOznwxhn
	AF/CLpj5SW+oYfh2qNN4DJl/OmMCqy+rBE5zGifjbSTbonbZUvY/WK9R881quyHqvIT74O1vW1Y
	b90sQ+tSkxZj5qYZQsK2dUekWAzBVU6mOZLt1nY0M5IVLD/UEXKjjmZGcjRUZDijEVO81jc856g
	Ra2BABQIzOJ6qOqDguyeLA7L/4UU+eQELEVzyoYtoIFSyWMIaOlHIWC5SY3EKkh2PkuXqQ35Mr9
	pHHa+ATWp/d5jxZOWaJfENMJBpsMpOzHkuirXT5CFEOJYVo+yWM2phwvSpIC+mYEAVZmoghi5pO
	x5m6XKuXgv3fOv51WXGpAsjJsoNU9WUXSrNcR5ynAgxxq0TfbC5JWLSYilT/ObCYBWztic1sLIs
	QBZhTuv0/WlERDxEAZ2XgP0hHc7415eOg==
X-Received: by 2002:a17:907:c50a:b0:c21:1b58:fa96 with SMTP id a640c23a62f3a-c246a39f3a8mr1805216666b.3.1787444450742;
        Sat, 22 Aug 2026 17:20:50 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24966f6adfsm509042366b.31.2026.08.22.17.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 17:20:50 -0700 (PDT)
Message-ID: <a9d90f41-1493-4efa-abd1-a7071046414a@grimberg.me>
Date: Sun, 23 Aug 2026 03:20:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] nvme: Add module reference counting for multipath
 devices
To: wenxiong@linux.ibm.com, linux-nvme@lists.infradead.org, kbusch@kernel.org
Cc: gjoyce@linux.ibm.com, wenxiong@us.ibm.com
References: <20260812223206.720363-1-wenxiong@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260812223206.720363-1-wenxiong@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_172052_706733_F08BEE3F 
X-CRM114-Status: GOOD (  11.56  )
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



On 13/08/2026 1:32, wenxiong@linux.ibm.com wrote:
> From: Wen Xiong <wenxiong@linux.ibm.com>
>
> Add proper module reference counting to prevent premature unloading of
> NVMe transport modules while multipath namespaces are still active.
>
> When a namespace is added to a multipath device via nvme_mpath_add_disk(),
> the underlying transport module (PCIe, FC, RDMA, TCP, etc.) must remain
> loaded as long as the multipath device references that namespace. Without
> proper reference counting, the transport module could be unloaded while
> the multipath device is still using resources from that module, leading
> to the potential system crashes.
>
> This ensures the transport module remains loaded for the entire lifetime
> of the multipath namespace association.

Can you provide details about the issue that this patch is supposed to 
address?
(e.g. potential system crashes). The driver unload should be able to 
disconnect all of the connected controllers when tearing down...

