Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E904C61DA4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 06:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0WAy6nTxOTihlobl/IWU8zEs/K3xXPElv08CObD60oI=; b=eaerGuwmQoGGoTkE/OGY85Lp4d
	ORtcLwOc75R05DomMDZTghPvn3u7M7xjDB7GwXfsHw1B3DNo6Uh4Sg/m+tiDfGGHry+3UG4715JXJ
	Xl+pE3vk9BiHlosQFd0X/xEhpGzlgyeacLRoRLOi0uHzaXTEJ1ijjvM221TZ51ag/bwbuy5l25uYh
	wUJSUBEDaRSXIGwQLiG5NXrhGVKyLNlPsS2xl3zc/G2Jq7RRSch+Pz3SC6qjAduW0uvBYAO+zZ7MG
	g0qWX6kac88QKKiisgCvSaNlfIU/SjJJYF/+0zJt8PRxIwxOzMKEEtUAlSGxQNtQrz6DVIfLg/Dve
	AOLm5/Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcKjk-00CXtL-0n;
	Wed, 15 Mar 2023 06:35:48 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcKje-00CXr4-2r
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 06:35:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678862142; x=1710398142;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=AqvR6GWOBuBZevsqJZBGWkod3RAJcrPxbAf+fENeafc=;
  b=RO+cY/BU2LRGeqvzaYQLFWKXyw9YCThmt9h54HBNBsR6wJTNQoa3G9BO
   Wfe1H2+ggrE/x068+FuT5j+mnkCiIP6Ab0BJPU9YErXk83fP9qojvttUj
   U/uVoHzUfoEgM+BHUEeJDfSViaOzuwI9f5Tcg/0rpg86NZ1nv5+Szw3KY
   mgDexFn0SWCVxF+vIyiLsCmTlc9XP6sG/+h6ItrKIQv8vdgkBEECUmO57
   j++iPim5c4GbH0hdkpGaUN668bjTgvxIF4n4ukcg/wZ2pYVje2vBlM0oF
   DWyicPKdHeoOV1sedK/ixmE4k1WgZbIDuzmUztxsqIauMCMhJCriEEVb/
   A==;
X-IronPort-AV: E=Sophos;i="5.98,262,1673884800"; 
   d="scan'208";a="225453214"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2023 14:35:40 +0800
IronPort-SDR: b9TcLV73WDqLIbLCdJk65e+AcgRNVgdo1siN/adVLsttfb3/ikmOsMD2QWCrnwjapndyLWynPC
 leL9+80NHT00En6/QuTYOS03IfYZu2A9Ak0vnigGT1yjAteIA7nQJIzXmQKbaqVU0gO+iX5YIm
 QyfOkdoNSeIjXsT4A9oTXBe9xjdF6sh1C7g63r7RDwatZjJpZHgVq5QEQoM2kS9/NnC+94QGh4
 iR/tZWgjafST1xRhN9zBCzioC0GMoBPx0brJRqMnm914WO7F9NDPQA7NxOOJOnVjHUqGu5Yfe6
 kYs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 22:52:07 -0700
IronPort-SDR: +W619Ps+DX2EkHfAmgllfU4PmV85JlLA20AnvU8t8nZxlBhhqR/eoTObMysbaegMxXvdY6lCB6
 +iaw46QoDYhbbVYmDrayX2GYSLaF2KyXxNHAc1UEF27pczeMg2v26FrsI2uNvaQggCUoLs+vmx
 QcnaVqrDxxkgnM/J3UVPLHt7pMoKEvwAtzMZ/GA+bWRc5IPf5e/IIGF3S80L/8b9C+LzBozYpl
 Zb9ssA1kJ2ZmGdr3ZY72heNMO0tnaMmIzxFpnAJEgxx8wulADqltDbLVl5LjYf4xa0jTZgaSnq
 gVo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 23:35:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pc0yN31C7z1RtVq
	for <linux-nvme@lists.infradead.org>; Tue, 14 Mar 2023 23:35:40 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1678862139; x=1681454140; bh=AqvR6GWOBuBZevsqJZBGWkod3RAJcrPxbAf
	+fENeafc=; b=KDWgBge/J4lB9OpjS1dsx0E3fvnJ+JnQ4w64VwaeOhB7jri+amH
	RnHJdWJB/nQYVGIBI/wSM9kcuwa42nCorTkXb139cVYo0bNYrHshvMKLD8NGw90b
	D889ptbGFsRq+uCyQ5C3jksTrAVZes0dWJQ1dSMTPsZdpr6RrxTYspP5XRBtNHEP
	9+0VB3FvrJtuva/R+4dLsZdjsUfEK9oj1dq1TQRsIOgmnF7XSLbDM7NKZCuzjZGN
	oJB8SyAMsqBXjDaU5usmlRxK+H2Ix1vXE2DkHma8OLF9WkVfcfPW48QZpO/pmhEK
	TAXUQRMciU41ak6pSMWZr5e2Za6IxLPEtcQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id F68by9WVts70 for <linux-nvme@lists.infradead.org>;
	Tue, 14 Mar 2023 23:35:39 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pc0yM236zz1RtVm;
	Tue, 14 Mar 2023 23:35:39 -0700 (PDT)
Message-ID: <a846edcb-456c-ff7b-db9e-a7cdb3382acd@opensource.wdc.com>
Date: Wed, 15 Mar 2023 15:35:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] nvmet: Fix error handling in
 nvmet_execute_identify_cns_cs_ns()
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20230314062036.25939-1-damien.lemoal@opensource.wdc.com>
 <bc96f62d-8bda-4d98-a8b3-6f6e40aa7746@nvidia.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <bc96f62d-8bda-4d98-a8b3-6f6e40aa7746@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230314_233542_988357_79E49FC1 
X-CRM114-Status: GOOD (  18.60  )
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

On 3/15/23 14:14, Chaitanya Kulkarni wrote:
> On 3/13/2023 11:20 PM, Damien Le Moal wrote:
>> Nvme specifications state that:
>>
>> If the I/O Command Set associated with the namespace identified by the
>> NSID field does not support the Identify Namespace data structure
>> specified by the CSI field, the controller shall abort the command with
>> a status code of Invalid Field in Command.
>>
>> In other words, if nvmet_execute_identify_cns_cs_ns() is called for a
>> target with a block device that is not zoned, we should not return any
>> data and set the status to NVME_SC_INVALID_FIELD.
>>
>> While at it, it is also better to revalidate the ns block devie *before*
>> checking if the block device is zoned, to ensure that
>> nvmet_execute_identify_cns_cs_ns() operates against updated device
>> characteristics.
>>
>> Fixes: aaf2e048af27 ("nvmet: add ZBD over ZNS backend support")
>> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>> ---
> 
> Thanks for fixing that.

More identify fixes coming.

> 
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

Thanks.

> 
> -ck
> 
> 

-- 
Damien Le Moal
Western Digital Research


