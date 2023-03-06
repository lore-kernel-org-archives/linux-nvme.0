Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192F6C61DA4
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Mar 2023 13:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=trTdywrHYXwzfPD8hCeMgDXfC9m/FtrVRYPfGappSLM=; b=MGH2XwUl95CWwRdQw6/4QgvVhJ
	EapGTHeKLC/bdgaajDnXLK2gkocyhEadaBxBJzCAeY1BGzOMlCb/VJ6Mrwcw8ObAlURhC+8glY/ga
	idtUrzx3yQzUG/p5WVtyqqVp0+gUfCVHwbGLhMRPQHUEjzYht0nJJRunGBTFTXt9gy+zrRHm8V0WP
	LGLIDkQnKoUheWSsZeFIthegzQ7rFqms6hwBnVuQZtiv3zohIZ8o4+rkWRlgQNEIdxxVMEjuMlNTQ
	sG862Oc3ADWRyVynE5KOBoJajuQdf+sZnt4lABgFu65rnAst/kr8MkHHesU9PAAmkFS1/o+xrgYSQ
	TabTf2vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZBL4-00D1CN-4q; Mon, 06 Mar 2023 13:57:18 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZBKu-00D17N-2q
	for linux-nvme@lists.infradead.org; Mon, 06 Mar 2023 13:57:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678111028; x=1709647028;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=L90qAkxjBVj6DIZBsEuoJ2Cts4SB4rkQA6/JjCq/gyw=;
  b=SqCFDQHlkt09paRchZS94D+qmPgWwACAxBD0lfTxADfoxtXoTGAYCtri
   ekdpL52pX4nnrztL4TQ74vjUAZ1DkWPbAWMx513iemovkmc4OfA9U/T64
   ywjF3LujUv0PBVycSRjs6m87WPXyNs9iChkwF49qWwh8eYyeP22n1i6ho
   1YkeAlP/9U5WQNroxh6rasnvmjDx5wFMJuxKGNdEVwurqWyA8+ayPjg1U
   +XO4ev8EkXjyAy3PMsI2uOX1n54zpkx7TSb3HfWWR+TFdj8SolZUs+nXw
   Mvt/T90FZrBJ9DHsESnWheDLBd40XNJVEUoJ0tK+3bCNc1z6PKnaBuF/Y
   A==;
X-IronPort-AV: E=Sophos;i="5.98,238,1673884800"; 
   d="scan'208";a="229866151"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2023 21:57:05 +0800
IronPort-SDR: l/NThY1AauGxWJW7NvJQkqknV/Zmeqc11Ygz3AGCLnn3cnvukWT7LVLekb2SQWPw/LkPckD3jR
 IhoGsLS1+kHEIlAfgeiLUdXngRZsJbRT/nwiTfKrkErM9qP3Hmz/7ha46F4bjN0CUOh8G9AfyG
 P0AnK99iGb2RKmsooZrIEqxjhjhofC18uCKrF5fVQQApCwJevU04qYDToaPt7ODfv/RAr6CX26
 vbNOj4Za9djnq7Uvtbgc8tGLYjORcqVYJH7a7bOudTVvBWudepAS0kQwEOEmiT4yhSI2KHcbuR
 A2w=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Mar 2023 05:13:45 -0800
IronPort-SDR: JJVtp8GazcRIdJXC1ljh95aq/B4+N0FuAyHciUmeyZ39tMjAKhur5G1JkcOX/qLrkN1KT5BV/o
 7BQoKCHCt0rpc4/jvVD//3RIGyitsl9GypJtlC2M66pmEG3vxJRMFmY477pxCHruJW/Z5WMt24
 vpPGYDJ+Scvd8sZ5x/q/4lZM+XY2JFjbnOWzHeKoo9Kma2fBejr1GfiLb8Vls7abEceMxczyy5
 Ggk9zuxyjiwGXZRIMnLmEytvYpfKbbix5h94Pwija8k679IMcnssBdGCZSa+3N4dGQp2c/HWZ7
 aAg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Mar 2023 05:57:06 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PVg9r4rS1z1RvTr
	for <linux-nvme@lists.infradead.org>; Mon,  6 Mar 2023 05:57:04 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1678111024; x=1680703025; bh=L90qAkxjBVj6DIZBsEuoJ2Cts4SB4rkQA6/
	JjCq/gyw=; b=Nd1J2m/r+Eai6uaePR5HjvxZN2FH+aWal8UIufkLKTt6DOpkL6U
	2e7SnJMlJWMQqKX5umaqRsNOQK+2klmAHfQSUFH4j/Ho6OTBwQr3KNEYNY6gB6zb
	3i7JEdONwVE9MVBoz4KZh04o3+m4mtAY+ixe9XP1blLp6iY203gvNVAqQyPuTbad
	cuqzlwNGpZmGczTZPRNQ/YgLwbrxSl0f0FpfFnnmo3MM5UsJClws0xLaW2qaXrCl
	xoEVRansaaq5lzxyT6a3awQugLdRwS6jR2OCTNhTWW95yJOkA6ILQLYkhq1tZUC2
	KoQv1Nh0dLGlMQIvnUGPlqrBRk7rvY9lZkQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4plyD95A-yQV for <linux-nvme@lists.infradead.org>;
	Mon,  6 Mar 2023 05:57:04 -0800 (PST)
Received: from [10.225.163.56] (unknown [10.225.163.56])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PVg9q4fVSz1RvLy;
	Mon,  6 Mar 2023 05:57:03 -0800 (PST)
Message-ID: <afb050c7-0029-ed87-7b77-720b559af798@opensource.wdc.com>
Date: Mon, 6 Mar 2023 22:57:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] nvmet: Avoid potential UAF in nvmet_req_complete()
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20230306011313.99870-1-damien.lemoal@opensource.wdc.com>
 <b0af3112-6f6e-809f-bac6-2a6e245b9245@grimberg.me>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <b0af3112-6f6e-809f-bac6-2a6e245b9245@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230306_055708_190701_1991E0F1 
X-CRM114-Status: GOOD (  21.52  )
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

On 3/6/23 22:52, Sagi Grimberg wrote:
> Hey Damien,
> 
>> An nvme target ->queue_response() operation implementation may free the
>> request passed as argument. Such implementation potentially could result
>> in a use after free of the request pointer when percpu_ref_put() is
>> called in nvmet_req_complete().
> 
> Can you point me to which transport frees the request?

My prototype PCIe endpoint nvme function driver, not upstream yet.

The endpoint board keeps randomly crashing without this patch and not freeing
the request (embedded in a struct) in the ->queue_response() operation would
require *a lot* more code.

> 
>>
>> Avoid such problem by using a local variable to save the sq pointer
>> before calling __nvmet_req_complete(), thus avoiding dereferencing the
>> req pointer after that function call.
>>
>> Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
>>
>> Changes from v1:
>>   * Added Fixes tag and cc stable
>>
>>   drivers/nvme/target/core.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>> index f66ed13d7c11..3935165048e7 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -756,8 +756,10 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
>>   
>>   void nvmet_req_complete(struct nvmet_req *req, u16 status)
>>   {
>> +	struct nvmet_sq *sq = req->sq;
>> +
>>   	__nvmet_req_complete(req, status);
>> -	percpu_ref_put(&req->sq->ref);
>> +	percpu_ref_put(&sq->ref);
>>   }
>>   EXPORT_SYMBOL_GPL(nvmet_req_complete);
>>   

-- 
Damien Le Moal
Western Digital Research


