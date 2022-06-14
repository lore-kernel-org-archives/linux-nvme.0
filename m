Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D6BC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jun 2022 02:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4gN+MnpMoCkMK7jbUnmbn/RtPX6Vx8nzusLVx4gjYjY=; b=A+6bDOKRO/mVVMzAueUmGcaIfj
	ESlAuGkwjewYGWzOAFsKpqq/jZNaXwOIFWcsFUwMZ4cfmie+vI8Dz2NM7cbcISvu4ubXwp6yEEJoY
	nR8zCEEuuU9fIVobTXiGU33Nz82jmHQl+6sEC5lmnccpQV51grrqRWC4XSpCO4hxxcV9YzYBLWLf0
	VjUFrZ+FwIoavtdw+0ksKLWjsFkRnKqi7mIj049ppYQJRzILPlKDYX+W5JPf0z0FDb7EuPvRd9Y51
	wXf1O3TW3AZWD+KtrvCcGSdPoJdsT49qSYeU+4aEAxqezwlQs+ZeCUtyNBnKEMuDNyKcOgrcWaPSx
	PQd33rWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0wSI-006lyV-NL; Tue, 14 Jun 2022 02:38:58 +0000
Received: from mail-dm6nam10on20623.outbound.protection.outlook.com ([2a01:111:f400:7e88::623] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0wSF-006ly1-Px
	for linux-nvme@lists.infradead.org; Tue, 14 Jun 2022 02:38:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxJTaOElCDOw5HjwDxtBqKsy/YHEAK77ruBem6zUOVN4u/ffSIHIZOCjkgh0adlAAbPs+koV3dqwScmPZq0lAmkiaH9G2iUfHFNlF50TTp11G4pA+hb1/+E3lRs+29bGLfWjp33LJ1iBd4eoP2b1wOjxVKBk+WX4m3Btq7rOC1sTEjliJqQ3a8EcEidKoBgS+/Dl4mPbWvMk72J9L9kEAA9VP/c0UboFd35HqaZ4iJevNA2aDFIfppN/YDvUBDY6T8AgfYzHjH1TUwXoR083Nhhl2AUvtYQik7rCFuextrvNTgmQCVc1pnox9PJv2CwfVWVixgoAgoxH+ir1idKeWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4gN+MnpMoCkMK7jbUnmbn/RtPX6Vx8nzusLVx4gjYjY=;
 b=DI4ZVowKMLF81ulYXI65lZC7Uig7F1k6rLMc5tHtzEvEhcqAv/waaf14zGcjnTWK+3pF8Te3NAVURy+gMExEaV9zq0oSsh6RjHr/mCztUCoFhOxHypQ9K3Hzh+If7gdFYaG4+oenJw7tHWGGFByZGUA5hYEaHbNlh292KV7hRC9pIzOBMTQnDa0OAHvKB45OSYGkeefatyH6MD+EouCCKwMPwTkbS8mYAishA1trlKurXUNyPDlpjYXuIaL44ymufZFMg1MgElrCJ5oMABOrXMJiw1AAoaA914J4fU/LmDW7mbeawTMfjG0ido21ifA9mwtvzuIfm4QXaoNZ/b+RZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gN+MnpMoCkMK7jbUnmbn/RtPX6Vx8nzusLVx4gjYjY=;
 b=mNxapUOVUDt5nq5HWO32cU7+Cw2z1hXfc9vcleSLICXwd4xMaH83uDYAaUy45to1ifqsdvETgD53Ft2yJHMrFeKbv6b099EmMALjr+HqA/0xPGOeiv5CZ5en8HtQSm3k2Yf94vsfjsRSC8hglVoTSnXQa8Amd72tAaAZwMN0/4fvAWcJnKrGzGVE034GFGdMzV4k3ngbfPF/WuuDkMBluDSxEbAMDmvLaNlxtmWWgFenHKcIGcjNuGMzZr7RmoaGnqqeFHuQSN15FOGltoQ43SbatCuy4ZIHOdOF7SW5GKAauGiprNrFSQRNpsqXYgpEJG+AbaQe/2iGnZ6p5GsT/g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN1PR12MB2445.namprd12.prod.outlook.com (2603:10b6:802:31::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Tue, 14 Jun
 2022 02:38:52 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e%7]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 02:38:52 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC: Yi Zhang <yi.zhang@redhat.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"mstowe@redhat.com" <mstowe@redhat.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: blktests failures with v5.19-rc1
Thread-Topic: blktests failures with v5.19-rc1
Thread-Index:  AQHYfFwe8PMwMXtEZEqIJFDj8WJWFa1IXnmAgAACxQCAADBSgIAAJ8QAgAEp9oCABDqugIAAFNGAgAAEQoA=
Date: Tue, 14 Jun 2022 02:38:52 +0000
Message-ID: <8cf67806-5b9e-3476-d81b-2fb8d618df5c@nvidia.com>
References: <20220609235329.4jbz4wr3eg2nmzqa@shindev>
 <717734c9-c633-fb48-499e-7e3e15113020@nvidia.com>
 <19d09611-42cc-5a81-d676-c5375865c14c@nvidia.com>
 <20220610122517.6pt5y63hcosk5mes@shindev>
 <YqNZiMw+rH5gyZDI@kbusch-mbp.dhcp.thefacebook.com>
 <CAHj4cs9G0WDrnSS6iVZJfgfOcRR0ysJhw+9yqcbqE=_8mkF0zw@mail.gmail.com>
 <20220614010907.bvbrgbz7nnvpnw5w@shindev>
 <YqfxKanxbZNN7Kfw@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <YqfxKanxbZNN7Kfw@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddc0a37d-ccc4-4e23-99e4-08da4daf04dc
x-ms-traffictypediagnostic: SN1PR12MB2445:EE_
x-microsoft-antispam-prvs:  <SN1PR12MB24451320C3B2529A13354311A3AA9@SN1PR12MB2445.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  taUfj/ChER0UYVkA8qwqcMp0/MBVV0nLeazw94NkAFVgehfWGSYdY3sY3r0wGWj3JaGyZUPuCcsmP42XinER59MIlAxXKZMbmUzWm6TNNYZ0y7eLJ57prvhP3tVEyteujond5PJ6Djd4GyvLnRyCIGvynkVTgbFrNGex0bp/wtYEEqC01Fqz//jA/E3JAtYIbQsyFZskkTEClsmVdLcEyIc6G6Jr8WJookcfvid/RXbmtXQ5TGBsVuPFiF3grKQSgEMAwN6flcR8+xIUFZu/TkwMIIbu4DDnE/7dpOZbfqFYyqMS6moRLIbbLrKBVZLZ0PK3Lecq2zAa4xUpbf5zLx4o+PiQofaTYZrVzcCNno+Mlo3sCahrkRFYr0pQCFRACDiJDYcJZhwa55iQqVF9bdxtjm7GHxbXLhMeq3BlR7ABPFkAgLVxCQFZTvO0HLvdFJziErnP5XIs3ibWA1PUWOwmdtzi2xUBaO410Wc4wrlpwkl4SmCgDjA7mXtRvuwAVH+mAScTdkGkimFJwKSNjjp0e0nzMEuvVB4Cp53mMHMNMjyb837ktjBi67DMU3T/i/hQFCPJZspU4P8g3lKt2/HSG8Dti8Luz1i0p0asj2KlDdkYrVhvxkf72g2rp5MAPk3glNlt3/zxDkwTiNEEUravwOrpqR3NpI0b04JVlMvMh5xrz+UhdpQqEKAwzqqd9zDpKjh7Lzf7i0cadpmOMWxc8kouRifGtObR3gMCvitKp0QCYwBSxZoR493gL6Qigyvs3RE8E8Npk7fN/JiLbw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(53546011)(6506007)(122000001)(6512007)(31696002)(8936002)(6486002)(91956017)(186003)(2906002)(38100700002)(5660300002)(71200400001)(83380400001)(31686004)(508600001)(54906003)(38070700005)(316002)(6916009)(36756003)(76116006)(66476007)(64756008)(4326008)(2616005)(8676002)(86362001)(66556008)(66446008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?cldzcHJ1NEg2Sit0WktuT2NFYVVZUGxmSS9tN2pmdmg0ejR6Qk9GVlVqcEhX?=
 =?utf-8?B?Y3c0WDY2OVhxamVBSG5yWjR0eitFSmljaHZWeGJMWUM5Rm9hOWo1NmhGQ0xR?=
 =?utf-8?B?YloxY01PcXhodkhxRVErN3VnbVI3Z1lCZUl4TGh5SllISXlJN2IwVStZTDha?=
 =?utf-8?B?TDVqMEhOdTBSQUx5dTNSc0pTbUF4TlIxRGoyeUlpQ2Q2U2tMSnlwaGlNZDk5?=
 =?utf-8?B?UW1QdXBxYngydUUvc1NQT2pmZTREcUlPYTJiNmp3WFhlaVlDZlhFZ0JGT1Fy?=
 =?utf-8?B?MzZzdzNTamUybTVncjdFOEJJTDZ4eFpoY0haTmlDVXlCZUM4WWhLaW9VWkI0?=
 =?utf-8?B?NFFIb0QvbUp1ZnQ1N0pRZ3BsSW9FcC9sRExwM1NYZzdSdzBEaERIZGRBRnd6?=
 =?utf-8?B?eGxtRkJlQThjM0dycXIzMHliamMvTitKOVJIV0p6QS9qOGdCeFhGdXI0b0ZJ?=
 =?utf-8?B?NGVLY2FSelRiWlRyNWdRd1pXYzB4MTRlSVBjUzBtNWY5MjBWb0NDSnduTitG?=
 =?utf-8?B?WVNWdzZERWZ6ZXlCd2kzNFFzZ2xxK3NXKzdnRzQ0ZUFLaXptN1drTlM0TTQx?=
 =?utf-8?B?M3h2UlRKa3l3YnVEcFh5NEc1OWk4eXpJZHd4U0NkaVV4SncwWG5yQjZEd2xK?=
 =?utf-8?B?VExBVTlkNklPY3V4RkYwTkRDaGdlRm5DL0RkMzcrRGJPQkxFT0llZThvVkUy?=
 =?utf-8?B?T0ErcW5NUG5GcDgzUVZtWmhxeTNUUk0zZ1h2Q3YvME5ud21nMEkyUkROaTM4?=
 =?utf-8?B?UWMrVzR3MTdnSUM4b1FKbXoxc2NqV3duR1hsQWlMWVd3c2cvMkNBbGlzcVVH?=
 =?utf-8?B?OWVKOXQzVVl5YjFuM3dNZHRJVUxzVW55TXM0eSsxd0JkMXg2OStSa0ZaaDRr?=
 =?utf-8?B?QThjV2dvTE9NS3ZDZmpsWXlnTGpSTnNURmMyNUlYU1lIL3JtV0g5SG1WN1A3?=
 =?utf-8?B?ZlNwMm43a0ROTnk1WGxxeCt4V0hnRmc5V2pXam9naU9ETkVCWnRJcjJzaVNN?=
 =?utf-8?B?UFJ0aXBwa3o2Qk02WXdHa0luS0FhTmdaanpNWTJPcWFCVkRlYU8xcmVXVWUw?=
 =?utf-8?B?Y1Y3OGMrUnlINUNRMXdDL0gwRlpzT0FueTlHOS9Da2pNMklpa20vcHZzVXdl?=
 =?utf-8?B?UEZRNFRnVHZCbTNJL0dtOGdCeERldkduM3BDbGpWaVdCRytKV3VJcVBZVCtX?=
 =?utf-8?B?TnJ6dmFaYjJYMEw2SHArTTE1WEl1RUgyQWNXWTFRQitZM1VESWpORVdRemtj?=
 =?utf-8?B?UUd4YU1SYktNQ3orVjkvZWdSZXBqMTA1MVlPNzd0aWZMMGxmL29DREFtdGxa?=
 =?utf-8?B?VkhCamZxaVZWMU1PMDdVRHNjVmo1WGkwK0RTdlErWU9kamdScXR3ZkxhdGVP?=
 =?utf-8?B?bmQ1QjZ0TXNUcVhlbGxKRzdJeU51Ly83U2E2SzVyZHo1ZFJPOUowUUdtRUlS?=
 =?utf-8?B?RTVqRWVKTGFGWll5UFJ3YVozcU9kcDRQZmNiTk4rWFVwRENnNVlqZHkvUExE?=
 =?utf-8?B?NmN5bWFsT1dKRDFjVWpKLzVLYXdJMjJvUXBTTzJpNmwvYmdYSjg5L3lsOFJ2?=
 =?utf-8?B?ZVAxOU1xVXhrbHBTdTlnZXc2V1k1OUMwTllCRk9iOFZzR0RyVmRrZGFveXFy?=
 =?utf-8?B?YlpkNlA4VFc0aFhZV2lVMzlNTUh5b3VuMlFzbk9HaWptRlVmaVBHcm9jTXAw?=
 =?utf-8?B?bDhiUzRhN3dINHM5cVE3d2twbXNscTdYV3pMZVFUMHdmMFhvUUpGWlZPaXNl?=
 =?utf-8?B?VUUrZW1jbXNtcUFmMlkwUDhHRUdVVEZCMnBRdXNmci9MRXphTzJVb29DTStW?=
 =?utf-8?B?SWgxMmlNcEVhNTFUNmw5TUJjR0JiYUxLTExIdGt3OXZ1Y2EwME1uUkd0VTRT?=
 =?utf-8?B?TzgrMlRJVWNFMGE5UDZBL3hMa1JScktpeWJxcUFhRUI5dW1rcWJKU2tFWjNm?=
 =?utf-8?B?Q1hab0dVUEg3SUw3Umg0L3JQendSbVJETkdYTDg3aUN4Y3FYeERkc2lUZURI?=
 =?utf-8?B?N0k4SU1ZRlR2QWFSVXlnM1hMNEtHOEZ4U2E0L29wckRCZm9tRlBzVXJtN3Ro?=
 =?utf-8?B?YllVc3B5ZkNmd2hVRGg4azJCRmkwNnRaV2tkSlpnVHErY0UzR1lsbXBUcVNl?=
 =?utf-8?B?bVpvQXRHem1hS0VUbjlscThFeEZzN1lUVTYvSS9NR2luRFd4cDdtOHN0UGtM?=
 =?utf-8?B?YTFTOUJCcW1ObjdWSS9qdkVIU3BKM21IUTlicWJ3ZmtGSFFNbEJHOFRxR2Rz?=
 =?utf-8?B?eStpWkZKdUFTUkRENmk5NGl1QldQaEVERXcyQTM3eXQvYkZQaEV5KzVyaFFU?=
 =?utf-8?B?Z0ttUDJxYVhlMzdQYS9nVVpuVU9NRFh2Sjd1a2NTc3RQRHk3dXo2UEhzNllJ?=
 =?utf-8?Q?5uEyvCLv3+4QI0KPTdu4IIKi5Xtu8BhQfvy+Rciszjve9?=
x-ms-exchange-antispam-messagedata-1: a+sl4U1Fou+eSw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F746F98057ECA47993BD8E68B57F3FF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc0a37d-ccc4-4e23-99e4-08da4daf04dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 02:38:52.2059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8HWyHGLfYTdFE5Le5WlggPsu0l6J4CfmIFXpTi/axYYGMs3kir2TKt0v1yGLgv78s9DcH8G7f/PfUJEe+BerRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2445
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_193856_079729_3668EA3D 
X-CRM114-Status: GOOD (  20.74  )
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

U2hpbmljaGlybywNCg0KT24gNi8xMy8yMiAxOToyMywgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9u
IFR1ZSwgSnVuIDE0LCAyMDIyIGF0IDAxOjA5OjA3QU0gKzAwMDAsIFNoaW5pY2hpcm8gS2F3YXNh
a2kgd3JvdGU6DQo+PiAoQ0MrOiBsaW51eC1wY2kpDQo+PiBPbiBKdW4gMTEsIDIwMjIgLyAxNjoz
NCwgWWkgWmhhbmcgd3JvdGU6DQo+Pj4gT24gRnJpLCBKdW4gMTAsIDIwMjIgYXQgMTA6NDkgUE0g
S2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPiB3cm90ZToNCj4+Pj4NCj4+Pj4gQW5kIEkg
YW0gbm90IGV2ZW4gc3VyZSB0aGlzIGlzIHJlYWwuIEkgZG9uJ3Qga25vdyB5ZXQgd2h5IHRoaXMg
aXMgc2hvd2luZyB1cA0KPj4+PiBvbmx5IG5vdywgYnV0IHRoaXMgc2hvdWxkIGZpeCBpdDoNCj4+
Pg0KPj4+IEhpIEtlaXRoDQo+Pj4NCj4+PiBDb25maXJtZWQgdGhlIFdBUk5JTkcgaXNzdWUgd2Fz
IGZpeGVkIHdpdGggdGhlIGNoYW5nZSwgaGVyZSBpcyB0aGUgbG9nOg0KPj4NCj4+IFRoYW5rcy4g
SSBhbHNvIGNvbmZpcm1lZCB0aGF0IEtlaXRoJ3MgY2hhbmdlIHRvIGFkZCBfX0FUVFJfSUdOT1JF
X0xPQ0tERVAgdG8NCj4+IGRldl9hdHRyX2Rldl9yZXNjYW4gYXZvaWRzIHRoZSBmaXgsIG9uIHY1
LjE5LXJjMi4NCj4+DQo+PiBJIHRvb2sgYSBjbG9zZXIgbG9vayBpbnRvIHRoaXMgaXNzdWUgYW5k
IGZvdW5kIFRoZSBkZWFkbG9jayBXQVJOIGNhbiBiZQ0KPj4gcmVjcmVhdGVkIHdpdGggZm9sbG93
aW5nIHR3byBjb21tYW5kczoNCj4+DQo+PiAjIGVjaG8gMSA+IC9zeXMvYnVzL3BjaS9kZXZpY2Vz
LzAwMDBcOjAwXDowOS4wL3Jlc2Nhbg0KPj4gIyBlY2hvIDEgPiAvc3lzL2J1cy9wY2kvZGV2aWNl
cy8wMDAwXDowMFw6MDkuMC9yZW1vdmUNCj4+DQo+PiBBbmQgaXQgY2FuIGJlIHJlY3JlYXRlZCB3
aXRoIFBDSSBkZXZpY2VzIG90aGVyIHRoYW4gTlZNRSBjb250cm9sbGVyLCBzdWNoIGFzDQo+PiBT
Q1NJIGNvbnRyb2xsZXIgb3IgVkdBIGNvbnRyb2xsZXIuIFRoZW4gdGhpcyBpcyBub3QgYSBzdG9y
YWdlIHN1Yi1zeXN0ZW0gaXNzdWUuDQo+Pg0KPj4gSSBjaGVja2VkIGZ1bmN0aW9uIGNhbGwgc3Rh
Y2tzIG9mIHRoZSB0d28gY29tbWFuZHMgYWJvdmUuIEFzIHNob3duIGJlbG93LCBpdA0KPj4gbG9v
a3MgbGlrZSBBQkJBIGRlYWRsb2NrIHBvc3NpYmlsaXR5IGlzIGRldGVjdGVkIGFuZCB3YXJuZWQu
DQo+IA0KPiBZZWFoLCBJIHdhcyBtaXN0YWtlbiBvbiB0aGlzIHJlcG9ydCwgc28gbXkgcHJvcG9z
YWwgdG8gc3VwcHJlc3MgdGhlIHdhcm5pbmcgaXMNCj4gZGVmaW5pdGVseSBub3QgcmlnaHQuIElm
IEkgcnVuIGJvdGggJ2VjaG8nIGNvbW1hbmRzIGluIHBhcmFsbGVsLCBJIHNlZSBpdA0KPiBkZWFk
bG9jayBmcmVxdWVudGx5LiBJJ20gbm90IGZhbWlsaWFyIGVub3VnaCB3aXRoIHRoaXMgY29kZSB0
byBhbnkgZ29vZCBpZGVhcw0KPiBvbiBob3cgdG8gZml4LCBidXQgSSBhZ3JlZSB0aGlzIGlzIGEg
Z2VuZXJpYyBwY2kgaXNzdWUuDQoNCkkgdGhpbmsgaXQgaXMgd29ydGggYWRkaW5nIGEgdGVzdGNh
c2UgdG8gYmxrdGVzdHMgdG8gbWFrZSBzdXJlIHRoZXNlDQpmdXR1cmUgcmVsZWFzZXMgd2lsbCB0
ZXN0IHRoaXMuDQoNCi1jaw0KDQoNCg==

