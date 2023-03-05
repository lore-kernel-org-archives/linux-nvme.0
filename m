Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E110FC678DB
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Mar 2023 22:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jeFZZ2rqEpElbTicP2c7Kp4I+BDEmgl4AuUQ78xoacM=; b=kpavkabp7YTvmF/FdPFcfXiw/n
	xlgKK3h6/4/ktvh7ejrZEd2NWNx+9n7aTAlze3HxAmWsn0+6sPD44+jmncJ8NW6a2bcV/quLmSKa5
	vp3jI53TdySJFgp78xhhHtLk55Dl9rat5nojiTHhBgHU+acPo7w70VUbex4x93R8nZ7AnAI9kR5J9
	Mqb7L3BJ58mymo1Vxy2erV+BYqEnJjvEeI3w8DEoCnv5nwJmkZVFbwrQhC03POMzuseBQT1jg0iZG
	sxKVevYlQ8V2VS+uMGFhhPlMRdVB/QLKUfOIwRGcGNln3gZ1jPeUKDOsPX9SeqJy/wO+5GI/SIeZc
	FVXl5G3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYxFs-00AlJr-3b; Sun, 05 Mar 2023 22:55:00 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYxFo-00AlJ8-Cp
	for linux-nvme@lists.infradead.org; Sun, 05 Mar 2023 22:54:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678056896; x=1709592896;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=JaqyjufQiAz3RP5R/20/ZxJ5GosoEQA32IhQS9z0Fjo=;
  b=mX6iHvgnkNWeYjhnIMcj31TUYmr/Rm3Y6OeZXeVViiTI2NIK/sBqaMmP
   pnLRrazFpmEPlAP9dyHQD2E8RUa8pbY439Nl4gcv6tpwDb+3dWTZHXND7
   l1ElmarukzRuY88NtKwxqe5BTCmFoTVrVJB+sILR0HhJW95qySEkBG9yO
   O2EH8hUVffBN2LQuq6NF4+Iywa+LvXZd2nrQD7gGaaJgJFG7VsrAOCrjb
   AKmLcvPMV1+DT3J4VsiRC0TxTH7+wFx3r3/ctuLfN717U/qwBFHEzthKH
   Vhc7P+BlEiBqJOtbSiwMoQLjwz37z/PlpuxlVsgyZ5vQIVklqKUImtGrb
   g==;
X-IronPort-AV: E=Sophos;i="5.98,236,1673884800"; 
   d="scan'208";a="224638702"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Mar 2023 06:54:52 +0800
IronPort-SDR: 9suvJZiyS+SRtU/TQ2VZmXcowykJJ8Lpr2VL/UAvZPkvtYLxrMW9eofy1NF4JMJL0rpE9EWvC3
 B9jQqrhcrIAY5uwUY+VnHLaRmZ7X+j0uHmUyW1/Sd2HWM1DwgIf0+ss3A2JVafIxP+KEpMVpZH
 81nDAfAvc1CaUP/awtmwNI70vrObYizGjazphsPfi6YQQkW79lf6KSCHvEIo4Vlno8z8ff9Ouy
 OARrmckhXYvKKC5QsJOrJYfXQzbOIz+3zfYls/JM9aVV2MHCyBRSIG0JZk3Q+BNokL/jqwdEk+
 +hg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2023 14:11:33 -0800
IronPort-SDR: xykY7m1m4EcBTBIrz8TlqoSFwMSQ3tN2D0NtNY0ymQN80cFoecaDT41j2D9Mn3X++S/S+Jwjz8
 w2pZuQUyAIeM2P7hgq8Gx/eEdBoTOYe5ze9/T+aKZom2i25pydWjM8TX9+axxAb9miid3PKEOX
 76jZQRbhH9+bEhw0Q/J6CW+rh1Ek3CpZX9OYrADDQXtJm6s4ebDD5K+1+IFNmvoqJwtIIL7+zj
 kptL2a0ZwZJjY2q9YfYrnT12NLXS6GBKVGklR44EE5NnR2NurQgtQ+UJ24X20nopnzV3JXrDrC
 9gU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2023 14:54:52 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PVH8r1ByNz1RvTr
	for <linux-nvme@lists.infradead.org>; Sun,  5 Mar 2023 14:54:52 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:content-language:references:to
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1678056891; x=1680648892; bh=JaqyjufQiAz3RP5R/20/ZxJ5GosoEQA32Ih
	QS9z0Fjo=; b=XqcQ2KFWAjUzQaa7nKfmCNoG5VVOtmFnLi8KXioeaXL42CcaEVA
	BYBmdAwItwGmFBgn0jB2nTyxRL3koMWaBjomyKZupbJRR1GHw7lI/p9ot8l+V9Mo
	Xjd/m7w1EWufuFp+a5fXybRu8mQ4Hb4kpT16TvTSLjEWPYKp7eEe7VZ1baq1/hS2
	F4AXCDkr9Rm2muUiVShw93yuP4oto1UfV0s1sAlVhtsEllUxLN4qzfAdc6YbLSpf
	UvImY9fuGH42rgaVs9TqBg+y947/ewcfIryYgDToqjBXw9FfFaRMKIcAzvc22d16
	lLFVBmzXKV4D85jUYGV6Y0rTi0icaL0QdlA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id l4NHmwSkiObf for <linux-nvme@lists.infradead.org>;
	Sun,  5 Mar 2023 14:54:51 -0800 (PST)
Received: from [10.225.163.56] (unknown [10.225.163.56])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PVH8p4zxZz1RvLy;
	Sun,  5 Mar 2023 14:54:50 -0800 (PST)
Message-ID: <6f8cb7ca-5746-7bec-be89-d01b5df3ff26@opensource.wdc.com>
Date: Mon, 6 Mar 2023 07:54:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] nvmet: Avoid potential UAF in nvmet_req_complete()
To: Bart Van Assche <bvanassche@acm.org>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20230305050733.4768-1-damien.lemoal@opensource.wdc.com>
 <8d5f03aa-6166-6cbf-3287-86328d710df9@acm.org>
Content-Language: en-US
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <8d5f03aa-6166-6cbf-3287-86328d710df9@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230305_145456_536456_C24715CC 
X-CRM114-Status: GOOD (  19.19  )
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

On 3/5/23 23:42, Bart Van Assche wrote:
> On 3/4/23 21:07, Damien Le Moal wrote:
>> A host ->queue_response() operation implementation may free the request
>> passed as argument. Such implementation potentially could result
>> in use after free of the request pointer when percpu_ref_put() is called
>> in nvmet_req_complete().
>>
>> Avoid such problem by using a local variable to save the sq pointer
>> before calling __nvmet_req_complete(), thus avoiding dereferencing the
>> req pointer.
>>
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> 
> How about adding a Fixes: tag?

OK. Will find that out and add one.

> 
>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>> index 597d1b2c0d52..0f9193323a02 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -758,8 +758,10 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
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
> 
> Interesting. The above patch looks similar to "[PATCH] nvmet: Fix a 
> use-after-free" 
> (https://lore.kernel.org/linux-nvme/20220812210317.2252051-1-bvanassche@acm.org/). 
> One could wonder whether there are more occurrences of this pattern?

I hope not :)
With this patch, the PCIe endpoint nvme driver I am working on has stopped
randomly crashing.


-- 
Damien Le Moal
Western Digital Research


