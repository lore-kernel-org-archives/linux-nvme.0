Return-Path: <SRS0=3Qb0=PQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48385C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Oct 2021 01:23:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0BA9610CA
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Oct 2021 01:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E0BA9610CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QF1hfVOF7CpyyNTCPUC4wqHJkcWeYkvhfYIRrQFZ7UM=; b=0Y6Ly8hhN8GmiwNBJpte1GB2Yd
	eMwDmi0mLFQ9gwrEdL/ius4JJ8l5o0FmWl7z1U3XGBQyl1X8kkkwakoBp7V4+4gB/heMiEtVm3RcX
	z6ITDYlO9pzIfgVmXwDhBK82JbcImsYXJRSbGAKzT/m6J1sOoQ2NrCArKHwPR6sfAVVp2IWlmRYRn
	vsYuMvKypMFeSPVk4A1okoiYZhxhsVgzIl3KW6PJqLbb3lsFTYv0LhkT8lXHpvYLH89C2eW0bjBbw
	FHxpytFk3kYzzm9rKydlNhplDZ5xlfc+DZ9Iq981A/7bgUX0+ds7mOIARHQaRzZCtr5eFUdRYypeb
	aobVN+zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfu8d-006boD-KS; Thu, 28 Oct 2021 01:23:27 +0000
Received: from mail-co1nam11on2085.outbound.protection.outlook.com
 ([40.107.220.85] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfu8R-006bnq-0T
 for linux-nvme@lists.infradead.org; Thu, 28 Oct 2021 01:23:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgM0ZPeQcJDwnwQu3bPpJ6FzgXXy+pVMKxPVzXz3TDOcDV5fwqpAqVkyjHcg1Ie8C/3nj4iZxAvsgP5D/WguP+mzhnhYunmZvGn224qvs4uEOQkAKbm85ebVbpEP3QbMol7hg4gZDenywmVQadHDho44mBJUklkt7mCZL3QzI9m1sUGXETuHGVEAJ70z5uSeCEuVj8sBKKfpfUW5hiRMRyRZkc62B8J2JDLCowZvzuYUa8vHD0q/NSX+CekWzCsuLVEV8N133whNh+HOoLo48jbvm6IrMzLD2RoguYABGGrCLrBmZNc3KLxJRlP/LrbVUcKnPv0nrgtlwzfUcPthTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QF1hfVOF7CpyyNTCPUC4wqHJkcWeYkvhfYIRrQFZ7UM=;
 b=LdJURv3ZKU14fC1dlMsSz/mrskQ4Ga9X1USwYCt5GPHZ5mme0IhtivdWXZczTmSXfXijTtTCcMobIHYGITWZy18ZGP3o8Qk5xfVZK+B1LKy/7BCMCpvc+XYQRoMwq+UHOVFTJpbYa2yTkBln5SSV7BfkkIjx1LYE5GmpoYTGy572dLCDYMBuBD784oIs3lJrz6sQhMIfqefzEzoke838RGvk0KtkzWLsPgqyaBbyuUJ3R7vfM3HeF/rttBldAe+qdmFTi+urlb9VRCyr7Aq07aXQ26wc/E9DBo088w1Ybg98kzn0eBZ0L0/PFxFUgbJQyi7oQ9BtKDEdIepq9ss0bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QF1hfVOF7CpyyNTCPUC4wqHJkcWeYkvhfYIRrQFZ7UM=;
 b=G3cUbp4+Jqyfj2imtY8kc5/0FL71qWdJHPXatbVPLhw6f3iFU8ppuzNQuJe9odvYRpkEbJ6XXvh2g6qBdHBizFqsPSgzVM03kV0nrM3PUxTpxSG6U0+WBIK+bDjTVSENyeE15tQNSDm3Rcd6vLy8HvY5IH9xrUycZJdfFMYDArUvAPlnv7fRjyNzrXe2rKEvNBNgfTuHugl6wYW9B14neNM/ABrK7eJrzZz/3UzXGAXVVKJmuNDYW9EmPuXQT6CiIQnNEi4vLvnQCuJITYO1XgBRkIpYyyWDD0HP9mKacjJ9K0/cw9Pu9AT9mbupntS2Hlc1DOA18Jb+Uu6S9dO2LQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 28 Oct
 2021 01:23:12 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 01:23:11 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: liruozhu <liruozhu@huawei.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Max
 Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: consultation about NVME_SGL_FMT_INVALIDATE not set when using
 nvme-rdma t10-pi
Thread-Topic: consultation about NVME_SGL_FMT_INVALIDATE not set when using
 nvme-rdma t10-pi
Thread-Index: AQHXyxAMbkIz6qx3n0uBFGwgbjhPhqvmqm6AgAD0L4A=
Date: Thu, 28 Oct 2021 01:23:11 +0000
Message-ID: <07d5b912-a223-34ed-f35e-032723987106@nvidia.com>
References: <ff7c0b84-e0e4-e22d-1ab8-1b31a0aeaf3b@huawei.com>
 <41ba9a7a-f4f9-4ee7-3cae-21700f086dd5@nvidia.com>
In-Reply-To: <41ba9a7a-f4f9-4ee7-3cae-21700f086dd5@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7655e458-7b81-4dc2-5d2c-08d999b1820c
x-ms-traffictypediagnostic: MW3PR12MB4395:
x-microsoft-antispam-prvs: <MW3PR12MB43950EA44960BB2B31892A89A3869@MW3PR12MB4395.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xEQenbvsPgDE9LjRAY50VXCXubpJym9wymJ0+lhgyLLy1nHks3tRxIvR73QyE5k7YE5cHVZ0fevCWtcuZGN6MXLyUukycuvUvryUDacZEnmDmPUr9XqJ7yFb85QkJthSm6923rSGohId7svsK5KMrfak4boGX4Q8bneqhPcEvgLU7lReqsELbnhPq2e8gj6mIfA8oWMuRqX/fgYPAKzP8KMuHdBoKM6TR10aq4CpsxqXGoGrGfWfz5i8kHKvVRQYsRJZvaZeyV+uTkvQf+QnY4OOk0NSLrnW01du/96fG41utZBZY0kNlxfE4UmYxOThI/yCvIeu3nKSAzy6IyOl2QUtkyagnX1yIYVPF5GqE2fkp/jK4eDCecKmRrMcgyHWeVbzE7AnDNVRKzHZQWsU59nDZSeXoGae9q2llMqrTm75BWAwDzmD17j+XsS9SSm7Agu55YWk51y3RgBt/0UZ1XFnCVRipdP69qF/UmXff+zEqdr+Uu+WWQabIHQ5xwjkZSgyqPrb0353AO6hecKbM4DMrkp1AtM+EbTmEDZxQB86xHr0lkT5C7Hrl7QcN3lwAoTpF1sf0mKv+Pb+Xfbabi9wK5TbGh6DjpGge0OePBmsZEZOwsYD+Dbo8pxsRBMUhIHurlv3kWMMAL85TsnYNvAxOheNPEoDBoshYpKJN76TKykhaiyasTlia/fByOgmmqg2OqNKlnnFhDQy4GQx5v9rN55ysIAScU6nHRjJCT1TmzQiY86WBcEfcN4T0WXnHdy6IBmM8L8YDOSlUuQn+g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(186003)(5660300002)(66556008)(8676002)(508600001)(31696002)(107886003)(6512007)(6506007)(53546011)(316002)(66476007)(122000001)(38070700005)(71200400001)(83380400001)(4326008)(66946007)(6916009)(76116006)(31686004)(2906002)(54906003)(6486002)(38100700002)(64756008)(2616005)(91956017)(66446008)(8936002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bW44Mm9IUThEellFT0Z5S0hZU05EdmgrWnprREgyVER0dEdvRlBxL1V3RHoy?=
 =?utf-8?B?NFM5aGdxeDJmNmxrYWpUMmt5THZGeTZZNkQ5RWhOL0tNWVlYVU1YZjV4T1NW?=
 =?utf-8?B?NG9SU215VDBPZUo2MXc1aWxMbTZXM0crQ3Zod0FuUUZrME83SHdaZWxvcW1S?=
 =?utf-8?B?TklxU0Vwdm53My9vQ0o5U2sxdlFRWEF4a0RxcW1hQjA0NXlZZlhaNHVkYzJO?=
 =?utf-8?B?R1l3ZGZ0SkFPV2lES2Z3RzIzcTVBZ1VLVHlmYk5hbXNoMjJRNm5PcmJqd1pk?=
 =?utf-8?B?aTN2bTBwY042R3FKRXFESG5VL042S1ZPWWdvdW1TY1FQWkxYcHpkOTVBNU5p?=
 =?utf-8?B?N3k2dnFIbnpNOFZteEZndmw5ZWNUc0NXQWF2eWtmbi93UCt5RWg0ajlROENi?=
 =?utf-8?B?amFtWExLaHlmcGV2RGJCQ3gwQ3dMd0ZuUzQ5cE9WNGZ1YytEY2ZTbW93Q3kz?=
 =?utf-8?B?UFdtWXFLRmp1QVlYOE0wb1kxRlFsNFJuOTdLeUtoMGlIMlh5Q3NsZTc5RFg2?=
 =?utf-8?B?OVo0NHhkRFZ4OEpuVHhxL29XT1hVMlR0bXZVakIrT0NIS2ZmcHplUytsUW5R?=
 =?utf-8?B?RkY1SFV3MW1WYzRqcFN5WmZMeklEN1JybFJWYzJOck9GQjRPaXN4UG01QlBN?=
 =?utf-8?B?MWxoV1RRcWRISTR4QnlkcEFVZ2EyMTFpYXREMEJXd2praXZzdTJLTG9BVlov?=
 =?utf-8?B?ZmlDT2RYZ2Y4eWlMTWdIVExnbC9pQzkwellSMkMxY052SnZVelBEUW1Jalp2?=
 =?utf-8?B?QkFFS0dZYVNIc2VMdGhvQXZwR3dCTE9nOVl4TEhUTHpJVHZhckhYQWNhMW5j?=
 =?utf-8?B?amcwWnpNK1NOOFFyd0JIM2NwSzhTcVRGM25qOURyZXRzbWkzcUdCKytGUzha?=
 =?utf-8?B?Vlc5OStadlJiSzVlNlhWUVorZGxlTE9KRk9KQjNpZFpMZDRQejhyZTBIYUdN?=
 =?utf-8?B?blNTL1AzclBIVzlEWHlBQ1diYll0aGk1MkFCL0hJdkkyRk90Q2xhYThGcDZR?=
 =?utf-8?B?V24xUXRmOHhkZjQ3ZEIvN2RVa1BBblM1cFRaK1R5dVcyc1paZWVhYllBTzhJ?=
 =?utf-8?B?UDMzVC9qMmN2b3c2ckVDZDEvWDdHaEJBU3NpSndQcTFwSStzN21Gb0VCUWEr?=
 =?utf-8?B?TkFDYlovTVByR3VNcm83N1dDa3dVU09obWkrRnVqY3dxMTREdDFoSHdkamxN?=
 =?utf-8?B?RmZlblk2RHZVTUpCeWJNNEZkb2ZNOTd3SFNqK0orTTdpeHpJdzZ4aWYzQkdI?=
 =?utf-8?B?YXFqNTJLVmExRnBZcTVKN082U0U4WFRDRHZjcXhBQS9PbnFaazBGbE4vaVR0?=
 =?utf-8?B?WTFhVFVvUWxGcWpwWFRDWXNQUkVPa1o2STJXR08wTnhWVVdCTW5sdjQwWklv?=
 =?utf-8?B?RnVpeHJDR2h4OURRSUorRlZ3eGVPZEFhY3lLTFUzM1dEL29ld1ZXM0hJMjM5?=
 =?utf-8?B?WkxZTktsaWM5aUdXcXFHQStKRWZFeUUvOGFhK2c0djhjalJ5a1kxdnBGTnBV?=
 =?utf-8?B?all6eXU1R0d3ZTRKU245cmRLS3JDM2pINEVMbEZ6QjB6TDc4WENLZ0VtdjhP?=
 =?utf-8?B?YVR1T2NwNEZsSmtSbjdITXhtYzFrM2MrTGt4Vk5OMmlRY2VGNUw0V2E0UHZP?=
 =?utf-8?B?enhwYVovdi9zQlVXRWE4b3lQUXJwbHNBeS9WaWFFV0xTSDBqb0w5amRMS2pa?=
 =?utf-8?B?TnQ5S3FsUW51TlR5aHpza2FWRW5MU1lhVFFpUDhyTTAzTWVQeW0ySG5DTlhG?=
 =?utf-8?B?cVF0NjgwS0pFSVdIOGNkOTNVTWVEWEpObTkrT21ROHcwd2UwaUxHZlgzenJ0?=
 =?utf-8?B?MDJOeHdtNTdhNE1hdXhHTklIMjMwb05pU05TcHM2R3lheiszVVNMRDFrQjZE?=
 =?utf-8?B?Skt5MitRdjdFaHB2S0g1L0tMcktScUR6TTB4SEh5UTN0WkQ5TjBQRm56Skcz?=
 =?utf-8?B?NExzZTVydVl0ZEJjNmc0RVMvWlI4azZ0Rmd5RTBKczh1TzRDUStjVG1aeTJU?=
 =?utf-8?B?R1kxMXdaOHJGYjZQT2JPaWllUVY2aHdIM3dXMXlOQXVpSmNpNHhjN3RuWTFB?=
 =?utf-8?B?dnludHlwM3RhekljUWU0V3BmZG1iM3JIYmZsMnNkcnp5QW5wOXlBd0cxV1A5?=
 =?utf-8?B?L2tJaFF6akM3bTJYZTVtcTIrWUE1ejBKOWF2TzlNR3RlK0t0R25rOUpDMGR1?=
 =?utf-8?Q?XDTAUjbQKcDmCuPDRSCaslPWd1p/DLH75aqj0w64OpBL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <321F06C2202D0540993DC4EA3FC7DE8D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7655e458-7b81-4dc2-5d2c-08d999b1820c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2021 01:23:11.8595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B3loAWMXUo0ScUhqgV3RDHDlIX6hrC0rJZQa5cWrSrlojllBZr9ZeenZiJy42jZm1v55rYAHAT3jyjaqVrSw2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211027_182315_103122_821F8498 
X-CRM114-Status: GOOD (  21.26  )
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

SGkgUnVvemh1LA0KDQpPbiAxMC8yNy8yMSAzOjQ5IEFNLCBNYXggR3VydG92b3kgd3JvdGU6DQo+
IEhpIFJ1b3podSwNCj4gDQo+IFRoZSBwZXJmb3JtYW5jZSB0ZXN0cyB3ZSBkaWQgZm9yIGFsbCB0
aGUgSU8gc2l6ZXMgc2hvd2VkIGJldHRlciANCj4gcGVyZm9ybWFuY2Ugd2l0aCBsb2NhbCBpbnZh
bGlkYXRpb24gaW4gbW9zdCBvZiB0aGUgY2FzZXMgKG1haW5seSBmb3IgDQo+IGxhcmdlIElPcywg
dGhlIHJlbW90ZSBpbnZhbGlkYXRpb24gdGFzayBpcyBoYXJkZXIgZm9yIHRoZSBIVykuDQo+IA0K
PiBNYXliZSB0aGVyZSBpcyAxIG9yIDIgY2FzZXMsIHN1Y2ggYXMgc21hbGwgSU8gbGF0ZW5jeSwg
dGhhdCBpbXByb3ZlcyANCj4gd2l0aCByZW1vdGUtaW52YWxpZGF0aW9uIGJ1dCBmb3Igbm93IHdl
IGRlY2lkZWQgdG8gZGlzYWJsZSBpdC4NCj4gDQo+IEkgZ3Vlc3Mgd2UgY2FuIGFkZCBhIGNhcGFi
aWxpdHkgZm9yIHRoZSBkZXZpY2UgdGhhdCB3aWxsIGluZGljYXRlIGl0IGluIA0KPiB0aGUgZnV0
dXJlLg0KPiANCj4gV2hhdCBpcyB0aGUgZGlmZmVyZW5jZSB5b3Ugc2VlID8gYW5kIHdoYXQgaXMg
dGhlIHNjZW5hcmlvID8NCj4gDQo+IFRoYW5rcywNCj4gDQo+IC1NYXguDQo+IA0KPiBPbiAxMC8y
Ny8yMDIxIDExOjUwIEFNLCBsaXJ1b3podSB3cm90ZToNCj4+IEhpIE1heCwNCj4+DQo+PiBJIHdh
cyB0ZXN0aW5nIFQxMC1QSSBmZWF0dXJlIG9mIG52bWUtcmRtYSByZWNlbnRseSwgYW5kIGZvdW5k
IHRoYXQgDQo+PiB3aGVuIHVzaW5nIFQxMC1QSSwgbnZtZS1yZG1hIGRyaXZlciBkaWQgbm90IHNl
dCANCj4+IE5WTUVfU0dMX0ZNVF9JTlZBTElEQVRFIGZsYWcgaW4gdGhlIHNnbCB0eXBlIGZpZWxk
LCBzbyB0aGUgaG9zdCANCj4+IHNvZnR3YXJlIG5lZWRzIHRvIGRvIGludmFsaWQgcmtleSBieSBp
dHNlbGYuIEkgdHJpZWQgdG8gYWRkIHRoZSBmbGFnIA0KPj4gdG8gdGVzdCBpdC4gVHVybnMgb3V0
IFQxMC1QSSBmZWF0dXJlIGlzIHN0aWxsIHdvcmtpbmcsIGFuZCBJIGdldCANCj4+IGJldHRlciBJ
TyBsYXRlbmN5IHdpdGggaXQgZW5hYmxlLg0KDQpQbGVhc2Ugc2hhcmUgeW91ciBwYXRjaCAoaW5m
b3JtYWwgb3IgZm9ybWFsKSB3aXRoIHRoZSBwZXJmb3JtYW5jZSANCm51bWJlcnMgYW5kIHRoZSB3
b3JrbG9hZCB5b3UgaGF2ZSB1c2VkIHRoYXQgc2hvd3MgYmV0dGVyIEkvTyBsYXRlbmN5Lg0KSXQg
d2lsbCBtYWtlIGVhc2llciBmb3IgZXZlcnlvbmUgdG8gdW5kZXJzdGFuZCB0aGUgYmVuZWZpdHMu
Li4NCg0KPj4gSSByZWFkIHRoZSBvcmlnaW5hbCBwYXRjaGVzIGluIHRoZSBtYWlsaW5nIGxpc3Qs
IGFuZCBmb3VuZCB0aGF0IHBhdGNoIA0KPj4gdjEgc2V0IHRoaXMgZmxhZy4gQnV0IGl0IHdhcyBz
aWxlbnQgZHJvcHBlZCBvbiBwYXRjaCB2NSB3aXRob3V0IGFueSANCj4+IGNvbW1lbnRzLiBJcyBp
dCBmb3IgYW55IHNwZWNpYWwgY29uc2lkZXJhdGlvbnMgdG8gZGVsZXRlIGl0Pw0KPj4NCj4+IFRo
YW5rcywNCj4+IFJ1b3podQ0KPj4NCj4gDQoNCg==

