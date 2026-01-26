Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4561D13C0D
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jan 2026 13:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mN4p0WM/s2J5YM2vtSaLM/NMU44BFPqX7lk+j2RZve0=; b=BL6u12Qeqdr/D/WlXQ9RB/tdrf
	x5/iLGlzvwxKqc5B6Nhe40WlZhgP3bP13sYhhINRxHDAUC9esZw8GoUI7EkAY5pHL4VRrwOWEesO/
	9k2PXeaNUU5gcgG/br94yawXmsRjKBp7prXDNi8YtqrAKbKPdElu50rGl1G/GrxhztR0/t5SUahNm
	XjIf7FtUENgHjELGylEy7eJBLVx0SOOfb4qetgbP60PXiCoC4eoT/h2AJkqkGvKunylYesyfnG2/u
	6pzhnommlHz6H81A5bkDf16mcefhu9W5J9QLccNgS0X8+SmuIn/CX5D6VmzcrPvZcARhmIF/yTWsv
	X2qR1lUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkMeU-0000000CcYI-3Mw2;
	Mon, 26 Jan 2026 13:29:10 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkMeQ-0000000CcXp-2LIT
	for linux-nvme@lists.infradead.org;
	Mon, 26 Jan 2026 13:29:09 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q3gKRK142226;
	Mon, 26 Jan 2026 13:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=mN4p0WM/s2J5YM2v
	tSaLM/NMU44BFPqX7lk+j2RZve0=; b=qlT2+hc44GMu7iMkIHfFmQUlgc0KobC/
	tXIyW4MTrlUgceDNV/8MmZsbk7GeyCWMtQOdQ7MlOgm1STjC53BEXEsWNFaCZ0vE
	TqD6xa59VtlgFdKFdNXp2/sUmAMfnCmoRbdPaFR3PSmB0kqOudFJVC9DpK7D3uvd
	BKJrX8F4oiwsDXrXHU2NOtQ/1QhwnNW5c9ux/Z6w6TBCBJgw63p1VohRgKH1+clQ
	aKJgRhiQquDcM+Uy/1tEiodd0j4zs/tE1W8TJ2ffItB7jA09S20T/gX/BRLW5/jA
	8gSi78o6xGuVxGNc9ZtxGmMFtgwyeOCcvgf/ptUui2iWLcNLZA5EaQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvpmr9sf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 13:28:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60QDHiob010430;
	Mon, 26 Jan 2026 13:28:52 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmh7y02u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 13:28:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjKGekSOGaxqZRIT6WaGfoQnzhI1d04ysteBYGb39ED3T+OnBMp82dTfdJYYGBj6aQqRcIJ13MhsDSthtT6N6nVrmGnJ9KQYhdDTuwdvNerGZwt9vupMGlcBv4O1AaDUY0GaYurE+9UEsi6hUykvPfRFrcM2ZqNqAT6+c2s3B0TKZi/A4KCZoOLFaFmVumaleaMVEDP5LyzAQRYSIx9VZUf4M4pZGQxGAANHp/C3UEtC8JlikhSSd4FLBDfAlg2qU0sHJCjzzVuDrNQ6+elw+RHXjePRDw1EPfnkyU93rkI1v3TK1Jm652jiOvfnZ5CEsu7YcSIJexotRcVP6NbDAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mN4p0WM/s2J5YM2vtSaLM/NMU44BFPqX7lk+j2RZve0=;
 b=oi69ee3z9C+mxDmmx/ZYp9R7XQrvHSTmZGhPPcQ89XPZ8+TujFO+txhUjGVEBDITfuhZu5YLIhC9A864kOX2Mo3TP9loC/Yzgvc7xQd7LP2NO9WB/ep/MGmgGTZU1oa0xFKlfgvFknJ4qmT/cAxXfFPGhsitDy42JbBI6RMc+2ehhwr2NA2KXeY3bx4dXd4fPgpQL8N8/t4p4kYnVubNpczoQtt7DI3gugc9frSKTAss9qFc/g2hrUyGvkO7QnVuiE0yRdSVACSMhqxa/6+Kz5pxkHw9iTRq+szcsacYNQlk/zc5t/+emUyO4xwWtC+yAVmOfD2TO56NDfaPlOk+2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mN4p0WM/s2J5YM2vtSaLM/NMU44BFPqX7lk+j2RZve0=;
 b=IXjruaUPJ++LVaA4KCwP3B1amCRGe6NJlGYkrdPpfJo3CRKAOh5/vKTpg5KoyW5WNvHmuLDsgDMQkqtGqBs2ONEOnnzlkZP9aFsiwmei7cgRIgsweqWnYFhY1vU554BJ6c/A7RuObNwDFS6mT9a4ZrRLz5MxFNUQYEuopjLudKM=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by SA1PR10MB997559.namprd10.prod.outlook.com
 (2603:10b6:806:4b8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Mon, 26 Jan
 2026 13:28:50 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%5]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 13:28:49 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc: martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        nilay@linux.ibm.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH] nvme: stop using AWUPF
Date: Mon, 26 Jan 2026 13:28:42 +0000
Message-ID: <20260126132842.3332090-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0112.namprd07.prod.outlook.com
 (2603:10b6:510:4::27) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|SA1PR10MB997559:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e51d5a3-85e3-457e-bf0d-08de5cded712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AgDkWfLiU3dJv4ow5j+D4WlcrztMCHAn5+TJCEd7oBf4LCfpB4Y3cD6qwAOx?=
 =?us-ascii?Q?43H72lDQYkFuBMd7dgxMTKk8XrNBy2JhJeDh3XQPC9zxtihFp8/uSzNWDuY2?=
 =?us-ascii?Q?DsBIueZJa5uoeDGeEIFPRPqLUsoRt5C32/TYmgJBQlFL7OpzQRIMVDLaTq+3?=
 =?us-ascii?Q?3U5LiiAJvIvfECxHaMZiEylrc3b8GCwbr1/P3YxI1gkBDekZENaXdxi3ROgr?=
 =?us-ascii?Q?h0D0w9kCS6v5eaqORAB5V//OPwItHFLADBGoSTTosGTcl/uh/D+A7agBGpMb?=
 =?us-ascii?Q?iAXXLRlk4JbCxWqjmNYoTRAmIzZPHlXQb1wD6XH8CmxEGclNTkScPgqzR8xq?=
 =?us-ascii?Q?UMqdlQF7B1+fsR+4UhzGyYz9Ene3YFwcIpP829gebK2Vn2nDVokwD21Zl5B8?=
 =?us-ascii?Q?YGuc5ARxAieHO5oweeiUg9YUuErisWaogjsJtCppZlIKOcn7k+XBFppcXD6i?=
 =?us-ascii?Q?EO12uVYX3d/i/itx8/TttQS0A96kUq7RzehC4LPPoLFFGZZFmuirAGVq0xOh?=
 =?us-ascii?Q?k+4H9GTyT0tHQIy2QHHKFPTCXn1iaGiHZ/KzS91DUB/2O2FI6WbA7YgsSICK?=
 =?us-ascii?Q?GBFKmKm923aHhv3oqGwvo2bzQ0XXcNpUKiZqthxsoNrrwIT/veWrl6TdDCH2?=
 =?us-ascii?Q?TkeAa/rca5QPRml6RV/trA/x1k08yC7FVvq4CSeKYSzZCP52dLHF1Y9q3xS1?=
 =?us-ascii?Q?GfSxuh6BKw6YFWV/pddDuCcfV+UIzPLsxNfhf963fQSbHLubVPcFLUedqEXk?=
 =?us-ascii?Q?2AVAYCUMApP9GHYfT3rbarD9rWpjlUBwdlcSeeOVJ8FhRexY3Qwl2BQM9ZDT?=
 =?us-ascii?Q?M0spD23boIk69UWwM8ssKDf7JFp7KlZ4SSRuqrKW6Mh8SaBEXANK9+AIFG2h?=
 =?us-ascii?Q?dPr7/xlM87hG42GzQMFCKZ8wBUi2jubd4NQyfEEBPFKFxexztpiUYOTreoz9?=
 =?us-ascii?Q?slyazYRmqf8Ax754bp0iFcOzoV3BysDZb6sLCUcgh6zUCQK3gTtps6GTYCHd?=
 =?us-ascii?Q?YXyUYyOt/J88kQEGt/ma0U9sUMsBWJH6AJ0K82w0akjcK1clZmvQYexIHM06?=
 =?us-ascii?Q?/Q9/DOcuOpFqlISB+3nQNWrCIFQl+i2oJ+LnO5m0TPW2D4YVCTvd626xqfj3?=
 =?us-ascii?Q?Jvv9EQEge7Wy0wAtCvj5ugKS8x2bJa5lvUIN1O9qkwgsp/NbWmOGkXkVrCOe?=
 =?us-ascii?Q?AahvHhhYJg0pAPHoG3jWPEVjWFxjnh1X+HlddH74CE1JnrLKMsas8v1IYX+z?=
 =?us-ascii?Q?wzDZI0VlbDAyMqqMbx2pB1TPyT+ynCoRAj9RbWI9FXhJ3eApqEXbn+NpfJxc?=
 =?us-ascii?Q?URZLQbCVTivrgOR3bsM/W/mAFfUzgi3F5e4JoNUFy8dQ61+bDXdmGP3Mg/uz?=
 =?us-ascii?Q?qCo444S+GxkDIUVSB6nxVJ0kColjXuGLHv27RfB6QWSWBtq8ibbO8SG4GWQg?=
 =?us-ascii?Q?8g9aUEXttAk/0QrVtyINaiCU+ZDGVi8RpaXKbDCPQ1RUfN27nQQXamsxgLWX?=
 =?us-ascii?Q?yNxOT0hdUfqCcka8IywZp2aZIHdOu6zulpOOuiOzp1+9Dk3REyooFNm8ax4j?=
 =?us-ascii?Q?S5fo3rPPW7erxeTPjMQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qLx91/GVVf4hnEoniaJh7UTIxAYqG+J1woYfuWnfr591oR3U8oeYschKacQW?=
 =?us-ascii?Q?T3WwoXcoF85i8/nagl2tcCmMsMrJkJG33i++/ntMZ09VVOT/5exFzpEiAdJi?=
 =?us-ascii?Q?iMH/8clio+i6wxQbyBiHr63XiNhKp4UCbvo+vdi2Y/pjA3Y0wdHJ2r10pstx?=
 =?us-ascii?Q?D/DLwu9xradNmWKHdwGsiSGcpc0HcI/FDuiLk3daoQn27XX7fASo3wm0pNem?=
 =?us-ascii?Q?J/lCNEhumbeLRC0zRvMdQSs0lygKeSoSe8CPqJq0sYxZmhuwQxrT1MpIxAAh?=
 =?us-ascii?Q?PAAMpvP9Spvgiigbd6J+uEjpoFMKvWUcHkN29sR/QrzhZ+po7PNvqvasjBGj?=
 =?us-ascii?Q?bezWAOAqm/akwMo0f+PdathRACV9kARXkZ0IwS5v2k4+BC3xteTfwdgCPsHn?=
 =?us-ascii?Q?qRJLz4l1lOFw/qJXKXrom0KXnD8+TlQEUfd0VpVv0dJ0IZ9OtRPk2tMtQs3S?=
 =?us-ascii?Q?VMcx8z8vMfFpZGNevhz95opDskUvYtRfqy22rc6lvUPwieOLBzz0kqH5L3G+?=
 =?us-ascii?Q?LY8oYRI3rhNfYa61ey2fcNFgfZukKus4OdKRST/dqq97q+WJOilsaQwNbbms?=
 =?us-ascii?Q?haMPAN/ZMWmdFvz/JbTcsFdgjg2gsruTf2eGohnUJiCcwmOp4T04oisLb+26?=
 =?us-ascii?Q?m9T6E9UW6IXjc4djuJXRQ35RMxYZGaGh5F2LIn+Gw1+MYntJWPU0n69er8XI?=
 =?us-ascii?Q?NjxDIb4u5ijKEDuTicSAArv1FRzsQmqWUAN1TdlvmLXtwiDsE0HZJ7NghA/j?=
 =?us-ascii?Q?G6XyIC3uSl38LucxC1f/yJrI0unte4pg/LLfjT/bpSctNG4KgmnuJultxUgk?=
 =?us-ascii?Q?4bh6ezt8u2RhEPoOoFPllagpKzISpQgiuKI86HaEu+CdQn20XXbrHrmQlu0z?=
 =?us-ascii?Q?sRHExCorZ+JjzxL8n4zjBsRT6Jw/cP2JlIJNXV2PXPGFIBEMjuLfOMtepmRH?=
 =?us-ascii?Q?7SOJFAhS6lDRgIOUIiF+BgBIC4kPz1iCI1fSNQSbnavoCkH4pPgKPdvGSU+r?=
 =?us-ascii?Q?fCHNNRLYDk8VzHU75tkVXnSB34/DzblQrpFq/bON1T2EXdQPpJ24+zCEDHCC?=
 =?us-ascii?Q?oo10eR3dYgMSb3HWB7CrFxEZXOmSaUIIm02FC/5/fqqmnWEM4V4b5MXia1x5?=
 =?us-ascii?Q?/LtOYfeKwiWKtpRlnMfiwhl9dSbCvC+vLiHt+l5T5EfH2afuqb+s3HubrySc?=
 =?us-ascii?Q?IpCvvALib4x1vB0BE+Yg9oyrZdWcx0SJ8u8Kzca2SZAEWlb5aNNP04CT7KlL?=
 =?us-ascii?Q?orBkh69TlFH+ysZkLDWcwjyHMby3kDddFcb54f7XU2/F3mehSIrVAbbf86Lv?=
 =?us-ascii?Q?CjE8YrMss+03c+YKqdykV4hWQD6SlldBM1iAKcQ+/AoDlyrPVXnvE6/UZkMb?=
 =?us-ascii?Q?DU0qujI+GIiJIP9RH/4pey3lozzlJSLYRfZnkbht9unMBiEyz+rCGY8VOw4u?=
 =?us-ascii?Q?GfJEnfJ2EtVJ1Q8sw62my68TJx1SpvOV1iU9Rc+DBNMDvrx7SHBO2mPL9iYo?=
 =?us-ascii?Q?2X8ocrn8JA4fUdPfBdjZWbJmrP7p++cppyXzX8V5H439TeK1HwGf14PfgO3f?=
 =?us-ascii?Q?DyCJm7xV0ew3DpjlwGe89Xl5uo7EQXVdHTk2IWxNZFV0Bn78bF4/IycSgoH9?=
 =?us-ascii?Q?MD86/ckufU6KhnPSMosERJ02f48gAUcNdjpF2AeaEh0GHRnc1U7UZdl+OFna?=
 =?us-ascii?Q?/1MsbXvoQ4FNfXKsyIu9xmHN+RM06gFXEqFWau/eqa3X0klr6pkYcrrR1CIX?=
 =?us-ascii?Q?DLr5hAVh4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FrsSIP/D3OU33tZJqfBGF7/t5su/r3ELffUxi1FFvEoVeC2Y86oyBSGdIU/jdVPdZkXK3triIxp9x3oeuTydQK2KroA/pdzwoNS5dWUYa//GNSmW6c4CD4Kphwz2KOeM897sWN/Z9VZRNw43AYyPKHrSs14/EogkF0upLyr6vwGNx+9+VCrQp6J0DPwtUJCpOaW9oDFKb8Mzxk76g5PNtedydIk4bF6sg2O81c80S3mnhiq3Ua68Jb7oUxfn78KR14mHeV9cXCuCCbxnE60viflYvfTuEu3eE5N1WvREdMu2p2MCx+jo7ZWJBWOL5vO89ulKCsBDPJ3u0V2lpI+W5HIy+AHTC1OkwcsjBLO9WRCrpEjcjhwMcasYNuBYLBpElrHzvnFzRR4R2IeukOTCk/5Y7aPoL0oTEKBU2r/V2cJTvQZvSmVN+SCwGVH9jBANhMFZRhWkO3FVeHOs3Dg0beO8LOMp3oLc0njSnGaIj+pa/eme8rw/NRb30m9C/eHwEW5r/CUqjKO9CbeYrykaz/8XLyNxUbqi04UCV3LAfpFBxqgQTTUm8PtURMMgVnuNjO4qSPsXx6+y94ZyeqD/OIlu2qA1d2q14tTuymJbUdA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e51d5a3-85e3-457e-bf0d-08de5cded712
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 13:28:49.5813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPcvx1cOpkY1x3qMHQWpzSOaPGhSqdokKRqSTG0Fpn084xsaCJSd/wkWpW+syoSISY5pIS6l6XqBNsKGaeRAaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997559
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_03,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601260114
X-Authority-Analysis: v=2.4 cv=Q//fIo2a c=1 sm=1 tr=0 ts=69776c15 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=Befpult7LnrRVZ3Z3jcA:9
X-Proofpoint-ORIG-GUID: CzklIbMO4zSl6aCzquVYoqJzMbdHNDKF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDExNCBTYWx0ZWRfX0MMEV6aY09Ih
 nfDdLC551IeqSw8LOaJAZAurg8r/oPhMT08flMVd/qPWAUuAlUACzDUXNFD2FbOuENIvJvCb6BE
 7z26+UQ5Vx3VQvPkVDv5KTeJAMgLSIsKhsWzBrB4pA65NMCPSSf6PRP6+b0DqCzJQxmgbM8QzaY
 jKkwtQkkzkjc8451acv5t4uPvfJwo/HcAHle9dQI/A/D0E+FHjnU3dzo24HvyzMGbcKqEQc+w2v
 sn866frG3lsbcQiQxbOTZ29SL2lp/ymAFC7IbuT9cP+fzxBxThfh8JFCtA3AP3buEIa0G5m3ThJ
 ns5d63KSgXvXbjqMN1gDzAeQx3AapYw8mOpk1g+aaOt8rgQy6teWLPxK1f+MgFAMK38F0B3soa7
 YjCgAM39YgHElfoawmkCyxwT522dWURkHhVIBnsuaSh0ijcRMrwL1W6AfGwb4Y+CxSGbhV9MMGb
 aijLvBnldJB07Oikttg==
X-Proofpoint-GUID: CzklIbMO4zSl6aCzquVYoqJzMbdHNDKF
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_052906_974304_547C6A7F 
X-CRM114-Status: GOOD (  17.91  )
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

As described at [0], much of the atomic write parts of the specification
is broken.

For now, there is nothing which we can do in software about the lack of
a dedicated NVMe write atomic command.

As for reading the atomic write limits, it is felt that the per-namespace
values are mostly properly specified and it is assumed that they are
properly implemented.

The specification of NAWUPF is quite clear. However the specification of
NABSPF is less clear. The lack of clarity in NABSPF comes from deciding
whether NABSPF applies when NSABP is 0 - it is assumed that NSABPF does
not apply when NSABP is 0.

As for the per-controller AWUPF, how this value applies to shared
namespaces is missing in the specification. Furthermore, the value is in
terms of logical blocks, which is an NS entity.

Since AWUPF is so poorly defined, stop using it already together.
Hopefully this will force vendors to implement NAWUPF support always.

Note that AWUPF not only effects atomic write support, but also the
physical block size reported for the device.

[0] https://lore.kernel.org/linux-nvme/20250707141834.GA30198@lst.de/

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7bf228df6001f..82446b9d30941 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2045,14 +2045,7 @@ static u32 nvme_configure_atomic_write(struct nvme_ns *ns,
 		if (id->nabspf)
 			boundary = (le16_to_cpu(id->nabspf) + 1) * bs;
 	} else {
-		/*
-		 * Use the controller wide atomic write unit.  This sucks
-		 * because the limit is defined in terms of logical blocks while
-		 * namespaces can have different formats, and because there is
-		 * no clear language in the specification prohibiting different
-		 * values for different controllers in the subsystem.
-		 */
-		atomic_bs = (1 + ns->ctrl->subsys->awupf) * bs;
+		atomic_bs = bs;
 	}
 
 	lim->atomic_write_hw_max = atomic_bs;
@@ -3221,7 +3214,6 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	memcpy(subsys->model, id->mn, sizeof(subsys->model));
 	subsys->vendor_id = le16_to_cpu(id->vid);
 	subsys->cmic = id->cmic;
-	subsys->awupf = le16_to_cpu(id->awupf);
 
 	/* Versions prior to 1.4 don't necessarily report a valid type */
 	if (id->cntrltype == NVME_CTRL_DISC ||
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9a5f28c5103c5..d5e3b67d39cbd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -442,7 +442,6 @@ struct nvme_subsystem {
 	u8			cmic;
 	enum nvme_subsys_type	subtype;
 	u16			vendor_id;
-	u16			awupf; /* 0's based value. */
 	struct ida		ns_ida;
 #ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_iopolicy	iopolicy;
-- 
2.43.5


