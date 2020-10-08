Return-Path: <SRS0=NQX9=DP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8671BC433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 21:52:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0632122241
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 21:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LRQCg+oX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0632122241
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wIO7juqHisF6zld4zuznTP5ZkIe1d9IZ+FvyPURepk4=; b=LRQCg+oXGS7+Xup/HmNvoQpUk
	ZQJGt6RNYTAckEQ/8TahhE1D7EjxPyJ/iSl5Rzuib4ODzsGl0YeECW2Evmur5isXwvpHtl76ZlVlG
	hHmRBRjjnQBMIY/SyLPDVX472b+HrdEJzfd5fvlAg7DFCjT3uceUqsbFOXIm56cfJWQRiO02fuOF+
	i3zXF8zzcmrSOVWKxsGAa6GV7JvuRCeF1uF4PH0UlncKOUUHiyd4/zxbneqqxivsE9/Zd0rb+QCXD
	n/b8Z94tWz9fyol2m6tzKn6ARFGJCyruQOECmeDQ1awv5lo2s6mcDcyDLChxVjU7kuf0GDnnTaeaU
	sg72e/y/g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQdpQ-0000ZI-9n; Thu, 08 Oct 2020 21:52:00 +0000
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQdpN-0000Ya-Vr
 for linux-nvme@lists.infradead.org; Thu, 08 Oct 2020 21:51:58 +0000
Received: by mail-wr1-f66.google.com with SMTP id g12so8162138wrp.10
 for <linux-nvme@lists.infradead.org>; Thu, 08 Oct 2020 14:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iJXlEB+Px1Bh29uSjjaKgu7whRXUx1wvZLQkXigqHdE=;
 b=IKI5JsW2ElB3JL1qOmLXvkJZ8v5wCKN5PduCxXR/mydQfFKg5BMoSJGh1Dl9+3kikl
 9/0XcUiPgBvqBCL8zsgee3MtHf9SmYmN7eZmb9FjxYN5rTpEOrs5hZ65H0mCqJZ2C859
 nBujfYHlbgvXC7aFtMPkUnbvgXZnFk8pGms05fzdYC6MO/udc1FkcSrNvLRwpVn8TdoN
 XnXppeOlQkHPDbcbeDRewRpzhWSi4hPER5QX8I7hTgGae7jArYIxZvtNDw9RbDdIftYZ
 LJqtJy7Y4vkom5oL1X7mYR10IRDhGiLM2KhLZYd2rY/ob6ofkcdWZxTf0nk5pGJbdOkY
 ANJQ==
X-Gm-Message-State: AOAM5334SWAzmSflx7EZaxbcwdsemkCBZR5u3bHHBj5exNUrvdezOgoy
 n3QFz912xuRQGiD5GWbFOLY=
X-Google-Smtp-Source: ABdhPJwJ7oTNHeMtK2UwxXqxI2a25TbVKjna+8whwhBksIwUGhMPofkX7Eg64tfJMI/ghTWDj9AlZg==
X-Received: by 2002:adf:d84e:: with SMTP id k14mr11803304wrl.251.1602193916816; 
 Thu, 08 Oct 2020 14:51:56 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:68d6:3fd5:5a8b:9959?
 ([2601:647:4802:9070:68d6:3fd5:5a8b:9959])
 by smtp.gmail.com with ESMTPSA id z6sm3872809wrs.2.2020.10.08.14.51.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 14:51:56 -0700 (PDT)
Subject: Re: [PATCH net-next RFC v1 03/10] net: Introduce crc offload for tcp
 ddp ulp
To: Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org,
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com
References: <20200930162010.21610-1-borisp@mellanox.com>
 <20200930162010.21610-4-borisp@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <904a5edf-3f50-5f6f-6bc6-3d1a1a664aa5@grimberg.me>
Date: Thu, 8 Oct 2020 14:51:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200930162010.21610-4-borisp@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201008_175158_044166_25415900 
X-CRM114-Status: GOOD (  12.65  )
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
 boris.pismenny@gmail.com, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> This commit itroduces support for CRC offload to direct data placement
               introduces
> ULP on the receive side. Both DDP and CRC share a common API to
> initialize the offload for a TCP socket. But otherwise, both can
> be executed independently.

 From the API it not clear that the offload engine does crc32c, do you
see this extended to other crc types in the future?

Other than this the patch looks good to me,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
