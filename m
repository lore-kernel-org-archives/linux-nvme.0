Return-Path: <SRS0=MxcY=4O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A4DC4BA06
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 00:38:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E692072D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 00:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tco5tqfh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E692072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s0df6ngNuKwamWeamd6oFlKCEvzILhRh6N2hO9FNc1k=; b=Tco5tqfhVJ7riZ8FXNslNDKUp
	m0nwOsZlZ69b9/rrNgPiX3L2+CM881CWxL1gpwzHV37Nj2e16fk0PmL1H003ddpz07EPeDsW6cB4K
	sbZ6FlUZTRraP2wkDJTosLtUeE3/REcwaJc7TFLYvh836sZAYEAe2vgx8yY2GWmVneQkquB7n0JXq
	FOBGxaB9ORB6r70mPzkkxMTnRnFFd0XqPjfufdr8dmJt+snMHHnrZyaTG34bOYjsl6QQ8zTbqYyew
	RquBwkhF0WjNjR29kXuI3I+ycufb5qBZ0He9/RD87S62Zsq49cyPgvp+Ja60mQpdS2LBKJHFWWAR8
	dhHj8ZbFA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6kiY-0007I3-1A; Wed, 26 Feb 2020 00:38:26 +0000
Received: from mail-ot1-f44.google.com ([209.85.210.44])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6kiV-0007Hc-7k
 for linux-nvme@lists.infradead.org; Wed, 26 Feb 2020 00:38:24 +0000
Received: by mail-ot1-f44.google.com with SMTP id w6so1395804otk.0
 for <linux-nvme@lists.infradead.org>; Tue, 25 Feb 2020 16:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zyHIE1nNgam2YHQE4zeavSKbTdy075euxc81ry8tQF8=;
 b=HO3+0CmPQTKtBAsSzwWxPriGZAZTSiY2Une1/HMdI8TOTSDQSnTgjzNyniEMnHy0mm
 1tRWH3n/NrCWXvE7BkR4p714QMLiBwEucRAZYgC20ZtHemolQPlihTgO3vP/aZXedMJB
 7FIvk+rySQszFNMkaYgtQBoz3zJYGFuYNIb+M5aLOqKU3pvxgMQCG51hvrUDusDq1i+A
 ByrVk4GJbEVx0e5wrn2Ek8jjGxhu9BkBSoKlswGscLcziEAtVRudUigHxHlTG5p5zRsM
 yhA8H4zA978BuZEOcSKZYJgJZlhXRnQb0233RqOlTh85XyFgFS+7ZQpf3w+xjyfcSyGQ
 sSkg==
X-Gm-Message-State: APjAAAXSbIZsJiaNAq8Pr6mWdmYqOb6ada58GrbAMwwRWZGp3/kAaEgy
 HXicsWteE6cXRiPTk/nDADKUfa1l
X-Google-Smtp-Source: APXvYqyvaJGAeSm68dK8mou/Juvt3fiopTqntFIqZLZZIcw4aKtJ1fCFXIofr+1BKvs+V/jjNAzW4A==
X-Received: by 2002:a9d:67d7:: with SMTP id c23mr984066otn.262.1582677500580; 
 Tue, 25 Feb 2020 16:38:20 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id b20sm99658otp.46.2020.02.25.16.38.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 16:38:19 -0800 (PST)
Subject: Re: [PATCH RFC] nvme/fc: sq flow control
To: Hannes Reinecke <hare@suse.de>, Keith Busch <keith.busch@wdc.com>
References: <20200225235956.28475-1-hare@suse.de>
 <d1aabd1c-dd2a-df7e-3735-dd36c3f1c53f@grimberg.me>
 <3611ba73-0d9d-a7ed-356b-bb856711a27c@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5cddf6e5-e92b-fa36-1ad5-e2cda1175150@grimberg.me>
Date: Tue, 25 Feb 2020 16:38:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3611ba73-0d9d-a7ed-356b-bb856711a27c@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200225_163823_278904_1F929400 
X-CRM114-Status: GOOD (  12.89  )
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
Cc: linux-nvme@lists.infradead.org, James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 John Meneghini <john.meneghini@netapp.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> As per NVMe-oF spec sq flow control is actually mandatory, and we should
>>> be implementing it to avoid the controller to return a fatal status
>>> error, and try to play nicely with controllers using sq flow control
>>> to implement QoS.
>>
>> Why is your target setting SQ flow control disable in the discovery
>> log entry treq field? We are not supposed to do it if the NVM subsystem
>> doesn't support it.
> Did I say this? I wasn't aware that I did imply that in any way.
> I'm just using the flag to figure out if sq flow control is disabled or 
> not.

OK, I read it backwards.

So in essence blk-mq will just keep sending until sq_head is
incremented.. How often does that happen typically?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
