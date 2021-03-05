Return-Path: <SRS0=roYe=ID=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A221C433DB
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 20:51:51 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5C965079
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Mar 2021 20:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5C965079
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QYkgdgbFlzgjr5meIeAd0cZiwEMe/OveNqmqMwbYkkg=; b=Ef92NmiFJ4n9qlaQL5N/EZ8mh
	2x4klzzdMWDHVUb9BvNjRsVr35ccqoGhIxA6WGG0SJgCUERihCbHUMUis6dchg0XJ2O/vVnISzIsa
	WmQuRcwPeNdGnuwjn6jiLqVHlQ3mWBL0sfMv0sZNFb7RfxcHi9gzA0uGkd5S8h9jhEBa+TGyO5u4X
	bU0a5Gt9Fr4qLWh0pCnvUbDaZyWToaRT4tLWOSIcZpR35AgXTZNpO3VVex6naOHNdujVjtxha5qhk
	coYxefEBVvg1PBZ7/Yw+r9PPwWgrsBgcqxz6rjVpWeJiO8mF3qZVbwODQfvhvP+zD+QYGK3Dr7rcv
	wTpTSRQow==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIHQ0-00GRxe-3w; Fri, 05 Mar 2021 20:51:28 +0000
Received: from mail-ot1-f51.google.com ([209.85.210.51])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIHPq-00GRug-Gu
 for linux-nvme@lists.infradead.org; Fri, 05 Mar 2021 20:51:23 +0000
Received: by mail-ot1-f51.google.com with SMTP id h10so3137376otm.1
 for <linux-nvme@lists.infradead.org>; Fri, 05 Mar 2021 12:51:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VlNZLGBbLmpCrNGrAQwLb9qYOfZ9xchB6d62W+oZJhA=;
 b=FUT/8KvOl1Adf0peyMnV2XqW5XfI4rh7XYd1XcH/xZuoZtT8AsHqh+USKoNIIy4lHX
 fnjRV8YUSWqWGxdjdmx7BdJvvCqiN25QkOpk4lEAtRF60d627DAPEw3DagxqVq11jLfU
 3yvH73d9+8oiFNEmCtAt8YeB2aTLeeUTvRW1qy5M4HTFsSE44Oa7L3yPLQux/0/Uu+vQ
 9fYo2MgFOy9i081RLWj07flZfr87me9BgG+waPmZt2WeN3g5Wx6B4AxblkQUmTOR+6rn
 J3OHoj9nKOAl0cEoNlKCTD5hMjn2AaJv1FCeUwjZdpzEVeTBG8Zisdxj4ljdLr8MfEAX
 nIgA==
X-Gm-Message-State: AOAM533+1NDjktwzGeABZCstvy/Zpe3S+zqemUM9ectVCpyMBY5nKUx3
 bmz4KcxYk8PvtZCaImdpvJQJK805CTQ=
X-Google-Smtp-Source: ABdhPJzGY1h2cyDCAyGECjKeFF1uTYHC6e8fr4CIo+jHsMNptVk+3+tUcD7ZYukW9DcwFH9o+9xbzw==
X-Received: by 2002:a9d:694a:: with SMTP id p10mr6121991oto.319.1614977477096; 
 Fri, 05 Mar 2021 12:51:17 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:e55e:67c6:e7ec:9?
 ([2600:1700:65a0:78e0:e55e:67c6:e7ec:9])
 by smtp.gmail.com with ESMTPSA id u8sm770466oot.24.2021.03.05.12.51.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 12:51:16 -0800 (PST)
Subject: Re: [PATCH 1/3] nvme-fabrics: only reserve a single tag
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org
References: <20210303125304.1200789-1-hch@lst.de>
 <20210303125304.1200789-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <49d65274-002c-237b-163e-c3d482644a80@grimberg.me>
Date: Fri, 5 Mar 2021 12:51:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210303125304.1200789-2-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210305_205121_977424_A23E51CC 
X-CRM114-Status: GOOD (  13.83  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Fabrics drivers currently reserve two tags on the admin queue.  But
> given that the connect command is only run on a freshly created queue
> or after all commands have been force aborted we only need to reserve
> a single tag.

Umm, I think this would be an issue for non-mpath fabrics devices...

When we teardown the controller, we iterate over all tags
and cancel them, however for non-mpath devices these actually
stick around until they exhaust the retrys counter (with the
hope that the controller will reconnect again) unlike the mpath
case where the requests are failed-over.

Now if the admin queue is absolutely full during a reset, we won't
have a keep-alive command.

One possible solution is to make sure that
nvme_decide_disposition to complete a request for admin
commands. However note that this means that admin commands
would fail immediately when the controller resets, which is
a regression from the existing behavior and we may piss off
users with that...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
