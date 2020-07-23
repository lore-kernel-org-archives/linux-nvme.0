Return-Path: <SRS0=ANVZ=BC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D07C433EC
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 16:10:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0216A20714
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 16:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b/3XwFyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0216A20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:References:Message-Id:Date:In-Reply-To:From:
	Subject:Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VR0YVwo3d7rHlJellrwhfgYoPgABXV+wSdrcqIE0Csk=; b=b/3XwFyRzGtrPFxDs5dIFpcnz
	cxDXPsvfPWRGrd7kvxX5j050Ma+gAXJhG6z3/wvfk5SjpgPdH41gorxj+GjCVkRFM122I1g4KEJE9
	alC5qjuNuIU50FteL9Tqh42Qd2mHzj81W5VNB1MCxurvpj0xL4kNDa2h8v3S91sfE8avyR0OSWspx
	XaKiJqPCviw3vK30M5AokO7XloK8g68uFKNZJTIQ2DVXQ4x2DeQk8uWXHO1nlaMbqwMt5v/ISXPFz
	66xCG7QEdw+oAkbT68hb62MWTvcCAPnnxts+HDrVwdGnftZGKJ+UHwH36YR/OcYwVNcVHS/l4R0uo
	Xy12ITzag==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jydo4-0001CK-Ud; Thu, 23 Jul 2020 16:10:53 +0000
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jydo1-0001Bv-VL
 for linux-nvme@lists.infradead.org; Thu, 23 Jul 2020 16:10:50 +0000
Received: from mail-pj1-f72.google.com ([209.85.216.72])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1jydo0-0003Ak-MZ
 for linux-nvme@lists.infradead.org; Thu, 23 Jul 2020 16:10:48 +0000
Received: by mail-pj1-f72.google.com with SMTP id cq11so3803901pjb.0
 for <linux-nvme@lists.infradead.org>; Thu, 23 Jul 2020 09:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=mloZu1UH6qYYfFGV+CjNmoEgB8w841kwWHgyCLqHBnk=;
 b=A6QrQ6ZpBF3bNzU9/K8CLN5ZvENP9y/KZM0n+bL4wJJ2Xy2UxjwYrtULwmGE6x5VqY
 YMtK9d0iK8xV0K5vPrqYG3qwASK3vT/oP2+nZfTmwux5QA06d/lSR8T5ShT2Ifity4Ez
 CyLooOFMSiBZBoLjC3mqa7UtOOHpoG6vPgBq+WWnj7TwYdc8OzugidUOZJRISPfzluuT
 HXHhmuzOG2og1aq8XdINIPlOrG2/W7VZWF/bmVRb8bFUftutlXNXh+g/NY93F+9+5XtR
 /Sk6L9vx9c9tlXB6VMe2KAlj3XijAa36PQWHmJc/b5d3U9FE/8fCG4dLoUSBmU7oJORQ
 sWiQ==
X-Gm-Message-State: AOAM530pSC4AaQV1kBnB0cQI0AN5j59PvRH+x6+CX28519ko+1ozVulW
 mHLutvYgYFZqyLerBINrgnL/TbrLdIlYjPabKGMvxbNs5WgB6vMFqnaOlSNiY0H8dCioEwnpZvG
 RHKINyC0EHp+Kf0qwxxEAToORvWvutZ39ckrJfi2Stw1o
X-Received: by 2002:a17:902:b7c8:: with SMTP id
 v8mr4419442plz.201.1595520647032; 
 Thu, 23 Jul 2020 09:10:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUlKUEWiLCJJBN4W/MsSwrvF+0LVOXjMJ5iKUh8RFRcu39sl9LdmwE+p+bhw9APuhnDrjnBg==
X-Received: by 2002:a17:902:b7c8:: with SMTP id
 v8mr4419410plz.201.1595520646672; 
 Thu, 23 Jul 2020 09:10:46 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net.
 [220.133.187.190])
 by smtp.gmail.com with ESMTPSA id z11sm3393823pfk.46.2020.07.23.09.10.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jul 2020 09:10:42 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH v2] nvme/pci: Add new quirk for SK hynix PC400 NLB
 off-by-one bug
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20200723160325.GA17996@lst.de>
Date: Fri, 24 Jul 2020 00:10:39 +0800
Message-Id: <45DFD291-E6BF-48DE-A447-6FA4086D40A5@canonical.com>
References: <20200417083641.28205-1-kai.heng.feng@canonical.com>
 <20200723155731.22313-1-kai.heng.feng@canonical.com>
 <20200723160325.GA17996@lst.de>
To: Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200723_121050_102949_15C93031 
X-CRM114-Status: GOOD (  14.90  )
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
Cc: sagi@grimberg.me, open list <linux-kernel@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, axboe@fb.com,
 kbusch@kernel.org, kyounghwan sohn <kyounghwan.sohn@sk.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> On Jul 24, 2020, at 00:03, Christoph Hellwig <hch@lst.de> wrote:
> 
> On Thu, Jul 23, 2020 at 11:57:31PM +0800, Kai-Heng Feng wrote:
>> After commit 6e02318eaea5 ("nvme: add support for the Write Zeroes
>> command"), SK hynix PC400 becomes very slow with the following error
>> message:
>> [  224.567695] blk_update_request: operation not supported error, dev nvme1n1, sector 499384320 op 0x9:(WRITE_ZEROES) flags 0x1000000 phys_seg 0 prio class 0]
>> 
>> SK Hynix PC400 has a buggy firmware that treats NLB as max value instead
>> of a range, so the NLB passed isn't a valid value to the firmware.
>> 
>> According to SK hynix there are three commands are affected:
>> - Write Zeroes
>> - Compare
>> - Write Uncorrectable
>> 
>> Write Uncorrectable isn't implemented yet, so add a new quirk to
>> workaround the former two commands.
> 
> compare isn't implemented either in the kernel, and we certainly
> aren't going to do these quirks for passthrough.  So I think we really
> want a "write zeroes is buggy" quirk and just disable issuing that
> command from the driver.

Ok, will send a new version based on your suggestion.

> 
>> 
>> BugLink: https://bugs.launchpad.net/bugs/1872383
>> Cc: kyounghwan sohn <kyounghwan.sohn@sk.com>
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>> v2:
>> - SK hynix found the root cause so change the approach accordingly.
>> - lspci is wrong, the device is PC400 instead of SC300.
> 
> I don't remember seing a v1..

Well, because it took some time for the vendor to find the root cause...
Here's the v1:
https://lkml.org/lkml/2020/4/17/169

Kai-Heng


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
