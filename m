Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B2CC3A5A7
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Dec 2022 05:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2gAEd/VcO6ztcvIw5EV5jnXNmDiP4qguANQFbew8umg=; b=hOmZjf6r6gT34wR/gDqhBDwh0M
	QvNpsIK6+Z6L7jndu4w840jZmpRPV/ecILft9CiEl9uLwRlsU1qchIIB35DUPr74GQ2bRxEEqwBSH
	ziBCEcyEfoTF4leIOJi6HZyEoFj5LkLolYv5dPp8yDrPoYfSQZKYx3CaF5JgBanqWS1DSAIlKZcv9
	dI+TMF5ddVQqprlYvJBIssGpuaDuwH3G+qCHOkNe4JJ5t0Js7/oaG1r9X03hv/vULLvf9zSkpI+zc
	KLR08l7e7gVdW6eB0r39tzjcO5OoMNNQwrg8Bi0MvuKV3cBgb/dZ2lgIATeqD0grXrwFqaqHyXPqd
	dSna+kvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p39cn-002MuG-5J; Thu, 08 Dec 2022 05:39:13 +0000
Received: from mail-dm6nam12on2060e.outbound.protection.outlook.com ([2a01:111:f400:fe59::60e] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p39ck-002Mnh-5m
	for linux-nvme@lists.infradead.org; Thu, 08 Dec 2022 05:39:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXEOkrw0y5EBV2d66u/GdUcnMqaYWyXsk7B8HpEiAh4QM8JYa7J4HmZwje3l7PXI6LLGrIclkbcNGtvurZN3Nn9OZE2Y5a9sBBWP8qvn5oI7+siBL0Uk9esNGe7X3mM6BtOrmy49cn+a6+0ucWZ1/Y/anevHNa66EII3iJM/IrqaiLJhNIkxHmig2EYBOvoUs8cNfO8mymI/Kt5Ygi3wpTAmtn55N/thnmI5XaOiWVK08u9ifYf5bCv5RvK0YkKefhwDxyEdmpTyisiq89pDkjtAzVQB6shZelQFS+21+OSeR2MjXzDQtFuvmkXoh4/n5kQK15xHrE6jn55OJXEy9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2gAEd/VcO6ztcvIw5EV5jnXNmDiP4qguANQFbew8umg=;
 b=Mx3Lvp+h7SOalCTkxd36I2AV2W3tagM0Hq3gzsYCtg2SZxGKVQMxlimJZyEKgJWGeU+e07memx47c+o7XK6D3RtLkbq2grmxREhmGrKn2mZYHuktFnhvGgLTBjrYjjJiVsdJwlSvTox5W2K5wXpOR64M68UaHlOd1rE/gsgVmIWMLBdud4VqlEkEMTN+cs1wqlc3LYEuISVX1iiP59zQEz2B8kAauU3GRT1L13c8nkCnbTejXIOuPpTzxftxYRjYIlVPe9ZFz/CFIyjkFxt0zmXqZlWOW0H7FWD8WqnZdQPdx37yP2sDFVlVNZoPUccXEYjFdLM4fkwaMD8tOcx3ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2gAEd/VcO6ztcvIw5EV5jnXNmDiP4qguANQFbew8umg=;
 b=AoCzh2eSpO/4IbwvU5X0bCRVo3vijLpiV0T3psn0sqxb9rfDiOGXHGlGqtMtPHxcEDCERICk7n50WjEXIxTEK+/3scB/Imr3sfARFEbp9jjYbl+n/Bjmz7m/EOb+VxpxZkIu5z/AnxLRhjd60R0jsaSNP+FxbFTQLfEfZmZQ5Q98aF6Io2dmS0895CIxQxKYNODtXxcGuV+VJmbfqSlCWdWhfwRkhRBRUiNnLGOp1myE8iU/8NOBjcGY8R8aW2FhXTtVtIwRo8fYpOJ3TDFzpEI9SApddJYiq0+QIUrCLYTmF08B/64RtrTZfaMaP4c2dg9CN7q0W+MQ+OJkgyMD2g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY5PR12MB6298.namprd12.prod.outlook.com (2603:10b6:930:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 05:39:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 05:39:04 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: Jonathan Derrick <jonathan.derrick@linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [RFC PATCH 5/5] nvme-vfio: Add a document for the NVMe device
Thread-Topic: [RFC PATCH 5/5] nvme-vfio: Add a document for the NVMe device
Thread-Index: AQHZCTfa4o51k6EUw0ehWDpBStWQ6a5jB+qAgAADWQCAABNRAIAAXb6A
Date: Thu, 8 Dec 2022 05:39:03 +0000
Message-ID: <f8b811a1-26b4-84cf-c5ae-4c25f8e18b38@nvidia.com>
References: <20221206055816.292304-1-lei.rao@intel.com>
 <20221206055816.292304-6-lei.rao@intel.com>
 <ef7bffa5-5d74-ada2-87e7-2f0a442f3240@linux.dev>
 <e96442cb-a296-4f90-36b5-432a2c0b660f@nvidia.com>
 <Y5Ep1FEykjuy7HFb@kbusch-mbp>
In-Reply-To: <Y5Ep1FEykjuy7HFb@kbusch-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY5PR12MB6298:EE_
x-ms-office365-filtering-correlation-id: 0deb0880-4400-467e-b026-08dad8de8448
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  nZxMVHatO5yzS2VHmn7Rxx9JRYr24FOdbWKC1rhoD/0OWM+trZ9m539l2Oom+YALRsXz5+qVW9aJqZeR4uIzIWusQWb+U3EJieMx1urkruHWSEN7lPS+Lqfx00deWDUlqlmMosDyYtuEr32KhTzE8iapYVe2LJAJe9i2lOPbv4W6k1ANz0YI915DtEDhjEwuV1q8xRXCm6W3xetcmNWcNFRQ/CyUiuZ4SfcqBLs8UCN+5VOJZvA+SQbM+bST5VRi2sSkBJZSIgNSaO7TNxID0usi0vKH35aQJDMrRCRQs9uNzVNuspVbbXJyrdTIMZfZKaoSHkfGp92HQMl0O3HMpwmyPeDYdAx/b3Pq9pmUK5O4UEIskkbRUeyyI9kZ/Rg+8Wqaf47UgUFqVsxlfA8nm5IBj+d2crDhpAKo7nLZCik4LrFJkTpycMMx2jMvkQmawTCHoheGQPWHEeJC1l2LCFSe1i9UNgSGc1zzBP2GjVkO2J6lnhqwdt6PP5oMiWIb89LFOwZ3RAXlYXMC3No3FzjRS/PhTXRk4G08wfCqtqLa8wPOe/T2wC5AAxhtARg4o90di4PC4GqI9W/KyEBmhRwm7Yl1lNLqjbvUeWLM+GdwcFpgciHt87uStmZaMk1dBIQbGKNVWxlB7KpHVvzNrbqTMllUJOb/hi8GhLLPNu15fFYZhektt4Q2m1p4e4RpgWH8O9IonrKWsT4bKBnvqx7/fHmExbHWMspE6X3ysfAYWGLnl0M0biJ9btTv7kui9ygwtLdYSn12rVtcJWbMV4CTDjy1GJP87/y6jh0xDhQdzjIfNuqUesfEEEAg9zBFAg55qR2leJRLPBrCg2lx0exZlWYjj0vTrIyFJuMb09I=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199015)(36756003)(91956017)(31696002)(8936002)(86362001)(41300700001)(38070700005)(4326008)(2906002)(5660300002)(122000001)(6486002)(54906003)(66476007)(966005)(66446008)(76116006)(316002)(38100700002)(66946007)(2616005)(8676002)(6916009)(66556008)(31686004)(71200400001)(186003)(6512007)(6506007)(53546011)(64756008)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?V1ZZSEFmdWJJWXk5WnR5WmZxUk5CVWtUOGdLdHlXZ2VkY3VaV2h3UEdiVWVl?=
 =?utf-8?B?Zmw5TG83RDc4V0czZ01EZEVENi9QTkhOVnV1MjArMGxtcFMwUTZrUmwvc2Q3?=
 =?utf-8?B?NXkzdC9lZE1SaWpjdCtGcXlkRmw0a0ZqT21KN3VudlBXUnY4RzhBZEtUT0JL?=
 =?utf-8?B?T3doVzNJOTdQZVZva0dSNEREbjc1MFVhRVozaFZublpic2pnTTdKRDRpemNl?=
 =?utf-8?B?VEs4MEVSYWhEYmZKaWpBaDV2ZitZUXBqOTVvbFRQZEsrR0F3eDZJUVdvMEJk?=
 =?utf-8?B?TGd2bno1cEprOHdHcTVaUG8wUVZMSndIOG9ReHczdkZSUDhtQ0xhd0w4Vm1k?=
 =?utf-8?B?Y2R6bEpxcFJmU2tjQkh5TlJ5ZDF3ZEptNzN1dG8vQzJCVUMxY0xaWHd6TEls?=
 =?utf-8?B?a1pXNENMRHdES3pUdVhKWVVvK3dFbXF4ay9jVjExL3pUR3g4QWlmaWlGWE1Q?=
 =?utf-8?B?cWpRK3d6MUh4WWV5ZDVuZUx6eVpHeTI2WHk4bjQ2T0MxTUxTYjdwVDRKMzl6?=
 =?utf-8?B?WGtnM3ZpaTVyZ3I3RWhrTVYrbjdyQmJnR1M2L2JnTWt1dS96SlFzd2V5L0E3?=
 =?utf-8?B?SkNlNGg3dmNnZjNKT0NMbU1vS1V2UkV6ZXNtS1ZvRnk4VmRKVWI5VWE3enJM?=
 =?utf-8?B?a2NsSVBzSTk1eXhiM3lPY2xiMkl6bkFkSTJGRDdMak55U25XMW43MnN3bGkw?=
 =?utf-8?B?WlAyQVBORGRGNXEwc1BUSVFCc1JicjU0T0JIN2tkZnZNRmx3WExnNnVxRE5X?=
 =?utf-8?B?UC9FZ2JOYmd1TzllbWxtVUVkaUQ2Y01vUldRcVlITEhVQWRZZnl5N0pyVmR3?=
 =?utf-8?B?OGdjazlaTHlPNXJxSU44cDJHaXkybGM4Wm1ZaTdMTTFtc2NNbEVDSXczN0Rm?=
 =?utf-8?B?NitoYVFlWXVmUFhDMERSQkVYUjU3VmdyeGQ2QXlOQkVNNXZUS2lEVi9keGk0?=
 =?utf-8?B?K2hSRHVXelVlN1I3UkpuRjFJZ283aDRHeXVnNnpNbE9Ja0w3TzgvMTVJNEht?=
 =?utf-8?B?VEtLMG0zc0UrbkNVUGF5a2ppTXNpNFhSNkxFT1p0QTQwbGlNUU01UjExWjRE?=
 =?utf-8?B?bER6SDRvemNWaXg5T0FlMGVMbENMTlVLenBqd3VvQThweGN6Mm5KV3B3dEtN?=
 =?utf-8?B?eks4djlGNTU4REZWZ3J0dTI5WUE0S2xqcURmdk1aenEyOFFGUU1mL2pXMy8w?=
 =?utf-8?B?WVAvdWdZaWwyaVZwQmV6Q2p6Yi9CVWxUNkQvbHhkYTIzZE55UEo2Z2h1dVZo?=
 =?utf-8?B?V2lHZE5zUzRYZVVheG1QaWJrZDNLU1NTWFY1cXNDTlNNc2NtK2VyRlcvbm1z?=
 =?utf-8?B?SW1sYUVjc016b2pNU3RJdkE2VEZKbEE1VVUvaG9vOGJYYThnYjQrOGF0cFgv?=
 =?utf-8?B?MXFWa2pWV2NuVFNhbUc1ZElaTVo1N1YrZHc0NlhHbFpUa2QrTUxYc2s2VzZY?=
 =?utf-8?B?WmVIemdVK3dXbXQ0NlZFUmtWallhd3JhR2NLamNiMHVlQmpBVGtxSkFEWUpt?=
 =?utf-8?B?eWlQQmNBNDg4NlFCTldpVGJIdHh4M2RrMEgzUFB3c2RMbWVPTm5OTWNUeXBW?=
 =?utf-8?B?M2pQaGFXcHZwajlqemtVcjNRRXArLzdiQVB2RENvK1M0dmNVRDFtTDNZZHY2?=
 =?utf-8?B?ZUxlWkprd3lmMGVpc0kyNkFOYkhtUUQ2L3lvTzNrVXVhUnJ5NHUvNlM5Sjkx?=
 =?utf-8?B?WER3ZFppT2hubk84dUN2UitlVG9MZFk4Qjl5ZjhPY0pVaEM0TWVYbUNoNFVQ?=
 =?utf-8?B?dGpGM2wvV3dLdy9iQnpBQTZ3dDlwelJrdWVFQ21kTGhESFFSUVdaNXl3SkZX?=
 =?utf-8?B?Mmdqc2dWMndsRmtNZ20wSHNnOWVlcXJwTHJodmZqMExBdnNZZ2Y2RC9oSjJM?=
 =?utf-8?B?eGlRN3IyZEF3eHdFWXBURm9OOG56cDlvWHhLdjZZSnRyeFlWcVcwOHZTSlNF?=
 =?utf-8?B?NEg2MmppOGFqdFIvcEFKb1NmbGtpaFRYVW0wMHFaWU81SG1BamlUY3p6TnQx?=
 =?utf-8?B?amhCZFIwYlFyTkJrSy9jdmIyWWJQRnJYOUdpRDRCUkNQUTRTSkNxV0hnVWVH?=
 =?utf-8?B?eSsybmthU0cweE1TYzZ2RDRWNTlEZzBOZ3lWMmFzaURpZGh6czBDZVBuaFMz?=
 =?utf-8?B?dTZCL25wVGNIa2ZlOE84UlRVRkhPaTNwWlcwVVZTSVcxREJBL0FkekdzUEZh?=
 =?utf-8?B?Zmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D21EFD6D5A7D6D48A0B8783CD47539EA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0deb0880-4400-467e-b026-08dad8de8448
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 05:39:03.9885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zEky0aSYVtG/lBHZzd6r59wOaULRXd/PcNcV8cpZzYObyzcIas2TUYFJEMmN2DCYJKPi6/1Gmxt2yyWVnastxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6298
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_213910_468022_1E91075D 
X-CRM114-Status: GOOD (  16.32  )
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

S2VpdGgsDQoNCk9uIDEyLzcvMjIgMTY6MDMsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBPbiBXZWQs
IERlYyAwNywgMjAyMiBhdCAxMDo1NDoyNVBNICswMDAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3Jv
dGU6DQo+PiBUaGlzIGlzIG9ubHkgcmVmZXJlbmNlIGltcGxlbWVudGF0aW9uLiBUaGUgcHJvY2Vz
cyBvZiB0aGUNCj4+IHN0YW5kYXJkaXphdGlvbiBvZiB0aGUgTlZNZSBMaXZlIE1pZ3JhdGlvbiBp
cyB3aWxsIHRha2Ugb2YgdGhlc2UNCj4+IG9wY29kZXMgYW5kIGFueXRoaW5nIFZlbmRvciBzcGVj
aWZpYyBwcmVzZW50IGluIHRoaXMgc2VyaWVzLg0KPj4NCj4+IEl0IGlzIHZlcnkgaW1wb3J0YW50
IHRvIGdldCBzb21lIGZlZWRiYWNrIG9uIHRoaXMgdG8gaGVscCB0aGUNCj4+IHN0YW5kYXJkaXph
dGlvbiBpbiBhbnkgd2F5Lg0KPiANCj4gV2UgaGF2ZSB0aGUgTlZNZSBUV0csIGFuZCBsaXZlLW1p
Z3JhdGlvbiBpcyBhbHJlYWR5IGFjdGl2ZSB3aXRoIFRQQVI0MTk1LiBXaHkNCj4gaXMgYW55b25l
IHRoaW5raW5nIGEgTGludXggbWFpbGluZyBsaXN0IGlzIHRoZSBhcHByb3ByaWF0ZSBmb3J1bSB0
byBkaXNjdXNzDQo+IHN0YW5kYXJkaXppbmcgYW4gT1MgYWdub3NpdGljIGZlYXR1cmUgYXQgdGhp
cyBwb2ludD8gWW91ciB2ZmlvIEFQSXMgYW5kIHZlbmRvcg0KPiBzcGVjaWZpYyBoaWphY2tzIGFy
ZSBwcmVtYXR1cmUgaW1wbGVtZW50YXRpb24gZGV0YWlscyBhdCB0aGlzIHBvaW50Lg0KDQpobW1t
IGJ1dCBpdCBkb2VzIGhhdmUgYW5vdGhlciBzdWJzeXN0ZW0gdGhhbiBOVk1lOiBWRklPIGFuZCB3
ZSBkb24ndA0Ka25vdyBob3cgaXQgd2lsbCBhZmZlY3QgVFAgb3Igbm90LiBUaGVyZSBpcyBubyBp
bnRlbnRpb24gdG8NCnVwc3RyZWFtIHZlbmRvciBzcGVjaWZpYyBpbXBsZW1lbnRhdGlvbiBhcyBz
dGF0ZWQgZXhwbGljaXRseSBpbg0KdGhlIGNvdmVyLWxldHRlci4NCg0KQ2FuIHlvdSBwbGVhc2Ug
bGV0IHVzIGtub3cgd2hhdCBpcyB0aGUgcmlnaHQgd2F5IGluIHRoaXMgY2FzZSB0bw0KZ2V0IGEg
ZmVlZGJhY2sgZnJvbSBib3RoIHN1YnN5c3RlbXMgTlZNZSBhbmQgVkZJTyA/DQoNCkkgdGhpbmsg
c2ltaWxhciBhdHRlbXB0IGlzIGJlZW4gZG9uZSBhcyBSRkMgWzFdLiBBcmVuJ3QgUkZDcw0Kc3Vw
cG9zZWQgdG8gYmUgcG9zdGVkIHRvIGdldCBtb3JlIGNsYXJpZmljYXRpb24gZWl0aGVyIHdheSA/
DQphbmQgaWYgaXQgaXMgc29vIHByZW1hdHVyZSBpbiBhIHdheSB0aGF0IGlzIG5vdCBldmVuIHdv
cnRoDQpnZW5lcmF0aW5nIHByb2R1Y3RpdmUgZGlzY3Vzc2lvbiB0aGVuIHdlIGNhbiBzaW1wbHkg
bGV0DQphdXRob3JzIGtub3cuDQoNCi1jaw0KDQpbMV0gDQpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvMjAyMjEyMDcwMTA3MDUuMzUxMjgtMS1icmV0dC5jcmVlbGV5QGFtZC5jb20vDQo=

