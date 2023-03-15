Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3C6C6FD1D
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 23:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pJAYW5tD+XS1d//BExqpxclvvVl9vuncUaQlwjZwnfM=; b=F3ar4/ShKZtsaZlErLt2ZnzQfb
	uIt4X0j6yda23NALb8eJdrVzZR5icssmXo3BK12iOSdHpcu82b/bPVWBu3d63GYRNiA3Vh8jJYVvh
	qW8UpUsOgYeFiqrW3rIqv9JjBpcC6jW8SyPPd8cDZnBhdIZ8jkCnUesv0PH0nApeIyNPvCVL+esyA
	+PHNlbZZr2AZNpL97i1am9jQFazLgraPTAbxLuRBlsN48Vw7SDEC7iWzvrEOgdhlKhgJP3LxZyZit
	rts4WmZKag6sbeIYzerUsjux6Ozv7cC3uaS6b1shnbb2DmyMvsLosbMONkXxzSa5XtPjJ+2UrRM/G
	ABnVpnlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcah9-00Ek6f-0K;
	Wed, 15 Mar 2023 23:38:11 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcah6-00Ek4y-0Q
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 23:38:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678923488; x=1710459488;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w2xpHGmivqO74AA29bsqRvHmZmKsRDaJtRGtIRVT8Vc=;
  b=F5o/LqA2GC207TcG17RpvnAak9izC19p6+aYsE9+/pv5nOFSNRQhyFD2
   tiKy6pCxgiztdDG+qRBWslqKkG1ryWhLxYCCLQiHO8cgTMFwQKTfk1jjI
   iJtIfa9bJvCej9acMKYc8d7ilyorgArdkawJKhdEkthrnD81ROtdkTPac
   KxnuwgOIUPxRfw98hGuOYPJChjnPIoOyzPZVvsKZL7z4aQmdhIdMkj8dJ
   LQkuuGPOlNtkII5e5ukxuMlFs4AtTG1bcBwC1vAQKV8Te4FkyD4D/O4rJ
   bkLH9eyEcvKH3YZuediI1LaFLXqCdkZPKcMAchQLRhnNNa8qp7MPJ++WQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,262,1673884800"; 
   d="scan'208";a="225518525"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2023 07:38:04 +0800
IronPort-SDR: ANkjibipvRngHdMC1ImESs+3c6Lx7fT5DMkGANYrdCwhNt4JF65el0EbaTXthve17y1WVqXJBw
 N57URkLyLVLXoCqDxp/rQ4RkMAqrdTesTbVmJosvmz72gIQaKM5MFI1U2q6spYx4xL2dloMsDj
 9c90xbGO0E6UITrJgVhEnF8oc2pyVrgI7i+RrykkIQkXeR9QQDSuEuvRs+Znfj/eUdvLdcBt4Q
 +T0T5E6AtJ9N3Sh5qMH7HeoNGyYR6d7c1QhT8VLozp55i4U6rcgn7Dvd6KDsLLG42DSmaxCzrk
 DQ0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 15:54:30 -0700
IronPort-SDR: OsDz6zF8KAxJivqHQFLp7U/omTkRUC3u1VxXnniRGulE3Zm7a7f+wDS4uKK3oIGiIalcX67WG0
 IwGdM54gLDBes10ZhucEpHwFOlKqZi1SHE7pkwRHuGh/+Raqsl4Vy8/Usuw5YbODlP7dMEVs/+
 nIFVDKwfu75xSlQSOierB4p42t++mdVchZtYkVe0Vw8EAZXwMFRE9KGBl7BfKviY0BiAV/BmkY
 czYP2jZ7WvAS2skjK6mA1huiaT0fLBhSpiNu3Lk+3302uEzPY61baeewyQWRSwYTvoMiDru4GA
 4Ww=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Mar 2023 16:38:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PcRf443Bxz1RtVq
	for <linux-nvme@lists.infradead.org>; Wed, 15 Mar 2023 16:38:04 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:content-language:references:to
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1678923484; x=1681515485; bh=w2xpHGmivqO74AA29bsqRvHmZmKsRDaJtRG
	tIRVT8Vc=; b=lY0I+L2EWCJfzzawlwxipUMLTS9DkjmP0vsTffKncQZNff7P+X4
	6IFD+akyi7dOgXUv+Cc7z2CUilXjHIwRdyQcJ34cl9YVEg/KzPWV6rbESh6C+CVa
	K84FsT5Nyfu0/LObDMXlq0WKxnNrq4iBkoJCvyMQJl5ZJOvVL+2WV3gHichsmOwJ
	yyyyDat+e7vs2eyhQ+QbKumcKcZG4l2fAQNqh+UoJ7eeGr8BkUNF5h/oZZe5aLvO
	XOTN4gAKtXBTK2vFpm5V6p+taG2tgqerF32txylC9YTHo11h9UzHkSi3hI2FRRp6
	fvQ1R2tKxGOAyCemaoBV1pjYvhgvv5wbtWg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IiPyPQY25V_0 for <linux-nvme@lists.infradead.org>;
	Wed, 15 Mar 2023 16:38:04 -0700 (PDT)
Received: from [10.89.80.69] (unknown [10.89.80.69])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PcRf33rshz1RtVm;
	Wed, 15 Mar 2023 16:38:03 -0700 (PDT)
Message-ID: <24be7ec5-f342-f9e1-88d5-0001905723a2@opensource.wdc.com>
Date: Thu, 16 Mar 2023 08:38:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH 4/5] nvmet: Fix I/O Command Set specific Identify
 Controller
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20230315105939.305825-1-damien.lemoal@opensource.wdc.com>
 <20230315105939.305825-5-damien.lemoal@opensource.wdc.com>
 <20230315133821.GC24915@lst.de>
Content-Language: en-US
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230315133821.GC24915@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_163808_224090_32770748 
X-CRM114-Status: GOOD (  15.44  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2023/03/15 22:38, Christoph Hellwig wrote:
>> 1) Renaming nvmet_execute_identify_cns_cs_ctrl() to
>>    nvmet_execute_identify_cns_cs_ctrl_zns() to continue handling the
>>    ZNS command set as is.
> 
> I think nvmet_execute_identify_ctrl_cs_zns might be a better name.
> 
>> 2) Introduce nvmet_execute_identify_cns_cs_ctrl() helper to handle the
>>    NVM command set, returning a zero filled nvme_id_ctrl_nvm data
>>    structure.
> 
> and this might better be named nvmet_execute_identify_ctrl_cs.
> 
> As the _cns in all these and the Identify Namespace variants is
> rather redundant.
> 
> Otherwise this looks good to me (and I can fix up the naming when
> applying the series)

Yes, please rename !

-- 
Damien Le Moal
Western Digital Research


