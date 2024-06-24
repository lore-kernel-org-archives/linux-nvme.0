Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F4F5C2D0D1
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jun 2024 20:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qHK7udMy0EMCMgDjTr1RdWOZ0YlVlAgbDOMENJclmJ4=; b=3dnrtoVLZxtD8PEQ6S+mhxPrpI
	S5B0pRsSjZrdGUmI8N/W9pgraAkeHAxPNB6Vvwp8e4Ji8Spy1tDrz0iTC01kJLopcHLVoqx0cw5VJ
	4ljh1luuPu9QhwAKxF0FJNDjoE0IHID407HSqupFanGq8jbOQ3f0+Ewabel2tj0DkoZVXu0saOQor
	KcqfyeX5Gjl9+2NcaHU5RDka/zpAxKOnIkun8v6wDZetMjJ8UtrVi2Femvt4HzbMVVCdlHlLd+uvj
	3gMYgbrCJqM1nyqh85hAXyII/32zxtc3yUvkwAIYY1/KojIdCh9EQInMhY3M3TpsbLk0Vdh9sIojz
	hvYcfAnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLpsp-00000000UzX-2Cdb;
	Mon, 24 Jun 2024 20:01:47 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLpsm-00000000Uyz-2F01
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jun 2024 20:01:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719259304; x=1750795304;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qHK7udMy0EMCMgDjTr1RdWOZ0YlVlAgbDOMENJclmJ4=;
  b=TZJdtCNSpS7gpB8YbIFRbBLtTOWpJ5WnKXFYhQnYZj4jGlnzpMzxXM8R
   4gp8aVxyhMTpVfVZu2NY4lw1b1+d2GJM9VwMxxLBObV0QpWcReQdhFesw
   J+kTMDHy7JMRrFkPbzqBhK0DbQPB+OzaMCJ6lq7+iw4T+qWixfuod+jiX
   1RH62QCRQ+0QVd11Y/3UH10vRDe2aCCfLXTJJ7MG9ZKR+hmYV0FaIYbIg
   FCg6lBbRJGuKOZC6XkTQlE+05Oe3Br1rdJQATQ0MpzciTCVMYgiW1k5hL
   V/XyK0Bu08IGLOLqAln4BudjAJQa+LFxbLnKKJZDBIkIpiaUEQIDHSLKZ
   w==;
X-CSE-ConnectionGUID: K68fQ3viR5C+Mo5/sMKYdg==
X-CSE-MsgGUID: bVON5WG2RmGevKQ9t6WK6w==
X-IronPort-AV: E=Sophos;i="6.08,262,1712592000"; 
   d="scan'208";a="19612383"
Received: from mail-bn7nam10lp2046.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.46])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2024 04:01:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d38XhvOCKA1hsNgJpw/g/9pQGyVWSwcyXmJahqk3KO2fyys3axYYdeiiJ7o/+K2cqN9Db/7+KdUnlCwPKmIErsKWNONK/MHnFhGuyFwdyDGc82qBQuJBuWcClcEMU8WXaVZs84GF+QDIn4ohsfhgWv4yODhaKFaBVZfostYKZftYtpk3GtK7PILe8pcrUoFXq6KpZjZd5kv5pmaxHU4MySoqjHsKD5+yxR9qKXwEUvEUrq0PI3ECqho4XDQSNRiVklqAraJCjl0R+V/E3mJo9Ir84nz4CF8xuElpQyXLDQRTbY2AkxsADKXjdMoiM2hNgzSvpbds65FvVIz1cIQ0Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHK7udMy0EMCMgDjTr1RdWOZ0YlVlAgbDOMENJclmJ4=;
 b=MCFQTtCQpZVNcAfeujfWgTbtLjxqHPF74YYo5mGCMjx4BEnxMxMyllxHOclya77siXq05zNuDVhL3ThB9OCzHJPGSDXT61ORx5mjV1DCzd1WSL4nbj0iSh8d8hTTdYJm4VNf75XoBr1kdwBxyl3FNDFKBYfa1C6iwVTzdFRDLv948ZqF8s4VUgYW6LbS0KAAFVst/9K2yhJCmRWb58vNfdnr6GtP7ramZk68R61xhMAb/y0suPsZ08bw0ClVfbqgjCYt2q3LMJpUMYTRYEVFayQvZx5NzK+15k5NV/FYvxjnE+4W73pR51vbuKQ0W964ZoxU1yTqNORXQ9Vu0RKPfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHK7udMy0EMCMgDjTr1RdWOZ0YlVlAgbDOMENJclmJ4=;
 b=aFaTlViFfx4xAaFCDZ2bWdMXFcuFxGObWrQA15T9W9Uw8cVeE6A4MoLv0wg0434iX7igsmaSihxy0AgZbe8gmb7I0TO4REWSjG+hkazvBhOF2CND6KAJxYJkyeeQfnksQb3l1v5Ub2nfY8U5ZSoBfJ4PkEP7YIomt1FlX8stMOQ=
Received: from BY5PR04MB6849.namprd04.prod.outlook.com (2603:10b6:a03:228::17)
 by SJ0PR04MB8373.namprd04.prod.outlook.com (2603:10b6:a03:3d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Mon, 24 Jun
 2024 20:01:37 +0000
Received: from BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320]) by BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 20:01:37 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, hch
	<hch@lst.de>, Hannes Reinecke <hare@kernel.org>
CC: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCHv2] nvme-tcp: align I/O cpu with blk-mq mapping
Thread-Topic: [PATCHv2] nvme-tcp: align I/O cpu with blk-mq mapping
Thread-Index: AQHawljnU7+bZx6ex0eCgJUX6ywi+bHPLgIAgAAGs4CAAAWXgIAAAYEAgAAChgCAB3gvAIAApXhv
Date: Mon, 24 Jun 2024 20:01:37 +0000
Message-ID: <BY5PR04MB6849C4BFA9AA491AA5C3BFAABCD42@BY5PR04MB6849.namprd04.prod.outlook.com>
References: <20240619145553.89736-1-hare@kernel.org>
 <20240619145958.GA2254@lst.de> <d5c87821-54a7-4fb4-9222-501174d6058b@suse.de>
 <f1348234-1dcb-4ac2-a0d4-305c39643a48@grimberg.me>
 <eb0023bc-3a3b-4f31-955b-c6aad4cad4a3@suse.de>
 <b4dc2a6a-1663-4144-a607-edb6beef48c0@grimberg.me>
 <f67d4572-f625-48eb-a8e3-3e7a5527d9c6@grimberg.me>
In-Reply-To: <f67d4572-f625-48eb-a8e3-3e7a5527d9c6@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6849:EE_|SJ0PR04MB8373:EE_
x-ms-office365-filtering-correlation-id: 64dc6784-bb46-491f-d374-08dc948874be
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?/vaED/kZ6afvrQeDCn+EqtkPs9mjrv0X0C/OsYjY1lnP7DzTPDYaY0lciP?=
 =?iso-8859-1?Q?sMhDI3dUiDUXdajBLjBO2pk6oOIZ9SeFZvyFH7Tor1smXtEYqd9Mdk2OVp?=
 =?iso-8859-1?Q?f3Eao0Xl9byljozz3HGgO4xSkleOyQ/h1+sG1FhQKlTgDp9nixJhUKYe31?=
 =?iso-8859-1?Q?6Lp2sAbI08St7XC9T77iyWayFgTWXPNKj4sLyCGJoj+GNbJj8bm5bQQ5ro?=
 =?iso-8859-1?Q?URRcpJfh/tFe4/VOYRRg0Cl+OAvBp3fog0A1B135+SqWLL+bfLsfhOdqmJ?=
 =?iso-8859-1?Q?j57RKVwH/0zZY875CX0JzEVSf/IM0Nd1O/jUVSBeFYt9CSqXqcESK6IHM0?=
 =?iso-8859-1?Q?0HuD0saJyg+wMX0l0N+gMaOA/xVeZQPEIjaTHgwLxRnkeOPx8OI1TTfJH3?=
 =?iso-8859-1?Q?gGPc/QiW5WzT3Vx/KXxyBaBSR4rKw4spitWaQ1rJZACNlqhVU4HWvSR0pt?=
 =?iso-8859-1?Q?sGKdrWRnKbzcaSxYizTOQBxiw2chzX684MMGg5vekAgc+hf9Fj0nN5+ZSa?=
 =?iso-8859-1?Q?ZaaOux76Xe7d9/GFWELv+VEOI2YRDkFvjD0TJY7zPCdM97jb7e88kAhKct?=
 =?iso-8859-1?Q?PGkdKsL7cjOG4Tq/EEOOiQDmTaz2Op1MULspNukOy+W1rpPT8mUIbjZrpq?=
 =?iso-8859-1?Q?E5xmXolT3kkwbdpPvZOPUvpV8FG+4h9YyujmDXerQIHTTnJ0jYqM0YMpf9?=
 =?iso-8859-1?Q?+EPa2ZoCW/FxYMt1EQfeEbomSBLu18Z1+bX6NSqmxOpCUuQ9lVoiPEn0rH?=
 =?iso-8859-1?Q?KrpcJ+rRbAkWi0IN59WyK78qzNa6w82nCfb34aWCzoRAmPOAptj7nL2sXQ?=
 =?iso-8859-1?Q?Rl0EF/cbexF+sIcltn5Qsx5QiGWF6UA+qtwGD56z7qELK/CMOwpYBsjvZ4?=
 =?iso-8859-1?Q?A4d+8udbwHuEQ/Nqs38fq2txjAsv0ZEvU38tITtNJhCd89iq2tSXw/LKkJ?=
 =?iso-8859-1?Q?kaLFd89s959oTOFnHLIyAfH8fuRWOjeFtBgtTndkBa9RHXCZKOqSCzDQGQ?=
 =?iso-8859-1?Q?tb53qpmTR+6tk0THP1NvzCGyArbx/0wgCN7cnZ8rh/J1rmEvktrUQ6VAqv?=
 =?iso-8859-1?Q?pI9tkjLHk7HCMW7QegpZO6rUntuimyHJqcb8Cj36mvJrfghuhKviPuj5mQ?=
 =?iso-8859-1?Q?HIeWr9s62JXo4AvEJcxp6GXsYu5pyquGLbAMBPRXsYdq+kl2BttfUlTEn8?=
 =?iso-8859-1?Q?JgyO3jPLy5IGAxFfgwn7uRAeU9P/x8sW665f+GPMB7X3PcoikQqHQYiqd6?=
 =?iso-8859-1?Q?TxUX8OL1OkPgr/+XU+6L/PKSzVsGKOBfM7rRD74hPLjX328xXn1m5B5QHL?=
 =?iso-8859-1?Q?57A2Epps4dTzcuAcmnFe712ilybYGS9kbFBQiQmdDOIrvSQcayaoDzUT+f?=
 =?iso-8859-1?Q?9XpUvww1lltfwi420xvWVZb/sGkjnj5q29NvOlWjRGz1ytWQwCHc4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6849.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?pkNTNuPORoQARs4NgzETJ39RYUDSj1vZoLLbwWQprC9imwXFeMeMkq7dJI?=
 =?iso-8859-1?Q?fakZMgrDk9bsXc4OLoMjxdSiIWr7HbxGFS8c5vkE8Ik1Dx3TucT5YgKBtt?=
 =?iso-8859-1?Q?+Si5gS9M4CkvNScHmsGUISoaE+SD7gx/eed4aK4Ha8lOj3a3PqL5/QJ+hH?=
 =?iso-8859-1?Q?YwMBncE54wpvKp3x07KHyaWJaCGpLcAyAAca6zz/j98EeU1DK6ZqEkSGuD?=
 =?iso-8859-1?Q?v+tqCYba73VWknMh412A+4JrKJUJStBYHXHlqj177ZkHoeRCSZ2pYk7cpf?=
 =?iso-8859-1?Q?HPKS+M54MaORalcxYiLJNfITC17ltBF9TGZpaC+gagJ0ODqpctn0I+5ouk?=
 =?iso-8859-1?Q?DtZcllzhvUMIQTqi3GfbbDgvhETjTCK9IUm8GxU2onn01/qefGGdfkMUZF?=
 =?iso-8859-1?Q?0QUIEH4Gip92eck/On+TkisgiidU5VGYtEzQwykFqh5dqveB3prdT+whfn?=
 =?iso-8859-1?Q?0Ru6Tgo4zdUZ5bSkG0Z+h0LvbUvbrRApqLaoY1zRuuehUcKAv2RWQTBiiy?=
 =?iso-8859-1?Q?aM3qWTDo8YwVIlSUVLhP743htAcS0SnPiGGvauyufzGtZYzstHHyFhX8v1?=
 =?iso-8859-1?Q?lw9DK4G5Zy0PcKYk3n1aYzPHzX8ZkaUC5tfjtqAplTQIB17fKGcq6p01Ez?=
 =?iso-8859-1?Q?90ov97d0IWMxvLUZP1v5+w4rec805stdQqog+kOGcS/Cl+8weswvc3vHfC?=
 =?iso-8859-1?Q?ix8ac//z6pssORBI5Cb5cL3Ug0YeQ1Pv/gMAQ9IBiLUgqvejCa/vRSkEUw?=
 =?iso-8859-1?Q?AlCyLKfNqKUOstWh31xNAKtizlYc42ci0nEGIWV6Ip6ctlsyRV/MYojjEI?=
 =?iso-8859-1?Q?cpOlET4Lqf4lVlgDKxpKrkYUhCw5FX+nfbco6zncQDQAKI5U1wdbEJjzp+?=
 =?iso-8859-1?Q?gxA3gO40r4JIsYb3PPTHxJx10yEkvAayQNzYqB4DqLEACS0t+ywAVscHyA?=
 =?iso-8859-1?Q?rWjQULrBeg7jUBcGqeOEW+0a1QZqWztn0cj33WtA+YRIqAStLxugFIduJb?=
 =?iso-8859-1?Q?e1UXpAA3ftOEnDMIpwZu+mcJW2qWI1kijLX9jkdZwpWOPlYpBRf4pLy8k8?=
 =?iso-8859-1?Q?ngT+/maLdaQYhlxiHxmT2TO1r/1kZqF9bEg7b5wiyuPL022hyxWLawZYO3?=
 =?iso-8859-1?Q?D3ehE4Gy9XfHJAJ9Nhe1ycAmeVJmlKJjQ/8WpL7V96KdLKSfrPEtwmnEPV?=
 =?iso-8859-1?Q?JOY31YtlC97e4+NpIj0bMrF/jfmIDTlhTRNKTVavChcCf4pVJnK6FCr931?=
 =?iso-8859-1?Q?sl6ovAXzUWhJDtyems1+6Z7zHHgL6ufEDH4n6tNG5znAk8sezvA4saJAbd?=
 =?iso-8859-1?Q?UW0QMgzN1onpDKGvXd9ibiTYvdsnvZpUvz/Ck0crE8Idgcn5VAh3GF1gRg?=
 =?iso-8859-1?Q?LDUTN4X0UYj5hRHTLPpUBesgciZjRwiOdqH8pIqnBgUFFot9NFXwVih7lY?=
 =?iso-8859-1?Q?juYPLfNPGESoVkEnGtf6j011y4oZZyk2U9R3qlkJIliyk6Bky67x5elouY?=
 =?iso-8859-1?Q?2cN2pBauM/3IBByubynm10JIdHAU3C0NHi3uPwAv1XtArju3fTSftlPdW+?=
 =?iso-8859-1?Q?c9qA40WQ0KgooGCymybImxW2Puvc0w3QNdoenhF8jF2F85sfGvJn06gvMv?=
 =?iso-8859-1?Q?WOGCUrHdqK0hqyudP1Zbea9gE8LsmoOOx8?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2MDi2oz6L+wyMWb+NnnGsfoIvmBbsth36QrSni2ngxzIzZWRQBS5AGpkXOnW0860MDrQiDFBM1JarDX/e0jqRB0eKXCG6rWlqLpBWL+EhKTp5UmW5990crJwSLYTNbmrBQWwhrQ4NBVAZ1Sk6mCWtaPjk/kANVIcXSudxYGu8eecXkpxH9H+MJSRnmyaZFKCY0wR7vw3/uTUReUkwVKAZ5ed6Ak1uLx3Q2Z+Hf1LjgJO/UKSJoxMCTVkGlwrajBRzNJ7b5eubpYgebIkRkMpQU4FrJSDST6vq/l/ti5Hb5XflbSFInvY3SJDaSfdLgNyZhc8AX+lYLcBZ1bBJzpYpP7OfUA4xUIwYL08VgC9K+Z4WOCU4wsxsCUzRky0hRwrPDyfEmf3Ds1LALIryO9VnFas0UkHiTeg5h0fNkrbYuoltiRKy0Yifk+v31pf8nIO2wnVoqs+VM8IRtf4kQ5MNJ+R9c3RU6t208pA4WSTjqVjKtbugw85jxsMM9vp7/wwi4Gfgg7gCmSAbPmBHxdxuR7nvVq7X3bnKw4zMkvR+6jiK64aVz+dJAygu34028JdE2eg1j2smOPF12jSoQC4Vi5pqcFD7lebKKeJLyCyFRT+R6OS67iANzBYYH935P4a
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64dc6784-bb46-491f-d374-08dc948874be
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 20:01:37.4767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CgoVO/9Qek2H0l+XEScqgFwHEZ1aWK1KYVPphONQAPZAs4y4DAA17Sz3CZiFHSGtibM94mQe96GJuPVRr5je1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8373
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_130144_612310_1C35222C 
X-CRM114-Status: GOOD (  12.08  )
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

On 19/06/2024 18:58, Sagi Grimberg wrote:=0A=
>>>> I see how you address multiple controllers falling into the same=0A=
>>>> mappings case in your patch.=0A=
>>>> You could have selected a different mq_map entry for each controller=
=0A=
>>>> (out of the entries that map to the qid).=0A=
>>>>=0A=
>>> Looked at it, but hadn't any idea how to figure out the load.=0A=
>>> The load is actually per-cpu, but we only have per controller=0A=
>>> structures.=0A=
>>> So we would need to introduce a per-cpu counter, detailing out the=0A=
>>> number of queues scheduled on that CPU.=0A=
>>> But that won't help with the CPU oversubscription issue; we still=0A=
>>> might have substantially higher number of overall queues than we have=
=0A=
>>> CPUs...=0A=
>>=0A=
>> I think that it would still be better than what you have right now:=0A=
>>=0A=
>> IIUC Right now you will have for all controllers (based on your example)=
:=0A=
>> queue 1: using cpu 6=0A=
>> queue 2: using cpu 9=0A=
>> queue 3: using cpu 18=0A=
>>=0A=
>> But selecting a different mq_map entry can give:=0A=
>> ctrl1:=0A=
>> queue 1: using cpu 6=0A=
>> queue 2: using cpu 9=0A=
>> queue 3: using cpu 18=0A=
>>=0A=
>> ctrl2:=0A=
>> queue 1: using cpu 7=0A=
>> queue 2: using cpu 10=0A=
>> queue 3: using cpu 19=0A=
>>=0A=
>> ctrl3:=0A=
>> queue 1: using cpu 8=0A=
>> queue 2: using cpu 11=0A=
>> queue 3: using cpu 20=0A=
>>=0A=
>> ctrl4:=0A=
>> queue 1: using cpu 54=0A=
>> queue 2: using cpu 57=0A=
>> queue 3: using cpu 66=0A=
>>=0A=
>> and so on...=0A=
>=0A=
>Hey Hannes,=0A=
>=0A=
>Did you make progress with this one?=0A=
=0A=
Sagi,=0A=
Looks like this change should also address the other NVMe/TCP issue that I =
had=A0=0A=
reported for WQ_UNBOUND, agree?=A0If so, would this also be merged into =0A=
6.8.xx branch as well?=0A=
=0A=
=0A=

