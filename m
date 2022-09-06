Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7E5C38145
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 22:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WtdBNLWnEM+WKpTBu/LT2vfwRtXKnQvdbRcYfpz4XS4=; b=QMqO6le+ZLfv+PzL7IoHtC2ZCG
	DVqlHDm/1MV4jBasyZnF52K7Bjytzn7eLE5aztZF4HelfS61mAqo4lT6VlSs0evw7daYcBpyHTqXN
	XrR86+Kj5rLiWK94g2Lqt2eIahRD4liHS7jrs4Wy2ZiAQvxBvc5S08eRHQI1oNx/e+61ngn0Jh1Wi
	cU1vSXCIldiC5wEDDuHYfGK0DfCWTmwGyuHiuK9jxkSEjSpWQgHFVuoJD8X3PrNxydDVM2bH+JQtu
	6ia09xyxvwG40EkKePdZIPN3pB6cOOQsO0zR8y8coi5fYwJtMjOVXMeE3mM5r1s/phuU1jd4WV3dK
	lVbYCj2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVhA6-000JUb-L5; Tue, 06 Sep 2022 22:35:18 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVhA2-000JRr-Cw
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 22:35:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662503714; x=1694039714;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1hG10Gj+FolNTclFGb1Q/V1q7pYCjSYlKl0N3KHDLfM=;
  b=XQURP3/RwDeVjqn+FTrkCjRzJEL34oEY47fR+lq2mqme/orNfsD0a1VU
   T8e1NOrjkaOGoJA6qvT9wbMYkaeWKhL723lk/Y08KT5fBATQDkqze7jWN
   hX1sldg6NlmSnajYxZPydXWe7HoLHu+jK97T/jthYjuED4ZTai/UMV7m4
   zH6Qyu1SbDbdbhab7Uku+lXN4Rp5ilhAoHbWeIggXiF3pr/m1dlvDjvR8
   ZJq0QHr43GNPOCncQCTqQiplsK+xvpwaoPQ7aQLTaQk0Al5PepFDS7SIT
   xwrvXsg9P8BwBmragKQ42zNsaupSCtg8W2XErwBqUYz2sGz2SxrQT+U/s
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654531200"; 
   d="scan'208";a="211150868"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2022 06:35:08 +0800
IronPort-SDR: 672rJczd+oMgVge1UX4MG6QWhIQuEiipaqYBSaR/qjuc6cOn4NMrBASCNijABoDzeyEpygxt4r
 IaWvZVsNeMSiyOOCnOY/Sq+M6ky8FtDO+dzDRE6I8nZvIXh6JluQj49f1VvrzacGy7FCmFFfQ0
 Z/vCr4fOboiZ86Uf5Hm6JO8tIj+H2U9bVdXfDpZ7dSCRwvfaNPQYYuIjaUG/68puUDT81UeBic
 JKVLqwz3JZbooYqsSBJzO75Nafl1CuOP1Q0qHcKOpoRDmVgTLQ2FNAR5jUoY5+3I0VePs6i60/
 /KX3+NRexg3c1ajBNgGZ8vOp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Sep 2022 14:55:30 -0700
IronPort-SDR: CFQzQRm9taBW59k9q2yE6RS+Ra+Kr9Y4UBn0OeAD8V8geBC758IhwPtILsGNIH1YjLZmCxr4m/
 XjYHX1NSE2nYviRItKcPRqOc9bN1zTaGRuLuzuJ26ymH/cSGcYEX2W6lzSwC83JG13MrCSQLRn
 65DxaFRm6fZXSsMZZqW9lSZ5zFA/S2120jA6B683x0k2If9GAEskCzU0DtLpJPNrS4gw3ZcV8G
 qMW0o80MXixo/4jK8EgUVU/oNviIeS4V+K3AAHDEF6ODIGrq+4/thHsWPQPulikfW6r99bOpKU
 5SE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Sep 2022 15:35:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MMgF83mb4z1RwtC
	for <linux-nvme@lists.infradead.org>; Tue,  6 Sep 2022 15:35:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:content-language:references:to
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1662503707; x=1665095708; bh=1hG10Gj+FolNTclFGb1Q/V1q7pYCjSYlKl0
	N3KHDLfM=; b=SK7/C38l1h+3nsVCQlwjum2y9DMHR7UrmRsyw8q/w/9qNo27TX3
	sTpTssMfpIX99y7cz7zum5yC8Xk1umVfurzhGd/bMCv765GOZlHmOUzmizvw/ghs
	wQktCFdzMNHXlNugF6kUwSq56raNj5aMt2bzw1M2dAeSkG1eegux5iRvMvAcXqzY
	g15/gtPyXG09JzmEGonOev26FPSAyNDbOKNQo86EtQFDR5T74ZgHNCTGqcn5n3BP
	YfiXsMiOyabjc4AFrYWBN8EBCEKckCoDQ9FY21Cdyzlg0cV4NJipTRNrWNyyU0Pm
	WSnLg1CRpFnhLAWHTgyd2VBKOZ4H+GCHlTQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1wLPZOP_vW3W for <linux-nvme@lists.infradead.org>;
	Tue,  6 Sep 2022 15:35:07 -0700 (PDT)
Received: from [10.225.163.64] (unknown [10.225.163.64])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MMgF601rnz1RvLy;
	Tue,  6 Sep 2022 15:35:05 -0700 (PDT)
Message-ID: <8154fb0a-4cda-a4bc-29ef-8435a3edb264@opensource.wdc.com>
Date: Wed, 7 Sep 2022 07:35:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2] nvmet: fix mar and mor off-by-one errors
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Dennis Maisenbacher <Dennis.Maisenbacher@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Niklas Cassel <niklas.cassel@wdc.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Damien Le Moal <damien.lemoal@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220906073929.3292899-1-Dennis.Maisenbacher@wdc.com>
 <d3b4ef13-62fc-1bf4-3a5d-3cc740df82b8@nvidia.com>
Content-Language: en-US
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <d3b4ef13-62fc-1bf4-3a5d-3cc740df82b8@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_153514_681935_D4B4E3FF 
X-CRM114-Status: GOOD (  22.45  )
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

On 9/7/22 06:53, Chaitanya Kulkarni wrote:
> On 9/6/22 00:39, Dennis Maisenbacher wrote:
>> From: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
>>
>> Maximum Active Resources (MAR) and Maximum Open Resources (MOR) are 0's
>> based vales where a value of 0xffffffff indicates that there is no limit.
>>
>> Decrement the values that are returned by bdev_max_open_zones and
>> bdev_max_active_zones as the block layer helpers are not 0's based.
>> A 0 returned by the block layer helpers indicates no limit, thus convert
>> it to 0xffffffff (U32_MAX).
>>
>> Fixes: aaf2e048af27 ("nvmet: add ZBD over ZNS backend support")
>> Suggested-by: Niklas Cassel <niklas.cassel@wdc.com>
>> Signed-off-by: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
>> ---
>> Changes in v2:
>>      - Add explicit check if block layer helpers return a 0 and if so
>>      convert it to U32_MAX.
>>      - Add Fixes tag.
>>
>>   drivers/nvme/target/zns.c | 17 +++++++++++++++--
>>   1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
>> index c7ef69f29fe4..eae81f939067 100644
>> --- a/drivers/nvme/target/zns.c
>> +++ b/drivers/nvme/target/zns.c
>> @@ -100,6 +100,7 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
>>   	struct nvme_id_ns_zns *id_zns;
>>   	u64 zsze;
>>   	u16 status;
>> +	u32 mar, mor;
> 
> consider :-
>   +	u32 mar, mor;
>     	u64 zsze;
>     	u16 status;
> 
>>   
>>   	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
>>   		req->error_loc = offsetof(struct nvme_identify, nsid);
>> @@ -130,8 +131,20 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
>>   	zsze = (bdev_zone_sectors(req->ns->bdev) << 9) >>
>>   					req->ns->blksize_shift;
>>   	id_zns->lbafe[0].zsze = cpu_to_le64(zsze);
>> -	id_zns->mor = cpu_to_le32(bdev_max_open_zones(req->ns->bdev));
>> -	id_zns->mar = cpu_to_le32(bdev_max_active_zones(req->ns->bdev));
>> +
>> +	mor = bdev_max_open_zones(req->ns->bdev);
>> +	if (!mor)
>> +		mor = U32_MAX;
>> +	else
>> +		--mor;
>> +	id_zns->mor = cpu_to_le32(mor);
>> +
>> +	mar = bdev_max_active_zones(req->ns->bdev);
>> +	if (!mar)
>> +		mar = U32_MAX;
>> +	else
>> +		--mar;
>> +	id_zns->mar = cpu_to_le32(mar);
>>   
> 
> above 14 lines of code can be simplified as in 4-5 lines :-

Simplified ? It is much harder to read in my opinion...

> 
> mor = bdev_max_open_zones(req->ns->bdev);
> id->zns->mor = cpu_tp_le32(mor ? mor - 1 : U32_MAX);
> 
> mar = bdev_max_active_zones(req->ns->bdev);
> id->zns->mar = cpu_tp_le32(mar ? mar - 1 : U32_MAX);
> 
>>   done:
>>   	status = nvmet_copy_to_sgl(req, 0, id_zns, sizeof(*id_zns));
> 
> 
> either way,
> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> 

-- 
Damien Le Moal
Western Digital Research


