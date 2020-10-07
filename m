Return-Path: <SRS0=DCfI=DO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAE2C41604
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Oct 2020 14:25:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37A66212CC
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Oct 2020 14:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mBGe9g9z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Z67xi9rz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A66212CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+5TUmBraUXcnq6aif+n46/3DrkICS60VT0Ccs8NBUe4=; b=mBGe9g9zMaVJbARh/im7a87FU
	k7zxgoOrjVHm8BO0oC/VgRCKnYAzsfMvCsTnevf3S3KpZOJQXeG5nh9r1D1xDnwT3xIgVgoDgqpzm
	8QbYBS0fB5vQqW9uQkq1mxgTcTIlx1Vz4oDBFhJs+YMZd5wLyvc2BlqYGoRWJV2z5z8JL7Xrgk21E
	lr4wPfMq3J8qqHrku741tHCYZHfoabGWotrpx+/2e2WlvtNoOwFc/o10hocE8lahEfvdqej+3/9Bg
	1xMs+6dcpX+2akZjBVF5BNshj/ULEgmoXoZFEqm1xGZg0qXDzisxR5cu7s/upTWlxuu8lA5ttTnHe
	n4v4+6dHw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQANU-0003zP-FF; Wed, 07 Oct 2020 14:25:12 +0000
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQANP-0003wE-Dw
 for linux-nvme@lists.infradead.org; Wed, 07 Oct 2020 14:25:10 +0000
Received: by mail-il1-x12e.google.com with SMTP id u9so2430424ilj.7
 for <linux-nvme@lists.infradead.org>; Wed, 07 Oct 2020 07:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=A7K1sHY6q/b2IdFDB45O/63cHris3UQRZX2+uyQGB10=;
 b=Z67xi9rzPKTp80uHhkurQLtC3skXmryBJtaenRQER9oIzoqYRElX5a0DF4Lafyra72
 /tLvHob1dfGrbG/loIPOSmGuJsmfbGGTsQA41aAgrNCdfLY7F4rhcTMSZslWJ1pZ/ODD
 8h7MG2NhsyaX6Cv1zVGyVb9D1QODk/MZYCiX0eFEZCYF5eMin9PJ+XT8uLroVVym9hkg
 6SYhIYWvhhCHvblaPIo/6QfZqmy9RyhJh7/GenoyNQYpK9yBgEjHryPY/B8Y0w/d4XRr
 oDJp1dvnJmpTRPtmwsmWqwVok9XprPx3KE/eDC0MRGGeWOauDFXh0bDoTgLZWjfaUcvG
 ZnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A7K1sHY6q/b2IdFDB45O/63cHris3UQRZX2+uyQGB10=;
 b=D7fdZnCkXvuIl3ZRdtGDDqfrUmZ2jUWZ95mFLjPeH3cdiJdO+6VROukzLQxmhgtYe3
 CcCAk8Jv9Gyxf9vsMbzNYVZkdnXmyZ0sn9kfukgaII6ZImHfBVGcIOfJabPS2HzLMV5q
 YsYALExNCgoOWM7wonRDQ3xDTVvvh2+ZmrAYR1iRMgOotrupx3Gxo5KhfqV5r4w5MpMZ
 rqBDn85Z5j6mYPC0JbAW5f94xvehWq0NvRWxYPxHFcUjwU7A0ulh+c2SwCFoXGDnI8Jm
 f5vlVRREXXhB0KlsxzBJ6LUjhzqUE1mGj7tsPXD4Y0SI6XoV+BwnW5VSsjLgSHdbd6ly
 gB/Q==
X-Gm-Message-State: AOAM531QyUsAU8bhAiEobus7LZepr/hs1iOMHBdxS8HR5gN4G6AzMrPB
 ZH37xa9kSZbiNknNaG132ZAT0/lNu+4NXw==
X-Google-Smtp-Source: ABdhPJyaPkfGb7JXNuxplHrvZZwINxTPrmRH4KFB+GvAm5CNgDm7EmCiP7Of84X20GVYBy2RoZ/Lsw==
X-Received: by 2002:a92:1f19:: with SMTP id i25mr3162991ile.198.1602080703493; 
 Wed, 07 Oct 2020 07:25:03 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id 15sm1089939ilz.66.2020.10.07.07.25.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 07:25:03 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fix for 5.9
To: Christoph Hellwig <hch@infradead.org>
References: <20201007142324.GA1458015@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d2e10d2e-66a7-5785-881a-2c1daf310d60@kernel.dk>
Date: Wed, 7 Oct 2020 08:25:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007142324.GA1458015@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201007_102507_515009_6E11FF69 
X-CRM114-Status: GOOD (  13.31  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/7/20 8:23 AM, Christoph Hellwig wrote:
> The following changes since commit 6d53a9fe5a1983490bc14b3a64d49fabb4ccc651:
> 
>   block/scsi-ioctl: Fix kernel-infoleak in scsi_put_cdrom_generic_arg() (2020-10-02 12:01:47 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.9-2020-10-07

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
