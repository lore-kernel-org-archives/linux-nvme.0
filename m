Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3720C369D7
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Sep 2024 12:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e1vsdKX31ZQMJQnYW8l7+O8odVCjbHrQhd7IsOPE+00=; b=oYL5JmNFeTKmwWppsNlArgKqhO
	L7o16xYIX+BXGJ+9YkYW9+H8RhRLhi3PX6aRh9tJKXxwuyf6kHWOeAgqifbB+jQ790Y4rTcXPhgNe
	BdS0BxnXde4Gp36KfAvXbLWXrrnPImvOneftglM8TB6rnkzktaaG1IlUcKTqcBYh6ZZDg54IEEnlz
	I2wZ1Dh3U9oBcBRzwGpSjVXCptU2l2FswgIj/CnlJ/qzm4bsKvBIrbHV9OiW/FLvsYQ9W2Sv1O7h3
	r9TI0SFPW1vMrhyWk/FdC+ukOaJrf+cUaeVCySEWhniN+kwG7yFup6uCXXgFtSKVgPV5b37Pgk1Z0
	1olwmZ1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stRBm-000000059uS-19Fg;
	Wed, 25 Sep 2024 12:32:14 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stR2U-000000057Jn-1v9q
	for linux-nvme@lists.infradead.org;
	Wed, 25 Sep 2024 12:22:39 +0000
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5c40942358eso1609847a12.1
        for <linux-nvme@lists.infradead.org>; Wed, 25 Sep 2024 05:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727266956; x=1727871756; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e1vsdKX31ZQMJQnYW8l7+O8odVCjbHrQhd7IsOPE+00=;
        b=gVWNvtIX5+/LozkPKKN43MvPdUZpAY2XJM0Vohv4f82dG821c2yzwOibWsmUN3xFFK
         NJre3ie3VWHOMMQnyXRzpUCI1Zam8HMhltGmvP0xsqYVPCYCZpH50+goqo9QiTAxPVKC
         zQQGb8hk+jFPZazlFkcyPWg5dkkDBlkvttBmI4r4CWyfICH9yzRDwDSiriQI/7HYzKRy
         FATrCJgY0Wrrw0vGzxS0QSYE3IC/cv0mQihwJjmP7u0/WpeR9weGmjHFgguTHHtAVXSb
         2mkXWRzmqqrQ3fsCaGLQaN7YZliByJC6Y6aQ3Ze7RCLRykBpcWzvDwPEo5TE/Io7Pi4r
         /aFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727266956; x=1727871756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e1vsdKX31ZQMJQnYW8l7+O8odVCjbHrQhd7IsOPE+00=;
        b=JPEvtFGEdzvlHG6QlE/3moFPcrNofOfppwDEtvqHpGWEDVp8b2X6P2bjwXpQTVI06H
         RvBRljkrREwR0bHqwAX9HNAGyB5Tf0LgOzAczEcMSbG1peDJl/vKo3leH+zhX5jqDOVD
         aw5CYUEFxgHv22uTMMbtBoDWGaocNLA1EHFqhxwFX0LK3fQp98ZmKH8az/GPlfhxtVQk
         mBS+kaSB8gVsYdtVaPqmTeQhln4tEe/xWbogSgXI01+PChGNKLS3B7dU1RFJdk3nuNeQ
         EA/ooCp/6BdDiCTT9qNncKGxAsXySNYzG7TofMz7wPyVcEa3+fOdJXqx5oKn40KYbUBo
         CgOw==
X-Gm-Message-State: AOJu0YyWeG4oCpkHHv5Byh/Pd58t+orQ1z0fm3DWBuQ5yfLo9Mnp6SUJ
	ecIQG57uOu6vCc7vkb17r7az3Z7a4yCb6IB/sKuKHrFkRLCnkvot
X-Google-Smtp-Source: AGHT+IHy8FnDpRRZ0xuHx941u/L73CdgNsgVKXSABy4Wq1uMlQmuwdBzBKZV8xBOb4xFnl0sRAAXbg==
X-Received: by 2002:a05:6402:13d2:b0:5c4:1c0c:cc6d with SMTP id 4fb4d7f45d1cf-5c5cdf051d2mr7695812a12.0.1727266955977;
        Wed, 25 Sep 2024 05:22:35 -0700 (PDT)
Received: from [192.168.92.221] ([85.255.235.163])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf49dbbdsm1802486a12.57.2024.09.25.05.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 05:22:35 -0700 (PDT)
Message-ID: <cb3302c0-56dd-4173-9866-c8e40659becb@gmail.com>
Date: Wed, 25 Sep 2024 13:23:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] io_uring: enable per-io hinting capability
To: Kanchan Joshi <joshi.k@samsung.com>, Hannes Reinecke <hare@suse.de>,
 axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 martin.petersen@oracle.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
 jack@suse.cz, jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
 bvanassche@acm.org
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-block@vger.kernel.org, linux-aio@kvack.org,
 gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com,
 Nitesh Shetty <nj.shetty@samsung.com>
References: <20240924092457.7846-1-joshi.k@samsung.com>
 <CGME20240924093257epcas5p174955ae79ae2d08a886eeb45a6976d53@epcas5p1.samsung.com>
 <20240924092457.7846-4-joshi.k@samsung.com>
 <28419703-681c-4d8c-9450-bdc2aff19d56@suse.de>
 <678921a8-584c-f95e-49c8-4d9ce9db94ab@samsung.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <678921a8-584c-f95e-49c8-4d9ce9db94ab@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240925_052238_517520_2A3F4B5A 
X-CRM114-Status: GOOD (  13.67  )
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

On 9/25/24 12:09, Kanchan Joshi wrote:
> On 9/25/2024 11:27 AM, Hannes Reinecke wrote:
...
> As it stands the new struct will introduce
>> a hole of 24 bytes after 'hint_type'.
> 
> This gets implicitly padded at this point [1][2], and overall size is
> still capped by largest struct (which is of 16 bytes, placed just above
> this).

For me it's about having hardly usable in the future by anyone else
7 bytes of space or how much that will be. Try to add another field
using those bytes and endianess will start messing with you. And 7
bytes is not that convenient.

I have same problem with how commands were merged while I was not
looking. There was no explicit padding, and it split u64 into u32
and implicit padding, so no apps can use the space to put a pointer
anymore while there was a much better option of using one of existing
4B fields.


> [1] On 64bit
> »       union {
> »       »       struct {
> »       »       »       __u64      addr3;                /*    48     8 */
> »       »       »       __u64      __pad2[1];            /*    56     8 */
> »       »       };                                       /*    48    16 */
> »       »       struct {
> »       »       »       __u64      hint_val;             /*    48     8 */
> »       »       »       __u8       hint_type;            /*    56     1 */
> »       »       };                                       /*    48    16 */
> »       »       __u64              optval;               /*    48     8 */
> »       »       __u8               cmd[0];               /*    48     0 */
> »       };                                               /*    48    16 */
> 
> »       /* size: 64, cachelines: 1, members: 13 */
> 
> [2] On 32bit
> 
> »       union {
> »       »       struct {
> »       »       »       __u64      addr3;                /*    48     8 */
> »       »       »       __u64      __pad2[1];            /*    56     8 */
> »       »       };                                       /*    48    16 */
> »       »       struct {
> »       »       »       __u64      hint_val;             /*    48     8 */
> »       »       »       __u8       hint_type;            /*    56     1 */
> »       »       };                                       /*    48    12 */
> »       »       __u64              optval;               /*    48     8 */
> »       »       __u8               cmd[0];               /*    48     0 */
> »       };                                               /*    48    16 */
> 
> »       /* size: 64, cachelines: 1, members: 13 */
> };

-- 
Pavel Begunkov

