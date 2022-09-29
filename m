Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16960C04A95
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 03:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sBsPQWm0OiF5uKUN1Wz+EJlPsbbvsA4uXImVnEZDzJw=; b=vAqGkP0224VlVTA6u9HHVwXQqy
	bTb0j+1YDtqX/dN/vyeJZwhtzV2MLNMEdvJPxNBX5RwSLqaRza7M209NAgFcJxjHbf3PDmvkNnXIW
	3TUc8wC/IhaEAsHeM1I9xfYu+Yedt+2fvkhytCHCPv0hCcuJ02qhAvWvzsySAS2v7WRTm0nkk2G5a
	BGghxEU1iSoUy775FMwPKuQ7MIjHNOISZlV3/Y4Br8YS3q5Mv9iJAAa6tbMEpFzwzW5OPhue74/Yq
	w2peDyC1QXlESkg90qfvy5rvW0xx92E/lIcF/Huqo/SQ9V6CRkrHlUEieaJ4uTFVDU3cX15MuHibV
	O7ir6f2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odjrF-0012ah-Og; Thu, 29 Sep 2022 03:05:05 +0000
Received: from mail-bn8nam12on2084.outbound.protection.outlook.com ([40.107.237.84] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odjrC-0012Zy-Av
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 03:05:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sl56NuLQpBxYGuNMRL1p7+iSD2E4NVUxGAZydX+p9KOdzoMlayPgpGnwYoh+fxFYFB3Qq1/4Z5MQ45PmXx0BjJWyE+9Mzs98S6gwti5+0GydXLlPkc3OgidKrPcVETlm9aWzxWsNF/942gLWSYVao/FqYvEJ5ZmL9Sm6UhiIY6ojNCXpKykZ3LZ2CHdEsePhAJb1kFqATVtuRxREApdim40sZYi7na3M28qdZtXckVRMwFy9hguf5XdGiFZlpEM78TI57bRUKXUxfm/UvV/6vDwpUH0VUSd7mpkiRimlhxlWsMHgZf1JB1raMxCGIvXna08PWuzqcGR7vV/JEeb2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBsPQWm0OiF5uKUN1Wz+EJlPsbbvsA4uXImVnEZDzJw=;
 b=mljX1yeCiuiWuxMlJBp+KVj7u8k/IriAK1rJ0ijmOzN5LwZp00V3JWz2kdeZ4lpCN8RANYP2FyxKG7yBqfufCW6uwZbGY/aRxLz47NDPNsq44EUsImOpI1Jd/NziR0aZxPj65VI6EEGMOWPNepuuGV/MaD13xlY3pMDjUj6cGdpyFgPuhnY0iwjvfbbkWEjw9i26iM2b/G++A7R1Or6K+RIObhEbN+IiY+8kh4s807FVNcd0WSTiHlS1AeLSnxopUl+DXZKRiq4nesRwTdfIcw6J3kSGNLC7K5Mcth9PGumOAzS0xeKOhLmwwnX1mbl+o/X/8Dvo/pZKsn97gKjzuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBsPQWm0OiF5uKUN1Wz+EJlPsbbvsA4uXImVnEZDzJw=;
 b=jPHeYmRvaEThfl0jL2y5R591HRn+aqXS8rOMGQIYbTWV7IcP9wOwMuB/g/DpG6sGMywT80LXY+nyXesBeTfZXzMOLxjGuIakzZc0G3watwGrlfS/yUVlgmMbINYOib2VAr+MK9T7B6uMazfJT/cVnMJL0sxRDK+TUX6mN1WIzDmcV0vMCQ12WRwUOFWEturhdSVgxvdC8foR3PWdi561T+1BT4j4R4zO9r1tFlo60mEwR7OI9/10uunLzfV/SdwzCh0qH9pxAI9BRfMJ/7/2aQODxLpCHs5vEWKjlWKSXpYsRE1Xk+E9vrcadhE9IT9rJ2QkfhnF/clGpR6nORnJjQ==
Received: from DM8PR06MB7704.namprd06.prod.outlook.com (2603:10b6:8:32::16) by
 DM8PR06MB7766.namprd06.prod.outlook.com (2603:10b6:8:3e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.19; Thu, 29 Sep 2022 03:04:58 +0000
Received: from DM8PR06MB7704.namprd06.prod.outlook.com
 ([fe80::29cf:1ad7:d52b:6f9f]) by DM8PR06MB7704.namprd06.prod.outlook.com
 ([fe80::29cf:1ad7:d52b:6f9f%3]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 03:04:57 +0000
From: "Knight, Frederick" <Frederick.Knight@netapp.com>
To: John Meneghini <jmeneghi@redhat.com>, Daniel Wagner <dwagner@suse.de>
CC: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, "hare@suse.de" <hare@suse.de>
Subject: RE: [PATCH v2] nvmet: force reconnect when number of queue changes
Thread-Topic: [PATCH v2] nvmet: force reconnect when number of queue changes
Thread-Index:  AQHY0xkW0CvFgvGYC0OqpzqIUZQ+Z630t3BwgAA4mwCAAAcPAIAAGs6AgACaLACAAAKUEA==
Date: Thu, 29 Sep 2022 03:04:57 +0000
Message-ID:  <DM8PR06MB7704AC563A6C8100A4A1DFDCF1579@DM8PR06MB7704.namprd06.prod.outlook.com>
References: <20220927143157.3659-1-dwagner@suse.de>
 <d151b0c1-d28e-faeb-03d4-ed28b9768ee2@grimberg.me>
 <20220928074850.h6rwvwgz2oje3ebg@carbon.lan>
 <f1909450-1435-9661-056f-b955d6089ca7@grimberg.me>
 <20220928090243.c4ctbj2frydwsfav@carbon.lan>
 <DM8PR06MB7704C17B1DF832A432024BE2F1549@DM8PR06MB7704.namprd06.prod.outlook.com>
 <6e172046-53e7-d2cb-38b8-e87d725046de@redhat.com>
 <20220928152616.inzetc3fsvnhb3o5@carbon.lan>
 <DM8PR06MB7704CA28602F1367574EB23CF1549@DM8PR06MB7704.namprd06.prod.outlook.com>
 <410aeb5c-3045-59ac-3fc8-fe80a89b9119@redhat.com>
In-Reply-To: <410aeb5c-3045-59ac-3fc8-fe80a89b9119@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.600.2
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netapp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR06MB7704:EE_|DM8PR06MB7766:EE_
x-ms-office365-filtering-correlation-id: 9c4983de-9453-4402-b7e6-08daa1c7643d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  Iv9a5u1scJLr5ToFmbjkw/td5+nvukRqqwSwLIjHrd1GhN0KsVAa7TRZcuVUkJ1IiZ3frmJwujuab/DSSHoxe6V2Lb7zMg70rfS3jQ4lqDKi77zwtMJ1SwIsI+JdlKROeTJgar+MV4WnnkUZWrJXQbFCgYAIOt++J2jIq5HOuIhnxdF0EcmxAZGYJyw9q/KD5QGontv7QdCS4lIk8IW8DDYB7Whnq/9Xyt6DPoRriow8rFXyIL3SY7K3aj9yoSjpWobRuxJYYAHLKFFQIDb7ie3e4HxLZBQoHrJ+gUi/kHYQZhbi85W4OpCMD6F/hcPB7zPCZwsWvGIc8LhM1QUrRP/EwbP53gbVYnC4dShITaU8hRyeFnNtTGVWrh9Vhx3Pfp/Yvw4AX7OzRFbsZZHsDzbrJ2ciOOZEaI0a6VOAXrvsbxZ68BMMYPYASFkGqa9N9LvQKqe/65+1SS/B8H6rITIEbUL8d1lqz7PdBv0UwZhqat/C05nELRytH9vzSPB2fgQbRFR7Udx6kMzW6uFp9sCv3NUG4XKVJbx7POPZ4QDix/YRBGQNuqsIE8fuNt5WIsCNSkkOQd13wYKynV6j91Gm+6wMupKtsDk/LbnO/vLI3OMhFn2Hsuml4eKf0uiAfX/7avu/dRAiah680UzSS/MCpUnm9OdvIAsv/q+YF5CYxYME1aWCwo/45eimfg0NwYFGqlG1P7I2CXltuyt0DOwxaxmv69/4g+s9p3lWljy4g4wnPDQycnmEgzUCl9/KSGWxK3xbEnxP2XoK0oH6wg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR06MB7704.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199015)(83380400001)(186003)(38100700002)(122000001)(86362001)(38070700005)(52536014)(53546011)(8936002)(5660300002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(4326008)(41300700001)(2906002)(478600001)(7696005)(6506007)(26005)(9686003)(55016003)(316002)(54906003)(110136005)(8676002)(33656002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?R0Y5MlczSTExRER6S2pBZ0crcWVHQ2wvYnZZbG9STFpUY1Z5Uldld1BUR3NV?=
 =?utf-8?B?Wm4wZEZKTDlUeG5JWGNBaVZHOHVhVmVCVGo4TU52anhxbzJjU2tvOGFVYUNy?=
 =?utf-8?B?VkN2RVd6aWpKdEgzZGNUNm5jcmU4UkZIdnhnVHpIRzZaRy8wanVKYzlVaTdS?=
 =?utf-8?B?NWpRY0J2QVVvbFFnZ2Y2Z2d0SDMxNVdiN1dwZDJ2YnAwYlVFaDFMaDRpL1Zt?=
 =?utf-8?B?eVlYNUNkdmFCZVZ2VTZ4Q1F6Y0RIaTR3eE4yc3A4UHdjUXpIc0k0Undwd3Vz?=
 =?utf-8?B?K3cvNkRHK3I5WStHMHdySjdDVU9ZVWhnV1F6L21zTEpFdkdZWlBuSHJYbmE3?=
 =?utf-8?B?cnkzQUZQbGpzdnA0a3RNOFlKQ2lvM2RxR21GRGFseWoxQWM5MU4xckNaN2NI?=
 =?utf-8?B?MnFVOUEzRjdrUFZ6KzJBN1RvNHRuZ0p6OHd1dFZQeE5saW1UdVNvaW5Pai9n?=
 =?utf-8?B?czJEcEZhYWd4bHBwTENTejZYaVB2a3djRStMaC9HcjV6UGtXdythWEgrOVFF?=
 =?utf-8?B?VEFBTHE4eXNqRDYzamZITWxSR3lxUXMrYnRtUnNBeUJVRjZGMEVleS95allq?=
 =?utf-8?B?STJQMHgzeDdZelVRY0xPMnhlNU5seUxSMGU0THdUbXNXUm1jeU42b0hPSWx6?=
 =?utf-8?B?Y09BWFpKZVNrR1luZ1NQNG5WYkFzT3ZnazNFR0VPT0tUUWMyc0xWM3FsVDV4?=
 =?utf-8?B?RnBPZTNsNVVUdzI5M0VQYURhQWF6YUc2MUp3bVdTbng4NUhHeVZQanR1YWI2?=
 =?utf-8?B?bVlRZk9mbjgxMGFvaHdYZWxKL0tXakxLVURBeHg4RzhVRGcyRUdZWVJ4VUZW?=
 =?utf-8?B?QnNyaVRDczFDNEF1SHZpY2R5T3VXSnBMeWorUk0xbThFVTNqNFlsRnVWMDd2?=
 =?utf-8?B?N0Vlcktyc3cyU2lrS2I4WlpjcWZ1WkE0R2s4TyswemM4eUJuWGhNc1VKMmVZ?=
 =?utf-8?B?RXlzL3VSMVFiMkoyVDBIZG83eDV2aWp6cFVBY3c4dnVhd2VZSldIdzlQOWFT?=
 =?utf-8?B?UnRvMVlPUWN6VHNyTm5mRklzUEV2NVFNalIycG5SQWZ5V2gyZHltb0YrT243?=
 =?utf-8?B?M1ZqaUFhWk1vSzNqQm5MVjEwSXd4NThsRVA4SEVwZ1NycnMxQmRFd3YxRkZI?=
 =?utf-8?B?ZmxVVnhwalhheS94cFlqZ28xUitLYzExUlBxK0MwRjdhRTN1Ky9DSUhwcm9a?=
 =?utf-8?B?YkViLzNWNC9NeHFBb3YzRy8rV2N6ZXNDUXBCaUhTdzkvQTRCd0dWNW02bWgv?=
 =?utf-8?B?VDc4WXlIQlV4WFVQdk1Kb0VLd2hoNnFvTG1wbmpFbU5VNFJNKzV5UzFFblZF?=
 =?utf-8?B?K1B5ektTdjh4QXV0amVwVzVXL0wzRHZwS2w1WXJtUU80bGFQNGl1RnNsNXNE?=
 =?utf-8?B?ZHlPNlduSjloZGhhcyt6RnBEcE85N09PaTVQSEhreVV2VzFYNGo5aUo0Yldi?=
 =?utf-8?B?N2hVamRIV2dHRjRCbDYzdExyc2ROb1l2OEJkYUVqWGVJR0xTK0s5Qm01VEor?=
 =?utf-8?B?Z3BmUzd1WW5VTHc2MEtpeWx3K1h1Wm9lTCs1RU9IdVA4V1NTMTNwNStFcDdW?=
 =?utf-8?B?L2x6SmNLaHo2N0Z6K0lOb1FmYk1YcHdpYWxmTTVVUGh1MG5kMUZRa3hQRGhv?=
 =?utf-8?B?T2tLVGphS3BTakNEVnFaSVlnUmpmTnBNdEsxcFJsaURib2hNbEhuMW41K2Iw?=
 =?utf-8?B?VmxJM3E4SWwvaFpVazNqa2pHTDBSNEZua2xRVnhzR2IzeGNNamhTL0JwWE5k?=
 =?utf-8?B?MHhRZzFSNHlwU2d2Sm1wNHl4eDNGbWttTjB0M05hSy9EZjdoVXZlRDhJalJ5?=
 =?utf-8?B?amtaVmdKUU9wd2pKUWtycnAxSmNpYWROUC8vOTRxRjRUYzlmWExhZ3cvMzFI?=
 =?utf-8?B?T2F3eTVheTM3OENybFIzUHZpZGZGMC9jdSsrdmhTdU5aQUEzR0JoQXR4YkRz?=
 =?utf-8?B?Q2FqUHAzdlJQM1M4QmRPR0g5bWtoRUg5OHZaZm5SeTB5SlNDdTU5dlpVYS9J?=
 =?utf-8?B?YzlnUU53U2FRTUQweENWbkZia012N2liN2d0RkRNR3BUakZzL1Y2UGp0TkJK?=
 =?utf-8?B?WmpOYVpvSkI2MUMzS0hlOU5TcE5GQU5rVW5XK1hjR2U4dS8rUnZyVHd4dndn?=
 =?utf-8?Q?X0tE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR06MB7704.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c4983de-9453-4402-b7e6-08daa1c7643d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 03:04:57.8051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1qUNnTwMkQmn1ZEnR9qkW87+PtyhHKo71s/EwKqiNK0UUBGtWOCQiAYb9T1D1FBd9JGoOYiqE9lEIvBaa/Gitg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR06MB7766
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_200502_848888_8A5864A7 
X-CRM114-Status: GOOD (  26.48  )
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

SSBzdXJlIGRpZG4ndCBpbnRlbmQgdG8gc2FpZCB0aGF0LiAgU2VjdGlvbiAzLjYuMiB0YWxrcyBh
Ym91dCBzaHV0dGluZyBkb3duIHRoZSBjb250cm9sbGVyICh3aGljaCBsZWF2ZXMgdGhlIGNvbm5l
Y3Rpb24gaW50YWN0KS4NCg0KU2VjdGlvbiAzLjcuMSB0YWxrcyBhYm91dCBOVk0gU3Vic3lzdGVt
IHJlc2V0cyB3aGljaCBjYXVzZXMgY29udHJvbGxlciBsZXZlbCByZXNldHMgKHdoZXJlIGFnYWlu
LCBJIGJlbGlldmUgdGhlIGludGVudCBpcyB0aGF0IHRoZSBjb25uZWN0aW9uIHJlbWFpbnMgaW50
YWN0IC0gc28gdGhlIGhvc3QgY2FuIHVzZSBHZXQvU2V0IFByb3BlcnRpZXMgY29tbWFuZHMgdG8g
cmVzdG9yZSBvcGVyYXRpb24gKGlmIHRoZSBob3N0IHNvIGNob29zZXMpKS4NCg0KVGhvc2UgYXJl
IGNhc2VzIHdoZXJlIHJlc2V0cyBoYXBwZW4gYnV0IHRoZSBjb25uZWN0aW9uIHJlbWFpbnMgaW50
YWN0LiAgVGhlIHNwZWMgc3VnZ2VzdHMgYSAyIG1pbnV0ZSB3aW5kb3cgKHNlZSBzZWN0aW9uIDMu
NS4yKSAtIGxhc3Qgc2VudGVuY2U6DQpUaGUgYXNzb2NpYXRpb24gbWF5IGJlIHJlbW92ZWQgaWYg
c3RlcCA1IChpLmUuLCBzZXR0aW5nIENDLkVOIHRvIOKAmDHigJkpIGlzIG5vdCBjb21wbGV0ZWQg
d2l0aGluIDIgbWludXRlcyBhZnRlciBlc3RhYmxpc2hpbmcgdGhlIGFzc29jaWF0aW9uLg0KU2Vj
dGlvbiAzLjYuMiBvbiBzaHV0ZG93biBzYXlzOg0KQWZ0ZXIgQ0MuRU4gdHJhbnNpdGlvbnMgdG8g
4oCYMOKAmSAoaS5lLiwgZHVlIHRvIENvbnRyb2xsZXIgTGV2ZWwgUmVzZXQpLCB0aGUgYXNzb2Np
YXRpb24gYmV0d2VlbiB0aGUgaG9zdCBhbmQgY29udHJvbGxlciBzaGFsbCBiZSBwcmVzZXJ2ZWQg
Zm9yIGF0IGxlYXN0IDIgbWludXRlcy4gQWZ0ZXIgdGhpcyB0aW1lLCB0aGUgYXNzb2NpYXRpb24g
bWF5IGJlIHJlbW92ZWQgaWYgdGhlIGNvbnRyb2xsZXIgaGFzIG5vdCBiZWVuIHJlLWVuYWJsZWQu
DQpZb3UndmUgZ290IDIgbWludXRlcyB0byByZWVuYWJsZSB0aGUgY29udHJvbGxlciBiZWZvcmUg
ZGlzY29ubmVjdGlvbi4NCg0KVGhlcmUgYXJlIGFsc28gc3RhdGVtZW50cyBpbiB0aG9zZSBzZWN0
aW9ucyB0aGF0IHRhbGsgYWJvdXQgZmF0YWwgZXJyb3JzIC0gd2hpY2ggZG8gY2F1c2UgdGhlIGNv
bm5lY3Rpb24gdG8gZ28gZG93biAoYW5kIHdoaWNoIHRoZXJlZm9yZSwgcmVzZXQgdGhlIGNvbnRy
b2xsZXIpLg0KDQpTZWN0aW9uIDMuNy4yIHRhbGtzIGFib3V0IENvbnRyb2xsZXIgTGV2ZWwgUmVz
ZXRzICh3aGljaCB1c2VzIENDLkVOKS4gQWx0aG91Z2gsIHRoaXMgc2VjdGlvbiBkb2VzIHNheSAt
IHRoYXQgZm9yIG1lc3NhZ2UtYmFzZWQgdHJhbnNwb3J0cyAoZmFicmljcyksIGFsbCBpbnRlcm5h
bCBjb250cm9sbGVyIHN0YXRlIGlzIHJlc2V0IC0gbm8gZXhjZXB0aW9ucy4gIElmIHRoZSBob3N0
IGlzIHRyeWluZyB0byByZWVuYWJsZSBhIGNvbnRyb2xsZXIgYWZ0ZXIgYSByZXNldCBvbiBhbiBl
eGlzdGluZyBjb25uZWN0aW9uLCB0aGVuIGl0IG11c3QgcmVlc3RhYmxpc2ggZXZlcnl0aGluZyAt
IGJlY2F1c2UgZXZlcnl0aGluZyAoYWxsIHN0YXRlKSBoYXMgYmVlbiByZXNldC4gIFRoZSBob3N0
IGNhbid0IGFzc3VtZSBhbnl0aGluZyBoYXMgYmVlbiByZXRhaW5lZC4NCg0KSWYgdGhlIGNvbnRy
b2xsZXIgZG9lc24ndCBnZXQgcmVlbmFibGVkLCB0aGVuIGEgZGlzY29ubmVjdCB3aWxsIGhhcHBl
bi4NCg0KQnV0LCBJ4oCZbSBub3Qgc3VyZSB3aGF0IHRoYXQgaGFzIHRvIGRvIHdpdGggdGhlIE51
bWJlciBvZiBRdWV1ZXMgZmVhdHVyZSBzZXR0aW5nLg0KVGhlIGhvc3QgY2FuIGRvIGEgU0VUIEZF
QVRVUkVTIHRvIHJlcXVlc3QgYSBOdW1iZXIgb2YgUXVldWVzIC0gT05DRSwgYW5kIHRoZSBjb250
cm9sbGVyIHRoZW4gdGVsbHMgdGhlIGhvc3QgaG93IG1hbnkgaXQgcmVhbGx5IGdldHMuDQpUaGVu
LCB0aGUgaG9zdCBjYW4ndCBkbyB0aGF0IGFnYWluIChDb21tYW5kIFNlcXVlbmNlIEVycm9yIGlm
IHlvdSB0cnkpOyBhbmQNClRoZSBjb250cm9sbGVyIGNhbid0IGNoYW5nZSBpdCdzIG1pbmQgYWJv
dXQgaG93IG1hbnkgaXQgZ2F2ZSB0byB0aGUgaG9zdC4NClRoYXQgdmFsdWUgaXMgU1RVQ0sgLSB1
bnRpbCBhIFJFU0VUIGhhcHBlbnMuDQpPbmNlIGEgUkVTRVQgaGFwcGVucywgdGhlbiB0aGVyZSBh
cmUgbm8gcXVldWVzLCBzbyBldmVyeXRoaW5nIG11c3QgYmUgaW5pdGlhbGl6ZWQgYWdhaW4uDQpU
aGUgaG9zdCBnb2VzIHRocm91Z2ggdGhlIHdob2xlIGNvbnRyb2xsZXIgZW5hYmxpbmcgcHJvY2Vz
cyBhZ2FpbiAtIGluY2x1ZGluZyBhIG5ldyBTRVQgRkVBVFVSRVMgdG8gcmVxdWVzdCBhIG51bWJl
ciBvZiBxdWV1ZXMgYW5kIHRoZSBjb250cm9sbGVyIHRlbGxzIHRoZSBob3N0IGhvdyBtYW55IGl0
IGdldHMgdGhpcyB0aW1lLg0KQW5kIGFnYWluLCB0aGF0IG51bWJlciBpcyBzdHVjayB1bnRpbCBh
IFJFU0VUIGhhcHBlbnMuDQoNCklmIHRoZSBjb250cm9sbGVyIHdhbnRzIHRvIGNoYW5nZSB0aGUg
bnVtYmVyIG9mIElPIFF1ZXVlcyAtIHRoZW4gaXQgbXVzdCBmb3JjZSBhIFJFU0VUIC0gYW5kIGNh
dXNlIHRoZSBob3N0IHRvIHBlcmZvcm0gYSBmdWxsIHJlaW5pdGlhbGl6YXRpb24gKGFuZCByZWVz
dGFibGlzaCB3aGF0ZXZlciBpcyB0aGUgYXBwcm9wcmlhdGUgbmV3IG51bWJlciBvZiBJTyBRdWV1
ZXMpLg0KDQpZZXMsIHdoZW4gdGhhdCBSRVNFVCBoYXBwZW5zLCB0aGUgY29ubmVjdGlvbiBjb3Vs
ZCBiZSBkcm9wcGVkLCBidXQgdGhhdCBpcyBub3QgcmVxdWlyZWQuDQoNCglGcmVkDQoNCg0KPiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2huIE1lbmVnaGluaSA8am1lbmVn
aGlAcmVkaGF0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjgsIDIwMjIgMTA6
MTQgUE0NCj4gVG86IEtuaWdodCwgRnJlZGVyaWNrIDxGcmVkZXJpY2suS25pZ2h0QG5ldGFwcC5j
b20+OyBEYW5pZWwgV2FnbmVyDQo+IDxkd2FnbmVyQHN1c2UuZGU+DQo+IENjOiBTYWdpIEdyaW1i
ZXJnIDxzYWdpQGdyaW1iZXJnLm1lPjsgbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnOw0K
PiBTaGluaWNoaXJvIEthd2FzYWtpIDxzaGluaWNoaXJvLmthd2FzYWtpQHdkYy5jb20+OyBoYXJl
QHN1c2UuZGUNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gbnZtZXQ6IGZvcmNlIHJlY29ubmVj
dCB3aGVuIG51bWJlciBvZiBxdWV1ZQ0KPiBjaGFuZ2VzDQo+IA0KPiBOZXRBcHAgU2VjdXJpdHkg
V0FSTklORzogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gRG8gbm90IGNsaWNrIGxpbmtzIG9y
DQo+IG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQg
a25vdyB0aGUgY29udGVudCBpcw0KPiBzYWZlLg0KPiANCj4gDQo+IA0KPiANCj4gT24gOS8yOC8y
MiAxNDowMiwgS25pZ2h0LCBGcmVkZXJpY2sgd3JvdGU6DQo+ID4gUmVzZXQgYW5kIERpc2Nvbm5l
Y3QgYXJlIGRpZmZlcmVudC4NCj4gPg0KPiA+IFJlc2V0IHVzZXMgcmVnaXN0ZXJzIChhbmQgdGhl
cmVmb3JlIEdldCBQcm9wZXJ0eSBhbmQgU2V0IFByb3BlcnR5DQo+IGNvbW1hbmRzKSBvdmVyIGEg
dmFsaWQgY29ubmVjdGlvbi4NCj4gPg0KPiA+IERpc2Nvbm5lY3QgY2F1c2VzIGEgcmVzZXQgKHlv
dSBoYXZlIHRvIHJlY29ubmVjdCB0byB0aGUgcmVzZXQNCj4gPiBjb250cm9sbGVyKSBSZXNldCBk
b2VzIG5vdCBjYXVzZSBhbiBpbW1lZGlhdGUgZGlzY29ubmVjdC4NCj4gDQo+IE9LLCBzbyB5b3Ug
YXJlIHNheWluZyB0aGF0IHRoZSBydWxlICJUaGUgY29udHJvbGxlciBzaGFsbCBub3QgY2hhbmdl
IHRoZSB2YWx1ZQ0KPiBhbGxvY2F0ZWQgYmV0d2VlbiByZXNldHMiIGluIE5WTWUgNS4yNy4xLjUg
ZG9lc24ndCBhcHBseSB0byBmYWJyaWMNCj4gY29udHJvbGxlcnM/DQo+IA0KPiAvSm9obg0KPiAN
Cj4gPiAgICAgICBGcmVkDQo+ID4NCg0K

