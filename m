Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27D2C433E3
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 16:19:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 948A720748
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 16:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sIQzWutM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="WpjbxUpn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="CtKTCcjY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948A720748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Y48boiKHxCiNy9apD8A33fTc+YO5eAp6R6VVg5mBluE=; b=sIQzWutM+bR+SWb9BOcDMBs+62
	sgjWlRVS/mjI8P5BgpgYEhxF4opflAnkWv0to6MRywlZw9jtA+97H6qrU/d/NHf37cCpbIrXu0SMj
	Dvxoty4KQesHdpIaKF4V1Q1/YCGYhW/9TgyRgx8r8o6a1cWK1dFb2kliZedCKUXcBpyZWEZvEn/9M
	dPc9LKFEtoybbgMUOXRox6+KuRLq41H9Pxboe0miLmBTbtb8tG9h3jqXAw66AR3fuJxP707WqY5Gx
	k2iPWufccBOxlkWreiqZ3ll3BEfj5aYZ8B4Sfn8UBPHqEWjzKmO1CSQ+UbU1nlXrdWXlHD9bW1XT0
	M5lzrA3Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7hrO-0006Xt-TF; Mon, 17 Aug 2020 16:19:46 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7hrL-0006XW-3L
 for linux-nvme@lists.infradead.org; Mon, 17 Aug 2020 16:19:44 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07HFv8Vc018249; Mon, 17 Aug 2020 12:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=k+qxCFORbTXsAGv+o7yjUPkj2wWfNtUr4+JVdJn20Dw=;
 b=WpjbxUpnEdbbwSKwTi59DMsa9C1MzEMPk2lfkoOLUAM0Ok0moQM7wjVQEb41iE+7s7Qn
 9sl+wZzYe5f8NPEjrTbRUNDPZ97m9KluNRRzxkO62LVp5qzUvX5TePWjIbgyCVYvtxFc
 AXzQn2WFbTYXUolBXxKygsQ1by+y+93Kfvz0iUuHgcMQo9WC2PVG4FtNR3uHEZSuNh5N
 heY4mtPAtSDW7eAdy/T2uauupbdw6cjBN2mIH3lbfN8ikO/yYz8/+9URYEfwj8fty+uk
 iC4hbG4BGjQ7RCRoUv4GZdlzd+7rseSOMBI5YBHkFF4EOlYMwNy1bTUGcLQ5lXzFEHBJ mw== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 32xbqkwhm4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2020 12:19:39 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07HFwIix190398; Mon, 17 Aug 2020 12:19:39 -0400
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
 by mx0a-00154901.pphosted.com with ESMTP id 32x9vrc1rk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2020 12:19:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dp6OR8Fb4seCxqoTxsSnzDMaVhS0292NpA3X5NkdR19mPxoVQXTyAEj3jWK0lS6vNgu2QDqe0DnUCpsfaAxuU5SG+K1+UtRcgFeysWq+xOoTEnT9RTHn1V/R3Jr5BayTWL0kb+A5ckHvyvsO9uyZjDXV3IOyc5m8ZyNotERJl7kFpmY9aXTDFkZgT27W5/PVAFJD0ltBp/t/rflCmVw49YToZeGl+RRDmCA7C0GpKuLt2fqfMqUZ88VN1m1iTU1Kt/zyMZPBuW0IzPABcKh/Rd+7weyheWlcgujDnZ8fgQ4xoBaZ9V7O9B2TT7YksYY0/aryFpBCca+qM6oi2ioylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+qxCFORbTXsAGv+o7yjUPkj2wWfNtUr4+JVdJn20Dw=;
 b=XSha4r4kspiq78NvwGhgmKqMlkc9OzCqqdtA8hs4IgDpEdEwle396NEBaFZckUckp0EwtJ2dngml5+wSGEwP0Upn2A/e+w417oxaAJFeT4amlFe0th/CLjbHefTsRShQCO62AylCyiHenf4JLPd03+WaSkyL/KyfdXfTTs0SVExmGrzaA79Sjj9KEmakd4GwA9VNMB2pxnZZkfKLxTwVL00oqAlWR/6FvWE+SEUOZw0Id1rCDIGbNEtuBgdTJIcXrPmTIDgH7a5HkKV0L4Gka2SYNWp0J+iIRBkraP/naDRDkPwT4QgMO/oYubkKeVnQoi1u4ry6ApCt7H8bZrY5/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+qxCFORbTXsAGv+o7yjUPkj2wWfNtUr4+JVdJn20Dw=;
 b=CtKTCcjYWHFlqX2Ifc0oDjRdls4r4HKv0t6Truqq8HyJ4A3wndVS4ww48NaGxg2E7/3sqoLKNJDVaxx8BDle893gDp7Z0dvQY1gVSVEFacek9piyeMQtLPXTdzP9k6ZTuqw/7SbvYmOZ4ogIGibxhEux/EDxZuCP+op9zbbDMkE=
Received: from MN2PR19MB3005.namprd19.prod.outlook.com (2603:10b6:208:109::21)
 by MN2PR19MB3005.namprd19.prod.outlook.com (2603:10b6:208:109::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Mon, 17 Aug
 2020 16:19:36 +0000
Received: from MN2PR19MB3005.namprd19.prod.outlook.com
 ([fe80::d51d:2072:5eb1:10a1]) by MN2PR19MB3005.namprd19.prod.outlook.com
 ([fe80::d51d:2072:5eb1:10a1%4]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 16:19:36 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>
Subject: keep-alive timeout zero value 
Thread-Topic: keep-alive timeout zero value 
Thread-Index: AdZ0sdy8CKRfHdpASJCNTPHu3SYSFg==
Date: Mon, 17 Aug 2020 16:19:36 +0000
Message-ID: <MN2PR19MB30052F070D1839045AB6468DEE5F0@MN2PR19MB3005.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-08-17T16:19:34.9126501Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=89c44774-8f03-4c2a-a222-d520046e313d;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [141.226.183.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc0ff8f3-bc19-48e5-4d0b-08d842c955d1
x-ms-traffictypediagnostic: MN2PR19MB3005:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR19MB3005793389CD0995F90FBEE7EE5F0@MN2PR19MB3005.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ucqipX5nalSdiDiSeuEzqBzky+c4g0S+edgkrIqiEHYwwfRsS8sl3yHuJqu8xWMFRDMQJuPNDsTt+zy/jnVcuvlgeMfba+Wa390+oZ0nZ9E8jLNGLqjFnzu/Dn6Q+t7cAUCjw3BAygPnQ1mNrzyTyY7DZ6C/a/LawHoaB02lbak6tb/VN/wvtFNewYlBweDTGeHa6BdUC238g2VH5Q1MYfFg9DbivulUwhajmuMqdA8sRH5/xNDJzEFA69989FqqgkD00w6jBd8OIkQfTSVV4aUEZgUUG6WHTArkSshMK59G8wn2AygGK4duYNMImKIFm79Jh1BX9B/RJ26DpHicGw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR19MB3005.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(376002)(396003)(366004)(136003)(346002)(4744005)(6506007)(86362001)(4326008)(4743002)(33656002)(3480700007)(5660300002)(186003)(83380400001)(110136005)(71200400001)(2906002)(55016002)(76116006)(7696005)(52536014)(66446008)(64756008)(66476007)(66556008)(8676002)(107886003)(316002)(9686003)(8936002)(26005)(478600001)(66946007)(786003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: F/P25C/mA+67qlxSRTZ5zk13CyLPiJmdgjBQ09QcriZP0KPUI2/9J+NyNTllyTb0xSCavzXmevk2LCzILbxVh3rWCuPevAlfDJZBqRrK4DPoeDsShIB6u1/o0kn5DrpI4Ga5CwQJEDHT58qmErQaDbz4xnWWXMvl2/ORVYewFxFlCbkg9/F/Xvp3sPozL4XdVLD2mmffnmwErinTdIvH8NpwHhy8/x17wgCs10nwOZBGxaOj6NSuQ2y2Za6sNcLP9TAAquoigsLJkRJY+xP22mxspChl6HlV7hTAmXXX7m09Fl3Q3wcDQJI8W37FJ7xKKpB0RRdLCUG8IfKc24LVvKdosuNfV7KpKIZV1HbFfFaGjohR6Txy5tXn684pS6S+69WToMOd2FJ7/fYC9FiYMHZ78/MbM2hmXiPYJYt+kDM7fJ1pcNaB/2PSU7quVzKBNM3Rz8XpUpk7hKLgQTdNHA4E4Oa3+HQu9/TW7TzuQyXp/xW3Q0FVBdgnROqVglRKvpEfGWBotxCf5QDk1Hc9o3U03SHLM91YOYjgJUlHRDED2csyouA3lec1b5DCnURWjI4g6Coubl1+ziP/RhWL3V58kwyTfPMbC0bckT7smhOuYfrjLX4av0J/GUoOW1v/pVP4jgg2WlsQ+4HDf8kAkg==
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3005.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0ff8f3-bc19-48e5-4d0b-08d842c955d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 16:19:36.6716 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wgmY6Rj4uhvOajz0Y3BzK1UMkNy6UBXHc7xPBmYosHcIM9wOm2/EalCMXAiyJn8GSki3fvBcDVUAzFZl2xpSmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3005
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-17_13:2020-08-17,
 2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 adultscore=0 impostorscore=0 mlxlogscore=723 bulkscore=0 malwarescore=0
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008170119
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=835
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008170119
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200817_121943_409625_485B6518 
X-CRM114-Status: GOOD (  12.88  )
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
Cc: "Engel, Amit" <Amit.Engel@Dell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

keep-alive timeout is allowed (by spec) to be set to 0h
In this case, the timer will be started ('nvmet_start_keep_alive_timer') where ctrl->kato = 0.
This will lead to an immediate timer expiration

We thought that in case of a zero keep alive timeout,
ctrl->kato should be set to a default NVMET_DISC_KATO value
(core.c , 'nvmet_alloc_ctrl')
this way we will avoid stating the timer with a zero timeout value
(This is correct for both NVME_NQN_DISC and NVME_NQN_NVME)

What are your thoughts?

Thanks
Amit Engel


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
