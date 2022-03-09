Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADBFC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 16:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bizmu4xIwKED4DDiG0OkOHqgyjCUyoXJqV94udehetQ=; b=jF0ghMU4H40YjMbrFLH9/Zq4xg
	CO7pxca6cvaZ5v+P1aoXuzHpysWtqKZC93Qfh/FPO6OOwF1JYhaNaqePuIo+YNFL9fd/chc5z+jIR
	tB4qZMpTLC1dVF5yrjFOWrCC+yQXvI+8oP6Bq5a5QdhETF5VtsIRoJX+hQ/6aEYUzRhpLAyTCdbXt
	TjRriDHZW3HNGdFIzFZ+pcfEmFVfhfH1YAg0i06nWFmezsBhmCTCUygFxx8IUXM+/jeOLUoi9B7vA
	9oKPJDILBD8SvdM8DwtGRm1ne6MT2Zc3RwvNUtd/PYVPdoMu2vfEQT7FZ05iuih2itmi+l4mOVWcq
	VBOAwA+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRyus-009IFP-5e; Wed, 09 Mar 2022 16:11:58 +0000
Received: from mail-bn8nam12on20615.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::615]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRyuo-009IED-K8
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 16:11:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtGQK68KX4JPDRkNfls7pzUFnXwaImzNxgDjhObMZ6GJ4e7vdy1loXJhuuQ9qkA6QY0Q+OHV0f4o1Yf8YWDnq9MK9wu4ckU1rDdn28Fu0HZYo2t95vZul3PU3NwFfKfHD4jcpIAx7Gby7JuEDusngruuA4+7MVnmdYhpX0HRRQTDHD8M/dym0LzHzAX4GoFfKRa2e9Sw7DHqBI5WzYHg9B/ZjGhzfmr8LXi4fxC7vR72fcKsLPkAsCMH3i2gNAHcjIU4nXZA7qsfZcYqJ98YHOP0b4XpUvhVy/FpE7scAUW+uc29OYZac9G3PIp2x++O8JQkSjufAmacpIXwRICtpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bizmu4xIwKED4DDiG0OkOHqgyjCUyoXJqV94udehetQ=;
 b=WTKxNE+qX5n6KI2hZlkHifAb/VSqKJesZzC4fA30AGugpESTd/XluoPaAdqzfp7VEFA7eVMhAonQS/O4YjucIwBC+ibIdZq4dGMnZQH5KbaHomSYT4u5y/uzfYaoRzUblSRay21Aiej0+Uul893G9PoKzXleEyeItG8CA8ANktjlr2YwpYIEq/JhmfsH2bu424PB4BhDDE4EYPJmgraliOnPn+oqbIjJPqnR5TGuTzr5yMzai/ho/z3kY1z6Um7Zjx9WaLsAmwlA9Wi/pHaBabFlDAMyjm4jWxu7BHtAguwyPUCuGJrmu2t0owfgDbAezbDRFBVwW6brp0j3GviXyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bizmu4xIwKED4DDiG0OkOHqgyjCUyoXJqV94udehetQ=;
 b=BdHFudgxWyaf6qkcPbWbGm6WW2yuXLDG7PcuwEvEyW4pPp3SFpIKGZvcfZSaIsLF7yFJR+HTMaLxX/y8eywWN5q/ZTTwX2NEBiU34+EpcFmwZkmeZYH9yswGucmLPRiqaPQhAFDpN0XLQ/hXbJoYLClMCW/Z2krdzq4cCFa46jSNKc3YGZNjCH1CbqTWIU3zZ01K8eZtfItgzph7bgBm+9yeSEWYKjpipIpfxs/lWFn6TMDbmXiEuRp/6DlS3nnZGP9NoDl6stanPtjgZ0pb0sCtMVY5YFLIvu9cA9/zjNmp6V8b5b8U6xSd5yAWVfljUCSOmv0bMKSKrkZ7l82ztg==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by CH0PR12MB5092.namprd12.prod.outlook.com (2603:10b6:610:bf::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 16:11:51 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::6065:161f:451:70fd]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::6065:161f:451:70fd%5]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 16:11:51 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guoqing Jiang <guoqing.jiang@linux.dev>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, "hch@lst.de"
 <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-multipath: call bio_io_error in
 nvme_ns_head_submit_bio
Thread-Topic: [PATCH] nvme-multipath: call bio_io_error in
 nvme_ns_head_submit_bio
Thread-Index: AQHYM3uI5LBmhLwWWEqrR/5wYK1dn6y3Oc0A
Date: Wed, 9 Mar 2022 16:11:51 +0000
Message-ID: <8d0479e2-c25c-7c9a-c978-ec20d162490a@nvidia.com>
References: <20220309060228.18846-1-guoqing.jiang@linux.dev>
In-Reply-To: <20220309060228.18846-1-guoqing.jiang@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e74a9c74-5d22-4f4f-5cbd-08da01e78547
x-ms-traffictypediagnostic: CH0PR12MB5092:EE_
x-microsoft-antispam-prvs: <CH0PR12MB50925A7EA62687159780D481A30A9@CH0PR12MB5092.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GkTUcSDh/+Q1oufQqp1dObFZk2B6y/Ur6vwJ8XxBLK91fjONTsja30z0c/BzHNw1t1EGDdRaqJbbYW4iRVeRtBt/zErn0k4pVpsyvaufISLGCqnlAu9NVUBzC3CahX3vKagUOmdBctu4MvGZznORTAmiCHKdjNTWvYNeJBDz32YtUVyKPeztJOEMN3dO3z1p2t/WWTQMXDmnYXMImjAAMAesvRVPmvX70A+7TsIUZQwz1z9ijfb+F91ph1ecBqlwEu7ZPe6wdN/vnlOk91nFfBJi8eF9IB+ZY7mO5BRVRrjFvJ5Z1/k+Aabtecy6mILxOR3ddHGJhhtzbANEU3Jxo0na5aH7CEMOAMBuOiiv90e8/UcA7ZAedxAEdtfvt0AQKfgdLvZW2ZXo4FJ7Pyc77je6r8MsWeuhgSwtDKzaSC2EosnLXv0YBuCfnNz8DLJOAbNn4W2DL9hko6hkuePTHSQRBpSweBtTJGzv5aeS70N6uicdBxVpqsmmZhzOPfDpIa+CJG6TDnTNF4tv/MmETbrA/E0Pah6QVzJNqahzcEyGWdT2X4DViwI+1IaAj7jHvAc5BbTnJ/fe9S7tap1iSjGKcDIpVfu2NDjIxB33h5GquRiQvi0qWnjXKNi+HVaETfrdvQrXVF9dCaHdozpqFmKn58SrzsOWcrKuCOd2nUUL0OLMRnveFDMPxBdcTS9H5lFiYs4wRPpKn4O1a6O13BOqzmDOO7BG+4s8Jsllh6z0xidG/xOyy4OWuHIHSO5OOkw09uILHf1MVnpoawmp/g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(8936002)(316002)(66946007)(36756003)(91956017)(31686004)(508600001)(6512007)(558084003)(71200400001)(110136005)(6506007)(53546011)(5660300002)(6486002)(38100700002)(122000001)(86362001)(38070700005)(186003)(66476007)(64756008)(66446008)(8676002)(2616005)(76116006)(4326008)(66556008)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0wzY0c0RHFBYTN1TGduaWtDeDF5ZDRWbFV5TFRkYS8ycEFvSlRkUU1TZHBo?=
 =?utf-8?B?dDBYRWRxRmJ0K3E5N2Uwa0FuMkJkWTZKVUFkTVp1V1d5SFVRcTRnUGJjMmFG?=
 =?utf-8?B?cHpkZkR4Mnd1djFtcFNEWWNQREhyTnVPcisyYy9zNTVtV2hOc1Z0NEJpbkRS?=
 =?utf-8?B?eVFkOXExbW9vaVkrZFAwMGthTkZDQlpscXAzS1krTEw1SU5md1cvOTJUZkFP?=
 =?utf-8?B?WTcxb01KMFdzdHVyZXhrSGpMZEpvcEZyMS9aV25FTHJnaytpSjFMTktGNHVQ?=
 =?utf-8?B?Skx1c3IvQTRPc25Ca1NCWlJHWUtCMCtua3FrZm9DeFkvK21aU0U1VkhwWXpk?=
 =?utf-8?B?ancrZWwvWGFITjMraEVzQjJLcmV0YjVmMURJeGppNXFReE5CL2YwVGtWS3lN?=
 =?utf-8?B?Njd1YlYwN3hCdHVUc1Q4czJySkxjMjdMOHQwdXNGVUY4M2tkYU1SaVQxM1BT?=
 =?utf-8?B?SEsvdDNsRTFZM3JydHprWE5TVk9FRVlpbDFnV2dzbDZSamdPNlFRd2JmYThT?=
 =?utf-8?B?V3hOaDl0S0wyQnY0aXcwMDF6UHR0MnVFRXdXak5COXRRK3ZPTTlCSDZ2S2s3?=
 =?utf-8?B?NnZ2K2pKMU8xUExHY2hxeFFHYnN5MWhydVYxYSt4ekFQa3lKM1J0NXBvQXhY?=
 =?utf-8?B?UUliNVllQkhMU3FhRTFtQkN1b1RQQVhJZnRQOUZ0ditMNDE1ampsMFlYbFNy?=
 =?utf-8?B?NDc0aXc4NXh1SkljM0pEMTJGZ1EyOVFhMVNBMU5mZVdaWHcrT0lYNE4wWUlQ?=
 =?utf-8?B?WFFWdjRMMHE0OUJKMTNWcVZCSUVMUkpGbmt3cTcyd3BRNnJ0Y2NzLzJ2UERV?=
 =?utf-8?B?STFDOUVZc2phYnVNb1JST3RLejVNWTNLUU1KdG1UM1ZwRno4NVhibkZMd2l4?=
 =?utf-8?B?bi94T21MSVh0M2EwTkZPeGJNYUpuRVRFWm9zN0ZzWWNwWVRjeXhnelNHd2o2?=
 =?utf-8?B?TlQwdU1uMDBTOG1oeEJUSUtrc0VUT2c2Ym04NVRtL3BlcW9CRWFLcnNQZDZY?=
 =?utf-8?B?R2UvaEdrM1ZTYVpZaXBsWm5VVWYvOHBOWlAyeGtQR0RpUnAySVc4SEkxRnZI?=
 =?utf-8?B?QWsyOEpQT2RBRmJTbWQ0VXVIQWQ2V2NrekM0dnFVUGtDQXo5RE1FbG9XUFdo?=
 =?utf-8?B?RS9icVR1aTRyNGFMdEZPanFlb0VOcUlNcUV0dFZqOFJKUkczZ3V4VEZKMzJX?=
 =?utf-8?B?dXlqcm15Z2RUNzlaQzFLZHNkR3VsZUxkeVhBRWFNQ2EwaE1jVzdTejBrb1Nh?=
 =?utf-8?B?L0xkMDQ3K3RnZktKYWZEUU03Q3N3ODZCb2o2RkZHcFVqV2hpV0d1VExkMmxa?=
 =?utf-8?B?V1VTYUdyaitUdk1mUit0TjJzRWcxc1hzbkppb0NXNElHL0hpTkFORjRoY0Yw?=
 =?utf-8?B?TmdCNW9IcFRqK1NEdXpVL2t1ZDZjL1RFdTJScHZBSkVDT2ZENS9rRnFEam1n?=
 =?utf-8?B?aDdmN3N3cTh2M280eEVPUDdnc3Qyb1Zpb0xNNE8wMktUVXBVOTVPbW5DQTV3?=
 =?utf-8?B?SWNOY3JFMVJWRTE4czZVbTE0TFZ2bjhQL05JazNMdlc2N2NRbmJRNzBsZnc4?=
 =?utf-8?B?NVM1a0RTN2dqbzJRUWg0bmZlVnRycUdyT3dQYWZhN3FSQjNSbERFRXFXQWFI?=
 =?utf-8?B?KzJlU3lFYVh3aGVNRm42dExGQmZRNVZVV1h3YVU2NXR6VkdNOStrbFpNZU5M?=
 =?utf-8?B?OFFMVDZWa3hSL3k3bmVVSE9GejF0SSs2ejVnR1hZb0xub0ttNG9lOE9MLzNG?=
 =?utf-8?B?T1Q5YmpvbkE0cExINm5udzV2T0t4TkR3Q0N5V25DZEwyVTNHWUJWVXUyMVpy?=
 =?utf-8?B?TFBneWRuckFCUHBhdnhHT2t1dDBJOXp3SmRUVjZod0JjWnUwQmNtZ1JRV1JC?=
 =?utf-8?B?MVY2TTNwb1pQV1pLYXh6aFBPMkxvb3JRRDQzNG5TOGtVWHlLL2xoOXBVUnVX?=
 =?utf-8?B?Nk9RMnFRL2dPRjYwOWJZMjdSd05xUkRYZFU0QzRnVGpXaVBYZTNtZk9QTXc4?=
 =?utf-8?B?VitiZEF0RGpNdmwxWGp4bEpwb3RBZzF4SlRCR2hoTXhzZVVwN21jR0RIMlpN?=
 =?utf-8?B?Uy9GZ1dZTW1QdUNhOVdLK1Z6b1hKTllvZXcxSldGQm1GVXNXM2FqaVVFQVdF?=
 =?utf-8?B?b0duQWdyMlVScGVNdWRqOXc3KzMyTW5WaFdtWnJ1UGEwaTFoSVJDOHdlTFh4?=
 =?utf-8?B?b1pJZm1QU2dQb280OUZOZWxDa0R1TG1PS1BNQVJpSDBGYVRVWGFpQXJ4VVdw?=
 =?utf-8?Q?TANGI4fSj46Rop2zEgN9HJBAgEbjyFpY7ctn7H64QU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A97D7726A2B60C419015FB305BA33456@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74a9c74-5d22-4f4f-5cbd-08da01e78547
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 16:11:51.0841 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XR1C412ULT/Rg5DrHrx3jHRgOGsqkui14mp2+qSrLAZJikSOrJucMKQSQV1APBHOXCFEFcNHdRrCx1JvBHgCUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5092
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_081154_695593_54D94F5E 
X-CRM114-Status: UNSURE (   8.52  )
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

T24gMy84LzIyIDIyOjAyLCBHdW9xaW5nIEppYW5nIHdyb3RlOg0KPiBVc2UgYmlvX2lvX2Vycm9y
KCkgaGVyZSBzaW5jZSBiaW9faW9fZXJyb3IgZG9lcyB0aGUgc2FtZSB0aGluZy4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEd1b3FpbmcgSmlhbmcgPGd1b3FpbmcuamlhbmdAbGludXguZGV2Pg0KPiAt
LS0NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2No
QG52aWRpYS5jb20+DQoNCg0K

