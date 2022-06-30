Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A4AC43334
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jun 2022 16:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t+9oIOgOnp9eS4vbzDITea3MZYpxdajmNNnqSs9FOl4=; b=PfOl544spaQfs46oBa29lFjuww
	6msD7ep4S9uofU8LpbUz0sNSv9tjB0S6uFL4mc5729xp88sL93smyYeQuoAxA0V27XETIjyZU+L5t
	y8PctCAAyQtfim6mviniOmelozgVamcW+vXCHm7lrW7w/+Ge0kq3RZEVv0Bx7IyS27r0INttFLXk9
	jFNz6Zuw5SWjoc+NpCVV+Ks2F1SOjEkZfA/ZstFcegPxRmqeE2nJ9MP8PxBb8qHE0FiQOY8Dya9N4
	5xiIB2LY8nPibYxSyp06iWa35oC7ELFIvUCiEdC4G3UisQTOPCsERYD2og/FmhsTSAA4YUXUKGnGV
	E2qm0p+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6xQo-000gw3-TT; Thu, 30 Jun 2022 16:54:18 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6xQm-000guF-HT
	for linux-nvme@lists.infradead.org; Thu, 30 Jun 2022 16:54:18 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UEtibb010777;
	Thu, 30 Jun 2022 16:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=t+9oIOgOnp9eS4vbzDITea3MZYpxdajmNNnqSs9FOl4=;
 b=Ghn0CvpOFu24qoa50vjV4uzHQ008YCgHBiD+PaExbdsYL5zPPhcxIrw+KzaOft9C+VD9
 /Ps0msS7hzskcSCDXpyFjhCrTFT7B4C7hGk+HuCYGZ0s/zX/vkxx8aGHbl7ha4p2wNAg
 ExJBl4Fr8ly4eui8JMJbWJeRnbgZez6iifh0CP9bByqsPaHq+lf6y3kzpFAZbuuakTDq
 lK3G9lQC/9VwwusUylE2in6TKPaAwH3vDb7kZZlKq2+deEXGDsp047mxSKMG8z/uIOJi
 6ip01QmPGG1JbhbjiLx4N4fopmwQP6MvEUhDs7yX89nRR1o5u/gYOzgUJe9ez/yoj0KP Bw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwrscmq67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jun 2022 16:54:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25UGj1qO039423;
	Thu, 30 Jun 2022 16:54:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt4mvd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jun 2022 16:54:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXNLh+diQqvcF9FKagrvc3HhT4Hl2yt+AFJAz1A1O3mKB3f07WzLoofPxZYBB0vmTcPDRiwTCaseNUYLVeW04p8uYCAkQ54Uc6tf61RcR9z2kt5LYOpPrGnEgq3Ssc+jNPboIW8+rreSeuZHkzO9H8k2sUCFT744ksoewNiFA105OZoi1GMcj5jc5PTtkD/n3p96T1RWxU/VUPwZix5Cm3ztxNOwouJ9bJjo78sE2qjTvS+RT9U/tg9Y+ALX4U0VvdmLGtd0waDlNuyQJWp35HSd/4m395pUvWhnRac4ZnXDJ+O3edbA0GPDALMmCEsABNRx76GCLTTfJD67URiKDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+9oIOgOnp9eS4vbzDITea3MZYpxdajmNNnqSs9FOl4=;
 b=DAinVdq8hAHuHzambGdXvdVYtrrBD8BCON3zaviwbzBcb0XKsRy0QVSZYwLiDsrX3ESND7rPOQGAmDbaD3ZPIrqkQ4rNAFFONl5Fi/Nxs7AyTtAaOUTjiXu8r1qez7XhdEUF9GR/Pw+s1TayZqZcT/S2SZq+GfD2s9JOwJESDN2yaexvyFzM7YdpgkV4GcBtwuIyrh8hUrPoNPSTpgfZmkPbkwO8+j4XgdEEbZYazQMDlsuYzEIr/2616PTh0j/TaABNelZmildXN8WHGfPhciQiUuPv05D6WEVUIktSyCTOuzr/bUJiWzGRKUjRhDPRbO6GrvWzRUbwxA1A3/1xAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+9oIOgOnp9eS4vbzDITea3MZYpxdajmNNnqSs9FOl4=;
 b=U9RSZCvU9wVCJ32/rPWmQE/mdt+qbw3OcFLB1gOhjVXfxrGZXXUNLpfg6wgm8wZTbQE/aFUJEUBJLDSs1hZtaAlrOQmp6aDnAU2FZ7bynysAkNwRUX/goW1vO5juVdAV/OaS3U3gd3kZiCDvoPqoI+s9VVjXnJQEITe0+vndX+A=
Received: from CO6PR10MB5537.namprd10.prod.outlook.com (2603:10b6:303:134::20)
 by DM5PR1001MB2092.namprd10.prod.outlook.com (2603:10b6:4:36::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 16:54:06 +0000
Received: from CO6PR10MB5537.namprd10.prod.outlook.com
 ([fe80::fc3e:f74a:c21a:fcd4]) by CO6PR10MB5537.namprd10.prod.outlook.com
 ([fe80::fc3e:f74a:c21a:fcd4%5]) with mapi id 15.20.5373.018; Thu, 30 Jun 2022
 16:54:06 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Christoph Hellwig <hch@lst.de>
CC: kernel test robot <lkp@intel.com>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [linux-nvme:nvme-5.19] BUILD SUCCESS WITH WARNING
 4db675888cdb7b24812e289d7f90e7928dd400a3
Thread-Topic: [linux-nvme:nvme-5.19] BUILD SUCCESS WITH WARNING
 4db675888cdb7b24812e289d7f90e7928dd400a3
Thread-Index: AQHYjEeh4XMahzBtCU6bn1vieSUpq61ne3iAgACv/QA=
Date: Thu, 30 Jun 2022 16:54:06 +0000
Message-ID: <7A0F1179-2680-4D50-BF25-2F2B7D0C6C93@oracle.com>
References: <20220630062413.GA6635@lst.de>
In-Reply-To: <20220630062413.GA6635@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8636c98-02e3-419a-c1b0-08da5ab92559
x-ms-traffictypediagnostic: DM5PR1001MB2092:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  2QEHGZnzckaAvlFhbST6kfon4E+/FxbhVXMa0lIA/BRBdCl/cUBqvE2AB8cZJkGv083zeiYjLn8mZ20AsNfWwNsIx5CHpo8pJJHO3izOGybv5a3k3Z2mtlewb5Dg3QAEL8NowsTsjFP+LL6MVE55ZOYdP/KIoHvgYE7OEqEOpHQjwTJnjRl7Bw5Qqps1R8pZVVP6PAbKTpa8Bl8HhdSr8jPzHVF4FMsiue/ZE+zuXkEbfm3mUQJAJ2+qu0Fz4fAm0+kl02aZdrO7HQFZIfsJfBZBkpu8UyUXLogDvXXs2D6U/3GJSlfPk92+0JMMWg6NLV3n1Pr/S0edLeS+ip0xYn+pKsX5IqLBc2NQ3NE5kSDZ66hC1eivk9ssvLUirWTqL2oXWmhvu9IdRhV3SszFj42YG0Q2F0DMRUNTUWBjrz8cUa1JDKumKqg+sGLieqjzluYIHSBRzuR2taK4Q9ADwcO22+mWlD7fQUtFwMPMXfbH116kDqhTkj+KFAcbJdsnpaNML53XBRFg8nOB631N4Rnd768YDArN+H5YPZ9+FvnbxsvPPIXVf/+TH0rk6OH/ibkV8DYV+gHc1eeGWIO43Rf25ar5Gh1xvB+4UZb7AoZdlTfmjQxesaYQ4hl6FkHU1xNb2Ez85a1zU7+yyMFOWBGJ6EGIgncEv3VWlwRXKj+sc38VklmSEqGfM2tXDE8VFbfmcwvXhVr3NrSu5qhvw2e3WSL5NXQbtcajSmKNfiu63po6TW+2ASbC7ghiRM+p040anpuzVotyGmiQM3PQ5qocTw8Y9Othcp1Z2iE8zDSKl1a06caDIou10yEzuxgS0BvoQQCXX57P0wbtRTi8PCC3Wzs73w3GiOOJXyznlIs=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5537.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(39860400002)(136003)(376002)(346002)(186003)(2616005)(6512007)(41300700001)(83380400001)(36756003)(6506007)(53546011)(2906002)(478600001)(54906003)(86362001)(122000001)(38070700005)(91956017)(44832011)(66476007)(66446008)(66946007)(4326008)(8676002)(64756008)(316002)(5660300002)(38100700002)(71200400001)(76116006)(33656002)(8936002)(66556008)(6486002)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?lCUxL5EYPD+OpmAYUWxShFcnXage38tiokxbzFsvKDCNNxzwwkpDKoArzk2H?=
 =?us-ascii?Q?RVZj5N5rInulwTicxRhf6bxT3FgZi6RKvCV8AGtw0a+7xTZtSO9YfYGRIjJ3?=
 =?us-ascii?Q?0UCV0/UERT54C4hLUmfLVyr0ZfMPrSTi/uMorBTT3d/mFkQL51KEB3hzyKpm?=
 =?us-ascii?Q?Ia61yfGOHlet9xPdpXT/MS2WH3Ue59VSntiajV/WlFaTr3ZOPlNbXIDnsTJn?=
 =?us-ascii?Q?P5Zv4xK3V+QPTezF96grd6vx5YsHW+EBJGaBZlulm1RvubD2jSXmJOxHlQqW?=
 =?us-ascii?Q?zX4E28O/hL5UbUxEN4PwnAE8AUbPciqkcCbCkAPRg1BHi4pJ3VuclZ+H6nun?=
 =?us-ascii?Q?W3RsXkRguIbQ9iEU+2k015f/gJN5eujOAXXxtuG55ASBNarDv+YS5EfDuIr3?=
 =?us-ascii?Q?qpvkcVHecoaFkx0xMDK7A2uLePr5lmy8rfJhffc8bi7+DVlMl/YiLNO/evuK?=
 =?us-ascii?Q?twc+9kwJPHm4czkV/YOvVXrqOj7fFV9HUs3jdm5DfIZ7RRaU6Q/fKUOZlzzI?=
 =?us-ascii?Q?UHEVQgZTiDGc0bjBSVgEsd66BamUnDsCMxelr0a1YxqZhgKzkyCfYXfSE+3u?=
 =?us-ascii?Q?Ee8gdEGWDfCYqdIuC7F1bPnTrPkC3uztms1PMteLPsbH1AQsV2bF5puPgNpm?=
 =?us-ascii?Q?rm7gQO0FGAVQk6mLCDjfE0GfVHlaUB9Mfo9+SbBwt6aB+Vs1XSeeQZYP2i/x?=
 =?us-ascii?Q?B1nHQFFU8yiDkGhps1CzB8nAw00ObOZjkU4HU9kZpS2GX+1uupVoNNHgZF3C?=
 =?us-ascii?Q?WpS/UiYe1JhXUPnl4CMS18hloK79J4ff2CpcUYiw1jbrgn8YVdr1NoWuaXmF?=
 =?us-ascii?Q?FY6SwMYuzzm5tzI/gFcavF29ddgref+37HbsBG1Whr5YCTM4bAgE3V0y1UrU?=
 =?us-ascii?Q?hELeK0MWwuSDNRt79wAkgov8G6j30Kiw/YFWS0POfAoeWb+ONfv6SWxCMweh?=
 =?us-ascii?Q?cMejPatNM3vZUH/k+wIolO5JgpLSOlNWpSjAoyLHyv+7dgvDqGMrLftxPAEx?=
 =?us-ascii?Q?0d4aICPiMdEJTVaCsvC07OQZ/cRvrXwnKcDdfSe1qpTxzL0u3mbdsm6rYsCl?=
 =?us-ascii?Q?MRLXTDY0+Gan/3AGYMce4JiPW2y67FxjNPeoye7ZKTh3Fz2k7lyGzZf7ze3J?=
 =?us-ascii?Q?pFJQfAwTOvLyIsa87VS2AGfgn5z/MMg+2ymkM6Aes2ulVi5EtMfICHvCKrOA?=
 =?us-ascii?Q?8FctS4Z0uRJghMeHunEmLYBiXBc6Dsh2FVNHb7Mirc2/abaBI/zGuUGQYK1w?=
 =?us-ascii?Q?Jerx5NPWKgmfHMJ25hJfXtjqc5O8B3O2yfyq8zfzof32wa92GFDihUAGNUFz?=
 =?us-ascii?Q?xvvoHOUnIcMnvQtrIEUAmtbMo3YHgcpOO1V0zF977QUOjnmnYrwlLMPaoBEo?=
 =?us-ascii?Q?xcuUumKx38vFVcOCUc8qfiZ9J/bz4V5gpYe05FMaYt/SOjUIB/ReGWPVblxM?=
 =?us-ascii?Q?kRXnlXhtu/P3smsE3wBNrZBUCUxhyM9m5Ua6dIoB2xKF61npCb4uZUHs0ypU?=
 =?us-ascii?Q?Pjg3mThVNv+xKrFgThKssPrG/GPJKgaV5Vs7RuLrbktTsjmQrGgm9PlPvhJ/?=
 =?us-ascii?Q?aSvi+ZZVDRYIYiNSiY9f6s+nD//1Q4DcPEPw3TCUzYdei0pbtDbjuymW62V4?=
 =?us-ascii?Q?qgba4SkF5CPQOIEHi3v8wXkI86DLfdHWjTxQYWu2VfSg?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D9A416E1B827B8498F2B7A71790585CB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5537.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8636c98-02e3-419a-c1b0-08da5ab92559
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 16:54:06.8122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UxsTbcIJfTKG+xFDMTx30sDGGJBT1ka0UdRK6q0APZPH4Hv4BNhOkR3oXh9Kv89scJH8KXQrn4Ksa6QieOVImw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2092
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-30_12:2022-06-28,2022-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206300067
X-Proofpoint-ORIG-GUID: adg648dMgKjD5VwIwkXU9xJcFuwoakVE
X-Proofpoint-GUID: adg648dMgKjD5VwIwkXU9xJcFuwoakVE
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220630_095416_734965_A8B0F3BB 
X-CRM114-Status: GOOD (  25.24  )
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



> On Jun 29, 2022, at 11:24 PM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> On Thu, Jun 30, 2022 at 01:58:42PM +0800, kernel test robot wrote:
>> tree/branch: git://git.infradead.org/nvme.git nvme-5.19
>> branch HEAD: 4db675888cdb7b24812e289d7f90e7928dd400a3  nvmet: add a clea=
r_ids attribute for passthru targets
>>=20
>> Warning: (recently discovered and may have been fixed)
>>=20
>> drivers/nvme/target/passthru.c:54:16: warning: variable 'csi_seen' is us=
ed uninitialized whenever 'for' loop exits because its condition is false [=
-Wsometimes-uninitialized]
>> drivers/nvme/target/passthru.c:57:7: warning: variable 'csi_seen' is use=
d uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>=20
> I ended up fixing this with the patch below.  Alan, let me know
> if this works for you:

Looks good.  I tested with my environment.

Reviewed-by: Alan Adamson <alan.adamson@oracle.com>



>=20
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthr=
u.c
> index d71ed297ad16b..6f39a29828b12 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -33,10 +33,9 @@ void nvmet_passthrough_override_cap(struct nvmet_ctrl =
*ctrl)
> static u16 nvmet_passthru_override_id_descs(struct nvmet_req *req)
> {
> 	struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
> -	struct nvme_ns_id_desc *cur;
> 	u16 status =3D NVME_SC_SUCCESS;
> 	int pos, len;
> -	bool csi_seen;
> +	bool csi_seen =3D false;
> 	void *data;
> 	u8 csi;
>=20
> @@ -52,26 +51,25 @@ static u16 nvmet_passthru_override_id_descs(struct nv=
met_req *req)
> 		goto out_free;
>=20
> 	for (pos =3D 0; pos < NVME_IDENTIFY_DATA_SIZE; pos +=3D len) {
> -		cur =3D data + pos;
> +		struct nvme_ns_id_desc *cur =3D data + pos;
>=20
> 		if (cur->nidl =3D=3D 0)
> 			break;
> -		len =3D cur->nidl;
> 		if (cur->nidt =3D=3D NVME_NIDT_CSI) {
> -			memcpy(&csi, data + pos + sizeof(struct nvme_ns_id_desc),
> -			       NVME_NIDT_CSI_LEN);
> -			csi_seen =3D 1;
> +			memcpy(&csi, cur + 1, NVME_NIDT_CSI_LEN);
> +			csi_seen =3D true;
> 			break;
> 		}
> -		len +=3D sizeof(struct nvme_ns_id_desc);
> +		len =3D sizeof(struct nvme_ns_id_desc) + cur->nidl;
> 	}
>=20
> 	memset(data, 0, NVME_IDENTIFY_DATA_SIZE);
> 	if (csi_seen) {
> -		cur =3D data;
> +		struct nvme_ns_id_desc *cur =3D data;
> +
> 		cur->nidt =3D NVME_NIDT_CSI;
> 		cur->nidl =3D NVME_NIDT_CSI_LEN;
> -		memcpy(data + sizeof(struct nvme_ns_id_desc), &csi,  NVME_NIDT_CSI_LEN=
);
> +		memcpy(cur + 1, &csi, NVME_NIDT_CSI_LEN);
> 	}
> 	status =3D nvmet_copy_to_sgl(req, 0, data, NVME_IDENTIFY_DATA_SIZE);
> out_free:


