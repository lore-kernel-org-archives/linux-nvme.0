Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1AEC433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 20:03:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A77F221E2
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 20:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C42AE1D0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A77F221E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kJkyZI61vo/c6dSUYOHwJCp09Gz830JAgLpCekQaE+4=; b=C42AE1D0cyTY+VSqeu50Xm8nH
	kWv9uWqAdIr+DJCbsv3lpHEWbxEn+zEzRXFHCsXgQMA8nlrp3BJmkd19CAE7sw9I+fb8Agni3K7Y9
	pfqtJuwDd5CL3uqT05ipigRurLS8oIDN6ebiTzDmZdDop56rvhK62lBK6XVijvDLoIXULwkMkRb66
	VDPi5hMRjeArT/6/Wzk+SY3DnJB0WbkOQZAO65l5IhA9iwZV1WFDiWiFeAlVWV9fOi75ISLrh1PKR
	b5Vx9zawU+wbXZdsFn2dnP4kI2ToG0JyU7DDCuddS2UOS4AqpC3vZlLe8mbPGbdPdQDqWr4rd2taS
	sQTIc2xgw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3m7F-0003xK-Hk; Thu, 06 Aug 2020 20:03:53 +0000
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3m7D-0003wh-Nu
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 20:03:52 +0000
Received: by mail-pl1-f193.google.com with SMTP id t10so23005932plz.10
 for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2020 13:03:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qzUMojKmCEpeVjeMEZUdci3XlThHmkYuAIzy49/WrNM=;
 b=LMSa/+Gefb1KFzuYmdCgT5LxsGZkafXgWTwB0fdkuyPxFaEJiu2e415hka1VEstxf+
 +qesxAMiVUyQCN0qtrLfXQeSrfJVNi3kWE2DDEQFtMZhZWo9iLnH42I6B43gruRWO+zh
 Z7Qf41o4iwlJ+PQMWR5uHn9uJM1TEjFYJ21UM3hb5vaSpDjRVMWlGDC1XKB5N+a8cySR
 E7Zv/F5N3PM5IMkge8XoHmEpux5VhL3cdCbNc437+QMXFF80LpacY44oig87e2qdnL7S
 Ov8zuCTKV1usQpCxW/jxDqyChu2Rny+Z1BfMERLCiMRtt1R4jwK0DFMu8iB3Cgsu2k+l
 6d8A==
X-Gm-Message-State: AOAM5334BUA4rSac3dFZmQyYq5bAhWclYxDy8F9lbmjB6z/+zNC8Rr14
 9P9Sna9Mu0BIp846BXFEbUw=
X-Google-Smtp-Source: ABdhPJz7hUmY1NOUFohesNyjgALcpExf7zI1Cz4d7UTxcTfa3JUzO3A60AcUipB2otnD6odscrp1eg==
X-Received: by 2002:a17:90a:4488:: with SMTP id
 t8mr10444549pjg.191.1596744230823; 
 Thu, 06 Aug 2020 13:03:50 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d88d:857c:b14c:519a?
 ([2601:647:4802:9070:d88d:857c:b14c:519a])
 by smtp.gmail.com with ESMTPSA id q7sm9185275pfl.156.2020.08.06.13.03.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 13:03:50 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvmet: fix oops in nvmet_execute_passthru_cmd()
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Logan Gunthorpe <logang@deltatee.com>, Keith Busch <kbusch@kernel.org>
References: <20200806073151.56061-1-chaitanya.kulkarni@wdc.com>
 <20200806073151.56061-2-chaitanya.kulkarni@wdc.com>
 <20200806154247.GB3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <1f6a1c73-fd0e-d05d-3254-03d0592ac998@deltatee.com>
 <20200806162602.GD3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <BYAPR04MB49654162034AA3CBA2F4E49B86480@BYAPR04MB4965.namprd04.prod.outlook.com>
 <5dd8cdbf-8864-ecd4-928e-daa74a9cd166@deltatee.com>
 <f6944200-35cb-e38a-b799-92bb4036698e@grimberg.me>
 <dfe9e93f-ceff-d666-c857-a0b7979e0673@deltatee.com>
 <BYAPR04MB496536159E418BA64D034A2986480@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d06c9d7f-cab0-2a3d-aeea-49e203529fcd@grimberg.me>
Date: Thu, 6 Aug 2020 13:03:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB496536159E418BA64D034A2986480@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_160351_816236_5B03C1B5 
X-CRM114-Status: GOOD (  10.41  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>> No, because the ns is only conditionally allocated if the queue-id is
>> non-zero.
>>
> but ns == NULL?

Logan is right, you have the admin queue condition...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
