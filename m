Return-Path: <SRS0=QPGu=A4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583F9C433E5
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2020 01:53:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 204B22076D
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jul 2020 01:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T+TjD3YO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QklBk0wa";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Z3TIU65d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204B22076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=AGdGRAk+neeRIkuyASxrgohKsKVP6bb6NuSds7HbmE0=; b=T+TjD3YOILQasYE/LZUnnEyjN
	ETyE4HshnKLNELNikE1VXF4kfE3XT0uk/3Rr09wS6bwDUh59kY+W1KTk3rI+X+Rg5u1Ysh9cXzC7g
	66+NsE1/5Rg+urSakP1uujEEWUn0SEYkn7TAkYOcCEITx8tsimAWcWTETIOPXvwc3rG+oSDgmelCS
	s4LRl1yvh+cbpCZW2NtPXiCiob30RlLwQ/jkuAgHiEOefhEntbIf/fjeP6yi+ZxWEEqp9oBuzfrWN
	X9hY+NSt0k6Y5Y+8yNGSLLoRLaznee52yDKzt0gA9uL2c9Uisz0E1hwi6sDjKEsgRSNyCRr7PbLCC
	XiZM9COyg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jwFYb-00052w-5w; Fri, 17 Jul 2020 01:53:01 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jwFYZ-00050u-1h
 for linux-nvme@lists.infradead.org; Fri, 17 Jul 2020 01:53:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594950780; x=1626486780;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=JcIakLT7nWgq+b0EdkLb6Nj8pDJUdoLuVF8YeO5jsLA=;
 b=QklBk0wa9gxyQpbf5E/cFdZs9Pp6jG86I/B9Bd0pLUx2OIyOn4Qvb5i0
 6Imepzpe+03Vi9U92MTnCPeafxIjNO8C8LkT0UPCcFin1qC8WtwBzgouy
 fy0ifpFCU+2YB8h7RaeQ1fw5k9OLLN+M/aYXTxjJo6uollAeZs0XvE/j9
 BtZDnYnXCjoh2x473W7i+NUFLXxocju+/E9WQWuNXCNVC6Cy68t//427m
 YDieMG5esHFYfumGSmmxsweee3TwH90SarDAdxWCFHaz+xtBcoj2qoUJc
 d6j0jI+YCMANf7NZ1oG6M6aMVebH9FZ7vltBFd7YHTJ6Mk/wvsmQKw2iF w==;
IronPort-SDR: Wr9/1b9IeF5utDgkjQpFExBVOaiictj4HniZjTxlijOIykfixjKh873bxVJ3Yldz8jxNbSFFJB
 j2/XAUZoS5igalDbVAdAn2NIsmx7xdbYAdsangVT0Vm+Wzq0sxLIq584pzmVYCJwTpJ7a67hY0
 U8mJ2ALCNYdJtMfdJIQOnvdYMS3ydMflfqEzECKjzXnh5FFLMRc//DUdOs1UqiU9tUoJuWSkAK
 O/THCJAKz0CP+dSNtoFe29aIgeZAXC23VmQpfqLkwYk1bJGVcnY5AiuozeGdsoq6efkPNx9MzF
 5UY=
X-IronPort-AV: E=Sophos;i="5.75,361,1589212800"; d="scan'208";a="143960026"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
 by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2020 09:52:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwGmxuzfJ2Ftf/ar2m5jKfC/k8HHqUlPswUyd3xJeX1sO8iRp0LqB58DBx/0eQXuH8KrRh0CBaUHUxsOxOy2TmhpV7d/yA8vSW2++3+f6s1HSIeXiLuyFZjswlEVU2cMkWacmDmdwi/zlK1H4RHP/iVrY/2CW8S5c50bMyBXkcRqP80IBtebmizJzuXM+XdH/GxzLRATAT9QhiXMFt5Qm+kTih/PnFSfsys5NIiFUHVGlAIMc3EHWhcmY8xrISfVxgS6xkViHAHVMRlwV65M3O6or2SgIemNSmVpZ55LsfNfj3TscQoDuHQ7hlBeNzPYtqlL7ObbQgW7MEESHNphwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj1rkOEUz4R0/8oJyowSXLEjCXUTpztraVLeIT+2zfY=;
 b=mL2BS8xnqU4D6uJYtKOD2rfV15eCXNrNDf7ecGbdZfd8cZvv36GS6+lku+NOZNzbg2npP6a0pKYb1ElwzIRleoFZ9o+VHzs7dYAv0v5psveNQ2mGZhU1yAFOTwDq2x0r5pEMGrFZEKyv2jkL9PVhnIuF1TY9a7SHvYqMsS+o5ZhAq6HWs1my0AAw0AwBHF1tCKOlrCQZCfVs6Hr8DN3WCRcLc4L4bXkYoBRg38lGSzr445ibIdrAMvL4oZQcyhA1eaB1IIdNLp0uPN8cELW9syWaq9eMCsqSydDd+0DtdRthIu8nqhqs8XlHgO2SZ43+wV6D5lPNUWKVUkf3s+S+YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj1rkOEUz4R0/8oJyowSXLEjCXUTpztraVLeIT+2zfY=;
 b=Z3TIU65d2+Qs2vkkljpjapYeUZIWi21jfVrDv875XWEA2eJAgKj/ClLGm8OW/i4tX0D+kU/hTiFd+yTKFN/iHRyO5FYJg95Kk7Jzb24tZ1j72jDZepzJA5GEm6OIEfI2LhHjNifwLfYDGg2EDbR0j1NFQ/q7HJIqdX9DYu0d6PU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5590.namprd04.prod.outlook.com (2603:10b6:a03:108::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 17 Jul
 2020 01:52:52 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3195.018; Fri, 17 Jul 2020
 01:52:52 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH V3 10/10] nvmet: use xarray for ctrl ns storing
Thread-Topic: [PATCH V3 10/10] nvmet: use xarray for ctrl ns storing
Thread-Index: AQHWWjcLD0MBisrCmkelYLSVe+sToA==
Date: Fri, 17 Jul 2020 01:52:52 +0000
Message-ID: <BYAPR04MB49653635113B5EA26861EACD867C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200714233057.10915-1-chaitanya.kulkarni@wdc.com>
 <20200714233057.10915-11-chaitanya.kulkarni@wdc.com>
 <20200715071027.GB22320@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b4f093b0-32be-43e2-56fc-08d829f41e38
x-ms-traffictypediagnostic: BYAPR04MB5590:
x-microsoft-antispam-prvs: <BYAPR04MB559043C647072E43CD0BD8A0867C0@BYAPR04MB5590.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c3x9+WoOjJM7Za5fRy2X3DaW4IXRhjSwdBmh/GotW7uxvsLoqm0PZs9qqtGF8aqnSqU3DQ8xN5ngDb/IGrHYyG0bTMbTP3XXEbPgF2SAnZucMmctoeldp3Dz3AXw3HIinQQCCAsulHlZE/lk8jAIUhmYhtmkimYS0DJxeJjUbrFW4ctvpNiNjV6fX8/w6TpXI/QrXYyYl0gW/MWPeBErl7V9IwD77urQ2JsRxnhmf0GGQFrYqN5UEZrve1Qb9d+nokCJ/2v053fETcy86zQUNStwsHtL2eA2PeSm4+P/iT3GfSAf3jBPfFHZ+zNSmeVRqGIRq3GDWdGXEaPIoLoFZA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(2906002)(33656002)(8936002)(5660300002)(316002)(66446008)(66556008)(66476007)(64756008)(8676002)(55016002)(9686003)(83380400001)(478600001)(76116006)(4326008)(86362001)(6506007)(52536014)(71200400001)(66946007)(26005)(53546011)(7696005)(186003)(110136005)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: z8kuNQRIlcZZfKvq5Wucb9ac7TPaEnw4CCwM5O7KW6wukEgBUVKJ2HthO8yuOihOwPSXFSaBJ28EFvrrMIaZ+m1slWcKtKnAqZAZpbuAUg9TqxD320cyvAl7buWGh/baoCYYox0zURCgLNWvHw27PTEF4mzj8Viay5jXUzESrgcp0g27jpCkLqQqIN4arrNfVBQ5oazCQKrFoqdsL62cETZgSI3MY0cmy3NwqQxps23aPD6bT7T+AEyh4H+m9l2omM/UxXNpw1MbNuj1rHLaqiAmohMM/83A3ZYMKqbCUCOD+lqPrvlYxUbhWjPf0eeFq4L8QweY5ihDaKBOwAlqoDf1lMi6tnbxXETKicnp5dnJ+BfyFmpjAXqYI/W+a7QWFi8pkMOZNO1VbOAi3XO2Rl8vJVlmPIaTJi6q89jRMCtJjtFeaFqFHegrOa9BeyPGWa/7pZVvUnKtzUoXMBpZKqci3m2TqMMBVF13lATeJvQ=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f093b0-32be-43e2-56fc-08d829f41e38
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 01:52:52.7023 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QCkfrHdY667WZod+XdJd5TDQ7FtILwYDM2zZbVy7+eRowUrOs3YmANbjw9dvdOx5UJcZpU11Q1390CKMUQ7CnErOlZoeL0VBiZQoT3KuFcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5590
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200716_215259_299893_217588BD 
X-CRM114-Status: GOOD (  15.83  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/15/20 00:10, Christoph Hellwig wrote:
>> index 9cdc39c8b729..2908acc7b1e2 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -115,13 +115,14 @@ u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len)
>>   
>>   static unsigned int nvmet_max_nsid(struct nvmet_subsys *subsys)
>>   {
>> -	struct nvmet_ns *ns;
>> +	unsigned long nsid = 0;
>> +	struct nvmet_ns *cur;
>> +	unsigned long idx;
>>   
>> -	if (list_empty(&subsys->namespaces))
>> -		return 0;
>> +	xa_for_each(&subsys->namespaces, idx, cur)
>> +		nsid = cur->nsid;
>>   
>> -	ns = list_last_entry(&subsys->namespaces, struct nvmet_ns, dev_link);
>> -	return ns->nsid;
>> +	return nsid;
>>   }
> 
> If Matthew wants to add a helper to return the highest id for an xarray
> this would be the place to use it.
> 
Matthew, any suggestions on how to add a helper for above use case ?
we want to get the highest possible available index for in the XArray.

> 
>> +	ret = xa_insert(&subsys->namespaces, ns->nsid, ns, GFP_KERNEL);
>> +	if (ret)
>> +		goto out_dev_put;
> 
Christoph,
> I don't think out_dev_put is enough here as that fails to tear down
> ns->ref.
>

Yes the call to percpu_ref_exit() is missing here, also it needs to 
restore the subsys->max_nsid when xa_insert() fails (correct me if I'm
wrong), will add it to V4.




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
