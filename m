Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E9BE69186
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2024 18:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FTiDZItwTWCo2K0dInYzxjqAvJbJZMUM6nnY57CZrJo=; b=11ORf17pBP5CIX9qkaDouuw5y0
	Q36vEBcPAM/zXkCW8F8PLoJyoiTOboSxF8ryfJqNDYQeHHHRjZcFglrBF7sK5YT9RGatsOKt5rpHY
	I3E8RKhZDJ15RoqQ6fJQgaV1e0Xyh0arl9ef6MmV1L0XK99MEYiC28FKZx6wejY2eoMuAoSbY7WFf
	1vKquFLdY5w006Js15lIKj9fJ1oa9lrYhyTnTj66umzd407wwpp3pDa2ZbD+EUjI9+lsnwMHqkM8p
	Kctmd/xFBa0U5JdtDSOp08t5iISIU1AePBa0Qj6qorQQ6gZSybl8c86pI1/gqkEUKhc9Nzo0LgLb9
	KOxY35bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEYN4-000000036z6-02Gq;
	Fri, 22 Nov 2024 18:27:10 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEYN0-000000036ya-3QLE
	for linux-nvme@lists.infradead.org;
	Fri, 22 Nov 2024 18:27:08 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMGBb1B002858;
	Fri, 22 Nov 2024 18:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=FTiDZItwTWCo2K0dInYzxjqAvJbJZMUM6nnY57CZrJo=; b=
	A7KEynO4HvFXNrj+Fu444gLdbSlbCYohOg4yBXxy3Yj89RjRpWkDtnCi7PG+7C3K
	UZGhcVetr3KEhnSr5Y8yg56FT5KcnpZJjoKRCnT/T9f6Fv94SZlEd+HVFqh40/qv
	eIX9uRejN6PvoDMzZPHkJ4OifWFfrYFpvvxdbvr0+HddLbuigc8Ac9+7s1useu1e
	ygQIH2JIGmVNasoJSQ88q+gIT/i8ULZr/a/p0DNTmNa3EXC1mnHUPAkubzL/P9+t
	k0T+GXAHWUx/VqvEJKbkI5wt7miizY0UQMGj0v/kdWT+7g/yMnAHJDHRSMBilHGu
	AP1fO0+9urtJG3ob5TT3KA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk98vh83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 18:26:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMGwOow023142;
	Fri, 22 Nov 2024 18:26:52 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhue5nd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 18:26:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xs3PHD5LBgRNUFuUY5zkeKFsoL4JEWz+gA7ukS3rikCus3+vcGk+Uz+pbV7cnoVgjGP645lJgDnvEK5WCg5XjkZt44Vf4RXS6hmGc1vZZW9oulItzOGep/Fcd6Xd2x116piOFJinPDNzrpZV8Tk35OzRN3YGzBLIm1YaBhMkviQuyph5E2dyOq0AVOrQ6idpbydCDydQdd4GR5yvbK87If+/t/iHrueUF+H9v1F1AOClUwnZSTWdJ3o9uQvdX1zZIIeKjY2eHLPmQk5ZFCTPwhSiIa8kmXyCxNeeweBNLZBQ+ScVjVT7wWdmOiT4C0XsvbXcYYVVSQEXQP0Q+V2iLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTiDZItwTWCo2K0dInYzxjqAvJbJZMUM6nnY57CZrJo=;
 b=SAbjf4ikyx/+QwgpkIOObq7O1JiOKEFKeZZjjU1h2zWcb+tr+dJnxREW7A0qgwQ6Af/UP6IG8JGAvuFdQYkh9BEGAV7Ognvlp9/zgQuz/r/gYeNh7UgCt44h2dWOpE6Hhi53rgdjP7lW2yfiI1fifQBOiaqqMd9/xdX+VWoqrRHFAYg6vIG5owDnl9Y2pmlR54wHprRp+Zrq9llu7gGZTomp01U+9UidMDEqcyTvEVZNhDG7pEy13UdNq+cm0BaDwViMwolRdF2EZnONoRbL9MSMANe3cDIytu+dCbh52OVjlZDhWgSl8XPvvmnl7Dj2ZVjArEzoqO3+SkvvZ2hjqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FTiDZItwTWCo2K0dInYzxjqAvJbJZMUM6nnY57CZrJo=;
 b=MCZBIVdY2mA23fPUYwn3Dcrdtt8WIUA/uHE629mWUH008eY/p0792P/8IrgidpHBQ0mdidzlgNu60p27CD7Zt/Fhu2vfSC4c3ILKTCf/x8Oa8JFDxaIGd+7ljZoclV59fYMPFPgDmZDuvy3nofyzP2GZ2bzbEFRHbaTHSdJfjKM=
Received: from SJ2PR10MB7860.namprd10.prod.outlook.com (2603:10b6:a03:574::11)
 by DS7PR10MB7156.namprd10.prod.outlook.com (2603:10b6:8:e0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.22; Fri, 22 Nov 2024 18:26:47 +0000
Received: from SJ2PR10MB7860.namprd10.prod.outlook.com
 ([fe80::3c8f:5ef8:3af5:75b8]) by SJ2PR10MB7860.namprd10.prod.outlook.com
 ([fe80::3c8f:5ef8:3af5:75b8%4]) with mapi id 15.20.8158.023; Fri, 22 Nov 2024
 18:26:46 +0000
From: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
To: Paul Webb <paul.x.webb@oracle.com>
CC: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Phil Auld
	<pauld@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Ramanan
 Govindarajan <ramanan.govindarajan@oracle.com>,
        Sagi Grimberg
	<sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Nicky Veitch
	<nicky.veitch@oracle.com>
Subject: Re: [External] : Re: [bug-report] 5-9% FIO randomwrite ext4 perf
 regression on 6.12.y kernel
Thread-Topic: [External] : Re: [bug-report] 5-9% FIO randomwrite ext4 perf
 regression on 6.12.y kernel
Thread-Index: AQHbO5QQcHjoRAVwOUOCdWnBaPnbU7LA2Y0AgAAWUACAAKqmAIAAN3YAgABpoQCAAP0BAIAAVT+AgAATHYA=
Date: Fri, 22 Nov 2024 18:26:46 +0000
Message-ID: <14F95ECE-2AB7-4A50-AE45-C98EC426312C@oracle.com>
References: <392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com>
 <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com>
 <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk>
 <20241121113058.GA394828@pauld.westford.csb>
 <a01ead6b-bd1d-4cd3-ade6-59ad905273e7@kernel.dk>
 <181bcb70-e0bf-4024-80b7-e79276d6eaf7@oracle.com>
 <20241122121304.GA25877@lst.de>
 <188e08f4-2eb3-41ad-a331-63fd5bb0e7f6@oracle.com>
In-Reply-To: <188e08f4-2eb3-41ad-a331-63fd5bb0e7f6@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR10MB7860:EE_|DS7PR10MB7156:EE_
x-ms-office365-filtering-correlation-id: ce26e181-6e47-4205-9a78-08dd0b23390a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QmQ3OVFMbHE4UUtHRnJHTG00NDdPYTZseDd6YitYZGJXN3J4ODAraS8vcklr?=
 =?utf-8?B?OGVSTnBseWhmVStQcjZ1T2R3aDFqYzRsYTBmdXlpa3EwTk9ZMmJhMU54R1lF?=
 =?utf-8?B?cU1KNVlaYXZlZ3VCQThlMjlGV0VDM0phbEJmU3doNnRaWU5sTEVrY3B2anQy?=
 =?utf-8?B?TTYrMkk0M1IxbUIzS2xqVDc0dERYYkRPeWd6MTIwYmRsYmhyV3lhdFJnVm1X?=
 =?utf-8?B?SFhtVUZtTVZ1ZFBPQjgrcmQ3TVRQMk8xUlBscFEzT1UxdTQ4NE5XNCtJelpt?=
 =?utf-8?B?OUlpc2dsUGlhRVBFRmpKZHkyTFQ0a0NoN0gwVHlVcG10b3JGMkVqa004bjBI?=
 =?utf-8?B?YnR3b29TQmVjSDZHOU9aaExVbjJvSGJjMGJveGJFSnd5dWpjQ3RXZlpROThv?=
 =?utf-8?B?eEM3L0dTOXZobmt2QmpHZzdrOE1RbVNPQVorQkN6MkdRbDlMTExwUmQvY0hr?=
 =?utf-8?B?TnhWVnh5QWlhUk1qMzZCeUR0ZGZRdnViVHNnSGJFT1dpZnJDSDlaakFhalNU?=
 =?utf-8?B?UlZvS1NUMW0xckJwaWtoWitjbE92MnpVcGRDb2ZobUpJcXZ2eisyeDBzNDVK?=
 =?utf-8?B?Z0dpSFBvTG9xclMyU3JJa1pZRHpRalZSWVVEcXhMR1VFbVQ4VGl4VUs0YVUv?=
 =?utf-8?B?dDdod2hORVhFMEpzZEZaRCs5cUNJc1pJUTdSTVBUVWlmYnAwU2tIRXdBamxu?=
 =?utf-8?B?YSt5TzRmZmM2TW1GaHBEUGlDN1UrRVJ1WEp4SlZ0V1RUbEY2M1JEOThXVit1?=
 =?utf-8?B?U3BiK1ZoS2VlN0VWU1FUSFVhVmk5RytJcmp6RC9WUGM1M0pwcHI5TEkzak96?=
 =?utf-8?B?ekhPaklaM3lNbUNGYVJwUDVOOWJmbzZJS2xPbFdIZnFTL0M1amtZWWRyanIx?=
 =?utf-8?B?a2NOYm9zb1E1bmxYL1Y1VEdTN2FCUlNCaFJYbEI0QnVzbVlESVJWQVR4QzNo?=
 =?utf-8?B?akxWUXlSeTd1RWwyR2JzVFNzUXhyVm8vS1ZUZ1NRNWp1cWlBYXpoSVFwOUdo?=
 =?utf-8?B?S1JTSUVDQllzZlpZZ2g3Nm1uTU5oWHdyNTBLc3A2clZQUWFOUlRXcWEySVdl?=
 =?utf-8?B?c2pnN210QVVpNy9xZU1OVEdzZTd3QW0vM2lQQlg2VDJzeHdid3lXSlpUQ3JT?=
 =?utf-8?B?ZXFQc1hLTlFOaXlCZmJyMUV3L0ZISEdnQUtIWm5tMWl0QXhoV1Y0MUZ6akRv?=
 =?utf-8?B?REtITG9yS2dtaDZkTkJBYkRJTnBKZW5nZDZqS2lXV0V6UmVUbldMSmY0TjRj?=
 =?utf-8?B?WXFKa0xBQ1daMVdXUVYyblhoY3dJTTZ4eW5FNXdKYSt5dk5FT2dFNUJlNll2?=
 =?utf-8?B?QWJLVWVrbXR4UjFuRGVwTEFONFFMeUwyVnBMbENBVUNnci9Wa1VyQWRNV2pr?=
 =?utf-8?B?VFpqYUZRL3NjOVY4ckJSeVBVOG9FajZ1TllVOU0vZHJiTHBSbWZJRlhVVUtk?=
 =?utf-8?B?S2poVk1ESUpvbTZ5clE1eDdpa05zcnNRK1I3VHY3WXRPbW8wWXBsakd2ckxa?=
 =?utf-8?B?c2ROKzNqMXNHS1ovZGN0djl1elZDYllVU3lOT3pzUHM0aWtTZHZMYWwxZE5z?=
 =?utf-8?B?ZVRlQXY0MmJDREw5NmpTSmp0V2l4YnRQVlZDZXZuMWFLTERyK3hUb1VrcG02?=
 =?utf-8?B?VmhJNWoyTlNpVHhHaDlmS2RoSnJzeXhvSzhSRytBWktDc1RSM2c3Tk5pdEo5?=
 =?utf-8?B?cmdNQUFpbU96cERDNzdQVE0zb0psV05aVzJUazFGc1BSRmJ6SE5CdHdWelR3?=
 =?utf-8?B?QTJPZFp4OW9aK25NTlVuYmgwbFc3NU10d3BOVVI4TVhnVDMzYWhVZnFPbUFJ?=
 =?utf-8?Q?MjRYFDm3TkQuy36ce1zrqzcbmF+/RehNEMcuM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7860.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0pYV2VnMENmTFZOTzNxdTJOSWl0OWgwZGlqeWxwN0tkaStmUnFwMjBVQ0dV?=
 =?utf-8?B?SGVxcnZFTzBYTkxaNjlyMVFoQnY2YmY2WGpZWFVmU1ZRRGpFcFllalVBeTJl?=
 =?utf-8?B?L3F0RkNRdjhCcHJ2SXpDVHgyVUY4cEhxdExEZENRY0lhVDRqWnF3cVByQjAy?=
 =?utf-8?B?bGdXTzlHbTZDNlU0U0Z2NzNzZG1QREozTmJjS1JjTGc3dGhybzdyVGtrRUI5?=
 =?utf-8?B?eTlFYXNIdXZWSHBVNmR6a0RRM2l6QjFUNG01YjFSemNlRUhTNDN2Nk12c3NN?=
 =?utf-8?B?eWpWREpMTHVDVHZ1RFNHK2FraldwUUEyZFpsUEJEblV0QXo2SVlLdkw0V1kz?=
 =?utf-8?B?VHI2VkZhc3NEekxOamhwMU5HVEVDNktUenczeGYweGxpeWNwR0k2MWRNWTlM?=
 =?utf-8?B?SEQzM3dkZ1R6c1pkNXVXQUt4YlJDL21kVFQ2OXFSZ1ZVZ1dRSFMvNUFQUno2?=
 =?utf-8?B?UTJQWS91K0wxc0pOR0tzWncvSVFBTkV0MDd4cjN6UklMK1dtdlMxSXdWR2lW?=
 =?utf-8?B?V3BPQlJ5eU1EUjJxUER4V3hWQURGaEt0TW51QUpOQUdyQ1dTTHBBSWpSQ2ta?=
 =?utf-8?B?OGRGRnVGSUhqeGo5RmVDaXZUWjRESFhSQ0RhYkkvZ0NrTno5TG1GMWVBcjBY?=
 =?utf-8?B?NlR3TGhucHZQdkYyUjVvQW82UFNkdWJIZDdrREt2VkxoY3JqQXRkbUVMaGlz?=
 =?utf-8?B?RGQyTVhaOGFhMGQySitLYXcxR3dMQVpZZWFxVklhaTIzRVIzU05keFpKank3?=
 =?utf-8?B?RVVRMW5Hb1VTbGkwNXljRWZhQzFSM0xzZTU5YytkeVp2REg1bGR1aGdLa3pD?=
 =?utf-8?B?dzk0TXRkVXo1TVdhRnc2MlhtNGJ2MmlUTzdzdFB0dkZrdk9aK3ZqNkJLMnZi?=
 =?utf-8?B?R21zTnJCdFNPaDRTOVdBcUpuSVE2ejhDTXNIaDhvVWUxUEhXblExaVlFUmxM?=
 =?utf-8?B?b0hxL0tRK3JqMW4zbStwOXNxNTNlamFybWJLUHd5Zy9NZ2hmVEcrWjBvU1g2?=
 =?utf-8?B?U0RGT3p2cFBLbG4yOHI3OWR3bTAzc3dUSGZBSkVlWmpjdmwxZXUycVJqUGkx?=
 =?utf-8?B?QWFGNW41S205VWRxTTc5RnlCVHVVZnJjelBWZThuZ3N5OE5mU25GdHp5QWlE?=
 =?utf-8?B?emd0L1ZzMkpPMGFSY1NZcmhKOXZkVjI3eXBKUTNza0c5VXZGRE5wQkZQKzFR?=
 =?utf-8?B?RmR0cTMyNlRWTExwRlFpbk9DR2NvdmgzZUxBUmppT1Ivc3h4NnNMdElpbDZ0?=
 =?utf-8?B?OGJrNU94d0pha2p0WS9rZkVSQitCTE0wVVJDMHYxc01kcE56R290YzEyU1V0?=
 =?utf-8?B?d3BuRll4ZXlsWDJoWHZKdWRvd21KWWRGQWgydDhOeUx5dkRiN2h5aytjQmd0?=
 =?utf-8?B?MGJJME5DMHVqUWxhU1IwR0Rnd2M4WE5KSFh5SjJYSFpnV3g0U012RmhRYU8x?=
 =?utf-8?B?emp5ejFJU2xNazh3WGVIa3g3Zm41US9NbjFXY0E0ZUcvNUMzMXpTRXRMMjYz?=
 =?utf-8?B?cDV2SUczeGFnQmsvT1JUdHI1NzZTaUIwQjA3enhYOFZXeEhuajJGOXBSWGl1?=
 =?utf-8?B?NjQwL3kxV2xsUlVvNUFVMnBITkdoNW9GS2RtdnVoOS9sdjdHTXo4UllTd1Fq?=
 =?utf-8?B?U0tYVlVjS2pBcGNrdDNaemhlQzZNVUlRc3IwdE5Uc29kaU00VWU2TC96Rm5W?=
 =?utf-8?B?OEMwV21LVkFKcm9XU0hXTEpOSFVScTI2ME9aeTdEWVAvQjZ5UnNnZ3Q2em1w?=
 =?utf-8?B?SWtWUEhJdjZCa1R2MG1mMVNSNGU2UlYyMG5CSTE4eUtNQ1gzellCTnNPV0py?=
 =?utf-8?B?OTk1NzZkMEV2eXYvK2RMem9ZSXhMVU1FNVlPWmtKdFFmTVRiKzVaNGdickdF?=
 =?utf-8?B?RURxU3V6TmV4cUxCS01DUkJCRDFjTEwyNndnL2wyUEZMRU4zaktBdUdic1NH?=
 =?utf-8?B?Y05uQXNWdnFYM3Z6YzRGK1dNcHpIRnBIMEdZS3dnQ2pUdE5Cd204dkgybnNY?=
 =?utf-8?B?bjlaZXljU0RMRlNHblQxRnIwLyt3cm5XSXRTY2U4bnhXbjNrTmNYYW1QZ01Q?=
 =?utf-8?B?bXZiTGZXVzNRTkozTi9reWEzQ0RBUFBDWjVFVDUzcGJmczhqM0lnVjdHakZP?=
 =?utf-8?B?SWMzWjR5K3dJeGV3STRRMm9KY29WMEFaYndwNHA3ZHpSRE5rRkYzTXdiVmpa?=
 =?utf-8?Q?NeWh7JsdIvcjzgEEw0UQAvU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D3588D284A73C4683EAC2243E37A113@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Td3E3zZPWzd2xc0U4L7FLoyr8urY8t2Zd53y30YfF8a4c4IAVFS/QUJAcJ4Cm28IMtFLBkdchGDbwwzgv3IWmUYNusL8+es2EmV9uLXeS381yfK4VWxQr3nqioRV1RIKq7/c4FNpFV8NvTozqqoEMMwRVP+TMsNV7ApgmeaRwqOTjISR/MVsP9nRd034Kg9RZT3o6RAL0ph8RPY/irq2uchjCHVbAC4gfKoFwmwVja3QzpO3tGwL/ddbCD7stAhlwbSCRjB/BevWGRrwrKK6fbaF+hAHYeHlnZo5fSIdJ2Z8IDpFgFG0NSFvXjPlUDhdQQJ3xuioTUSkTf5aWC+5UCMZ39MonBZemYenGu7lCkATi6rgvVHgSzxL/cSNUKagCR2kMEpeAjSQQ+minLJo4ya+Hak4GgsLs7QPd1iKGHH7ousOxxLE8yLKClPVNLMuT+bCVofWb2zYeJp1MZiQ825tFJYk2Lwa4xlhH3nwDjauMljUxAR4I/nOAvYIzg6vkj28MeNj9c8mCc/b/Vxg+VEh+cZzVUPTEu4Uopp6b9i70TXDIeGTZTiFCM7QXFg+BhLmdw2vWRHNpipWxG81DhQJH9ZoSO+AbhK6vH91TqA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7860.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce26e181-6e47-4205-9a78-08dd0b23390a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2024 18:26:46.4780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wEz6ZngYYzbj0N5HyXsizYIewoIlj3xP6/5z9idNOxurBtxmSIuEQKktTQW2whDjdbTVi0FyDP4RBr0N5ciMbOu6PqtXSOpVoUQj6p1apq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-22_11,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411220155
X-Proofpoint-ORIG-GUID: 9HyYjCxr10aJROdXac6KPhFpLAjDxtJN
X-Proofpoint-GUID: 9HyYjCxr10aJROdXac6KPhFpLAjDxtJN
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_102706_862030_2FFFBEA1 
X-CRM114-Status: GOOD (  13.52  )
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

RllJLCBUcmllZCBkaXNhYmxpbmcgd3JpdGUgemVyb3MgYnV0IHN0aWxsIGdldHRpbmcgdGhlIHNh
bWUgZXJyb3JzOg0KWyAzMjYuMDk3Mjc1XSBvcGVyYXRpb24gbm90IHN1cHBvcnRlZCBlcnJvciwg
ZGV2IG52bWUybjEsIHNlY3RvciAxMDYyNCBvcCAweDk6KFdSSVRFX1pFUk9FUykgZmxhZ3MgMHg4
MDAgcGh5c19zZWcgMCBwcmlvIGNsYXNzIDANClsgMzM4LjQ5NjIxN10gbnZtZTBuMTogRGF0YXNl
dCBNYW5hZ2VtZW50KDB4OSkgQCBMQkEgMTA5MjgsIDI1NiBibG9ja3MsIEludmFsaWQgQ29tbWFu
ZCBPcGNvZGUgKHNjdCAweDAgLyBzYyAweDEpIEROUg0K4oCmIA0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9udm1lL2hvc3QvcGNpLmMgYi9kcml2ZXJzL252bWUvaG9zdC9wY2kuYw0KaW5kZXggZDNi
ZGUxN2M4MThkNS4uYWQyY2U2MDA4MDYyZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0
L3BjaS5jDQorKysgYi9kcml2ZXJzL252bWUvaG9zdC9wY2kuYw0KQEAgLTM0MjUsNyArMzQyNSw4
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCBudm1lX2lkX3RhYmxlW10gPSB7
DQogICAgICAgICAgICAgICAgLmRyaXZlcl9kYXRhID0gTlZNRV9RVUlSS19TVFJJUEVfU0laRSB8
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5WTUVfUVVJUktfREVBTExPQ0FURV9a
RVJPRVMgfA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVk1FX1FVSVJLX0lHTk9S
RV9ERVZfU1VCTlFOIHwNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlZNRV9RVUlS
S19CT0dVU19OSUQsIH0sDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5WTUVfUVVJ
UktfQk9HVVNfTklEIHwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlZNRV9RVUlS
S19ESVNBQkxFX1dSSVRFX1pFUk9FUywgfSwNCiAgICAgICAgeyBQQ0lfVkRFVklDRShJTlRFTCwg
MHgwYTU1KSwgICAvKiBEZWxsIEV4cHJlc3MgRmxhc2ggUDQ2MDAgKi8NCiAgICAgICAgICAgICAg
ICAuZHJpdmVyX2RhdGEgPSBOVk1FX1FVSVJLX1NUUklQRV9TSVpFIHwNCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgTlZNRV9RVUlSS19ERUFMTE9DQVRFX1pFUk9FUywgfSwNCg0KDQpU
aGlzIGlzIGZvcjoNCiAgICAgICAgeyBQQ0lfVkRFVklDRShJTlRFTCwgMHgwYTU0KSwgICAvKiBJ
bnRlbCBQNDUwMC9QNDYwMCAqLw0KDQpBbmQgYXMgd2UgY2FuIHNlZSBmcm9tIGxzcGNpOg0KJCBs
c3BjaSAtbm4gfCBncmVwIC1pIG52bWUgMTk6MDAuMCBOb24tVm9sYXRpbGUgbWVtb3J5IGNvbnRy
b2xsZXIgWzAxMDhdOiBJbnRlbCBDb3Jwb3JhdGlvbiBOVk1lIERhdGFjZW50ZXIgU1NEIFszRE5B
TkQsIEJldGEgUm9jayBDb250cm9sbGVyXSBbODA4NjowYTU0XQ0KMjA6MDAuMCBOb24tVm9sYXRp
bGUgbWVtb3J5IGNvbnRyb2xsZXIgWzAxMDhdOiBJbnRlbCBDb3Jwb3JhdGlvbiBOVk1lIERhdGFj
ZW50ZXIgU1NEIFszRE5BTkQsIEJldGEgUm9jayBDb250cm9sbGVyXSBbODA4NjowYTU0XQ0KOTQ6
MDAuMCBOb24tVm9sYXRpbGUgbWVtb3J5IGNvbnRyb2xsZXIgWzAxMDhdOiBJbnRlbCBDb3Jwb3Jh
dGlvbiBOVk1lIERhdGFjZW50ZXIgU1NEIFszRE5BTkQsIEJldGEgUm9jayBDb250cm9sbGVyXSBb
ODA4NjowYTU0XQ0KOWI6MDAuMCBOb24tVm9sYXRpbGUgbWVtb3J5IGNvbnRyb2xsZXIgWzAxMDhd
OiBJbnRlbCBDb3Jwb3JhdGlvbiBOVk1lIERhdGFjZW50ZXIgU1NEIFszRE5BTkQsIEJldGEgUm9j
ayBDb250cm9sbGVyXSBbODA4NjowYTU0XQ0KDQoNCj4gT24gTm92IDIyLCAyMDI0LCBhdCA5OjE4
4oCvQU0sIFBhdWwgV2ViYiA8cGF1bC54LndlYmJAb3JhY2xlLmNvbT4gd3JvdGU6DQo+IA0KPiAN
Cj4gT24gMjIvMTEvMjAyNCAxMjoxMywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+PiBPbiBU
aHUsIE5vdiAyMSwgMjAyNCBhdCAwOTowNzozMlBNICswMDAwLCBQYXVsIFdlYmIgd3JvdGU6DQo+
Pj4gQ2hyaXN0b3BoOg0KPj4+IFRvIGNoZWNrIGZvciB3ZWlyZCBsYXp5IGluaXQgY29kZSB1c2lu
ZyB3cml0ZSB6ZXJvZXMNCj4+PiANCj4+PiBWYWx1ZXMgaW4gdGhlIDUuMTUga2VybmVsIGJhc2Vs
aW5lIHByaW9yIHRvIHRoZSBjb21taXQ6DQo+Pj4gJCBjYXQgL3N5cy9ibG9jay9udm1lKm4xL3F1
ZXVlL3dyaXRlX3plcm9lc19tYXhfYnl0ZXMNCj4+PiAwDQo+Pj4gMA0KPj4+IDANCj4+PiAwDQo+
Pj4gDQo+Pj4gVmFsdWVzIGluIHRoZSA2LjExIGtlcm5lbCB0aGF0IGNvbnRhaW5zIHRoZSBjb21t
aXQ6DQo+Pj4gJCBjYXQgL3N5cy9ibG9jay9udm1lKm4xL3F1ZXVlL3dyaXRlX3plcm9lc19tYXhf
Ynl0ZXMNCj4+PiAyMTk5MDIzMjU1MDQwDQo+Pj4gMjE5OTAyMzI1NTA0MA0KPj4+IDIxOTkwMjMy
NTUwNDANCj4+PiAyMTk5MDIzMjU1MDQwDQo+PiBUaGFua3MhICBTbyA2LjExIGFjdHVhbGx5IGVu
YWJsZXMgd3JpdGUgemVyb2VzIGZvciB5b3VyIGNvbnRyb2xsZXIuDQo+PiANCj4+PiBBbm90aGVy
IGludGVyZXN0aW5nIGRhdGFwb2ludCBpcyB0aGF0IHdoaWxlIHBlcmZvcm1pbmcgc29tZSBydW5z
IEkgYW0NCj4+PiBzZWVpbmcgdGhlIGZvbGxvd2luZyBvdXRwdXQgb24gdGhlIGNvbnNvbGUgaW4g
dGhlIDYuMTEvNi4xMiBrZXJuZWxzIHRoYXQNCj4+PiBjb250YWluIHRoZSBjb21taXQ6DQo+Pj4g
DQo+Pj4gWyAgNDczLjM5ODE4OF0gb3BlcmF0aW9uIG5vdCBzdXBwb3J0ZWQgZXJyb3IsIGRldiBu
dm1lMm4xLCBzZWN0b3IgMTM5NTIgb3AgMHg5OihXUklURV9aRVJPRVMpIGZsYWdzIDB4ODAwIHBo
eXNfc2VnIDAgcHJpbyBjbGFzcyAwDQo+PiAuLiB3aGljaCBpdCBkb2Vzbid0IGhhbmRsZSB3ZWxs
Lg0KPj4gDQo+Pj4gWyAgNDczLjUzNDU1MF0gbnZtZTBuMTogRGF0YXNldCBNYW5hZ2VtZW50KDB4
OSkgQCBMQkEgMTQwMDAsIDI1NiBibG9ja3MsIEludmFsaWQgQ29tbWFuZCBPcGNvZGUgKHNjdCAw
eDAgLyBzYyAweDEpIEROUg0KPj4gLi4gYW5kIGludGVyZXN0aW5nIHRoaXMgaXMgZm9yIGEgRGVh
bGxvY2F0ZSwgd2hpY2ggc2hvdWxkIG9ubHkgaGFwcGVuDQo+PiB3aXRoIHRoZSBxdWlyayBmb3Ig
Y2VydGFpbiBJbnRlbCBjb250cm9sbGVycyBmcm9tIHRoZSB2ZXJ5IGZpcnN0IGRheXMgb2YNCj4+
IG52bWUuDQo+PiANCj4+IFdoYXQgY29udHJvbGxlciBkbyB5b3UgaGF2ZT8gIENhbiB5b3UgcG9z
dCB0aGUgb3V0cHV0IG9mIGxzcGNpIGFuZA0KPj4gIm52bWUgbGlzdCI/DQo+IA0KPiBIaSBDaHJp
c3RvcGgsDQo+IA0KPiBUaGUgbnZtZSByZWxhdGVkIG91dHB1dCBmcm9tIGxzcGNpIGlzIGFzIGZv
bGxvd3M6DQo+ICQgbHNwY2kgfCBncmVwIC1pIG52bWUNCj4gMTk6MDAuMCBOb24tVm9sYXRpbGUg
bWVtb3J5IGNvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIE5WTWUgRGF0YWNlbnRlciBTU0Qg
WzNETkFORCwgQmV0YSBSb2NrIENvbnRyb2xsZXJdDQo+IDIwOjAwLjAgTm9uLVZvbGF0aWxlIG1l
bW9yeSBjb250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiBOVk1lIERhdGFjZW50ZXIgU1NEIFsz
RE5BTkQsIEJldGEgUm9jayBDb250cm9sbGVyXQ0KPiA5NDowMC4wIE5vbi1Wb2xhdGlsZSBtZW1v
cnkgY29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRpb24gTlZNZSBEYXRhY2VudGVyIFNTRCBbM0RO
QU5ELCBCZXRhIFJvY2sgQ29udHJvbGxlcl0NCj4gOWI6MDAuMCBOb24tVm9sYXRpbGUgbWVtb3J5
IGNvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIE5WTWUgRGF0YWNlbnRlciBTU0QgWzNETkFO
RCwgQmV0YSBSb2NrIENvbnRyb2xsZXJdDQo+IA0KPiANCj4gJCBzdWRvIG52bWUgbGlzdA0KPiBO
b2RlICAgICAgICAgICAgICAgICAgR2VuZXJpYyAgICAgICAgICAgICAgIFNOIE1vZGVsICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTmFtZXNwYWNlIFVzYWdlICAgICAgICAgICAg
ICAgICAgICAgIEZvcm1hdCAgICAgICAgICAgRlcgUmV2DQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0t
LSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0gLS0tLS0tLS0tLS0tLS0tLS0tLS0gLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAtLS0tLS0tLS0tIC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tIC0tLS0tLS0tLS0tLS0tLS0gLS0tLS0tLS0NCj4gL2Rldi9udm1lMG4xICAgICAg
ICAgIC9kZXYvbmcwbjEgICAgICAgICAgICBQSExOOTQyMTAwRVE2UDRDR04gNzM2MTQ1Nl9JQ1JQ
QzJERDJPUkE2LjRUICAgICAgICAgICAgICAgICAweDEgICAgICAgICAgNi40MCAgVEIgLyA2LjQw
ICBUQiAgICA1MTIgICBCICsgIDAgQiAgIFZEVjFSTDA2DQo+IC9kZXYvbnZtZTFuMSAgICAgICAg
ICAvZGV2L25nMW4xICAgICAgICAgICAgUEhMTjk0MjEwMFBFNlA0Q0dOIDczNjE0NTZfSUNSUEMy
REQyT1JBNi40VCAgICAgICAgICAgICAgICAgMHgxICAgICAgICAgIDYuNDAgIFRCIC8gNi40MCAg
VEIgICAgNTEyICAgQiArICAwIEIgICBWRFYxUkwwNg0KPiAvZGV2L252bWUybjEgICAgICAgICAg
L2Rldi9uZzJuMSAgICAgICAgICAgIFBITE45NDE1MDAyQjZQNENHTiA3MzYxNDU2X0lDUlBDMkRE
Mk9SQTYuNFQgICAgICAgICAgICAgICAgIDB4MSAgICAgICAgICA2LjQwICBUQiAvIDYuNDAgIFRC
ICAgIDUxMiAgIEIgKyAgMCBCICAgVkRWMVJMMDYNCj4gL2Rldi9udm1lM24xICAgICAgICAgIC9k
ZXYvbmczbjEgICAgICAgICAgICBQSExOOTQyMTAwRFE2UDRDR04gNzM2MTQ1Nl9JQ1JQQzJERDJP
UkE2LjRUICAgICAgICAgICAgICAgICAweDEgICAgICAgICAgNi40MCAgVEIgLyA2LjQwICBUQiAg
ICA1MTIgICBCICsgIDAgQiAgIFZEVjFSTDA2DQo+IA0KDQo=

