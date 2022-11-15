Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C413BC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 04:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jC5+qae9TeY5UnJuiDN3V6f86N4ChUs9F60vAMD+ZPY=; b=eoshIvnLBVi8PJtTR/BiTwaAxw
	0ekaZl2LVLOAauasVdeufdWzQ1A+s48/1/+1Z1QGuJq1mrOyyuMl4HgHj8t0sf3DQ4TKP3VxkpBff
	e/8QN7ff4+Zx0DNf6E94dNgFgmbdQLO8IJyDPmaQE47fxT4uJe+xajPnygAqt6Js6SdjpDTpMFNG+
	zvnNUmG7RPPThg73ILpwslHyY92CvfQ8rtOSbzVTqZu9bRgBa/WeaEKv9Rc3gB3y7656LdKZv+a2J
	Xk5rolbCjiZTON0n3GIpTBuJSwqbr22pmWkPTd6ZVWeg4IfvM4S/N0hRrWkwMj99nmPrtZWNnUIcF
	pOY3nNEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ounHE-007USS-50; Tue, 15 Nov 2022 04:10:24 +0000
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eae::600] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ounHB-007UPd-05
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 04:10:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3tI1HOao5fcoeC0kneICBmh8glI4TNN3NzTSlqvtsm4zXfifPxHLDvyvbytBi/CBDavjH19lEmTZAoPpFZgLgbrIdtYb9kiSu7JEphJR8hjMWW7FNllBiFxjaT4VrJsqIR9QCfYTs7k7uCaKI4j7zztFtqICDzWRsPGGrZ8emUVF3HBo/GNHDIM46sN21JbjoRTllTSN9F2n6B5kSfRowPmcX2ZuhQ4/5nbU5rea/GdWB5j8lsGil3HO+WcsY75tvkHo0Ti/aIysR2ua6iNJhYB5PTAcQDvC8xpgpStdEA/yZtJsZ88tJ4qaCbNKqjETOgm5w3m2wso3JoeIlwijw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jC5+qae9TeY5UnJuiDN3V6f86N4ChUs9F60vAMD+ZPY=;
 b=Cw5QnEoCmqB2NAGnXDv+yTKHIbansh1T+m7s9FaO+wuOJpioW10o2ktt6kZsM981M4RHaF5NaEsnwDkZaGWuLVnHk047QyDmR3ICG8Q+9NTpd60ig2QYziHlGdhLtz9i64Y+4xojdltCnYspzx//6+z/WzifGra/Wpbdlv/pELhzI08Ym7HpXi93kkj/XFnI6+SG0VsarlP5LSk85LwrzybiJBLKoLhBZhSMNWDlCmQyPJzbzj1oj/mUvYi7HiZTB50qXi9yfqeEgj4CZdrf8qL3cX55m/s7lh5GOf6K4pcQAdyh9q2h3CXENHDWj+IjnKj61K1zNJD2DcEpp4R1Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jC5+qae9TeY5UnJuiDN3V6f86N4ChUs9F60vAMD+ZPY=;
 b=pKhmDjmtlDfxWKeO4SYFcx2kxhvoKbUGSkKVQR5OL8C05FuYFrICYviVWt8I5yZ+uqr/KlBzRot0Y4dxT1PmXbO44N4k4MSCHt8qIYnP+z8xtPN0953cRi3fnaDhcfBN2i1QA1UtBQnuLE8sBQHHUPk+rPBOPnBl1Nx0TWq1y73JgbUPFELhEZPjIa90yRNQ44Cima8oZmjBqyqsu5hfsZS5XzHkJsl66VjmmdDjGEcACGb7SIUmQ0WUXDLC/57ief+oskLhY+oul6B6HrfGWBTYlKKRJp/plbWsngXhAhUOOasUL2Tp9Ryo37AIIYV2DnbFXtVMGhAY+X+mlmBqnw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 04:10:17 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 04:10:17 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 13/20] nvme-auth: no need to reset chap contexts on
 re-authentication
Thread-Topic: [PATCH v2 13/20] nvme-auth: no need to reset chap contexts on
 re-authentication
Thread-Index: AQHY91MiewC/Akbc7k235ogv0E1OXK4/YbCA
Date: Tue, 15 Nov 2022 04:10:17 +0000
Message-ID: <a49bd307-679a-9a36-9c13-d758bae927fb@nvidia.com>
References: <20221113112424.1049834-1-sagi@grimberg.me>
 <20221113112424.1049834-14-sagi@grimberg.me>
In-Reply-To: <20221113112424.1049834-14-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB5997:EE_
x-ms-office365-filtering-correlation-id: a0ab2710-2949-40c0-3d57-08dac6bf4dec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  XRuf8YbqDipill3MvS9Jpmb9tFqLRsq3EDD+18qowngRPbxBoeWS/NeLsPttmQtVCe6c+13XWRGRKyfvc/IunD92qskm8r8J4heCEfQeFQLnT+d4BY9BDNsU6Cd2fEOaDNmwFKo+Ym5AUP3EQ9/uFDC0DAi/XH8ZfOpoCVYK5WLoaBbWq6g23Qf4Jyu8i40hS5oV9790uXpArbZOU8q9Gb9b4j4OoQsMJUX3jCToPP57q2tg4KvIgZwfZRx5rilIt3zCY6RHSUfU8Tw4mM+43iKREQJIdC1OI5D4hzFpln5CG5lMbngNPr9WvmJFiZBNior+aQ0angYnKh0s0kgXwHr2MLRc/DT2SXpEFBL8Ha4XJ+E68p7VfjBpTQIWfM05LHRtzr75lJ+YXi9OdLoZStc7r9BA9ZJwF6J42liBkcsea/kBfcAhFjab6mrRSUJQBgP9ssTEAyY1A2VYMnvJBjfAMRxz3AiN+T2//O4lRWUOdNyiiWaFIFH0612EUFPmqO08Ljm9kchkib+HuSHO9I3ChGEHjvXfF3GwSPtj8ckaVcn09rTuHx/JSuZ78t8KfDDmmXHFi/qul4lWr0rptkmctCB6D6eyPGzuX6wqZf2fs0jwsQ1GHkFpUu5K+TB9ecYOVz46DJcTet2Dc34xcHjbD2iAw6Yo0Pi0KkIJ30vpQWrptW8N5ORVnTJtmhlNiJFQjtv3m3CLYdVUhSzofpmdM4ftThzF4QLYEJxzV9wgu+DwN47qFZGtcvjAAW7hmswdUk7//M6QDzxIVv+HLlueJivM0KhR/esSUxUP1crPbF7XkST/SFV/hS5HJRQuOR64WBTN5EKC9M0Vq7Xhtw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199015)(36756003)(186003)(2906002)(38100700002)(2616005)(5660300002)(31696002)(122000001)(8936002)(558084003)(6512007)(41300700001)(86362001)(71200400001)(478600001)(53546011)(38070700005)(31686004)(6486002)(91956017)(110136005)(76116006)(4326008)(316002)(66476007)(6506007)(64756008)(66556008)(66946007)(66446008)(8676002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?T1JVTWRhdExqcnFzWlRDS3FKRzBCdnJlcXY5VTJDQzJGWW9CMHpJenM1NDFi?=
 =?utf-8?B?RG9oalhLV21CYW90ZHhGM2x1eWxocHdaUGFBVVBmNDNuWmpFY1lITGNPcXdt?=
 =?utf-8?B?QzZjNEh1SElRWXhqa3lqZStaWmxuS0RTZDdOL0FyS3kvbUdxTWlnbmtJTlhD?=
 =?utf-8?B?eHdPc2RvUzRHVGhPcEsxTGlDRDF6akMybUlzdWUzeDFrUUwzNmx1RGpnM3d0?=
 =?utf-8?B?bzhEK20zTk1GLzlGU0MwNnI4Zmw1TThjUG5JUDd0eXZDeTJyTFBFYXk0bWcz?=
 =?utf-8?B?UTRqS2lQRXBqNzVlMmpxTmRzYkhxZlQ5MFBKQ0tpRUpEcmNWeG9RYmhIN2pt?=
 =?utf-8?B?dnZQQ1ZRWWxJa3ZnZUxaWnAvc2g5Y2h6U1dDWXBteXlIVDZ0cHNpTmpOeG5W?=
 =?utf-8?B?NGEyclAzZ2lFalo1UUJnWFZlVU9VTWNpZnlLRWxwZDU5VUYzci96YXVGSlJs?=
 =?utf-8?B?OWgrV3cwekhtRUVJWlE2ZjVIQ045QUV3Mzh1MzQ0R1BGTDNUWUtXdk5wZXpF?=
 =?utf-8?B?NWhYNzN1d1Jnb3ozeUhiS1RYM0ZlQitrb2crSWxoV2RzNGprL0tEVk5ULzJn?=
 =?utf-8?B?NjBCdm9ObFBOelBaS1R0UFhkYndpQkh5QTZMYjUyRHdFaVg1NnNPclJMc296?=
 =?utf-8?B?M21SSHNUcklSZDlrVDZPZVhEZkJpMG1pMmpET0dYcHhhTTM0dnpET3BTUllW?=
 =?utf-8?B?eXNWNWVpTDZqWCtwSWhsREczb1lyRjJPRFpoQTM5OTVXd1p3THFOSlhPRkVW?=
 =?utf-8?B?N3Z5ZHU0QzhYQWx5SERJZFVtWGp5Qm5zekI5UUtRTFFRQUZTdCt4R0NZRmF0?=
 =?utf-8?B?SWZMUmhPdGVMMWNHQkpKbEloMzJLaEZDUmRadjliNXpYcU93dmlsOGhIRjdP?=
 =?utf-8?B?MzBJNjBzR3BZWGQ4RHdnRnFiTUl3ak9GV1kyMS9Xd3B2aXg1UFFhWHRCMHB6?=
 =?utf-8?B?Mlc5amRheGxVcXdjQS9OY25EZlRTK0tuV2tGZ1BKZW9YVm1HSG1wT1lrQk5H?=
 =?utf-8?B?Q0psQmVzbVRjdm4rT0FKUVQ2N3VtbDJxbDhvc0FBNkR4Yjc3QjhwWm53dE9t?=
 =?utf-8?B?QVpoa3pzWnNqSjY1Tnd6U2tqSXgxRE9CQWx3UVBzS0ZFUHRrSzhOUllGdHRa?=
 =?utf-8?B?V1MwUm1CWDl4cVk3VlpsRzNaNDN6MWRQalBSRy9adXU2LzR2K05naVpGUGpG?=
 =?utf-8?B?cTdwWkZHcEFDSU85VC9hUkQ4ZCt5dTduNTNPT05wTTZQYytPYllsUlUyUjM0?=
 =?utf-8?B?cVhUelV6ZmNpWnBpOEFVS1FSUnh5ZjJ6cWdwR3I1eGZVQURwejdlNDJacEM0?=
 =?utf-8?B?OEtEeWFwSlp1SVlWMVp2NEQ5eUNQWVM2Z1NOQnRiaGI3WDdUdW9rUHpSekto?=
 =?utf-8?B?R3ljaXg3WnhWUTFrTFBKK2JkRXphVm83aS8wTGpxZmR2WDdJUUhRTDI1MllD?=
 =?utf-8?B?ZkN5OGxlOC9mWWo4Y3pNZ3BHeDkxMnZOVGFKMW92SFBzWkJlbDY2MXZqZlhT?=
 =?utf-8?B?WWZ4OXkzYVBhUjBRcnJlQ1hJNW9DdDNxclYxNTBGdnJwVkFYb1ltU1NYNTdB?=
 =?utf-8?B?QktGNjlLSzV1Zm5vNjRFTjhndWw1UWNzajZZZU1jWEduNGZBdVNEWlg5elM5?=
 =?utf-8?B?ZGtUNVZBNzZnaTJGWlM1ZUNSZzR3ZmZBYVFHeGtuVmtIbms0Smw4MzhjM2ZJ?=
 =?utf-8?B?STNNNFJ3bFNMN0JreWlMZW52dHRjdjE1bk0veU95WWJnbWFVQVE1TEVwaTFu?=
 =?utf-8?B?U3ZCRGZ0VlZvZ3JhMHlrMnJCejYwME9JU2w1b0tSQTlUbnhiMCtza1EzekRY?=
 =?utf-8?B?S1BzSG1YSFUxZkJiU0NEVCt5d0ZJOFpkVTVwUnZsZ0k4WU5vbEhpOG9MTXV6?=
 =?utf-8?B?amd2ZnJLR0dMR2lHSThSL3JUUzA4WmxnTUNKcEFOWHh3dmY5WXpmTWprdjg2?=
 =?utf-8?B?YVZBVGNzRTJTYjlKdnFxSmxmbm12UEVXQTc3NXRXZCt2RXRKa09TUGZ6a01X?=
 =?utf-8?B?ZEN1TzZxd0V5S1F0NUJnditOcnVtZkNpV0RWaHJPT2pWdmZWdmJWODlQNktZ?=
 =?utf-8?B?ajBlSW9jVmpmTWNFMGNNTVg5MHpiN2IyM0JYLzYyV282TytId0ZMMEI3b09E?=
 =?utf-8?B?NkZOMWM1RzlnaStuWm5TNDdHSjk4aUJMbURidWYycEVxeC9wMitWOUd0RlBN?=
 =?utf-8?Q?4zYxgj6s4Lgaj8JfzjRfCqqaemJrjNEaoS1liDoWff6N?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <983D059F3FE29B45B9E77861210BCBAA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ab2710-2949-40c0-3d57-08dac6bf4dec
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 04:10:17.4102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oa3p+kGZg14dMkEh7HWfpYbkYVYZjKs/6h+4DJW5HyqP5hNE8x7XJmIbe9DxW4riPzCg/FC01OQn0iL4095JYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_201021_072461_555F507A 
X-CRM114-Status: GOOD (  10.35  )
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

T24gMTEvMTMvMjIgMDM6MjQsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IE5vdyB0aGF0IHRoZSBj
aGFwIGNvbnRleHQgaXMgcmVzZXQgdXBvbiBjb21wbGV0aW9uLCB0aGlzIGlzIG5vIGxvbmdlcg0K
PiBuZWVkZWQuIEFsc28gcmVtb3ZlIG52bWVfYXV0aF9yZXNldCBhcyBubyBjYWxsZXJzIGFyZSBs
ZWZ0Lg0KPiANCj4gUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPg0K
PiBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KDQpSZXZp
ZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQo=

