Return-Path: <SRS0=PNO/=FP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D41CC4361B
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 20:00:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A6C2311A
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Dec 2020 20:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A6C2311A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lt/KgY855ElMtwvxKnAi3aQ4Q6mvavYAJbOslmF0pyw=; b=x8Lwz4QXyJTk3D/FU89rdeza3
	th08PsG5KkQvVROvuqdUatkOu9I+I2/xnqtybWjcdNqQD8acviSpAdnZGp5jgAthOsHjMWYtG9YFq
	LUQZwX+B58HsDnh8r7RmvpscM1wgSgfDtfUsI2+2wufX5bx6I762yISkzWeKBTBpY3agOn3NArn06
	i0FppEQmnow3MAkVLuQgO6CXnlmGO1O/wC9ocwvwDxO/8d6xE9lVUYDllTLpMFJvTqcFIRAq1Ncav
	lJ6psweYEZLGj1WWXStzCnr+bhrU+qpRBieutCgqsxXnljRnWNUiSWHvTvnDWayGxE9sA9e5LgsOo
	roxnW727A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knoa9-0000eP-5B; Fri, 11 Dec 2020 20:00:01 +0000
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knoa5-0000dq-Sz
 for linux-nvme@lists.infradead.org; Fri, 11 Dec 2020 19:59:58 +0000
Received: by mail-oi1-x242.google.com with SMTP id 9so4033611oiq.3
 for <linux-nvme@lists.infradead.org>; Fri, 11 Dec 2020 11:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GXouTMg9z7FxGREV13t5lB9zURmuWrbw3x7YOJeBTgM=;
 b=uEyEY3EPAxWX3oGWTVNPUuEUfSH8bFqor4l/2fgf60BGehsY1bJ41QWiUEJ5XuKljy
 yNF2EMdJI0/VPcyTfOg6gU598Ppdx9lKtzdsoA5u2KspNJkMD5qWHD5Yyk90WB+fVHqF
 zM7As+I+S2ySbShGJsY80spNK0eZnSvab90q5RpmZFCWlrIj+gKOu/JXwHDU+amEvl4b
 NTDPzhllgUd8iZUn4d0RvKZd9R3jIiLnbQaXp9qU++PyRKHoY70YwMC6eBKqi6v+NgUU
 bBZZePrYoMggpeZ2fNv75GuBLe7z9QpWEjgrlEZ+DHjmWSheZXKj+NXqqLcQm1A7HU99
 Amkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GXouTMg9z7FxGREV13t5lB9zURmuWrbw3x7YOJeBTgM=;
 b=GuGjcmNQiHKbjxzS2a6lPbtq/QzyMPRZ61Yklz2X7xSlYGsaapJBg8IWYNEFr/Wb+6
 ZgHnyvD4HXNPdWnrelOKv7cCnwBAKdILXb09J3HLdygSwlBXehXTl0WN5he1zjCI/j+p
 bia3xqy7PYQ/ZiG9ifYx2uNUCSwXh8bDPefiivRDB6rfLG28U5wknsWva9HSwkdaP6sK
 hMD3ZWcoxXm2HW6368JglXsvz3XKwUO2y3CBGC7GfnY17AF6H35TaWW3HY1AbuP6Gn4E
 uU7fKzz69PncHPHvFefCshogs5OIe7h2Cb1b82Liu7/+ZeIgagVXC/ZVH2OFePnqfNuY
 iE8w==
X-Gm-Message-State: AOAM530NHsKJBJaBSgNtQWEtylgqV9WUg+WpOv2xLaSdMAce9urcn1Cn
 sGQgHffWenKvH0rT9+7PkgY=
X-Google-Smtp-Source: ABdhPJzxtMM7NQoSo5eoOOehPBdJgEAWO056zfguSFANeHCqz4IKmjGwP0JfVn+DZVXqR46X9uVNvA==
X-Received: by 2002:aca:1b1a:: with SMTP id b26mr10534497oib.43.1607716794557; 
 Fri, 11 Dec 2020 11:59:54 -0800 (PST)
Received: from Davids-MacBook-Pro.local
 ([2601:282:800:dc80:6139:6f39:a803:1a61])
 by smtp.googlemail.com with ESMTPSA id l5sm2014127ooo.2.2020.12.11.11.59.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Dec 2020 11:59:53 -0800 (PST)
Subject: Re: [PATCH v1 net-next 02/15] net: Introduce direct data placement
 tcp offload
To: Jakub Kicinski <kuba@kernel.org>
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-3-borisp@mellanox.com>
 <6f48fa5d-465c-5c38-ea45-704e86ba808b@gmail.com>
 <f52a99d2-03a4-6e9f-603e-feba4aad0512@gmail.com>
 <65dc5bba-13e6-110a-ddae-3d0c260aa875@gmail.com>
 <ab298844-c95e-43e6-b4bb-fe5ce78655d8@gmail.com>
 <921a110f-60fa-a711-d386-39eeca52199f@gmail.com>
 <20201210180108.3eb24f2b@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
 <5cadcfa0-b992-f124-f006-51872c86b804@gmail.com>
 <20201211104445.30684242@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: David Ahern <dsahern@gmail.com>
Message-ID: <281b12de-7730-05a7-1187-e4f702c19cda@gmail.com>
Date: Fri, 11 Dec 2020 12:59:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201211104445.30684242@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201211_145957_954876_3595E468 
X-CRM114-Status: GOOD (  14.35  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, sagi@grimberg.me, yorayz@nvidia.com,
 Boris Pismenny <borisp@nvidia.com>, boris.pismenny@gmail.com,
 Ben Ben-Ishay <benishay@mellanox.com>, edumazet@google.com,
 linux-nvme@lists.infradead.org, davem@davemloft.net, axboe@fb.com,
 Boris Pismenny <borispismenny@gmail.com>, ogerlitz@nvidia.com,
 viro@zeniv.linux.org.uk, netdev@vger.kernel.org, kbusch@kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, benishay@nvidia.com, saeedm@nvidia.com,
 hch@lst.de, Boris Pismenny <borisp@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/11/20 11:45 AM, Jakub Kicinski wrote:
> Ack, these patches are not exciting (to me), so I'm wondering if there
> is a better way. The only reason NIC would have to understand a ULP for
> ZC is to parse out header/message lengths. There's gotta be a way to
> pass those in header options or such...
> 
> And, you know, if we figure something out - maybe we stand a chance
> against having 4 different zero copy implementations (this, TCP,
> AF_XDP, netgpu) :(

AF_XDP is for userspace IP/TCP/packet handling.

netgpu is fundamentally kernel stack socket with zerocopy direct to
userspace buffers. Yes, it has more complications like the process is
running on a GPU, but essential characteristics are header / payload
split, a kernel stack managed socket, and dedicated H/W queues for the
socket and those are all common to what the nvme patches are doing. So,
can we create a common framework for those characteristics which enables
other use cases (like a more generic Rx zerocopy)?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
