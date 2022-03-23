Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5051C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 19:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Y1czQPBfjxA+7+PhewRxDp1m/ruhK4Nm9pNmyT5COcU=; b=R7+U9VoI/S5TFr
	hJNeX9l8VXU+jNsJFEK87WWkmitSz6FKeFNOvB6efhMJP4Xk9gudBfzPFy8AgA9BZuhHOh4T0lIVe
	3QsPwzrDvHVh4hu2Hd7ZhSs5NMVrTKq0xGL0f8xW3XF8n62UcgpX4oUQDI1B3xNhjjkYZ0J9E2Voa
	ROBf/M6A0nOwYfolvA029BaQxU1sPMiLV8H/TxudXYnskSksRJKUTA7VFxGVfYa1xu7hwUoWQDCcs
	BrxV6a49stN19EelZbTMwOjNVDkk9kG+qmuLkfspICOQv6kNDOWZ5lZmo/mhxGL5qkbs0sqlwQ4Am
	QAnZkuDEV/bTvtl3hpRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nX6j6-00EjT3-VC; Wed, 23 Mar 2022 19:33:01 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nX6j4-00EjSJ-Um
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 19:33:00 +0000
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22NGqaBV012227
 for <linux-nvme@lists.infradead.org>; Wed, 23 Mar 2022 15:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=Y1czQPBfjxA+7+PhewRxDp1m/ruhK4Nm9pNmyT5COcU=;
 b=WIgnnLrK7laVpmB+YxgfZu/je7ugZi+0ltzYd57G4GFTy5cHVxH7VSsGWd0NKEMASklq
 T1NHG2nWeu2okwQV7VHwZeJ4sbgxiWGZVKdtBWaHm9Ok8mzxQZTrNu1rlnXCR75u+0Rs
 MUMSpwp0jTnCYk1PlgL3T0LPDz6nyntOWBdneAwA5eqrEAyUzQHrg9Z/DJoaTSR77R7l
 Iv3eVl4TIjfVQ7fcJWF5AwyoFF82+U/qIBhqkxC0O+toTVueiSLTUU3BzlgUg2lWJDkV
 P025etdAlGrw02raE2uzcowQxwmHebbciCBeIGHOUjYvbYPl0z4M10CaAExQlVEGBxaP Gg== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3ew9r6mdrc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Wed, 23 Mar 2022 15:32:55 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 22NJUstW003238
 for <linux-nvme@lists.infradead.org>; Wed, 23 Mar 2022 15:32:55 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by mx0b-00154901.pphosted.com with ESMTP id 3eyv67xwn7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Wed, 23 Mar 2022 15:32:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAwZ667x8Bc1BBymdPL0JUHUwRQtUYpWudKKopLno+2GgXNfJd2NFu3Vyx8/PANJPNo56uwHn7tRQvJJIlSB9zoIdslO8CInqU5E24szpaGMtTEGWdFDGHE9x+v2x//W+ArMAwVGcmZferZ1mtmHpsCzsHcS/+ByPNyZhbMWWcXGX/2gxt0Kewr7ja98DRWcIaIFqgrp4DGR3R23IQ8J5HMi2Fa5yU5M3cKbMWiT5cSONjWm4vvpHQJD7xTbm7QANtL72ImdBVdcuW0p9Dkx8z6+ow9BM3hdD/U072sOaYLFlRnRqjjPvR0T0lORerOlIPCy7jmaRyyBW2iUY+xwfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1czQPBfjxA+7+PhewRxDp1m/ruhK4Nm9pNmyT5COcU=;
 b=juNJXY7yDnj0WfAsG+4hZAnISEHam9lJbXO95wX6LK1B8Z7Q9JwkW+nEhzKO5HMGSDyEtBpzs/HQMfiZakMyhlHTAwDM71LvOuLUae5bL0oHENh4PRUggLUGcKSgmtW5FgVKxWNnoHE2I60+WfQF2jo0hWjGSjyd+rIHVVoZ7j9r4cHXk8v/NPMmQoOFaFAKR2IWNgK/KjRKStWn3TTVQxs6B8HnCCG6ZKfQdiSKgJMo1YTwivsYB1izIDCIFB2a/A3IHcJygWXCWetbzhBrozSJKaF6wHXLmYsoyhrilxhaBBLFJ5qBUCkP8BWJcfaJaRZkRttPm/G1xVNyu7nJdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by DM6PR19MB4325.namprd19.prod.outlook.com (2603:10b6:5:2b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 23 Mar
 2022 19:32:53 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::c6b:dc8e:9cc7:51d7]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::c6b:dc8e:9cc7:51d7%8]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 19:32:53 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Unable to build branch nvme-5.18
Thread-Topic: Unable to build branch nvme-5.18
Thread-Index: Adg+7HTIT/YM6CW5T0in+DU2ox7COQ==
Date: Wed, 23 Mar 2022 19:32:53 +0000
Message-ID: <SJ0PR19MB45446560EB7A86ABFFA6BA9FF2189@SJ0PR19MB4544.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2022-03-23T19:29:24Z; 
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=cf9cf418-05b8-4d64-86e5-99e2e362cb5e;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa3ebaff-4b9a-4a0d-3478-08da0d03eccc
x-ms-traffictypediagnostic: DM6PR19MB4325:EE_
x-microsoft-antispam-prvs: <DM6PR19MB4325111623CA6AAD98C27BF9F2189@DM6PR19MB4325.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /fJynfkeENdUZSZCdox0/cpKrIQNb0+eIeR7RAKF2l26zw3S+uSOuw/QlllekFdGttViL29vxuKqAw7GfXMoTAlNL5s9pW2qckPd4BCAzCXoGBYNjETAuUaZmswWcEVwqGSuJ1d+zGpNmraeRFySGAQyx+24WT4t7uL5V+DaH0jhAH4Qi6sV/0JvJRIiqbrZHuC9DaKGAk1JR5AgDJx2mjrz5mPXlEzJ8pWFMBhsSGWNf9PBgonzIrTdxwJ1V11DgPwpZzTiBEyGsIHEg8h4+6IeDtZ4YULL3sST2jsqvZ3JjRB2WhoJPSxHw7Js7zbWjLJT3vFFvISQCn8eTTtcxvj+tYG2ahoE5oLIZdW+JalqPxOvHouz+Qa9NM8Q4Cj/kA1BN7uq+Nryn3R5tAqJfghMD2j45RfQZ1h6q/slLVUxTozTjRkn+uGFKL1MYxOtHSXhuzVjVHdMbxeiCKfsFlwzUXbIR8CEbAvDo/LDfcdY81IlEqAzY5laihf+A0B6F9OcrhIUZBHKPzNG6t+hnbhX+uao5gSEk3JBbAbUi7S5bYdI8ukDlWswafRuym8ZUS/Cedc/TG1JqW5y4ZPCpu91stgNfnd1dPELVI6a0r/f9EZrdMasOcjz8ulDlNUqT9SKoMYGXB/yY85jft8bTI4+gIREIXN6MFWexv13mvSTxOuruOEbb3KgmegfgdjV9hG92mJlknxT1Xfw8hCRbw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(26005)(71200400001)(186003)(6506007)(7696005)(9686003)(5660300002)(52536014)(4744005)(2906002)(55016003)(8936002)(508600001)(6916009)(66446008)(76116006)(316002)(66476007)(66556008)(66946007)(786003)(8676002)(64756008)(82960400001)(33656002)(122000001)(86362001)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R7wd202SVEGm4RysbVfrPQ73g8ROmzY219OtyiGUaY20KFYI5wxaFxM4WkEr?=
 =?us-ascii?Q?njPlbOMXJuAlIhDJzQmPpEZxVeVhYwn0FVA4liEDlhMxIy95bZ6Zq5E+Jgtx?=
 =?us-ascii?Q?mGSjmkbtCTepPEm5Jq9x66JYPresLqlryYuzEiM9xh9F6CqR+2D7PJoO5aF8?=
 =?us-ascii?Q?mSK89fLJ5Ts9TJgfIGaLUm8bAdJXgLKaXZ5bdz15bKjrBeWU3aJGSZCzZV5q?=
 =?us-ascii?Q?PbhJrCwApYiAdcCsQXKj+mE3RfZAbzMwgUISV1vJx4WEObmMJimYFAPU/I+s?=
 =?us-ascii?Q?4TdRqWy4Ajrg+g2/3Piv8L07hpUtC7mtv6rnQwtuJshYVDwPwd18fVKaRx9u?=
 =?us-ascii?Q?aTQ+ndzQfLTM63aWWMgAlizEjXgE5j83Axd0TgPx8W2GdM7CBV7oWgGdved/?=
 =?us-ascii?Q?xDOYtkaUuL8gFYeWUrw6RpSLVsiWxcaLGgjpvn7G5Xyfxku1s/pNlZNfJhZe?=
 =?us-ascii?Q?tWqRq/cwXIT2nVKvH9tsB+5vmqn0yFyr5XgY0U6u757vsAm2zt1M4BVZSGMF?=
 =?us-ascii?Q?PImcMu09Xdw43n8pfD4FRjoXnap7cWoiZnMirwD+6588bGXAiTUUXIk7iA0d?=
 =?us-ascii?Q?tYZeDR+vuuuTFFjdtmQWvlLpaMz3j/QilNOtXurbjiTW/OXHbfjpFbiFhvsF?=
 =?us-ascii?Q?+AES/lQEx5oggsftPhMTQX4NFimkVbMhjWcNEWVcUimW8060cd6CuqN4bK6f?=
 =?us-ascii?Q?5Cl9FZZxck56GxCKCyjLXysPaJql+S25ALMR/Jdg55duQEYzrQR9R3xeAUja?=
 =?us-ascii?Q?Lrpt+m12A+SuBPaLPerXMmDVFhJT4vxrKbHeuP0KM8ViV8ul4JFDq7Igr5QX?=
 =?us-ascii?Q?zu+69WiHItNWQ+K5VIXp8np+ZCyGWG0eRxbOCvdgf2yZoj4ojO4EKwMk45Ts?=
 =?us-ascii?Q?usF7vWX8gI4RQMj47EEfKoZpKvJeYTOemdnkBfBBSyZKm+Fa2zq/Zmqadrz4?=
 =?us-ascii?Q?/xkC6BGCf6HOYsjXGW/LHWRkc0sg3AXnXrgZQEaOfQVpx6QGupN1gM5F7tSO?=
 =?us-ascii?Q?YHKo4e0YPtwQg8Hf+3qzrXzeh3SfWrGUSRvzg3X/hC2VxG2glFfx8MfDsz5z?=
 =?us-ascii?Q?aY6uKIVFTTAJJvLMA6jDzNFRRc86Gz3vzofatGiWVzkeV13DA55Yo0RoNqVv?=
 =?us-ascii?Q?IrMJQYPV0xwgqF6zlcILd0yPGlyRPPrcnM3OHybfj7AVzJBMVdGBpJ7ALWrY?=
 =?us-ascii?Q?AS6durnsXu7iWYwpp7/bMBlE5D1xEOjhY4mdNbG0Lvu6lWB2AVTCfXUZEKvn?=
 =?us-ascii?Q?Z+MqTjTR3rTshdtSNSJle1DD3A8KqMoYdELEY8Hlh4W0cMnyCHNhsbvZokHB?=
 =?us-ascii?Q?V+xZrRmRlt86QQ0myrm+e3MUFtaDH6SW/+2HICxgKqBYWnOWx3IRT7AQ2Fbb?=
 =?us-ascii?Q?YRSwmEz81qVz3AU+QBrrT3J7w9N8Q95+Hg4Iu8uFtxNV2wR8Eth0bSXjTCHC?=
 =?us-ascii?Q?dq2jXPTvybgNfWCkMMyBmOYYXxykB+pIMADWf9eBijmEfPE1S05NEA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3ebaff-4b9a-4a0d-3478-08da0d03eccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 19:32:53.3809 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zWBX24KB4Jf2vV1Gu4jSq+szTiFrKceccA4WEvqLOakbkYHst9aN1OvvAgvAvACs6bDkyDJwYN1ALYKtaXf4i7UZ9xBaClzc5pzTXBYVl3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB4325
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.850
 definitions=2022-03-23_05:2022-03-23,
 2022-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 clxscore=1011 spamscore=0 impostorscore=0 mlxlogscore=517
 lowpriorityscore=0 bulkscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203230101
X-Proofpoint-GUID: musNJ9sPNc_0g1KHUO3M3IZBIqeFozQZ
X-Proofpoint-ORIG-GUID: musNJ9sPNc_0g1KHUO3M3IZBIqeFozQZ
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=664 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203230101
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_123259_204468_E93FC892 
X-CRM114-Status: GOOD (  14.89  )
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

I tried to build branch nvme-5.18 on Fedora 35, but I get this error:

  LDS     scripts/module.lds
  MODPOST modules-only.symvers
ERROR: modpost: "nvmet_wq" [drivers/nvme/target/nvmet-tcp.ko] undefined!
ERROR: modpost: "nvmet_wq" [drivers/nvme/target/nvme-fcloop.ko] undefined!
ERROR: modpost: "nvmet_wq" [drivers/nvme/target/nvmet-fc.ko] undefined!
ERROR: modpost: "nvmet_wq" [drivers/nvme/target/nvmet-rdma.ko] undefined!
ERROR: modpost: "nvmet_wq" [drivers/nvme/target/nvme-loop.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:134: modules-only.symvers] Error 1
make[1]: *** Deleting file 'modules-only.symvers'
make: *** [Makefile:1746: modules] Error 2

Any thoughts?

Thanks,
Martin

