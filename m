Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE91C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Apr 2022 16:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5IZql9oNTIn788c775mdC+XZ66KfFENX+H29LITjBsg=; b=kDP3LFCqqYE0KpJbr1kZM1IXqP
	BzxSspfti6EOJBTVP1TWW8nACrrJO+B0QD4naS1nmniUQw8SjQhTUaQfD9l1cYYhh1ANDTCQfw5Gt
	O0gqRiukIXm77VrLThPWJE8S5iYcJHCVKY8ACsINv8dwDWEwGATwZVA+RV2Jg9qZMDVOvhz9SqrAG
	Nve6L4k50ua8KAmqqNAZIgKwIcLDaaT+Ah3VnM1aXY5ijH7gXBbVuhT3iGeo3DSzD+gHAWl3tjhJx
	wKoQbnVUPhAwA9xoP4v3pfN0h1E/reCKi0y5oB/zEoN6HAGExBznnan0dYbo2lKo2w5c3mkg3ktAX
	zOgnXHNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbPKo-00FloC-C0; Mon, 04 Apr 2022 16:13:42 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbPKi-00FllZ-2O
 for linux-nvme@lists.infradead.org; Mon, 04 Apr 2022 16:13:39 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234G5KoH004892; 
 Mon, 4 Apr 2022 16:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5IZql9oNTIn788c775mdC+XZ66KfFENX+H29LITjBsg=;
 b=dKrrD1RLtYJ66a4ukEpF+skMBrsIB/cUvN+e/yhbkZCWYJ8LD+DmnsZ3KyjWPhZf6Sdf
 VF5J1iBMdLjW20fVdMTws+HGJAewVYFbU1Dk+yG48ZX9z1hrfAQqZAqodXkcSO5AYYRM
 4JmWSiiXsxOFS8qCSWC5ZhJnHguEjQZKiPNV5b0nvDXxgHE/ATVfpE2nQ1dQLwWjOl2U
 EEjgnb4p0oRm1f5DDaWrkgrAsPW53SZVECVqL7YL0OWFaFcn9/uX61gm+lS1heBrKyrA
 Ju7OKaRsbY7ug9HbHMBn2U2DrqXv1bBtQOVVDt/V97xqKehDv3ARWAngzeAmdh/6umga yg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com with ESMTP id 3f6d92uqtb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Apr 2022 16:13:33 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 234G6joe021593; Mon, 4 Apr 2022 16:13:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id
 3f6cx2n0ke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Apr 2022 16:13:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVk2wrwtuFoF9lUJBtJvRmSKEgV/uqRNFClpsIPU7RhryT7PwV9jEQ1kha400jxutHLf9MruWqXNxdYCuhAbH0Ifg9Rz+oJZ+BBVfXuUkBJK1lghDshH8gZKtAu+WJKGVhVC3ecZRZZz6CNmLsiIuw2WMpyJ0cAwCgv+LJOqEFChG9QV/0BGLddX//UlSokwnmrDSGkpDwmM8Dx9ZHMFhbatesOEQeOfdgZ+WE2iBjujU7QJquBz9to2LjXQgCOM/LwHZlXHtfhyrh/Z4lRgGAhjem/KTIvvcWjwdLmMskCaCvZcxM/o0eSJ8ml2+sa0RG7vEqaactMBaX7etuYN7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IZql9oNTIn788c775mdC+XZ66KfFENX+H29LITjBsg=;
 b=UYk1GZ/U6hreBnITwj/FvmHKDb2BVu2UzfkxTFK1sczp9dQ1m0W8hCa5LKfuXNjqqdYubqvq9h8k4BgEa6BSY7wagfFC1F8l2pqehy+FsvgNOGADRXQhBedFOYZTEJ5hZvrKIvgxRRtPWqcBYcLWyei7gEIyHUMr68KvMrX0LaWJEvkP1bwxHDq4dD9LeSZeKSoCHYIk7iN1qleXCEeCBFVkSWqBx6NSud+HV/VZjGsFoAk0zhcOyc0m859vPOX/dRc/h6FWx18VRC1aZ1eH/bYnGNWBqeWr0LXWAlEeMg5VvUrnBueXpFM7KN6mm3yBF3+IFTlPAgT3UN2yOwF6UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IZql9oNTIn788c775mdC+XZ66KfFENX+H29LITjBsg=;
 b=pj5aVb7PXBK/PNbfi09+aV7p8GzJuLu+NajHxRCbGSO+Ieydg9qiIT/Cs7ZWvNQCP5URN7RWl4ZQdDidi8iT40kL4LxLHCQlSialuOMJrU2z2mPCCLZ6CvUi2GhDGzxyAzvoc2S7m3Jji1731uQkvDFhDyck/oQJenvqL34zfaE=
Received: from SN6PR10MB2943.namprd10.prod.outlook.com (2603:10b6:805:d4::19)
 by SA1PR10MB5735.namprd10.prod.outlook.com (2603:10b6:806:23e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Mon, 4 Apr
 2022 16:13:30 +0000
Received: from SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::59ee:c799:39cb:c54b]) by SN6PR10MB2943.namprd10.prod.outlook.com
 ([fe80::59ee:c799:39cb:c54b%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 16:13:30 +0000
From: Himanshu Madhani <himanshu.madhani@oracle.com>
To: Alan Adamson <alan.adamson@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH blktests] nvme tests should use nvme_trtype when setting
 up passthru target
Thread-Topic: [PATCH blktests] nvme tests should use nvme_trtype when setting
 up passthru target
Thread-Index: AQHYRUjCoWhWPS3AE0OObP4Z8q8PLqzf80cA
Date: Mon, 4 Apr 2022 16:13:30 +0000
Message-ID: <02AE7A38-5E02-4D74-8028-249894C0FA21@oracle.com>
References: <20220331214526.95529-1-alan.adamson@oracle.com>
 <20220331214526.95529-2-alan.adamson@oracle.com>
In-Reply-To: <20220331214526.95529-2-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.60.0.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17ee611b-d929-4d4c-5d5d-08da16560f4d
x-ms-traffictypediagnostic: SA1PR10MB5735:EE_
x-microsoft-antispam-prvs: <SA1PR10MB5735410D9DD7927F21986695E6E59@SA1PR10MB5735.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bCS8K3fbprEXUUgonfeeNAhsupmQjCpDP7Rb5Err7jwwh6ShfGkfFgamID3JF7E/G2KVLI1PnfUDA10WvVe8fdXe66FmrtI4NNgE7ayfludQzHSprBbWul9laEhS1poh1Tyg0VrnFRCTN5BvNVpZKrfQsq9IaIYKjHGwQJsGdeNO2OZvHQDu2ijkOfK4rOqIkShXZNG1fXaV8/KKYPHl+tz/cH/MUWCmzNsg1PJ9JdzYFd68Lladck2t6dbNtEFgUWpVV+yKCskf9kpGvEVb9L0V4ceAP8r/sglCMXh5A+NCDHqv5uJnft2b4SzGV0GMSa1WJz2M9hJ1yQXCZImfvTV2tzCnWoFD7EOsjvWcmW14dkJ45/I+OjdCDq5leosGX4C1YFgmhbZ716ZXXSNcUVr+bvnn1dC4yXbtYBk3RHHUWDGUopMM/TYe5u8ZviAEe9ljdc8CE962k8LiHLmUFKmXZM5bCDD6ERs6oaWeD4UA5Jrh2VMaipRrh0dF6gAcNv9ZtPyQqjAqIqEcaauVCOb1i2sASBtF3JyX5NhcFHirpwx4vIMldsXAHZX6g3SoXUCo2sPpbB06JCFuwLfc2owvKe1BPKWN4Ae4pvAFz4MNkgAI7yVhSrBN+mnaZca3T9KvRtFVlpmi31Kmtk7NmF1I0DunLlyXkVsScskoPVpyeskDHi+0oqJAO8kiHA6uF5T5VksUZYflt45j/DGADmeMVDkoBGNS4SLunI8hHjtWSDDUkcnoCn/h5ECGm94b
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR10MB2943.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(44832011)(186003)(6506007)(53546011)(36756003)(4744005)(83380400001)(5660300002)(508600001)(2616005)(6486002)(26005)(71200400001)(76116006)(2906002)(64756008)(66446008)(4326008)(6862004)(8676002)(38070700005)(37006003)(66946007)(33656002)(8936002)(86362001)(66476007)(66556008)(91956017)(122000001)(54906003)(6636002)(316002)(6512007)(38100700002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3X60s9ckwYCyMBhIIECEts86fWT8rKo8Jovu5PPsFOrD9Wig01jK2Nh0Mggw?=
 =?us-ascii?Q?5nSLlE7y12klqEilAp7/lpniaePDIRVoKJnJUqDrq2fcVKEZvlH/7Wbd5XH6?=
 =?us-ascii?Q?Oh1cschcHZdjh44uZQwohrSMVRsQp12hQCvavlYVvpr17NBPFbW/FnfF+kQe?=
 =?us-ascii?Q?D4TWPTjaijGKBU/VFT2eGuXzq1vFuApY89sYDPabUdDVCdL55ioaaeuokdg8?=
 =?us-ascii?Q?jSA/EoD1JOQ6kudAvs831fTdq1pGpKaXXc7Dr9z15odyCysaJwz9rq2YB/Pi?=
 =?us-ascii?Q?C5N5/HPeE5nJZmJ0K6hhJDnz1wNN5hASusAHl1qQry1GUZpOAOkhH6zjcljO?=
 =?us-ascii?Q?3rQAEIqFEYFnT20TF45f+P8TlEDJ17HTQSi0qfbE4vhf53gEAVyYnatFKNAo?=
 =?us-ascii?Q?oxCTNwhZEKBF0WYOvEiGjqr7TT06c7Km8+e2s5odokOp8f16R9CALQblJfaf?=
 =?us-ascii?Q?xRpUJS7oXIDjU7+97WIxLA8JPDo2+e/eebfTrThsXFjzX4FvgZSO89/IDn3V?=
 =?us-ascii?Q?mqGdmk86vKa9KE3bWa+v7rhi10Cw7LsebaHBpZ/fPQabnjZCmoi45o96Ix6t?=
 =?us-ascii?Q?ThS2ByGvCTNMiY0wSCWC+M9a0ShcHful77V3ilsI3NBfQvYY5IuEpHOGBe/x?=
 =?us-ascii?Q?9nezvBQMDHy8uqnqJsCQrZwjQ5teR/TsBDELPX6nRRwefyoDZC5/eWlvTkDu?=
 =?us-ascii?Q?4RlMr1Y4RJT3z6+OaC6zyStI4barkYLjsIkRzBFqrInQ8pomJj5bogvqaJcO?=
 =?us-ascii?Q?qWh3uTqEbDGxpmAaffbqOa+NNdWtOVveARHVhbXP5XfhtepERdwb3Pw9Vxsf?=
 =?us-ascii?Q?34IX1sJdfnGy3lQk+rc1Rm5Zd7K+K1deIe+62ysXQTuvMQTMuXO3rZg0Plcb?=
 =?us-ascii?Q?KrO1MgdrZk54KbdExQcNHM4m6tfYp8QtWCSFR1ZKZBylYfxgpOhntVosdo3P?=
 =?us-ascii?Q?Fwcy3AtsF1spoprLN1v1SH1UI3B9nKrFeUClCbFUEPhpt8/19ekuZSidLe+C?=
 =?us-ascii?Q?5dafrFFfmUyTihyOyriLIPJMOCITGkdA1x7/2Wsur7fDLBP0ixatlQUNeoa5?=
 =?us-ascii?Q?yjl07exHYi2u40gtImw5NsXt2tJKPXd7A6HlvjUIhOqS1YbKEwQAskBbp3BM?=
 =?us-ascii?Q?nTIoR+2f6nxLNrur49wK6s8sUB7hP/bDl5X8Yt5BBbYT4LHPiZVstY8WdjtK?=
 =?us-ascii?Q?wvUmf6y7ymiSEMxAHBMJsT9nz857my/3CfLzu6+RkDBh3Iq8pcFO1LR6sE1u?=
 =?us-ascii?Q?VktvKqAo8Tt32shj5MmeHMSZhcpLs8qN+iXAUFqsJ9kmN7+kv0pmbJcKCCc2?=
 =?us-ascii?Q?dmEl3k02BaCBN614HiibVT4TmpxW3Gvab8GuDyMF5acHj3zV+a+raKLWMKGt?=
 =?us-ascii?Q?W7Ukb5l3kVa6DYnk1TkdLJXVi8TE2bpeMC2SMAaYOyDpGJGxKbhulY3Tuvjt?=
 =?us-ascii?Q?wsnjflO+plT7OQetnwD0UweETL/gC6dEIgdnlqSVnUWsQq12UjelsXji5cMb?=
 =?us-ascii?Q?4VdY9JgKrhHzsSw58IGnZlnw6iQEhfXYX8E5J11SJ1BDUKZw6hliXN8n/CTL?=
 =?us-ascii?Q?ZEN0cOX6KMM7u7Vm9OGdk+4D/Zega5MxvEM7bqI2SIOVtWk7kf1REGtB4cno?=
 =?us-ascii?Q?tpgzcfY69wZOVvg1+qy3fSo+Rj+K/DDB73oxkAkE7OuyOzk+4IERbc4/VUMz?=
 =?us-ascii?Q?P7xHEshCPxRJa40qgJzPHv+UWuQO8DoP1wi0oCed1PX69rGbnkJa87G0XyYZ?=
 =?us-ascii?Q?4F8GMxgFDQIYhm/fE6h4fyDpw/QfQ/7lxJ6E8yT0ByrhkRUNJPnC?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2F589106AD2054439BA93F262AB67F13@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ee611b-d929-4d4c-5d5d-08da16560f4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 16:13:30.5448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LfRTjwKVlKLjKuToc/OWPEMJHasN5G3MH31jgaQ2pFsfnh5ifBz10BkQH6fZDNG+1MuiFbJ1yZKxzCIuFgzEcj5fmCW1EkzubPkQ3k1efz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5735
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.850
 definitions=2022-04-04_06:2022-03-30,
 2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040092
X-Proofpoint-ORIG-GUID: dhqLdmThUfi5ZNMOnTomhCmkElrGyAW_
X-Proofpoint-GUID: dhqLdmThUfi5ZNMOnTomhCmkElrGyAW_
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_091336_310955_6185C31C 
X-CRM114-Status: GOOD (  21.55  )
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



> On Mar 31, 2022, at 2:45 PM, Alan Adamson <ALAN.ADAMSON@ORACLE.COM> wrote=
:
>=20
> No matter what was passed in with nvme_trtype, the target was being
> set up with trtype as "loop".  This caused several passthru tests
> to fail when testing tcp or rdma.
>=20
> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> ---
> tests/nvme/rc | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 1c27cdee1b5f..3c38408a0bfe 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -335,7 +335,7 @@ _nvmet_passthru_target_setup() {
> 	local subsys_name=3D$1
>=20
> 	_create_nvmet_passthru "${subsys_name}"
> -	port=3D"$(_create_nvmet_port "loop")"
> +	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> 	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
>=20
> 	echo "$port"
> --=20
> 2.27.0
>=20

Looks Good

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


