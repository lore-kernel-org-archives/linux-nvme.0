Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CD2C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 02:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CjgNCjRJ3MoeEllFv++aAG00zz03oBhx88sizTFXoTM=; b=bocF5GVpG5ObGeKATQs9Dhwhpn
	Ri9K1UgQTUA9/atLwnWwgV/cplTHj9+w4m02KfVbTSIoG9feKDUEq3S1AO0da6lplYS35YKr17fEP
	78B2cM/lIBdg+2eEC07tyPURbpXeefhv79tiwv+jykEnNdEzr1tOXzd3QvgPfF0eJ8CZJkfDjzn1I
	sRD8aeawkceCIO3AkzNrnkJAQm2fK2Qp7/Go4Q2Up0fPWRxWmzWeSTrYwZVleAAF8VjuvBbN8JQOe
	Lmis5hZGcf9El41EmebfEtAAke+HJAsoIaXQIgoMn2eJT3cSc9d5WPMaDDnHgaU+JNSqv0Mnxb2VH
	xXlqnLvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8uTN-005JpR-S2; Wed, 06 Jul 2022 02:09:01 +0000
Received: from mail-mw2nam10on2087.outbound.protection.outlook.com ([40.107.94.87] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8uTL-005JoV-2Y
	for linux-nvme@lists.infradead.org; Wed, 06 Jul 2022 02:09:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAID7ABkUatkZZSNSs/OTgs3LTEnSj6Bs8hHriGsIjtbh48hfFcoTEbGDluG/garr0gtWY8ooUsirqIM6YaCfMenY0QzjoloKxHvqIkqzrL4vbVds2z437wHDtgq/ROW9QaclkZRHZgoq7NTaYjIPZOeuN18kZDx9rTqFRVR4yNYhKk1nYQ3RDX9XsY9o0XdTIIeGSQCIMKQ/pkCiJaiBkxhcWDRbC4NB0/kHmhNhfYPzG1Mgj+8hEmZ4VAxP07T2uI90Cn1KXQIPFT1Ii3dgr8Y6D7HlpAhBMgQimkVp9PiaORJ5oGogOIrmragsbxQ/liG5fxyTcgnnXTQmIt5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjgNCjRJ3MoeEllFv++aAG00zz03oBhx88sizTFXoTM=;
 b=myOfvYkwQtoCFHlDwufxCM4Rnwo5ZB9pWxuy+SCZ+Db2O7xFfuzOMPKPsyAg29P5dkR+BuxsJ33+XYwA0Wfnygc1t86JPzs3DOPXRGNc9xQlxI0Ocn6ywMiw9LwZxHMAAQukqsZfvT3gMDrEosGkvUjp8q+Hn8WVHNsvow2YCksWLIHCJfl65nQswxNP6EuTO2oO5VdWkdTMBRRCll08Dt+6oF5pm70fmmKxJcRAKzTpacmbb8gj7T3xWB/RX+6cR3k+alOvNdZBC1HSTZjV4888nWIBs0jlIWrOpTsvG7hM0pukuZ71cRu4Ev+18qrf1N/+///uREFodM6MURm1HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjgNCjRJ3MoeEllFv++aAG00zz03oBhx88sizTFXoTM=;
 b=ufF1p6LA5fEO6LtlTeAVq8Eql5BRickGA+oJqnXE6VJxlIMsEUVDnmu7bop8rLILfMnDMiDiUVG7wMyYhFbb/xcbVoxn9ek2Tp4Cmf/V3GiazxgYVl318DSkpT6joLIH9ryQi9zqqQLUfrpMp+60eTeN9iSMD/tp2+9YzMIcILN+YNhmx81GxbkuGfHX6d5vVOnF16uEJWh+R/jemZdbsAtHxCHHQiWuykvjTXyOWObmbtxpMAnE5lfVLd3D3TmiliaKYpuV0L14Qf75FaXw8Yx4LlUzhMDhVlYp8mW2ygFIfZ05byRuCvAGLiXjNnpMkf3M7v8Ioy5TFhneefnpfA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Wed, 6 Jul
 2022 02:08:54 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214%7]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 02:08:54 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@fb.com>
CC: Keith Busch <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chris
 Egolf <cegolf@ugholf.net>
Subject: Re: [PATCH] nvme-pci: phison e16 has bogus namespace ids
Thread-Topic: [PATCH] nvme-pci: phison e16 has bogus namespace ids
Thread-Index: AQHYkJPsDeENNaFnxU6z5lW3js+pSK1wmYaA
Date: Wed, 6 Jul 2022 02:08:54 +0000
Message-ID: <07a1e48d-b8de-f0b2-ae8d-f09fecdeb004@nvidia.com>
References: <20220705172102.3522189-1-kbusch@fb.com>
In-Reply-To: <20220705172102.3522189-1-kbusch@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d0f8682-b4ab-40d9-7304-08da5ef47a38
x-ms-traffictypediagnostic: DM4PR12MB6087:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 	=?utf-8?B?Vlg3TVdnNnFHZjYwNkxMYWhFbU5Lc2Yzbnl4TFhKYWFyMXdmU0VMZHp2ajR6?=
 =?utf-8?B?RlozYldBSnBVZm9jbGc2dlloWWxCdXNPcFRqbmVJSkxXclZyUTZ1TTlzTVFh?=
 =?utf-8?B?V3BiRlBma3NLcVA2MzRuODhWUzJjT2VUY01jQVlUcXJvQXhVTjBUbTBocTBy?=
 =?utf-8?B?a3MwSmd3MUlyd1hZNGhjUG5LbDlqK2dDK080YXdzREtabTRsaEdzNWoyVGEv?=
 =?utf-8?B?NEhUWk9hZ1RvK1phZmx5WURKY2xwQ3BMNkgxemdCdzBvZ0xHTDZqSFR5b2o4?=
 =?utf-8?B?VHFEN2VZeFRnRWROKzMvUzZBMEZ1ZjhuN1RyMnBWeSthQk1zUGcvNi9qeitT?=
 =?utf-8?B?T05kZk1VMk55RjVMcllVbDdWSVlaWVBqYTdPTUxKMkZYazRDL2t4cGlKR0dZ?=
 =?utf-8?B?Yk1rZE1FV2JaRmsvRDlBK3RtblgwWEgyUXUxaGtDd0hkdUE5N04xYnJaMEJ2?=
 =?utf-8?B?eGpsNzhxTmx3OWtTaks4Sy9lQ0FyS1lXRlZrRkhhWlg1R0FrKzVLQUk0aUZN?=
 =?utf-8?B?TjhtMVRsUEFMUVpHdS91SnczUElWbm9aZnZYRnBzOFNSNnpvSGVSVElIVGI3?=
 =?utf-8?B?T1pzcS9qTU1GczBEU3d1UHd2Y1Zlb3c1M3lJMVhmbjk5VjBEODJPYTFiZGl0?=
 =?utf-8?B?aldJTllTbmlGVzY0T1pod1drUDE3dVdpeUtXNzhMK1hkTzFPemVpekhJVHRo?=
 =?utf-8?B?VzgvNEp2Zm1xOFNzanBXdUxxNTJXYkMwRy9CcWtQTk9Zd1JZZDJOQXVtL3Nw?=
 =?utf-8?B?QVBHckZQSjZqTllLZW1HTEhiN3dndmZzU1loU1FXMCtrZUZmdWx5eFE1YmpW?=
 =?utf-8?B?WmNwZzF2RjV4MkJrdFNkYWl0MzJ6SU9sT0w1SmJzWCtQZzR0aFAyK3lzVTlR?=
 =?utf-8?B?YVM1N3FTYTJTL0szbStDRlVvSk4wbGFQL2VPb1IvMnFadHBrcE9EZnBXR2lj?=
 =?utf-8?B?emhjWThhRXJBRHRIU1ViandsRVRVVlp5b3p3Y1hTbGFkbHlmdWlHSDM2aHE2?=
 =?utf-8?B?Y1dPNitBS2NQd0FRUkcyK3NpaDVmUFZBRXpqM1p6aCtvckxkK25memFORWJZ?=
 =?utf-8?B?ZmpBRXg5aGVWeVY3djlZcHVzekpCaU9YQWxWMjhEdVpXWDRPS2VlMUtHMHQv?=
 =?utf-8?B?T3BZTEZYR25XOC9aWVY5Uld3Y2JjUDdBdmNnY2lrUGY3N1RXaVJHQjZVdnV4?=
 =?utf-8?B?RmRObzFWWVN6aHB4eGxCVW9SMGcxamNCVGV4N05DUWwyWFg3VUUrQWZsZzJs?=
 =?utf-8?B?RUg4QXhneGFrQ1ZwSnZHeFlWZ2JaeGRwRGwwaTJTVER0NmNadz09?=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(6916009)(31696002)(38100700002)(86362001)(66476007)(31686004)(91956017)(316002)(76116006)(8936002)(966005)(36756003)(54906003)(64756008)(66446008)(8676002)(6486002)(4326008)(66946007)(4744005)(53546011)(41300700001)(122000001)(186003)(38070700005)(2906002)(2616005)(66556008)(478600001)(6512007)(5660300002)(71200400001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?ZjZEWGtJV3BuQUdQenJqQm5Kb05Ja0l0WVU5SnhzeHpwSlRtNFh1ajd6ZEM3?=
 =?utf-8?B?SndhSGF1WUpZTURaU0xuUkF4Z1cxR2p1dHBmT2ZaUlRkNnZpZnlsZnlibVJH?=
 =?utf-8?B?QUdnQXNhbTd0RXBNYWVGVGNpVzZVRWNmSzdpSFNMVmFjdjZCRFlGanlhMDVh?=
 =?utf-8?B?UkhSWGNDVmtRZ2RVSk4vWmNlMy9jem1HLzNpdlBxRXhuYXBCNGl6aDdvc0w4?=
 =?utf-8?B?TWJqS2dGRGdLWXI0UXU4QkZMWTNCZm1mcUVVYTJVaGEvRkxKRVB5SWFRa0h4?=
 =?utf-8?B?eEIxRWJHa1dickpnVVl3TjdMcmJyTzd5cU9zbkxMMGNVdko0VmNKZUdSMzF2?=
 =?utf-8?B?bXpaVmNSMzdtYVZrS01QT0dBZ2syVk5SWkpCNTI2TWRPS1FxNXR2ZGFsM2dv?=
 =?utf-8?B?emRvNkJFMytaZ1R0YXBhdU9ZR2R4N2NGbm45TU5sWmk1VEd2YnJjQkhEZjNw?=
 =?utf-8?B?S1Q3cVdtNVZHdUw0MTdGd1VzL3o3TTdxa2E5eHlTN1U4d0o4aEVFSkozMWhV?=
 =?utf-8?B?MG4vNGlYaFFPM2ZNMTdHVmV1N2pFTEZyTExmZVJHVys5WGMvVzZtR2NPTWhw?=
 =?utf-8?B?a201b1ZYOHJDV1B1aEdpYTVhbnhTVm9YMzB4Z1N0NkhZUEh1bHRwUkE2dkgr?=
 =?utf-8?B?Q2VPaTFOWWU4N0lLeGpJbVlkMUNJMFpQNGpPT3RDdy9DM29nbE1rNDFqSVUw?=
 =?utf-8?B?ZHdyZ2tWNk9zcGVXTEw1d1Q3K1FCcnp6RnhMK293a1ZOTWo4bDNwM1h1c1pz?=
 =?utf-8?B?MTlLOVZyRVl5ZlZDd0dKbVlZV285bytRUmJSS1J5TUFPcEQxTnlhdXJjalU4?=
 =?utf-8?B?MS9BVk1nS3FhMDRBZGIxM0ZuY0IyVVp6L1RvdzY3WFBXZTI2enMzZUJZMkll?=
 =?utf-8?B?UVVYUTRrMjRkS01XK21QZlNTemxycHlRbGxxaUlaWGUwbkx3NUJaNWx4eVRR?=
 =?utf-8?B?VGtVQ2RtOGxpMThEOHdkRURtNTdSRGFKdUp2MEI2N0xIbkpLeTRya2JDaUdI?=
 =?utf-8?B?R0ZBT2xRa051b21LVUhOb1FPWVRpa0pibENpQzZSUEpqQlNRMCtqWFNacXBu?=
 =?utf-8?B?bmtLc1V2ZHp2V3lkaWhZRnVRS29NN2x3V21IMm1YWDR4dDRJOUY5Ty9PNi92?=
 =?utf-8?B?NklieTVzVDdZdEVxSzhsbHBRMkdsWVpobnJNTkhycnNOZ0MzUU4wUjM0bHM4?=
 =?utf-8?B?aXJtbXI3VHR2Szd2azdSSXR3bUJXb0ZYRDNoWEdhREFUM1dGMjFIOFZBSlJP?=
 =?utf-8?B?eHFQNjVYeitLbDFYdWhIa1ZRcC9IalFoMUozV2VMbUNVOXZaN1Y2NzJ4dktW?=
 =?utf-8?B?ZlN1SXNnL1JHNmdUeVZ4bmRLTVJpaXlSOUlvTXBkWE96VGN4aE8zbzFQbis0?=
 =?utf-8?B?b0V4dnhHaUF3bHlTdjkrQXdNOFBwMVFwUndOU0czUEVDcVBhZ09Kdk5XeHFN?=
 =?utf-8?B?Qk4vbHNkcWR0cTRBZDdFRWlmMlphMERrTkVRaUovSjl5NzFlQTVlUmZvYVc5?=
 =?utf-8?B?Y0t6SEk4c1lsR1JjLzQweEl0VkJTUUV3NEhmZlU1S1FsZFdPRlRISFdBWHdD?=
 =?utf-8?B?MlJYMXU5cHdjaDlCTWpGRFBOeDArbXVMeS9YYmRBVEVOTnhVT3g2Q2MvVVY0?=
 =?utf-8?B?Qnp3UzRjSS9tUHNFdUxDOVoyQmg3L2lnbEhZQ3NYcnhYTGgvRVhCZ3lPTSti?=
 =?utf-8?B?eHR6U0FqUGNLdGlVbnFuMmRsM0ZWZjVwZzdObE8wSFJ0MzVONitpWG1Xc1pF?=
 =?utf-8?B?ektLd0wyaG5FUkVyMkNzM3psSThQM2hLNG9EZmJuT05GR3dzblQrNzg2TkxZ?=
 =?utf-8?B?VG8xcS9uanlkUnduRXgyZzYrbjVTUnY4ekZzaXVPSDl1cW9zcnQ4Qkd0L2NU?=
 =?utf-8?B?TVZYWTN4Y3ZOU3FPOXliQXRMNVJkUzFGNkJnVGNhNXpmaDgwQTJZMk1GSTdi?=
 =?utf-8?B?am1aTVpCUmsrV211TzluRzk3anhtbFBJblZRQlRXdmtlRm9SRWtJQ0VIc29l?=
 =?utf-8?B?Q0Q2bC9KSnk5elRyTUdsSkVmYVJpblFqQWh3RzJoejN2bnJGYmV2WkhINnA2?=
 =?utf-8?B?dmYzYnI1cUdIWTdTdkhqdVZSR1ZaMEZNKzh2ZEhROXFKaVZFSk0yTTU5bS95?=
 =?utf-8?B?aXBGclFMc2lEa2oxVEJSK0NuNkRsbEUxV1lRRXdub2k0bDRLVC9HRVllRHlu?=
 =?utf-8?Q?6ulQ5ZVw1zgyfOya2nUxGH6a1F3rn63WDKIw8Bss2LaZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEFB1AD6B3BCF34294C8F3B563C671D3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0f8682-b4ab-40d9-7304-08da5ef47a38
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 02:08:54.1272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YK5MJmpQJAaKok0dKwNb8eLLrgsxsWSBKC92J75u8baBkSACM/sTrXw3ff/2HJuUQHPFgKgtU9OUAuoD3JHQIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6087
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220705_190859_158678_56D750C4 
X-CRM114-Status: UNSURE (   8.22  )
X-CRM114-Notice: Please train this message.
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

T24gNy81LzIyIDEwOjIxLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4gRnJvbTogS2VpdGggQnVzY2gg
PGtidXNjaEBrZXJuZWwub3JnPg0KPiANCj4gQWRkIHRoZSBxdWlyay4NCj4gDQo+IExpbms6IGh0
dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE2MDQ5DQo+IFJlcG9y
dGVkLWJ5OiBDaHJpcyBFZ29sZiA8Y2Vnb2xmQHVnaG9sZi5uZXQ+DQo+IFNpZ25lZC1vZmYtYnk6
IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gLS0tDQoNCkxpc3Qgb2YgY29udHJv
bGxlcnMgZm9yIHF1aXJrcyBpcyByZWFsbHkgZ2V0dGluZyBsb25nIGp1c3QNCmFuIG9ic2VydmF0
aW9uLCBsb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hA
bnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

