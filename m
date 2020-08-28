Return-Path: <SRS0=SY4p=CG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EB3C433E6
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 04:30:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D2AC2080C
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 04:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OJorty4+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ey18QOff";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XwbehV4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2AC2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=5Ez96Z6d1bKYB0/rOhekOxoUV0HyeYQhqtydlOwJr8o=; b=OJorty4+PSh/n+N6VBbyJV6PT
	Xja8EBsXt4pmPorXI+t6Zi+yshOj1Wm4jdG56s55/xHig3LXByGYGvS7Lw3VZFWNEJ/pzqpX6cgur
	9Bpfzbn+H7mTOg1zfbo9n6sA5Z/mMrALsC6sesQTQnliDQRp7GZgZGrVUyljITjwgOMwg+EAFYFUJ
	IL2IqT7BeOiiSVv7d17waSixEB+mtQZwEVcXQ+V4x2vVgVezkThDDH0jTbrARnOq4YXMC9sagdozN
	aZW3N6lvLTba9XJ3DndBPiuBlhWMOoOVhldiX4wqPemZH0POtRoqrzaNA/Thk/2k1bYLjx7MFy7JN
	ZMXNQxkpg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBW1g-0007aI-Am; Fri, 28 Aug 2020 04:30:08 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBW1d-0007Zn-Tz
 for linux-nvme@lists.infradead.org; Fri, 28 Aug 2020 04:30:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598589006; x=1630125006;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=m/yc9UMsbkOYRPaSetiiRKD3f/BUS1MLLy6xnx46yls=;
 b=Ey18QOffy5iy+C7Fjyni9QYkFjK8dxIUKe8kST3/yRfUimDDnmACm1Jr
 pdSDgx55LnEcxrWTVFgbBbQ9W1/paP1VduYwMg/pyIxh70jDz7+kF2Oaj
 lYSDDVRz7TPAoefbZaqqzbnbd+UWm7ZaD8+S8ofHz/pyF5MVh3tIFttmL
 fNca1xIJbdQ4X7w0LHjrWWz+8LG84PVUJIGhlfhbWUPocjXs1SixHm8il
 OqyEe7+jrFQkLf91g2aomwMyGex8eqxXT3HsO4jh3n2CjFIqv+JpaM/tW
 mmOHtGnr0MQSaMy1SxRIQHnwX0MWLo9YRyeOHl+xslRGTHIVS63HwS3Tq w==;
IronPort-SDR: RBKK0gpRaDteCw9mMrkl7m9vGesX+wYiePXZZ4K8HPP7zC6qM5e28osL8BeW++h1DTOsJUgiUy
 vaNGXNI3o++uORCIB8E+Zjmf7jXwU16CyGFfSy49otpwsxbUklBdGtMdaT0L4GbpcFVTLY8ssk
 /A2RkwV17jmTk9YMoEvDWpvcbTBHjMXlQHle8GBgFa2f34ZRfc6O2/oBR97yxSxuE6x/rAiIro
 OOInFT0m2OGVt2a/Q/uY49Def/ks5Beuri8fnyS9bcYjD5E7UJ3xGfzRHkhlyH5ibXT7s3sw33
 GU0=
X-IronPort-AV: E=Sophos;i="5.76,362,1592841600"; d="scan'208";a="150364483"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
 by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2020 12:30:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zd50zIQmSXEHbdtKeMnf4KuUyE8IJGz9twTSVohs+VR47M7IuVoXbtwAuEKPBhyc+pDoupmg+T/DWbjFRtHbm6gIeJk+eAIGwnxlQFX7hwvljGc5V9jlqHNQzVP9EEx/v2cgBy8fO0HKjYGnfbMuYvNvhTiHS9Qqd8XCqBIeQzt87PiGNZlHVxUmG5kyloHjmWgtNTzgCLq9/X5OCi+7Sethv/AUI9+ONHwsYKi/qmp4/uUeXlaXaN+/oerL17H1oF+dFXP/8XayUtE0mLnSsU5AwZ3xPjvvJmCpuZtI44wawU6eU5Dd8UiXKLyTtToXp3zdtxThg1qD3oDgk28MQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2CAPRMKSjFiZxfs9qJwJQAVf48qxETApx4Bn70M9yM=;
 b=RY+WzqgtyJ5zO8VJaUXanik70z0uRVuslamaqW6X0cw71RooQO4317NzfYcQmMgbhuAc29a5xVRdj3EecbZ9t+BFpwJqU/KJU+qELPgbXElg/+gO/RMGAgt70Y3YSC7KNAPe0SYVjAtzxYpU5UC8UlZ+8+E2HBAiJQJyG3jPKhqfFJGEQXMxMIRricyyFmcAYvpZfLxySoZiZk352Y9xdpg/aAB5+KMsDWG3bAbhyUfYOFMVJr+W/IMXQfaGuN6ruUf3TE3ITwGYxehKyve9gi+uwUXsNabNPSoyu92Pn3qFWtj/HxQPaEiwWY9m3tAUB+zLyyCYoxfubzfBlAjr3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2CAPRMKSjFiZxfs9qJwJQAVf48qxETApx4Bn70M9yM=;
 b=XwbehV4NvdcQ06m+nI5X1rmZZEGrDjYbjUh9Es3QVaD1KSQsmpKYZDZ2LcZ9D8bFp7Yz/EpBK5DoWyJBV1S6srovZ3fmTAzU3je4KY+N32LRexLMHAlO0L7+NRH0eM2YzkzUwe3TDY0IwKYdthRxElHxp5IxLmdR6LXTHz57B8E=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1175.namprd04.prod.outlook.com (2603:10b6:903:bf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Fri, 28 Aug
 2020 04:30:03 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2%12]) with mapi id 15.20.3305.032; Fri, 28 Aug
 2020 04:30:02 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] nvme: only use power of two io boundaries
Thread-Topic: [PATCHv2] nvme: only use power of two io boundaries
Thread-Index: AQHWfIew8sPeVGuOyUGnBvqGhC5QdQ==
Date: Fri, 28 Aug 2020 04:30:02 +0000
Message-ID: <CY4PR04MB3751CF0BBED62F4EF6BF36FFE7520@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200827152824.2784396-1-kbusch@kernel.org>
 <CY4PR04MB375186A80BD4AA911119C13DE7520@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200828041645.GB2784469@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1cf:fa0c:32f2:7362]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2cda5b52-72ef-4071-3d8e-08d84b0b0851
x-ms-traffictypediagnostic: CY4PR04MB1175:
x-microsoft-antispam-prvs: <CY4PR04MB1175E4A7FAE82207554DD15FE7520@CY4PR04MB1175.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gQSowZvhVl2YWTf+SAjbfQF4TLIeFMTsE3MDfzE5v44iOvwTufTZg8eLqI7loz82POX51P5RLuKKr81Xg0dZaUeKd23syTMxFiOR0Iyb/dQYDO9Jwa7OAnL3seU/SLcd1WjDRzGYKsSbUs4rdo8dM68sCvNXkY0sYRopFO1g3kpDOyniKlfchCjIXrWS/MMTz97QBCRtNJzL2aIsphJDq64WgKalBnVMGMYn67gnYkBGHeOyM0dPTgFhWnySBxHyTvxaZc8EStvVyaPrx1I9u91iS5GsfoCXhvoa3eH0pO7AhUOBgzyirXz1hI6Lh3Cp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR04MB3751.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(39860400002)(346002)(376002)(6916009)(83380400001)(2906002)(71200400001)(4326008)(5660300002)(52536014)(66556008)(8936002)(64756008)(66446008)(33656002)(7696005)(86362001)(66476007)(186003)(478600001)(9686003)(55016002)(76116006)(66946007)(8676002)(53546011)(6506007)(54906003)(316002)(91956017);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 6BO3LA8iVRby/F/4PxEonMzGvvuQIfVa36G+KAMmyPuBNYPvZEKVWyUNIZsi1OC6PXWHYmcu2ee2tefFTlqrDH38b3W7M2/5oODlugLKkDOSffNtG8e1q/9wawrCvkQuMz/98xxtyghgdKy0ux6sdizzWN80Pc7gsJbiqKQSoxyqAiwal6FEf0dr6pZKvRSvF42pirBlsd5GG/+Szy+/Zf0HHszTttIE9PnoIjv5FIOol7IP3pglHMRAYChc2qR5MauWE2dJcqqdUjD3MEYyI7hVwxe85Gt67MROD7vxn3QvXfFZe73SI2cdjbmt2CHtTYbVqGoSgIY8nRdjGh/gaR3+4dj2nx/BKzke5m1euZYnbQMGU+FGIVInz60RtgUBjPgKxjRCbLnEGLHpJ13JwUzw7TURl0FnrBgCqiKHP/nitG5lRU3ASt24oP+yJxLtEo7QUHpp4IqefzKmJS/yuD1WnCUZbMlDRufrvvVt0FSbGctJE1y57l0iLIQdaI+7E1asP6zLUrmoNbKFKKQQC1wUR+RdZznOLXwP5BrdRUO9vPCfj0NbPzAdzthcO3NK5YuvtjaydTt6bvkjDjSZLSU3oVkQLkAS6lBeNaVec0Vpznujk3UY9HSa1znYaUZAkkjq9XW7tM+y1CHWoR16OWREbqfTUChSbGKWiBvDf0byBN9udlZfP6x/xNJGmxl9DgpoxgHul7rD1UqHwu9kRw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cda5b52-72ef-4071-3d8e-08d84b0b0851
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 04:30:02.7941 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VsXa00xK/OwiUuu25GajM5OLTD+XKjCupCHYeEENcvZXAcVhiXpLrHN7etFD/kxyZblpW5Xr/TFtr9IzV64tkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1175
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200828_003006_368553_6E0C3AE9 
X-CRM114-Status: GOOD (  16.61  )
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
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2020/08/28 13:16, Keith Busch wrote:
> On Fri, Aug 28, 2020 at 01:03:30AM +0000, Damien Le Moal wrote:
>> On 2020/08/28 0:35, Keith Busch wrote:
>>> The kernel requires a power of two for boundaries because that's the
>>> only way it can efficiently split commands that cross them. A
>>> controller, however, may report a non-power of two boundary.
>>
>> I can understand that using a power of 2 limit for splitting can be more
>> efficient CPU-wise, but I do not think the kernel "requires" such a limit
>> alignment for splitting BIOs. BLK_SAFE_MAX_SECTORS is 255 after all. What I am
>> missing here ?
> 
> Ah, those two limits are a bit different. The max sectors just checks
> length, but chunk_sectors needs to consider length and offset, so
> checking if an IO crosses the boundary requires division. For CPU
> efficiency, power of 2 alignment is enforced through a BUG_ON() in
> blk_queue_chunk_sectors().

OK. Got it.

>  
>>> -	if (iob && !blk_queue_is_zoned(ns->queue))
>>> -		blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(iob));
>>> +	if (is_power_of_2(iob) && !blk_queue_is_zoned(ns->queue))
>>> +		blk_queue_chunk_sectors(ns->queue, iob);
>>> +	else if (iob && !(disk->flags & GENHD_FL_UP))
>>> +		dev_warn(ctrl->device, "namespace:%u has unused io boundary:%u\n",
>>> +			ns->head->ns_id, iob);
>>
>> Isn't this going to generate a warning all the time for a ZNS drive ?
> 
> Yes, if a ZNS drive reports NOIOB, this will warn on it's initial
> discovery.
> 
> As long as zone sizes reuse the queue's chunk_sectors, the zone size
> needs to take precedence since it's more than just a hint compared to
> NOIOB. If people complain about the warning, that may indicate we ought
> to find a way to get around overloading the chunk_sectors queue limit,
> but I suspect ZNS drives won't report an iob value.

Understood. But for ZNS, since the zone size would take precedence over iob for
chunk sectors, wouldn't it make sense to have the entire code block under a
if (!blk_queue_is_zoned(ns->queue)) ? Something like this:

	if (!blk_queue_is_zoned(ns->queue)) {
		if (is_power_of_2(iob))
			blk_queue_chunk_sectors(ns->queue, iob);
		else if (iob && !(disk->flags & GENHD_FL_UP))
			dev_warn(ctrl->device,
				"namespace:%u has unused io boundary:%u\n",
				ns->head->ns_id, iob);
	}

Thanks !

-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
