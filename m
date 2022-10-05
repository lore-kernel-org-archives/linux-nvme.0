Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EBDC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Oct 2022 03:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z0/7fron8oAit1LAQ3CxjMMyBcpleOdiz5D3RUPdQL0=; b=nvK+oSPpNA9ECUZGsClLc2myPa
	knwe+nMsrH2YeYEVbPSPbtv/94dx6Pd+HF1u+S3/IhWCgu9NOQv78QWK6fYbWmjD7KzUk8xtMtM8T
	9sj0jl8iyc7mrE9o8yNuj2NVsxBCvWK+8oemDo9NJSuG5I6dnnucSbw3smYr3RRcl4VSlCJ13Ccfi
	+kIiZVKzrKXYBICRgdij4BVUxhHl35rikWOyWGmc3OZsbcpuVk2XykyXKP9DZjmhl4kDwsyY08tfg
	+DCFp+y0dvpKp+psFAVvWE4M0YFJGbBSgIzCaPnKXgNRcGW+SI8JFNIptNJCRQH0aJzJAEzRa5vh/
	NIcC7wmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofvJS-00CGL0-Ew; Wed, 05 Oct 2022 03:43:14 +0000
Received: from mail-dm6nam10on2042.outbound.protection.outlook.com ([40.107.93.42] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofvJP-00CGKQ-RO
	for linux-nvme@lists.infradead.org; Wed, 05 Oct 2022 03:43:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncmdHDvjvY9vOWWcTyGPJdpV3vr2mdovxb1Ulw5wDXAFa2HmNVfvbE2F2nAqrwsfho2sFFKPJYlyfXSpX401bYoDKATUtO6ikpyeKrcJc9tuaKEEsmsarV7KqU2IXRcE7g6wBa+G8b7fzD/XoUVdYEMbln1+C/5eqfNc8M3GpB9tTGkvUF/USqOCX2qfrYxkPd5Tbc0Kj2L9nyu/psufa49HFPD9NCDab9w1EAB/ZSxx6X0G/+6lJKtgx5m00XPasCCMtgCMgEfLaDRh8j8YVN0x3YzpsaRyR0pcDMra0gHDNm/Q4kqpCYODiOWl4MJWMPQpMENXZH6zBvx/odlL1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0/7fron8oAit1LAQ3CxjMMyBcpleOdiz5D3RUPdQL0=;
 b=GwkQ+rBLg6sDAtMc5XCBKaSLgw5TLZndnqT8HR8+zszOTmifHpgShq/BNGDLKrk5tNZVuCufNktns+JQHGrTShSci5/rcDqNCAeOKpryYgxME8e5vR0WPEUU0CnljMhjsMJT/F63yJzNttiHoPjti2a15Ho/8tSRSc2U8C9wXvA/caB3Kbro7+6Pn76qmeiAbIvTigd7KrIazKIiWLrpuxARUNI0CLyz9j26T/PV03pxvUbILJ0PgEPbmQMS3+d8jRVkMRa7XrmlhOYwjN7o6dj25UPpMULNC7z7b4fhJcB+X1Pzik4vX3xPAJlho6FQ828DzakUE96w5aMbZJYKwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0/7fron8oAit1LAQ3CxjMMyBcpleOdiz5D3RUPdQL0=;
 b=a4mU9zTyOJdnijB6WP8WBUDXkxyMkHX30y7g3t9N1GMn3WzAk4Zowpt7jD5ROdp2RDcVqdVdyVTlTM3F3TpGR6e6uin0Y4/7Pk7/mnFVoDKVWS7qcYtL62Rjtak+9exqn4dZv8uV++uIZrNiwKVOgEiZ3hMepp90xU3D5ZXsWxxNNC9G7SM6sBndxgpoXTXWxBHuwoKRq6q5Z5RbdgBK286u/9kiO/aLpxIdY6sFL9cTGZdaIjUICwjBG0Fe2a/W2YkWG82SKpVbAO6CKn+o/DFPK0rbSbHSxYBNUf0sNsh015vALJ+n8HeckIvJmxr+oKxwYTKRfj591wveSiIaAQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY5PR12MB6225.namprd12.prod.outlook.com (2603:10b6:930:23::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Wed, 5 Oct
 2022 03:43:06 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5676.028; Wed, 5 Oct 2022
 03:43:05 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Xi Ruoyao <xry111@xry111.site>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Jens Axboe
	<axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>, Ning Wang
	<ningwang35@outlook.com>, Chang Feng <flukehn@gmail.com>
Subject: Re: [PATCH] nvme-pci: avoid the deepest sleep state on ZHITAI
 TiPro5000 SSDs
Thread-Topic: [PATCH] nvme-pci: avoid the deepest sleep state on ZHITAI
 TiPro5000 SSDs
Thread-Index: AQHY0x9qF3kcgnqtqkyrQZkiYwMnWa3/MuiA
Date: Wed, 5 Oct 2022 03:43:05 +0000
Message-ID: <82fa489d-a14b-58d9-7bd9-67418a02a0d3@nvidia.com>
References: <20220928093913.45905-1-xry111@xry111.site>
In-Reply-To: <20220928093913.45905-1-xry111@xry111.site>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY5PR12MB6225:EE_
x-ms-office365-filtering-correlation-id: e50fb10f-7fed-4fa1-63c7-08daa683b65a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  Uaq6xODdHdjzm7dGVLvYpL9boQDCA5Xee/rmj/8t0QDq1MX7xVXHTaxuEoOIFZ3VMqryBrCmkNOBfcV4rnIuXVXyQV8+dG8mat5GvDvQPr/6hsFhmrKwPdXskncj2bz7RIWPwd2/iDpDqunSybrtMW6KRB7JsZW3qPquvpp9nqFVyG0XLBVxYWYRkT79bjq/LGWXNU+WUjaZtjWhvnr3Ky40z6ia+G4hKS2haLkCX21mYZo6E+z7j6wIQmr7q1qBZrA0xtypq9C4OQhHFj9+prSbjDl/KhjsfrveClzGnobT5tnonyvYz5oWIDHu6mmUiE8C2dX7AYn06IkRQZhveKoyOAe0aTzPm0eXhhrOqTkxH4r0SpGvcPjCaWVKZy1tS3jpz6g6l+I+rBZu1pU4eKNc5SddReJHb21yAkXERsSTiHH1LGQlBHl/Pdnm5ftQfkUT2Zq/pFpyF6VPnwoaR8Mf47E3SKht3I/V3Bo8kOD9t6SGkmSXSFMF2yHlPNX4lUpxBisUnfXLsYkmNa2E2p1wkdUDmraDnCaLntHP1JTRoc0fB2U8mdaI9akMhPUG1fCXOPlTc7AMFQ0BvZUSmPTpUj7xe4MfKPWDDTC1H9tmFUqiXhU5zEMrERT1vl9HDVhJxKr/MYbr4RK95Ii8QcCBikUVoFlEjOXHVoKnkJ1QDmqs13N5YZOXHNB0PAsWDZ1eQqLQXCBKigLyJihSGeiRxmmQggu3rgSYI5Yqlo2tGsyTZQovX5hc8nDOtPk9FbdYq+boXU56TGMKZg7EZoB5yeo2E3Ttg55tgxys9y3yiz9RzxYNa/qplVWtYbsqzTBV+VghvfOtRaDBTDBZCw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(6029001)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199015)(31686004)(5660300002)(2906002)(41300700001)(8936002)(71200400001)(36756003)(478600001)(316002)(6486002)(38100700002)(86362001)(31696002)(91956017)(76116006)(122000001)(8676002)(2616005)(4326008)(66446008)(64756008)(6506007)(66556008)(66476007)(6512007)(110136005)(53546011)(38070700005)(54906003)(66946007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?S1ZMYnUrTjh6ZEtlWHZIdnBNRTlITkhJV2Z4aWFESHBZODBWT2E0bldydm1q?=
 =?utf-8?B?TWkvSDhneHk0N2dOQ2pYcEozaXR1T21HK0ZEQitjTTBoMTZ5cXFTeEUxcUlF?=
 =?utf-8?B?cTlUUlFyT05HamRpUHpERllLUUY5cHdVSlR5YkNkMGR0Qmt3bVFzc01MMFRV?=
 =?utf-8?B?MVAvWUIwbXBpcGttWURyKzVMbzBlbEE2cmZwMGVYSUx6R2pMbndBUUM5K0VC?=
 =?utf-8?B?d0tmREVyNlRtUi94bTk4WENyM3Jnb1RxMnNrRXNtVk5MNEhJS2szaXhBY2hB?=
 =?utf-8?B?b016YkVBWWZucXBjaGVLbm00Z3I2bStoOFdKbzIzcHV6Y1VWaTgrSDl4L1Ev?=
 =?utf-8?B?R05kYkoxVGE3Z0Q5WWx1UjRQNjRXQUhqalFOcHBNeExYc0xMUUxJR0hYUTMr?=
 =?utf-8?B?M01OODZVb01nNHEyTDA2d0QyUkJBMktvekV6VW1zV0JTMEFyTEp1RmR3c09t?=
 =?utf-8?B?Yy81WFFQMzQ1ZVVwNytkdkRrczZnbWNEb3NxRnpyakhXUkx3cXU1Q0JzMnl6?=
 =?utf-8?B?a3BrQmFCcnNTVXJpa3djZ1JISzJPWFlLV0RZZTJjTlM1RkUvSGFpQkZBdE1z?=
 =?utf-8?B?RW9Ob2hlNC9kTm9iQXY3cFJGT0RRQ3Y0SFN3T2w1ZGdTajYzMkZ0bGhpanRB?=
 =?utf-8?B?M0ttclNkZnBzYkdhUkNUNlVRL0FGNWk5ZFd5V0l2a2JwckN3M1MyNWFBOGFL?=
 =?utf-8?B?eHZ5VDdzMk52emJUZU5rWVhuN1lHUnp5STJEc2Z1ZlIzSjdRMExsck9qeGs1?=
 =?utf-8?B?NXh1Nnhhck1qaDhPMEhLRnhXd2Q5L0MwTm1Ta1RUMFJ0NXFhSUVxeEhObFdE?=
 =?utf-8?B?am8wTk9IL2FTTXVRQ0xydHJ1V0RhYnk4ZU1KU3hZUmhrZDMvS1dTdi9na1Rv?=
 =?utf-8?B?YW1KaG9BNmdONXVpalhLVHdSUytBSEFhaW93RGF2SU1qUUtCTkdTTkVZUU44?=
 =?utf-8?B?Ujk1dVFtWHpkZ3ZiMkVpZ25ZVWdZTDZmOXQ0YU8vTFpUdGRuOUVZcWE4WnJq?=
 =?utf-8?B?dG1VVFlNZDcyMmNCYmx3bjVVZnk1R0FpTUtNbVNaSHVUTFBoS25RS2RaQko0?=
 =?utf-8?B?U3N2RlpnUmdENHcxRE0xWGRVbjFpVDh3MFJWaWN1b1JmQmFEWmZXU0N3SjJF?=
 =?utf-8?B?alpnZCtySkZUR3EyYVdza0tkbUFQSUw0c0RNd0ozRG5nQmlsaWdIejNabVVE?=
 =?utf-8?B?am56SGFudklKc09VZ3REK0ZNZDJxdzhIZDJKYzhKS2RNdnUzUnJHalBTL3c0?=
 =?utf-8?B?a0x4UDVNekdvdExuZW53K2l2c0tmYzMxdTdUNlllS3NzbnZxd1NvMWovN1Bh?=
 =?utf-8?B?aGE0OW8zcmc2aWFPWGcxWnh5dUl0ME1hQmdkK2QzdjhxK0tsc0JnUys0eThI?=
 =?utf-8?B?T3U5TTZmdFBPWkNkcVV1Yi8xK1FoY3dXdVhnUFRjLzlmbnFkaGN2WWtIM1dm?=
 =?utf-8?B?ZlVnMmJoWnYzZm85SHF4QjZzc0lWOEJpL1hxWUtoM1NXRENDNXAvbHpmaTVE?=
 =?utf-8?B?V0h0aU1zZ0lNQlBpUy80b1ZBN0RQazZGbjYzYk5EQVdTMXZJMVNLV0k4L0hl?=
 =?utf-8?B?SGpZdm1mM3BwU2YvOHF3Smp1RlkzN2FwVnJReFNneG9ZTVZacFNjWFAxaVY2?=
 =?utf-8?B?Vlc0UTlyc0F2eGhvWkZrb01UTFNoUTZUWDNFWFVCWjV3VmFCM3FPQnRBK1Z1?=
 =?utf-8?B?cmRZTXJycXl2citGOC9jTzRPVzdZTjIxbFA1cm1JN1dwZ2pMa295dmFOVlJa?=
 =?utf-8?B?eU01YnhZcEtyZmdKZi9rV0RscTgxOWtQNE1OanpNcmVVcy9MbC85QzBTYnhK?=
 =?utf-8?B?a0VXQllvODdMVFJDT0NjK1l4OU4xR29qa0RlaVB6Ym0wQmlTK3BSamM2ZmUr?=
 =?utf-8?B?am1HNzFzQmNBS092cUU3NExLRG9wQ2t4OERpVE1DWmdPVitaejkwZnBaTjQ4?=
 =?utf-8?B?eEFTUGhpS1hPWnhCR0Ura1oxeVJ3bFRVMS81b3lxRXQ0NGZNLzFOL1JWQUV5?=
 =?utf-8?B?VmhVdHAvRTZHNkZHUEN6eHRpb3lWcWxvQkhmYWZRVThFMTVQTEVraXk4NXNi?=
 =?utf-8?B?T3pCUTlGSzlRSVhLOG9ETXNibTBiZ1QxYUNRcWlJOUNYVDQ3MlBpOXFWWGND?=
 =?utf-8?B?MXgvNVZubVd3aWR3Zk1keVA2YUxkRlB2TEcyb1VsdENlUUYyRmUya0hMMVJR?=
 =?utf-8?Q?RrB2n68DcKicTcuTfkn1ayHa5x8+oBkA2w8LaZGcFtrA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AE5BE78CBB7284D9A0EC778F10E94B4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50fb10f-7fed-4fa1-63c7-08daa683b65a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 03:43:05.6493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pbvUQN1D2U0xFB5CZGpaQJzf3AINWOHnHrpv7CSaGcnoYUYprobfAt+Eosk35i7P4wkcPjva6o/ylnDjEeJenA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6225
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221004_204311_907226_097D891F 
X-CRM114-Status: GOOD (  10.32  )
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

T24gOS8yOC8yMiAwMjozOSwgWGkgUnVveWFvIHdyb3RlOg0KPiBaSElUQUkgVGlQcm81MDAwIFNT
RHMgaGFzIHRoZSBzYW1lIEFQU1Qgc2xlZXAgcHJvYmxlbSBhcyBpdHMgY291c2luLA0KPiBUaVBy
bzcwMDAuICBUaGUgcXVpcmsgZm9yIFRpUHJvNzAwMCBoYXMgYmVlbiBhZGRlZCBpbg0KPiBjb21t
aXQgNmI5NjFiY2U1MGU0ICgibnZtZS1wY2k6IGF2b2lkIHRoZSBkZWVwZXN0IHNsZWVwIHN0YXRl
IG9uDQo+IFpISVRBSSBUaVBybzcwMDAgU1NEcyIpLCB1c2UgdGhlIHNhbWUgcXVpcmsgZm9yIFRp
UHJvNTAwMC4NCj4gDQo+IFRoZSBBU1BUIGRhdGEgZnJvbSAibnZtZSBpZC1jdHJsIC9kZXYvbnZt
ZTEiOg0KPiANCj4gdmlkICAgICAgIDogMHgxZTQ5DQo+IHNzdmlkICAgICA6IDB4MWU0OQ0KPiBz
biAgICAgICAgOiBaVEEyMVQwS0EyMjI3MzA0TE0NCj4gbW4gICAgICAgIDogWkhJVEFJIFRpUGx1
czUwMDAgMVRCDQo+IGZyICAgICAgICA6IFpUQTA5MTM5DQo+IFsuLi5dDQo+IHBzICAgIDAgOiBt
cDo2LjUwVyBvcGVyYXRpb25hbCBlbmxhdDowIGV4bGF0OjAgcnJ0OjAgcnJsOjANCj4gICAgICAg
ICAgIHJ3dDowIHJ3bDowIGlkbGVfcG93ZXI6LSBhY3RpdmVfcG93ZXI6LQ0KPiBwcyAgICAxIDog
bXA6NS44MFcgb3BlcmF0aW9uYWwgZW5sYXQ6MCBleGxhdDowIHJydDoxIHJybDoxDQo+ICAgICAg
ICAgICByd3Q6MSByd2w6MSBpZGxlX3Bvd2VyOi0gYWN0aXZlX3Bvd2VyOi0NCj4gcHMgICAgMiA6
IG1wOjMuNjBXIG9wZXJhdGlvbmFsIGVubGF0OjAgZXhsYXQ6MCBycnQ6MiBycmw6Mg0KPiAgICAg
ICAgICAgcnd0OjIgcndsOjIgaWRsZV9wb3dlcjotIGFjdGl2ZV9wb3dlcjotDQo+IHBzICAgIDMg
OiBtcDowLjA1MDBXIG5vbi1vcGVyYXRpb25hbCBlbmxhdDo1MDAwIGV4bGF0OjEwMDAwIHJydDoz
IHJybDozDQo+ICAgICAgICAgICByd3Q6MyByd2w6MyBpZGxlX3Bvd2VyOi0gYWN0aXZlX3Bvd2Vy
Oi0NCj4gcHMgICAgNCA6IG1wOjAuMDAyNVcgbm9uLW9wZXJhdGlvbmFsIGVubGF0OjgwMDAgZXhs
YXQ6NDUwMDAgcnJ0OjQgcnJsOjQNCj4gICAgICAgICAgIHJ3dDo0IHJ3bDo0IGlkbGVfcG93ZXI6
LSBhY3RpdmVfcG93ZXI6LQ0KPiANCj4gUmVwb3J0ZWQtYW5kLXRlc3RlZC1ieTogQ2hhbmcgRmVu
ZyA8Zmx1a2VobkBnbWFpbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFhpIFJ1b3lhbyA8eHJ5MTEx
QHhyeTExMS5zaXRlPg0KDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEg
S3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

