Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8328C76195
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 05:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eLLL8HUXFLwMOck3rrPcL/9GgdBIvca4rCElWYd10fw=; b=iXtQrRcs7wNMFvDBct83+xZe/X
	3+cz9fd1kZUvfKVGyaFhgK7qmFpt+c7vkH0mHBGeTja2vrXgm4QA2y4EwMCv/3Q1ArgpfhcdIVrf1
	0q4PTTGVgZSZmGgwtjr0xC4n65KoTcHCXvHGaYWcilmYYkI3OJ0GgkoVwN5aczoTq1jk4ZqsKBRuB
	iIa6d4g8NcJqund++gE63nvHN1EQPq/n7aChf6ZSXNesgWBKNlJxCJHGEgc0VHU+hlwghjahqAz3A
	SldP70uOz9WQbNwO5ISwfVX6MrbOqoNM1PqICWz28eFlGfLg9TuQDmaquXkWBkOEtiq6IwdXLsR6e
	sDBfReVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcJUf-00CN7U-0u;
	Wed, 15 Mar 2023 05:16:09 +0000
Received: from mail-bn8nam12on2062c.outbound.protection.outlook.com ([2a01:111:f400:fe5b::62c] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcJUC-00CMkX-22
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 05:15:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KX6cK/18ExVcbTJ7DbhUjh6ycWOsTHw0gC+wpMuA+ZJPOS+klQvPCZOv7+T4pgIq3KP7GRemCdoJJztGCLru1iK0DAt2kfeDfGtYG7pthTouz9aNEpotH1bbZwR2K3Uy2bbOdryeW3n8l03BP+cMVEkHV1i9vA+6XDx3P/UrXy//GxXyNepTlzxvJuElmP2UViHAU4XdU+vvM2g/uDAGXG/qtFNvlhj3zNZzYWJxWEs17oc5Lt7vz9nOlnx8rRaoEjcrAdX5PvkcPz4PrOsOWSvFZ9mkk11wbOUgtV20bVOmMotWBwuHXOyc68Pca4iOAB4YtOxCVArZoUk2OsSSsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eLLL8HUXFLwMOck3rrPcL/9GgdBIvca4rCElWYd10fw=;
 b=kgrgKM2W15ASyzJ9QRmsO007xXo/mP56yadrgEgwtZvkA1SCB8nbR2fw5YA5qD7V2bFzZ/EXUsCyyOJZTqH8Gt9SUZRalaPHYOPIPVGDeAeGlYOa7YRe9HTliSn8T+CjDukBWKjzIIdZ06bqvrue0QGwmav9ChFcgnmjinbuVhhlgN92FV6BaX3u8mrONy16NT4AqNcRf/YZhkOYwEGhUeaVuWOYq2AAJFupstmGiXV2Od+qLujVFx+Gf+6xGeGlyu1pdz1rNWhHG6Mpo2lB3yOx/Sd6lw00ptOUzg3IF9N0N55VBImCcwPfKUun2AeA+dUL9LTRNI6AIfhagBQWvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLLL8HUXFLwMOck3rrPcL/9GgdBIvca4rCElWYd10fw=;
 b=pLBSX/79EcsaXY4QegDN09VoqO+gmOa8YX7k+TKeUidj+8rYsB13FRyDGTafXltfMFBl/i44spgyB2X35D4vMaChXwxcqSdcx2/mtU3UA59ob6DyW5t+j658vTETHSJp68IBrZSwnMN6U5hKku1VqTDk9/5RpT8qCHdHgkGrFiKHGif2oJHTNakPBvR4Rkz8xotxyPIBP4SyorVZqpC4RQ8B1YFSMFN078gQe2GgI/ZT8aJdOtcdRn1EnPUbBuayExkH9YoufMlrHV/QnuJbBfXpXbV2X34zpL4/OXIbNr1ZrT5O+IxdCMi/vFAZN/7PZwY5W0EN9XUkSCgKhAWaXA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Wed, 15 Mar
 2023 05:15:37 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6178.023; Wed, 15 Mar 2023
 05:15:37 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>, Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 2/2] nvme-tcp: add nvme-tcp pdu size build protection
Thread-Topic: [PATCH 2/2] nvme-tcp: add nvme-tcp pdu size build protection
Thread-Index: AQHZVYnP2hMn0ZBIXkmYClI0xXAMca77T0aA
Date: Wed, 15 Mar 2023 05:15:36 +0000
Message-ID: <60127641-2551-19fc-8ec8-b74b22133efc@nvidia.com>
References: <20230313085623.9321-1-sagi@grimberg.me>
 <20230313085623.9321-2-sagi@grimberg.me>
In-Reply-To: <20230313085623.9321-2-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA0PR12MB7773:EE_
x-ms-office365-filtering-correlation-id: 24ed9e36-679d-48bf-67fe-08db25144fbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  YqYzbeZIO3+SwXgib6wuzMCLdIImE3NgUOthpSkBNPILlf+BKXvpV8RL20nJrELl3JFuc5Ro3yDozRPifNTjOPycK6lww0M3bCkW6fuEd65FvQyTHOQBt8ZBzlMt7F1hrGaR7mntJFsqLTgqzvMdtg3+0faM1LZt8mtf8i9x4x5mbMhZ6LmKTbiuwF5FZYOYqDOoM6p5YVI52SZi7tqE84df0b85kQh7iBdcEXaPW2CvBWShqikpRyJxxvMfZcsVSNOuFSEZbtEnpcvngNyfqmWGYteonVMyERD+P/irok0rz7nk7EDNOavF6ZkwQPOSmoRCYdF+iHxbTdu+dxJWBEY0DxvzxeaQsn3wFTZ8y+YN/oxg4tpoBirq3hhc1Ub8ufVUtM0urb5fva6ZgjirYT2U7of/6rQVIVtKFVXuNp4yIRY4fZZ8Xw483bpwuM6yBFG1f7VRYflYd36jpk+wUvkMyJsd7zrcRYkMDbKW/s2gLvvVoNcJP5bDzmAPajToxW2cfzZiM3SINXme/sXxUl/IqrZoIt7sJXnY1+G9rHk06UVMBEHsiyJBwmiO9328M/3IHOz0i/On4+5ihnFeg8FXMEFoRTXPLUnIGtecbDqIHQXONSJeR1GPWV4sDyx4sK8L33OWlAQd6hIgXKc7hhkCY4UZXnLnOr/+xt4m1gS2NBFoB4RvVV5/TE9cnsg2N4o6hu2kT8zGHdPutYdjqe/tbQ/ybsC6CxA54rcfVAxKznJPZ8JfJRcXgCz6XmVOAJDITyYYYPJDVCH8NhkXOQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199018)(31686004)(316002)(186003)(54906003)(110136005)(558084003)(36756003)(38100700002)(86362001)(38070700005)(31696002)(122000001)(53546011)(6512007)(2616005)(6506007)(71200400001)(5660300002)(41300700001)(478600001)(6486002)(66476007)(66446008)(2906002)(64756008)(8936002)(66556008)(76116006)(66946007)(8676002)(4326008)(91956017)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?RGRlbUFIMjZRdDlPdndnVmlXRTk5TzZocHBMRmFoWXk2M21scGgydXNKYmUw?=
 =?utf-8?B?VDFISlptS2tBWTc3T3VXYlZGK0cwdVk2WWs0VEJNQ0RrZ0VUSXRNZ2thV2d5?=
 =?utf-8?B?d0lnQ2w4RUFZTVo2OFJvTTlVdXhKa2ZLYWZ3eERUZE82MmJld2RnRWdDMjhP?=
 =?utf-8?B?K3ZibDJhcFNOdWM0Qmxzc3lvYlpJcnVwV051QTk1akJHZDkyS21ObElvdmhZ?=
 =?utf-8?B?WDhVUXk5RC9zYUxEWGJvUGozWmkyZGJsYjVmZ1hxNmNmWEMyU0dyR3dkZndV?=
 =?utf-8?B?bUJmakQxQlRFSGN6U0ZLRzVPM2hMVlhOWlZTVVFaT2ZhTnZsTHhPUllkdDlN?=
 =?utf-8?B?UExURU91eG1HUExtMEpwVUN6c0l3TkxvdUNZM3pDZ3Q1U3J6dnVBR0JZY2N1?=
 =?utf-8?B?UGZoaTBpek1idXFpTG02NkZpeDZxa2hKQnN0UHlFSGdLTnczWi9sWS9adXRB?=
 =?utf-8?B?MGhWdkdNTVN1Mk8ySTV2eGdCTEdDVWpsNi92d0ROQlNjNDVlbTBKaW1LMDdY?=
 =?utf-8?B?dHdUUDk5Si9vdEUyL3dsV1h3ejZ6OEFuQmFYUHhEZDVQWDFmMEdFMWxDTGNw?=
 =?utf-8?B?UTZ4RGcyUlR6TDNDU3l4cG51V2pBYUcvR3FpVHlVQ3hCM2JLVTN0R0NRZUlZ?=
 =?utf-8?B?a2hwbWhIYWlEd2lNVy9uMkN6SVd0eHd1YThnMnhBYnM5U3dvVFJtYTNLcmZs?=
 =?utf-8?B?M0hZZFAxRHY4T0JYc25ZdTN2VEY1eE1OeERqTWQzYVdLN21CWkdPd2FMdzRt?=
 =?utf-8?B?bWxVZEwrZG1QVW4yYlpHRDNyMXhwMWdIZm1aRFJleFdrQzZNaDJaVHhwQzc3?=
 =?utf-8?B?ck5uelk5NWFURkxaVUNpS1crVlprUWVPVk1UVW9jTHBnZ0YvM1FFdFduYTlh?=
 =?utf-8?B?ZjR6TmxOcXVlaUNnUWZxOERSU0JVeE1RTlFoTi8rQkt5UDR0bDhGaGtFQnlY?=
 =?utf-8?B?NGFFNzlraXdweUtaRXFQUnRaL00rTGwvSEFQbXk0VDVxVGNWZTlaaDBPamt0?=
 =?utf-8?B?c1Z4bEE4ZjVaRFg2TzRSVE9UTk9mVHZrcVBtczlabEFKVEd4bTV6bXBUSi9G?=
 =?utf-8?B?bDExU3ZqeGNrOXJGRlRjc3J6bkdFQ25yUS80bGw4YzAzWW1LeXNXVHVYdG5X?=
 =?utf-8?B?ZzFEcVZJSlFpYlpYclVuREk5bnljbHdjcnV3Uy9GTlk1ekdZbksyN1JMNWxp?=
 =?utf-8?B?VWlJNmtOd1daSmxQVzNKUkhobXAvanhnZFJlanFLSUJ2VUpJdUJ3bVVOM2cr?=
 =?utf-8?B?V1FOTFJjTTlWMDYxNUJVNHBvYzBmbTlSVk9nOXUwcTlJc2I2Uy9qOXZoK0V0?=
 =?utf-8?B?S2JPL01Cd2xTODZENWZodWFGZjdpSk9yd1dOZS9XRGdpdHV0UmhjbE41RDB3?=
 =?utf-8?B?cXJuRU8rR2JXWUpnK3BPdzRsNTJCZTVZWERMM1NLQkVMQXBJV25kMVR4b3hw?=
 =?utf-8?B?dVV2c3hVTnpBT1JpbWVNMkhIRERWMmFkcjlKOHBDNE1lZkdhRmI2V2ZLdlg4?=
 =?utf-8?B?dUtvZ2F5T2pSTGpBZUtZMWRhVG02R3M4R2dOUU1LRm5oQVVSV3FTMVRrbld2?=
 =?utf-8?B?Mm1aNTNWUXpyamwzNmlSZy9mVEI3SU9LcUtyaEIrTExabkJSMXl0enFKNlhK?=
 =?utf-8?B?cWVNVG5yVytHWWd3WWEwd3A3TmdIVWtPTHhRRUNvWDFJbGVRR01SRk12RzVR?=
 =?utf-8?B?ZDlTUktTWVptUzNaRDVibitlN3d0OTllY3JQVk9JNW1UeWtvR1IwU2RaRUt4?=
 =?utf-8?B?MW1udk5CeDlUb1U2c0Q1WmRqOW11M1VrcCtwT3h4VUZRQk5JcndIcitTMUxR?=
 =?utf-8?B?RHNIeFlnV1dCSHpuNE9rdUdwY3pCWCtWNkl5YUtFU0pmdTRrV0FDUjNUdFd5?=
 =?utf-8?B?MWxLSWRNZGdVZjFxdy9sR3dGdjAzekl1anU0SzJ6aGdvajNicnUzTEhzbGcy?=
 =?utf-8?B?a2VPNWV1TjVBd1U5ajg1ZTdraGliRnVCblR1eE5KYmZJdE5LU1RuUHc2TWpj?=
 =?utf-8?B?bkgwOGc0OXp6cDZLYllmUzVHSkVJMjRNYTV1SVBmbm01ZWRhN3o2OTZkR2xE?=
 =?utf-8?B?MnFzNW0vdE1xK1cwUlpnUHZGSk1ZK0dNVHpuWmduVzAyY1VIekp3VlJIQ3I0?=
 =?utf-8?B?VXJtbXZCT1NyRWtXc0tjV1l3eUJ4ZkxucTRpNDJFL2xKeWVaOEEvcFVYaEdU?=
 =?utf-8?Q?AmgxjrDX1d304islCyL1bTR+wuYqDjkvznuCTsXvJyWW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C99D335A01A1EC4C84D43A2503460C26@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ed9e36-679d-48bf-67fe-08db25144fbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 05:15:37.0131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+Wh0vq/eMsFPu0GJcxa04x0ADEy6pVRJO2h7UK9F3diHbH8BoKJvmBfDPHNx2He6GHvkjkTFNpA9sSKKN6tdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230314_221540_803084_0EAE497F 
X-CRM114-Status: UNSURE (   8.95  )
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

T24gMy8xMy8yMDIzIDE6NTYgQU0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IE1ha2Ugc3VyZSB0
aGF0IHdlIGRvbid0IHNvbWVob3cgbWVzcyB1cCB0aGUgd2lyZSBzdHJ1Y3R1cmVzIGluIHRoZSBz
cGVjLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5t
ZT4NCj4gLS0tDQoNClRoYW5rcyBmb3IgZG9pbmcgdGhpcy4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0
YW55YSBLdWxrYXJuaSA8a2tjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

