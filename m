Return-Path: <SRS0=wM/2=DW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F4AC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 05:09:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F15322247
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2020 05:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YKWZ4A5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F15322247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:References:Message-Id:Date:In-Reply-To:From:
	Subject:Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PONEMUXAMSCMHmf9igu8qR47bB+af34fhTaeetomuHg=; b=YKWZ4A5s/K9NjgaRG7dbOyCvt
	mLk1td/63d+PACV8rSd//0mgKKnUFGPC8ZwMdBIm6Jio7qsNNdnC9sq7Mj4bs4w40hV3BR83Q/ln0
	qy/JDwhOPEY/Q+4tchfkLY7KcUeUZQCX+WCTqnU2AgS23Ysx739vC3zY4TkwmUqyVHkwtcShPInFU
	IJ0IgKW/yN8lX4UYmMGX80ur0OCaAeQjnubkOHz+gdlyqYwAF4xlB3fag/SF6fhJDEwvodwXRNnFn
	k6PnK0HMNheL23iL+ls3rLAxWL/qoblZSUltNLqG+Q5Df9slim2yW2olpIlJPoeK1ClhXbOexupeo
	xLZG3X2Rg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSvWG-00057y-0j; Thu, 15 Oct 2020 05:09:40 +0000
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSvWD-000575-7E
 for linux-nvme@lists.infradead.org; Thu, 15 Oct 2020 05:09:38 +0000
Received: from mail-pj1-f70.google.com ([209.85.216.70])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1kSvWA-00052Z-Ss
 for linux-nvme@lists.infradead.org; Thu, 15 Oct 2020 05:09:35 +0000
Received: by mail-pj1-f70.google.com with SMTP id bo4so1126324pjb.4
 for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2020 22:09:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=CKMUi55uSlXTFPdNQwqvWcYtcP11uT5LRNRhx7+ShsM=;
 b=XmPccAiVKzLE5jt0Wp0cobzjt0zCymCtm7fhOUvGX7nN8CWLB6CNvd/UbYqpKT07dw
 7TocRw4df/Zzopu2TauSJHDKWKxwfxO5YFv1W1H+B6a5Fm8fALFbG5EY4pESI2TgOsVV
 8+NlKg3ZkL/CexBUwzz6qaQYEYDF/5lcVRB+X4t0Q9PmHCWy6zeFsj7dFOGdpH72H6Ox
 OiSuS+ZNDYPT6DhWk16kyMD6+p+QXHP+5JRSO6iiKxwsJSpn/A1znvlrmJ0Dirj/V2xC
 qgyi2cI1bpBrf10BsIFWZ2DMEKDwK8AzrPubR1Ih0c+0fZWx+GmpmBUTAYURWa9Tmomh
 usOA==
X-Gm-Message-State: AOAM531abTbSASVcv0Mg/T3jWr7f7OayjQB1i/ICYrEoXMQKbdLSrhPH
 v6xIZ5+vMlUtfElU+4bpBahvO4ADgzhVKRfPUdv3LxPVH9vr7OMlA2qDBPR/LhPho9xYDEUJca0
 Q89XLuQwUtAsQrEQriF0WD04wi4T/ykEcZrpb373yhUOA
X-Received: by 2002:aa7:9607:0:b029:155:2b85:93f5 with SMTP id
 q7-20020aa796070000b02901552b8593f5mr2556749pfg.36.1602738573579; 
 Wed, 14 Oct 2020 22:09:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxTnizW2vFtpThp3YQPzh957kld1b3aOAutHHKHaqwl8BgCzLea3bc4ZkHmozWup8Of2OIrA==
X-Received: by 2002:aa7:9607:0:b029:155:2b85:93f5 with SMTP id
 q7-20020aa796070000b02901552b8593f5mr2556722pfg.36.1602738573267; 
 Wed, 14 Oct 2020 22:09:33 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net.
 [220.133.187.190])
 by smtp.gmail.com with ESMTPSA id x18sm1429145pga.49.2020.10.14.22.09.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 14 Oct 2020 22:09:32 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] nvme-pci: Disable Write Zeroes on Sandisk Skyhawk
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <BYAPR04MB496518A4C9FC65964C58453386050@BYAPR04MB4965.namprd04.prod.outlook.com>
Date: Thu, 15 Oct 2020 13:09:30 +0800
Message-Id: <73A03A07-05E3-40FA-991F-5B98C05B51D1@canonical.com>
References: <20200723155731.22313-1-kai.heng.feng@canonical.com>
 <20201013083445.12317-1-kai.heng.feng@canonical.com>
 <BYAPR04MB496518A4C9FC65964C58453386050@BYAPR04MB4965.namprd04.prod.outlook.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201015_010937_341017_A710F402 
X-CRM114-Status: GOOD (  12.58  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



> On Oct 14, 2020, at 08:20, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com> wrote:
> 
> On 10/13/20 01:45, Kai-Heng Feng wrote:
>> Like commit 5611ec2b9814 ("nvme-pci: prevent SK hynix PC400 from using
>> Write Zeroes command"), Sandisk Skyhawk has the same issue:
>> [ 6305.633887] blk_update_request: operation not supported error, dev nvme0n1, sector 340812032 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
>> 
>> So also disable Write Zeroes command on Sandisk Skyhawk.
>> 
>> BugLink: https://bugs.launchpad.net/bugs/1899503
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> Are you sure this happens all the devices of the same model
> 
> and not a firmware bug on specific device ?
> 
> If yes then looks good.

Yes, and this is the reply from WD, requested by the user:
"These are newest WD branded drives and WD already confirmed they are
the newest firmware / no upgrades are available."

Kai-Heng

> 
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> 
> 
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
