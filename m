Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FBEC5B549
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Jun 2025 07:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rVqUtI9cDEJZLKGzccoSGwW+gukN8EcMJrS8W6JrfSY=; b=RnT4m6IAneUeVdQFLrBVbGm1GY
	JOXTTIbzhowalta4yKPJCrLJ2726b73icNP4bm439xi1JvmDthLHP8yhoSUwvRo3bP/Zo+AeEk5uB
	jtJ6Ef1W/iwsh9RKWRUVWpyv1v0T/+tGmKlwqo7DptxTndAIYtRCDPBLJkqplh4LKDBXgiDAh5EvZ
	b9WmTS6g0AyBG41cqcYxdNi7P/vaFXtpS8JKitEOrwyxtDOI/iaD2scGot9z0d2eNxyA56VgKX5Ws
	qq1M39zt7CEJKLGsBf+qa4nNL0SYOI+0HberuZ+kxG3LYl+7xeu3PXGH7R58bZvPW4TGG16zCNZhh
	gZJAh6cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNRv3-0000000HM3v-0ZXS;
	Fri, 06 Jun 2025 07:55:17 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNRum-0000000HM0r-21sW
	for linux-nvme@lists.infradead.org;
	Fri, 06 Jun 2025 07:55:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749196500; x=1780732500;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YICUXt3IYNOgc0stavb8O7gIZjxLncqm7cfJVsXw+2w=;
  b=fx77/coL61xwnLKj1oWPFCin+Py1dmMQCdq8uupL2oui9dUczseAkdBR
   BeQVNxSV1QiJhnYh6JX53a9wrihbluMGSIfo4IvxjK12xTR3+rZpnDidn
   pxVByvygGJBqQtetbhOcW+8Rt1c2yLbpADTNeHFY/Z+L2mChmg4JiQdA8
   0CSCwN/44ZtsSx94LwgA7Qpmg18XJvCjw/YcU86ALULdnGxTW9De7sDm0
   I+UxKHIl6Oh2zNZDpkjhIezb014nzKpn4e72rIArRXAYNi6eLwJ32r+cs
   o+gqis3o2P27vBrb/XulxfjguZC3eYVVWH4zRwtXFBixK62U0/UBVbiKs
   A==;
X-CSE-ConnectionGUID: xkecNOAyQLChkhylilYFmQ==
X-CSE-MsgGUID: t2xaiMUBSlGm4SxGddwXdA==
X-IronPort-AV: E=Sophos;i="6.16,214,1744041600"; 
   d="scan'208";a="83553122"
Received: from mail-sn1nam02on2049.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([40.107.96.49])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2025 15:54:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7zpDv00NQt/BJnUyTJV6ZBeLHi0a87V5z1VE77y5DwT+x/mNPo9L9Xg5W05Sy+qAWzhu0MbwOaDwn7HU7pN4tc8WugtNwztoEzeNnmpBrBHTJrMhp/MsDWvjpxpaeiNa1RJDc2N5seUfhHy8D1o5Hz3idkd6VJU99aEF39AyxDXigbOJ5PDR63Jlmb1hFbA7U9aqVRPOpjcDust8iT4HEZKrRTtlxH9VE4p3jrnA3YXX0debvAckPdfP9LD7yQV2Qg0dqJkk5IHvfF53CDUpGq7QGdmw66yjbsM3izjZiYdVcYTDMONvWiK1g6e9Eo5tUIETEdWjlDBMVNTCc9Pag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVqUtI9cDEJZLKGzccoSGwW+gukN8EcMJrS8W6JrfSY=;
 b=Vb/nbT38Mo+Se41HLB+5sAKS1yjFNPB0urkr2jcWElF+TEglK60oo3TjcPYrpO2Z+a38b8RQiKzqS2uUpuRUjexaDRJcHgfDNjoY4A5j8QKZ2CMNVaHjd93aAR1JoKF70i2qGckqpIJGc5AlmkmMXSNoGMaLEu4PgQIWuzlAy71Q3HZTAVyosxN1KvQ4hXju4icuUUM/UD+rwp4JyxpJ22wW45/kVN352/Qp3Gku/R6LeRF3SgBgaTvx5Pcuu+7xHiJgQQas/FTT5ILlUVp+QR5xYH8THkcaQ7zBzkRn3m+lepsEbzuDQS36GFo3ciIX86HanmFfjxkny8qiOkXStw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVqUtI9cDEJZLKGzccoSGwW+gukN8EcMJrS8W6JrfSY=;
 b=PGG2xKV9VY42IfB6vfoO5ioziGIK+iSw1P8hi4t6Tjc3ThkeU3iRqv4v9CdFOxnJff9ZSYKOX9qG7cRXADuXrFaNoMNvvSFAUeMMX12mWFo0Pvb1mL+WxtAHHJBsOWWxlDquStfgq2xpWvhNE5XY7tSgvIDXA2LLb3Krk2urL1E=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by LV8PR04MB9732.namprd04.prod.outlook.com (2603:10b6:408:297::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 07:54:55 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8792.034; Fri, 6 Jun 2025
 07:54:54 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>, "yizhan@redhat.com" <yizhan@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.15 kernel
Thread-Topic: blktests failures with v6.15 kernel
Thread-Index: AQHb0HYvN//Uc3+takahHhtvsJIVubP0k2AAgAE8RwA=
Date: Fri, 6 Jun 2025 07:54:54 +0000
Message-ID: <rcirbjhpzv6ojqc5o33cl3r6l7x72adaqp7k2uf6llgvcg5pfh@qy5ii2yfi2b2>
References: <2xsfqvnntjx5iiir7wghhebmnugmpfluv6ef22mghojgk6gilr@mvjscqxroqqk>
 <7cdceac2-ef72-4917-83a2-703f8f93bd64@flourine.local>
In-Reply-To: <7cdceac2-ef72-4917-83a2-703f8f93bd64@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|LV8PR04MB9732:EE_
x-ms-office365-filtering-correlation-id: 19beb01c-da88-4ee5-5a45-08dda4cf6ce3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?RztYKUeUlgCCOjVhlkDrwERGf9R0+dWPgpj6imC6dqthBzo7ExKnRJKTAz9B?=
 =?us-ascii?Q?jhinUsAbZ+pdz5hVfli9qfUfx6zOkKWcrynn/ZvqZ+oj640ItS7RVAbOo/mD?=
 =?us-ascii?Q?tMQ5kEVV++DYHB0SXXq7Sfof1aZjEm7V9k6Gh8bKN8AOOmuX2vhw1wXNjIcp?=
 =?us-ascii?Q?SiU+0kxk5Ly9j7F4s7tMVQ7DMZB5Ha/7qxz8TgfezjSLpTiJRVBGVCD/80Zz?=
 =?us-ascii?Q?+gN/5LWEsYMgjeRchR+2fWmlSM6voO01AZg2NnvjEIVYtveFwWxznomkUv7E?=
 =?us-ascii?Q?xcsL4QhtBmZOPbQ6aO5jjKT+VVjRuLM16Eu0Gfwe0t7UFkzMWJPFx5qYbTAN?=
 =?us-ascii?Q?MNJlA6PZ+6Z+JsmPKDSknDmAx210BV1vbSUNN+7vYNC38tQX5WGXQgv0gbKT?=
 =?us-ascii?Q?MvcsmCK9IWOtYZto+OaeplYlcYZt2Pd9R9V+9dP2Z7+N5TEPpKspELIB4P3p?=
 =?us-ascii?Q?nbqwhUAl2WBCAk8rH3zJzvxk+lMnrpEkDPBxEfnay+JRFYkM+idu/WWmcgWz?=
 =?us-ascii?Q?wOKSWitY/wAJv6bg8iIRU1tjaSA8JhYh2szXTXJEDUnoEpRqqYNElSPFQd8z?=
 =?us-ascii?Q?PdzQ3rUc4QnSF9LuIlW13l2bIzuYbHLc5RuLhho5SG4VFzuw3/xj0uYLCGe6?=
 =?us-ascii?Q?VLOPWw1yvQtcFQUNRNivv4eEWGoA3EZ5Aj5z8K6wZb+HVqY3kFsFOMvSg3lz?=
 =?us-ascii?Q?utm9ixDPJQVdrKg3VOHg4D2HWEAl72OreS/WwLYlEllKe6fcOSU01iIctGjC?=
 =?us-ascii?Q?b/mm/9OMgtP1Jr/RsBStD87Np2zSvpc83WCIEp7PWWglkpXnhGB8vlJdiPUn?=
 =?us-ascii?Q?b5KPn1V3kXsPjKD0Xyp0QP99P96JUSw5Nb6rBp9ZjGujAAH8hVaGVqQ55lgP?=
 =?us-ascii?Q?7yEEWoQKZvWTTmGukVfE9zXullucGkJrxLo0evqH7l9HypIAr4RuOb8+KfFM?=
 =?us-ascii?Q?4ImUNT/NKAOuKEoiVULqUuEVn4OPDAITyNoGW7+2EMnRvN/QhklIRX7eAQ0+?=
 =?us-ascii?Q?wEWPFq8e8ia3qXdQakevY9WnO0r5d6FJTRdKgvxA4lmlquO8PLHVWaXywzMc?=
 =?us-ascii?Q?3lbPp4grInpH/5cIZP6zc5s82vVBhp1ebskxDcqmHDh0eg1Yu4BGpVmbIBfj?=
 =?us-ascii?Q?l1vHvlpBQi9oOKI9RHriqpOJlU8+a697W/SnFe1jAtoRd8em/kGeazSZlFMv?=
 =?us-ascii?Q?3wt3iDOOreE65x+9sJSAgdr/mTiQIZMzupD0oY6sKRFXmHov//iiHw0xeWnw?=
 =?us-ascii?Q?g3srf9FwHF34SgwCNtTPXTOx6DKeu2GdkxRqMpFln2efiwPO0E3NUHJUoIa1?=
 =?us-ascii?Q?L6eFdk8uVYx2xU1ZNr3fKi4TcvRZV0faJUfbvGLhyGfRlobeffirHMeuGIlX?=
 =?us-ascii?Q?pIMYR0FQaAxn3UFKkUBRXa8i1sASYhItSBYHgnc7tCjEV4t+e6zZpMPJ6pO+?=
 =?us-ascii?Q?18ajiX6aT9BxEmKGhPXik90OerLZw5qk?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZQjTuCa2dUSzI3aIL5rftxgyNV0TN4+44kkuJQv38ovGlrGqZNbRtDrrVTZu?=
 =?us-ascii?Q?8LFIlWDEqDBAIVAPhd/uoUl4d8lmBcGZZgU3DYrL3HMFAVjkHTxOob9Bj03l?=
 =?us-ascii?Q?jQC3T3VWamfW6Kekfz1MjDvl8Yl2ofAP2ZYHAi5hHiPriHLm/MJEkWKkdMss?=
 =?us-ascii?Q?7OyaG3pN43LZnEgjk6CDbR/NWz/fIK9nRDb0TwtWTJEAiMsIECg1OUARjWBL?=
 =?us-ascii?Q?yGkWutMLt/nUaVrlvvKKmd6d/qo6D6JHXWP2is//z6da8nVPuNptDuyV6sAW?=
 =?us-ascii?Q?2v5U3uWxT6zE5bBEjP7OikRSVn3W3mvZ5T+0ZGIwb9W7q7aVkyCbv5yKyTF3?=
 =?us-ascii?Q?vqoxbCs5IdaAKp4MIJ4srSq2Y7nZ1Yffql+h7DpnnfoobvN1rr2ls1Xc8Jq0?=
 =?us-ascii?Q?yCWVosEy3y9ri31Nj6Fdb68GP+q5UDDQGx9FBzTONkBrhTBSH/SVaJKlKHQb?=
 =?us-ascii?Q?sq1KkQN/hcmQXbgECPNMMa6EKoFSraAZ3rodJavvQcJCHu6XQHJXDCBuKLho?=
 =?us-ascii?Q?le2pAh14onp8FWSK/GGitt2RHQQv2rD+AcI6++1ocSwBJ5PPhI5+myBCDnWY?=
 =?us-ascii?Q?UG47tjW3NTkF3/Di5ORjvzsPYOaEEtNR/hAmqEhnAHy0GEoSEwqtGLK11aUo?=
 =?us-ascii?Q?DLLL+EXQKDhfF87XuG7mpvTCZK1XbWEVVM25xThQ4UhJwjupmJDigv0Xvb6i?=
 =?us-ascii?Q?Ki7OiH45jOp97/uPF0dJwbep2c1vnSsnESMTH4mEWZAXoAKM5GxFoUA9QMKm?=
 =?us-ascii?Q?qC4E+ahGYx7yM7ClgJ7QdXvW+iE1ELfiiWZs/1ih0ZYXbagFCO9TPCSogxBb?=
 =?us-ascii?Q?YsFsWXBKWmYXYHJFWZCzA8GPkIYJ1jRkhe5/nRFguPDDYj1zTK6RNLRHmVg9?=
 =?us-ascii?Q?ZyngMS5/gf+JL07Cg/g5nepT+aILk9ih6ljOkAAZFIuq82WU+s51zVo0x4A3?=
 =?us-ascii?Q?H37rpQGFltfYm228iViGT6b6X+XNMppsvhAi6jgT2tGHDlaHyyb4MPjQnlHd?=
 =?us-ascii?Q?J6Czyyb406D7MSyTZUfpq8uC+GngZ+ZF/2PiJZYHcEQOUM/q81EbUsoAZrsr?=
 =?us-ascii?Q?h2FoxXfffkaCQm5mf/NiOZyNbY5HeM4dNExTWwEB6fbGQHhDGVwva1XRjy1G?=
 =?us-ascii?Q?Yz3grqqT9YehVh7rDjlBe9+nlxjlDD+bRH1S5TkOV3FQiCs+mAritGM9pxiQ?=
 =?us-ascii?Q?okWfGByCWZ38CZVOF453yt6MPjjVshSBu2JJfPgSvOadpvhCimbwXZ5Sz/Q2?=
 =?us-ascii?Q?Ijr2hAI6ZjIj2r9uv8+KtZWc7/qlcaX+/MveJkR0AwvpWKIjgmspvvNnZHri?=
 =?us-ascii?Q?P+CoHYL1fUiUcsnYzzLvBDOjvJ/adZTxQMN1rqLMTHO1rCssqo3+pQfJow5Y?=
 =?us-ascii?Q?bCug+pGXGRNApbuA9fGET66FYbQqciY5wAzNpcXFWIqY4JxEZkVMaNy01emb?=
 =?us-ascii?Q?ARYZz6QUf/txHQe7FMHOOM+biqxq5mEIuBcDVqLAKsbGiyu/eBnYb6yEuLcC?=
 =?us-ascii?Q?TLRKrD++Df2uSnwv2eK8p5Udru7bBSZbs53uvTvBRsQpouHxe04C0YCfgRU2?=
 =?us-ascii?Q?e4/cRE/hnILzSRm7e1aBP5DEhe86hzMDOfzQAxKdEUm/qUtGXSvcfbJWXD+8?=
 =?us-ascii?Q?6LlEmtPJM5Ugk1bqhhzCgIc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2456DEDF0FD730419AC04A6E1BDD037E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OXE28FGxZagZFTplQYjaObi03N0U27DsSGplfHyPmBqvqB6WSEXNsYWFy8sz8LJnpeiRLgLM1gpb10pXPS5c7UrQ9kRtzv3sCEh2Po7bG2G6uJQNTp0YCTphP76DZgjUEVunWlO72N/++T6QfHJO3fFLYkoJMWUymEP04ncuTm1cKCY+IhIbopoHFipyvK2PnXkJV3GBuqAgq1NgZzjiysSxxdCbCJUe6ai8Rf85mGsDPnXRH3kvMZisdESzGy1PZI7ge/xQ5Z1mw6Wn3/yWknapETJkLSn6iYhDYIDbRveJ6+MsWfo5koRaBsTRC+lD1YkMfoT2BCcpAg8r7LFjKHkhVRTrtu7gBQ6+1hsWrJVsa04eB8zpxA+wo9aSDrhcJuC2RK5rfQUUSqGzlarqAoFmTNmOniLDtrvkmHri1ki3U+V/RlQ9eFtV3sJXSm9qBuG2oAW05sxokmXhxZGIXlo3bKonJz8GUnO0Npcfp9wtJOiM31c3iR/EFtgXgVbSLMgMA2VduZLZQFnh1Jtpuf/Hj/jkT+QodbpF2TUzU5rwW3zrtXIk59BpNBbax6EUDTRC5xAQUrrYs8adwdyNGhQFd2ACZGJmoprPW1tOlXNEgYyyLemZRa5KlWgwKEea
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19beb01c-da88-4ee5-5a45-08dda4cf6ce3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 07:54:54.7873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LKmrElIH70GOetbguKRLhXwJIFzGfcghYCR0E4mE80WwV554/DCZlM+qcEYwkoUozJmJjcCWGZdHkCpyVyvVSeL+SIARRMhxc5yXO+osSu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR04MB9732
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250606_005500_559402_6B21377B 
X-CRM114-Status: GOOD (  14.88  )
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

To+: Yi,

On Jun 05, 2025 / 15:02, Daniel Wagner wrote:
> Hi,

Hi Daniel, thank you for the fix actions!

>=20
> On Thu, May 29, 2025 at 08:46:35AM +0000, Shinichiro Kawasaki wrote:
> > #1: nvme/023
> >=20
> >     When libnvme has version 1.13 or later and built with liburing, nvm=
e-cli
> >     command "nvme smart-log" command fails for namespace block devices.=
 This
> >     makes the test case nvme/032 fail [2]. Fix in libnvme is expected.
> >=20
> >     [2]
> >     https://lore.kernel.org/linux-nvme/32c3e9ef-ab3c-40b5-989a-7aa323f5=
d611@flourine.local/T/#m6519ce3e641e7011231d955d9002d1078510e3ee
>=20
> Should be fixed now. If you want, I can do another release soon, so the
> fix get packaged up by the distros.

As of today, CKI project keeps on reporting the failure:

  https://datawarehouse.cki-project.org/kcidb/tests/redhat:1851238698-aarch=
64-kernel_upt_7

Yi, do you think the new libnvme release will help to silence the failure
reports? I'm guessing the release will help RedHat to pick up and apply to =
CKI
blktests runs.

