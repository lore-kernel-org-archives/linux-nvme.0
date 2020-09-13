Return-Path: <SRS0=pw47=CW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CC5C2D0A7
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Sep 2020 15:18:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00466208DB
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Sep 2020 15:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gdyb/Spk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="WiO5fO6Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="AwY1e0KK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00466208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xQtwB5obiTN0faXDjuccgtXPdqtT1hlaVBWgXVFTfbQ=; b=gdyb/SpkvytpG/BtPF4oa2iwY
	GII2bPDf7QXRCc3CbVxFGu/Ifo9upjlNpqshvqos/H0Lyk6mCB1f2L0Sai0VyoJW2rOLHPEr9f9P7
	4VVHML1pa10+3RrMwV05IACbkYXRLrw1vCdiqnifS29+x6a8e2Sw5Vz+ct/+t+LPPpAhH8a6YD1RY
	d8LPJhT6Y8HP+khrR5ep9dG4dGNPvw2/WZhzd5GC/2dHBLerKN7s+Ejng1ZUvkT1+FacNCR3PjBy8
	KdbNBn7osSvqdTK7Eks+rR4zBGmrd1XnsP6ZDsW7ES0n6atSsJL90f7EHdQxA9h7w+7rQQc3z5nCQ
	aGf/zoU4w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kHTlt-00019B-E3; Sun, 13 Sep 2020 15:18:29 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHTlm-00018V-Ij
 for linux-nvme@lists.infradead.org; Sun, 13 Sep 2020 15:18:23 +0000
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08DFHjDI016899; Sun, 13 Sep 2020 11:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=skhBcB9fLEmN7+OIvDgmGDsuWiZ0iT2ZzybTLDage2Q=;
 b=WiO5fO6Z6r2VPImbbD/tQ21ysTIodKIAT5PK6qHiNufyVfcmjYRtRwXyjmIOhL5UdZ0N
 kww7T79Mg51y4qXo8kQfuiSXavE9OGotuFLxd+Mp6pZJq+j3WDpDpD40MVhKqW7w3ugx
 LXYaa4MxxOF4tc3iF7HQvG3b0ndqk5M3LPCWW8cgWzU0DdimOiIOJWZytEBfLsOXfO/o
 D85GsuxUvHRckpl/mP3tcxx5uFCTQeycpbODpjIlpWs5K+n4aBZBFmlHeSzg59t3ywac
 xAuQebgF+KuirWxG/L+0S1lHv09Ayhx8HffZOQwWO0Ghr4t875BQ6yrpONClK4pKI74+ JQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 33gqdt293u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 13 Sep 2020 11:18:11 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 08DFCcNf071273; Sun, 13 Sep 2020 11:18:10 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
 by mx0a-00154901.pphosted.com with ESMTP id 33hb89c8tk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 13 Sep 2020 11:18:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efy9dH9+mokFk3d7qx4z/x8gFups3yeXXr39LJvgcLFnkST+uQdE9U3eM7LoqtGjhbxJA8Urb13YixGd5r8+SMaOdDslByVgplF38ESMLoDYzw+/tBB1QbDFJVaOwwyFNK9Ulk52Q5gAho9wKQBy7/74mzptv+AlSY2QsEBPs4Ly/heGUOKiQBfUwhlUcJXtq6IHDOcg1Ya56TI3m4Cj/f4Np/qM6wCPaq+eOQoDNEoMEPi2HRqk2V1MPYo28mdpyblNKLebLURDaS4XqHyCN3KnGwnlzKt+l4y19m3copeEs7Mg9vdhaYSZAC40GhGBAxzEXXqDuRoa8VzYJNmrXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skhBcB9fLEmN7+OIvDgmGDsuWiZ0iT2ZzybTLDage2Q=;
 b=fr1Phrute2V/sThvRpz3F52y6UBy8G3OuaErE61TWJ2rooXZJhZlWkzowAjoXDVD1OAMKaoHfNFAjuWfebyk1/3oLmwhB7/x8tzLo4ApackPwIiC5l17cwFV3OG5n2Z4Gq4++cwVI5Y3PilKO/NcRZpt5sRbPSRbiTiqWh/38CaSinMhsHZLYKEMC0xz0n6ZFtbldWv0Rv/JBfzZRN3tiL5EjQ1cjOGopiQepaW0mgq9Tk6obxL9GylMaVL5KgcY+pF5cL54pZXlPTCKIut13TmM/wxCGrip7Ou6x9AuCV7vSqZXrTkTnYZ0rQqJGW1PKyiOSnazs0xApfpr3hH5aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skhBcB9fLEmN7+OIvDgmGDsuWiZ0iT2ZzybTLDage2Q=;
 b=AwY1e0KK6JFrhCmg9DTFD2s1X/1KuMlW4uuM0takQV7mdB5GDGFH9KpFTISSJeuTYjqdgWb+lmpQyB3AJdfjFzafHD/eXNfbjrwT2aTiRrAkwd0awhXfgWMOdq2CaKff0NXDHRa1H988VwlcuSkQosaXdMJdFQRJsj4PONq1n4o=
Received: from MN2PR19MB3005.namprd19.prod.outlook.com (2603:10b6:208:109::21)
 by MN2PR19MB2800.namprd19.prod.outlook.com (2603:10b6:208:f3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Sun, 13 Sep
 2020 15:18:08 +0000
Received: from MN2PR19MB3005.namprd19.prod.outlook.com
 ([fe80::d51d:2072:5eb1:10a1]) by MN2PR19MB3005.namprd19.prod.outlook.com
 ([fe80::d51d:2072:5eb1:10a1%4]) with mapi id 15.20.3370.019; Sun, 13 Sep 2020
 15:18:08 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH] nvmet: Set ctrl->kato to a default NVMET_DISC_KATO value
Thread-Topic: [PATCH] nvmet: Set ctrl->kato to a default NVMET_DISC_KATO value
Thread-Index: AQHWdSwQNt51xVzDuEiiv7DIlV0weqk+DpiAgABKkQCAAAEugIABJRfwgAAPwACAAAUT8IAnQxEQ
Date: Sun, 13 Sep 2020 15:18:08 +0000
Message-ID: <MN2PR19MB3005D217FD29FC88C64106F5EE220@MN2PR19MB3005.namprd19.prod.outlook.com>
References: <20200818065114.57532-1-amit.engel@dell.com>
 <20200818162731.GC27196@lst.de>
 <0b3027b3-e4ef-3e45-9b92-babe09e34e6d@grimberg.me>
 <cdb5a25d-ab1c-bd6f-2608-c51e169ad87a@grimberg.me>
 <MN2PR19MB300552C9AAC6400847E51042EE5D0@MN2PR19MB3005.namprd19.prod.outlook.com>
 <17f4ef7f-1a1f-4e0c-5219-117bc752d959@grimberg.me>
 <MN2PR19MB30050F8BE320428D55B32231EE5D0@MN2PR19MB3005.namprd19.prod.outlook.com>
In-Reply-To: <MN2PR19MB30050F8BE320428D55B32231EE5D0@MN2PR19MB3005.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-08-19T16:04:29.4318021Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=a7bf2b29-021f-41ff-9e95-a04f0373505a;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [152.62.109.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdfe1471-b553-4c3f-fec9-08d857f83898
x-ms-traffictypediagnostic: MN2PR19MB2800:
x-microsoft-antispam-prvs: <MN2PR19MB28000CEFA92785AB38F9F386EE220@MN2PR19MB2800.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RbxwtMgn+8TWIwSsqRaqAMRN2GlpI/fg/98e93SuEl8HBTVBIPcUmMJ1hcXiDl16Dy/LFwdaYIDGCOJrDwK0t14JSpbAiXCUB0B0wNMhrwdCCiRg/rIKcPxaX8xi0oGxURArGgzDYUdNKUw6GbD9J4GjekK3IfJvuaco5VJDTvPsCFf+nlukmaYtrTd4MJsgIDFtVSvQEMrav5klaiQaDdKMfJ2Xlb7zSmP0OQ2s3nl0sPY+1zWi1GkzzU/t7g04Te9j3JX3SmOD3w3e54SLWEUGBB/54gvzd9zhU7+RQZLmTQ0Cr/SPymB7+Qsdy1ov3RhU3aOa1xz3exRK5Q5njhfYmc5vZQh2UUuN+rvTINKQS+qjkSl0WOKc0TWE4o/HYYEEps38RczPu93jTs6l3A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR19MB3005.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(136003)(346002)(376002)(366004)(396003)(66556008)(53546011)(55016002)(9686003)(7696005)(8676002)(6506007)(26005)(2906002)(966005)(5660300002)(66946007)(52536014)(71200400001)(76116006)(66476007)(186003)(4326008)(33656002)(66446008)(83380400001)(64756008)(8936002)(478600001)(86362001)(110136005)(786003)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Mk+FHg3QVuu4ImsxfIP/650YPuTv0im8ttUGYt6mRfWzKfbAKHE8UUc5sZYeebJ9yFYOSMjDxjiVTmIPZ8t8doGuuuTlZ3TQCZFdjIemfx6WzmUGOWT+upSUaO2j1krTo/z8KLYpy19uK0CSyJgNX/qdopRYTpyZCTvfwapBfS0720+injOAUDkErz8H6E8/sYOGY6F+HCDU40w7whM0by3ZdYp7TQQMAmWV8CwlVbL+WxJaDsj8sl58X1QLnoKY9GDB9zsaUUSK9DjH33m42EWmAWdvcYcVGwZmmpDeU+8NnNItxpWc984Rc7Y//Jh2fvZpJrT65E1mT2Q1aCWUG0duKUM+gJcegAstMMHcS0RtXlWE/HyLtbcDQtPcfsJcjZteCHC7tp68SyCvJVI6Phre4bT0qszebaeF6J4tU0J3d5ZYn7tAGr9mQLZpdZpopscvGd6rS6adArIxRiBHNcoGaAAbC1WBDmjAqrwma22E51q38i5XLGRmOwCVwexaK/xIdIumkuonmIFuo7Gm5Ea2fvTjThz6PCSxdzEBRUp7/8QPH+gENIZ4bMAuOdtn8HJtC1buD5WUWgIZeX9ZEMFVKH1sYFNOD0tmz4JskROhdGyaCoLpFJaBIaRU94D0lt983OGPtNkR7afYHydpFA==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3005.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdfe1471-b553-4c3f-fec9-08d857f83898
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2020 15:18:08.5082 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sb2R7uOc+cqsvNF59pjfyBCBwvEji8iUiVbbU7YQ6+Ccg31vEMlcfaC4U/lven9xWh+UzvnQM8m7cCEPIxwmEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB2800
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-09-13_05:2020-09-10,
 2020-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 mlxscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009130139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009130139
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200913_111822_820961_2B711A6A 
X-CRM114-Status: GOOD (  23.64  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGkgU2FnaSwNClN0aWxsIGRlYWxpbmcgd2l0aCBrZWVwLWFsaXZlIHRpbWVvdXQgIHplcm8gdmFs
dWUgYW5kIGhvdyBpdCBhZmZlY3RzIG90aGVyIHNjZW5hcmlvczoNCldpdGggbXkgbGF0ZXN0IHBh
dGNoLCB3aGVuIGtlZXAgYWxpdmUgdGltZW91dCBpcyBzZXQgdG8gemVybyB0aGUga2VlcC1hbGl2
ZSB0aW1lciBpcyBkaXNhYmxlZC4gKFVwc3RyZWFtIGNvbW1pdCAwZDNiNmE4ZDIxM2EzMDM4N2I1
MTA0YjJmYjI1Mzc2ZDE4NjM2ZjIzKQ0KQnV0IHRoYXTigJlzIG9ubHkgcGFydCBvZiB0aGUgcGlj
dHVyZSwNCldoYXQgaGFwcGVucyBpZiBhIHVzZXIgc3RhcnRzIHdpdGgga2F0byA+IDAgYW5kIG1v
ZGlmeWluZyBpdCBieSBzZXQgZmVhdHVyZSBhIHdoaWxlIGFmdGVyPw0KQWZ0ZXIgbW9kaWZ5aW5n
IHRoZSBrYXRvIHRvIDAgd2l0aCBhIHNldCBmZWF0dXJlcyB3ZSB3aWxsIG5ldmVyIHN0b3AgdGhl
IHRpbWVyDQpJbiBhIHNpbWlsYXIgd2F5LCB3aGVuIHN0YXJ0aW5nIHdpdGgga2F0byAwIGFuZCB0
aGVuIG1vZGlmeSB0byBrYXRvID4gMCB3ZSB3aWxsIG5ldmVyIHN0YXJ0IHRoZSB0aW1lcg0KDQpX
ZSB0aG91Z2h0IGFib3V0IHNvbHZlIGl0IGJ5IGFkZGluZyBjaGVja3MgaW4g4oCYbnZtZXRfc2V0
X2ZlYXRfa2F0b+KAmSBmb3IgdGhlIGFib3ZlIGNhc2VzDQpBbmQgaGFuZGxlIHRoZSBrYV93b3Jr
IGFjY29yZGluZ2x5IA0KV2hhdCBkbyB5b3UgdGhpbmsgPw0KDQpUaGFua3MNCkFtaXQgRW5nZWwN
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEVuZ2VsLCBBbWl0IA0KU2VudDog
V2VkbmVzZGF5LCBBdWd1c3QgMTksIDIwMjAgNzowNSBQTQ0KVG86ICdTYWdpIEdyaW1iZXJnJzsg
Q2hyaXN0b3BoIEhlbGx3aWcNCkNjOiBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcNClN1
YmplY3Q6IFJFOiBbUEFUQ0hdIG52bWV0OiBTZXQgY3RybC0+a2F0byB0byBhIGRlZmF1bHQgTlZN
RVRfRElTQ19LQVRPIHZhbHVlDQoNCkkgd2FzIGNvbmZ1c2VkIGJ5IHRoZSB3b3JkICJyZXF1aXJl
cyIgd2hpY2ggdGhlIHNwZWMgdXNlcyAodGhlcmUgaXMgbm8gInNob3VsZCIgaW4gdGhlIHNwZWMg
YW5kICJyZXF1aXJlcyIgc291bmRzIHByZXR0eSBzdHJvbmcpOg0KTlZNZS1vRiAxLjE7IDcuNC44
IEtlZXAgQWxpdmU6DQoiLi4uVGhlIE5WTWUvVENQIFRyYW5zcG9ydCByZXF1aXJlcyB0aGUgdXNl
IG9mIHRoZSBLZWVwIEFsaXZlIGZlYXR1cmUiDQoNClRoZSBzYW1lICJyZXF1aXJlcyIgaXMgYWxz
byBtZW50aW9uZWQgaW4gUkRNQToNCk5WTWUtb0YgMS4xOyA3LjMuNSBLZWVwIEFsaXZlOg0KIi4u
LlRoZSBSRE1BIFRyYW5zcG9ydCByZXF1aXJlcyB0aGUgdXNlIG9mIHRoZSBLZWVwIEFsaXZlIEZl
YXR1cmUiDQoNClRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24NCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IExpbnV4LW52bWUgPGxpbnV4LW52bWUtYm91bmNlc0BsaXN0cy5p
bmZyYWRlYWQub3JnPiBPbiBCZWhhbGYgT2YgU2FnaSBHcmltYmVyZw0KU2VudDogV2VkbmVzZGF5
LCBBdWd1c3QgMTksIDIwMjAgNjoyNCBQTQ0KVG86IEVuZ2VsLCBBbWl0OyBDaHJpc3RvcGggSGVs
bHdpZw0KQ2M6IGxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZw0KU3ViamVjdDogUmU6IFtQ
QVRDSF0gbnZtZXQ6IFNldCBjdHJsLT5rYXRvIHRvIGEgZGVmYXVsdCBOVk1FVF9ESVNDX0tBVE8g
dmFsdWUNCg0KDQpbRVhURVJOQUwgRU1BSUxdIA0KDQoNCj4gQWN0dWFsbHkgdGhlIHNwZWMgc2F5
cyB0aGF0IE5WTUUvVENQIHJlcXVpcmVzIGtlZXAgYWxpdmUgc28gaXQgc2hvdWxkbuKAmXQgYmUg
MC4NCg0KTm90aGluZyBpbiB0aGlzIGxhbmd1YWdlIHJlcXVpcmVzIGl0LiBUaGUga2V5d29yZCBz
aG91bGQgbWVhbnMgYWR2aWNlLg0KDQo+IE1heWJlIHdlIGRvIG5lZWQgdG8gc2V0IGEgZGVmYXVs
dCB2YWx1ZSBpbiBjYXNlIG9mIHplcm8ga2F0byB2YWx1ZSA/DQoNCk5vLCB0aGUgcGF0Y2ggaXMg
ZmluZS4NCg0KPiBOVk1lLW9GIDEuMToNCj4gNy40LjggS2VlcCBBbGl2ZQ0KPiBUaGUgTlZNZS9U
Q1AgVHJhbnNwb3J0IHJlcXVpcmVzIHRoZSB1c2Ugb2YgdGhlIEtlZXAgQWxpdmUgZmVhdHVyZSAo
cmVmZXIgdG8gc2VjdGlvbiA3LjEyIGluIHRoZSBOVk1lIGJhc2Ugc3BlY2lmaWNhdGlvbikuIFRo
ZSBOVk1lL1RDUCBUcmFuc3BvcnQgZG9lcyBub3QgaW1wb3NlIGFueSBsaW1pdGF0aW9ucyBvbiB0
aGUgbWluaW11bSBhbmQgbWF4aW11bSBLZWVwIEFsaXZlIFRpbWVvdXQgdmFsdWUuIFRoZSBtaW5p
bXVtIHNob3VsZCBiZSBzZXQgbGFyZ2UgZW5vdWdoIHRvIGFjY291bnQgZm9yIGFueSB0cmFuc2ll
bnQgZmFicmljIGludGVyY29ubmVjdCBmYWlsdXJlcyBiZXR3ZWVuIHRoZSBob3N0IGFuZCBjb250
cm9sbGVyLg0KPiBUQ1AgbGV2ZWwgS2VlcCBBbGl2ZSBmdW5jdGlvbmFsaXR5IGlzIG5vdCBwcm9o
aWJpdGVkIGJ1dCBpdCBpcyByZWNvbW1lbmRlZCB0aGF0IFRDUCBsZXZlbCBLZWVwIEFsaXZlIHRp
bWVvdXQgaXMgc2V0IHRvIGEgaGlnaGVyIHZhbHVlIHRoYW4gdGhlIE5WTWUgS2VlcCBBbGl2ZSBU
aW1lb3V0IHRvIGF2b2lkIGNvbmZsaWN0aW5nIHBvbGljaWVzLg0KDQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QN
CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZw0KaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lDQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1l
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1udm1lCg==
