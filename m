Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E310C25B76
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 06:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aH20jbNOmN07YNyZ4sxTXgGz26CzhSHDXBRGbZ9/rkM=; b=Yrg+qseumOMl/l3YWuyxt1GWZs
	KrvZLym/PUlJD5FbLhBSQ4V8CQuyNjc+6HbhXRjpTMcX4y5hmQmR04TG29VOX6FTJ/8359l8UQwUc
	Qsf1y/m6cjVLoc9IJE6SIeF8+MAWIR+D0/fY9Esb/OkSuFLgiODyP7Qsr6CvTP7QCVOzPoLGxKyaY
	mT2ejMTXix9TKMFpJqiSMsa66TRulGMpj4shoPoWb2n5e/Yiyz3FKLmB2PxJv/BhagfjrIA0APc3o
	uO3olO1RBuNk0QCxiWiLGtHqM5t8//gvSARIEwVZvGEYVbgOoc+wuo8cvV4C17LOq7Lw1kHA5Q43W
	rnn81BUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGv7k-00000007j5g-2gHv;
	Tue, 11 Jun 2024 06:36:52 +0000
Received: from mail-am0eur02on20716.outbound.protection.outlook.com ([2a01:111:f403:2606::716] helo=EUR02-AM0-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGv7h-00000007izI-3CsW
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 06:36:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyvgAC8Lwm6tD6/LS6+wpXZyMeHr9D1+S7MJRAyAmnJOU4M4bZymZduWCEUbOYyV+sCq8ZPG/2gWZERkXpamTek2EUfwxX0y2afydp3RQ1R3aLsUhdlrc5IdGU4mRoACF5m5ERJxu7BDquibz3M7kJ4YizqF8qf2KN48tAi8TxTECRwPo26YbCif4v56B8jaI8TxeLo3Cuk8N0B91DujAyjUF1kEm9CSUBJIWwh6RRzObXOUBoSNc1bDfJJmAzlfnha+iWX4VZm2bPDezQSmS8Ad7Zqye2SEqgbwYM/7otYEdEG80ylUjthfB5Bah/Lwpcrl6EwqU5yd03wDSydGtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aH20jbNOmN07YNyZ4sxTXgGz26CzhSHDXBRGbZ9/rkM=;
 b=TogY/xXc/aW/D4PEiJJ87sKYjBhG8PXyyHdxNINoux1rWTYQUGrNylMcD6T8J4hDdZsKUmUrRceew34fen04HsTnFf9Kl6Hr3HAg7rYEpvJwlrKO/oUt/exysBHh12j8Ki7ehuI6nAOj4SV2wGXsIJ7bWosCnRRHBzLtRl81otbZWSpCRNnZs42ovb8FyNPr4WSje+hziGpZ+FWMEQkIPMdRP+Qbt8iWl6xCe9tPmOIOoRtwmlhZPGhpvpkOPOhXGEGqXcn1UQlRl47qanaVTaWbljSS7DlViJ5aj1GhXErdzQecJbVaVsEK5w1T7bxzNrpNcanRF3eVdtU5qkmSZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aH20jbNOmN07YNyZ4sxTXgGz26CzhSHDXBRGbZ9/rkM=;
 b=ocTSdSBPGqo/BkTX8l6U4LvraIVezH7AdDfxjb9Zr3oV0V9BbmEPybPW3IEJarh4z8FRT8MtNCnjxGUsiajhxYZCxyv8wwPz4PxaiOgAGV66UskpOviHVf5ca7Ro2tUkZT6L/IpvY/vY2K9+W5momgRLg16FwkP1juD9Wcx795v3ey9r0a0V0ubEugZ00GyunugAZNEePM0Uy7R3xRq+gcSw1PYbkL1tyHXzWiyYyv9GGwyUbKTEncyn0ayeH3S7c5NToVgrNPPfqgKcxR8YR18b6gqcQ7wcFjTQZNqBMvL0edd/SMVkXUQOK6+60Uyr4r1Dl8xd83iTfPl6KJtAoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AM6PR04MB5110.eurprd04.prod.outlook.com (2603:10a6:20b:8::21)
 by VI1PR04MB9977.eurprd04.prod.outlook.com (2603:10a6:800:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 06:36:31 +0000
Received: from AM6PR04MB5110.eurprd04.prod.outlook.com
 ([fe80::4077:a101:3fd3:3371]) by AM6PR04MB5110.eurprd04.prod.outlook.com
 ([fe80::4077:a101:3fd3:3371%6]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 06:36:31 +0000
From: Ofir Gal <ofir.gal@volumez.com>
To: davem@davemloft.net,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	ceph-devel@vger.kernel.org
Cc: dhowells@redhat.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 2/4] nvme-tcp: use sendpages_ok() instead of sendpage_ok()
Date: Tue, 11 Jun 2024 09:36:15 +0300
Message-ID: <20240611063618.106485-3-ofir.gal@volumez.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611063618.106485-1-ofir.gal@volumez.com>
References: <20240611063618.106485-1-ofir.gal@volumez.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To AM6PR04MB5110.eurprd04.prod.outlook.com
 (2603:10a6:20b:8::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5110:EE_|VI1PR04MB9977:EE_
X-MS-Office365-Filtering-Correlation-Id: f94cd1c0-2de7-4ceb-c928-08dc89e0d474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|52116005|1800799015|7416005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QzSzGHztvpDTo5/nnqjOaAdvR+QE/Ge7pmy6RstGXZnyJvt0SFzJF2JC0Lga?=
 =?us-ascii?Q?GLTVs+9oeAOUNWRKEN90e7ZNBxO2a3tWNAMvM4hXPDeAfDDSGKZkNP94NZtW?=
 =?us-ascii?Q?dUc6ugTPfMfF4wk89TX6w+I3DGVr59mw7hW8bfdniM8LQBmdwiP6K7+wuYz4?=
 =?us-ascii?Q?itx4qzXoKjIQV1Jg132dRPI8CKxiPHvnkcu87SjSOQv3xsCkLSxxBUv13t7a?=
 =?us-ascii?Q?S8PVxNmSnqM/XkdGfXDKo/G2F4aWuBpaUYKyMA4mUbwdAjwxqRMUobVesha6?=
 =?us-ascii?Q?c7eRQVeIn2uCxuyXRflDDbbWZ7iv6ysPYIt/3SRshuLlZV2exwh+YV0VFdgS?=
 =?us-ascii?Q?sEKyJZwcvKFsurvnshSN+6ajcakgN3+wJUd5oBWDklHLtmqLah80YAGbgt4T?=
 =?us-ascii?Q?wRisgjG8lsm9/assRsaz35FuFp0JwtoP90DZU4phoVQ5sILjy24RNu454fn/?=
 =?us-ascii?Q?0dd33Z/bbfMlehM1Wcdmj8YgxxEJMVNQkzCnQDgC6CudMW0yl/GgBpEIPzJm?=
 =?us-ascii?Q?IbgvxTMPcUBiVZy1CjoB6JK3fMfcqknqxob+LL2qNHnEycXrfZcFk3AN8dsw?=
 =?us-ascii?Q?8bBY8cPYbYyH6D+15ialLdaeE7Fl5/2qhCGw9HKxT1t8SZkZi3IVTCTPTyFe?=
 =?us-ascii?Q?v6vdQuYJ1XRAkCBS/b7iuqGOPEwvUugF6ge2s6Bs376ilgso6C78wt2NNGil?=
 =?us-ascii?Q?K1JZ4Dd9n3B+lGWWRQbJ5GFQ6vfo6BsjSZcwmGhF2HbpH7P5Z7h/K9VIlxFo?=
 =?us-ascii?Q?8cy8ylksjGRDta4Vdz4cJM00XTXG/HYcrIbYM9JgxWL6Lm9by3JW6Cb59Tv+?=
 =?us-ascii?Q?MQhhWsdvC1DTdOQtdFm0ixNSTH2x8oBp/W2q7jgnz23joc2Lu3Bm6oabAjhH?=
 =?us-ascii?Q?Kkjf5bncqwt+5ebaOJvsFs/1TYRnePFV/b9OdWCHYOwrWWjpHEECCSLQ0DKe?=
 =?us-ascii?Q?Yrk6I8prfJH2/XVUd/UKYy77mngStPN/fYTVFRkjOpMo5txYspDyeO4uKhGo?=
 =?us-ascii?Q?AlQvvBi4xC6uDiJdWePjk2/X+NVy3vyz1VaUKA7JMZEQl0rtaplOeiKLWVUf?=
 =?us-ascii?Q?Hz1s5kuAkI5Zm3mt7MoK4ox7aPzA1cpAxLq2CP7IR5A5M+mTZ7Sh8SW7K4Hp?=
 =?us-ascii?Q?XSQChZlFlYIApC3p3fYgKqg4RFMfrgcxGeANnnokmtu8bJ3kefYxjyPKtfmN?=
 =?us-ascii?Q?wFSAfq1Mz7uwLcWOYOAmFJW7mSA6KmrpZLjnkBP+gXm2Ww5a+WyYXWoC7UZ7?=
 =?us-ascii?Q?OZkQuwGVrzrAh3aoFJ2Lz8KyIvMzpGSyBwceXkHhkq0FtuvhCaq8W108MfPc?=
 =?us-ascii?Q?WHR6Gc7g+D/Vn0Zjd6MHUi54jbLF3M5MI6Ie2/iiuQDvIt3KZLcFkxirUjx6?=
 =?us-ascii?Q?DCdyLUs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5110.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y++U6p3aj8gWl3NyeF4giNGy2i5Ls5mcxGPtmQKzOgpIqtq5572zDw3TJnIO?=
 =?us-ascii?Q?ZhIYv20ozjCg9NtHX1COE7fDeHD18x1Dmog6RNUTcQqByGGEVfNJhqGx5Gm0?=
 =?us-ascii?Q?FXX5Lq51MsQcT3LBg8MPNW2zCMlcVlw9lB06OAuT1zRpa02ZodCVAplsSoDz?=
 =?us-ascii?Q?SdOOE5OSs42Ds4Ti7MaNLlA+zFDE5yBZpmDfy0FshKJ/cuTq36R6lwUZn7Pc?=
 =?us-ascii?Q?W/BZCii/fPplxF66tIno1rnlMx2NfAjD4GL9D1riQpiwLdnihyrLj/5qH4Sn?=
 =?us-ascii?Q?QLTuiGtS+i/qR1DOyUU53XmmToUP9K0JbsNPihYx151l4qdOmYxTvZrGDSPR?=
 =?us-ascii?Q?vZyhxChSNzu3sS8C+W53n7I8WatTipjg369CqIdxOm4/JTvHXO8zQmGITvLq?=
 =?us-ascii?Q?5puX0fCVDgsEGMBUKZCBV3fXJ8l1mjdefcrpX07pcuzZs/FtRymKxjN8OR1w?=
 =?us-ascii?Q?ZNhE/5wbzCAzbwN1IUjwxsyIKzt7FBRhlJz/F7v71lYVCQMQ6+aoLNCoBQR1?=
 =?us-ascii?Q?bZWLuSu0yjivVODmaV+gw4sk99Ihq0IDCs3zRDpAePh1DVAxngUFIS7CXVgz?=
 =?us-ascii?Q?AOIgrTIclWfDgbuuycuJd4EFBAKc6cFoVJtEPoSmL0Ch9M907iUW+S3pYl1e?=
 =?us-ascii?Q?e3wQI/Wj3Oa3T8n2soLUHpwCyZbZsSHRmlE8friwtHDNOkJaI6nTvNVucfp6?=
 =?us-ascii?Q?G1hUcHsoUk4QlMwtsFSm0W72y3htDTrZ2CTXSCi1OtLIpooPLCQr+bGmpCpt?=
 =?us-ascii?Q?2jMjt2p32Z569Yvm667siN7ta5NEqJr3fQuc/7MwG/ocpkWwvIK9maMVctWD?=
 =?us-ascii?Q?+bhI6Ph50JdyzbqQD5FOZ0xKppYhgl95dAozwGEgxOJJmuKpKNtR03i9fMOZ?=
 =?us-ascii?Q?X3euigjMnBF2Ejcs6IC5E1xaL6os5D9qG26acjc2CMUT+Ktr6/FTjWy4nptA?=
 =?us-ascii?Q?PBEtZGOnfo/6SDDldPVZ8ZXGEm8CBR6MK70wuZ5Ihy8OaZabksMEgxnkTnGN?=
 =?us-ascii?Q?suK95WRIOOSUsIWJ7VrgIbhHl1ru6yiSjshKazudKcFs+4IecEXxl5iBw9cf?=
 =?us-ascii?Q?qA9zD6iEjM5bBVY6k8v5YX1ULZaFBoNYL/KS05rSsTe0x27rg1902+mhn+f4?=
 =?us-ascii?Q?uBwgkj4a9Xuco6vf+sulTf7PEran8+FJYZoxZKxUpqS2US+g+I2UBDEQtyy7?=
 =?us-ascii?Q?XNWCvzHEJESHGNfiTMdFQyNmMaUsEUHPvqtHh4q4tOtSjeHqaQCdlsIQZK1U?=
 =?us-ascii?Q?6J97igVkv2Z5SQIdzSd72qcvLU2Wdl65dykL7pKcezzgDzov5bpUYUNA7ZKM?=
 =?us-ascii?Q?B8iuCFK00QukQEVqKZSOaTK3U6VtoLR+FLcE/4x6gI1mOGNu1bEVzsuwUbRH?=
 =?us-ascii?Q?M1dY63WwYi0KQjAw/UriVQVC9GeK6M7FMsn5XmXcI1imFUJ/uOYm8kHN4SOP?=
 =?us-ascii?Q?x61MIR6I/h9f4onGFkpgCyZMjL6FfDXchX1xkg3pztLEsfF34WAFAlBzzqgr?=
 =?us-ascii?Q?IqKUSZ/XPPDArTRxhkjODI1LPAZSQNUsMJvMcronq84zmN/LnKZI0OxYWQAc?=
 =?us-ascii?Q?P3efI+2DHGy9BApF8AnGNqh6zOpmpejFJUbbF+a4?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f94cd1c0-2de7-4ceb-c928-08dc89e0d474
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5110.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 06:36:31.1881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VntzRM5FctOjkbgyL+ox7cwZ53uWAi3QvFISr82/1gkqZdpIhGrve428cMSZM8OCI0ux9RBZW073RylcTpn4cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9977
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_233649_863388_CBE2AA0D 
X-CRM114-Status: GOOD (  12.48  )
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

Currently nvme_tcp_try_send_data() use sendpage_ok() in order to disable
MSG_SPLICE_PAGES, it check the first page of the iterator, the iterator
may represent contiguous pages.

MSG_SPLICE_PAGES enables skb_splice_from_iter() which checks all the
pages it sends with sendpage_ok().

When nvme_tcp_try_send_data() sends an iterator that the first page is
sendable, but one of the other pages isn't skb_splice_from_iter() warns
and aborts the data transfer.

Using the new helper sendpages_ok() in order to disable MSG_SPLICE_PAGES
solves the issue.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8b5e4327fe83..9f0fd14cbcb7 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1051,7 +1051,7 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 		else
 			msg.msg_flags |= MSG_MORE;
 
-		if (!sendpage_ok(page))
+		if (!sendpages_ok(page, len, offset))
 			msg.msg_flags &= ~MSG_SPLICE_PAGES;
 
 		bvec_set_page(&bvec, page, len, offset);
-- 
2.45.1


