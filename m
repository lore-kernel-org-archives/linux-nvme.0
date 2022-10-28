Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9BEECAAA1
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Oct 2022 19:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1vIFDrlnDCCfIdBo8jeZPa2S82bqP6K4WxC5FdCuk0w=; b=Lov+UVzsK290GZopU3ylqg/uii
	tcqx7hE05gNTNE8aJa9nIQy61e1S0nB1yzpqCVUKVmvnAVscXqZ39MV3DCIDQfSBEBMp/e3fS5qtj
	sKVVLM3GW1Bo/l34GAn+Mbikv5CAel/+vTLP7T3EWUon4yxtqdgtrctU/+eQcVQSncvtMpHPN6MaJ
	me5BeJqipv7YkOCbFoZQWfGUkXevxrb3NptpPfUU+MTA6ydz4gY+jbfEOUZ6nX3tgSp7xC/QiWEiB
	J0lUKhbBe3XJV2muXoElEvzBBDxU3M0/Zk5H2Yytpg60ql40E9gtUp0wAN6W0Ii2n2DGyj6kOVk2Z
	cSHG+MlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooUjC-001pDv-1D; Fri, 28 Oct 2022 19:09:14 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ooUj7-001pC2-TO
	for linux-nvme@lists.infradead.org; Fri, 28 Oct 2022 19:09:12 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SIxJIx026946;
	Fri, 28 Oct 2022 19:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1vIFDrlnDCCfIdBo8jeZPa2S82bqP6K4WxC5FdCuk0w=;
 b=0mFwJ/4rE04zcnIDeDtIAuk36k7+mBtoJ33tdVSo8USuDDkx0txb0VUHukCTAPJePSKt
 YHv9oCu4jRPi3xFKfHg2UU/bt3BYSn9hLlu3v4PPIsvdAEIwLANnVubpA/vG3R5fUXv6
 lcHlegpQPnhZJ2EQuDz8wXXqnrWN6jRG3dnh1XUO3+t42EsJFJ3tkywHscy1g44zlttJ
 Sj9MOGBISL6ViMnh1wP1mFH/R5Kjy04SxhIdpHs+RVIq58rINDJ7Muyg8ivbKMl2m44P
 BF40C3t1uvEHJuwHrBcORbWkITAGQNAfNA/et19at/pFErXCux2Ot7/OYJQFTmDuFB6B 7g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfawrwxqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Oct 2022 19:08:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SIrebM026593;
	Fri, 28 Oct 2022 19:08:55 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagrd48m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Oct 2022 19:08:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdU7asdy7YKh7h88UEvTsXVJ9i7mzj9LODb1a3yVdBlWOm0ysb7pFWyDJIANyeU7pZitWVd1D3ksTfonJZPXcUIf4V7wTy31iBYT/y4K4gQb1o5v2/bFpWxAl2VFyOlC+oMjeg3525oxYc/UBoeEf0GOQr1icuc4UvM7KYe6stle80frPiwjpyvSGYPA5w3I25DVpJiQumlBSC2PNRqactXN8oxTlmPeUD89g9hGzGOSIJ/AsocQrg3LLz9NORSKdRCfHI0D08nwg3CcQoMwKtgrhK2v9ocjE60zo6el14EAPVfBIhE1zXCzxlR11K0Nvdh+cqrPcqn0NyMC+5XIOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vIFDrlnDCCfIdBo8jeZPa2S82bqP6K4WxC5FdCuk0w=;
 b=RTwzFz1h0pGt4GNigYHm1VytCJ4jW0uD8jlsuVNI0SKFW4vohXom+fuq0AbJQ5ShxPO4e3rpNuJ1igRotZ7tgB6enxLfc+Cy9Dzx8xMRpndq85BLz0R5tPsuNTNcFWQVk7f77Jo3jI+ucUc1aix4W1kQ0rDUald561BDO27QxNIQsOX+lXlzdOmSBTpzbXY1zJeecuKBTR+h9qWzwUm46bP9kwKSlkzzhuuRcQa1wgaAyTKMrtOh5l/dszSGP5J3cHajDCebnAxKS8dRgEKVxrRJPAoxtyBQFmy+ynN2Jgvm/pgxgqj5IsuJClAwXWOoTFnPtxeFqWSP2LeEVUBJwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vIFDrlnDCCfIdBo8jeZPa2S82bqP6K4WxC5FdCuk0w=;
 b=gm+A3QEouU2hbkWIuNnhvcU7+UQ2DQy2rL7GEEge1C0SGIH5L3zH5pqLn/d0yjCq0/Y244q7XFl3eJof2jJwnYhp+HSvHrcKRhBR6zLbDMSMfgzQcJ34bNJFy/n1xEmiQtAzxigF8s0/cCCdpsObaljcgrw/6WCmvkR1ytGpNlg=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by CY8PR10MB6780.namprd10.prod.outlook.com (2603:10b6:930:9b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 19:08:53 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::8896:7475:58a:7003]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::8896:7475:58a:7003%4]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 19:08:53 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Keith Busch <kbusch@meta.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
        "joshi.k@samsung.com"
	<joshi.k@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, Keith Busch
	<kbusch@kernel.org>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCHv3] nvme: quiet user passthrough command errors
Thread-Topic: [PATCHv3] nvme: quiet user passthrough command errors
Thread-Index: AQHY6tvZQ/O7VIkck02lPg7Uo3LFKq4kK7IA
Date: Fri, 28 Oct 2022 19:08:51 +0000
Message-ID: <5D2DB5CB-CF49-480C-BC6E-30EA28877F5F@oracle.com>
References: <20221028144435.1613982-1-kbusch@meta.com>
In-Reply-To: <20221028144435.1613982-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB5550:EE_|CY8PR10MB6780:EE_
x-ms-office365-filtering-correlation-id: a47ee25d-2b48-4496-6f71-08dab917dac1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  de0nPUXHWYELe3X91uGkzzGD4/oQt0MXATgBnkkpIoAe/l0ja12K3kPGhEKj2z0YlanUMn3zMlqBjk+Ry9PycFOAZ6dtKo1IjvXmmj8PPZCPJ2miFUdyAXgUDxZj6ksPNUo0BW7EhZpXiubrVevViVFHUacPH5ChFpTwujkbFRoapeM3hiaDl9UlThvO9NAI8QM9uYzYac+G55YUGfMiazuVZ6bEbkAPOjH5ZxJ4rK9K5Gn6VNFe1aQ/xclAHS9GElJZpM0jWejGjB0oeCAYvkL9K3xmRM0cdO5RvqhQxb4yL1ni94A8muGmRWBTiKizxmrSLlAGPzu/oOnyGM80KVniyLc3Db7Q/3qFiZhfw9jt00L8dWGHz57nhh1OHxKudPNdwdpMKNfk1mJBXg4qOFc4DPIDHa3/mocu7xctMGNNiE0wDe2EjrnHqgNZcaK1aQ+kzO6flRlIfpV2CqnfCOy61IowCU60y27J0RVDHXN0Ba86mavZ9jklvQWCe9DTfO+aqdzxMeHCIlKdZgHPR73uODkGJeZunH5Wg1B88/9N07qDD2/hnMfeXUaaUKniopR6dsL+MW+AphJciNtuStcukRgdtvAPkgYdbNrl6lQPpc8/9mmDxrY9IJCGZZq8kZVmi5WQE/pelseeB59IL+/jC6zHjsmCgnLJ3IT5VR9ACGn5GAl6wqIYN5tfwr8q4IyxsSB5tfBKn4BsDrADpHN4mHeLadE9i+Hp0DK8JII4p85mJy2FN1EDouWFwCKlWpigOUkgCo8qQ3o652bcDaYEpw8pBB3HpM4PKsuXQUQ=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199015)(36756003)(41300700001)(38100700002)(44832011)(8936002)(2906002)(33656002)(71200400001)(6486002)(8676002)(4326008)(91956017)(66556008)(66476007)(66946007)(76116006)(64756008)(66446008)(5660300002)(122000001)(316002)(6916009)(54906003)(38070700005)(83380400001)(86362001)(186003)(53546011)(2616005)(6512007)(6506007)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?OA+dR92zkZVnBC3vtItuI/mu6sxiZZmazfzqG2v2kOmwTg65oLV4Blyt1R4g?=
 =?us-ascii?Q?IfFP70fSmytPHq9uruRONd6OQzR1RczLcULaRybMmvdu6XrmalMs+s4uKFw6?=
 =?us-ascii?Q?mdtl3Cs5GnCjO3KVBZ/8Bt2IzRQb2+e075f9y5aK8mau8MscsJt6B+bkvWSg?=
 =?us-ascii?Q?1iw/K69x+uYFFRPOxvgT+9eU2UHGCoV/EBl9AhMN+Q+UFxOpnoo9sZsxNI7I?=
 =?us-ascii?Q?tpceGi/wnsrDiVth8tj11uRTImtmdVtvimEQBOdrny7vtE8nsXQ9mDpZMbWD?=
 =?us-ascii?Q?RXBEc9509H9RZvwAzOrNnzoUlPBGqwf4ys+AiklOn2z4P+E0JNoalomN0H7Z?=
 =?us-ascii?Q?c6B5lGN0YSA8ZZtBcbV0wZicFWd7WfAY0gPEz85BseKHxoACfNIwzQuUv4Hl?=
 =?us-ascii?Q?vPuEn0JqBt7l3D9CGiOmt+MiyjVIfwEwPx4pgM3YijV47TG6qU+xGMarllCA?=
 =?us-ascii?Q?GJOosx5aKT/dy3V/MffpL+NbgPro+zNakx35qoi/koIFMYvwL1Zwik4tG8iI?=
 =?us-ascii?Q?ZZ8zRoZyG/2tjeLwZvQgzA921jVds2B705XXmysqwV0TsFHM/5/tiMC6VBLE?=
 =?us-ascii?Q?hWbqZ210IY8/GvRAQUpX2Q8I15m1B7pYMQCmRiHvydtXYzBwj5eGcg5lEthG?=
 =?us-ascii?Q?x0WFDOAYngLoS+7cybQvMp3TZ9o27ds5zkZtIHtJDEcT1CiwA/ao9xqR8Vch?=
 =?us-ascii?Q?8M0qCEkkNOA11wbjnFVtrZlN+Yz7ogNqFtxXGrU0S1hKssUrvsbmgVAmn95W?=
 =?us-ascii?Q?UE7Evh2CtBjHRRMgNtveYINXrfR6qXFO8xQgQl05oxnYKHXhbTkv6w3hQkw2?=
 =?us-ascii?Q?MQs8KX832yeuSiltu7V0zo/iZcWhZ+0WE2LtsSjNpUYB87mD/OuwVtWeefHs?=
 =?us-ascii?Q?xkLUF0KuZIS49PPqEMzMk+POqUq54fkW9GbRN9WC5x8Qmox572x2fPg9k/m2?=
 =?us-ascii?Q?5melscZGVnoz41Y/rWdylaKW8Fhv8bxptqtFQv/xejj8up4P8QKNULNxJAUd?=
 =?us-ascii?Q?Rlw3Ey8gLwxlDHiT/cPTpjI17W/a45XX8z9RncusQB3m3QiXlZ6N7bXfzO+H?=
 =?us-ascii?Q?I7L8k80GqHAv/vmZ+rMxv+oqz+gGFgfb29wvdgTCSbp5lW5VXfnp6cK78tYi?=
 =?us-ascii?Q?qBmyFpVxMjgDQ5KggFApvQpjCb4DcEDTLlpGxg7o8GjrUmfbA+bgDU2gipHT?=
 =?us-ascii?Q?zXhoJel8NBgLI6jRSAjrxcXcyCfC627kHeZzi5brmOcCyDPMdiivC3PlNog1?=
 =?us-ascii?Q?RYwaOKa9/SIqqbbR7sF7K81KHNLGq/tc7yvPPd22RD49kfKLiBqAdt8lVWUB?=
 =?us-ascii?Q?+BnsmGz7b6w2p0TCRWrUhIO3g1Zip2M9FQVVU5XqcjA2t21zdG7WVQWdOs8m?=
 =?us-ascii?Q?0/JZHfZZI5ifDNrdRNkAS5NP19ZvKRbUOEGEjolEbIF2CroCZiq4NegwUt2s?=
 =?us-ascii?Q?ez6DS6dyrWAmeehIP+hOoiHjxQoLQ0io+K/q8E1ArJ/xogJow+jXtN3b9w40?=
 =?us-ascii?Q?ki8L3jFzLJMaOnFI5lGtBn0jFndJloU0oXuWikbo22Ln+RGCNnFby8LPssxl?=
 =?us-ascii?Q?e7a8R+pYf57+XroFC6LbleU8yZ5HetL2hoV6toAxRf1MyrdSxFGNk8NSBq/D?=
 =?us-ascii?Q?RusarFEwt1llY0/xHFUblVRB1A+FTEOvmH+ucX7Bj8JA?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5ABC7FE7144A9B428431CC4B6DD7012C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47ee25d-2b48-4496-6f71-08dab917dac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 19:08:53.1530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jj8UmPuYGAWhfrciWbWBbcS2lF+FpFCnlcBThoB/UfsVqxSzBE1qY/QPIzYFK3P5StahtBzeUlvYob02pBrQKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6780
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_10,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210280121
X-Proofpoint-ORIG-GUID: eQLnwHPpJdqNLrqbzDaC8HXkJTAlE8Rx
X-Proofpoint-GUID: eQLnwHPpJdqNLrqbzDaC8HXkJTAlE8Rx
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221028_120910_112427_9B61C27A 
X-CRM114-Status: GOOD (  25.87  )
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



> On Oct 28, 2022, at 7:44 AM, Keith Busch <kbusch@meta.com> wrote:
>=20
> From: Keith Busch <kbusch@kernel.org>
>=20
> The driver is spamming the kernel logs for entirely harmless errors from
> user space submitting unsupported commands. Just silence the errors.
> The application has direct access to command status, so there's no need
> to log these.
>=20
> And since every passthrough command now uses the quiet flag, move the
> setting to the common initializer.
>=20
> Cc: Alan Adamson <alan.adamson@oracle.com>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v2->v3:
>=20
>  Removed the last open-coded RQF_QUIET flag users since the setting is
>  redundant with this generic change.
>=20
> drivers/nvme/host/core.c | 4 +---
> drivers/nvme/host/pci.c  | 2 --
> 2 files changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 686c55cb5d1a..543782dcfba9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -657,7 +657,7 @@ static inline void nvme_clear_nvme_request(struct req=
uest *req)
> 	nvme_req(req)->status =3D 0;
> 	nvme_req(req)->retries =3D 0;
> 	nvme_req(req)->flags =3D 0;
> -	req->rq_flags |=3D RQF_DONTPREP;
> +	req->rq_flags |=3D RQF_DONTPREP | RQF_QUIET;
> }
>=20
> /* initialize a passthrough request */
> @@ -1037,7 +1037,6 @@ int __nvme_submit_sync_cmd(struct request_queue *q,=
 struct nvme_command *cmd,
> 			goto out;
> 	}
>=20
> -	req->rq_flags |=3D RQF_QUIET;
> 	ret =3D nvme_execute_rq(req, at_head);
> 	if (result && ret >=3D 0)
> 		*result =3D nvme_req(req)->result;
> @@ -1226,7 +1225,6 @@ static void nvme_keep_alive_work(struct work_struct=
 *work)
> 	rq->timeout =3D ctrl->kato * HZ;
> 	rq->end_io =3D nvme_keep_alive_end_io;
> 	rq->end_io_data =3D ctrl;
> -	rq->rq_flags |=3D RQF_QUIET;
> 	blk_execute_rq_nowait(rq, false);
> }
>=20
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 72b5c1addbff..8cd92283cbfc 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1436,7 +1436,6 @@ static enum blk_eh_timer_return nvme_timeout(struct=
 request *req)
>=20
> 	abort_req->end_io =3D abort_endio;
> 	abort_req->end_io_data =3D NULL;
> -	abort_req->rq_flags |=3D RQF_QUIET;
> 	blk_execute_rq_nowait(abort_req, false);
>=20
> 	/*
> @@ -2485,7 +2484,6 @@ static int nvme_delete_queue(struct nvme_queue *nvm=
eq, u8 opcode)
> 	req->end_io_data =3D nvmeq;
>=20
> 	init_completion(&nvmeq->delete_done);
> -	req->rq_flags |=3D RQF_QUIET;
> 	blk_execute_rq_nowait(req, false);
> 	return 0;
> }
> --=20
> 2.30.2
>=20

Since all requests (not just user space initiated requests) call nvme_clear=
_nvme_requests(), all requests will set RQF_QUIET, so no error will get log=
ged.

Alan


