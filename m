Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69FF3CD3445
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2026 20:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	In-Reply-To:References:Message-Id:Content-Transfer-Encoding:Content-Type:
	Subject:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H8QTXNED7ZIuZSaGEpmFtKE9Ea58WrXFvajE8xQTBvM=; b=pWgWLVEsTB16nigVR+qTadMXJU
	bJEfVmgAUjt7+WYfMihQSY+vHNMctpABIKgOxp4NnDIGyoF56xVkwhJVAjyG/uzLHT6voJ+Qaf3H5
	lIdUaOqZ/uHQWZ/IN82FP7bXj0NTp7Wy7YqGY7l7PL1GX6nnLUvA7HiCKW/XglQkZHSiFETYU2kpO
	3htx5mRip4ROKGZbaQ3gjYacFx9Y+Ev+0oz9WFCFBPPL1+oc1gxtA0k7abaFmOb0JAWTSMO6OZ6lU
	k6xdye3QeHodfeNUXv9HCGRpmk5Pl700nctUk3wCIMa6v6cTBTxTncxg1fvtQNvKHTYmSFF+NC8m4
	zEFgHAig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKj6v-000000020r3-033C;
	Wed, 06 May 2026 20:44:49 +0000
Received: from mail-northeuropeazlp170120005.outbound.protection.outlook.com ([2a01:111:f403:c200::5] helo=DUZPR83CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKj6t-000000020oY-1kTn;
	Wed, 06 May 2026 20:44:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWo+ghL/9k5Vgg4M09kfP6FhiWvHpoB4w6e/oVkYhedvw5HAl1ZLEKMzp9IPldfqo88W307kIBU8Q/B85j2wPQKhxyInL1eY8CONote4VAZ8lSlS++U+evNvbJobjD0k/iuLussVhWUpv6rRM8l/qm6nv0JKEWUIWNCDACCYFelgdsQMRxDUR7aqBcjGZteqbpnPz6VJXQ/nqEYxGKbfQgiaOMaUXI2Cte/4AgZVkHAy966V2vVRnG8en6Bi8wG6dwGS6JsI4QAWZ9FHGdJ8PC/cGKJ8qQcrEdCqsTKtKLqMis2XCzhI6RHEApcUEGEBNHQRd90S2ZVqD48ItwGx3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8QTXNED7ZIuZSaGEpmFtKE9Ea58WrXFvajE8xQTBvM=;
 b=EVntTRqp9m+H+ScynZoHfPqL1bsI5D012lIyDYLS32puu4E59zii1pV1jyFfPg5zJu+OPk+IzfrLqSTiZM+ZRUw8fZRXnmYQCnA+Xi8IDVzKyrPbqS7aHEY+lUkb7gBltEzrRSf+b1fk7v751X2LFyoGOyF4HCoOQSXk8ZEaMm7MeVH5z+m2LUuq+R7QfAlxVZwQPdz6aWrxwdRYxzUDrf+pzwtTbRQIp4u4QVms3bzgvusTD/37SvONhjhM/OJW0S5NQzKxSwEkoZAvFdGklRUpzNikfZpwZuhZDxS0kXOLYgsUDtecdcPzK11GcVT+ZHEZBEZ3ieBwsCERQjUXOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8QTXNED7ZIuZSaGEpmFtKE9Ea58WrXFvajE8xQTBvM=;
 b=h1jn3S1BSacugPug/u7NThQqDKEJ6qR/m7yZqVhwpBf1v92AOUM0AUe9VK3mmKO8Ww8dzMbrqBUV5z+wEU/xc3is9i/SRqIHZulpWRnI5AiKviBt/YmfZ/ouXpv3s9wXd1MtiaenGOOOloF0k2RTQqckoexSw/CZ5u9BQsGCg5c3PMRkaV5pyrW51A0R/qYge5awnWzNuohfdzljIUoHeoEauAlhwCL4toyyg/lzzaeYJPuQSy33nyeKqYqFEuPeL5q/yBEFzlq3YK5iJap1fZaiV0jgK20K1BW10tBlFpjnCSkCRBBw8tTvLZIPE/pDnlnwyY24cCWWmqaagVyZog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by GV1PR04MB10479.eurprd04.prod.outlook.com (2603:10a6:150:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 20:44:41 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 20:44:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 06 May 2026 16:44:15 -0400
Subject: [PATCH v4 3/9] PCI: endpoint: pci-epf-test: Use
 dmaenigne_prep_config_single() to simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-dma_prep_config-v4-3-85b3d22babff@nxp.com>
References: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
In-Reply-To: <20260506-dma_prep_config-v4-0-85b3d22babff@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Koichiro Den <den@valinux.co.jp>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, 
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Damien Le Moal <dlemoal@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778100264; l=1293;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=5Ht3OpV64qQBJF72UE+o9BDFv/FIRBIdPMczb03BKkU=;
 b=+gyRCk2F2wDoHpaQqe7/bP02FVQZ3YlTJjqGMMQO8UIfMxP7fQkdJK8BmkYkQMRH+fVNE3fME
 5vf9NoxHwYpAlAoy6UCjH8crUY1HgCBwvgIECeUhJPKcirqQ3irp7yY
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0051.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::24) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|GV1PR04MB10479:EE_
X-MS-Office365-Filtering-Correlation-Id: 17259e45-42fd-4a50-de52-08deabb04c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|7416014|22082099003|921020|18002099003|38350700014|56012099003;
X-Microsoft-Antispam-Message-Info: bAKJL5w3hb4zgbGg/UPX1sZVuIRXTSmEvT20MIP+GktDJldfdOi1k+Tv1HY+N4OVDnyUmrJvLw1aYr4HuV2rJFuuHUbeqwQJRtyrtySy2XICX06HNGPRB6jGVXcb+TOq/wFRwk2HV9XsnnudVQVeNIAwtwdoFP20JGYVGxF8IN1RxN3+wc/Wms21EwTuoi4Zv4sJhuRi5W8emo5QGBniPTsZa6lX9lBkjil1ek7mUYEnF4kgAGub3ayQtweuTidXeSCim/GAYHcHF1/s2wdM4MnA69Q5DAPFTR2/IHrJ0j1hT8GhsVfYVh0BrEH1ogfXzXoqI7rgCk2K//hb8Kod5IJLH13y6v0qW+DdFf5oErss77R/zCAuF2co3A+e3qzZCeHQUCEMEhzKV51x+t3u73dhvKKJ6pjijDRsBg7YRs4NmgYR6dwMXGh5cB6qWWqv6w0faBJDZz6ZAr1fnDou7BPj0lD1gNmb862fL+Ti9bPzLFhJxJe7IIrQYZ776wecFdaMwU3i28HP2eXCMBIV7lHCSQFs9U+tLnym2gf1+popzd6+O0W/G5x6hBvm4+/03LMCCDCwQx+l968jwCfaK6TbzDp9xD903hiodthLfdfX3h/pQoegud9xHhOgD9Pkv0RgyiEThekjwjfhA3cQsmf8lO95qfZ7QqCZDYEYhYBXbqvtYOVUUfl/TkUTBoqvbSnTyFpuWhLKDtEeOeoRJWkocyYJHSkVqfp03F9hwfq/Hc/S8egnP4pSoIZ4aSfA539VarWzx9lxAVaRg4q45Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(7416014)(22082099003)(921020)(18002099003)(38350700014)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVpuOEhJV3pCUXNaYk5rM0s5UndVaE5rWi91a1QvRG9DUVU1QWZDOEYyZ3hy?=
 =?utf-8?B?RU5MRjhGeHF1cHl1a00zcWU0LzVsUVdPaGtzRVBaNlM0b1MxdVFKb1graW1V?=
 =?utf-8?B?TlVOUHc4cHprUmZDSUJOajJMOVFTTkV6ZEQ3dWFSL1plWStBTXFrdDdnRHh0?=
 =?utf-8?B?T1pMQXVUQURtUXJSVzhjSXhxY1J1VjNCRlJPSUFySENzaW1ZMCtmUm1qWndj?=
 =?utf-8?B?cEM4L0tpRkltWmtIN3JzcHVDcWhleTAwZjZJSDdSa1dwTktIejZhV1ZYdExY?=
 =?utf-8?B?MEtCRjFLanNQdjVWZ1N3YWxjR1pVek1zWHkxSWdNWUI1eXdmQzUzOGVzM0J3?=
 =?utf-8?B?QkE3MXlBZFIrMUk2UVlhVkU4MmpJVEVYQXB6VWZRa2YzVXdaRE5JemZGTUVN?=
 =?utf-8?B?VEY5aGQ4YW9RVlAzaERDK2NZN2lHU1BKR1Ixb0JMZkFBa1A4ZURiMW0zbFlZ?=
 =?utf-8?B?OHU1VVRSMWk0eEcvdlNjdjd5MW1mSXhCWWQ3RVVxdzgwUUJwcVJWSkhoNjZH?=
 =?utf-8?B?czZyZ3RTTHhKSzk5OXRENHhLRTBmT09PdDJMK3RocjEvYzR4dzRBREswQnFo?=
 =?utf-8?B?ME1RYnVaaGpoN2ZUQ3krNEdqTzQ2MUpVZFJXTjhtK0dRQ2M1WVhSbnF2dDVF?=
 =?utf-8?B?K0ZuN255VWcvOXNaeEpualRrT0Q1UDhtUm50NVpvSVhCdldLVjEwSld0U2Jj?=
 =?utf-8?B?L1BlQzBJVVRIbmR6bzJ0QVZyS0J0N05TT3RBdENPbjVHbEM2Q0RLbWtkQ2RE?=
 =?utf-8?B?dUtoWC9iY2g4dGkxZG1WYXpUWS9wY1dWRnJvNzdsWWFFNE5FeUV1cUFOdFFk?=
 =?utf-8?B?MHVGdk10b0NOamZTL3Jnb1I5NGkreTRJalNDOVgzQXlrTTJ0SDg3cnlqbEpl?=
 =?utf-8?B?b01QWTErT1hFSXp0dndGVmozZWYyZE9FZ2piY2ZLOFRCOElpeFk4YzQwNTNU?=
 =?utf-8?B?U3J1Nnl6MDBVTVQxZE81S21JcWNKakgvTyttMEpMeW0rSDNkYVVETG1oSjdw?=
 =?utf-8?B?bENialhGKzJtMVA2V05hYzczWlFVTGF4UnJwUWFMc2JCZzUxdDAyRE5ua1Nn?=
 =?utf-8?B?NmlzTTFGVk5pNUlldXZzRld0cWtTcFJTdXJWaHZ1THFSQS90b0N4aHk0bmc2?=
 =?utf-8?B?WDE2aUVtWGtaTTJqdlJJMGVjVXRwSW1CZmVDQWtITlc5OWtkVUFzTE5XL1ZB?=
 =?utf-8?B?V3V1UDlEMU9iVjRscjRtRjBIeUZGUTdaTWl2UzYvRHpianVmUVY3T0Z1cThW?=
 =?utf-8?B?K2VseFpNcHBKNXR4RFM5cGtnQVRnWm81encwWkZWMnEzS3gyRTNubVljb3pV?=
 =?utf-8?B?b1h6aU9BU2hLaVZnaWVKL0xSZStXUmNUQlI0RFZvOVRib0ZHTW9WMWZIazdj?=
 =?utf-8?B?dmV4RzNxZUVac2ZyS3ZBSHM2dmRhVHlkeXF2bHBxZXk1LzdDNTR0bnZEMVBV?=
 =?utf-8?B?dmJkam9VbVFQS0p5b2FDQzcxQWlmVnhtSjFsSm4vUXplaGxCdGJQcDNzMGZ4?=
 =?utf-8?B?Z3Q1d0F1N2hVd28xdGRZZU9qMWU2TEtuR2tPQloySDRDUTNyTFhYUGMxcUNS?=
 =?utf-8?B?WE1zYno2MWc2YnNORUNYbDdMdWVjZHRRU2hSbDRFUXlOSkZYYzVPckpESjFE?=
 =?utf-8?B?dGhWUUc3UFk2R0prNWpjUXYyN2xENU9qcEJqQmQraUF2M0djZFZuNWZ6YVU0?=
 =?utf-8?B?R1pSTEpQeXFWSytBRjdlRTZ5eUZBbjBiNTluQ0daYkVTeW1pNGxiL1c5WHY2?=
 =?utf-8?B?a2pxWW80VjB5YVNOOGt6dXJYTFlzMmhYQXdtOEw3V1k5VEZHbzZhdkxxb2hJ?=
 =?utf-8?B?NHAwZXpjRzYrZnYxTDBaYy9VOVJpVWFibXVpUjhocWQ0c2RDYXhSV1FESUFs?=
 =?utf-8?B?T0NWTlM0RE1XRlNpdHBrcEtsbGNsTy8wWVFpT2ppNFVqZUJjWWlWWmpNdWM5?=
 =?utf-8?B?UjAwQlBMaDFvYkNzSjIwejBsSG02cjdmcG9HVmJWNWwydGhDN0FqZlc0dCs3?=
 =?utf-8?B?SXBpNVZjcGIxQWFId3BQVFJ0ZFdmb1p2akd6amYrUmtLNEVWM3JkRWxXU2ll?=
 =?utf-8?B?WW5yMFBYNHZhNXNpVGpSM2lJQ0NWbjlGcFhlSFIwRHBkYUdkcU9QTHZxU1Jt?=
 =?utf-8?B?MmQ0eTdrUmlZMEtIMk1tSnlXUmk2OUdEUE5qU0hGNDB1bkJIVXV4NnRHME10?=
 =?utf-8?B?QlBNMk9JTG9Fc2dJa2FLZ1pKQ3dHdUx3V29UQUo5SVVYZHhsZFg0VjllMlhR?=
 =?utf-8?B?QStYUCtMTHJNeVRkQ2ZMQ1d6TDFGZUZJUFA0bGkwYnJkbEQyR0FDR05mTkk3?=
 =?utf-8?B?TklIa2hMQ0RlZmxOZ0ZJMXFGNUYyN1BOMU85MG5pd1NlRFppWnhkdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17259e45-42fd-4a50-de52-08deabb04c14
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 20:44:41.4021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1U0VTTU8jZ1DuGSyyTlC2/AgsvDs9egKwYhKF0RazeZiy59hl6qStBiiPVrWZBgwEas2Ccb1eXOF5YpuZ85Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10479
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_134447_466892_C5F365FC 
X-CRM114-Status: GOOD (  11.59  )
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

Use dmaenigne_prep_config_single() to simplify code.

No functional change.

Tested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v3
- add Damien Le Moal review tag
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 591d301fa89d89addf5df16e775e80460b689589..0f5cf2d7951088af3801ea1cc240b2ea8627eed5 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -182,12 +182,8 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 		else
 			sconf.src_addr = dma_remote;
 
-		if (dmaengine_slave_config(chan, &sconf)) {
-			dev_err(dev, "DMA slave config fail\n");
-			return -EIO;
-		}
-		tx = dmaengine_prep_slave_single(chan, dma_local, len, dir,
-						 flags);
+		tx = dmaengine_prep_config_single(chan, dma_local, len,
+						  dir, flags, &sconf);
 	} else {
 		tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len,
 					       flags);

-- 
2.43.0


