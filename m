Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B363C27C5E
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jun 2024 12:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Date:References:Message-ID:In-Reply-To:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W341iCnKt7T0Uokc3IUhJdGHSjGDvtyXBmgRZmqC9Wc=; b=OeP0XcKt9lw7RDlPD0HOVy73sO
	GuG6ZzU1nTqPgi/UR5Hfm5vjM+orfGHEIBRvZwKBfIFn0MkrjKSE3SpgH8I059KG8Ae1/BODhz1la
	lS58nkZGfvmahSBDPSXuWjkxPwMT4bN4gH7jzKErRHtS/tBp6g67K9yMfWJRindrTteZExf9xDJ38
	KD1r0xeRzFRQoID/0DBSQ8U9vSGORRNnw3Z1oH6ooTnWjplPukFtan2LxdSLE0CpZUNbj50Msjml+
	d0z/k5ygoUoV4+KbTsz1jeTzqgxaocjjJ23FpeKo+woNSoqKiV6ikn+OvAREa6Z2qjYmUa6GRZVGp
	aOZEAkcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGdhp-00000004uvq-2V6H;
	Mon, 10 Jun 2024 12:00:57 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGdhm-00000004uvM-3IOL
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jun 2024 12:00:56 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A4BO0E016238;
	Mon, 10 Jun 2024 12:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=W341iCnKt7T0Uo
	kc3IUhJdGHSjGDvtyXBmgRZmqC9Wc=; b=dDtZYBTs5kaIWXBYPjSwyMi2Tbqxx0
	OzvMO0XiNFtyk+4/mwgRHddYco/91QjzfEJluL4UxZxYrqDOQDC9bo5/oiPgRBln
	Bu1zIdpLwIqyV12dDjuEINPNLJ7G3SzT50DO6MtuCn50vrZll+8aMZ7OsBDn7b0N
	oo2Kf9amp7hS6fVB9yXyd2yRNo1kxJTSNwkfvfGvc2GDQ5PM0w1L3abiILQDSdqo
	RDwcgn61Ab7CwR3OKDpJpXvQ5ZN/bZnO7IGUiherDkAj/1RelDVsSmN3zDGihekF
	fyfXNXhboulxiC4LlrjXScppwvwm2e4NSkoEMitX1xLrlpcGfivzRS4g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhaj2cah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Jun 2024 12:00:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45ABxApw036622;
	Mon, 10 Jun 2024 12:00:44 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncdunv66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Jun 2024 12:00:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQ098EGBukVvHmlQgjJSJUZVIlAnEP8viFXV985T9VscUdXR4BX/21rTFr0W3ldRCQeIhlKfwxW3qwJ5DIhZnSI4PJsY2aird0/q96Mz3Yev/QwLzV7Gw+GI+dpmHsXH30JWMoPrZ65dTYgiAh46xF8zKlGfRCD549fC94huvt/WJg6hdYGlnzC3ga38xAX667rexoqYK0GXIKAy76EbArx9TKGgoI/QmO9O3OELwwcaQf397O7lCW7LISurTOIXUstTTgt/sVzlFXYZM1E2Jc1sUItMXwbPT/6I1VdVQh1Vyi1dTm96Pb3K8/oJQ7dA7SgOsfE5aMPUTjFigBgF5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W341iCnKt7T0Uokc3IUhJdGHSjGDvtyXBmgRZmqC9Wc=;
 b=AddPOgNwPXujbPz4knVHsEM9we2CCV3W/a/RUM0ql60mE5uLNomN9ckwiYUwNiP6HJSOtiTGmGKhoFbmYWRql+vdAF87nXoZyhMdfwMDwobYI1knye/BqRyTKEFOSSMPt2GIw4B25L1lPrnf3xfvWcCMyeISXzOXE8iUKu6L9/9kGymxXoIiW/h/wVy4CWxwCnPnghB9zthk9x4tq7VP94WS9SdHnQKCX8DXqVaDLST33+Qrk4lEbdmCpTrwPig0KZxgqzTt+leXjERyOr969Q008/kRducLnhRH6XxACkYhu1P9GHyEME5CyjPjSsAvY1pStVSsH6wVn+ZTQ3d6/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W341iCnKt7T0Uokc3IUhJdGHSjGDvtyXBmgRZmqC9Wc=;
 b=f11bn6gFOYXBBsbol3Ue3Wye8586YBT1yQcceJNrWBlpw6E0tvuG0/+ynn/UrEVuotLbekz0h1xXu4kwW8mEVKSdCssN914PBcZRHXQ18c7g4m8ErufmY4oh24+rHx/YxaTHF9W+EDOPoR9OjP9OTg+I7pyIfPk+cRZBEiaCro4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH3PR10MB7236.namprd10.prod.outlook.com (2603:10b6:610:12a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 12:00:42 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 12:00:42 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Mikulas
 Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
        Yu Kuai
 <yukuai3@huawei.com>, Dan Williams <dan.j.williams@intel.com>,
        Vishal
 Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Ira
 Weiny <ira.weiny@intel.com>,
        Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
        dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 04/11] block: remove the blk_integrity_profile structure
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240607055912.3586772-5-hch@lst.de> (Christoph Hellwig's
	message of "Fri, 7 Jun 2024 07:58:58 +0200")
Organization: Oracle Corporation
Message-ID: <yq1a5jt3t5n.fsf@ca-mkp.ca.oracle.com>
References: <20240607055912.3586772-1-hch@lst.de>
	<20240607055912.3586772-5-hch@lst.de>
Date: Mon, 10 Jun 2024 08:00:39 -0400
Content-Type: text/plain
X-ClientProxiedBy: MN2PR14CA0018.namprd14.prod.outlook.com
 (2603:10b6:208:23e::23) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH3PR10MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8cd574-408d-4680-717a-08dc8944f3ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?svdWPND43jzk0632yyHUpHAoDjgTJQYWeLrzUKzpWFX2x6MEq1q2vKiO+Isx?=
 =?us-ascii?Q?iRQW6CHb0Oaj06FAb7ry6MCMbEbYrYoFz6+yJj65iD/lyhSuUh9Onq2WCmGy?=
 =?us-ascii?Q?HzkJogj4y9+loqcEss+NHvCKHmSpqkYGmeuFPeUbeVcbxKgyZVUP1gkBfQo7?=
 =?us-ascii?Q?kn0paBQCSe/On1vtFcBcJyjqlbTbRatYG0p2mwe3RNFDfPY7oWpe5sjcVf8X?=
 =?us-ascii?Q?An6RGmJCWFpo3wsgrdAzRk55EdGeNJV7+2aZrs5jyZdJbxQg8bx1DAqup8fC?=
 =?us-ascii?Q?XfBER4L9HTwDNwa990J/iYTSXaUcG9xL0LFtaQ+m0zvH4Kcxwue7JSYyJwf3?=
 =?us-ascii?Q?7FixjfewHG7gd41U8T+PxwmOxa8BFWSKTq/O86hX8Y0Sbz6ktpJYbby0RxjM?=
 =?us-ascii?Q?crftg+3ziX+nknzJdgWhiIhB+nGQtXSVm9t1Ozi0EX0GG4UONfztWrbC0G0g?=
 =?us-ascii?Q?Z4YAoNHxYBpWXLKSxUBaxO1MQ90LGKLeolE/mPH0r0w+F7RFB03PZcmx7tNt?=
 =?us-ascii?Q?NExVbuqRsDWUrIfhHGZFXwDP9nWp33CSLcZPztGimm8MxpiNYXGRfZmDu+Ao?=
 =?us-ascii?Q?yH6rwcLHOH3ZBy6+n1iyEw0huh4dQRHNfBajdYgO7TYoZWhSc8XxbyWareMk?=
 =?us-ascii?Q?7N/YTeO5ba333vkJI0vR2TW7S7v9ujWta+Ak3/RrH+KgUYoVI7eFZClXxB9U?=
 =?us-ascii?Q?8vIWXLPvzNfrH9R1V02hVpPZOjMvC2rKbGKVTkm6af+dM1b0Bh6Lym7oxifP?=
 =?us-ascii?Q?rRaZkmHj8h4MdQet3y/WxNKyPCSU97rUkK3evrY+t4tfUyRa11bbKuZ1kQeS?=
 =?us-ascii?Q?YlSmml8f4TpXyDGDrk+Zvw1BR/JdlbEAkgYoyBcsoJR0smbEcT3ZgzCooj90?=
 =?us-ascii?Q?3nmwPQq4UbS5KFoORegZ3FSPVQUIvyHzMLsjb71xeFNwTvWwvqMFwLxiN8/p?=
 =?us-ascii?Q?pLC5CaJWSGCXWhPr4PPjd9JVOR5PLr5eIcrTALyZBgv9urB2I4gKtq/kk/pa?=
 =?us-ascii?Q?8MlPMEFDUc14yZlUOo3wCkEBX9sWnm0iWsdQtcLh/Gae11e7/q238rTYd1eC?=
 =?us-ascii?Q?8rX7oic/cwSQWkUPB8Tf/Kl1d8yegiGV3TdEjwc+Dq3ClFxeOr0SF7SHi3Xm?=
 =?us-ascii?Q?uWBMFeBNMXE24k3p5letlsxjVLSyIsA2PqSHypIECJLnh5uL/oFvDwR0jI1E?=
 =?us-ascii?Q?5oUgYSSIOvuX/GwDf4bGcrUCNW3T7Lwp5fkX8tkAWMEw6j/2VzwzRgkk6G90?=
 =?us-ascii?Q?vPIU/asZXtNcrIO3bZRAvt8WMThEWKtKl8wOGi/69XY0PjlA/dQEDgh05pnH?=
 =?us-ascii?Q?rJOWNc6esbJH6K0MLksN0eii?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P7uP1JYaL5VgoYRAATFTxU2ID2kZXnQETfrqsInJFsPfMClfPuiy8Ibxh0Vn?=
 =?us-ascii?Q?4RTGtUZS0kRnzvlGyYr9L0l7i9diue6umS9bKMB4MqGptGqtnTP5/OzvW9qp?=
 =?us-ascii?Q?/mtdG0V+AAwmeS2np1VqSFgMClBZp1Zzj++vFdjpRqWKJf9Yo11IlARb+FZC?=
 =?us-ascii?Q?2rn9s7LA2/eIIh/uhvxnOGKEZwC8pr4HsDaGK2++BNgQ7j9iVefASS/9umIf?=
 =?us-ascii?Q?EBfaCsCDWfZgYSEa6hZOlcqKc0VV0qy8XRHQbQHJ4Ou4Ku/Oemhz2Cy7Yg1W?=
 =?us-ascii?Q?jlPveNmoYgQ/+eeiAIF3P6GxKAFzYtejEY0UtILIysyJuHrnBN5t5ROwJmLh?=
 =?us-ascii?Q?yV7Q4iQNKRLxHx2zkBZuvXBvyjZiDeRqKMMoRBUQfA4LaWm3k91ckqvINTmn?=
 =?us-ascii?Q?qc7rf/t04Ha0VSxyBuhkB5n4dd7cI2hWbAkLSlbfVoGdq1NYMBxoFjsFjn4M?=
 =?us-ascii?Q?GuHxD53xE3bbxtFWIeATkObWQGXw7WwmMcwEkkBJ2PypoOoWscK3dEJilnRR?=
 =?us-ascii?Q?uLZRee+V3CvHYGCm44aYUKUQzqGLwau6HeVJjdrwR7oQmfRE3Py7hk6F6ZYN?=
 =?us-ascii?Q?rFZgnACW71WXAZlLPYT09Dv/2SLG0J6TBiwZbVD1wL/S4TY8egMbDT9870CN?=
 =?us-ascii?Q?O8idjSPsHShGh03OsLkdbRkzpCM11syjnn3L7Ics86SmcARAkQuqqrNWhGlF?=
 =?us-ascii?Q?xj/OevebTjzcm/PJcDG2a/JoJ9q/hDN12IDavUHxr8OsoSyZY5ZliYoUjU75?=
 =?us-ascii?Q?U4NCNmMKe/5u9Ibv6sToA4j3VWpa3Qu/+abME36AoFPqmlzCj/tGByqVv+PZ?=
 =?us-ascii?Q?XbCrmi5EYbXYFU2iVtUaCg3DyGs2fpVjM3sI/+IGS0bJmayNCU+h0FJCFDV0?=
 =?us-ascii?Q?OuVhpPk6XrxItMe3jpKGqp/VTFRyjGoQLsHO9D0Nr2Nh4sejNEHBdqtDqZ7d?=
 =?us-ascii?Q?vXHkBULOQXQXGqEMhujbNdYicGe1/3qmtYdDY3VgE83SEq7mMxbRBaSKJWAg?=
 =?us-ascii?Q?3ndwUwaDqf7rmI28sVY3OL6belDLAa1W66K9VGsicu7BOG/vUemJRlBB+e4k?=
 =?us-ascii?Q?7lGmV+m3GH9WE2gHJABq5f0V1li81B2v3MqNDJxHIwbwnFuYn98ueOeadKwd?=
 =?us-ascii?Q?SwlhCJb6Vw9FWVELmHQ2YrCiAQfWcxulCwASPvMmiXKkTGNpCblK3HtPpPyE?=
 =?us-ascii?Q?XjBzfzRDLI5r4BKQK1K+YkzkgZRo9+9Ql+XvqVe2xHFZnLVxRwSeYtCeL1ar?=
 =?us-ascii?Q?+861rc6+Gn1YG4HZb9BwTPsrH9hKQTNiOWjHVwMZ5vAxbbmjjDN+HbAQbFeo?=
 =?us-ascii?Q?/tgv8nKE1sKCKyP/X55U0h0GzAzFTitwX1/v66UbFopQ5DaE916My7jf3ULD?=
 =?us-ascii?Q?nXqV2r0RQHp59WW4DXrjThr8k5+0ptuy+++2F1kZFMfaISSVHK3gqBS6JiKt?=
 =?us-ascii?Q?wKrsAJ9iH/gR59R1WNRSujIzVBe4NE3EJHmaERr3zgRrqlu456i9c7LfvLn0?=
 =?us-ascii?Q?57653yZLb/JJ/prHd7ZlLgyR+UPGBXsCpJ909XekYP12hrpT8Fs/8Ip9k31l?=
 =?us-ascii?Q?/hUy7ioqj0d/FVRLZiK+OYPCIadoa1T0YnwbGY/qkUZ43ufQPJ1RIp5rAwUZ?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ra2wmgWAQhKHnbFTukRwhCIDV6TmOKZRaa7O1+jzj1A6sPaIDSsJYfXkLtrYeoNWpbdl+RaGGIzTwi87LPJsx1tG1YsjNHU4OnU6/DqqOqo7Brg3Y5Z/DcRXgT4yR4xvNY0ST50FHK4NG8m+M+AZdZZmTrrfdkwxUS2ebxYXvIExYKZ4RLze1q56MMSzA9IG8tgbuxu3aDGpnrN/8PX7nw7SDMw0t9MAMJ0muPQgASD5gpGPCrtVjeVq1OvGbfcnIG3JoURan/Pe9OUAF2YZLz+dewX0osiK3XX8MYZzvSHEK8gGUG1QnKhfD4y1V9a2yKkZUUmrSbuJbU6Y6SFJ0ewtlqjkW33jhgH+SPZYraIPGKoKDl4RH+WnjQKliQoAlUBoxseZWen7CEwLxylqYI1Md4q/1+TihJF9Unq1EvgXV7hdJrCPv1HQDBve+Om+wgIQlyUtkXo713z3ZGQxzD8WWyxA29ViMED28SRtL86/Yymup4Ix/DeaCD6GyvvudZxz2tWBYAYLgH7JLcdthV6g5lMy0o+/Vak9ZfOj1dqPdSXraBAIda+q3UjVmQ3bwFANcLa4M7+tGR/alHoiEkjSUYFaVdb8jesJbpBaimE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8cd574-408d-4680-717a-08dc8944f3ea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 12:00:42.4275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVF0cu4j7a7oaW+/m2carh4rMcoQVyNb5wFRqsIdvNYeo0OAyxa+JMePW66JtKXJCoWxx0XUL63tkBXcTka851w/rBly8a84NKm5SF2EWZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7236
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=794 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406100091
X-Proofpoint-GUID: XyjA5MAmHXlKDbGuaKI-X-M52GsgZKfv
X-Proofpoint-ORIG-GUID: XyjA5MAmHXlKDbGuaKI-X-M52GsgZKfv
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_050054_855493_C5F648BC 
X-CRM114-Status: GOOD (  15.23  )
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


Christoph,

> Block layer integrity configuration is a bit complex right now, as it
> indirects through operation vectors for a simple two-dimensional
> configuration:
>
>  a) the checksum type of none, ip checksum, crc, crc64
>  b) the presence or absence of a reference tag
>
> Remove the integrity profile, and instead add a separate csum_type flag
> which replaces the existing ip-checksum field and a new flag that
> indicates the presence of the reference tag.
>
> This removes up to two layers of indirect calls, remove the need to
> offload the no-op verification of non-PI metadata to a workqueue and
> generally simplifies the code. The downside is that block/t10-pi.c now
> has to be built into the kernel when CONFIG_BLK_DEV_INTEGRITY is
> supported.  Given that both nvme and SCSI require t10-pi.ko, it is loaded
> for all usual configurations that enabled CONFIG_BLK_DEV_INTEGRITY
> already, though.

Glad to see the profiles go! Vestiges of a time where it looked like ATA
might have an entirely different format and NVMe did not exist yet.

I'll test when I get back home later today.

-- 
Martin K. Petersen	Oracle Linux Engineering

