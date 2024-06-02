Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFCEC25B7E
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Jun 2024 14:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hnwTjXg77Nze6LQe2mD+iyMVp1YWIYX58p+5m2fahrk=; b=OEo3yQ95cFFs4Wm4QvTvTrFvgy
	jv/gpZa9n5e6r6HP9bfmmJgAKlsdpelb0gpctFVqk00mq/+/LTYFPTIeXEJE5U0NtiGMpQxh85t3h
	EtNEoGcfTawOc7CBMq0DFuuTpY2Text7qIXVAh2VPeKCHYYNyt1sD6GKvPwzQ9zPiyXrLgxrvuGiD
	iUCo0DLI8EulkSuGBa0HNa3mhzDIPm8ouJzEUOmLa3zJLYiMoUGjPz4H3PlVP15HHCe7KZwOJtYm/
	G1tsQGWAHUMH/haa5V1pHk9acXTWA/HCPi39cbTJ/cGrOpw72xq/IKJ6vyCG0tCuLHhGhIF68kKuG
	pDf7AXEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDluT-0000000ELr3-1qqG;
	Sun, 02 Jun 2024 14:10:09 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDluP-0000000ELpP-2NbC
	for linux-nvme@lists.infradead.org;
	Sun, 02 Jun 2024 14:10:07 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4526jm3S004327;
	Sun, 2 Jun 2024 14:09:53 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DhnwTjXg77Nze6LQe2mD+iyMVp1YWIYX58p+5m2fahrk=3D;_b?=
 =?UTF-8?Q?=3DDAFVvbN4lMb9k8nIQl0UNIb/9iBhzGaypRqFBHCi1K2H5w27twbbNvn2RTjC?=
 =?UTF-8?Q?ISYttx0B_jP1kxA882hzcUy8jQV4ZEewJFgAnd+31oFKwM0PxNKdbE5bNyW96LL?=
 =?UTF-8?Q?2TD7MJ8LrffJlS_zB5OmaPKiU8140sZ9GxMNPnILDJhq0ggKndTQcXwSRK//u3Z?=
 =?UTF-8?Q?f4aXaiS3b3sIr5UWN7t8_biQYKxBihSlAOEuhbvFppjEPqhO2dzsMvJR9lftQ/A?=
 =?UTF-8?Q?0QTXL8nc27DBr71iuN8ScuAXPt_mRrQvs6nLgL2MGuscZS6v0UTRKDepBqjtu1c?=
 =?UTF-8?Q?auSYvhBb/b/VfJW5rbVQ2qmg0FBOIu30_AQ=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv6u1cnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Jun 2024 14:09:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 452CDYtY037809;
	Sun, 2 Jun 2024 14:09:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrja1h81-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Jun 2024 14:09:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgCyo+NXusTZsIgf6k3dSiRgzBpsLx9LGA+HUnv0QBHR8HTFtUUFwMw5LFKsvegUQKQrQOLTe0UnZs/C+PeoN40sUJAHoh2NgjIV5ZDECW9Ag61uRbhl3Vl6BylSTuq7/DUaK/++rTNsYFoUwkvO0qpjIxlU/JcYHOczdtB/7YEjM6UknbXXs+F+AdeT2tjC/GSsC6xGfW3TYCLFow8rD0shO/gj/EdD7Rw1h03ZBkb0UZ8WW/aBzPx0X3KB9hBya2phyuY648EsHpWIXosMVzWPJrDCPd2hWVVt23hPzqwHfqoz5ESzLq5fbZ0Qb75itUgO6J/bRh79AHAUGDRo5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnwTjXg77Nze6LQe2mD+iyMVp1YWIYX58p+5m2fahrk=;
 b=AoVSV+JdqC65ywKEG4AfB9Xd7zPWPh8s58O80LcvS4Hyqj7g5Tl8dp8/5K3G6jTC/tykYR1xhwVdjWg5bKddhjBxxdBmT2itmxnbU6B2FFgnk1+pd5SC+ciBLBYHhZlTFtV/M2/70xqVoF6v7rb1Ji3iOVoCh9pzSPKGrcwZLY/bKFjz0uEedWMimpVVCn/m6xNA4EGGl1WppXYAPgamxQlbOZ6sm5f78sNqJfxvGNRih13A0UyW1t3t+ZQGHbHBNipBmmlFUcYyPHvFxexlxd3/MDPHvCQDT3Z+SZfr7naGuaY9ayrIlgnUQfabf6WvVDg2x0bkVhZE4tuvIySUzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnwTjXg77Nze6LQe2mD+iyMVp1YWIYX58p+5m2fahrk=;
 b=KCqSPMrE3UWVljJDRCXh9g2dHAlId7SPIg/OGW1Ahhu4GNtLRP3vekk13xnwGOwxg7ZYy90pcL7EhSgG0pex+C5GTIOTetyjtoW8p6LEFBYO7hES37J9d1eyaaEI989BLixwPBbpgsFZH71jKNKgF9OJXjwmtAOSXMdFar3TpQs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB8078.namprd10.prod.outlook.com (2603:10b6:8:1fd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Sun, 2 Jun
 2024 14:09:49 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7633.018; Sun, 2 Jun 2024
 14:09:49 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
        ojaswin@linux.ibm.com, linux-aio@kvack.org,
        linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org,
        nilay@linux.ibm.com, ritesh.list@gmail.com, willy@infradead.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v7 6/9] block: Add fops atomic write support
Date: Sun,  2 Jun 2024 14:09:09 +0000
Message-Id: <20240602140912.970947-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240602140912.970947-1-john.g.garry@oracle.com>
References: <20240602140912.970947-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:23a::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b95f740-2669-4112-7567-08dc830da9ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|1800799015|376005|921011;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zP+SIH+2k9RQY9rmNj/189mleTk25VBRC00geIQSQObgT1KawZagEDAYj6s7?=
 =?us-ascii?Q?Jm0LZv4S0RjDzENuwvQTNTmHl+Adq5vXiTc3FN4E8Vq+l/XflHvS5dEO3V3H?=
 =?us-ascii?Q?RCbQCuup4MIxfa6u+Ztd2tDuKZnsc+sd4g44hQlF8CJWkdWy9JC9tq4rpfWB?=
 =?us-ascii?Q?MYGE/qGcXtB604uFI1BSZV3g4hf0ZP44VWf1z07gcOMBICr5Hj8e9J2Bd6NF?=
 =?us-ascii?Q?6RcXGcJXmpAM/BuIUhidrBGvsfivjXT5EvpeT9eirYB4USdeRj/rtpvUvNHO?=
 =?us-ascii?Q?uYhn/I+T74acFbfxAQU3UIntKWzU4Y5wfvYrP/zQsQibBa1KcQEIRI33wqXN?=
 =?us-ascii?Q?yparXDTCcBpAHOLzH/bHf+IPhfn3unk2Q/yEe3IUnElI2erS3KzaImn7lwYj?=
 =?us-ascii?Q?Aa2IRxju0HGyYWsbL14cRmSplIw0IKl5rVUm/1LsNLujslGKOV2ZZH2sPKQ7?=
 =?us-ascii?Q?tnytOO1oabp8h7+Twm7y/BgZaShNB3asCYCgRzDGl/nNM67MV/dfBdij60cn?=
 =?us-ascii?Q?8uDxRYeI5RnA6VtlS02oBBsEDk/QH0yyJK8O5OVSHBoqwOr47IKZ10RBqhTx?=
 =?us-ascii?Q?5wXIQnxDa8LZaRjAAvJjNnqGJT85B4/ddemtUWIJ9BsHRPTNyk7Dsjs2zI9d?=
 =?us-ascii?Q?6LdKFCFb1IZXgeAX/jV/r8dVzMp8trrLfROfQ30QtRuTys+ELG8glK6A1e4L?=
 =?us-ascii?Q?hMee4S5xnXrRS66ErlQaQsSd6YbPNJKQxluLAPI30K/pdwksrMo4knz+3cS1?=
 =?us-ascii?Q?+EkX1JhcG9x3JdfXdlZPxVlV03Cq1eOdOUiqLcgbesfPN48F3muXKUFp4Qt3?=
 =?us-ascii?Q?F9JkwdUbGuQJfcb1u0tWiS2ZKhKOgfQ7DRkqy9Fs2ia1CvxZSR7th6d8Zt0r?=
 =?us-ascii?Q?ivvZUv2OrVIZGPqoJhzVoQUlAqALu4D7WGqKFUtACSsAdCbEiPdoOjgcBqc4?=
 =?us-ascii?Q?o+LwPxcH16yubo97Ezz0U2Lqcot+iyHJdARHOGFJ3AV+dwd6qRNbBQjQOOIH?=
 =?us-ascii?Q?8pLyGjJfj28TLQTfyRSxR08lu8/As62tY9Dnnm71LeWEvx5PsnBQupujBnzU?=
 =?us-ascii?Q?nHN7rQD8s5CpxSMqxvuD1KAcEtSHX3RqhaejHBnGmjop2xmLraW/4sWSfzLX?=
 =?us-ascii?Q?5gV4IGQ+r5u0yIfHoSXcB7yUhQP0pzp099w3XapR+rd0XNOCmPjN/5S6c4j8?=
 =?us-ascii?Q?cmNl9JGC3kmKD7cmKOGbwQFZw3kvjDIKBYPHEZ68M2Zp51SXniXHCK7euML/?=
 =?us-ascii?Q?4ndtff3Fy16WrOP7XGG1JaHmw9UE6ceKSPrfycgOzIZJkSafkYEjOalJXon0?=
 =?us-ascii?Q?Gwck1+DRHSbpX7jgNOaw/E9z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vlgy8YcnDw3Jq4pi7aC36fec/xiEMpd+dBXkdoYpsbOrEHK/CigK1PgVE89P?=
 =?us-ascii?Q?BUolUNYk5W+XOHhcWic84D5CfE8NRUgn8Tl0iVlsZr8raKAtf6Lt5DDHirL2?=
 =?us-ascii?Q?tigEYiE/82vBF7Tyv04BOY4sdJBiudb3Ga44gSAEedOVEbSm9OQyRhjeJdjc?=
 =?us-ascii?Q?4iOftOLDcLErpuRC4M7owfMHUhWOJTOUW+iS0PyCbNhqCclRrf3xLCmz3jgP?=
 =?us-ascii?Q?RVdPoGY5ZR/8QVzzKWLnFv7DO0J5WiXuacxqNVeSgoaZmGYbwvbN9W9WvJrR?=
 =?us-ascii?Q?HT34FZwr9jQEdojlfwN1ff4ni7Uk42Nwmc3Zddw83VB0E7uWvXkLSw/v3egE?=
 =?us-ascii?Q?HinRR98MC7MqiaQl92rfUDQcMkluZfdj2VT0nR6t1sJEZpC1Mru1ljPzfx/Q?=
 =?us-ascii?Q?IKWuSPv65DofYnfEqJxdlywJWueLjdqaXOgzn6tSlAwJAmRRSScX/CQsynwI?=
 =?us-ascii?Q?FkoZ5wFu7nF0z9O08qUyuRpVUT8eBvIuzEtyGJMhDjPZ0dTDcJBJaECR12xS?=
 =?us-ascii?Q?DZWTdJR59u6s5eeBR1/2PEOoHVBCHk0w3lBVwcWScZHuMZKKe0dtlFZpJ8ky?=
 =?us-ascii?Q?wGmImHPjApDMLwlVNZi4+RipK8Nl+eMQ2FalSzAeKOpy5/LcWiUIwccLgZge?=
 =?us-ascii?Q?SUUnTRiQ9pHZ5XEygq0IttkFgd/980uXW4G+G6x1C9No+bRFKbQ8ZSV3zl5+?=
 =?us-ascii?Q?sJswo9JQbgd3IffgmQguDQ5yToax2Lxu2NJ8LGYkG8U3EEnIP25nFJp6+wP6?=
 =?us-ascii?Q?R/whcpuE9svGaYYDvo9HSgSBO2e+pEAW/wSDb40XeJv/AwZuH7RKs1wEneVl?=
 =?us-ascii?Q?nrZEKyOzcPnVrhEtK3b1ho2ex+EqeMv8G+kYSUWwxlCW/yhB9e6PoIevzw02?=
 =?us-ascii?Q?ZOVc6t2U8G1hP5PuIktmCJht0DRGy7oS+t0tcF157a/hZ+7Wi0f7ktVUMYQc?=
 =?us-ascii?Q?aQYSXjHQXKPUAAXDVasq23cfLGiv5hnS+g815XH+c69eL3fAjIsoXFzyAgnO?=
 =?us-ascii?Q?0W9tA6C/IDa12f9J/5FsBaI0UTvO33gXMCfd6GKUkeYtN1aXyx93u2oSOuCr?=
 =?us-ascii?Q?yYdLZV+5tbOdXzJkOqj4JpFuozPrU6fyy5A+SpJ/uj9qkXo+p68Snp8vfaVe?=
 =?us-ascii?Q?dv6ypEpQs9QzlgiCHLKS9KNph4QLJMpsFtc6V/EU2LxdIqMm0kRbhBE2MJHR?=
 =?us-ascii?Q?Sw/k52bAKWigLDeFvXi6d/CRdYfeyPKmEDxw4mNQDlgMz0VVQ9wVuOOUlVGG?=
 =?us-ascii?Q?mtgGegdo0UnVfcXBoRphcOpR6AIGRkaeLMfJlNP50huhPs8wOJVtanN3+FPr?=
 =?us-ascii?Q?pNKkQQIWTrxrjQz9cHw1P0QOEg6i6Qyl0QKwl8vbIEGpVh3xsl36DJMINotF?=
 =?us-ascii?Q?lA7P2qTJEE2H0MlXkEzDQJsPp/RxACZOL2vjyggw0AEwoB+rqM0jsitePae7?=
 =?us-ascii?Q?AtX9vGWP3da8HQj9DrfMwfrOXhjU4Kv+PEWqLSMzh5RWhgD8lEYqQtsq+r1i?=
 =?us-ascii?Q?Its8/fbxgOKpkOmdj5NC6Zo560gLdSGtgEKLqFnXmJBAhOZAfryYCyu1h9uS?=
 =?us-ascii?Q?km5NoheagEbv0O47/lVTOhYd6xbZ3wfzfXGV1ICjWJKtFidY0qN0P6XpruUu?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: d80DM8wcZCQy2p0m2bz8keAys0Kp0s5KDXgQ4GHyVJNzv72GvY6/eWyvZo+Ul00SuB+M/6UsgOQEHcRzPLlXOfo4cFgULgNc97SBrF0X3ICITqTtaLamI6coG3ZBgD8/AbY6B6Lr3loPR5alM1aV3SU0DgtshlUB2IkjuJ9CirBWfRkT8pPAkJexckN/05glZc5nLxaGxa7JIfHeAZ97enaBFoM5qL7lsXdOl9+qS/IWLXFB3khwn265AuXenfunkcqNeHbzTxOYTar8emRWmMIyNkBphFLGD1GZLuZCZdpfrRPvVlY+wOKQgyQf32G0vtx6dSuySTxT2Bpq+69BLEL4W/b8NeW/9QF+B0D+QMfYHk7Kik6N8xuaFb4OYsu8k1jbDWrNgn7NbRoiOuYM8WGC4//JNqHMebIWBk7eegWXuuV+OsNA3TyeHDbqGBEKQP3KgQrc9EbnkWXR/XhIwYZ0Zl/V8JUlKCnalYmjHlvCuO9F44mcaHIkrn21n/927ln6MTq1WJIUCu4Ml6XLPUjYhhx/TbvRwG0psSTGlyRSHgdm2wRsr45GlL6T/KARiwUaqKne7rD+0eNQhgsvx7mloDDCVonCVNARe3olgmo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b95f740-2669-4112-7567-08dc830da9ea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2024 14:09:48.9724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPECkUiAbbBLmXcfyzF4/k1IpnHwGm/0CdQtYzW8m59nRAFaKJFluoDks8QFj8lfCNEWTHDHvYsR3F3aEXCDiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_08,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406020122
X-Proofpoint-ORIG-GUID: viF77xZHgbq0Tw0EE2hxol6m48gzbASn
X-Proofpoint-GUID: viF77xZHgbq0Tw0EE2hxol6m48gzbASn
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240602_071005_677440_513CBAA9 
X-CRM114-Status: GOOD (  15.72  )
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

Support atomic writes by submitting a single BIO with the REQ_ATOMIC set.

It must be ensured that the atomic write adheres to its rules, like
naturally aligned offset, so call blkdev_dio_invalid() ->
blkdev_atomic_write_valid() [with renaming blkdev_dio_unaligned() to
blkdev_dio_invalid()] for this purpose. The BIO submission path currently
checks for atomic writes which are too large, so no need to check here.

In blkdev_direct_IO(), if the nr_pages exceeds BIO_MAX_VECS, then we cannot
produce a single BIO, so error in this case.

Finally set FMODE_CAN_ATOMIC_WRITE when the bdev can support atomic writes
and the associated file flag is for O_DIRECT.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/fops.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 376265935714..9d6d86ebefb9 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -34,9 +34,12 @@ static blk_opf_t dio_bio_write_op(struct kiocb *iocb)
 	return opf;
 }
 
-static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,
-			      struct iov_iter *iter)
+static bool blkdev_dio_invalid(struct block_device *bdev, loff_t pos,
+				struct iov_iter *iter, bool is_atomic)
 {
+	if (is_atomic && !generic_atomic_write_valid(pos, iter))
+		return true;
+
 	return pos & (bdev_logical_block_size(bdev) - 1) ||
 		!bdev_iter_is_aligned(bdev, iter);
 }
@@ -72,6 +75,8 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 	bio.bi_iter.bi_sector = pos >> SECTOR_SHIFT;
 	bio.bi_write_hint = file_inode(iocb->ki_filp)->i_write_hint;
 	bio.bi_ioprio = iocb->ki_ioprio;
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		bio.bi_opf |= REQ_ATOMIC;
 
 	ret = bio_iov_iter_get_pages(&bio, iter);
 	if (unlikely(ret))
@@ -343,6 +348,9 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 		task_io_account_write(bio->bi_iter.bi_size);
 	}
 
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		bio->bi_opf |= REQ_ATOMIC;
+
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		bio->bi_opf |= REQ_NOWAIT;
 
@@ -359,12 +367,13 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
+	bool is_atomic = iocb->ki_flags & IOCB_ATOMIC;
 	unsigned int nr_pages;
 
 	if (!iov_iter_count(iter))
 		return 0;
 
-	if (blkdev_dio_unaligned(bdev, iocb->ki_pos, iter))
+	if (blkdev_dio_invalid(bdev, iocb->ki_pos, iter, is_atomic))
 		return -EINVAL;
 
 	nr_pages = bio_iov_vecs_to_alloc(iter, BIO_MAX_VECS + 1);
@@ -373,6 +382,8 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 			return __blkdev_direct_IO_simple(iocb, iter, bdev,
 							nr_pages);
 		return __blkdev_direct_IO_async(iocb, iter, bdev, nr_pages);
+	} else if (is_atomic) {
+		return -EINVAL;
 	}
 	return __blkdev_direct_IO(iocb, iter, bdev, bio_max_segs(nr_pages));
 }
@@ -612,6 +623,9 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	if (!bdev)
 		return -ENXIO;
 
+	if (bdev_can_atomic_write(bdev) && filp->f_flags & O_DIRECT)
+		filp->f_mode |= FMODE_CAN_ATOMIC_WRITE;
+
 	ret = bdev_open(bdev, mode, filp->private_data, NULL, filp);
 	if (ret)
 		blkdev_put_no_open(bdev);
-- 
2.31.1


