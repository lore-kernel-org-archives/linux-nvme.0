Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C12FC83F27
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jul 2025 18:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TTiCy1/SFwjfkAG7kPuaAK4LVVVl6UCDEBxjDkBhpjM=; b=jQo+FEYrnUW+DX6gPNhzTuNN9c
	e522qdOFhZLY9pg1tm57DPizj1UXa2Gn81bXW1EVjM43aC0ogdPAt2NLBmaUeBQanUriim8DJ4MhW
	QLjKBJ0iJ0xMSYwYQjkeTxUKmKkW9AhQh8BZ2Dl9PObYmx0wBskkDnW79oAF4ZtQOhToCjDP6a1Xw
	rqeN0Q0QwfvK/evqJkgCafL09mClqL3GGzotLwYXF3gQIBkZc9AXD5LfmfqJVlDvt9/QlLTvM8qce
	2c2CtQC7oe5nzniA+3tU9GE069I1o8iZ4hJlFrekNL4rSmzpWby9Mi8CBh7prQijEvH6TqfZuKntG
	bqIF2Sag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueHLi-00000003D8L-00BV;
	Tue, 22 Jul 2025 18:04:22 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueFwR-000000032Up-0x2m
	for linux-nvme@lists.infradead.org;
	Tue, 22 Jul 2025 16:34:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753202051; x=1784738051;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TTiCy1/SFwjfkAG7kPuaAK4LVVVl6UCDEBxjDkBhpjM=;
  b=h0SCkTxdCQKrvool8a4aF9HliWRjwbfmZJcKS3dh9ne67SdXea3yiduK
   0wmmbUBu/FpG1ZbeOABANKiRgJSR6rUAJyMDKwhlfdL5kbe10O2DA1OrR
   NqlY7y1UOcpltNptIFPdqT4r0UFQW+9zCGz5GnSc8UrZv2FRt2UW1Qq2o
   nPw83MIAOtGfpYwfe3fxKkFHHTbEx8BcZ+mOX18KZiwoUOthra0B7mEq5
   mVDFKG1ggJie3XCepSNRdLZZRTp56XOArhqHYWY7mMBJ/hZAt7R7VvLxb
   dGIfpgROHE1hWQnJUXBEJ7CZqRy8LzqDOixnRDfLvrUuGbnPGI8BQg6uH
   w==;
X-CSE-ConnectionGUID: 6bQ8EvNhSZO7xLBFwBc+lQ==
X-CSE-MsgGUID: ITnH3qXQR2moSMdkYvLk7A==
X-IronPort-AV: E=Sophos;i="6.16,331,1744041600"; 
   d="scan'208";a="94917991"
Received: from mail-northcentralusazon11010020.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.20])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jul 2025 00:34:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsrGmfFu/qUqLcAqfKgJ8CUovnTI/bBr0w2MFRG3P1/yPOydB6W+y+XaFfg08aUiIunGlYJwXui9xPPGPLW8myQZZQRDdrliuWhwE1J7vgDULIP+CrD3MxwQUv2g4XGqXAhu0oSx5nfa7zjuY1EbPgDMXjoZmWxItJGNZeDyYtp2FfPkQkDCjHFE9DgbySQBjCgdbOEoimvjwd887v5WYGVycPF0ATY1dRoNODyFT2bMuSsbNtYRQlYqqZs+os+wZ15ayw2BjCcG1DalLXiTl/SzdomnhOY/y4RJisL5RRCmhhfry+mSu95JrglMnqWBBTxsUyNUiFAhocABK3Otng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTiCy1/SFwjfkAG7kPuaAK4LVVVl6UCDEBxjDkBhpjM=;
 b=Z7HEHmBx1EMa4B6w6XwjFck6/7gP9/1DGiDfl035jk2UBfKRkxFMYhn1p6SPFe8u1WqkIvAVaO/dqxwudSOa+qJqnuxLAvBxqrll0H9Fs/6kJ71LyDJexmV+qtknNPQptKaOeqvhDVvdRJSSbR48jJpoHFsHiVAYGAJQjiNCbUjdX18L4pYfjWfSJ5XbtarEvTbrliTr60DB6l+/3Ssvt7Xi9mKqP+P3SDKcORiSihJYoWVbtFKY6mmJ9N/mbsFLdmdSZZusvB+rvXCnAwxyPxBtndh42jMj//fzPgZpwUiRrele1ISEeZFfsJ55gtZEz2ufel3SPEsXBB+5e8KF0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTiCy1/SFwjfkAG7kPuaAK4LVVVl6UCDEBxjDkBhpjM=;
 b=gLox1mRcIHnkMlZUlkBiEMyI6MJ1YSM3FQ3AfbpxZezQ7E9pB+bdGQbF+E1FcC7XvSPzEHT3BzkPU98Ix/LuMIy/1vKk6o2+cUeGVwDxLTqrPMbWqu2yu5sY0oEdmmYb/EnWyJ3bTkiie7lsE0NTlw03P54vlrYZXMbacFbbLdU=
Received: from BY5PR04MB6849.namprd04.prod.outlook.com (2603:10b6:a03:228::17)
 by SN4PR04MB8365.namprd04.prod.outlook.com (2603:10b6:806:200::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 16:34:06 +0000
Received: from BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::a414:8a6d:1caa:13d5]) by BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::a414:8a6d:1caa:13d5%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 16:34:05 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: hch <hch@lst.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, hch <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>
Subject: Re: [PATCH v4 2/2] nvme: prevent admin controller from smart log
 fetch (LID 2)
Thread-Topic: [PATCH v4 2/2] nvme: prevent admin controller from smart log
 fetch (LID 2)
Thread-Index: AQHb+mYXMAEuLxyp1ESYRJA9jnnQSrQ9r1+AgAChYwo=
Date: Tue, 22 Jul 2025 16:34:05 +0000
Message-ID: <BY5PR04MB6849574654806676E024F16DBC5CA@BY5PR04MB6849.namprd04.prod.outlook.com>
References: <20250721173700.4153098-1-kamaljit.singh1@wdc.com>
 <20250721173700.4153098-3-kamaljit.singh1@wdc.com>
 <20250722063015.GC15013@lst.de>
In-Reply-To: <20250722063015.GC15013@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6849:EE_|SN4PR04MB8365:EE_
x-ms-office365-filtering-correlation-id: ddf86446-46f3-4070-0f53-08ddc93d9330
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?mPaXvl2kXk2x9sHrg/R4rj9Pyz14NYbKUe92Np3hgfZRjikDnuH1Cuk+Iz?=
 =?iso-8859-1?Q?awcnwb2yyC2snxRqsdckKHBkz4uGkgWxN4VzN9TGG2hMOuy1GN0wc6rqd1?=
 =?iso-8859-1?Q?YFp709513Gnai+dJbsj+MwFlFRK6m0wGiJEC5eE+e3NydzydcQd85SzR3A?=
 =?iso-8859-1?Q?yEoxoSxcx82LxJ8FbUdanzcMTZFMfGcP6QzfmAuGTb3JqbmPui7+Y6rmhU?=
 =?iso-8859-1?Q?5lzsvicmJCEEzpA0tc+Ef56cHsCAjwnXkQwLOIUg0WRF/QG5XreMo/sSbX?=
 =?iso-8859-1?Q?Ln32qVowCHWkrJcBt2RacJSFOltHTpxlHEZjKGPEUxGb5ggBg0tNJEmprz?=
 =?iso-8859-1?Q?5f+0Hmbbp1dR/VuuHIquWhTY/Yb469KRdqH/Qxr1aMq92hhyVoqcQFtcqj?=
 =?iso-8859-1?Q?NIiAC0bn2qEt9svdYYid0x5pKK6qZTPnAAXnhAwxLLq/xUW2HQmVVf7hUp?=
 =?iso-8859-1?Q?PKu6hYu9PCuHvo780hoI5kBVIQhIa4fqxibuvgNrsmc0goZqTt2sF49IWG?=
 =?iso-8859-1?Q?cE5f5W38FNI+N7tXrAI3DjWcB2xKc4Tnyu7aud5YmCuf5vhLhRFjIeQOu5?=
 =?iso-8859-1?Q?8uYvC2IMsUnkutubsUpPvpTR15gMcLGXM+ngaQNFt+yyOHmT68v13sOCu+?=
 =?iso-8859-1?Q?fuHySu1Z85fbyP2faRsJndQWMxFpDUDmI13FEfqQvWr2NOpKzyBJRyNS0D?=
 =?iso-8859-1?Q?Iof10iiYx7+oFBG7XMySuNA+1OtmQRlTAZ7D1b793M69nCWvf6uagQCRsS?=
 =?iso-8859-1?Q?RIDgNBeSdagQtyP+Bp3Oq4CUG5cR/FSupwDBf3Qzc8/J44RyFTnPbRjUoQ?=
 =?iso-8859-1?Q?AseOeA3jDw9t7Cd5hefBHdIk5ySEhnOR2oUjCnlDsQRI2l7eRy8w1q1p6n?=
 =?iso-8859-1?Q?8iuaO1+yMEJnJLwoeU0AMeikSnE6GgSZjMBSVEE++O3pK/1QCoVpPekPTI?=
 =?iso-8859-1?Q?yIaXeO1RjWsy4wRcGbJ1j2urDE2OaHfyC9C0ofTff4r0M7xld8LOJScZ6i?=
 =?iso-8859-1?Q?WWgPIElX2xjNTMJkinUVuOkbiLl+qbyAYNcFkX1dDM+tmUl+mItyKlN8cf?=
 =?iso-8859-1?Q?1SXc5opsXH+mpHgOl2IQ/dND5Ntr6edZghMR0CyZ6d4NeKUrkqOcGohr7j?=
 =?iso-8859-1?Q?2ynN1wxaHdHc98U9r2ddcdxsVm/K2kJ/isvAePrhcIUoBCbaUFxgyXvkrN?=
 =?iso-8859-1?Q?F2YC4hSZQ5wd70ljENeS93UVlOQlfVf3vdWfkrA8ncHEecr8d2zwJCv0ze?=
 =?iso-8859-1?Q?GoUQKciYyecydOj+ZBqFEoZ1gbwaDYd7Y8MipVRM2b0bhphmkxpK/wIEVp?=
 =?iso-8859-1?Q?AowC6Q/M8ttEeO2E1NcTC8ZcrKvt/qYgTsTgeyyLEJsDuWSILGszoKgGuK?=
 =?iso-8859-1?Q?Q/LUSwzdI69WT4PyQ9/DNVrom7Xwy+T5yD1NKhl43cPw+6OjvdpmsAi69U?=
 =?iso-8859-1?Q?ryzt6w6fsDotcHWkk9g3Jgzdu8GWbj3d6w+4coX4Jl1qf4HVoQtnP0oreL?=
 =?iso-8859-1?Q?2LFl31ZIaEw4GwkvP9I9bo8IDQls8mBIvaAUf/wsc+2w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6849.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LLIZO0Ie4eU4xolQf6lWJ2UU9jvolGnWPwKPQHfi8IWvYuwFbW76PkbQ8W?=
 =?iso-8859-1?Q?8DqA8TckoEXYkOfbNqFTU4U6ixmarljUBsOBy/0lBG5zNJ3+74sKz8uxVG?=
 =?iso-8859-1?Q?Je1p0pdQMeSI/G/kV/7faqglJB227/j6h56EP7/+yhjfnzjddfwhHvbYpx?=
 =?iso-8859-1?Q?XVl/MgHAl4tPF8HaNteRfAcCSzTuYR6A7M4NC6iTOuEpWWUyTZNAfrfMp7?=
 =?iso-8859-1?Q?Kay797m6aYq6/wwM/zSlCMUi7rqvD32QM8T/c4tfruuaMfnZvc8EPFgYDP?=
 =?iso-8859-1?Q?iIQC7LTG9lRv3ox7paOk/BRBcVTKT3wXItwRPj/ZAnL7FqxTb1nLvEmun6?=
 =?iso-8859-1?Q?HA8DVyljeie7+7PK+5TFgs63tBfZH3FbEAFUui9Gwr15Iak2FgW7dUUBVo?=
 =?iso-8859-1?Q?Zn19QZ8kD1+Py7CKpefVzrVXn9IxQM7+lHCSy5xD0jJ4J/J9NSpD0BtE8F?=
 =?iso-8859-1?Q?rDECMVekZkAZm0VJJO/ZK9lrpDU26dkwSmsABBElWTfHFOG68lQZXOnRRy?=
 =?iso-8859-1?Q?QCAFzN9xZQd1a97lSx4+cJLav8dxOT6xFlbin/ITodfSnpUkiPlBQ9kLkS?=
 =?iso-8859-1?Q?hqK57JwOlNqe4zS7Ho2zTeQKU6bp/lzCoyvRR0Y/1EddyLy3t8dd4vuCsQ?=
 =?iso-8859-1?Q?SXX6NpR7FpdU0VzLytg3SE2EC3FPca6RO/ft1T+EZriMEodIlkYLsTjhIO?=
 =?iso-8859-1?Q?dN5uAxRhlpWoWpC0zbxYS6uDfSI7EJ4TEv2VlvdB56eUFs9jmNGnxNlB98?=
 =?iso-8859-1?Q?AtjUO85d98cXrbsnYGH1Yf1Wsa+xpbNBMTuL8HdzfDOytifI2hbBFr/C5c?=
 =?iso-8859-1?Q?e/hFKdyxs3tkk/mxLqvDEWdbw8LrEQ7/UBnNelOL/Lnm7XfJ3LjhVJLXzO?=
 =?iso-8859-1?Q?Syn3UtO4KbP5GU/Gw21Qvy0+nb7PuUEbs9iJGUoAibk0reYYv8ztLfGVf4?=
 =?iso-8859-1?Q?fWNXIOqTkCPTk2siDOVmfy/vNg47XycJ6F2qio8LuNtV+YwEDswNCP7Vbw?=
 =?iso-8859-1?Q?V9hCUCfqZr7HYT4Lx/430dOTclIWf+32QLl+OvdaAs5SRcCRkCP6vK557J?=
 =?iso-8859-1?Q?HlhmpnN3hoNwfjCy84tVCZPO4+UQgHmEDEN1mToJVRmxCqsOy1kK4rO1ZW?=
 =?iso-8859-1?Q?6isCqMKlUJqwXF+nfdGQnVoumWRMpOJlMxx40p0pL2sIdNuat3d0DbdrKM?=
 =?iso-8859-1?Q?RQiQnlcj9D3dD7LXiYxMJMfOdBep4l/jejVFBurnSdSJUQfjx/y0v4f9YL?=
 =?iso-8859-1?Q?q5PLEfAeD245mh9BLkJHBz9P+FPAd1F423esr+7rBH2LNSzrjpgCJQeVj+?=
 =?iso-8859-1?Q?lPgnHVRHLQE+PceYzcMqrrFTMRFYr2Z0nUsf5p7ITO0aKfifReS08fWZjg?=
 =?iso-8859-1?Q?fqTIy+thS4kmh3QMwEFUlM6PraFPCTAJTvp2givDgWJ5y6vVgoUbBaHFtq?=
 =?iso-8859-1?Q?l53jAcWbh4OaE4heRth5UFVC7csA4Y+0F5/qpGaWq4Lhl7DWr6YdDDf3tj?=
 =?iso-8859-1?Q?7hX76AM/4VwnOnWfl6vWQBFyslxnCvQOG2DN/nFe5QkUhejM3sjhnMHeoa?=
 =?iso-8859-1?Q?npU5Ev17PL8OIf/nNVEPKYzzr9LmFeN+jlojZOdMhe3/zc/cwzHWlOAONk?=
 =?iso-8859-1?Q?QML+y/OJPT/pv4EZB3gm5Vxe1EX6Jsjg5i?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Fes31zdIxYMlCIdnxnHIPCJ/wXcRyh1/FlGYVBcOFnV25aPG4nJgN6WDLwBf3ZQATdhlkisSB507atyVwEA7/uCHHjlOdfvstw2lKFe7MBvH8/TBIjhh4pwnuWWUfnhItTQxwfseMYAU+t6Z7CHvjzHEPPOl/To7jgEPyOdGmwXR3wRTkow4EV9PvD7+A2uRMfUKNwnlPWx5PFOUcVSqxfY+rv4Y97sMFrf/T6FaVVod0HLpJ0KFBkJYAum0vTWiWn4CAX0G3NO6n9y/2ah0XgxoAWqXPQSIt87BzQ14lGpz1J/4GpPdy8x8hPjfAfGQxp/MKzQ5FPm5o6cM5nmSZgvSbNE6N7ewoebl1t1+oxthrJgIHNyMlkIUpxtJtWBcYcv5x2/NeRFWlYaSlH2NDrJT64vdl/JNJZbS4SokOF6robsCdSarwBO+DgC5V2vHnWDk2Bg5zbkXl8EaqE37jYpT0tmawt9Mj1/Cetlp6pboJovrXECCzYy/SxBAs6xmiHCbYpMN6K18L8mSLQSgpBjRGh26HzIpVWKCkiX6e2gWTmZhwLBMeX9txcXq79jVgIRv37bzI/cnolJSsl3UuFmQSWB2oCtFeiwBhzxDJVbko3YIXoDG2UuKhJEysAJu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddf86446-46f3-4070-0f53-08ddc93d9330
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 16:34:05.5670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: urbIrgszhrFe/8vtNjcCmiiU7Iu/k0TixDzBvM2yDumiMnj833SRfKX46UOK3uWuHd8SJxzjolkeOFlUKilb0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8365
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250722_093411_300419_3F45A7D4 
X-CRM114-Status: GOOD (  14.34  )
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

Hi Christoph,=0A=
=0A=
From: Christoph Hellwig <hch@lst.de>=0A=
Date: Monday, July 21, 2025 at 23:30=0A=
>> Similar to=A0a discovery ctrl, prevent an admin-ctrl from getting a smar=
t=0A=
>> log. LID 2 is optional for admin controllers to support.=0A=
>>=0A=
>> In the future when support for the newly added LID=3D0 (supported log=0A=
>> pages) is added, GLP accesses can be made smarter by basing such calls=
=0A=
>> on response from LID=3D0 reads.=0A=
=0A=
>Umm, as pointed out last time, this log page is prohibited for discovery=
=0A=
>controllers, but optional for admin controllers.=A0 So=A0I don't see why=
=0A=
>we want or need to skip it here.=0A=
Sorry, looks I may have misunderstood your last comment from v2 (pasted bel=
ow).=0A=
By "let's leave this in", I thought you were referring to my patch. But now=
 that I re-read=0A=
it, seems like by "failing a get_log page is fine" you probably meant to le=
t the driver =0A=
issue a get_log for LID=3D2 and fail.=0A=
=0A=
Process wise, can you ignore this 2/2 patch and we call this patch-set done=
?=0A=
=A0=0A=
>From: Christoph Hellwig hch@lst.de=0A=
>Date: Thursday, July 3, 2025=A0at 02:05=0A=
>Subject: Re: [PATCH v2 2/3] nvme: prevent admin controller from smart log =
fetch (LID 2)=0A=
>> Similar to=A0a discovery ctrl, prevent an admin-ctrl from getting a smar=
t=0A=
>> log. LID 2 is optional for admin controllers to support.=0A=
>>=0A=
>> In the future when support for the newly added LID=3D0 (supported log=0A=
>> pages) is added, GLP accesses can be made smarter by basing such calls=
=0A=
>> on response from LID=3D0 reads.=0A=
>=0A=
>Let's leave this in.=A0 Failing a get_log=A0page is fine.=A0 The differenc=
e=0A=
>for discovery controllers is that implementing it is prohibited.=0A=
=A0=0A=
Thanks,=0A=
Kamaljit=0A=

