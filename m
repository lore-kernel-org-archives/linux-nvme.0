Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1870C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 03:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zBhntCIeULN7zK9ofeLT572X2t26zP/6CplYTB/H+oY=; b=KbaCeUUGNk+uut6HrItbMgKMvx
	tAkrDBwDkmRGC6btPN7YCU4HkpZC8+qVFMZMY132ihWvlVrYy4CJCO0ES1rllblHii+ofNlfrLwg9
	qxmV6a3QVDwPlqjvM+5UDpXEy57Y2g+xQ4z+cktFQEi1Pcm5UaIMrgdpwXcoxgEBquWrIKqJShbL7
	6CpNgQinpF005lKdW4ldiWSIU5QfkJVupCENnWjW5mTWwEebjftn5xVWMvm/nSLu3qTaD3CtIuOQk
	UGkinbLfs15u5usIQe1tVu453N6Qr/OSLBouebrp92pm1JEFYJcMwti+VVg24STbEv9b+khZLuRof
	IaZqF+1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oun13-007JOG-9q; Tue, 15 Nov 2022 03:53:41 +0000
Received: from mail-bn7nam10on2041.outbound.protection.outlook.com ([40.107.92.41] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oun10-007JLn-Iu
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 03:53:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0MEeJr2FSnFwXZqFXiaGDtpZOtMuZw3BwGs+ECS2TPycyyK87tSenfcO9dmslAUFbh6BfT9LpY4/8pGywHXrhYPY6JLX4I6cZ1Fk/9m0yfF+6NQ9sE8PQMVO2ZbTcYOkr+lvcpL/5z6XDkmi5AB9ovOsu0kYezEuJEfUnKks9lQe4GSHXBS0FIne1sSqXpslqvZ+e1wC56f9wn+lx2AK2nI8/CgrXsLgMe+N9UkJDNt1sE4W0kHfvENHrLWaAd3JiVnYJplsyPRiY1uaN5VA8FOyxwp6iDAfrwmLR/ih6n0ROFNBZq1znI+atRIPwxDd0I39H1rPL1zqhqe2xtn9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zBhntCIeULN7zK9ofeLT572X2t26zP/6CplYTB/H+oY=;
 b=fS++FXN7qjAfGn98g/MeQZRN/hWUhxH8t23T69RJbzABNxrxzVHhrsM4LCq7SeuVIHjbD+N0Y/nH9Ra8hQ4xfOIVj1U5Le3/srCffI9WwvXCLv7+tOUDtbuJT3SVSDtePrnjP5ckFswbTPiKZMccz7seJNN22l/itjwSF+c4lNwmdE53rnMNoGNxfIC4fXr2iyTYvqgrRtoUYWh6QyZBhJSP2NEAO6d8IhzUoUZW/hkp8lJLaTc4L1sLB3wIaQmH23BvZZXIn0aivCE9/P0H/jVAJ3REauAoJ5eRegx9mMstXhpAAMP96GMniTJFh7sCZPvAMyFxirB5fwCGEGyuHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBhntCIeULN7zK9ofeLT572X2t26zP/6CplYTB/H+oY=;
 b=CJGPaTifYaKqVGNNuRJPmAtA+30ry2stn2hQtyKV8iAt+5x0UvEQ1WGC35BJ37IHADe7CXIYt41X5fnSUrwPAVVV7EiHHgqJAwx2NBhn16SXHK8iAQ1DVqwNXSddC3zy5hwstLLqZ1UZ8KKFn7OJeMjJn+RZa8YP+B0vk8Fv/hGZ3iNYjiVL2OyccrVbQcJrYFisn7aJyAWVRyfXMsRevzyX7wRjpMa7JdqODhLs3KworBdnMd6Wdruu1YQKoAfl53RfdssL+xvrthEwpryCVkcEa97d/4Atsp3hd00wHRKlX8BH6VNTrd14q6buCvkMCUODokSZdI10Cyt++9+tzQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB6144.namprd12.prod.outlook.com (2603:10b6:8:98::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Tue, 15 Nov 2022 03:53:35 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 03:53:35 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Hannes
 Reinecke <hare@suse.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH v2 04/20] nvme-auth: don't re-authenticate if the
 controller is not LIVE
Thread-Topic: [PATCH v2 04/20] nvme-auth: don't re-authenticate if the
 controller is not LIVE
Thread-Index: AQHY91KtyBpnQs+kwkaJN68AYYceWq4/XQaA
Date: Tue, 15 Nov 2022 03:53:35 +0000
Message-ID: <5b24bc65-8339-3ddf-02fc-0797423e8af4@nvidia.com>
References: <20221113112424.1049834-1-sagi@grimberg.me>
 <20221113112424.1049834-5-sagi@grimberg.me>
In-Reply-To: <20221113112424.1049834-5-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB6144:EE_
x-ms-office365-filtering-correlation-id: bcf3954c-fa7a-4aff-f670-08dac6bcf8ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  72Tz40stRwsQCaUnJ2WpjtWkYH3jYb7G4H/sJpsoPXv68CWoQqFy+qwTiA4T9bfMDmfgb1/8BFSyxqJgmwk4uz3q49Isu5CXOW/uiMozifO83wHMjYC8Kfd4j5IlHpBzJtdBWVvf7OVNMO0yv/zyselapImIXLvBrMYOqRwjBqwdV83dqSFHiVo5rcsbg+wl4AQ0It5uj6rRdZ/LXHslnuKITsHnG34APZK3pqFIgTQoNbO/yc3mNKC4jP1hi6vmx0cLr1Yehl4Cib6qyIHUe0/tu2QaNTyXuhm9Z2oJPPDUaP5bb3RxB8scxuYpodbJ1sByKL3H6F38JyYmj0P2/qGMySd453Dp4nO7lbQh2ZTxhHhZNHNJjqUTGB+/QGPJSRBAW/iUwBJTM93OBETrVRL7ooDkbhP2j+23rRqPn4leyK7FXfuJLWPwseOBWdrIyZyg0zG2ZP7IXNP/tp27dBDdtqdHvjjkNyzC2SVJ1hFohld5ORM1alJ+Lyx3iF6O1DjCWz4h1ftokIzwvM0eKGIXp/RWlkh7QgVhwfpakByFyFrKnxxtE9qefYvJBL+omjd7rvkjMzvYEq9vFxsETzF9HaGeeV0rx5XIitZ9Pwbf87f5YpZypKVyGFiR7hv81yX2qazrC0r4oJCmv26bryvljZoDjVcgJT5Wh+9RqLd2/WYOcidTuoZ9oqyTFT7KW6cXmmIkLBssikz0awZIEbjTC4wB/PxkfjVY5wTXguTBob9pfymoAi+oN9afQ5U4OZuntDuxNewNAITFX1FI3BM60MxOhWFCX8rXKKZ4QGyBoHGwzo9h3mY12C89nSf8tvvLAyVZBmQ4N5Xv8zvMYg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(136003)(39860400002)(376002)(451199015)(83380400001)(186003)(2906002)(2616005)(5660300002)(41300700001)(86362001)(38070700005)(31696002)(558084003)(8936002)(38100700002)(122000001)(36756003)(71200400001)(316002)(110136005)(6486002)(76116006)(4326008)(54906003)(66556008)(66946007)(107886003)(91956017)(31686004)(66446008)(6512007)(478600001)(66476007)(6506007)(64756008)(8676002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?amczVC9ZQmhnVHd4RGNDZkZOUHZvbXdqU2w3dzk4ck9UK3Bib3ZhTWQ0ZTVi?=
 =?utf-8?B?WExmY2lzZ2V5Vk1iUWlCcG9JZkxrRDdIT1ZPU09vWGNtSlIzV3Q3YmZHRE0r?=
 =?utf-8?B?dEY4ZUluUVB4TGNUUVNoWjhPUU0rZGgxMElGVHpleVNmTFRNN3hFTVlOcHdz?=
 =?utf-8?B?N2ZRNFZTYko5aXpaeEw5citGWXJ4TytaVkpvbU43UzhxMjB0ajZvcWNzT1U3?=
 =?utf-8?B?bElsbGlpbVV5WXlZTGFGMjA1RndXdVdrWnFKd0JEZkJSd2cwUVBram9LUnNH?=
 =?utf-8?B?eThQNHJ0eURZMERVaGhIS2Y1Q0M4YUV1emZkSmxVSHdyckV2d1BHYUg5Tkpa?=
 =?utf-8?B?UE5TNDBQN01rak9mZWhFeU5ueXVja00rbEhEQmpweU85MXgycW1kWi8vbE80?=
 =?utf-8?B?L0gxdXlSWHREUzFHei9EUkZ5QkQ3b2ZXTzNWc0xCZi92RmlNb3Q2VHEvMS9F?=
 =?utf-8?B?aTJlTEswTkFvckJTOExpOGFVaHhZbVVENmhuZ2dPSVJvMVBpODdRMmJoTUVt?=
 =?utf-8?B?RUswSzkxTVdoT0dOU3M1UXQ0Y3ZUdEpxMk4zaFVzZHRJM1oxUS9tR0VCNWEz?=
 =?utf-8?B?dEluWmxZZ1lKdUtqbGFQVUV1NzNMRmNtcUN0R1V3SVBxRHBrMmNueE1RalBh?=
 =?utf-8?B?cktWUzJ4aTBmb29GQnVLWlhIakFLcUlRL2JOMFYybjkxQkhCeXRVRDBPQWlF?=
 =?utf-8?B?UU1aeFcvSm84dldzRlgwYjlNKzhuVE9WbUxXWU5EQ1RaaVB6QjAwY2R6MmxF?=
 =?utf-8?B?K0JiN2l0WG91aUtmY3VRcHFrYXlJdXFydWdkNzVwMmpnMGtHK0hjZUphV2FO?=
 =?utf-8?B?SlNXeGRKVVcwV211MTQrNFlyWUkxK1FtWjFudktLalRzZ3YycHMrR1NHdncr?=
 =?utf-8?B?NFMvWWQrM1NBOWdORTU3Rm9VY1FtMThqT2RuSnhYWHZNT0J2b1M3R0U0TlVU?=
 =?utf-8?B?QXRROXlvak52MHVXWEJHMnp6RG5IaEU2QVZJdk1CaVVRVGxFMExHSTFzZjY3?=
 =?utf-8?B?WkhYYzhHZ1hVUHJtbTVsSjBxMXZKN3NVNE9aYzZ6MzRkVHdVNFJLZ2x6SUlU?=
 =?utf-8?B?ajlwSG5JTWJ0NU9ndUd1dkQ5L1NPOE05VndubUlPUjdHc0hZNnpaVDQybU1o?=
 =?utf-8?B?LzBDTTdQbXNENmpEVlB6cTl1dzQyTnp3ckdCVk9CbVJRaU1wQjJPUURYOEt2?=
 =?utf-8?B?S2gvWC9TenJUZmJITVR0RW9nMk9EeXNWZEppeU9TdXpqSXBNTWVkczRGQ2lZ?=
 =?utf-8?B?MkhjZGNIZlk5Szhhendxd3Y3K2w3U2tPc0RCWEZuTWFwazBMTW1YampIZGFp?=
 =?utf-8?B?dEtOTFFTKzRIUERDZzQzc1o2S3NQMjQ1dWRwZzdIeTJYSVNHcWdmZVNsVW1m?=
 =?utf-8?B?aTFiNzhGL1Rld1VyQWR3Y3l6aTRzZVk0NXVYVmQyM0hBTHVqRElrRGhEdHFj?=
 =?utf-8?B?UFJ0ZUdoOW9sUXg1Y0xCcWQycHM1Y0huSlhJS2ZBT0ZnRXROUUFwTDVxU2xL?=
 =?utf-8?B?cWFycFFOZnR3ZEJaMVdwNFlDNGxiTDdRWGdnbi9wd05EckdFWUtQRGUzUDRN?=
 =?utf-8?B?amFQNnVlQklDQVRPeG80amlCZzFjVDgwNkM2a1FRQVpDc3ZJcnVMOGU3OERE?=
 =?utf-8?B?ZmxlaG9qQ3k0N3VKN2dvVG8vWS96cWw4SndFTlpBdndYWjI0RFI3ZzBacnJx?=
 =?utf-8?B?RnJJZnE1QVl2QUE2RklhTmM1aUZTRS9wM040NlQrQ0VPeHNrY0hCdmZIRW9x?=
 =?utf-8?B?eHluWVFVcDVsSFdmVG1PVUpYWGN3YXdGSWVIZ291bW83VmI3U3Q1V1FvYmhT?=
 =?utf-8?B?L0Y4UEJqaVduMjA3aEZ6UjdueTJieVUzajFsTTVRRGkzRTZCd2JYeU1FK3ha?=
 =?utf-8?B?aUVYTCtIZlp4SVpleVBWeC9Hc2RLYmFYcU9MR3NCQVJGU3VPNytZMkRUZkNi?=
 =?utf-8?B?b1R5aXdrc0xpOUozNWNOVXlEY1MvS2QreTBxZVFoZGhqUVBKWEF0SFVQSlRK?=
 =?utf-8?B?cFNyT1laNzliUmU0SlRuRWN2UDVIVk5oVjlDV1UvQ1d3ampiSkQ2aVRheG1K?=
 =?utf-8?B?YzJmVWxFbXJvZ0RRVSt2RWRQUWRGMGMyVFlHT2U0YnlBb05vZ2h5QmRBYnNW?=
 =?utf-8?B?TDJwdXdEbEV0eUZxNE9NUGJETnI4aTQyU2UzRFVabXNveVRyd2J2cC9XVGZ5?=
 =?utf-8?Q?1K0KbVWabssNIXQqDiT1aEDzJRj52+Gtrt6vmlgWOjv5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E23CED7CF1883E4E84854FFB4C95C1DA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf3954c-fa7a-4aff-f670-08dac6bcf8ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 03:53:35.4557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9m0Y7nJZ5KxkbjgSq//5MLmfXMF3v4napDKRmKm7G3r+cya5D9BNK0XrANvCVAhFeW9I0yIzCh1lBMRlPy4VLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6144
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_195338_685163_D7A7371F 
X-CRM114-Status: GOOD (  10.20  )
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

T24gMTEvMTMvMjIgMDM6MjQsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IFRoZSBjb25uZWN0IHNl
cXVlbmNlIHdpbGwgcmUtYXV0aGVudGljYXRlLg0KPiANCj4gUmV2aWV3ZWQtYnk6IEhhbm5lcyBS
ZWluZWNrZSA8aGFyZUBzdXNlLmRlPg0KPiBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxz
YWdpQGdyaW1iZXJnLm1lPg0KPiAtLS0NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENo
YWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

