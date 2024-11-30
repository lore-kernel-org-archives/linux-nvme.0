Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5A3D735FC
	for <linux-nvme@archiver.kernel.org>; Sat, 30 Nov 2024 09:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PnFK5bVdZmGcTBMEok3GLMIg9XwBnQv+ZjbvnVLxZGk=; b=MGe5CfUKSCaTKNcA7/HnkK4rjg
	ZIxERPPE+GiFRgwJzi9deyvAZAbeS1BHTB+5hEte3wlxnbucSpjS4TrBx13LzjH05+dkDSmrVw+0n
	0yQcr+gjtjVM0X9lIXkF8KPab4YBA5PQALkv8/OqrriC8EVi1GqDljXxpEwUyPl0tuecWceIODwlc
	KZ8Dpimx2uTIofC797fYA5lI4vyKWD3TFv5RaE/yRSX5inm4Ri2ocdTdxKqn16w3WBfrs9MYMy+Mf
	4s1gjgkL91XUJl9/4BwdiE0SqM6uIocIEjZb1PMq8m5grxC75cf96CgqK6jKU/kWPPfVskXZzXDmp
	Z5tfbgZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tHJUj-00000001fRc-1jZ9;
	Sat, 30 Nov 2024 09:10:29 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tHJUg-00000001fR8-24db
	for linux-nvme@lists.infradead.org;
	Sat, 30 Nov 2024 09:10:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732957826; x=1764493826;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PnFK5bVdZmGcTBMEok3GLMIg9XwBnQv+ZjbvnVLxZGk=;
  b=mr+L0kgLjUKkqPKPNJLqQ4AHaHMVW1LPJyH4iHVp6C2WtzvCIFQySJaM
   yQyjnn0PfTzr9/vHwxYv4gbNQ8kmSoKB5DJwxV639g2Q5Nc9qTDcyeNg5
   NwKwLe9QGSfGGTA8g9YdWV1LaR1aOZn9uUwqyF/4WhAyAtboG0g4IMs0g
   3JmVO3HC4UbZQDxK05CH6/fv79vJKrRWk+fUeVltMHVyLlNGlqbJ1GP1J
   ZhpH+7QHaKHd+8Ma7GNSZTV06hdOm7D5OXtWf2G6jzzm0QGHLt0BqxFf5
   pneYxl9LGaCzo5F0S6wwyCiqQnOYz7hQRFE015gzEFfcltKmr24zvzwDk
   g==;
X-CSE-ConnectionGUID: KbGyc9U8TICbiKe6JM+QFw==
X-CSE-MsgGUID: LkMTHmChQ42JanwAwcsQbA==
X-IronPort-AV: E=Sophos;i="6.12,198,1728921600"; 
   d="scan'208";a="33779536"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2024 17:10:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iqorp5xZE0wDZqw9WrN6HJCPV+AXHHsD2FXiZZZUiskUsqATREZ4oCloPEWY9Q8d60/l1XsV7IMea0DwvcKfXs2K8TACkE+Lgw63ozO8VPkW9BOU50/15YdDLaI6wnZE9xUUNRy5yonTqESg+/G8LTYughnfu049b3/bo9YUB/kZwUbhSNj3UZw6jA4mSFg2SCmGegVppkgwo+7KTYCuEhuha1b6oEBDs7NwxyUN6npHGw5lR+gJqzFBa2o9HIFjv7yLxTyrXj3TyjApwjj95n8+L/dq1/TlqfHF9FTKLzmzXQaXqU8fuqs6sLyT6XR1L1opplkVeQ7yxgxZSaqq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnFK5bVdZmGcTBMEok3GLMIg9XwBnQv+ZjbvnVLxZGk=;
 b=MQ9SMZNFgfnRw0JcTU8rBqNhrxev+z0I/xlvd8kP4xF0HAUqf06EpRynW4Gx8jPoALV2MXZIiyspNmye6+prRrUKBTRnsm5SOCX9HS0EsR/uP/iRDFCbNJ4kKqK9a1AcXe0Fk/w3K7EphLhmFtQAQeV6v+0D96yUsjmiMCLcTLnb/7AdcjvBzVEHAK3gfMlVREDTybGpcVO/u5HjV0jgqBbWoX/jRXuQ/AHbyoKyn8bvaDrLAUR4fWGmgC8QSrx7j2aj/IVFqHu7h1aC1PaWIDB/hOM4xemBUxkco9UN3JR51ctINjOOHIT2ZbYqJyI2qihuyFMFV8JeHYTOUfcxVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnFK5bVdZmGcTBMEok3GLMIg9XwBnQv+ZjbvnVLxZGk=;
 b=SCd7/Y8B8vJRmw/CabTr96vdsKQdNqGTQpzoEYjuNYEnKrhLY+i2+dvgEXQI1Pi7z4fZpq7T8vQtC4tScMTOuhgBG+1/TCTwvCyjBbykutwmAno2d1k8aH2vAvRrobuJ78eUC323dHdEmJIHhwifv81AV0rETBPdPC6/9IJhY+A=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by MW4PR04MB7457.namprd04.prod.outlook.com (2603:10b6:303:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 09:10:20 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::2482:b157:963:ed48]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::2482:b157:963:ed48%6]) with mapi id 15.20.8207.014; Sat, 30 Nov 2024
 09:10:20 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, hch
	<hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"chaitanyak@nvidia.com" <chaitanyak@nvidia.com>, "gjoyce@linux.ibm.com"
	<gjoyce@linux.ibm.com>
Subject: Re: [PATCH blktests 0/2] add nvme test for creating sleep while
 atomic kernel BUG
Thread-Topic: [PATCH blktests 0/2] add nvme test for creating sleep while
 atomic kernel BUG
Thread-Index: AQHbQji2nd2WUOE9rEKflXfeOZlVkLLPiuaA
Date: Sat, 30 Nov 2024 09:10:20 +0000
Message-ID: <kuvftnq5cjwtzh557umohu7afvndg3tl4lx6qfjjuwd675phk3@y5iaypkzdsz6>
References: <20241129080231.2994578-1-nilay@linux.ibm.com>
In-Reply-To: <20241129080231.2994578-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR04MB8048:EE_|MW4PR04MB7457:EE_
x-ms-office365-filtering-correlation-id: 28940b51-7577-4a82-356e-08dd111ed080
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?62gweR0/UpDk0JQELQvJPRZEAV30GUbf6EUnU82WC3qPMGv6fSe8qoQ1zI5S?=
 =?us-ascii?Q?pg/VkDVVNX28Ap+TdABpYuybvyLFizI0HjUJ4DCIIBn9kJRcTk9oldCe8O/i?=
 =?us-ascii?Q?itHqtYOBmzker9wAwTZ6BgtkNX/FCS537+P7177ck/WhWTLNCjm1EFR9Cz9X?=
 =?us-ascii?Q?y66PvIpfiUqlvGbT+TwWn5ql1wrGkSDv6L7u1+82DYU6y9bopibjpQrjqcuN?=
 =?us-ascii?Q?9eSVwPjZ8RKVuaM1bVWhwu1elJXFay2o6UpJqyu/pCPoHSVMTnkIWfJ+YFvV?=
 =?us-ascii?Q?qLq7gk5DMu7mubGhtumfHARKvLd6BAhgf0jmv+ugFwvX4AolhCzEwUeLZabH?=
 =?us-ascii?Q?FXzrIGFcFyutGZYZ1S0ZS7/KDhQKwEr05vgQnTt0w8rfRLFBL65pVZ315hr4?=
 =?us-ascii?Q?g+IdU1Xa1IUTJDeeEbf2Xpazn7Ty+1PUvr0pZHWQa9Mz57knmcM+MfOO/m/X?=
 =?us-ascii?Q?w4IIlORV1mW/Lf68NRSD148W44n3T7D6Ge/k6S1qtYhPDRxXwdVM3xeGvxWI?=
 =?us-ascii?Q?p6aiSmpUz+PNUqnlrnxPesZ4+eHOfJ2YWZXQK1tfFag/VFmbz1KW0ROk4441?=
 =?us-ascii?Q?IS7/nIw5FuIuBDQV7nzabeKdML6GAPBYENIKxhE0nGsPoucvnR7cz9XmDFOE?=
 =?us-ascii?Q?e40tuuA6AWMZZzShHvRg82rOqMOKh9d3EmKOw+0VT758gOcX7nthov7r0NtK?=
 =?us-ascii?Q?jtm5twM8IySroOc/y4Ejsl5FHp2ABZ2mx22JhGUooFNnbwnHasDiSOMmfmPY?=
 =?us-ascii?Q?HDu7Yqb34NNIvIXo+yxpnHj91t7kpcOQ28eEdwidfcm0Rln1fOUOy8TbMXRH?=
 =?us-ascii?Q?JFci87eK3jo1FIVwuOAUPCy0FiJk4Ffc2Zg1htglFSl39wRlY0MO39hqDRmE?=
 =?us-ascii?Q?O47UqC+fWyXo3iozu14FwEumZdyTqMol9HaKnbDjHvmcnS+ATobijkxvWJZA?=
 =?us-ascii?Q?9X+3y6+MOq0pwtzOUDIXBcl+JmHGKYvRURs/cnM4oTtUOQvAPjgOQF4pASML?=
 =?us-ascii?Q?GM6g2brG6qbmz5AsuGym1ZceJHbsYN91PNkVBaHuTwF/kKTHluHVNhAGMYeQ?=
 =?us-ascii?Q?Z+ItTEctWa1ygP1spIHc07WdkOF9z8ZUW46Byvu1VkSLFvs3lWd298TLGOaX?=
 =?us-ascii?Q?nxN6FiSMd4WlvE30WUDlWX3Dq8atzWErrXAms6t4LjcHSu7XqF3vw9lrqRKl?=
 =?us-ascii?Q?pUzm+MqR0Z1idXFDvqsZHG3r+8uHWQgtrSPcsCV3/FaO/nrCCKFJbAY/uBpN?=
 =?us-ascii?Q?TubdPOb7gbTSQ7VOk8XGJ2sImI7vuGkNWOntNxF6KzgP7rLQTnoweE8UZrhR?=
 =?us-ascii?Q?mnU3b8RqS5WhNtuSPaAjWPmtQrK1iHk0OnUFRTcNDhBagN3RJvl9+oaDFpbz?=
 =?us-ascii?Q?KIZ1H7bwlR5u40JlxjUM+JB+eQbesU4GL2SYRcoSe7AwVWvRZQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r6rWQXvszwQPU9ijjJxwXh19opbH3U/joNXK/MQvEyrzG9N4YIOL2+/T47+f?=
 =?us-ascii?Q?9ow9sG5KeX4HJwNfEPUuSkeWD4sqaNb/TfDU1KrFjlPo49KigDnz2DTIunwL?=
 =?us-ascii?Q?nP8pJ6gsZbkBd9PwT05Ewrj9FXufve77BrhBRSzXwqhMqym/MSb4uOkUjBh5?=
 =?us-ascii?Q?9l1kyAx6dp6HL3y0HRPqoS904oPnIiMKk1uPH9Dew2Ksro9M5xHLVqz3tUTd?=
 =?us-ascii?Q?VK8etCjssMKxp+NrTHljv80dZzzAVs057EIwTLfXPFNCPjnM+nBtEa5Q8fhJ?=
 =?us-ascii?Q?LZZ9BdHU2VGmOccGktl/ZYMKCIdSNQoDeb2U1LlCsqLxgQP4OFMHzvOSN+iB?=
 =?us-ascii?Q?mZLQcEG7jZyeRS1d/rz2DNCtYXBC3QDb9pzYVKtM4/40/jRb2gYpdBNEObWq?=
 =?us-ascii?Q?8HlN9a83zU2Uv7oPUH+qN4eypWCtjU94pgMJWSX6OpSg8nPRaPNfkZvwXRyl?=
 =?us-ascii?Q?3zShi5U9+aRKGQaRzfxMhlZ52JdYI6agHXtw8riyIGif7/2VtxrRcVCpErZ+?=
 =?us-ascii?Q?fantx+sY21+POvxDDVaitq/QJPV3TKGLr/vUa2X1qXkWG8Ie7eJUs+Io4WEO?=
 =?us-ascii?Q?8Bm7GTiX0F+tC/1HyLKp0MBH5A2Dhck4Mx61w7ajFLR6kT4aAC3QDor5FC1o?=
 =?us-ascii?Q?S5TLzwYInsPrBaz7b/+Odd20FPCr248GtoqTUQrP5/SML67M5DrbJ8DoYOci?=
 =?us-ascii?Q?1Y7KqTGviXWOJ4xLqw3E5xJrBjmPbi+dpNkShFYgoBcyCqzqLzKDlS+SZsv/?=
 =?us-ascii?Q?1mKvOJmElfXBQ0UxxbchbV7+BxCcwg+HSpMK+/ljed9To/ustpV8RUbecsUJ?=
 =?us-ascii?Q?BfCQIhVUlsIkeAlJkCxwzvcwo+BXD50clqa66JbaUW2m/pH4v2n/5XRonctY?=
 =?us-ascii?Q?JgyKQjONUKeaqaAq/R2qB046XrKwwVEdkoZoZIKUVDf5gyTOQ0IelwTSma5y?=
 =?us-ascii?Q?B7IKAXKu2N2nTlun1kgGZ85NqWdzM5p1thEMgB0ERLvJJMJAwCUnw7nClzSa?=
 =?us-ascii?Q?H6FdYCOCMGWXhw0mmrZYKQgzrFv4a2kzdDs9KDg3e88whJRRjNbizhj7x2o/?=
 =?us-ascii?Q?X2T3NJKYXW5p5c/ZXDOjUmzljT9a14fp9/XfFuTEAy/e4XqTCsKx1HaK1ojw?=
 =?us-ascii?Q?ZWe3JP3nUhxhZVjXiFZwm5I/XmfAA1T8p+UdvXpEtM5r10068xhSQ+5+Kb+6?=
 =?us-ascii?Q?KE6kygiQwl5+Plfx690Hz8wVXRIQsSthT9TzEUzcExBIMQSZCWwHhVsh5z8G?=
 =?us-ascii?Q?2mkQJQ936Tr3uveaUlZbOrJomEn2f8CeO3ZM/ioEAqJWhs2gI3pm4ip4W/3c?=
 =?us-ascii?Q?fzhBtl1P+8fqJDdtDsuNK+w+YGr/Z1yvNAaCxB4XCN2oOGIvxoH32DXWzo/M?=
 =?us-ascii?Q?SnG2lq1QSjIwCCfk/ufMEkH4iOmxJwk7shUhZGntcg6nZqpKjoC97cYJz8m9?=
 =?us-ascii?Q?yG3Qk3K6WES6FVFlT7yrM9/a8Py4inpFlzdF9SN6MpSqF0rHaJsbvRK395RA?=
 =?us-ascii?Q?OtLOQ4bdL6y17txKpykPUYEho8jAYx/kGTdy70k1/VZ5DmnRBhpcvkUJ0X46?=
 =?us-ascii?Q?z0lsf1s+XZegd1uCRnbJc1Y/9E55YLb5mtebV+7rxUkjAmHJuxX7YYrcSaUU?=
 =?us-ascii?Q?U4K11seLC+a6i4wRtFnkaI0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <69AED8211E91354880042C2CBAFE4D1A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wZ8IT673xGjbUbvq/+UquRXWaVfxWtxURTT380il/yx3GvxZotq0hjGFbPRBHjXpoechGjuJcWm5xOVxQVM5cp7bSflOkqU957XZrg1DTW9sNYKh9bME+uBUsfy2N+aVE6NqXQsXoueX0HpoHUbLpaFokkT5NoAjLEbMjq+xV2I9/v2WC6cYhXqKr809or80VjMFWXbMUDWls0HWnXdKghQ36xgXGBiw5uiKf1OOgYmMkVmPMaU92HdcO5LwRG9OKaBR1tKVRadgpE8huKVoU7bAgZpg5akiHvsAOjpWmx32eJXpUEHiWS7OgpYv0AfXnZ26UbpKtbKmwOautqdzYxsqblEv7lTHAJfn9t0p65rLFQB3YlLiR7OYUDsrXsmqlcX2Jd5z9FuQxVLzF8+bqLzonzIeYQojSY7pVLdmBFDppnrQ/KBkKknuZ6fGA8KojS2YyMsbCOH6tqfMA7Xznxg6Ww1+A4O1xcDvkInsyjCtewSu+385ZSk/cT1tywJuoW2G+iCohzq9tu2nNKJixX38ia94Dn+ee6SOjAU27PpB+dZ6wQxftUXEU6iZ2lF3+AqcAcap0LkD2PYlHMilZfc2ZAC/EaDY6BqWAt+19qxtSo2TIGDXHfOmvCfwSG4c
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28940b51-7577-4a82-356e-08dd111ed080
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2024 09:10:20.0968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7N820oyIiHAfWH7iTGVpi7aPgbRZRm7Bk/Mf2upwjwUVhOmC3dCQz8naeomrp+8KN3r95X3TNnYHgKCJa8rGLl1yzqSAvSDFoVmD9tkc1y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7457
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241130_011026_794777_34C7D6F2 
X-CRM114-Status: GOOD (  15.17  )
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

On Nov 29, 2024 / 13:31, Nilay Shroff wrote:
> Hi,
>=20
> There're two patches in this series. The first patch is a preparation pat=
ch=20
> for reusing a common function nvmf_wait_for_ns from multiple nvme test sc=
ripts.=20
> The second patch adds a new nvme regression[1] test for commit 505363957f=
ad=20
> ("nvmet: fix nvme status code when namespace is disabled").

Hi Nilay, thank your very much for the fix actions. Much appreciated.

I tried these blktests patches with the kernel just before the commit
505363957fad, at the git hash 6825bdde4434. I expected the new test case fa=
ils,
but it passes. I increased the number of iterations from 10 to 100, but it =
still
passes. Do you observe the test case failure on your test systems?=

