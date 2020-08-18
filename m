Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47287C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 19:10:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB9D2076E
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 19:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Fltz1wkl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB9D2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CW6z2M/nN9bZMvKnnuPyEqAlc4Mb2+alyfhkK2TTans=; b=Fltz1wkllVFbZQrOeie9ufYcO
	uEeBPRq4ndmYb0EMuyNNWrFt4GK5EqbIxnyzMqOUU8IWvWOp6CSK0l+hIeMpng9R5eZFo7IlrJr9O
	kM9agqN9y0i0Iqv+9tKy89tMAMBj2pgz1PUE0yBYvoZDqmg2Ng6sXzvjmpLu+YO+LN5fIBOQovrl1
	FLb4TpEpWyo5s0XSI36tqVYvqBXOAcwKO/USsAaY/MrZH0cyZk2KAId4T/sOTI1fFWsFPVSvAx2gd
	ESEzfs0cH4zb7rPxhK32qoTx+MY8F3ozqVvJmuQmevbr/S7bJyzBzNCpbZxNUNLBDoqo+Hu9swY8m
	zSyAHudYQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k870B-0007ky-JV; Tue, 18 Aug 2020 19:10:31 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8708-0007jd-Gt
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 19:10:29 +0000
Received: by mail-wm1-f47.google.com with SMTP id x5so17210806wmi.2
 for <linux-nvme@lists.infradead.org>; Tue, 18 Aug 2020 12:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0DW34Q5BpyMf4nFACRNp1o2xgGQvxUytn3K/+VPFV64=;
 b=qdxHQgfxeWqL/EBk5XwerbWGaY0JlcH4Cq+aDyUX9ofe3DVgyNqP/KKEUJRepGoZeW
 Ck72aYajCxXVdkxcbs4+IptowNtjg+PSFM9z9YOnFFsODfn2WITi2/Jh2cJOOZfHxodg
 YAvajILwqYx2D9O1+GjX27WnFFslQOV/5tUPCDUX4yF3MlOA1HuRA21t5jlEcLh3B1xC
 FIYqiF7alpGHg0wsVFELwZgaWzKVgNtELFZDRSi6XrcXjxPj6I/+imZTgLVINkbqDxEr
 m4VTS3H9aKS33ynqfumWYtEtvjBqQ7uIUnH6vq4/txJBzeMJCppqF3Xuskhe4Khd9Kyz
 b9fw==
X-Gm-Message-State: AOAM530eCWjKItlNPyIL7GkDDExE8ogtZNVfTNciU4A8WK+1vpQnXwXR
 8ko1m5if/clkGFkWYLCpUnsd30cIldmZFg==
X-Google-Smtp-Source: ABdhPJyz5gjH16LQ8tH+spEIWCUOIqRq61M/zQANEqyd/PtSmAYNjSVJ4y+3lnwmcHOhBG4pTc9MHA==
X-Received: by 2002:a1c:de41:: with SMTP id v62mr1312713wmg.163.1597777826341; 
 Tue, 18 Aug 2020 12:10:26 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dce:63f2:5e83:391e?
 ([2601:647:4802:9070:3dce:63f2:5e83:391e])
 by smtp.gmail.com with ESMTPSA id f16sm36986275wro.34.2020.08.18.12.10.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 12:10:25 -0700 (PDT)
Subject: Re: [PATCHv3] nvme: skip noiob for zoned devices
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200818162941.2674340-1-kbusch@kernel.org>
 <20200818172504.GA28474@lst.de>
 <20200818175054.GB3097355@dhcp-10-100-145-180.wdl.wdc.com>
 <20200818180205.GA29087@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bbbaf51c-d4e0-ae45-a247-1e44666f866b@grimberg.me>
Date: Tue, 18 Aug 2020 12:10:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818180205.GA29087@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_151028_903861_2BDDE9D5 
X-CRM114-Status: GOOD (  10.97  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I'll wait for a new version, reverting the existing patch
from nvme-5.9-rc for now...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
