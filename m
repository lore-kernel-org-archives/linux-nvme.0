Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CACCC10F1A
	for <linux-nvme@archiver.kernel.org>; Thu,  9 May 2024 06:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v0fyvv/t4JLmnq2/x7aVOO7zCJex8zcGo6nWWr1z490=; b=hpVFVTM+lg4YUPLOaRVVLb1RJU
	3Js2cfeTRHxls24R4QvDrepztRIK+3VgwofmNcH1qZ4l9UH09o28uBgKmPkvA5jL8GSTx4c4FnzD+
	WF3Xyv80ZjLnQlt7mB4PMx/GJ0phWuykhS/pJGlrgyGsSuao24Siz0GSC5SPn/shjIhLvzRAUfPP/
	JoMzijcoqI05OFBhGw/Mje9J56d86leSJQya0izy+DzMUTMwhciMENOzBh+I/8nrS/GGLh9BPFSw3
	7EBzCnSPMwLmMFXJxWs2LVsX85AX6BnZAB7lWWB2mPhxzRQyS6kJHW+yUJEhw5GHSTnmJqw4LNfj5
	dDME/+ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4xOR-00000000aP3-12Qi;
	Thu, 09 May 2024 06:36:39 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4xOO-00000000aOA-3Zmd
	for linux-nvme@lists.infradead.org;
	Thu, 09 May 2024 06:36:38 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41c017ee8deso12755e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 08 May 2024 23:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715236591; x=1715841391;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v0fyvv/t4JLmnq2/x7aVOO7zCJex8zcGo6nWWr1z490=;
        b=wEMS4lwhkyxZFBZswOs8zA3ZMwZyff9t5zrsfCTYVls41sH7rwESXp8ki6AmEhTUR8
         hSdferWZj1qECF/5WGU8zw1zA2RzqRpgNPzlRL50r/C8i+Pen71LOq9yUzuMLkcubuVL
         b75Vn/EXaCpCMZ8T+9mejurAvPopgJ4kskB4585iMuCXlVjOxrmRou5PQ8MzXgAjwszd
         r759xtziNj8GxXA/rPijzllcV7jRbv9C1nN5WU4s/RBTFC/TsA4ggEwDRlxTjSVqAFNv
         RBpymK2MhjukFk8IOmplXzucrQWEbSJPLjIEBUU7E+KrjKOsFscsfq/dz1wyHdJrVRO/
         tiWw==
X-Forwarded-Encrypted: i=1; AJvYcCVo+HYdnaE36YUdXrWXXDv2JJQTiglmmTwwDWWkKDrlLATpxksZDuZ+rBNajN46QV6y7C/3ZCBhuRbEmHW2MUZpssH7NsH4xClP3CuydQY=
X-Gm-Message-State: AOJu0Yxur8fLCR6kS1uhHXICVjkeTNp5L9hq4gf4EBmyzRuy+n7LsJZB
	QK8hZCJysb7dOdu5J4hX6fBiehpYdWUqhCGWaWTQw5Kbz9dMvDuv
X-Google-Smtp-Source: AGHT+IF+4UI1V/bvMXBYMRBn6YUXeHc3GcJhO0EB/9GeAyfPEvkVJoEfqcj1J8TbQs+Yit81vwgcGg==
X-Received: by 2002:a05:600c:1c93:b0:41a:bb50:92bb with SMTP id 5b1f17b1804b1-41f7093ca92mr34421685e9.0.1715236591237;
        Wed, 08 May 2024 23:36:31 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87c25459sm48317745e9.18.2024.05.08.23.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 23:36:30 -0700 (PDT)
Message-ID: <dfb9074c-d019-4a19-83eb-00d93da8dada@grimberg.me>
Date: Thu, 9 May 2024 09:36:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WQ_UNBOUND workqueue warnings from multiple drivers
To: Kamaljit Singh <Kamaljit.Singh1@wdc.com>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <BYAPR04MB41513F04DB2ECDC3601CC36ABC2D2@BYAPR04MB4151.namprd04.prod.outlook.com>
 <c4057654-97bd-4721-9bed-9dd5ef8b3f8d@grimberg.me>
 <6d3af8dd-30c3-48d4-9083-7f00ea21ff8c@nvidia.com>
 <BYAPR04MB415196EC84756BA1876463DABC3E2@BYAPR04MB4151.namprd04.prod.outlook.com>
 <f5d57e3b-8168-41af-8e36-c7a21ef3a475@grimberg.me>
 <BYAPR04MB415180536421C9B8326D6A30BCE52@BYAPR04MB4151.namprd04.prod.outlook.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <BYAPR04MB415180536421C9B8326D6A30BCE52@BYAPR04MB4151.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_233636_916522_F25F58D3 
X-CRM114-Status: GOOD (  11.05  )
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



On 09/05/2024 2:16, Kamaljit Singh wrote:
> Sagi,
>
>> Does this happen with a 90-%100% read workload?
> Yes, we’ve now seen it with 100% reads as well. Here’s the Medusa cmd we used. I’ve removed the devices for brevity.
> sudo /opt/medusa_labs/test_tools/bin/maim 20g -b8K -Q128 -Y1 -M30 --full-device -B3 -r -d900000 <device_list>
>   
> We saw the original issue with the upstream kernel v6.6.21. But now we’re also seeing it with Ubuntu 24.04 (kernel 6.8.0-31-generic), where IOs are timing out and forcing connection drops.

Thanks for the info.

>   
>   
>> Question, are you working with a Linux controller?
> No, with our ASIC (NVMe Fabrics bridge).
>   
>> what is the ctrl ioccsz?
> ioccsz    : 4

I see, what is the mdts? and what are the r2t lengths the controller is 
sending to the host?

