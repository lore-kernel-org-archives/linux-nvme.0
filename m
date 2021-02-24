Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0511DC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 22:41:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C75A64F03
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 22:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C75A64F03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zR43L1ItKRBqj4I0M/UcSBJ37ysoV71+TnKDLM5y6hs=; b=UpbHB9zmqJBU7BIDejSwwHHpE
	gWFeCoIanxBy9VNMvUNGyM+97tAMS266vx0DwDldOciEutvmufhQoc6QIgaNpC2PE6OwOPkdtvu3K
	ldxmvKiyidXsiN9jjJXmD54Swn56BDhtl/seaI9wGzLTwYOxoMVGFeahNcHe2F5dxW7ZqSKmRg5UM
	5g9Bw01lo98K4DM/Njo8fqlWZ10qD/jXDK0eGWVDgJgKUmC7noLOSCzpc4p2MQx79uJTayj3x1bFC
	1Bp33apbqeQD3vavSZ0DSpWbXACQCHSjYoofWKcDzLFXrEi8TJcNcDVK1ed4n3uinviG4HByYXuvv
	sWhgtQV8g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lF2q5-0005CT-HE; Wed, 24 Feb 2021 22:41:01 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lF2q3-0005Bx-0T
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 22:40:59 +0000
Received: by mail-wr1-f46.google.com with SMTP id v15so3401136wrx.4
 for <linux-nvme@lists.infradead.org>; Wed, 24 Feb 2021 14:40:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Pq0UBm3YeqA67RXd+tNQB9MQRRDnSOqIhapYHBOG9hQ=;
 b=X0gctP38z4J+T2vm27MpTQMlym2IUAo+a1pHhwBJ0VWR69BNkapusdlC/ttr4+8y0p
 aY6b4deZsQr6yQuA2sex7PzFUN+PoNs+yKcaYionYz0bhIqGaxHGe7EG7pCegEMwjCkH
 W8rtohESeeUSJuB9Mq6wpmveWu/j/v2nLSWSVFqMQFj72/7/PEPdhDrhgBCK+lc2pett
 FSQ3VlW4jYY5HyMimraxgMNxKo+sdXkLil+kutsDU6MlA83Q9BroVtRMnPg2WnozSMbL
 RFf+IpeK94Jl/nIAVBxOSWEgvHtlrlJzxyZUSPYOLJQaWwmZSlb5NaOEiohLkyAQCIp6
 JBVg==
X-Gm-Message-State: AOAM530Bz3JDApmdq0jwDCkR8BUPhxEKLXxo23TyQ82xRS/N3Gn42Xff
 d5Eb52xCq9AR9WEvh0wSGVw=
X-Google-Smtp-Source: ABdhPJyTgNAnKQZlqktMWtK50vCivB30lTU4WxewlMwQ6e6bZIruRbcijWTCKLo3QBzy+BrgfhgC6Q==
X-Received: by 2002:adf:b641:: with SMTP id i1mr232174wre.295.1614206456133;
 Wed, 24 Feb 2021 14:40:56 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:db58:8280:1bcd:2501?
 ([2601:647:4802:9070:db58:8280:1bcd:2501])
 by smtp.gmail.com with ESMTPSA id v6sm5728037wrx.32.2021.02.24.14.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Feb 2021 14:40:55 -0800 (PST)
Subject: Re: [PATCH 2/2] nvme: delete disk when last path is gone
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20210223115922.104369-1-hare@suse.de>
 <20210223115922.104369-3-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <eb979539-96fb-b767-5c5a-259263a25a0b@grimberg.me>
Date: Wed, 24 Feb 2021 14:40:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210223115922.104369-3-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_174059_107198_8300AD27 
X-CRM114-Status: GOOD (  18.67  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> The multipath code currently deletes the disk only after all references
> to it are dropped rather than when the last path to that disk is lost.
> This has been reported to cause problems with some use cases like MD RAID.

What is the exact problem?

Can you describe what the problem you see now and what you expect
to see (unrelated to patch #1)?

> This patch implements an alternative behaviour of deleting the disk when
> the last path is gone, ie the same behaviour as non-multipathed nvme
> devices.

But we also don't remove the non-multipath'd nvme device until the
last reference drops (e.g. if you have a mounted filesystem on top).

This would be the equivalent to running raid on top of dm-mpath on
top of scsi devices right? And if all the mpath device nodes go away
the mpath device is deleted even if it has an open reference to it?

> The new behaviour will be selected with the 'fail_if_no_path'
> attribute, as returning it's arguably the same functionality.

But its not the same functionality.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
