Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A0ECCF9E5
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Oct 2025 07:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rk7K39JP5qpJ6/g9sQ/1msC3BVaeNNtI21dWJvjb9Vc=; b=L1YlYJRqPY6GcTR7ho31+2JlZi
	1OBV2IhFYhj/gq+lZZxKcXB6Bo9ueVXVEDomlaw5YaJELGJceKWxi4NNzY594n03e3ZWh1r5JDKkF
	s8PgoA8ULFC/V2XaP2tvZWpyXLhE7m2pAKa5asbsGRWfESc5Rl4QfLt1OTEjPpIZoBPW8jF/hb728
	yHqRE5d16Z8D5dH56ZeEwBQr7WmnnTWav3oNs1voJ3PUUT8mwnlTFg/JoPCuW4h0dQ//9McpgoXiZ
	M5dmKjMzjOO/7sDHrf1zgmr3KhMhzDcer2ZOvd8iGCV5DRFlnibepwTFlPmYAUD88kMPD9fAErFlc
	Br+vrX0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCv3p-0000000C7XG-2IAp;
	Sun, 26 Oct 2025 07:21:05 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vCv3i-0000000C7Wh-3q3g
	for linux-nvme@lists.infradead.org;
	Sun, 26 Oct 2025 07:21:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761463258; x=1792999258;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rk7K39JP5qpJ6/g9sQ/1msC3BVaeNNtI21dWJvjb9Vc=;
  b=f18nUSRBSzwrYiO61t9LuAC9aPZfOZHefW9xD9lWHIqqk2np/hc+rNMN
   D9Qk4O4sXDv/6U269p6uWt+nNs1mR2K0IxgEAa7IJ0e0xQJC/mvLLJS3j
   yURiB1nH4mB56EXsYwQ2lxSY3IO4LHauNxn4ryLE7FW4SpUeoRynP9W/m
   6MBEXHVmGrbFJWuTC2yL0NQJ6JY96r7XBHx7TronGmN/EH702UqDb7RLI
   teXN623lskmiDbN/eAfdVgO1NsKBORnnHITmwminpHkiTbwd8KR0zRlT9
   a6AzyfdWkVzhwgWG0GW9oRcoPaZeVRVr00VGcPYYIjQWP8LJcn4Rc+iD6
   g==;
X-CSE-ConnectionGUID: 3g9l653BSCWFsLJNU+fHvw==
X-CSE-MsgGUID: ySMnC2SAQA21Mfq8WJLjbw==
X-IronPort-AV: E=Sophos;i="6.19,256,1754928000"; 
   d="scan'208";a="133568089"
Received: from mail-westus3azon11011019.outbound.protection.outlook.com (HELO PH0PR06CU001.outbound.protection.outlook.com) ([40.107.208.19])
  by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2025 15:20:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcUsb5+DXjmTC9QtunWOEAnm2Uo9dq23Yx5oK2Kov/xvYaUcJmtWgtDlWdvIX7EaW7FSNBdt2BieIRXndTyJXYQETw+t986IwbSAQ6+wQ8r2Lsbj/nEXZUdD6ijucfJGz23/JLpr46F/dOOJ+Of8ns6yN1EWXD2iG0qDoSG4Vv3s9MHKvIDzYJPjl4hggOhMKdABRC10ETY5HT9B9lZYYCC5JKdQSg6pIUCnhJG/WqZnX0fWeHP19e0cwxkIc+BlX0rt5AWArqC3/jFwvPnoHg19a3iOCXljmctsHzKcE7aqATITqJYUi+sfs7z0vFqdJfoiq4afRpKHHF+7nFl/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rk7K39JP5qpJ6/g9sQ/1msC3BVaeNNtI21dWJvjb9Vc=;
 b=wCp+n1Wmy5Y+QN0/V3XXrL4SpT4gXatJxa9Uk+P2p2uc+ZUxocXh/SI/Og64eNB/WSMXTN4K1JQ64CPyDXC+wG0UWRlEfpldtmchZUgNtQ/lRdBSrYiaAzygXxdGmympSIPCaU50w5/vXKwsZm7phhkUaq6R6E85/z5gqdzy3NcdtaKV4S/VZEJ5gFAmJWAGT7eaqHeqlgbM2qjmbmZnKddwz5MlwnokLibO1ybFlQ6oS1KOymJrB1hqr7TG1MIbsGHCNFXWwU4FYLCB1/wHvIWDwAwImzfoCSO1cJercdKLhi/M2Wo7zj2tIohvgLI8hzoBCy0m9SgzLfBWl8kw/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rk7K39JP5qpJ6/g9sQ/1msC3BVaeNNtI21dWJvjb9Vc=;
 b=WAAl3yX7MS1FSTt5mcu27ydsNpfGu84FUnRFvy0mVjUYhsd9LdL2n5gV1cDvp4b/ByT8lL7AlQlvgni690eBqByNhB8tOPyoU/PK5CeX3ZbOfJHDtKIEGhrE9FMjr1gnxUJwuJCl1iu/fInu7YzJV907Q/Wp9qg+qxp1jJ7ZRe4=
Received: from PH0PR04MB8549.namprd04.prod.outlook.com (2603:10b6:510:294::20)
 by PH0PR04MB8296.namprd04.prod.outlook.com (2603:10b6:510:10b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.16; Sun, 26 Oct
 2025 07:20:53 +0000
Received: from PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e]) by PH0PR04MB8549.namprd04.prod.outlook.com
 ([fe80::5b38:4ce0:937:6d5e%4]) with mapi id 15.20.9253.013; Sun, 26 Oct 2025
 07:20:52 +0000
From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "gbayer@linux.ibm.com"
	<gbayer@linux.ibm.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>, hch <hch@lst.de>
CC: "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"schnelle@linux.ibm.com" <schnelle@linux.ibm.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kch@nvidia.com" <kch@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] nvme-pci: Print error message on failure in
 nvme_probe
Thread-Topic: [PATCH v3 1/2] nvme-pci: Print error message on failure in
 nvme_probe
Thread-Index: AQHcRNZCvVcIeH1B/E+sQItRu3TypLTUCG8A
Date: Sun, 26 Oct 2025 07:20:52 +0000
Message-ID: <4539e32df948119ee7a7e77cf67d263e488236f9.camel@wdc.com>
References: <20251024-nvme_probefail-v3-0-5386f905378b@linux.ibm.com>
	 <20251024-nvme_probefail-v3-1-5386f905378b@linux.ibm.com>
In-Reply-To: <20251024-nvme_probefail-v3-1-5386f905378b@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB8549:EE_|PH0PR04MB8296:EE_
x-ms-office365-filtering-correlation-id: 35fcc16e-c46b-4311-9efc-08de14603269
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|19092799006|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?V1hkNFJsOXNqWG04eUUrcjdpRkplSjJUYkNCU3VLOGFjWHMxL2xXVDIzbHFo?=
 =?utf-8?B?TkdNRjJZWEhPNitCRnZhQWpWSlVWN0svcy9oYk0rWjV3VVZnazRJaHdSNGhv?=
 =?utf-8?B?T2FoRnlVbmtUOGMybHQ5VWpOc2w0MXNzNGpkOGo2MzNlNWtVdm1FR0Fwb3NX?=
 =?utf-8?B?UUhSem53Ty92Y3d0U2gwcjFudC9RSXFLT244UWdkbXFrclZKdllJUm1od1Nq?=
 =?utf-8?B?L1VaQ2RmYVRBSFBvbFJGK2FiWC9oWnhycS9uUE9KR1p3WFRpZThHcWQ5VTJO?=
 =?utf-8?B?eW11ZW9uanhBbWRndEVrYjUyRW9UeWNiM0RtTVgrQ2RmWlVRUWZld2NIRFVM?=
 =?utf-8?B?M2dhRDVzVldlTHVEVEoraXg5VGZyWVFnUktrRS85cWVNS2tMREwrMlFOb3pI?=
 =?utf-8?B?MTEwVVdZNmF1czFPMzljZ3ljWTJSQi95YWFlSitDeHlCVHJUN0l6M1FHMlVs?=
 =?utf-8?B?czNhM1dMSlR3QVZBOERuZHVWZDR0UWV2ZWN1ZGJiUkRjZk1MRnRoQ3BGT2l2?=
 =?utf-8?B?V0pxaXdIbUtGMVZKM2FWYWRkUE1BR0RTTFhoUU9qcWl6akRXNnZybzdaU3hu?=
 =?utf-8?B?OG8xRStEbmFaQkpBNmtVMmFVWnZORHNjbDFkOU5Vb0NrUWc1UmpUcFdPR0Iv?=
 =?utf-8?B?ZlpNQjBIdElpZFJXTk0yUmVWdjZENEJleWhmalpaaXFpTkdieXZsRGJxZzBm?=
 =?utf-8?B?OGd0MS9zWVRweTVPWWJRQy9EdjlWSDFQKzlXa1AwZUJnWjZacE1qa2c3ditG?=
 =?utf-8?B?a2kwZVBpekFuRnFEcGVvL1RZQW1FS1pRNFBwTEtPRkgrUTNPdU00VGt1NTBp?=
 =?utf-8?B?aUR0ZHZYblc3aXZjZ1hDZWJscUhyRUtXbXVIeVI5ckRtZ2pzOE1jZFVVRmdv?=
 =?utf-8?B?ZjJBSjBXb2ZpUHM1VUROWklhMFdjYVI4aExaYjh2SVNxazRRZlpYSDRZRytF?=
 =?utf-8?B?MWUveGRLSnBZUTEwT0VSYjZUV0k0RFV5NHYrcHdVRlZaVUwxRGZsalk5QnZP?=
 =?utf-8?B?UDF3SzB0RERZMFZVNS9WWUFiMUhXZVgwMlhyTFZ5eis3WmJSejd4MHYvUDly?=
 =?utf-8?B?c1pPQndIY1RNVmNOWjJXUzdpMEMyMStUNTlZRGJkcTl1VXlROHZZUHhDdm14?=
 =?utf-8?B?R0g5eG9WZjI1YUVqM0NHRFU5ZkxPVjE3TUFjK1lpOVNRMUd2RVozMHhzTkNh?=
 =?utf-8?B?YmpKa0hIVEVnSjJyVUV6TXc4R2hlR0tCQmhGeUZpNjdvVWoyd1VpclI3aFQ1?=
 =?utf-8?B?V012eUxJdGxTdmRPdkdubDQwbDJ1d0wzVkg1VXEyYVNHbTJraWxMbnBBajFh?=
 =?utf-8?B?RlZDdmhPMGlqb3A3a0p1eENDZ1VndzdPSlZOVkFzQ0lKanY1TWpsa2RPMnFr?=
 =?utf-8?B?T0NBaVZWVXUxNXU4c0tmajZQOHpwREJjYVU5QkM5MnRVZFpEZ0NKZnlGaVZJ?=
 =?utf-8?B?MWl2YzJ0eU9LeW9aci9yMzFEUWNRaElyUWJjbjhBUXNVRVFoZExLMzFCMW5z?=
 =?utf-8?B?bW1FSWNiN3p4eVREeTUwWjZnZGVDY2FmVGtCcmdGQVFrSTd6R2R3empTaWpP?=
 =?utf-8?B?TWZrZmZDbk9sM083MU9RdjBzaTNrdkxaaExvT1QyeXRtTHpUZUtHQXlMU0ZD?=
 =?utf-8?B?eE1SdGJnT2EwYWxTZEVKcCtKTVNtTFNWYUc2enl3bzIxbnIxSkFGc2wwU2hF?=
 =?utf-8?B?RklyclZIQzN1cW1mRzAxNTFodmlBN2xpU1Y1ZGRxME5TVDBxc2cyTU9GWXI5?=
 =?utf-8?B?UUN1UFZNVUo5Znk5M2pqM0VLZ3hDSWgybGxRaDJJT09kNUtDbXlrZDVnWlc0?=
 =?utf-8?B?TjI2VXd4NVN2ZnVWUXFIbzdZMlNQWTNtOFNPdkNLaHpWa1lESklRcHgyaHFU?=
 =?utf-8?B?MlpoUUpYeExkeWdScTk2a25JMXNWZ25DLyt2dEF1VDJESG1xOEtwc2o4TjBL?=
 =?utf-8?B?ZXFsdzR1YlF3cVgybVNUYzJXM2k1cFo4WWlHdzRkT2pUZ0xsS1hRdFRjWWpL?=
 =?utf-8?B?VktDY3cycTJ3Y1YrMUNzcGMyQStEdjkwYldxK053SjB0eWhFY3MraDBDeWtl?=
 =?utf-8?Q?F4hxkk?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB8549.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2hWNjFlaDZXSm0yb0lmNEpzOTJkdFV4QnVGR3dFZW9aRFNkNDkwdXk4b3J5?=
 =?utf-8?B?Q25pOG5sbUQ0dnpHT0FiU2QwdHAxQ21kdi9pMDZSWWh6NThkV2VEM2ZJUGQ4?=
 =?utf-8?B?aVp6VkdVNExUanRhbkYwanFINmhPckw2MmVpRVk2SHIxa0FFRGdyQU5jRUZ5?=
 =?utf-8?B?YXRzd0o1RXRUcVVmS1JoN0xkeGs5NXlac0U3R2ExbGxXU2N4UlB3aUZ2VVdp?=
 =?utf-8?B?dXpKMGkwb1h6V1d3dTllZGxiVU1Qb3BEenRhd0R6cHh5VHFHK0FnckpQVzVS?=
 =?utf-8?B?UjZRVmRmNTh1akZYcmJUcnVPTWpHaGNIM2s2elpsQXdVSzNwbU0ybVRFRWZm?=
 =?utf-8?B?blBudHNyY2Z0Z0hKdnFrYWFIM2p6NG1zNjlHOVlIeDFxdkxkalJXRGR5TUp0?=
 =?utf-8?B?eGVUUllmcnczaVpwVUEySkVwMnBxWVBCYTUxWjF6VXRpNjlwRTE3QlZUanZC?=
 =?utf-8?B?T2txTkNSWWhOTkhBSGQxOXp5RVRURkJGYVhwMUpWajdqVGo5c1h2d3NnbmdJ?=
 =?utf-8?B?WDNmQWpBRmdjcGpEU1lGMk1WbFo2WExsZStENnQ2ODUybXlFWW9CVVBqTys5?=
 =?utf-8?B?YzN1WkN6bHpxR01pYVhiK0lDNEFVT2xBLzZocEFVWmhIN0dGa3d6K0JQSlZh?=
 =?utf-8?B?eC9veGhISXp4YWNXbTVmaGNTYVFyOVV1NW41cmR6ZGVSUlBtbWs3MHBOVFll?=
 =?utf-8?B?ZGdJRHlYblBKQTlmNkFIVnNPTld6QU1iWHk3YWQxTEp4Y3I0KytkeHdVSWc5?=
 =?utf-8?B?ZXc4NUFIUXBkRFNxcEZyWnJoWWh0aDVKWkVQS1JoM1NqYWlqVVRhZk14RHNS?=
 =?utf-8?B?OFo5VStyWEJubHRjcit3RU1CWkVaMlhLTzRIMk5OK3VhL2w4d21sQkZIRkcx?=
 =?utf-8?B?S0hmY214UUJweEFLeVdSc3JxTHpwZll3citwcUtldFczRGw4alluZjBDV2pk?=
 =?utf-8?B?YzhXMjdCKzRremgvdUZOdWl4Z2ZXZTFLZzJ5TTFCZThEY0t1MWNqbG9telRD?=
 =?utf-8?B?UUlqOEJqRi9uWlRFY1kwSTNCczdGTVNGdURLOWl3VnNuN0E2RFMwOXB0ejgr?=
 =?utf-8?B?Q0FFODJUMG81QW5WVFV5VmRiSTNhWUFCaFozQzRQYmwrNFR3Wlk5UW5sTTVU?=
 =?utf-8?B?WWJrZVJzTFVacWxreVRKc0ZFMXM3bU0zK2xaUHdFNkpRWkFQcS9XUTRzc1lC?=
 =?utf-8?B?TmtHQ3ByQkowNHY2bDdjekN2L3AyMGFsSGh0aFFKZ0tiVEVjMjYxcWFTWXFq?=
 =?utf-8?B?RGZnVVdVeUo0K3FzdTdMdmtJMWpFbkZrQjZDb3p3QkNLdG0ydWNSYmNOR05Y?=
 =?utf-8?B?Z0xucTJ0QXQ0OGQ0cmw0K2IySm1iQ2NBMHEremVXRWhucUwya1hydkxmMWdG?=
 =?utf-8?B?TmJjV2s4bXY0Y1Q3NXZhSU1MMDI5NFFHOVFNUU8rTG82cGxQYXlHTk1DdlN3?=
 =?utf-8?B?V25RYUk4V2VKV2lCY25FMXdkNGo0Vk43aHR2dHdPMlA3V3h1RDZBRmNJQWpO?=
 =?utf-8?B?MUR1dlpqVENzYXN5TFBtR2Y4a2ZWbXdFdjN4S2JDVnpSV0RVQzMyRWZMUFE5?=
 =?utf-8?B?WTk3bnZ2Q0dYNWtiR3BkRTVaRGx2OC9JZjY3U3MzQ2lXTmlyM1R0OWM5QStn?=
 =?utf-8?B?VkpVd3FKWjI4MHNITCtuYk1UVVVienEyaUlERW9vLy80RlFhbnRWUExCR0M0?=
 =?utf-8?B?bmIrd2FOckhZM0ZTcW9lM3JJVGYwS2FPV0lGaG41SXJGem9UNTIrcEhMYUQv?=
 =?utf-8?B?L1VzWi9wbjVWS3hoU1YrcUhHT3BjTVhoaTRLR2lFNHoxd1lHLzd1VDdHNDN0?=
 =?utf-8?B?Mno3T0dJMTE3Y2hHK21VZldpSmJtUzhFZDBUUW5KZWRVRXdVNzlhNlh2QUpP?=
 =?utf-8?B?TFc5MDgzdm1RalRPUDhoZnpDclJDdGpRME5rdVgwR01DMjRvWFpxSVlLVG5S?=
 =?utf-8?B?RmE3VDJBN3RtNVU3a2VIK0syK1FjVlJqSWU2dWNmYkx5MEpjcTc3VTNQb1J3?=
 =?utf-8?B?MGE3SkhTcE1vR1pNLy85TGoweGxjSWFjZ2tUL3g3OXJQQTgwRHpVcldOODdE?=
 =?utf-8?B?cEducFAydGJvRk1XaXFBcG9iL2RvR21OdEVWTjBxMjlTandCamxuVzhaeCtJ?=
 =?utf-8?B?eWhEdzZJTGpwQkJQZlcwMTV3Tk9MUVhncGx0OWM5eGRya1RtWDBDdUhKaGVX?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1F6E000A04CE24F85ADC7D045C8AA69@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Qzn/DEtc88PVYYitdgXXdp6bq+FLQTF+IbPe74useR0RF/tjLWH5FGD9raxP7w482tsxcDCeHjcfgJ8otr7YhksOjyvhTNSK4h9PXetsDgaw2foSLapOCcmQSIYe3lEPfxZQmmJq+EOPrbGlzO2rmRNm+OkIfQgpHngXxxKAYNEnVPDTXvAkbdBeoOmRBBBvTNQvZnhhfpmnnPmaGV6Bl1oHrOjREIYl9EB4ajx78gApjqyyh/Mcc4JBrXmdewB0oQZqS8bln7LpImovGhgaG5ew3E1yKuW9fWR1ZxaYEuGsHh8ZOASsDb5NfNdzn0m6vEYap5/3bLlhN4dslsm09GwOfMhFb2k60s9kWSAk8v9jrnzwvUfZYIMQx0OI8mIDvvgeOOAIeTZ713/plNZ0QwOfDe7pcyA8mLkwGTlmLGyEbvd7fcOgg6ZsRPD+oAgIJ/G/lX0YxZQESotxRwYfDD+U0ABXELWc4FiEY+Mf6idfyLvfnXw7lJG9985tlopEeEepZphKqUc7xNRFv0qazchk/DOTCxmjYqoOVz/kCY0GPOeLZF4VD26LtAurez5qP8moUMOMTUR4stQkHRqamTdswQ/a8/yqFbXizrouSPnyxN5HM165xUsmTalzdT3h
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB8549.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35fcc16e-c46b-4311-9efc-08de14603269
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2025 07:20:52.8023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7N814mJQFzqIpIiO3AwD817sz06BB4eSjDyMZmyrPRfn9C+XhAr+RQt40b+fO4vobFRt0DKfY6Lip5iHeIR/6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8296
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251026_002059_054212_5FF09F37 
X-CRM114-Status: GOOD (  19.55  )
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

T24gRnJpLCAyMDI1LTEwLTI0IGF0IDEzOjA1ICswMjAwLCBHZXJkIEJheWVyIHdyb3RlOg0KPiBB
ZGQgYSBuZXcgZXJyb3IgbWVzc2FnZSB0aGF0IG1ha2VzIGZhaWx1cmVzIHRvIHByb2JlIHZpc2li
bGUgaW4gdGhlDQo+IGtlcm5lbCBsb2csIGxpa2U6DQo+IG52bWUgMDAwODowMDowMC4wOiBlcnJv
ciAtRU5PREVWOiBwcm9iZSBmYWlsZWQNCj4gDQo+IFRoaXMgaGlnaGxpZ2h0cyBpc3N1ZXMgd2l0
aCBhIHBhcnRpY3VsYXIgZGV2aWNlIHJpZ2h0IGF3YXkgaW5zdGVhZCBvZg0KPiBsZWF2aW5nIHVz
ZXJzIHRvIHNlYXJjaCBmb3IgbWlzc2luZyBkcml2ZXMuDQo+IA0KPiBSZXZpZXdlZC1ieTogQ2hy
aXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IFNpZ25lZC1vZmYtYnk6IEdlcmQgQmF5ZXIg
PGdiYXllckBsaW51eC5pYm0uY29tPg0KPiAtLS0NCj4gwqBkcml2ZXJzL252bWUvaG9zdC9wY2ku
YyB8IDEgKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jIGIvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMN
Cj4gaW5kZXgNCj4gYzkxNjE3NmJkOWYwNThiNDllNmU2NzY4Njc1NzExZGY1MmIxNTc2NS4uOGM2
MjQ5NjBjOWY2N2UwY2M4NDA5MDIzZGU1DQo+IGU1MzJkNmVkOWIzYWMgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5j
DQo+IEBAIC0zNTIyLDYgKzM1MjIsNyBAQCBzdGF0aWMgaW50IG52bWVfcHJvYmUoc3RydWN0IHBj
aV9kZXYgKnBkZXYsDQo+IGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICppZCkNCj4gwqAJbnZt
ZV91bmluaXRfY3RybCgmZGV2LT5jdHJsKTsNCj4gwqBvdXRfcHV0X2N0cmw6DQo+IMKgCW52bWVf
cHV0X2N0cmwoJmRldi0+Y3RybCk7DQo+ICsJZGV2X2Vycl9wcm9iZSgmcGRldi0+ZGV2LCByZXN1
bHQsICJwcm9iZSBmYWlsZWRcbiIpOw0KPiDCoAlyZXR1cm4gcmVzdWx0Ow0KPiDCoH0NCj4gwqAN
ClJldmlld2VkLWJ5OiBXaWxmcmVkIE1hbGxhd2EgPHdpbGZyZWQubWFsbGF3YUB3ZGMuY29tPg0K
DQpSZWdhcmRzLA0KV2lsZnJlZA0K

