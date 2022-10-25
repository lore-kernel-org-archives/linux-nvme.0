Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4157C38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 17:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JRZlRI2ThJp++jyWzzOcWB+k7QATphZRtuQ9Gxprhsk=; b=g4FTjAlbbtyDstXFang/x56K+E
	fpTARutYI6FZqIKpku2E9acwnVdsfxNxCB0KZjhosdE9/mu8ahLFWcupXTyidyfWL3OvlsWgrv0zI
	Nb6IpWpFXweOfFMOniIqs8kJcwT6UJQ+9hZYrAVe2OSICxnoDsr6EuPsRRXbUJp5n5QoDGeteoM0E
	Bc1TIynG1CgDDeyCCixtj265L07PzjXQbE1JKI/vJY6erqnZUbVe+B0haiXrkM8DW0KPGK9iZDVkt
	BK2Miem4lZvyzhFDafxRONmjS2iZPm0+51EOdt2oOvbdxXMRDLHHvS0ERamJycwdUobG1s6TV72k2
	wADmBrlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onNpR-006V6Q-C0; Tue, 25 Oct 2022 17:35:05 +0000
Received: from mail-sn1anam02on2079.outbound.protection.outlook.com ([40.107.96.79] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onNpO-006V4t-Mu
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 17:35:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEg5uqEafXbL/WdCuNXvqk0IrvTn7mJHLFrSSv9BVHb8e7S+kH9uj3n75urVv7dZc5RRF/lRvPaPB5SrgYbaWJ6/CrrbTUDUSuU6wSYOGliGw2JnoDolRkLszSMHN1wbcZLHiz83KRdcsixW2jUx1Fmw7xh/Yh5uYd1VtN83ZZmQrCKidD50rRxW8uHMHSq6gTB2Dq6qW3TSsBbqLmvsdm1/82okhXuuDzNMAFFyJt/Lc4mwCDDHTPYULeZQ/Jq8iZU4rb3U3m2bJMJFRnhoWLvNqDuc7PgqNylwCvqsvsYCt55mRSs+kjDJNfv4Lu7HFdofMiOWeef8lGji3sEFaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRZlRI2ThJp++jyWzzOcWB+k7QATphZRtuQ9Gxprhsk=;
 b=U7S5rLOPNEb6W+8j5lBTcQoSYGC7LK85KaF1GST4FooeszD5r8QiKVyxJ+cSfTPjueLk6KEplX1D1OikdJc5WP+EqTNDGHWqUk5XmjKYqAly8gCdqhf8eCkYSZxA/rzfTy7bqrOrn2tWzRP04n3tUsg+5D/aB/DCT7ekU8K/fkmQwJo/K2WjYIyhUMvyLKuZUvhTS8crgGN+1u/Lt16m65bV+0w7+bRBfV96LP2cHu4iJEHk65eJ6d+9qfVUSL0CBkAOXFXD03/IqbAtR5GqXIUjrOcIbCB2GPR+/H/k//wLAe2KVM2zRcfvlFAk/dJragK2XITEM5SwHS3z3qT0ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRZlRI2ThJp++jyWzzOcWB+k7QATphZRtuQ9Gxprhsk=;
 b=sGy2c709wSPKvC4YQNAhCGzq+DVp1w/UchRTjFV3vC+oJkapdHNuaooTRH63Rty8QJqhUXJfvnO2vib0OecCu3jQRMkCL5u0FfIdcfluhIPXXVzsQcY+2Ap8iCYIvsnb20sntHjhDNicikWv6wjQRzYFRNqp0tTS+G5tmoZS8VQsya7BPQkLIAXw51W6ZBxx70+KSOZGIJQ50qlPYwIU18tQ84mIgCoCMHs3hG0RgJvLMVS1QV0SOO1iTXcLxFAJxaUlm3FebnPJMI04B5dhTNaWmq5LJlQO0sNNUZ7E9xFf/R/AsBwhr4EsXMsJGmGaIJbeyZFNTjc5NnDe/1/YGg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB4520.namprd12.prod.outlook.com (2603:10b6:208:26f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 17:34:58 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5746.028; Tue, 25 Oct 2022
 17:34:58 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/6] nvme-auth: remove symbol export from nvme_auth_reset
Thread-Topic: [PATCH 2/6] nvme-auth: remove symbol export from nvme_auth_reset
Thread-Index: AQHY6Hf33HnFUsyvI0a+B0iL8BGILq4fX0OA
Date: Tue, 25 Oct 2022 17:34:58 +0000
Message-ID: <2e9e321e-7da0-20d0-4ab5-1ef4e4a5e8d0@nvidia.com>
References: <20221025134330.1028352-1-sagi@grimberg.me>
 <20221025134330.1028352-3-sagi@grimberg.me>
In-Reply-To: <20221025134330.1028352-3-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MN2PR12MB4520:EE_
x-ms-office365-filtering-correlation-id: 8e295917-ed17-4f2c-32b2-08dab6af3ccb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  l9fbAS87y6AB+VBECJC4DvdgszexnM7q6kSzpTg4BETbmoL6xLNSKWdd0LtL5vzTCDVdOkT80GXRqQH1A6jYJ/R3tLa8bmqSUJRV3+PdeuhzpJl66mBPiXfeMlX/dHPWiIwYVAPE/q0Owf2Ebmz7HySJW5Obd8h1dPSt4f1a82/5KnNvB2CS4iiFVQfei0nJkdzOY57erAfz+X0yf75YjXgF3gRKkO3wdbz6sHKt10W0CfK9Unrb/isRI5lOjigRb9DlO7hOC450k1btoU88N3FxCsM4Ev9nt05Ei0WTGAvO4PdzgPvSVtQQA2MtnI/8VHYwM79PddFUPPAvyZMSdNnrZE1TcUey0BMXWrVlgfu/9BWfvBXgePszBoOGNjG2i+nAEBSzhsR/+cTZdH31ZxkNVNe3RUfM734T0x0ObgZ4K89vjZ7+IRYyKhYqP+htcsp8dZu1yEA9EsLxvvyHd+8N5S/Gl3SMWxdf1GHnrDrpWuUnNGG53qb6JzDnDaPN8VY5gb2XboKOQ8tIZhMXLmlIz4rMaD8Y7DzPblaPazZUbzXtliTE5zG3OayWAr4wDGgb0kftqtP5lmB9RfvhCiTTYBu++/qd87HOLhD9ajqJNpwYN/cargo1NAlpj3B//HuOAQ7XOPyxGkONckYhiTA/81GnSHeR9CilcgxF1BmK1ILFUsHYABX78DdavEm508oVG+wewp8oCssWBLjkva+AlHAQCFBEkUvixq849ZG4C7E3oD/nN++mkQ1lMnV17TJ+P3UvDY4Kx8zI6AiAmiU40jBbAulIl9+T8A2Y+8GDPpN9LpPEF55yiMeN+PAjiS/YmqFvEJfLoRNWdgoftQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199015)(31696002)(86362001)(36756003)(558084003)(31686004)(38070700005)(38100700002)(122000001)(2906002)(8936002)(5660300002)(6512007)(26005)(2616005)(186003)(53546011)(6506007)(66556008)(110136005)(54906003)(66946007)(71200400001)(316002)(91956017)(64756008)(8676002)(76116006)(66476007)(41300700001)(66446008)(4326008)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?cGFxTzdhYU1jbkdzKzFJeXQ4TC9POXUxdk5MTm5Kd2FEeUQyQXhwQTg2TklQ?=
 =?utf-8?B?a25YR3FHOGZERURDSkt0eTVqM2xQcFM4eTh3QUladWwySklXM2FzTnpXKzg1?=
 =?utf-8?B?a3U1SndHVnlRVmowQXhBQkI3SjQ5aEJyamYyT25aNm1kYlFWVnBUUVU3Tm1o?=
 =?utf-8?B?TWxhMFMxaXJheW56dTk0MFlIRWFHWUN4N1p6RzlLcVpFdXRnR3FkdGVMcElE?=
 =?utf-8?B?dmptK1ZuWFBCTmVqb3pYMjN4S0RTTkJ1SWJtNGxZdXZpcGNrN1NQV1ZGZi9l?=
 =?utf-8?B?a3dhVTFvbzBEVE5RdVlpeHhwYU1hRWNTejFWdzQ1Zm1kQS9YaHNoemEvclRl?=
 =?utf-8?B?cGJ6eGtLQklHRVAzZlFGQW1uNG5Ec2xNRzlBc1VuRDA2emFRNHhJWjRuUGd0?=
 =?utf-8?B?bFFUaDAyOWZwVE1XcnlUb3g0YVNPY0IraFp0UXVETHNMODFrZ3JwYlRpdTVt?=
 =?utf-8?B?UmZaMVIvSElEaWlVWVFtdThQUWxCQ1lrOFEwNzY1NklIWE10aG91UU1STFRi?=
 =?utf-8?B?NTlYUlJ6QjlmSVdoYlRvS2Q3WFR1ZDM1TjVXMU44U3dDMGFnV2V2MWlkUXBF?=
 =?utf-8?B?MUJVdTFhQ3ozVmJTb2xZcTg4QnJTdldMRjFMcldSVVpwbkx0S1d1eHR5NEY5?=
 =?utf-8?B?bit5cTU2QzhoajlUczZJWEhScUFUZ0ZKWk4weHNEelhSMm5MaXJpR2F5bmdO?=
 =?utf-8?B?QWVNR2RWUnFZZjlTOG02VlZRazRDR1FXS2FVSTErNW5tZUlha3RubmlOeWUw?=
 =?utf-8?B?SHBRYlUrcWdWbDB3RTlvZDgwV2JuZTVXekphTkIrOCs3WEIxdmFiL2EvY1Rx?=
 =?utf-8?B?T0Z4WllUeDZ3blFjbG8zOTFUS2huVjhYRnUySllMWVoyT0NEN3BWa3Nvb2Q4?=
 =?utf-8?B?MndRZXJQVDR3cTNhaklpVzV4cFYyU1FqV0NWT1kyVGo1NXlGN2N2S29obVE3?=
 =?utf-8?B?SU9BSUVTUm0vV3ZWY3NIVkpMVXFVdEcwYksraHczY3pBSjRJbVBsR0xWM3Nh?=
 =?utf-8?B?d3RaOWw5TTRxVVBuVXZDQ2JiU0Y2N21XSmNyY0FRaEp0amtPcWd1c1ZTQmJX?=
 =?utf-8?B?Y3FNOEs2SWptUC9IYlhiTDdic0VqYjQ2OExjV2FyQ0tJNmFpaHVNZ3RpWDFx?=
 =?utf-8?B?bWRhQ3B6ZWFvTk9LaE5UVjF6dlB2Zm8rczdHSDhERFJFdm5rREQ1OUFWaG1m?=
 =?utf-8?B?MTJFbjF5WXcwQ05oK0g2UTI5ZlhEWnJoUUwxR3lFM3dVMVlTRnZMYUNYVEwx?=
 =?utf-8?B?Yi9sU3RHU2dYVlNMSExIOFNCTzhoK1RBZEdYOUpGdERvbStucGNSbjhCN1ZT?=
 =?utf-8?B?SmEzRjFtUXU1NFZFSDd2L2JFNERpODV5MDVwM21QcXFUUnJWZ28rUVFNNlEz?=
 =?utf-8?B?UWFKK0RnZW5ZZzlwUmg2R2ZxVmhKN2Q0MFNqZlhGVTJ5RjZ1RmYraFNZdjQv?=
 =?utf-8?B?Kzg4cmxMS21OcHdhdkNDdndPbEZGS3hQbHd5L2liaVZQRThUWDgxaXZneFR3?=
 =?utf-8?B?VUQ0cUp4RVNjeUlmTFk3djBLT2VnRFNFdFc3WlZDSjlJblk3SXYyb3ZJYU5D?=
 =?utf-8?B?Y0Q2Q2p6eE5ydFRaWWk0UUl6ODRhc2ltYjFJUXNXMGFocXlYRmZUdks3Sld3?=
 =?utf-8?B?bmJ3dnlSUzg2bDlCTHlhMms3d2lXblVZSjh0WHFGcm9sYTc3dUgyVGhxUzFu?=
 =?utf-8?B?bVQ1eGkxeStYRHlmVjhYdk5rVEhxQzgyYk1sZ2didUlYTFd5VExNeGljZ0Qw?=
 =?utf-8?B?WWswcG96U085MGJqOGE5THQxS2JrdE9vYk9TVXVOTDhJN0tUV3dyS09HSmkx?=
 =?utf-8?B?T2dmSlNDbDlQc25jbVd6Yy9JeFBvRFFhSmV2VER3VXhtblN5SCt1dm9kYnZY?=
 =?utf-8?B?V3FjcHorb2o4MWFJbCt3aS9sbDRuT29Xc2lHQ3JGY3I2NU84bnNIdUY1Ti9R?=
 =?utf-8?B?ZHNkUy9XTzRmaVRMTmV6L1lXT1hkbXFOdHlsU2ZUTDFaZzIxb1kvWTFzZElP?=
 =?utf-8?B?c1Z3bDVpREptajNHa2NvajlSelNsK0lZV0xiSDFNMWhOYi9nK0tVSVRsblha?=
 =?utf-8?B?MUpJRUw3V2NHMkRpbHN2K3dsLzN3ZnRtL3REaHREZ0UxcjdQSXVDVEpVS0F4?=
 =?utf-8?Q?uBz2Em4KwccC2Pq4EFa91VMIi?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <586942832A62C440ADFD7AAA4C9B8FBA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e295917-ed17-4f2c-32b2-08dab6af3ccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 17:34:58.1515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yk/amq+lH9djYthl/nymkMvUIdMfy/iHtowUNGWz9SVr22yNYqaCQxXspA3h6asyrnjCucCRKFTwq31GTIB6DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4520
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_103502_779282_D4EB1D58 
X-CRM114-Status: UNSURE (   8.16  )
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

T24gMTAvMjUvMjAyMiA2OjQzIEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0KPiBPbmx5IHRoZSBu
dm1lIG1vZHVsZSBjYWxscyBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNhZ2kgR3JpbWJlcmcg
PHNhZ2lAZ3JpbWJlcmcubWU+DQo+IC0tLQ0KDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vs
a2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

