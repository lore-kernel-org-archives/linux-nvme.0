Return-Path: <SRS0=GOb3=P4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9944C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 14:41:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B65C611AD
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Nov 2021 14:41:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7B65C611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	In-Reply-To:Date:References:Message-ID:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lba1i+3EweD0JNXqYqZ2XyAKwi79iCSi6MikuOsocRA=; b=iFOik3i8Xdr+zKoo+d+sXBCvzK
	LrcxQIoFtOXKsQzWUNgMuirI2fk96u/GcrFALopzajP09McXdzlCESyAAkzOrP/zFjHpwOBy7ldi6
	OpbovHC8opSfM7/ikcs0wMirg68KpZ/0xR4UNktrz+WaeJCI2QCwJaZlOmyBDkelgYY0bBN0NiO72
	uXu+Yv6dUeMFXPsqF50pMjBbmeiYhxEpnkZodbkFdJA9/rDsmoLre5HWo+HY3EvUy2GMpRqMucT/W
	aBhkdPRYNoiOMe8pUvSp+kApdaS0YZzXCyZEnudRQMmQzpnytsdDb+U+bQ25ZKZ/myQbrlmyQOWO7
	YY+L1lig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mkSJp-002RzH-GF; Tue, 09 Nov 2021 14:41:49 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkSJm-002RyR-G5
 for linux-nvme@lists.infradead.org; Tue, 09 Nov 2021 14:41:47 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A9EW5wS009031; 
 Tue, 9 Nov 2021 14:41:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=lba1i+3EweD0JNXqYqZ2XyAKwi79iCSi6MikuOsocRA=;
 b=i27wUzqVTnB7WgMAPD/QrAXbcvnLrXdj6Rp0rRFuvPqIuA9mQCv2eWV0QcwuZAPYzi7z
 RUa5zdPoj+5/sKbYirfzZnG4In2Lk3JcDaYyWy3a5h5Zik3v/N0HDKfPpkW5PH9hJfgh
 c7kmSx8loP7Kq1Gw0/YiLPZxMedwnFuA1zWp/cQIGIgRNqiIMtj0Jw86jc/XAet5H+RR
 W0Us+8HvFQiMLeHFCvKhwkn0pyIf/YSrtB84g/RIbAvfjq0gaaYJAYtqeixtyv72cklw
 Jlil3g1afyh/+bIfaLSNGU9wjEkm68VZYQ4uEWONFLlqEy72bhOjRa3ayFXKefrF8x5V Mg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by mx0b-00069f02.pphosted.com with ESMTP id 3c6vkr3q9m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Nov 2021 14:41:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A9EfN3Z162899;
 Tue, 9 Nov 2021 14:41:28 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
 by userp3030.oracle.com with ESMTP id 3c5etvqvfy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Nov 2021 14:41:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlTfX16ClGIytsGdHZlHAAn8oVX5i4kO8M8O/RCfStbId+hCm1ZFoGRHfhDUCZgD+KX5x3nsODFwPcxBYPUjpVqM9cSKNrBB3f/PyBPUVn8Osr4G/Ecy0XZB5/HXvQzSCN/ba7Ij615zBaylIaSSk+CKUYbXAHN1lhvahSuNPcLFoIhRkiqRdZdDBih2VimxA+POT6COOoGOr+7xdvWlKj4hVtkOUFW88toPwfzp6f/rZHi4UCcex5D4CNSwb0gRuokoI7zFNZpLvxyd2C8gVivmswX6mD9z9BXZmhl6U2lXDT05Pl4hKwW3wW+G3GhQApe5GR/0PXTgnDgMbemnwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lba1i+3EweD0JNXqYqZ2XyAKwi79iCSi6MikuOsocRA=;
 b=eyQHCUr9D0sbBQSWPbk1R6Z9Q8ljx3IZFEXQxF3KPniuitJGEi0b9LAqi46U+BwGaufOapdac0TwJ2zQvKA+tSaO0/vrnjYATulkvNR2VnBpGCm3QGZh61Qfn8OiiwZXNT0mq9w0vtqSIWNGx8Tqkfbh4Dd8zpMfA8llZfdYgee9M3r6TGIEZZuy597eYWDn5DKE5fOaDEOIp7uch0L8TpYkBGfAyy1nClfjcaJRcwqNSxkRJE6BM9UKjHKGKk/dixNAsGBTMRz87P1xMDBUBhkHqnSv2ANlSFPnt0Z+O4KN2B7K4dpJrji6pw2t2vKyFWGqzEEfhauIP0QTQHlzHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lba1i+3EweD0JNXqYqZ2XyAKwi79iCSi6MikuOsocRA=;
 b=kuecV4HwXBrhAQaFtTD6693tfyOgvt4M+ihFCTP89zzkXAQXxZ4h4UirchBxB6r9uaJnjv9tXxedIxdLvhV7GMFQW+4jQ2w/MazKaaNGk+RLL7/hKOMs6fKGJ2aE7rwvuZNc9QLw8QCJL9PUGAhglIxXPB8sg18mlboQ1qoC6ME=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB5878.namprd10.prod.outlook.com (2603:10b6:510:127::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.17; Tue, 9 Nov
 2021 14:41:15 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349%8]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 14:41:15 +0000
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, "Martin K
 . Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH V2 0/4] block: fix concurrent quiesce
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle
Message-ID: <yq1fss5jssh.fsf@ca-mkp.ca.oracle.com>
References: <20211109071144.181581-1-ming.lei@redhat.com>
Date: Tue, 09 Nov 2021 09:41:13 -0500
In-Reply-To: <20211109071144.181581-1-ming.lei@redhat.com> (Ming Lei's message
 of "Tue, 9 Nov 2021 15:11:40 +0800")
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0019.namprd15.prod.outlook.com
 (2603:10b6:207:17::32) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.201.57) by
 BL0PR1501CA0019.namprd15.prod.outlook.com (2603:10b6:207:17::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Tue, 9 Nov 2021 14:41:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db25ae80-9b4a-4e69-8412-08d9a38efbd7
X-MS-TrafficTypeDiagnostic: PH7PR10MB5878:
X-Microsoft-Antispam-PRVS: <PH7PR10MB5878C1B2B293F484DB1FDA328E929@PH7PR10MB5878.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V4M+3Usb+E2Ri90OOsU+hFUS5kTPRUX28ruM4Er//LO7DTVbwV5+t0+GzE84ulKlGGRUTw+bLJ1TmbM/r3ka0gNGVt+6lKy8yRH3dowWqjZLblNxs0QrwLu3kD+LRqgehlE5i3ZKS1ktv6CzSR+PH2sEEc7MAMphXQsBCKZryIPzRAELf+GLVrC7QsjSbc5cjiAYQnz4a8yl5DkJHCdnz9SabIsb62eQNlEJB/Fe0DHFsjgRZWjr4DQG/CYWG8R+txgP4G0VQ7mD90nuxF14maM1Lw0o/qMLEk0WXIo5AkhYAjqZTNaJyjV9C1+Qke56YKaY3bPJyB0Ku5S6SV6ics0n810edttkukyvAYeRpCD9pFRmueiE9JESOf8vbNaTi8gw9SkUsjgJKAbGM2ylFElLDXt/FBthCjSeTFEtdmWnX85jkyStY0wVsPIlbx0eD8PjjDc5rExvT0oB3E64jsWAAjU/vASGqz3Zdq35qQKn0nAE/vsuDWkBHu19NKjEpDc4f0raFT2y9XyMl4KNx841OdDNsgiWD9FU8Jcdy14wWbsJ2a83NEOwsfndJ3H9uu7mgWpgVIwlOudWHkjJK6MsWcMrLFr8uQKBHh0vl0ogZOeGas8hDEYQUqlNKwU1Vj0qCrt+iacWmmO2xf7qgh8Fx+hUOKeFLsn6HHDUqtkynEU4tmQsEUVtZ0gNVBztmEf5gp0lCfAlfLHntwwxFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4759.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(6916009)(316002)(508600001)(2906002)(4744005)(55016002)(956004)(66476007)(66946007)(66556008)(36916002)(26005)(186003)(5660300002)(38350700002)(86362001)(54906003)(38100700002)(8936002)(8676002)(52116002)(7696005)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Rn5hN+32VD2m/jTEchcXuXB5lxOd/CaH1DfPBKv0yN7EG8X3idEaL6lTzUs?=
 =?us-ascii?Q?l3j+q2FJEwglKorPgVvIv0PGF2yaD9jChDyoMjAIQ9qvrocEyTg1plm1ONXJ?=
 =?us-ascii?Q?XYlCWsMHQtbrnhlZFflZqF005NfiloOG98tgkrTLRT8OZ6yUkcoqAC9w8wvr?=
 =?us-ascii?Q?Rg+EspdPjRQpkVsE/Ie1vgHEJJawdnPePDZ7oODTVBQKqX0SfJARrfzbcAz7?=
 =?us-ascii?Q?eNIRCXyCx+OUW42GTi0Xqn7CJ7o8RP1y/QELij0zAZs50XCo62whVayB7G6A?=
 =?us-ascii?Q?Z2otG4Oad/h0+LbWE63or8E//zJ9ezSvzHAW6RvzeozUJOrxZoqLhw+PwCzu?=
 =?us-ascii?Q?SA627O9J4oG7LnW8smIobQLbYwlqbqtDCd7aO08m44rqGMf4HW6n+Xg1V6U2?=
 =?us-ascii?Q?Mo8svFnxHnXoxBn31HPPiW13sC7RhgmRwz2p3hXu8P2jKu8MfqPJd1sf0lz+?=
 =?us-ascii?Q?3RpxWQMKEECzXsmhYl1C3xa5b3XiB9ew7lvf1S4u0r487qS2ycCwfJBB0LHl?=
 =?us-ascii?Q?Bv2V9jmJx6FPfTRWV8guvLHWcaHhZ+EO4Qf3//LoipWnVvYnXZDygHC2bRCT?=
 =?us-ascii?Q?7IEkkLuFWwJRkiOCSsPspzzxszRYOPLCKUdE4oUYdwmLzu3ZzCqL6ttCYXJY?=
 =?us-ascii?Q?ErJTHW41Ulp0JTZoCKgCnQLatGVsBOvHSrt5DmeUW6CQz6PB1+uRSsY1RMbl?=
 =?us-ascii?Q?vcY/Y6yJrBJ3p9l8EBQnGad+QSiwZlnM3LZhv8/B76KAui7FDY2V6+/oPk7y?=
 =?us-ascii?Q?Z0xG4Msqg2Vup0y17Dc/46gbsysWxGC1GIeJiaAZaXto+OaMB4unvVI65eqN?=
 =?us-ascii?Q?YKd30HW6XPGaIZhMzwme6s67TvMoPfYacmRn8uoGW81ia5lWZtgjI2hp3hP4?=
 =?us-ascii?Q?bfXSN1o8tm5Mv7vEApQGPNIMyv3FjFdpv67ryRL1cVNHRHCuTJv7QsQeetvp?=
 =?us-ascii?Q?g9ts3PmcDTmys1gjvYPIzdh93E6IRRR0nYyl5PTGyXwM2Ngmu97kvHT7dHAy?=
 =?us-ascii?Q?bW1z92z94E0no7KS8FTlfogT1l2hOJhF6GmJb1kUXwcfrPRb2PlZH00V52ZP?=
 =?us-ascii?Q?/esT8s1WSesvUzWzt886O+tJA1lsmAdly9aJCtbVHKoYAM5d21J8FK1VlTNO?=
 =?us-ascii?Q?ml9Q1vEHyHivz4h3TCbQ2OCXgYjDgZ0sbVBnFTKRbNyuBqjjK2IHAldZhdPy?=
 =?us-ascii?Q?aMKRYru3mX30qLhcZJvIi6lfYmR3lBlyo47p+o6ZcdwE6OvyKhe/fTLlCMmt?=
 =?us-ascii?Q?DTrtQbljMTdlWzKspTL/xjvkI+gknGzrGvsX6khWKZY4MVuPTMOnkcdE1nRm?=
 =?us-ascii?Q?9UzAhLILn8824+Nl/HP+QTYjH2qpZSPrHfrmYCNbiXWgXjk/dr8LfjJcWKsG?=
 =?us-ascii?Q?MD3P1FtPneKOdQK1ffQzXJeqq6dT24Z394BTzz6G0LNuOfqfvVSLAvzv0ujT?=
 =?us-ascii?Q?fiT0A5+cuKSLQVMVy0rIkwVUM6T7BkxuFXKO5MJ1Z2BdC9g+IIx4HMYWHlKl?=
 =?us-ascii?Q?CUpJrwiGU4xkarSASNR7ykh/q0h+hSpBzYPi0RJf0Rsct9U8JYMKAzr3kuIh?=
 =?us-ascii?Q?6maiLPFE/2RjOi7bg4C8nVMgPbRd46UwRW3aMGypJ4JfLVZ4S7Z9QgdBXyvx?=
 =?us-ascii?Q?X7ms4cx4HV5NxPXpbRYBeWrO/1O5lzxaGhd2U7VhRJdGe+6LWbXgfqkbwXh/?=
 =?us-ascii?Q?pYS4Ww=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db25ae80-9b4a-4e69-8412-08d9a38efbd7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 14:41:15.6739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvkgTsShyZ0gcE4G7+rnV0O0qGDIZdDXFuP4vPWaxg+md8VgA4H2BiMxFY5MtI8x268/UGITag/C7J0y4s6cppB3j0ZtvYCXQbS2BCbe+wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5878
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10162
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0
 mlxlogscore=850 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090088
X-Proofpoint-GUID: JeiYf8GYlgjdqatmtrGQE_eYJ-KreOQS
X-Proofpoint-ORIG-GUID: JeiYf8GYlgjdqatmtrGQE_eYJ-KreOQS
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211109_064146_578574_7535B6F3 
X-CRM114-Status: GOOD (  13.02  )
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


Ming,

> Convert SCSI into balanced quiesce and unquiesce by using atomic
> variable as suggested by James, meantime fix previous nvme conversion
> by adding one new API because we have to wait until the started
> quiesce is done.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering

