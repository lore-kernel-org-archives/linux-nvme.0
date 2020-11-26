Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2773AC56201
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 01:23:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF62206C0
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 01:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a+I+fp0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF62206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=R5dzm16tUB7ITyumHP6+V5LlOCI71pTChb+cN47ohSE=; b=a+I+fp0zjdCbW0y/VTeBIObeF
	YzB4uW6dFLlMsB3uyZwteRUPCp3nuhcjhmR0m/jh0JkvIze/kUz7O1JkNUe8IQifzv8Hm4qwfCCNe
	wCee0cMFVWgFXAQoOrn1xecR3kov87X8w+RrY/07bIk535O/OKUhqD2FSRMFIrf+PIVygTv9/G3wU
	TNP3Bh9EVkBzKrgtrrfajDbrceygbd551rZFRkUAsHSMPg0BVskUYjqp+zYhmfdkSh060qNHuBCHr
	q3WuBlbfNAql8UFnvbztURCXnc2OQ1PJi1K9Fiwe0cqoy3t8iEzaGIvqwZFZNh+wY3wUid8aJ6MIM
	B48nWoB9w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ki5zy-0007yU-Mn; Thu, 26 Nov 2020 01:23:02 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ki5zv-0007xr-AT
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 01:23:01 +0000
Received: by mail-wr1-f65.google.com with SMTP id r3so350526wrt.2
 for <linux-nvme@lists.infradead.org>; Wed, 25 Nov 2020 17:22:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=msx6IowviOiX81c+UADBsnE0j2mMdhzHMMjobWCYDFw=;
 b=fKszKNnh3/Xm+RS3GxtqpqIuFlPXZJr91y3xsj5uqvepWa+aVjIazH8XboczwvJTU5
 CcggxYskWKMMnwVeUMrl8+nUXCzG94ywoBlbVObYAGWvwBvfu3NSs/bM8bjyCZiwx1jl
 XDyhFhn0Mpmi6Xz+bUPrzpt/d9EW+mDVXz5igItNANykyZC3rBn1++ccXjQ3eoUZyFK8
 KUpgO7F8J2m9Bcp5B4FI5I4aN8X+evUyxnozzJjzQ0OrpjQLYp1wz37YrxWZNnOwovjJ
 iUcsSOVBWUK0N0ercVQOODHOwJl5JHTMYw5UbrS2+Ma9D29CJvinQb+7ocku1I74T4n+
 N7Yg==
X-Gm-Message-State: AOAM532uYHQcDTxHF+oWN/wmzyNU9qYpE4KyrP7aEfGh35QAYsqZ/Qp2
 JkkbhPpIphAEFQzIMUgo08I=
X-Google-Smtp-Source: ABdhPJxKjvLhO0gWCWtl/SBdmJOCcaujz5o4ulLBCIm3QiwS3HUWx2n08h6HzvflZVFNU8COHmsCVA==
X-Received: by 2002:a5d:6452:: with SMTP id d18mr755223wrw.200.1606353778043; 
 Wed, 25 Nov 2020 17:22:58 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:5e57:3445:eb42:2ba5?
 ([2601:647:4802:9070:5e57:3445:eb42:2ba5])
 by smtp.gmail.com with ESMTPSA id f199sm6726139wme.15.2020.11.25.17.22.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2020 17:22:57 -0800 (PST)
Subject: Re: [PATCH 1/7] nvme-tcp-offload: Add nvme-tcp-offload - NVMeTCP HW
 offload ULP
To: Shai Malin <smalin@marvell.com>, linux-nvme@lists.infradead.org,
 Erik.Smith@dell.com, Douglas.Farley@dell.com, liuw@vmware.com
References: <20201119142107.17429-1-smalin@marvell.com>
 <20201119142107.17429-2-smalin@marvell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <568e4923-b312-257a-8fba-0111e9953cd3@grimberg.me>
Date: Wed, 25 Nov 2020 17:22:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201119142107.17429-2-smalin@marvell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_202259_421765_095B5508 
X-CRM114-Status: GOOD (  14.21  )
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
Cc: aelior@marvell.com, agershberg@marvell.com, mkalderon@marvell.com,
 nassa@marvell.com, dbalandin@marvell.com, malin1024@gmail.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index d92535997687..2c4c21f39a2f 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -47,6 +47,7 @@ enum {
>   	NVMF_TRTYPE_RDMA	= 1,	/* RDMA */
>   	NVMF_TRTYPE_FC		= 2,	/* Fibre Channel */
>   	NVMF_TRTYPE_TCP		= 3,	/* TCP/IP */
> +	NVMF_TRTYPE_TCP_OFFLOAD = 4,	/* TCP/IP offload */
>   	NVMF_TRTYPE_LOOP	= 254,	/* Reserved for host usage */
>   	NVMF_TRTYPE_MAX,
>   };

We cannot do that because this is not a spec'd transport...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
