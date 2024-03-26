Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8382CC6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 13:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GQqyK93YBqEEnd4dsp+niPoiL16LGfXp5Dj1i2cLIJQ=; b=hpF8ttfExM/gw0x9QeiTkCT/vl
	3s93A3kOmL48RTx9ZfjfrGrdmn8Ab0RZDdXnnJTh77lnb91YhLRNsF45vOJ0drtrTV/hNXVBY0/Zu
	ogpb1duRgOj1xK3iG2p4siJCXO1x/iN+rwekgSmX8tvaBGlFZ3am/k+BdB75VTWbKZtFrURCmrM+U
	h9YPzhkOYK/aJa8bvvpo4VA2xWmMRXr3N9/af+rYk8hcd8y11duJkMpDfrLX6TdP03Ctd42/aOJ/J
	E5a5MssrUlxkaTjBt2eIIoK1i7H2NbiiVLky9PiHGk7GxMay296O0ez/Y1ZgRKa3Fj8xJsda/Be3V
	zT1qfOKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp71X-00000004hcQ-4C6q;
	Tue, 26 Mar 2024 13:39:32 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp71S-00000004hZg-08VM
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 13:39:27 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42QBnSMp009002;
	Tue, 26 Mar 2024 13:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=GQqyK93YBqEEnd4dsp+niPoiL16LGfXp5Dj1i2cLIJQ=;
 b=WCm2MeW4JK3aA33fT/DeN2saUXlFxK2WI96f21MqWnhLFrwr/nnNuaSX0beSK5kAL/yL
 fipS22UkUur3sdu+hrpGQuGU2DedHV831Ji3suZ+lBJKK6iTxI7eisAp0SkzQBUKqYGi
 FQPWxgujTzu8VAgKgHGRwkypXoxMt+3RgPRcFnMm6nUmkfDgQS1WXaZ5Y6ZG+bas726k
 PvJSn+9gVmJPMtljdATEJacudQqcN1St+9sg5dHNvw/wLxpz6Q0Hp73b/QryVe5rvF35
 /B2IAKq8bZDfzWe9Alx+KUETgam6miiQLLzPDhDj18SO4ZdrHyIFsRdjQmh/tx86OOur 8A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1q4dw1nk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 13:39:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42QCMUGt030865;
	Tue, 26 Mar 2024 13:39:08 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhd8mbk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 13:39:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2G68ux9nrYESTmoaBlVzeYOUCmD/xZeYXCON7QsE4NprbChwxdcUZXVhM2V33MHrdOHoYx2Omq9YRm/04/xWLOWK/gnZK86I9JUXco2QcjbJ8/HqhwDc8X95O1sZbAzH9Wj14OQkQKgPpFwXJD10SIxchEzT1vOgFLe7YagwriVsrXua3Y66jMdKihJYSAI7h/SmXxUlzf926sOpSqa6X8f7+b8mGa5T07lOujkB0GH/hAiuRhNgr0bG0cqgJMFzu8Zv+UlxmQtu+/JQYKieeyVQqp16Jkqlb/Ibzln8juCTV56bSU6AAp0rG7FVYMbSt9n0QY8TaTShTNcLrv3Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQqyK93YBqEEnd4dsp+niPoiL16LGfXp5Dj1i2cLIJQ=;
 b=m2erO5on43cpy/iCSD0+cSL7kuxyZEst7w+v/GEIwl1zRayvZg1WOl0Oa3TfvI9dBbIL01htj0CNtpDDsbjI+WxeLSklJKTI73+aWTiW3OMyoKnjiW0e4UJ4X13Cx43funyEnjKdm4CVgX7FXUEWAWFKH6OIb3ANvEqjlN8j2z0QdmVkuOv6X/Mmk4HsvfGDS/gI8SFA/W7q0+D++8u/AX/hvpgJlOXyAYCj0otjKmcC9RT6Xh70thXRYzru55U6YiDq0zQwJ12QdKdfolxDzRY5h0MjeFR8hh4UpF9LzeZb+Co3/BmrBXsIfAl933ML485JzB+QSoyAIxD08TCDXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQqyK93YBqEEnd4dsp+niPoiL16LGfXp5Dj1i2cLIJQ=;
 b=yxSmeziN1bjyJMI398F8hUIHTf+Q50QDm8cJ7BPCOcu9D7PWZyPQ3iNPePXDp+/fCOk6K81RA08RJWo+b97X+1cfKeZjWioSRVLgn06SVA8LFQ4cRla4hJ3zvb5UzQjdGFSieQVxXGww0VNnLI1I45nVOgAvkhWEposlxqrwgyY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SN7PR10MB6666.namprd10.prod.outlook.com (2603:10b6:806:298::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 13:39:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 13:39:06 +0000
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
Subject: [PATCH v6 01/10] block: Pass blk_queue_get_max_sectors() a request pointer
Date: Tue, 26 Mar 2024 13:38:04 +0000
Message-Id: <20240326133813.3224593-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240326133813.3224593-1-john.g.garry@oracle.com>
References: <20240326133813.3224593-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0009.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SN7PR10MB6666:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tn9lz3p8s7pnxoWlRxbTVKs8uGYT56mMIioha5GuCRLH93mb47yHqTXAc/BOGaWA/Xx+R5Wgn38hrEruHR/dRUk+xvo0LNziXwmGItTjAR3HKdjnE2ZBOKHuqRZoIs8X/HW+XWvlwb9XuGjm1ct6brmLdk45bxeyZRxIJOhYwPQyJ0cxzXxcOOLaqtWZIjxuq7CdiKNeoUJSR4Xv9tEZCjkfTgkFKAFyoqw+CaBxueqa7m1BPqvKR9Wb9KFABjR8gvbS6Nwr1+6CcyNimUtr2McWIUMF5gpbr42VhD6NBHI1uBXJWbYYFGhXYwsbzlYTWktgikTrLVVUUhkVhAqhc3qs3JHtxuIrZDwXPXvbMBfzrEqWXr+AYxU5KazrSrtCHqa63xCDI5RbAnxPy16Vwq1oT3JWEBBvRkZTIttElQPafl6dBCDf7jHN+mGYo5uyZSg+0X5E83LzhARS0Talg5Lf5MNr4xVO5l4JaIBQlFQEDJG1vGaHeLhEoWNeKCRWxXA1kdBnWsaLJXBANLuaLm/J5h+PQwzGqA2J3Wt4rAFIhovFpY+EP7gujS+GdDh24Q0mnaHRQssLsrMf0HN5u/r+BlPipFwRGM9J0aaZQUZDFOErZ353gQtRW0s5wnRNDbKXqA+zy0NG7v5RKLF8vacy5ydUuctU9p+0u8clc5HPvePxq7VQ8cGAQTTA4qbXp2KVZqrl6gtqOpz5kue5wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tBWFsnwgiwQsEcQ79GDU0x+qtUxBAmhhZwRKop2/zoMsdjdW3VvlvYYJOM83?=
 =?us-ascii?Q?c2BLcE0ZJWggqmkHwmS0/rktwHLv5EJj8QZX2XV7OcrrbQlDMS8O0BX4la7M?=
 =?us-ascii?Q?yx6IH6Y8LNofNLTTIJAhpSVwUQ7Xayc25hoLfqM1c4upnXpXkWAwu559WYp9?=
 =?us-ascii?Q?WmLyrukTwG046wI7lE+vFSSiPtdbg3ILRlKvzENC15ZBJOA/tGC025BidIV6?=
 =?us-ascii?Q?wIhEMCDFCwd77fU2BMT8oUi0SxsWm9XdCuAjyNs0QZL1LCkRKuWz93O0+9q/?=
 =?us-ascii?Q?XwA3acA1q503O15QvYuT783d4R0W6F3UpmSmId4Wd69wEm0ntuzzMXbOq0MY?=
 =?us-ascii?Q?a8H464r6sPROWVRyLtOSPn+jebqMjrdZVMdY4eYJ6JPD19O4AD0iT8zaRtC4?=
 =?us-ascii?Q?Nas39c5E/VdD9c8Rkj+TtgGmMaX9tAvGJ9BkAM8ufpwnzYJxn2eiHPClWIkd?=
 =?us-ascii?Q?BrL0H6LfK3LVt8OIsJuhS1+HaU76ZZSGBSht9FB/u3ApNYgYpQkXLsXm6UBa?=
 =?us-ascii?Q?aOx6EKgKu2ABhjx/8a7cyDJTGBQJVu8oFBttAjpB7IuJAnN1SeDZPK44yHiP?=
 =?us-ascii?Q?sQVhZoQe8+CXlM/21l34HNkm1REOYKv89xOql9XYrrSUlEDcfvu9zYXHmvkQ?=
 =?us-ascii?Q?lpAMVkC1eu/uR97dmJH6Lb2r3H3mMIrj7o0WqvKesDj8bZElxRyywy+ypIJX?=
 =?us-ascii?Q?Swevj7ICSoVMkuAIk2AMOF1uPyUXygwfANguc6tG8jpRPT4OirevP5RrxUtQ?=
 =?us-ascii?Q?Opguk6CWiPEElXo5bLcAhKaYJFDw+tHphuHdMxqAnRVxc97413a68PIqzyQE?=
 =?us-ascii?Q?ZJPcF/3SwsIk86jsFKX4JVaHtWWAIIDfuJEEt1ffUX+zwYsO68O7nxcrRuyC?=
 =?us-ascii?Q?QqfQqSzro9BxIj+hA1dvZTZfEF/CuMSw/Z4vNB6pqdMdF3OqHBCeSRjqT9/p?=
 =?us-ascii?Q?EP35ygrcR/Up7HQhNG7aZ8MyVfp03oZ+Fw6HUolBfb9+O7awzwZCzQtIth6O?=
 =?us-ascii?Q?hUmAxcKPF+KRQpRSdMtPwcv0n+w1s0rzdygIky++3BrFmgmgdLzVS3ViiJmq?=
 =?us-ascii?Q?euwAwXSf9aZWW0oDadUygDgbd0ODaH+hnX7CBGnUyqvMXzahoI1GiqMY6Zll?=
 =?us-ascii?Q?Y/Qv5TMkg/1s7M3fwH6z7ifsPCBTqCVNrFox/s8xP3X5Fnd1Zu97Fa23l51M?=
 =?us-ascii?Q?l27HWx7DwFZWwr4KdyidpCn9aLjKzFsh5/C/TEj2pzq+dZrAVN3MOX4whbDA?=
 =?us-ascii?Q?b13l2sG4GBpwYGU2GJZH85hfqGFoNOvZQcKfAPWAF9EJR6Co2Xz6UFgP1+g/?=
 =?us-ascii?Q?+kqNVFL0zDfWyYn4J6QIbsc8mTdsSTuQoNMTAvh1zLxiwkW3751eR3QYEsjU?=
 =?us-ascii?Q?0WrvLhbBQEJhEJIqlUR0F/q0zDyyxryKOixwu60kC6lSymt30BmoOagZotPT?=
 =?us-ascii?Q?SKm3JhpuaHYAhICIiVpqbT/Py4UbtLSvlxbxzecutxDvaJKRCBjMkCzC/Y6s?=
 =?us-ascii?Q?ayaqB2+LUiDIRneHwnSEKm/fOUm0+ZyQeymfnBn4iG9OpEMSlJoNn6XVLbHR?=
 =?us-ascii?Q?Nr7cIpfqTkbFQnx0Xv5BsrJvH6TT8lu2GXWrsJrKbWRCgPXlhle2qocVlr7C?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HjV/2UX0mmdMWwyBi2hGHGFyYMYWDlQ70OOqg2nc+NtndwlaCLuJqVUc55URlMNGlLAzI6vk2XWeK8CQqzPBFlhX4xq/1NzgXe0YngxjK+svQb0Evn+9NWH4hlJOKxjn+npzvmD2ukVI9NO5kLrCFX6ZNV2PKhJGmAaNb1XLf13RiMJ1DFcssoMeWr/rMhhF9IlbsMzN/QoWEYX0s93r3L3zjpjhoflRyNVjOY0QPIpRQOhh5um3dxn/hGL23D3NEmI4tVGu1dVTFYymaafAdKCDBr0rLa/iLXEw6d/XE3ZAKTJAj650sbrd0DPQJod84KknH2iRTQ6GBipG/eFR7Bv7HYnnYygcjAYYvHgZj9nSdDcD0KXXU2vQcHdkW/TUS+pXlA05t1nTsppThSlia2XzPKzQB++jNI7fwmfgyy5wSugNu/LuBuAC1IZo2W4uIwBW4WASMx0l9+yWGSqbkU8hVUJhrv8Q1ygOx/Sno95iWpp20ogxpsE5WMdCTw62UkqlC0N9ogcurRC6hc0JyV7sQZQW3i5lFav49IhGgvxZ1YWEBGmVOB2RyfRgb6kyPydBs8t93jFD2zGT5qL5squMm8kWZ0zmVxQOvF/f/UA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e389bc3-994e-4152-ed0d-08dc4d9a1b69
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 13:39:06.1809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: njMh0NhBJW8OTH0WoS7i2dY7tIso/wvNLl6GmZsQdPZgPDjMom8Sm16UGJupHZH9y1JO0H0mZ9tOhtbO5uW8jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6666
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403260095
X-Proofpoint-ORIG-GUID: c6GExGfEpot8w4BCmWoWyrN2IoL3kLt2
X-Proofpoint-GUID: c6GExGfEpot8w4BCmWoWyrN2IoL3kLt2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_063926_203422_CE0BF22F 
X-CRM114-Status: GOOD (  18.16  )
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
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-merge.c | 3 ++-
 block/blk-mq.c    | 2 +-
 block/blk.h       | 6 ++++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 2a06fd33039d..6f9d9ca7922b 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -592,7 +592,8 @@ static inline unsigned int blk_rq_get_max_sectors(struct request *rq,
 	if (blk_rq_is_passthrough(rq))
 		return q->limits.max_hw_sectors;
 
-	max_sectors = blk_queue_get_max_sectors(q, req_op(rq));
+	max_sectors = blk_queue_get_max_sectors(rq);
+
 	if (!q->limits.chunk_sectors ||
 	    req_op(rq) == REQ_OP_DISCARD ||
 	    req_op(rq) == REQ_OP_SECURE_ERASE)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 555ada922cf0..5428ca17add8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3042,7 +3042,7 @@ void blk_mq_submit_bio(struct bio *bio)
 blk_status_t blk_insert_cloned_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
-	unsigned int max_sectors = blk_queue_get_max_sectors(q, req_op(rq));
+	unsigned int max_sectors = blk_queue_get_max_sectors(rq);
 	unsigned int max_segments = blk_rq_get_max_segments(rq);
 	blk_status_t ret;
 
diff --git a/block/blk.h b/block/blk.h
index 5cac4e29ae17..dc2fa6f88adc 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -180,9 +180,11 @@ static inline unsigned int blk_rq_get_max_segments(struct request *rq)
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


