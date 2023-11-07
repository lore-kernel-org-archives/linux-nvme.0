Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CD1C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 21:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dj9ixUj6ObVOmVaHe6I0bhrRbYRuXujHcT8xESb74WY=; b=oWTYlHIJw0R7hOVj/xD084wpF0
	LocStEe+nWipFU8uf8nwAmQYUhKoqChRPKmmlI57SCoBrvgl+uf4tYaTzjGGc+qBzwFRh/DpJMKlC
	+52d2jZq5MSG56B5z8IUA+ATyK6uQvh5pbY7rGXCeMH0QSme/PZ+gQNp6ThC0kHj2fgBQ4W6qWWyT
	3u5JmHc47vi21eVcPOitich/Fq8Dn1s++GjrYrbTR3trhQEOcnXxp6NQv2mzBSCRj8YJe4AQPQcTc
	wPOS6LVZKD2rFoxb/n54yecGkiYhCpkywlra2kror3XE9M3g99xKLVpzqeMahmch+RaEphkUdWaWx
	SVVsynng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0TqA-002SH9-0t;
	Tue, 07 Nov 2023 21:42:30 +0000
Received: from mail-dm3nam02on20615.outbound.protection.outlook.com ([2a01:111:f400:7e83::615] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0Tq7-002SFK-2F
	for linux-nvme@lists.infradead.org;
	Tue, 07 Nov 2023 21:42:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlFViM83iqlLd9X1RMiTOPwrAy83syRj23lYqefsHM4hm78kBlQeLX4xg+WcWb1Y+Y3+tWb1cokIMF6NF/hVTwxkvuZ2KbB2arPItdqDhAlisqnCGvvdb4YVK1w96jo5chmBnvlI/uXq3eEUiDpwZqwFSPRJnc8cvsZyQ4Fl9B5NS/eX5b41IeOQMdT87KZb2dXgIZuDewjE6ydAOfLa41kxmxqqe2A+dYOunNVND9FIAtOPP3qpNh+NiYsCJjNaBybVATvIai8XIRPu69PB1lBsNxDWk+H5ZKYACSFJ4nchHQcNaIvP3i6wD86vlMTibNr7dseINc8RCplDuAnk3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dj9ixUj6ObVOmVaHe6I0bhrRbYRuXujHcT8xESb74WY=;
 b=oFJQ1Zd+wMRzHuzXCIu7gVu5IM8fN1kAdA+qIWRy3NAj0oa2+eJ5M8oorsIUNfOD/tEJurZr9cCGBEDW5lKxP79BGoAhRLMgwkyJbc2qBCtXYLmxCVDLxjai5eC/4fp1tXWCVWgfS4bobC1jn8rQB3eN2nQqnqRGfa9F876i8fqFnOgXQyvKQVQ7aYbtQyKd5LjaBdOEuuGjX2w7/E56zV+kReb3t0tSOBY3b3S2DFMvk3em6JPZhO9AQynESUGKIgw7DgGoMhTsjs0vDw6teCejSQIdCM1tql01fNs/uJK34SMBWeFh/RXKt9oGZWRGWmC6cHbWU2Ok4uVRoCxmMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dj9ixUj6ObVOmVaHe6I0bhrRbYRuXujHcT8xESb74WY=;
 b=fTRtOEM27LraUgqHyFVLx0jn4a9Oh7xRrIyRtH2t1gs6LF01kASxZJ0bs17OrVv5oDoTyH+Kg1ubBZN70qp0Q07NSGxr1oZ4RWP1Y9YZxst46Rdqamlr+h6fgmUDECCnR4eNfZhEJSqlcD8eBlPeRfJW/V9b47hYTDk04OyLw+O8WMC+BpOpVv/yfrARvytP4Y69qV7SLGHKL5iDPF0ZqbA6+O54mTp0PpnaVDiZMtZd3Uc/Nohh1ZNIDzMuypGjdEVFRMRiGUeIfz2rir2LatGJ733gwnmkamyYFKDY2YkGmWw/OAhw6vzfY1QrEr+4z+vgXxkYwsgDrPxPGbWOOw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW6PR12MB8868.namprd12.prod.outlook.com (2603:10b6:303:242::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 21:42:23 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ccfe:928d:3fbc:8781]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ccfe:928d:3fbc:8781%4]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 21:42:22 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "Ewan D. Milne" <emilne@redhat.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "tsong@purestorage.com" <tsong@purestorage.com>
Subject: Re: [PATCH 2/3] nvme: multipath: only update ctrl->nr_active when
 using queue-depth iopolicy
Thread-Topic: [PATCH 2/3] nvme: multipath: only update ctrl->nr_active when
 using queue-depth iopolicy
Thread-Index: AQHaEcEAynCMbGBFFku5vjOw7b4QobBvYxIA
Date: Tue, 7 Nov 2023 21:42:22 +0000
Message-ID: <89dba91d-5ee1-47aa-8125-dc36285add4f@nvidia.com>
References: <20231107212331.9413-1-emilne@redhat.com>
 <20231107212331.9413-2-emilne@redhat.com>
In-Reply-To: <20231107212331.9413-2-emilne@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW6PR12MB8868:EE_
x-ms-office365-filtering-correlation-id: 2c686619-aed2-4729-07f2-08dbdfda6d11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TZupJ3EXQlWNf8ddc4HDb9I/bJS7baQIQjdQ9zmQhX7toDK6VZ5W2pBKiKL1ntmHvAisvfHl38QwCh6OiMHBeXLJMWDRI43PH59sWpoqYcjjpr8mwjBdMbwtb2CrUKmV20OnwwTaf/4IIJSfl2fWBg+ba7wcaRDUWgIiq4KqKx6qHTiMtjCljhTlkEw9vT23oCLPZS8a7p1KNcp42ia//VtUp477hiUSWWv3SRyBjrJheWCs8vJUP1FHIoqCRCVyGZoHiwT6jE5IsRC00l/oF3lZRfScaKKSniZnV9nOBlNytqOHPKAiuIja3qT554HL4YpZgX+snZxstdBLJtxW+JjcJWfrrfhxe/R+DGXeMm6cj4/8LDcH22R1ki9nqDONSZfttE4CHtLHLlKKWvzJ9xATYSoAf28jiWGffZmrBQ/6Mn6j9uI9JpezmOaPYZB6dLY5iWvke+ncWF1kq0CykK6+eUwnnW5z7RQklRHxIaRbspR+MV1reyLNCzUDOL32N+yVmx0SIEli5G0DUw0ceVHPzsgOg1gMGi2+V/ghvZQSZmAqhXVDPBGl24ftw8qpofE3jx9jBflfWP0HcEMPXelU63Q5ITdQFSEnf7wA22PhsqGxZr5aqy0C166TeG7p1+AW2temeGFsUrsoMymijEf/JTGECT4B5IwSsr64duCrN4pqAzqXBMGCRvSXYH9j
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(71200400001)(6506007)(83380400001)(38100700002)(31686004)(2616005)(122000001)(6512007)(41300700001)(86362001)(4744005)(2906002)(8936002)(8676002)(4326008)(31696002)(5660300002)(36756003)(64756008)(66946007)(66446008)(66556008)(66476007)(91956017)(76116006)(316002)(110136005)(26005)(6486002)(478600001)(38070700009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y29lK0RYY29KRUMwang2UGhpWWxkUWtLc2R5MEU2NnZzNkloN0hwbTViV0kx?=
 =?utf-8?B?czNucHlITDVsSnQyV3c2Z1FYYUxNYlVJUDRpZkxNQkhSSlVKMjR5QjlKUHRl?=
 =?utf-8?B?WHVLVkM1T3dub29mRFJDbnpUekR5T3kzQ3hrYkdHOU0vZmhla25JNVF0dWg5?=
 =?utf-8?B?eEZmUnBQMkhYL1R5aVh5Vmd5MkFuMmNmVDhncXlSRFNyWkFGS0JneGpSK24z?=
 =?utf-8?B?and0c1hCcDQzSlhpU2xnSjN2MUM5TnZ5RVRHYmtLR0dvNHNPNDBqZVhLU2xZ?=
 =?utf-8?B?RlgyTklJS2VXL2wvWFF2R3dCclE0M1cyUFp0Y2J6Y2RkYlJTV2ZYM2ZNVWYy?=
 =?utf-8?B?ejRZT0RJdDZ5K3o5ajJwMW5yV1BNMEtSMUszODBHbFY5dTZFMUpxOG5qYXNP?=
 =?utf-8?B?SW92ak9LRTZ5TmlmNnZqTndFSE40VW9xcDM3Y2EyeGVlY2YrdzN1VnQwYmZ4?=
 =?utf-8?B?ZHd6SitvTFZaQkJDNFdiR3VTSTduZDVtNzNJYm5JNk5LMUF2eWFoU0JBM0Jj?=
 =?utf-8?B?eklBT0F5bDd1b1ZtcDF6UjRHWlA1dUlCMmM2a3RCL2tPaE5nL0E5aGRrWktj?=
 =?utf-8?B?eW5WL0pJdDI3eXJOcVV5NFJoSy8xU3BMeHQzN2NQdG9MSElrczVxYklMM1Qv?=
 =?utf-8?B?OER0SVJBTC9Zd0QrWXRnUEZTcGhZbVUvZUJMTTE5Ty9WWG5meWx5d0EveHh5?=
 =?utf-8?B?VnhnZVNqUkxkR1hpK3RPcHA0dTRmYXFzbmJnRzQ1bzBURm1zenNYN3VYc2E3?=
 =?utf-8?B?QnlUbWJaR21KYnI4MlN4TEp6S3ZwVE4rdDNCem1aNnArbEZDd3NkVnkwMU9u?=
 =?utf-8?B?b2IrZTBuei9UeUpMN0s2OXhPQURxQ0tiSTk2ZEhJSWdnaDg5WkZiakloWUVE?=
 =?utf-8?B?RTB5VVk4T0RLeGVWUDQ3K2tQeTRLK01XNEZrVXJxUVFkRW56cFlOVnNUcmlC?=
 =?utf-8?B?WVVUYkx2T2NIQ1VqTmRFSjR6aVNNcW1kU3RBZm9KdkFtaXRxMktKbjdaTmRU?=
 =?utf-8?B?Zk4zOHQ2Z3ZFbnVWR3J5M0taZ0tFVmd1OTJTWGVCclBLenVuWXZQTzZEZGo3?=
 =?utf-8?B?TGdQRHNrekR6WnJEWjNDN0NVc0JPVi9UUjVQM2NZc0RiUkZkRm9hWTVNMDJV?=
 =?utf-8?B?RXplbFd0dmNaa3NkMkl3bXc5TVdzeXRiU1pRRU1GL2wxTGxJbWNQUHhMRDUr?=
 =?utf-8?B?TzhDZ0JlNEk0WlJDVDV1a3REbEFwd1lpeWlMOGlsZkErZ1ZvZGE0QjgzajNI?=
 =?utf-8?B?eFlLYXBXYW9ZdkJoRlY3d3RmTEpQVDlNVGNTbWZvQ2Zaa0ZwWHFkT3ZuOTFh?=
 =?utf-8?B?WE9OMWZqVzRpcnFLTG1GT2g0emVzV1VBbmgzZFNUVUJudHoyZ3phS29VNzQy?=
 =?utf-8?B?anJrNnRWSzlJbkxuV1Iyb0Ewc0dEMHVORnhjdU53WG5IWTZzZzZoREE5ZSth?=
 =?utf-8?B?Q1BEekxpTlFXU3hEU1V4OXpTQmpvY3FqOHR2aE1aWDNJN2g2UndIbnd6a3NB?=
 =?utf-8?B?RzFkTXRLaStEYVF4Zlp2QVUvc00zWHRnSndneDBYNHJFb3Q4RXNBT0lUVmJY?=
 =?utf-8?B?RFBNeXpjNVZobFVoaExCYStMKzBsUCtKT1JQK3dJeWVVUmJhYlB6NHNUVjNp?=
 =?utf-8?B?eXhadHRpZ05LQUs2SzY4dGVOZGdTK1lhbGlEdFVNN3RjdVdZRm5xUnpBZGhY?=
 =?utf-8?B?dThOejNXMk5HbFI5UWZXWFZqNTVETkRBZzkvTmhIeWlSa24xdUNoQkg5K1ky?=
 =?utf-8?B?SnU5d0FVbDhXZlJ0WHdPR0ltU081dXRPSlNoWUQ1eXB2RCtRdmpENnZ0SkZS?=
 =?utf-8?B?a3FVU0xHRU1JRmhwSzBkdWI2U1FKUE5kemNiZ1hJUytEankzamJWRlN0NFo3?=
 =?utf-8?B?eG4reVRDaFVubUtkOUtPeHY2QTArWURIVkFyNnVtaUJkYk1hRVFPZnRoWHJD?=
 =?utf-8?B?QU5nbkMzU1Q2SUNBVU1CTWxTckQrZVFzdWJCUzhEc3AxeVU4aEE2L2JPMld6?=
 =?utf-8?B?Nk9JNCs4TWRvR3I3MlJ6Y0FpQk9ySzVZdUIvTHRzMDFRbmJYR20wQU1DZHBW?=
 =?utf-8?B?NzBjL1hZbWZ6L2lpU3RjVkNFckZyYmZlZ2NSVitOTm1PVmZQTncwMnlWd2NR?=
 =?utf-8?Q?11B+2m6+hMqVfPcgvyct3w2E0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EACEAC747371AD4FA48DD6BAD9082093@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c686619-aed2-4729-07f2-08dbdfda6d11
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 21:42:22.8225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RNJNJskR3Fmu6gji72SGVWT0YcFy8MXfmOybmWzQbLsw928T2XgpXkUqs4HhYZ/daxA3tjBVthN8Mbcuai5f9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8868
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_134227_739253_6B11CB9E 
X-CRM114-Status: UNSURE (   7.09  )
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

PiArdm9pZCBudm1lX3N1YnN5c19pb3BvbGljeV91cGRhdGUoc3RydWN0IG52bWVfc3Vic3lzdGVt
ICpzdWJzeXMsIGludCBpb3BvbGljeSkNCj4gK3sNCj4gKwlzdHJ1Y3QgbnZtZV9jdHJsICpjdHJs
Ow0KPiArDQo+ICsJV1JJVEVfT05DRShzdWJzeXMtPmlvcG9saWN5LCBpb3BvbGljeSk7DQo+ICsN
Cj4gKwltdXRleF9sb2NrKCZudm1lX3N1YnN5c3RlbXNfbG9jayk7DQo+ICsJbGlzdF9mb3JfZWFj
aF9lbnRyeShjdHJsLCAmc3Vic3lzLT5jdHJscywgc3Vic3lzX2VudHJ5KSB7DQo+ICsJCWF0b21p
Y19zZXQoJmN0cmwtPm5yX2FjdGl2ZSwgMCk7DQo+ICsJfQ0KDQpuaXQ6LSBkbyB3ZSBuZWVkIGJy
YWNlcyBmb3IgYWJvdmUgbG9vcCA/DQoNCi1jaw0KDQoNCg==

