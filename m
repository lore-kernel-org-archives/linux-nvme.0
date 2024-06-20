Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7E8C27C79
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Jun 2024 13:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v9656SdQpzrKVNwFfsUbO8Jc9qLT9UDvLRy4cJcRfuw=; b=2+zr7IDbzPGadZFrig8Uvs9FAe
	Uz4nd2GaYBj0x2xh6WMPxBOvicz7mm2dCA85ee5L8uIdvN0MNwPR0AtvnrcBV5mrNxX3mqH9RYPBf
	AeQq7oQeMgRxUxWGMCGKho1UFwNXK2sveH8lhQb2HcNHUaCWoYOPV8C7jnx1O6Ne+BjoPyRlf4y84
	QQNqM+hc1hhK5Pjw2nJe+138FN+0Hy0fuu5ihBiVbtMI1FSF5cagGrULEfv72kt9LUYl8BbVuWrdT
	vsZHfO16sCRWSOrICg4YKxPLmrqKPgygQHAbhad3l17mIUJbu7LSdypOIlXjVbB0Fxqt2FQ7wKQKZ
	c3gSwVOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKHPs-000000053Pb-0OWo;
	Thu, 20 Jun 2024 13:01:28 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKHJR-000000051BT-1czu
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jun 2024 12:54:51 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45K5FEXO014356;
	Thu, 20 Jun 2024 12:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=v9656SdQpzrKVNwFfsUbO8Jc9qLT9UDvLRy4cJcRfuw=; b=
	H7zuEBTsLUpPhOuZ8KV/rw5CxE9ZWkEhhY9d/4R5ceOuQZrrMsrfhodqZTjgbIJL
	o0zsT/ZP8oG9SXyaoqn1ektsiKH+0eZAGlNil6AbMyp3URq84YQtCW+oqztPr7Mc
	P8GHMKMAM1Amk1qYBU0RBU5iRkr3SpiniUpdrpZKTosm8MJUoHrhH+QEurlhv/v8
	N8yJ3AIj0hORSI5d99pqrbomcLue7M4TliTCaYJUuLbjhKFVeD6PNkSvoq5W2lf6
	ekub8nXQ0EgOi3qJzUbBvImdVWBYpkE1tpV2+FAzpsmdT5oZR+gXxTii4Lw6PZGp
	E/a5Mo2Awc5aHOsqM9+f+w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuj9gk53d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 12:54:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45KC7utY032824;
	Thu, 20 Jun 2024 12:54:27 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dae6dx-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 12:54:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2CEiT79VCRMexP5o6oNY6IcfaLoga2gAlFK206lRIvQxnsRiO9C3nUYpRlYxuPn5TjEI1DlKnGyarrP+ygtiGhFq6GHezUCKcLuzrJV8HImSE55nglLYdiklfD4gW/IN74CdEddjX58guhS8/xD7i0QQsPC4zcRVEHBsW2Gw33HpjC7OELxUIGB/o4Y/KIMR8/x0o39Sq8ugd2o1VuZplWH1x2/gYZTOlhzB/h2ZtOKFdPd4ljoX/CEXzuDHmeTmVOVZYa87I0sCP78/0TN5JenLzaLUcnkyb21z7f9JfFGe8Wxydn83qeShjytg6c/xmnZnud2F2cXiCM+qwrh5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9656SdQpzrKVNwFfsUbO8Jc9qLT9UDvLRy4cJcRfuw=;
 b=Ycd5E24fhxUP3O8iRCcsaA3Tq6ePq0T44HYD9owiuH8H0EJV6/ivXUeNM/+kuBfZZ73rqZwoBwXyvCQCtBo4+w/bLNfF1nFR5CMVrBC+CA33EeuMkqBuTHpH8dfS/BNFeM7GOZTSug50OsPrN9tgBt0nHrbfIqX5GUuNVtx+OocpHaOqtPioyuuKx/bBMSHKpOxust/Hu9QSy3FpRLzyF5nZmjAlHLoVq3uonP10WZvTAtB+Q1zG7IvJp1f+70BjDXAZ7uPng073WrzJSIFnEvlX3CBTeSrrXbcwpWejGyGFVxEiNzso5csv4GHCYXgA76BV6O5o0Q2297hEdbBpnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9656SdQpzrKVNwFfsUbO8Jc9qLT9UDvLRy4cJcRfuw=;
 b=Wx2z1VhbPQLOIHDQyTRNfCYp0TI86IcPepVhD0xT5C8Eiq1DRkiACNtWgOFOZlMwTyWE1h9DMWPWfbQnsyK98+Je8dTn6EaUa51QgYBWnQsP0EUBQIdRdjpM8e6TZ28Omrv4CuKjJfB5vuV3bVEZ64iBsNr5DGJbjP9+fVpHnqU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB7695.namprd10.prod.outlook.com (2603:10b6:510:2e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 12:54:26 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 12:54:26 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: djwong@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com, linux-aio@kvack.org,
        linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org,
        nilay@linux.ibm.com, ritesh.list@gmail.com, willy@infradead.org,
        agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
        dm-devel@lists.linux.dev, hare@suse.de,
        John Garry <john.g.garry@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [Patch v9 01/10] block: Pass blk_queue_get_max_sectors() a request pointer
Date: Thu, 20 Jun 2024 12:53:50 +0000
Message-Id: <20240620125359.2684798-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240620125359.2684798-1-john.g.garry@oracle.com>
References: <20240620125359.2684798-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:207:3c::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 93237373-85fd-4e69-69fb-08dc91281d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|7416011|1800799021|366013|921017;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/wcUJgjYsiSDN1SBME47XgSUaP6s9nQBMcTHTfXI3fgp4b3VCkvRINpmw5wP?=
 =?us-ascii?Q?Xp6pI1cVB3ejoaWnEXy0SOWcALsVbH0M4owEFk9uVNR+hHlP7KHtXaTtYYxi?=
 =?us-ascii?Q?wp8naYKeIO580zkuvO1a+xHeSgV5CVvpmRVj6TBnqurgnjMGNkvcC4huAjH2?=
 =?us-ascii?Q?FuNSwp0GhZILuclDxgSLqGhWH6Jkt2RcVplUrcdhfTk9fXjjrDUWa31p2g9+?=
 =?us-ascii?Q?uLm3Mf+St2O6QhAfkdGyHS5qhgmGutBbPv0PCiNPvTT1hPpm/IudoGlhoSCK?=
 =?us-ascii?Q?qDLCLYi4maUek2BTJdBb6xbIthxHdxMmO+4WaMXKpXbW7yufngBFvcCzwSue?=
 =?us-ascii?Q?WyQg/OoltZKxWnFIQi8qMQyH1HZEtmld6tY4mG0J6GdjaI1LemZWWlRJ7kcL?=
 =?us-ascii?Q?FWlbMe2pBeihn/lOvIxWOJkr28GexWGf15CI8PitdjSdayeqc3H9kqv+8ZZ7?=
 =?us-ascii?Q?jzlzOJ5YIpCf436SI78uCqHVvk/1Hr/2vpPZI9zmilDyKnCmgxuPzxfqAPMP?=
 =?us-ascii?Q?JjVq/I61zxFC43eziWMGfsXEqr0GHoxD3Oei9nKhqUaNlKiSpi797DOSzWnR?=
 =?us-ascii?Q?fpT2dDDh/AvrO9p/oTsgwdyo0EV8ZU9EC2Rh0ETwQiMparzMjtZK/7GSX8ti?=
 =?us-ascii?Q?dow455YA08YIZwNNL2jUIRpTXl7soAeIKyADsjnD95R3KGpUeAA/wNSn91AT?=
 =?us-ascii?Q?ZXW3b9gwNzbYzbvXwYUh+5mglEaTc9dGhcP8zes4pVTgnAQZxh9Ql/jhDrlb?=
 =?us-ascii?Q?RPV/WlDavkbmroZTbUIqUyOTtOSHYKb+nduVFYEquslZFjcRW0njTDRQ8f15?=
 =?us-ascii?Q?MXGaA7V2axtSOQvR6LcxLyHV4sXlb2bIM5fD/Vmqh6J6wWI7f3dfHTD/QaZ+?=
 =?us-ascii?Q?HzP5Lyr7hqT4hGY/X9+CfbXzPyLAZ6cOxSnUIayA1wBN/+qaJ1cCPW2q5zp9?=
 =?us-ascii?Q?b49PNJS7sb/qa6g3X6ZkZjDiDP62Nz8QwJeNg1IafEMl29gyo6jXw2gJai44?=
 =?us-ascii?Q?+itqXda8qQjEp23w9JTBfGuUiNiuzH3rO8/yrgd7DaEzx5Grzx3BpP/vsDQJ?=
 =?us-ascii?Q?RixP6wtlrISRE8pZIdBOM32x9XDZc4h6u6ExT5mtk6y4htryUEL34QACRkRO?=
 =?us-ascii?Q?S1mh1BUMSN3ZW+PGD/r7fY/W3NPgoQOXKhF8kDx26jQM53Mmdct8WIUdNejC?=
 =?us-ascii?Q?VPTSDyf5OEepVEaP8lpuDnfD2pnxgkj9m8eFIVy1tjeTuGakWstfjBYko+21?=
 =?us-ascii?Q?IaRB4/FoCp8k3Km0f/sCbZDZsmksr4M58i4NIn+pTWU0GoWxSH9GTzip87rp?=
 =?us-ascii?Q?P0mFF06BjmrtQr/p2IaL7xo/sysC4mB+OWSmcCKVBxGLCzU4QoRs1ZE3tYfY?=
 =?us-ascii?Q?u6x2LjY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9GJKSagrhPf3gGAkcR6qN6axgnxCvIkF431FoH9ohcJLHcaRFOkpjfZkAsyb?=
 =?us-ascii?Q?5k6a1DwpFOuMxLrPqox/yB9DHLdIHBRCVL8E/Ty1pJQlDTUgrZQkYhMe1ETk?=
 =?us-ascii?Q?Kiu3I5udD8SkKz7QSG12PEwWyXcKVIAoc6HyVZhSrmIWQe7OmCCZK8mzlBBB?=
 =?us-ascii?Q?L+RKLbgbhmZGsP8LnR1sWW/6BLgGVyEWzMr9GKLZA2AsE2kF3clnXOsV9LRv?=
 =?us-ascii?Q?iScwJitrOGppeF3B5T0JpDXO2ikaSZw4Vxh5x7PzMcUrqIRoVsxiukyNdpka?=
 =?us-ascii?Q?ONYDt1DPrtHzNs5TgLxPQekrJVUPn3kw8gW90Ek89suPnEuJM1LGSy7UR9O5?=
 =?us-ascii?Q?RGTAfiILBhLXeWBGjhZXpf4Zmk0ou7aoimTYyM3bOH/KpgQp+Mtm8QYuhE+Y?=
 =?us-ascii?Q?bl1TnSg/CzZk0ZhstyUF4t1Pw+iwldsOYr46+tk96e3hFiMfFqigWxnx2WVx?=
 =?us-ascii?Q?wfy829606iyCGlMcm/IAQ7bqTv1qFflsjX5tSuYS+CdgBmjZ/YPv2LqivKlJ?=
 =?us-ascii?Q?FCnmJ/Z5NF8iiGhNHOACaa+qBkf3HAcjnYhpEQXzXCGIUc8eUr3wdrK8wJYo?=
 =?us-ascii?Q?LXe0nIRLss4e2/6sa8PQzu3vaDx9mAPZ6GXIWAWRkTC8bO9lJqd8gVrVJzag?=
 =?us-ascii?Q?o2uViCDHHeGjTzMqoaVUKxZ6P/vAyN4YYqSpiJurZnI/KVQ5c8iuVwNfDWAV?=
 =?us-ascii?Q?EGiJz2sHPRQMuuMSxDh7PlMB0xn2UdkBfOBjV0ZnAR7ElHgNVVjIgWDTfRJd?=
 =?us-ascii?Q?HgeVo5KDTQilNAXC+aDRB5J1KzFp8VPgY94KaHuXqIwEGv5u9mqgsnjZJkiU?=
 =?us-ascii?Q?hyr4QL56fRK9ONqOf+QWZNChX+MGFFs9pKdgvhJdfyFIYh+NTfF3e7Sg/+0W?=
 =?us-ascii?Q?1vMWzgtPl8QgW90Zso8iKiaJ+rcMdkAYboAMUFV/wE79W/RZFvnMsmZL80MI?=
 =?us-ascii?Q?6k1OfbV3Chy6HBZtrLxi+oVy2zWxP5wDPZgvKmSHcjzPwYsuDhX+96rxQheI?=
 =?us-ascii?Q?n/0w44GvKC2WDDxGqf9JjEU5k4cm9eukgd9+T4pb640nMEVS/KDNWxCHDcD8?=
 =?us-ascii?Q?gjYbDc7r2LxHAwlAn6kanb0Sn1JIIQzdqaojP4kWAkMr7v81IEgJ7I+UWbd3?=
 =?us-ascii?Q?5HF0S7iVo1q/ycBYXTCJhJkEDg0FNfOODIatE0Y4IZE8+9WYPFJxw5H3/Y8C?=
 =?us-ascii?Q?khIBtA5InfL+gk9vX1QvGfZoiGbhwiRzgrFlm6/HMIRbo70uIdHfLzPBeTvL?=
 =?us-ascii?Q?F2GkbPYVadVGpESLb5JKjCPSQK48edYA8O1WIN4Eh/JvoW7646yeEE5dunPe?=
 =?us-ascii?Q?yV74NKSDRZ3imx2JDeCqgbygvu3qtWOWWAB5Vd7GuVZx5IoZPBsijekkO5LS?=
 =?us-ascii?Q?rC6fsL0cC5OxfipfXXk3qcxxfaDXqXc8X1x7UUW/17GPo8ReTJkTsg+w4y+S?=
 =?us-ascii?Q?uf5jvh9Mk3N2hN8SX7A1O6f+wk21fmTtEkBrde2rIoyWPuMdm8srgGDRsESa?=
 =?us-ascii?Q?2pVFUBSOYKmmIXljwpaTHqtAweAB1WL8jc6/tNrc6xO0cTFPnDSytEQ2M309?=
 =?us-ascii?Q?4TLFzndP6mGX4wagG9TqzeQPtNF6XZm0ppvQVlsxr6MZTD6FywEC/F4pVqiN?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fKqLwLuNkcA7oLxOMIBmTd/AzWyETExM0VRMR5DP/9z0aaXu72ULTokCkNwJvaevvQ8+JUPRm9iNaY55sgBrGRQA9l6sug6+tXddcS24T91Q7UP0AWA40hT/wJmkj7WJPUSOZD0lpmtuf0pOUCwJgs3zAKkCRAb8AXh1uT9ndZoK3bSTqBU7D/BtxpuVLo4+H1pb7Vo3DY7p5Fbtyp9SUrJThkHmDtOZUTIYVLj7Wwj8eow0YU/dsVpjwVa2H+VXhq2B8qRa1F26AwEacC0J4wSzFH/8vUJdnTFlO/AOxvkYE7WP5PCc3LtxU7o2Md+c3DQldXFYvKDE8o8ynynGhpfOEoHIwwzLnECwDyJ4VzKVQioOGHpuQyl3Xu8l3v1OJ4JmFZ1bpI7iQySx2p74CNtcnTC+JORYHd0NSo0Li+KBSobKHJP7VKmthYn1/IMDynyhH+SJQW1lJxo/rVrnhgAL9VelyvCaTBVE2/m/gG8dZO51pXztUVKunhohzWRyH9BmVrybWztn5VifJBAPbb1g6Z5p4kZDgI/Ou0vmMhEIdGfYWkzFhMSf+X7+e5AFqfmfgNxT8urVeqRGBn4DtQ3rOvaL6skEzySVspRXTQI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93237373-85fd-4e69-69fb-08dc91281d79
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 12:54:26.0117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IJqagTFZnCLYbhivnPLHpeIzkEBpSl0Dpy0OB8avldEQ51AevJEtlMsGdMT0HJUn2CL7O5VQCQ6xRxkFsD8Jhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7695
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406200092
X-Proofpoint-GUID: -DXiYAKlmtymKDzy0Ay79f4PqhHc6PHZ
X-Proofpoint-ORIG-GUID: -DXiYAKlmtymKDzy0Ay79f4PqhHc6PHZ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240620_055449_572545_B0AE8665 
X-CRM114-Status: GOOD (  14.49  )
X-Mailman-Approved-At: Thu, 20 Jun 2024 06:01:22 -0700
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

Currently blk_queue_get_max_sectors() is passed a enum req_op. In future
the value returned from blk_queue_get_max_sectors() may depend on certain
request flags, so pass a request pointer.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-merge.c | 3 ++-
 block/blk-mq.c    | 2 +-
 block/blk.h       | 6 ++++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 8534c35e0497..8957e08e020c 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -593,7 +593,8 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
 	if (blk_rq_is_passthrough(rq))
 		return q->limits.max_hw_sectors;
 
-	max_sectors = blk_queue_get_max_sectors(q, req_op(rq));
+	max_sectors = blk_queue_get_max_sectors(rq);
+
 	if (!q->limits.chunk_sectors ||
 	    req_op(rq) == REQ_OP_DISCARD ||
 	    req_op(rq) == REQ_OP_SECURE_ERASE)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e2b9710ddc5a..47fe9d19b8f1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3036,7 +3036,7 @@ void blk_mq_submit_bio(struct bio *bio)
 blk_status_t blk_insert_cloned_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
-	unsigned int max_sectors = blk_queue_get_max_sectors(q, req_op(rq));
+	unsigned int max_sectors = blk_queue_get_max_sectors(rq);
 	unsigned int max_segments = blk_rq_get_max_segments(rq);
 	blk_status_t ret;
 
diff --git a/block/blk.h b/block/blk.h
index fa32f7fad5d7..20c5718815e2 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -182,9 +182,11 @@ static inline unsigned int blk_rq_get_max_segments(struct request *rq)
 	return queue_max_segments(rq->q);
 }
 
-static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
-						     enum req_op op)
+static inline unsigned int blk_queue_get_max_sectors(struct request *rq)
 {
+	struct request_queue *q = rq->q;
+	enum req_op op = req_op(rq);
+
 	if (unlikely(op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE))
 		return min(q->limits.max_discard_sectors,
 			   UINT_MAX >> SECTOR_SHIFT);
-- 
2.31.1


