Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F1FC27C6E
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Jun 2024 02:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Date:References:Message-ID:In-Reply-To:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L2JvZcH6Oecvv79CD6PlnQ7dTBdds23OcdPM088mkig=; b=rJocv/P5tnzmj1l9Mvr2LFkkZg
	6hPRWuF6iRI0maOQwSDpsQeLT6G5od+YfBGQByXIKFSUuCvLqwIp0Y2KXPbtyaQ5nQJ9kIYpGVNWa
	U0N8gZ1BYhICB2LZCS7Ifh8udymWVEvFkLdNvbmYVDuT/QG2+vNlXHC8xnkSyX5fxelnp5sX945bW
	Z08Va5sqy16Q2oKwcggYr6hhIwRVissdNx72zh+j+TocWYcND8Hdxx5LSavGz5OFlJDH4oEWsC8DR
	OAq2Gok3m+wK9C77EqafcBPTKwACUtVSlNnuvs56/zqQkoXry3mVlSQ04rj83XYJj1b26r6+clK0E
	YrcbmEWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHwIq-000000014Rq-01No;
	Fri, 14 Jun 2024 02:04:32 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHwIm-000000014R8-3EH6
	for linux-nvme@lists.infradead.org;
	Fri, 14 Jun 2024 02:04:30 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45E1fUsY023012;
	Fri, 14 Jun 2024 02:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=L2JvZcH6Oecvv7
	9CD6PlnQ7dTBdds23OcdPM088mkig=; b=BEDOrRJsosK33LK2nhJdZMqj9dvTDx
	jzJx3hajOwEIreJrAHmOSV9QKhsClJYeiEko0nkO/vVGkFjQKKVbAXsHE4z0TjYY
	BhbiIJUhLcNgYdlygq60Hxx6GT2YSTtrgwDacET/SjSyhPYwWy1/Yk73hK2SKMZt
	i6AQUAMil+sBb4IZy4sflKj/VuuLfiDFDvo2RmaBwye0zP8n4Q7i54Qq7TKxs1cb
	kqIqsT5geX7fVdPG92xtY7Z7Yq6dWLxbuPzcdT0srQ7Pj9lCDFITnJYCSAmJ7kMT
	C1okmiH6Ez1xwBnincSWry7lGvkD2Schve+M9wyUMmOyd9oiHsktCa4Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7ftnpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 02:04:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45E09Nrx012592;
	Fri, 14 Jun 2024 02:04:19 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ynca1v7u4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 02:04:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLrA0/mxhlHBamdszcG68C2yDGgLk5V04IdUJ3+g0dL0Fuw/N0iNEA76yEs+u2wALiJTU3zwQaHs6BknkMDOs5aPvBhYIlu80XPwe4mBWNxARad/jhN1UtTSmnSecPslZ2ykYVsfw748eBqgpe/9p4AIeTjc9C24FQ7Nw49XIiXPGXi6yvcvkF5pEwI2RLK3yrqYq92OI1Z5O/KqMjfpt+Aaku9HIqb2aWynRADE5q/Ta/StI9tRtrqu+fkRuhZMegAi8r3+kU5zUBf+N4E5OpKi+5cHY7t2EXM8Os8LmmqdeB5J1MLiz9WQk0izyxK/xG4x2VgBosenBiiZuQBiHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2JvZcH6Oecvv79CD6PlnQ7dTBdds23OcdPM088mkig=;
 b=ErQnm++PVuhffDIDq08xPtVgajBZEuGozxNmKWeO/UJXKMvU//1fw/gHVRbVZT58r9lRT4RK0LqF/we3Ru8wWnor1ra6+EEPqtN0OwURBftmJDmcs4nQhd1b3PUIQ8Bq9ae7HOnmy7SB1XSaW8fr1TAjp2WAmL90JJny3uC72hrYZFovbpaQOTPjGLws2NteRA5c8rNdBeknzWceTvAEoPRANdUcI4ZkapSJ2rx2xsAPnbcAkolKX6F4cZ2bXe1lZTmRkk50NSObteyJkUSKD25bhz+wabs+nUMW1X8O5RxqqO7+agyaasNVAh9QjS+jPdqXoyqzfQ9AIv+l3ixi+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2JvZcH6Oecvv79CD6PlnQ7dTBdds23OcdPM088mkig=;
 b=zKi7ZFQc3rM81ALzi5Eu6Y58yMegtxYAiRcnMoGALrtNT5MvP5h4aemexj7pWi6EU1Z71zLA0RLb2R4OJZ8S8N9zKLNGu+s4yo/3HC8gYqnk5pyy2OkMCU4tE9tHvgZwHjSMxd34aKlmHJ/qGwxsYsZnQb/iUqZsLqkfunI2Vn8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB4607.namprd10.prod.outlook.com (2603:10b6:a03:2dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Fri, 14 Jun
 2024 02:04:17 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 02:04:17 +0000
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
Subject: Re: [PATCH 03/12] md/raid1: don't free conf on raid0_run failure
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240613084839.1044015-4-hch@lst.de> (Christoph Hellwig's
	message of "Thu, 13 Jun 2024 10:48:13 +0200")
Organization: Oracle Corporation
Message-ID: <yq17cesqnzk.fsf@ca-mkp.ca.oracle.com>
References: <20240613084839.1044015-1-hch@lst.de>
	<20240613084839.1044015-4-hch@lst.de>
Date: Thu, 13 Jun 2024 22:04:15 -0400
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::44) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB4607:EE_
X-MS-Office365-Filtering-Correlation-Id: b58ed1f2-ddfc-4712-a761-08dc8c164bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RjBWnDUUFyf5BjDXyn/L3Ev1WYyHYzSCoXDyCdK3HimzG6KRKG4Njtho+PpY?=
 =?us-ascii?Q?wPSUZacs9u73Kl3qVBpIIxIlvQeXtkOXj7QBm+EL5ycafAZ0LNTZ9BICWTLW?=
 =?us-ascii?Q?WcHOW8ZTRsD2WbYH3Sq/+v1RHvvGUzQq/P7QM/livI5QhLrT3/bod3dMHyjM?=
 =?us-ascii?Q?MQ5gAYdff7VMo9IVWNj2vFxxdi6AR+cvtM9ZvYBio+7+hbm1DVCz7yAyiEkj?=
 =?us-ascii?Q?e2fa67FY0wmn1I2U12w7LxnQ/SJ9L1MyibffnQ/qBA8uBeGgn6nrroJBov0/?=
 =?us-ascii?Q?K+2mFJAU+WJ/6ICGZjD6HzwawnWr4fGVCryUFs9a/TQR55mo0eAaVNBoEa4U?=
 =?us-ascii?Q?URQnVUMQn1CbXC/3NkwTcPPLMnRZBEFSApU+mZNiRn5qR5zVisK0LpgF/Y3g?=
 =?us-ascii?Q?vFpisrRmjK/iGQpIRPEZxs421Wbzk1yZLGo1rWle07MJUh1x/xh+0bHuxCvi?=
 =?us-ascii?Q?OOtvR3XW+Udo9A3TSRzUAN1x20dCWKThaJ48WQoa8GAQkla5rOVXBxK59zCq?=
 =?us-ascii?Q?bmQOaHeTDWvXsjqKuqf7MkZQQ4QXaFQRmTpf1TK3dPBkKgW1EBMiP41Fi5ft?=
 =?us-ascii?Q?ZzvwGVNJhKCnOKZaEvAmzpliao1PLzHe37w/bFDZTvWuTTA5OKkfDPrgg0Zy?=
 =?us-ascii?Q?ONAXYFMjJxTFgyUu4+LXpF+Ve1CGIXGuRN7irQpKFfb0gsU+orsHM32/BD3M?=
 =?us-ascii?Q?d5KqzLWCzhZMQeTtMjld4quTLPYMhYd/plQIoApLakDcpwk08VoumFbZF3Gi?=
 =?us-ascii?Q?B570JoeA9OsPju6Uzd7NWiKptYVRHmgx6Lgj3L+Iue0CJSsO2d0K4fv5Jg9p?=
 =?us-ascii?Q?oZd+LusJRNWnWo/0FlHDfQpYv1fFCPSqCnn80OaQYHE6x6B7eH4v8wIgAZVR?=
 =?us-ascii?Q?Ias6bBLC593PAEjopat32h8xb+RDc20iEiNzMA2WZgfMpuXzcCdLGpv6dGIK?=
 =?us-ascii?Q?e8lvd+W+DVKvdI9Om57tjQmF3Szj9ARyuMFM9yPuts13H9bJSsa/cYAx4hpN?=
 =?us-ascii?Q?TiApVpZ0Jqx12x4LV9trdAm2nCd+QsKN0sBAE/U7Mt1DjaVZtozf9vVtXqgy?=
 =?us-ascii?Q?NvRjDmzeALSGWpBpWaM+08YbDIuhQvpzJim/T51Ch5CJd1XtGG2Zu80kmXPt?=
 =?us-ascii?Q?n/LOPy8OKx7x9oslg1Iu0Xsoz71MRkorFRegVGjaDONMu7v7gdyw1lUciO7k?=
 =?us-ascii?Q?cWgRoofE4IupxvbWee2S3q+/fWDh5DZXuUX5VvrvqWbH+8cBH3ZzPuPZYUJR?=
 =?us-ascii?Q?Yi0T9hifZ2Dh5UVZTc66OE0dCqMpVv7syR+9y4M1tWwzb5hTQE8VQRgrCpLq?=
 =?us-ascii?Q?/HQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yzxENA37t4S2ykp/XZDl/MxkSf9M8CpWKwy4csziGefVli77sdJQvHqw6LB5?=
 =?us-ascii?Q?Y9JuUMemlvRxuYRCmrMreb/JTzWpqE5DWpRVsbeLVShs3D41HlkuIQE8RxI9?=
 =?us-ascii?Q?3M3faQxHsfQahHOSBF9q+BTua+udHBWwoj2HJNPil1PayjIJ+wPYPNUfLsvQ?=
 =?us-ascii?Q?+EQPimZYa3E+DyYKnTgP6/U+Q3LZ4058enFxZ2ykq1fu05uscgp15QcouHZ3?=
 =?us-ascii?Q?zA7dhK61JdgCIr7PRza5+FEmm4fzmMSqP90PPBqlRpGB9R6NeG2vUx9YagpI?=
 =?us-ascii?Q?Cpp1jog9MljRT4QSD5GpNd9d54cFk4uzBTNVt3Ix6jfwJK1XdDBONmExWtmm?=
 =?us-ascii?Q?FoS8nwly8OLnbua1ncQZi6QpIMZ5j03EBjYedgYU/+zM1t4zSjSzuA1MOjOj?=
 =?us-ascii?Q?LB+4OU/huYbL2NIHwSKvt7i+yH/fA0SrlQatSiYl0choIp6va3pJXXkqYNQ/?=
 =?us-ascii?Q?O2/IAdWsAsF0sUtI0kYZav3zZZTODl/23//E+aCbIuodQ3j+Ur/kDgxEecJX?=
 =?us-ascii?Q?B7R+C6Ut+kcEwHVNtzxpX5dsqVi/oClAbYqXT8liMYI5CBYZjl3xW7u4G4CF?=
 =?us-ascii?Q?MqT0CZMsDkZ92OPyqtZYlYCgJ5m3ufoyP8Sl6cvMLjvmi9CgLyUZoks1ck67?=
 =?us-ascii?Q?YPFVY+6yvFcbn991hZ7dXngIujVCGue14K8jy6aTb6I3Iq2xehzclZWD9mjc?=
 =?us-ascii?Q?L6EWf40fO/pwaEgqHgMze6qLsJjNl2DSsGwsoM4cUnIbDHcvKzRcU/N0EVKH?=
 =?us-ascii?Q?3Juiogl2yGh1azTtnUMeIekBt1vAtCllTDnhCBl9lnSl0PsxDDkYHGtYHOeQ?=
 =?us-ascii?Q?W0TExv/40eD5paqHqCEXhe6J/i5+jakekxH6JOJpRQw+hSrakamzfcVcoqNe?=
 =?us-ascii?Q?tCMVjbZ0Le8puhpvXuI//YeeP39PFHZKomSYWy9Q9+pQBd8j1UzYC+q/Yq7S?=
 =?us-ascii?Q?7O1kArRjkR2nDItchXiVo83F9afrZBqehPCjFpZiYSw/46KNhjdi8X4Ii7/W?=
 =?us-ascii?Q?MfuHzELMrCImLMBO2AWGNzt0fen3gp/na7l2c6Yq/z7uvS5iGGsRJn881yqX?=
 =?us-ascii?Q?VGNrWtYS0DeQLuHSkpqr2lsBs+OdVYCgrOpjsUGKEbJC+LadI6XZrrPDTC8o?=
 =?us-ascii?Q?HSdCxGt9ksADIxQAxN9dENNOPB9ndojkrthSPze4Pf8HZ1xECaTEeGgSz2bs?=
 =?us-ascii?Q?Knir+L6P9e3w7nCO9YN7a9ZvFMgBCthv5Szg6ab/07mprWMMtrUa+oeWma8G?=
 =?us-ascii?Q?GlweAfHpd16KKztjM1TY82ZB+H1vdaP9Cb5ovSZGXBGJvyhB7uJHB8VDzvMq?=
 =?us-ascii?Q?PTnDTOUVzPr4hIbg89Lx8LJTzXPMug0emaIatDnofrt4KOabMaENukBH/Zot?=
 =?us-ascii?Q?Pw0VgkzyUFR5Jh4z0n9O+8SwRGJyQcg47JDz+bHbsfYIud+UnT+gU7h2jhbm?=
 =?us-ascii?Q?Z4HfO6H9Xy8wWKBfYVkdS1evqrQCnmjhSgz+fale8mNwUMGHVyW3iolY5xDc?=
 =?us-ascii?Q?MuY5TCdd3WAr9kYMWkpvyUEuUJxxBSYhgCCDDL6qXOMmZZXJdCviAPr662Zp?=
 =?us-ascii?Q?WTI8zkX4OcRp9YFHGG7qROICZBeu22AWPxnUEI2V1v0eYEyCC40h+9auylqq?=
 =?us-ascii?Q?uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aExFts0B8QdSnsZDRLqJoH/hSu1qJnWMLfMJAXDEHrQc90ki2qOsPli6n7O1QAtp0lKIFurLyzyM2JRsQXR1Apmzl04xO7kRndmT79eGa1gcPagjg4HZ8TRpoJtFqQLtbm2Gn7juMHO3ggyS0fZ5xdsH748h4etu2d8G/YQem4PIMbpPN1H2M900zw8TFqRr43qm5VqHx3a/oe8tG9PjX3UHnEqE/MO4Mu3ecPZjvzqfsDcrChwEWgwJEDlAljdt+CseT2ZymdGnXT33w+33sg6L2Rt4qXoKJ0PG7Qnh/O1k/gBpXSM8/+TC71zhvuCHhUcRPP5cbmg1l7uRWXXdcJGKsEr2wNLC5B4gNUe1l1MpGESQDUhITAtpdQG+Gzq5u91WlIxsB8mw07egmFi2rc1f0UQe/KJ4zg1eS4I+SeBgZfn7kP/bd16xEqxgMb/6oPqCkF4ZY6OHAIQltY04eORvDaWcmnh+KOsDZkiLIV4TmRNC8VG4Jw2hOmak8WsGAGHOrfO6oa7U1YzzTi5GFFEMeiFTaZqj8XEaPZpEiqI3v4XkhMHYukpJZNstSw/TuePhl/GxR0WNlgh2uU7hCC2a6SNubr2mQbgKHEq3EW8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b58ed1f2-ddfc-4712-a761-08dc8c164bf2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 02:04:17.2015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xgncQxtr/4Ai4z3BFXEjgmVH/+NEk8uAbQJRxkC81Ao9l+EDCxOayryGz3Kk84i4EdiU5Q2jcJfvVcqt/zKpNj1ZRTrqgJNAPmD0V1FFAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4607
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_15,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406140011
X-Proofpoint-GUID: sHlayv2_sf9zY2mLevdo2H5R2nZlpBjU
X-Proofpoint-ORIG-GUID: sHlayv2_sf9zY2mLevdo2H5R2nZlpBjU
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_190428_831478_D8D54010 
X-CRM114-Status: UNSURE (   8.48  )
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


Christoph,

> The core md code calls the ->free method which already frees conf.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

