Return-Path: <SRS0=Nr0d=N6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28477C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Sep 2021 08:09:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0EBC61131
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Sep 2021 08:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E0EBC61131
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D1c3jo2CGQ+Gdche3QTZPYfX0ur0fZtFiXAj1w2yYOc=; b=K4Zhvi5Cl8Mg8M
	xMOWiFhGNC2LFrGG1hbGjQHPNm6P3UNjUHZz/jrMJO7fp3p9RwIUJhxkF6c2jU/9khoH/3CEmAybW
	ubxRZherJSHPZinkVrKdYuoBeeh7faTsOrCdvocPPxW0hMBQ+zQf3oXTui28yl0+AblouBf1qu23m
	RLu1yJ66X9TH3hafNynToZTougdPtE6LwdHyUQde9PCp9tWqQkA35KJ9+LCRlbnJbDhre3l5j7KBc
	4098crMfiom8zDQ3DAkCGTW9rLBMPe2npGvpz5cAyByqHZtwDwbuN++EvpEOtkKDJrBgr7QRQeeVn
	KzWGO8BE5Yx7qFZfsIsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mNsdL-00653C-NB; Wed, 08 Sep 2021 08:08:39 +0000
Received: from mail-dm6nam12on2067.outbound.protection.outlook.com
 ([40.107.243.67] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mNsSj-0061gq-PY
 for linux-nvme@lists.infradead.org; Wed, 08 Sep 2021 07:57:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0rFNIyADbdeQ9LjaqBlD7YySQ2c8O5f2GqE3A2HLRfdqh0Ja/xh9ZZgbc04fUTYXfznP9jdKvdXB3UPdr2p0J6MvY6Cftmtf7vnnYulBOlbLopW6udpK7YGK7tErInW3wtlfi1ZN5dI87RlFozO30xU/4fOaMNIhMkHZsgkPUZ822qxe7sLYZFeuQ5PYzjurpwKGdFoQ9EGCwN3Tmz/8sYPcia8yUcmfyYaztlu9PCCfdwGgrusJ90zA6ND+pgR0MdCcChP3Lut7OIYyJRHkAxDPE95FLyn8vrjyCSbJ9Ur8DbY69ewxiJ2ObecFmcxmBEVom7kCJ9v4qidOxh91w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=dK4GUuZ0heijtQuZAR4nwrWpclVg/AyeWvM4lJqGzGk=;
 b=cs65k7QgHgYvYURCylsqn/UibNgSqidGUHwjabeQfy+dq6pleaCKm3CO9IOg/8OWsvVbMbhZ/ryBXK7euJcJaM/oQL9TZQgECnBtW5oq8Ih+N6eqC5nKW3uTWn7KTL23FqPzwX4ycoiCn9RaVLnuiH3mVWGrfDF+B8N9ha1ctZPKHKlTN9HZqL4q/cFKthN/03d1Vr9p5geOkxRI0awMDXri827mbipfuCD6TXkxU1Nbdmd/1hkIK81UWGNGzafiaDY8yGypy4aR3Y5ZArXr6tNepl9tuyRqxk+bTYEV2wS9WtUtW0F8aJIe//ImRyR13iBUhOXRna2S0DAUdnaM/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dK4GUuZ0heijtQuZAR4nwrWpclVg/AyeWvM4lJqGzGk=;
 b=AE34NZtqxMurEQX0WWJ05TBKQPOUHAMDBFKdtTXNdRyOBDNXqctCl8iCeMrMXYzlaW5I2HR2vjC9Scl4NLJX6rbPjMvLQ0Owsgt8Uv3o0moCeZGgrT/cTcKwqviJ4iMA/EYAlu+zDV58FFNh4GaG1qwg+VjB730tU+ZhnEq2KGrnA9VoiswuDOfy8hH8Fe+wjvks56yOXEGea/bewepRcI9hqwevp+Hbr5qiVqVcPBfkXNrWveWuj2NWTFzG2wrSj6HbpFeIKGrCqZr9tzzBaJjfkIkMzWe91AA8SeSDcUQYphK7ydEFlfYmLV8u/WLSY9YcxumAO1mb5ObMtlveug==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0158.namprd12.prod.outlook.com (2603:10b6:301:56::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 07:57:38 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4478.025; Wed, 8 Sep 2021
 07:57:38 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Nilesh Javali <njavali@marvell.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "GR-QLogic-Storage-Upstream@marvell.com"
 <GR-QLogic-Storage-Upstream@marvell.com>, "djeffery@redhat.com"
 <djeffery@redhat.com>, "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH 00/10] qla2xxx driver bug fixes
Thread-Topic: [PATCH 00/10] qla2xxx driver bug fixes
Thread-Index: AQHXpISAD0D1xmfxFk6S/bXnlodKkauZxVeA
Date: Wed, 8 Sep 2021 07:57:38 +0000
Message-ID: <d2022256-52b0-1ab4-82cb-83fac3c49cd4@nvidia.com>
References: <20210908072846.10011-1-njavali@marvell.com>
In-Reply-To: <20210908072846.10011-1-njavali@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
authentication-results: marvell.com; dkim=none (message not signed)
 header.d=none;marvell.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 454922ef-c8f3-47b8-8f5b-08d9729e53a5
x-ms-traffictypediagnostic: MWHPR1201MB0158:
x-microsoft-antispam-prvs: <MWHPR1201MB01580DA71356570D5CCE7B6AA3D49@MWHPR1201MB0158.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:403;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3T6TtWPLODihaX41rFs8LEmF+oA5si2xCtm7QFiKSjvJ4EX5NKBB6iFnHQivzwBYJM3oQVUiJHVkKtRFiYNKO7ao9ocCTUZJht9iEdsT1Wh0RR/JQMUwZRDcttwWJU9krNt/Ruqc+KZBG2y80Ufi+xIhwHjSHHO9yoNi/jku64sMCwyv9V7eAgtIg1KIQMLZcEHV9djZSbt6eULOpQdDAosDokVCG4aOhHm8LTNIrX/M9ZKxcM0QX48GJAJeydNqgTi28gTT9jnYoAIeLrjp1dGAcAWra8bzhLM2W8HCPR/6iXzsgsrDQ+jDXgGnFlhoNq9a/gDosDgNacNM98ShsxOPJXrFK1XM1eubAxR29zm7Bp+HR0DncweoQ3M3lyUS4nub5yXebBkaYBNma4I+X60eygecMyRlPfGLVixRCq+P50YpKYvCiDxOx4CwVwjJbjj38d5O9keud/KUtxWklmQs8QEiPbdDKCobnAz8Zmw/tBUQx6Rr98CRDtIycIFrKDDIe+DieAZLYPz/KpE7rrc2u2jDwIRStJ9c4d10Zzgnterg5ZzZJT+jhq946hE2+IuNDLl8maRWRt40Pl6MHjekdygCS1A2nRIECE0/q+KssRweyFDzvnZ3ttt86PV05NrEdDl4rsi+/vvYCObHi+ou3xJpr6zspHDNi/K9gthltXuprtX1X/0GPDdIVr/KrwDzsX9rf2fd2ForPTcoRBMvw/zIg07I1LCdd8CaZwxFwrg5Jk2AGWB9tXI/CCh7LKkKdn/QI8UTzZsy5EoqXg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(36756003)(76116006)(186003)(91956017)(31696002)(38070700005)(8936002)(8676002)(66446008)(5660300002)(66556008)(64756008)(83380400001)(66476007)(54906003)(66946007)(38100700002)(122000001)(6512007)(4326008)(2906002)(4744005)(478600001)(110136005)(6486002)(2616005)(31686004)(71200400001)(86362001)(316002)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUhSWlhSVlBKUzdoeDUzRlhQZnVUS3hQSVRUeVNJNGZMZ1VjK2xuc0lnSEwr?=
 =?utf-8?B?aHdxMU0vbzNBWUltN0g0OWRwcXFNY3pySm1vcnErVjJlZyt1WFovOXNER1B4?=
 =?utf-8?B?WW1nMVdIRUMxaGcybUJCVldlTFRuWGN0VWJzOVNSZ3RVL1AvVWRUaHFIc0kw?=
 =?utf-8?B?RVBLQm9Memh3VEJtSFFmSW81YjY2Z0ZvdE1aQk9SY0hXNlNNVXVZK2VNTnov?=
 =?utf-8?B?RFhOYW9ZNUwzQm9ueERDRHJBYjdqa2tiQXBJeGxvZzY2cGZhQVIwYWprdTZr?=
 =?utf-8?B?cTF6bEFITjVOdEsyeUNXR1N3R1lRRzB0eXVtcXFZY01XTkQ1RXk0RzFsdmZV?=
 =?utf-8?B?VXkrYkVCRFRrczBzRVNHNThjMDdXdEpEY29jUzZhS0R6K1JaeUM5VlQxdXNN?=
 =?utf-8?B?SlNwRDYvMHFkY2E5VURWSjBrNi9oQlhPb0cwSW9EVnhXVFNnSStGOTkvMVRw?=
 =?utf-8?B?anZKMjBqcmlTaW9rcTJFeTVzcGduYVF0d2ZWSkVKREF0M2lIQmlyTjZpUGU1?=
 =?utf-8?B?UDhsS3BxenFNRlpnb0pxQ1RwWVlNem9EcjViTEorY0pGVS9DeS94NStHKzk3?=
 =?utf-8?B?ZjkxVkRCWFlSQ2hwaFRmb3JFV2NtNTdQSmZKbGkvK3BiNWx1cjRucnlqVlBL?=
 =?utf-8?B?VWJ4YVZzNzArSUs1YVlVSFNHZGZKMTdIemh5Mzh6cmRBdXMrNzJvcXl5TGtu?=
 =?utf-8?B?UWtFa0UvNW9ua3J0djNGcFYrKzJmbGJNUEYybHFiNHp3ZUxmVXFCK2d2dFhp?=
 =?utf-8?B?S0ZSUzdrdG92bkdtZ3laaXdJV3JFVW96dHBER3pURlFwenVZanBvcElxQkhr?=
 =?utf-8?B?RUtwREdmSDlONkxqcXh2YTVDNWdtS0txdWkxaFJweFN3NktoS2x6T2JxSG5O?=
 =?utf-8?B?cXB6b2Mxa01pc0o5VkZmMXlFOU85WFF2YTY3M3FiZ2hwQmRyV2JoQWo4U05p?=
 =?utf-8?B?TWNJTzdBWWUxSVNiaUgyRlNFeGFIUFFENzM3K2V6SGg1bkJsQ0pId2daaW1F?=
 =?utf-8?B?YVlWblAySkZPaFlqTmUwbmVoTVVycEl1V0VaNnU3R0dPaGZiR1ZKNXZ0Szd2?=
 =?utf-8?B?NEZRc1I1bllldkhjL1lBWXhVdURyampLMVNwY3ZIbTFsN1M1MXlqREdORm1t?=
 =?utf-8?B?eFl3S1JzdFhQaTEyRmlzcVd6Vmw2d0o0bnFsZGg0eVNnbVZHTmpKVXozamQ0?=
 =?utf-8?B?TTNyczBDRmVzcTlNZmNtSUtKZUlYTVFNRmVodWVWTkx5ZE1JVmxGa29hR1Fu?=
 =?utf-8?B?V1pvdDhERUpFL2tnOFhLWU1IWjFCUUZieWk4TDk2a2hKTXhDREJob01Xelo4?=
 =?utf-8?B?cEJLU251cXNqMVA0M0c4cGF2ZUpUd2lMNTd1b1Vad3RMRVRFYTUwNWlWemtt?=
 =?utf-8?B?OTN0UmxBYlNNei93MnlpTElTOFRiNjdZT3ByMlNEZHdiN1dqNFB6MjZtcEEw?=
 =?utf-8?B?eExoVG5mbjlmUkxQcEEzeUkyT1dHb0ZvWlNCU1B2MjBuaUQzcUgzbWl1cTRO?=
 =?utf-8?B?NHRrb3JPL28yenhNOExBNTQxb2pSQ1FKY3N4b0p0WUNiZ29kS2RiZm12c3k1?=
 =?utf-8?B?TE8rN1cxN2dFYXhKaFBtY05pS3dsOWdkM2JNVWlIZFVVb2ZtSUNWUzBZak1r?=
 =?utf-8?B?L0NLWU9ka1ljS25hZmQ3U1hTaVRrVnRFTGRHMjR6QUduMUtRc1dWTjV5c2ZT?=
 =?utf-8?B?OUZmek9WTCs0ZWZWb2RBRmVaZTdnUXJOc0sxdXpWdkI5L2wzTGh5cEROYkR3?=
 =?utf-8?B?eWNHSzIzWWF3K1Y3TGlxeG5ROTNqUmpmWVB6c1Z5aUQxSVFkVHFWd3htd2dO?=
 =?utf-8?B?OWEwWWRVWnE5R3I4R2RsZ1Rld2g4MXM0ZnNRMjNuNWJNYUVuM2tCSitZVXNi?=
 =?utf-8?Q?mgcPyLnhDbR3r?=
x-ms-exchange-transport-forked: True
Content-ID: <48F856092DEC794DAD981FCFAECF5299@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454922ef-c8f3-47b8-8f5b-08d9729e53a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 07:57:38.2404 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CWSx+Xue7TEv8uJm65Xnttwl52YxTQh7IUA7LbDFRuKU7tgFC6EFKGB7rygwp/zLnBviQOwt0KAXSjARpiQgGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0158
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210908_005741_978767_EEFBCAD8 
X-CRM114-Status: GOOD (  11.51  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 9/8/21 12:28 AM, Nilesh Javali wrote:> Martin,
 >
 > Please apply the qla2xxx driver bug fixes to the scsi tree at your
 > earliest convenience.
 >
 > Thanks,
 > Nilesh
 >

why linux-nvme ?

 >   drivers/scsi/qla2xxx/qla_attr.c    | 24 ++++++++-
 >   drivers/scsi/qla2xxx/qla_bsg.c     | 48 +++++++++++++++++
 >   drivers/scsi/qla2xxx/qla_bsg.h     |  7 +++
 >   drivers/scsi/qla2xxx/qla_def.h     |  4 +-
 >   drivers/scsi/qla2xxx/qla_gbl.h     |  4 ++
 >   drivers/scsi/qla2xxx/qla_gs.c      |  3 +-
 >   drivers/scsi/qla2xxx/qla_init.c    | 17 +++---
 >   drivers/scsi/qla2xxx/qla_mbx.c     | 33 ++++++++++++
 >   drivers/scsi/qla2xxx/qla_nvme.c    | 20 ++++++-
 >   drivers/scsi/qla2xxx/qla_os.c      | 86 +++++++++++++++---------------
 >   drivers/scsi/qla2xxx/qla_version.h |  6 +--

no drivers/nvme/ in the above change log.

 >   11 files changed, 191 insertions(+), 61 deletions(-)
 >
 >
 > base-commit: 9b5ac8ab4e8bf5636d1d425aee68ddf45af12057
 >
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
