Return-Path: <SRS0=yBWI=D6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B750BC388F9
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 07:50:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF2742085B
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 07:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0gdkeDc0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkP3uQto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2742085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2UvhFAI7dyhrVlQfOH/vhMM+kGmZe3T3+aJZI+zBwsM=; b=0gdkeDc0N4pZv5KTZ1CFAF9H5
	2wtF0VXOhY/z1h9Si3M9o3pU+omvLvYF2AxGEGHHEIVUcau4ukMBGMet8RsI/Gnd7i/Spf3bD+3Xq
	VhDxYQo23FU8Plx50mRDXBnqU4AWHjUvdmLpJ+rlW4ZoA9sZCIZJ3ji3wzxF0J1Eml3na1radckuW
	ImfiNJqKIbvGYYMYI5X1rDWZ3kNeoPpaW1HH1QEDO3Gw3TkkMi9e4tInv41BxqmvGU5EQXxuoJWZG
	yoC+dMWXzfYslOpKeOui/+I0pFEe0QZr2UnZWdVRwm8RdsUXN8iPbcJQojFuYhSZmxMF7pVuiA53Z
	8EXjLEuGA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVrqb-0005Yx-AK; Fri, 23 Oct 2020 07:50:49 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVrqY-0005YN-Ef
 for linux-nvme@lists.infradead.org; Fri, 23 Oct 2020 07:50:47 +0000
Received: by mail-wm1-x344.google.com with SMTP id d3so451912wma.4
 for <linux-nvme@lists.infradead.org>; Fri, 23 Oct 2020 00:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=4oABfubuy9rJdffezMc5U2Sgyccmm6kFm5R8Q0Ln3KU=;
 b=KkP3uQtoHLnNBNLbx0YL85D1j6jXtma25BYZ2T7qxLAvC9OUChO+purYX7Uq5O3ISG
 DdHd3Gu4thKzbS7Hcf+NlgcNyoay8UV6MldHmIjJKNYt6tipSItmYw1xX8LddO5P33sb
 6fnnj0/vhoLGgZgrN3Sfy9iBiewECf2cjgIHpuYyfGBJ70R0O1ZrWg+BDu387xd6AV70
 5y4sddqwHM36pmZ7ez4jjDLjT8ZKqEC3Jt12KJGhM6nxmoTtTjMqTZnooNFDFSMIb71Y
 8Fn6+6bUeUCEz2kL8zz85+YWHJyhuJEMaBwqs4geQ2AmsneImlvuf9fV1y/0GQjLq7iI
 wIeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=4oABfubuy9rJdffezMc5U2Sgyccmm6kFm5R8Q0Ln3KU=;
 b=E6WxNO0UiZa8oEI06ONNwUL/68SFF/LXf/ZD85xUOwaZt7W0Kf+HoJWqC0Y0Rxjvu6
 Oe2G6QbQgSu5ZlsLADLXPhkXKmbkzm71Sq8JuHRmd3e62iUKVQ7eSCF/sKV12tRuRD7I
 68qa7uYNZeKDhIbHDlC+xARz+1K5JGjIrdxz8OJl9QwgWUuoMmPOfHXzDKTvoac5WIsg
 Ho0RfN79ellZYHohD289eRN8C+iAHUmZQduOB62B0lIaME8BtvF6sDoXB0pMp2AjtyKh
 h88eJWEzQBPyX5rW/PQWQUfcAGKSSwjHckr2yamSijHYDOLe/zQUsLa1T1GIPfxvzH9r
 sLjA==
X-Gm-Message-State: AOAM531KzgkTbG2MQ8lpEfHPpMlftRAbeX5sLJkRjO4+U/9OTOWbF3Vp
 LABFRZFDZrHXTAsFfs6qoU8=
X-Google-Smtp-Source: ABdhPJydCOnz8Dt4TawfY2hlg6gNhwBBAp7XoNU1h3SdDngHaBjgjyu8q7M92EXRNRflUA74bgWMrQ==
X-Received: by 2002:a1c:a5c4:: with SMTP id o187mr938575wme.171.1603439443716; 
 Fri, 23 Oct 2020 00:50:43 -0700 (PDT)
Received: from [192.168.1.11] ([213.57.108.142])
 by smtp.gmail.com with ESMTPSA id f139sm1628447wme.47.2020.10.23.00.50.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2020 00:50:41 -0700 (PDT)
Subject: Re: [PATCH net-next RFC v1 02/10] net: Introduce direct data
 placement tcp offload
To: Sagi Grimberg <sagi@grimberg.me>, Boris Pismenny <borisp@mellanox.com>,
 kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com
References: <20200930162010.21610-1-borisp@mellanox.com>
 <20200930162010.21610-3-borisp@mellanox.com>
 <ab791897-6398-f38e-c2a6-f54c5ca5e1c5@grimberg.me>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <c5ad9021-9f44-9ed3-8e41-90a4d561d637@gmail.com>
Date: Sun, 11 Oct 2020 17:44:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <ab791897-6398-f38e-c2a6-f54c5ca5e1c5@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201023_035046_607808_CE77EFB9 
X-CRM114-Status: GOOD (  13.68  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, Ben Ben-Ishay <benishay@mellanox.com>,
 Boris Pismenny <borisp@nvidia.com>, boris.pismenny@gmail.com,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 09/10/2020 0:47, Sagi Grimberg wrote:
>> + * tcp_ddp.h
>> + *	Author:	Boris Pismenny <borisp@mellanox.com>
>> + *	Copyright (C) 2020 Mellanox Technologies.
>> + */
>> +#ifndef _TCP_DDP_H
>> +#define _TCP_DDP_H
>> +
>> +#include <linux/blkdev.h>
> Why is blkdev.h needed?

That's a lefotover from a previous iteration over this code. I'll remove it for the next patch.

>
>> +#include <linux/netdevice.h>
>> +#include <net/inet_connection_sock.h>
>> +#include <net/sock.h>
>> +
>> +/* limits returned by the offload driver, zero means don't care */
>> +struct tcp_ddp_limits {
>> +	int	 max_ddp_sgl_len;
>> +};
>> +
>> +enum tcp_ddp_type {
>> +	TCP_DDP_NVME = 1,
>> +};
>> +
>> +struct tcp_ddp_config {
>> +	enum tcp_ddp_type    type;
>> +	unsigned char        buf[];
> A little kdoc may help here as its not exactly clear what is
> buf used for (at this point at least)...

Will add.

>> +};
>> +
>> +struct nvme_tcp_config {
> struct nvme_tcp_ddp_config

Sure.

>> +	struct tcp_ddp_config   cfg;
>> +
>> +	u16			pfv;
>> +	u8			cpda;
>> +	u8			dgst;
>> +	int			queue_size;
>> +	int			queue_id;
>> +	int			io_cpu;
>> +};
>> +
> Other than that this looks good to me.
Thanks Sagi!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
