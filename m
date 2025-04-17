Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE843C369C2
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Apr 2025 23:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MAuMc3ihgRMTrnqZR6VVoH3gcRQgEW5pNc4rN9+ppWI=; b=UXj5FDGX5+gbS7rl92Tqe3DKes
	prsGAsu8X8XotK4AeyrPAxy1gxF2hOuyDYteZAESXQzUINzx8yf3AIgwFbRbCdFovX4kDaxRc+TN7
	uv1EXakq8pVHRB/VlzMMh9pnQ0oj7HKN0f3cH6RbdkOE3JAYzkOKnE+4i/T3YLTkxmm+mv/wtIyYy
	ehcctn3MuA3MdXqxF0RAXjjFeIG/g7PZ09df9NbTYVLajjUb0iAdtAJ9W3Hhz4pyyguEU5Ua3cqrw
	tpgglrSs5zcDkjDg1BIH+HtiSOmLmgYwz1heKfDP7o8UX1lOD0X3Cd2ZH41gCC406HP0LtGDhYjce
	HHlO1T7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5YGr-0000000EWlD-0AnL;
	Thu, 17 Apr 2025 23:03:49 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5YGL-0000000EWkV-2W0S
	for linux-nvme@lists.infradead.org;
	Thu, 17 Apr 2025 23:03:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744930997; x=1776466997;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MAuMc3ihgRMTrnqZR6VVoH3gcRQgEW5pNc4rN9+ppWI=;
  b=Cay2//2/tYK2GV43ktdJ6QqEktE3eRnybmx06E1obL52sZPrujFX97+H
   Eyt2ZhUtZGA20Skr2niHNRwDAgzT6lsm0zN/O2eoih+0qIS0kjF6cevoX
   pDkhlt/1QnY2pO+x7/DPfXikxKV2wj65HniieJ2RXT2eqq3NmOW92AOCX
   0p6T6xyb76ewX24yarFFTyyNHWRnOT7Y/aW+jP/Xswl5WbmFpPOFVbs6X
   eyDybiYYBLCXhPPhE34n/bVA2va4l8RfAUVuwYO8PbHyJ6a4MAc8qTay6
   tApjn9Nm2dn3hBEobn8o/G2EVQa5FsVYtQGGJ3mYdOKx5C74N+3+C7c4w
   w==;
X-CSE-ConnectionGUID: 3NtGUySlSV2k2GQb/42Qlw==
X-CSE-MsgGUID: qQh0nI/ASLKig4rpxXO0Xg==
X-IronPort-AV: E=Sophos;i="6.15,220,1739808000"; 
   d="scan'208";a="75785736"
Received: from mail-westcentralusazlp17012039.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.6.39])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2025 07:03:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpeDotRATaJT23LFI0tkE3Gz/PkSEjfHdgRRjSUrbFkFbQpWsvw32xaU7NfxB7cPOzT4e1kmpfpopxHDEVIKnIBoIW3eP6QSmCHV9noLK7N8tJm3YcC99T7wa2hlZJkJvUwIxYItHcfM2/BdxJXwpa315vcI0VwX/4f55MavU9Beoz5apthVZFHH0BwQ6rcXsO39ISqC4N+/3SnmYxeJmIr6e7farbUI0qNhShj/omjbtEhKxJ08EP5j1k2ZSnZ5lqQ1o6BAz5GyKdQilqCc1Lw6u3Al/KYGi9Vt2MILmR1UTowas6kveXciNF8SwUBEJoLIo7SmoojYsxdmtaUB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAuMc3ihgRMTrnqZR6VVoH3gcRQgEW5pNc4rN9+ppWI=;
 b=RDEis07A6RrriX6qb2XPti+PAcszX1ab/y6cUqaOGbwdGGNiRDm5y4imqrEEsPlQgXkvf4mRE+vWD3moyU/aeqiRZTSCHEcoa4NY0UaKzUirrkFJ8cqiT2Uxk8lZWWnlzQu2melV+yzXzvxJLoNngARS5lY+sj7R2sfGSxVr2C3WGa+HPs5NHVQkJvJ9/mZW6eg8VD7aPgF4FdadN2Wqo4Ywl1gTODhVBqnBkq5BtxVdDHmyQjZvAKzKYoUofx2swuEEBJ3kBoTgsEmqrvrfSGTJ3qg9c+PZQpkSHAXz7/7PnU/bywxvDHvzeAhuFPFAbqpvlzIiIDnS1yamm4NTSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAuMc3ihgRMTrnqZR6VVoH3gcRQgEW5pNc4rN9+ppWI=;
 b=KVTGT4HhcBg9npHiXZMzEcXe6/EqTltvjwe92Uy2dRRXWoSqz6kDasqFxfVQrs/7WxXLB6/nZnlNcjonBgUuxNPoTztvo7pTIKog+t1pW7/tw6p0fX73CTKINWFhHhJSsSKBhC46jTdiwDgj39vSNrkLQEVvpGEtFrwXlkgW01E=
Received: from BY5PR04MB6849.namprd04.prod.outlook.com (2603:10b6:a03:228::17)
 by PH0PR04MB7527.namprd04.prod.outlook.com (2603:10b6:510:4c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.25; Thu, 17 Apr
 2025 23:03:10 +0000
Received: from BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320]) by BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320%6]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 23:03:10 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Hannes
 Reinecke <hare@kernel.org>, hch <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Chris Leech <cleech@redhat.com>
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
Thread-Topic: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
Thread-Index: AQHbpGZdo3Xoo5WOcUmvA6U4U0rVxbOkYTuAgADyiwCAAK1uAIAA7l0AgAGfxuo=
Date: Thu, 17 Apr 2025 23:03:10 +0000
Message-ID: <BY5PR04MB684996C1DB38F3BC4386B55EBCBC2@BY5PR04MB6849.namprd04.prod.outlook.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-4-hare@kernel.org>
 <1edc23f5-eb48-4006-a2f4-d303b05bd3e0@suse.de>
 <e7371b8a-e0b3-4387-a941-292e1f46b2aa@grimberg.me>
 <5446ef17-d922-4467-9a3c-5001713cc260@suse.de>
 <dac1d594-cf64-41ce-8a23-4b246db75b83@grimberg.me>
In-Reply-To: <dac1d594-cf64-41ce-8a23-4b246db75b83@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6849:EE_|PH0PR04MB7527:EE_
x-ms-office365-filtering-correlation-id: aa96d09e-e16b-4680-f32b-08dd7e04062b
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?6NQPGqjC9ETe9DE+WRk4z2WWEeuvHMkuVS/eueN7UsfMCGG76X7q4X+xC0?=
 =?iso-8859-1?Q?cvIbdfx/R6pr4TN9xhXCUMWrpSkLzpIYdnCuEW/vDQxbozWoUlZv/YeVti?=
 =?iso-8859-1?Q?gfSdPvAhfPeVkeXRH7Tag0KzjOPtJAC8tQ57Lrw10r6BCUpnTlimmcA5Yw?=
 =?iso-8859-1?Q?4Uc1YKyHb1BkM4AKTFqWmrt3THzXZozbh03JHTr0Qxa+/HXGtf/F955odz?=
 =?iso-8859-1?Q?T8DWZ3ELgn4lRtq+ITM5qVoizItSOH8W0o0GIJEciWOL2taHkvncwUv5EU?=
 =?iso-8859-1?Q?KcukmbbMnDAH6l0uq9i10jFEFsYsi7lFzP8Vcif5/kZquTXuJ98Hxul3ZH?=
 =?iso-8859-1?Q?WuPYWUa3pP8g/KRBTa3m7tfIIueJwBvAIpFP32MKXZ2BTeWXt/sjw20U9u?=
 =?iso-8859-1?Q?bzXw5RPCQHyk9A/QvXjPzMch4LDFeQ8g7zwGMEvisHxfsysjoNjoMUzaDp?=
 =?iso-8859-1?Q?mOZWzHBfGWz1iI6+sD59Fu3zot9EwjLESNiklWXMj+KZN+seGZexv5Jtze?=
 =?iso-8859-1?Q?Sx7zskig9ksoSzdjSJurxJ12s5L1tI9aYfc8WroiE4tCBdwspjd6PL788q?=
 =?iso-8859-1?Q?NYPNRsWoQF8J6zMI/fl9WP/Im5eu+e02dnUy734rfykCDbQy+5nONEcmgf?=
 =?iso-8859-1?Q?ZeAODJIqz4dA54pc0D9dDVvuJ59ijMbNMSjfjyCduAX/ne+CF8XxPawnf2?=
 =?iso-8859-1?Q?MHiDc4iTU+lof6kHZNRYO7EFihmCzKtzeXGL2LhiJmYMn5pdiB6Rdn8HZf?=
 =?iso-8859-1?Q?3yDo1hGf/88FFSIsZIc3EbJSXL3R6K9TcW4OAKVfXYFfVaRd3R3ypEREaE?=
 =?iso-8859-1?Q?WdXMI8iX+Vp5xVgipR5Li4pAE8cttCGZBP5fVDuDWujn7rnzWTl0u3e6BS?=
 =?iso-8859-1?Q?C2hZpo6mJqxissmwgbU8sTu5V3Yos5xDHd9nLP1EC5qw7Nt2rU7ZtRCzbK?=
 =?iso-8859-1?Q?k8IZHMNyko/+Hee+j8m9ElIjxulYR+Eclde+Yi7jhtEfmWHgNUYjISe0w4?=
 =?iso-8859-1?Q?3UU0NDrvlc6la3iBRbs0tc8G2lWRCHbXc71lzDVhJXPq92n7akd+t3u12O?=
 =?iso-8859-1?Q?zAmRyDqX7YHmYeOGIfbCwOI3ecx6HPwGN1id7KbCIBvJh+pOY7xO53uUpq?=
 =?iso-8859-1?Q?Ll0vkDCRvORkCClfpHtSQuuP5rzy4OrYMGyPvPuKQ6qvVXB3Kton9Wi38A?=
 =?iso-8859-1?Q?umJ9zYeaHTUW4z5Q3/G406B2r+H3EtSMUKn0ThOk+7k+YLIK4jltZY9fr1?=
 =?iso-8859-1?Q?8hFTHO2ZEI2BFsnsoaaPSNK/pvSIPuk+IzM0iZ7MFpM0cPTX9n545HTeHF?=
 =?iso-8859-1?Q?brWS1nq0bHoxfHbWy5TWuN3Rvb8nSH3xzGoxB5N/dExHktgSpIEtbfQ+Mz?=
 =?iso-8859-1?Q?0/eFhqGYWnDJchoWlbl5BHOEV9gfsYRpa0a0r6ntILLtecUdnpiCQGQDTg?=
 =?iso-8859-1?Q?icgF7cvC/YEH2Bcg1rAVRilYfbZcPBxaIU/FgPS6YwpZfpmnzacwIC7f+X?=
 =?iso-8859-1?Q?18p/4S7DkItdgKMHiqTt0fjzGMyL/ZbR8S+L4++sQJlw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6849.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NgKQub6XWhbhpdn9BpAlGfXwO/eQl4r5mo//RxrVpxYSS+iojcLxi4DGEW?=
 =?iso-8859-1?Q?ZecsZWPEOlTXuy6mzEP+gy9suxlOdd06FiwJsg+/ug5FvCmG11h/zNHVcN?=
 =?iso-8859-1?Q?qx3uS2pupYkcWFeBN/5tucdSqWuAIR0DkFnonl+pcURf/MKdyIn8tHCnBn?=
 =?iso-8859-1?Q?HhvO/ptzgB2jcqHDeRISQq2uQdVNKI/oBQeUNOUAKm6vimGyrNWBZi6bAH?=
 =?iso-8859-1?Q?Q1k+U8cvfK4mKDi/YVSjrkb09tR0NuIdiJ/mi27CFMLHNSB1fHPDcppHh/?=
 =?iso-8859-1?Q?L4Eo5lwvRXVk+dbtlGvXh3dIhawF2cEI+jIAQM7+VCfcCyKEB2KfbZDxnH?=
 =?iso-8859-1?Q?Pt+zfnmtCzD5sUo1ASQjDTq6YqvpIs5BtIgPdUuy2KZHPA1GpSlvYD48Mt?=
 =?iso-8859-1?Q?Dvi1a/UdM+LGh96b+Zg1Xs9XStLYDs5zG/uaeSzXdMtPN/lsIRCV3PdbPP?=
 =?iso-8859-1?Q?KXEupeJ8sAKNm3rAIUgNOmp8xWF6304aEj6h0cAQArIUoihweBk1xWl7Np?=
 =?iso-8859-1?Q?DsOPUNoq9CR1hNLtqzc9nefHfFrLBENx5Rnwae9Y4y16l2q3dD6J4dZUNJ?=
 =?iso-8859-1?Q?R6bLMNtQvB3XXm6YOYtWmsojRmpm/J09bHqA5Esa6ErheHXazrxQfoq20t?=
 =?iso-8859-1?Q?rk2lAKrztbDvpCmIFHwk0ufkwnarrrWJO1Npl6ses1zCOG1LA0nAsbayFv?=
 =?iso-8859-1?Q?Ay2b2J8rg0Pkw5LkC6tFBTsk1nUXRDVxUaOaqWc/gv+CvD3EzLxo2HFWDR?=
 =?iso-8859-1?Q?4SA2e0rSUrNvWxNJaKLE9rKpWg1j2ri9Z8GPzQyvBukMiAwHwTSySBZ717?=
 =?iso-8859-1?Q?RsvvwqLtlWUp/TybKNdPlfR7BwEzVsbyfG7AFjMlMryv7i1jwjfXlB4Yth?=
 =?iso-8859-1?Q?3uXYBMwltFxoun0n7wM0VBeuMCVsECXNhUDmrQQ+woy8tKNU32WfbJ8gOM?=
 =?iso-8859-1?Q?tX8pdu3+sq6gN31q+KrKMuy8/jdXXNTc0zQyvrLrD6GgVJsGpF1h/UtZme?=
 =?iso-8859-1?Q?xbdKamSzDV3An5ZFSIJ0Sqv/MShlySlan//1SJUR3vkK/r9jqDdYfwevJE?=
 =?iso-8859-1?Q?JDJtXTTCZkmR9DHg8N9+2iXP4XAbx0dM3SfGTeDg60GIXBWpKv7zdSRw+9?=
 =?iso-8859-1?Q?GDiZxL1dpcydoKhgE9MEbh6VxW6hyBffm80YrqcqZcM4bytOTnFrd02Slx?=
 =?iso-8859-1?Q?VUEELemn3h/BQq784m98730+UwFFyfL4wFBC/cIw5HYAv5cftb+VbitL3z?=
 =?iso-8859-1?Q?6ciGo94wuvC4sWt3lxkbZKluYZT34w2SYv6Y0AGd6XWPdwBinzbOTx5xhc?=
 =?iso-8859-1?Q?gV6Q0du+ue0IYnOWSqV2iJgOTeA7RNIjKwEFCTX+o8sz65ZPJlNeUQBqwD?=
 =?iso-8859-1?Q?8RLkemkhUlkVy9p0d1ZlDL/MgMMPAXBiNvB7WFHPymbS0uSF6RAAnIgbrp?=
 =?iso-8859-1?Q?7Zs3vYfndmJ2pWU8hAkuWmnBP3gzPCObjP0lxKnrIjOqTwzpiBxET7IwuG?=
 =?iso-8859-1?Q?/xnsJ24aP+Fe7zLvL+ytBJ6KwwVaQVNKz72JCJdHOz12GOTxuMfzy502Cx?=
 =?iso-8859-1?Q?rqJobfDgvav6AwBYDzcyVJ8QTqF4bvIPcZ2Py5Oh5CwBRLGHQKBd5++aBB?=
 =?iso-8859-1?Q?7HyiOE5z/rt2+xNKRk/H00aDaGGQsG05HN?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bcK2DYYIXbl5J8UPS0VL0DHUjri4biaKb/NBXgb5EH1wKfKFN2Kbc5K+v+L5iMEVfQ8yrXpNa5UbQkwMYITIjS9pPOiTSQTP1ZnoRmsqUsLHvUguBywFpPlupDVk9jasJimpLlSjo/es2h1r0iB7VbU6YLqldNZBXQNcAJO/PSjjfFhjUTrVZ1QwU/oE3y6nHDJVMldbg3fvfkvFGL5F8FZhuascEFELVnr+wIishLPBbuFaS/YXqTLHF4MeYC+tBm2yWPsgMFJw1XM2T2YR74Uyfkcaj9qPgdk0AwaWH313qECZHdz0OofMHdCnQhUToeIz33/SPZW0v5YB428TZdWRgN/PWDvYA598J685NGUfXACSmTee//TCXmhy87CYQzdEGWnsjENqWrVHBQ1C26DUKTv+GbDakT7s6txI8bur22wypPJ9WXU8b7JqmsUEoghFaW6j+6xLKxTw4bZ4l7CqcsLcKtX+2xeqv2iRhbd43E0ogmzNcRLk1SUDccVoutksN4uu83UV06peVQoskIVJUt3lCElmZbH6JNeAX88xF1ury6kvImMHhEu+PgdXjWpAqLe4H650f/3aeNQo+YceJSeBICln1cGGJ4UZ8iGcWl8qtqVRCan433eHpZLh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa96d09e-e16b-4680-f32b-08dd7e04062b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 23:03:10.4587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 92jLmMkpGipnKJHCPJ3G5+fT7kAdkKaixt17y556mppD4P6yA8rmlIYTSmBTDZJQE8O6SpfhydmJ25GqgNpexA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7527
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250417_160317_665339_40BC8ED1 
X-CRM114-Status: UNSURE (   9.61  )
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

Sagi,=0A=
I tried both of these patches but looks like #1 causes an infinite loop. dm=
esg was full of panics.=0A=
I had tried just #1 and later with #1+#2. Both failed the same way.=0A=
=0A=
>How about these two (untested) patches:=0A=
>[1 based on your recv-side fix]:=0A=
>--diff --git a/drivers/nvme/host/tcp.c=A0b/drivers/nvme/host/tcp.c=0A=
>index 72d260201d8c..4eb9a2dec07e 100644=0A=
>--- a/drivers/nvme/host/tcp.c=0A=
>+++ b/drivers/nvme/host/tcp.c=0A=
>@@ -1348,7 +1348,7 @@ static int nvme_tcp_try_recv(struct nvme_tcp_queue=
=0A=
>*queue)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 queue->nr_cqe=A0=3D 0;=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 consumed =3D sock->ops->read_sock(sk, &rd_desc, n=
vme_tcp_recv_skb);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 release_sock(sk);=0A=
>-=A0=A0=A0=A0=A0=A0 return consumed;=0A=
>+=A0=A0=A0=A0=A0=A0 return consumed =3D=3D -EAGAIN ? 0 : consumed;=0A=
>=A0 }=0A=
>=0A=
>=A0 static void nvme_tcp_io_work(struct work_struct=A0*w)=0A=
>--=0A=
>=0A=
>[2 based on your partial write fix]:=0A=
>diff --git a/drivers/nvme/host/tcp.c=A0b/drivers/nvme/host/tcp.c=0A=
>index 4eb9a2dec07e..daf59e75cf15 100644=0A=
>--- a/drivers/nvme/host/tcp.c=0A=
>+++ b/drivers/nvme/host/tcp.c=0A=
>@@ -129,6 +129,7 @@ enum nvme_tcp_queue_flags=A0{=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 NVME_TCP_Q_LIVE=A0=A0=A0=A0=A0=A0=A0=A0 =3D 1,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 NVME_TCP_Q_POLLING=A0=A0=A0=A0=A0 =3D 2,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 NVME_TCP_Q_IO_CPU_SET=A0=A0 =3D 3,=0A=
>+=A0=A0=A0=A0=A0=A0 NVME_TCP_Q_WAKE_SENDER=A0 =3D=A04,=0A=
>=A0 };=0A=
>=0A=
>=A0 enum nvme_tcp_recv_state=A0{=0A=
>@@ -1063,6 +1064,7 @@ static void nvme_tcp_write_space(struct sock *sk)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 queue =3D sk->sk_user_data;=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 if (likely(queue && sk_stream_is_writeable(sk))) =
{=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 clear_bit(SOCK_NOSPACE, &=
sk->sk_socket->flags);=0A=
>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 set_bit(NVME_TCP_Q_WAKE_SENDER=
, &queue->flags);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 queue_work_on(queue->io_c=
pu, nvme_tcp_wq, &queue->io_work);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 read_unlock_bh(&sk->sk_callback_lock);=0A=
>@@ -1357,6 +1359,7 @@ static void nvme_tcp_io_work(struct work_struct=A0*w=
)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 container_of(w, struct nv=
me_tcp_queue, io_work);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 unsigned long deadline =3D jiffies + msecs_to_jif=
fies(1);=0A=
>=0A=
>+=A0=A0=A0=A0=A0=A0 clear_bit(NVME_TCP_Q_WAKE_SENDER, &queue->flags);=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 do {=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 bool pending =3D false;=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int result;=0A=
>@@ -1376,7 +1379,15 @@ static void nvme_tcp_io_work(struct work_struct=A0*=
w)=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else if (unlikely(result =
< 0))=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 r=
eturn;=0A=
>=0A=
>-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!pending || !queue->rd_ena=
bled)=0A=
>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* did we get some space after=
 spending time in recv=A0? */=0A=
>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (nvme_tcp_queue_has_pending=
(queue) &&=0A=
>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sk_stream_is_write=
able(queue->sock->sk))=0A=
>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pendin=
g =3D true;=0A=
>+=0A=
>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!queue->rd_enabled)=0A=
>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return=
;=0A=
>+=0A=
>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!pending && !test_bit(NVME=
_TCP_Q_WAKE_SENDER,=0A=
>&queue->flags))=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 r=
eturn;=0A=
>=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 } while (!time_after(jiffies, deadline)); /* quot=
a is exhausted */=0A=
>--=0A=
>=A0=0A=
=0A=
-Kamaljit=0A=

