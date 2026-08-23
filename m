Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC13C5DF8C
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 00:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AVEWFdwq8Xwpq8Wv8Dp7YZqXKLEzexdEFR7B5DRQc1w=; b=3eaedfa+blYpNHhEXLqtThr+5t
	m8a7B70EJ79h5/kxoaYZFVVlZQnvmTK5ozsHoUsl4mgL62ShAXKuuAN05TvoWx3JexEoulSEKgAXA
	r8iNj51WFcOG8zeLymj/YQfszrP+K81IkznoeKFIICz+vc5vdYFuHE/vTGS7LjKfYVsQrep58U2x3
	ZTY44WWoZ3Cw9ySmjKGHI4tGEwFGOzX8WopUWJTPbe948QWex+88kfO+/rnsAtF8oMRcWmNx8UigP
	rHlZZmkkB11WYTzVe9mwVbB54lc9ubIqExO3CNCCdPnwMpJQPLuaMRP+qONfmbuLIJBBIPTq4jDHW
	eup+49gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwML-0000000Ew3J-3Atk;
	Sun, 23 Aug 2026 00:46:49 +0000
Received: from mail-ed1-f46.google.com ([209.85.208.46])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxwMI-0000000Ew2U-2bO5
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 00:46:47 +0000
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a28cbdso4122685a12.3
        for <linux-nvme@lists.infradead.org>; Sat, 22 Aug 2026 17:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787446005; x=1788050805;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AVEWFdwq8Xwpq8Wv8Dp7YZqXKLEzexdEFR7B5DRQc1w=;
        b=V63BqlikQJoCc6CVJB/ZzRnwJzW+1SRDOZi6mSX87M0nLhQNg7DLeiJ54o19F8Bhmd
         FynnhLp2oDZWp/U1ki/RktMxHXFx6vrO8IszsVrDBp2J7T9tZ9sCMBNV1UVNJ6UvIPU7
         DEHQelZrBUXcir7uji6HigcPYJOjgmdU6hJpVPrjNt8jXKXJGg/5FZwkbL694Vtd5eyj
         YMjP7Ri0sQ8Leqtdq6EVOZt+cGiZCnrlHGOIRXhAb+8d8ye5B1Ni5Hip2zVCP22V3sZO
         rSpzWTDZZtcnB/osoCalxuZP4Ye3B2Rm2f25gU/eWTnuvV2Ll3yoH+piM911S1Sud6ug
         ffhg==
X-Forwarded-Encrypted: i=1; AHgh+RqO4U9EEnb4kcFGBnZ0zzoqg43ii7zQoFwCO2EiaT9l0OLdXMI+VjzDxyW6IBQUmq9u7kLn6UmAyp+L@lists.infradead.org
X-Gm-Message-State: AFuF++mCpJtz1p9GisYq5/xiOsQAGFbAdwDNHojju3jKWrMhgE/xzfQD
	tNrLCR9TNbLsW58yDpBaiuA+csagam2O6h5MyObM29dZ3ZZbKsM9GhTA
X-Gm-Gg: AR+sD113Mkpr8ZBraqcnqnMoGAgX0cqt2DXbIP3TNJGYhK/77wjRV1p9Ay8hlMiqr8E
	n8RHrBPIadWCk+l180iGLuq1PFdM840H7W06xoacpoS2hi3pd0PZl4t8yy1hRwRlZQ0n2i2AADj
	+qqEGJnA4PonS9O8+4NToEbLiHHxErO6Zr48s+CrTNnWutZa8Tu/C07P9aMNsDILio7kMqNkQSQ
	ceFyXT2QhYy8LPjOi+xLl+iTExB505GzhoCgmLjUoK3F9AagGeT/z6dE2eaKHX95YOy/QMDMWNP
	LJHw6A6d7DzaYJMv0C4wP/beSjE6Ni8PIDn9pAK7kfQSFEUIwNczeEjG9R0OoAetgTXKrt2VKxn
	6iu69butS879930vMgJGFNFYgI0I52U/AtNN23l8kOLK157glzkajzsYcjQ/HOHEiDL7FrTPM30
	R/JFlIdzWGTAzCXGtmFlv0R/WJXVteilEeJlnxC4+E0kJGBOQMTrgfwe7altZg4x4CY5qjx+cB9
	XnWChVbBCFUW5E0UBev6+Gt
X-Received: by 2002:a05:6402:2109:b0:69e:8ad:5162 with SMTP id 4fb4d7f45d1cf-6a582af9528mr9856294a12.1.1787446004611;
        Sat, 22 Aug 2026 17:46:44 -0700 (PDT)
Received: from [10.100.102.74] (89-138-65-240.bb.netvision.net.il. [89.138.65.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e012f84sm635292a12.8.2026.08.22.17.46.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2026 17:46:44 -0700 (PDT)
Message-ID: <d58d0c4f-0789-4c99-94bc-e2e2121e7b7a@grimberg.me>
Date: Sun, 23 Aug 2026 03:46:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] nvme: Add module reference counting for multipath
 devices
From: Sagi Grimberg <sagi@grimberg.me>
To: wenxiong@linux.ibm.com, linux-nvme@lists.infradead.org, kbusch@kernel.org
Cc: gjoyce@linux.ibm.com, wenxiong@us.ibm.com
References: <20260812223206.720363-1-wenxiong@linux.ibm.com>
 <a9d90f41-1493-4efa-abd1-a7071046414a@grimberg.me>
Content-Language: en-US
In-Reply-To: <a9d90f41-1493-4efa-abd1-a7071046414a@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_174646_673186_5683291C 
X-CRM114-Status: GOOD (  11.73  )
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



On 23/08/2026 3:20, Sagi Grimberg wrote:
>
>
> On 13/08/2026 1:32, wenxiong@linux.ibm.com wrote:
>> From: Wen Xiong <wenxiong@linux.ibm.com>
>>
>> Add proper module reference counting to prevent premature unloading of
>> NVMe transport modules while multipath namespaces are still active.
>>
>> When a namespace is added to a multipath device via 
>> nvme_mpath_add_disk(),
>> the underlying transport module (PCIe, FC, RDMA, TCP, etc.) must remain
>> loaded as long as the multipath device references that namespace. 
>> Without
>> proper reference counting, the transport module could be unloaded while
>> the multipath device is still using resources from that module, leading
>> to the potential system crashes.
>>
>> This ensures the transport module remains loaded for the entire lifetime
>> of the multipath namespace association.
>
> Can you provide details about the issue that this patch is supposed to 
> address?
> (e.g. potential system crashes). The driver unload should be able to 
> disconnect all of the connected controllers when tearing down...

OK, I now read the original report regarding nvme root device. please 
disregard.

