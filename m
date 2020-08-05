Return-Path: <SRS0=ZkUF=BP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF2EC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 07:14:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF20721744
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2020 07:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lxOMFXAJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="gFyojiF1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="bGIWK9PI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF20721744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=X7IUo2+dyCM+43f9GjX4QvYsfLPf+M/oD5Gstbis0mo=; b=lxOMFXAJ2XmyimftYN/sNoSvJM
	bFNYcEGZ7Ga2yt7qGR+49eB9lffw5ta14MG502wHqU/+nupeEBe1D0nnrIbulNjpSAFITB1HkOstT
	Ib+zss6G3c9cOeCrC4k+Qrv6C3oOprUGNROUw+O/NcFEGsTrndaLNGgU+2ec/3srf6KlNoGJl8m8z
	jCFV5rGihGupaMrsiR8HVgqb4SOg2++ojobZGnt0sOWOSEjLaRxSMgaD4oTOwDt7wY/wrEdM1PGJn
	KIGiOi++BfqwBoUu/BCt/di1M07+zhX1EVRCf0MD52CjeMCV/SHHqLDIQQj/1KOqO8GU+aZAGu0yB
	mPBPhOYA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3Dd6-0007tZ-7g; Wed, 05 Aug 2020 07:14:28 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3Dd4-0007sZ-7P
 for linux-nvme@lists.infradead.org; Wed, 05 Aug 2020 07:14:27 +0000
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0757BmkV001666
 for <linux-nvme@lists.infradead.org>; Wed, 5 Aug 2020 03:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=J0jY4zJThsULO0qZT7aVt2CV6o0u0VfaRq6nwF/uVhQ=;
 b=gFyojiF16h6c6LzVlQ5//nX0cI0DAw91geqyDqJ3ah2+eKzFoMr1QJ139jd+V4Fn8/DD
 /qX8sI+7TuHWowYc+luHYHIrXLpFows+w6DAXWIM7/IwXwYY5Zwe6g7sicWFqeRsfsp/
 E1/JsqdDapT0JjGXksgrLN6UsF6+wgXHuGbCl145RaumxUjdraLT8PgZuAj6bPipRdhn
 8w9mWLsgmS4hkK+b1POqV26T6bmUVa/xzU8y/Z/StkFJtLohcmlXCtB0QKyzn2WzNqVc
 v1bq7ilazbZ5g0DEiz8G01iWebZMQkOdhlqtQ09Kw6D+bqhGbZwD5JPjuaHMaxx0yOn6 uw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 32n7tsm2h3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Wed, 05 Aug 2020 03:14:24 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0757EF7g167643
 for <linux-nvme@lists.infradead.org>; Wed, 5 Aug 2020 03:14:23 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
 by mx0b-00154901.pphosted.com with ESMTP id 32qq4u8m82-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Wed, 05 Aug 2020 03:14:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhuLXbQI9cUuU1HmfdPoI9dHdrlUh8csZZQQUcXBzjTVF06pX2qkHi6VqvFlmOhlIXcXzZHa7Fw+mCt2FI8daub3DFuITgu0GKRF3+kStQWYTM9SzcfOjpMsrhRzQAQ904PdCXmuj/RZBEAR21M1gwQF92LutdLMp96Na01dEyhA0QHThDkyutvbuyy/uOEEfwhP4XPPT6oTBtLT01Bs+bNlpLDhAVOttHrJh3mqEoNG7SFTUrWTciXkr5AhuBCarJ4KrrNEZs2l9G3frVQNOWEfb40HUZUzlOmuD+rEJbmyQJ5RSp6zTviGLV9t7/Kw5SCiCgsLepwSoVjSFWXwqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0jY4zJThsULO0qZT7aVt2CV6o0u0VfaRq6nwF/uVhQ=;
 b=XR9qf9hGCGvilXR6yj3Bd3XS9iX5uBLJzQGa1rarIFpSKPT7wfbT+VApG1ufYlPWxL3W/QFbOOhzXplbjEmQVd1qB20VmyXsuvGdbTq7CWdhUU6s//moPVVJ0k1H3vMidowyocUGr2MgZ0uosngPU941RRO6dkEMg03FdzhqKdGgoufB/W6vw2Df2lxjkm41vIK0W9roBR0uv1MvGCk7zmK1dNs8q2RhatuZnDtC980QKRsv2RtjzQnLmuc6NGt887Gp+MSoAzUFeQSjT+snsVaMSd2oIeQOHR2LtJKdM5KJditr2VhAAump4HEg4UIiKBLguD/TZsrFaQHofSlxxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0jY4zJThsULO0qZT7aVt2CV6o0u0VfaRq6nwF/uVhQ=;
 b=bGIWK9PIWyqaSQAyIdHjNNlbE97MNJK8vakSybBbOZ3XbT7prJSUrJB8Rkz7wAef75vmUAVRd+tKuRy3SDlFUryTcIcYEBqkeaSMed7bCtiF4puzBm0Vt7jeSAY38DKRfZu+2q9ZJN3me8CCZukvmGzKo+cMlWrXdxKolfzkPaY=
Received: from MN2PR19MB3005.namprd19.prod.outlook.com (2603:10b6:208:109::21)
 by MN2PR19MB2815.namprd19.prod.outlook.com (2603:10b6:208:f8::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Wed, 5 Aug
 2020 07:14:22 +0000
Received: from MN2PR19MB3005.namprd19.prod.outlook.com
 ([fe80::d51d:2072:5eb1:10a1]) by MN2PR19MB3005.namprd19.prod.outlook.com
 ([fe80::d51d:2072:5eb1:10a1%4]) with mapi id 15.20.3261.017; Wed, 5 Aug 2020
 07:14:22 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: nvme reservation commands during controller reset 
Thread-Topic: nvme reservation commands during controller reset 
Thread-Index: AdZq9/uNS/3GoWeGS1CKT5X8UElmUQ==
Date: Wed, 5 Aug 2020 07:14:22 +0000
Message-ID: <MN2PR19MB30052441F4F22A4CAC8D396FEE4B0@MN2PR19MB3005.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-08-05T07:14:18.4984417Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=a0d0aa1c-a7c7-4915-a852-a4cecb6fdaec;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=Dell.com;
x-originating-ip: [141.226.183.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdeed128-c7ae-4d21-9643-08d8390f2d8d
x-ms-traffictypediagnostic: MN2PR19MB2815:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR19MB2815536397267C8E7E784D73EE4B0@MN2PR19MB2815.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1vnGjdzeXv+b77H3bjOxdVSJywAz7ogwsFxluQp02WeWBaLWiGdTPOBDbXNGpKIzjj4/mt5+k6gMDYYTzsOOFwaFfTGO/n37hguRHVs5k6aro/Q6frfT4mc2gcSS1jVGkiJCT57fqQRNtthRcXXzSMKzGp/lKV6rtVWUo309YVx+nLtyinY6z0S9n9GU8G9lTDMUtGb7/5xWM92LltC+K7FuSoBq2IVYglzz46CrOiFjbcISFAZjEkODsOSAUliFqvf2E1tiMzNgpWhH/QxAvBbmrdMb1v7GdE/FM1MatwE7PQ90STxz8a2yPefaXud5FVYXk70ZZ0GWtCkXa7ERHQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR19MB3005.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(376002)(366004)(346002)(136003)(39860400002)(71200400001)(86362001)(9686003)(55016002)(4326008)(107886003)(478600001)(6916009)(33656002)(8936002)(83380400001)(316002)(186003)(4743002)(64756008)(66476007)(66946007)(8676002)(2906002)(6506007)(7696005)(66446008)(5660300002)(76116006)(66556008)(26005)(52536014)(786003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: gAz2OfFuw/WmjD8n9f/Pxe9jC7/FW1F/kBr2MueU8RVkf8gfOa6z5Q1na5q3GPH4BHlPQgdQOk1xBReAmz06TmW3qccdOPPgURgNU0h0xFhQ2NAjdIydo2/gXmPlrNCYwfE+0p1QGSAr+Uk/4Be0o+EDwT6rsNdyQZ+m66yJCqCyaffO1zmNqKEYpJneo3+jBhbSZY7xLAoam9J9xxBqPIrEAVJZQmaKm57IDR8N96znnw8p3dXHLOXLKtbFIgPLnUebdKihAtaXXN1O+TTYSvtmZxT84FbmQGzMw5WfaKvyZYKeMAW2FjkLadD24MrpqDRX68KqarffepnE31mdDFIMNQD+bRiMyhYzJGfor/URFaZLGU8nJINzrwzx4nwnU37eyg4vEtUxsowy+vnIbXZap9Fet0mQfVcLCLUpxHLka1EVX6qh7bjvjK6EB7JhMlJnkqO2IyyjHCnxbdoVEPoLKF5pTgva35wIlrJhaK8z++XmC0zHCOV0CgLtzNB+ahxk3RxhRrZ45X8cXnLuLV7ILOSViiRn8Dta54T/9GzM5qd6oitwgKfrEyGl4jK5ussvsSiL2NbePTDR5ZsYmlbPGorpPSeUB3ZlfIb/JtVwFnUnnm9jyjUNh0wA83TnhRR4BNA80ST4Byhx6ddxTw==
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3005.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdeed128-c7ae-4d21-9643-08d8390f2d8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 07:14:22.3102 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bgmDC/ES65OWAOg1w0jKDA2LhzJm+9n/QU23miLVshlw5tFqGQnmamwuFNo3pdPcNpEfen4lWGPB5c0WzF6Xog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB2815
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-05_04:2020-08-03,
 2020-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008050060
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050060
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200805_031426_456414_06EF5CA2 
X-CRM114-Status: GOOD (  15.52  )
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
Cc: "Anner, Ran" <Ran.Anner@dell.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello, =

We test nvme reservation commands while controller reset and encounter a pr=
oblem
The reservation cmd during controller reset fails on the host side with err=
or code 0x370 (NVME_SC_HOST_PATH_ERROR)

based on the host code, nvme cli/ioctl commands are marked for failfast (no=
 retry)
This is also the case for block layer user space API for persistent reserva=
tions (for example: IOC_PR_RESERVE)
host/core.c 'nvme_alloc_request' set the flag
req->cmd_flags |=3D REQ_FAILFAST_DRIVER

In case of path failover, the host will fail the cmd with status NVME_SC_HO=
ST_PATH_ERROR
host/fabrics.c:

=A0blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
=A0>------->-------struct request *rq)
=A0{
=A0>-------if (ctrl->state !=3D NVME_CTRL_DELETING &&
=A0>-------=A0=A0=A0 ctrl->state !=3D NVME_CTRL_DEAD &&
=A0>-------=A0=A0=A0 !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME=
_MPATH))
=A0>------->-------return BLK_STS_RESOURCE;
=A0
=A0=A0>-------nvme_req(rq)->status =3D NVME_SC_HOST_PATH_ERROR;
=A0>-------blk_mq_start_request(rq);
=A0>-------nvme_complete_rq(rq);
=A0>-------return BLK_STS_OK;
=A0}

What is the reason for setting REQ_FAILFAST_DRIVER flag in nvme_alloc_reque=
st ?
The original intention was to mark only sync cmds as failfast ?

Thanks
Amit Engel


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
