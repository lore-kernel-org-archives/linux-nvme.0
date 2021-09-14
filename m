Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB8DC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 13:53:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D316112E
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 13:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F2D316112E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oHhKh+v2vccPW4OGxslSdTMvIzOlX+n+Sg6zllGYhxM=; b=iXMHRMJRrcOU1G
	DxwgERz1OQU7ifUWqulz2eodXZsVtDQNZ3NlQDT6V3p1nSupZhw8my6yO455tLYrL4r27WEfuOEwX
	s+Am/BIhnMyPF5SfQMZCQqsChdkp+EhDpfFtT9fZ9IZ1iqLOKpMaVyOL/oSgc6UsuH6nHdyCWhRwc
	E7Ez//zXoRlMZjI98G2k0spy5orCOk98mjGabKbTqWcfVnhC8zLSCOySV6RGUdVbCmN5aB3vYjRzv
	QJ1XAPk98O5NTa2Ls+Nxfv/5aaU7YmLTP+8wiGEyEbZg6/DOqs58YhiO0/ZkQVeWTLtEuzB+tp8y6
	eJ2TxZAjKP13i8HQKiMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ8s5-005uFP-80; Tue, 14 Sep 2021 13:53:13 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ8s2-005uEs-F5
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 13:53:11 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18ECosHp024447; 
 Tue, 14 Sep 2021 13:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/G3ALlxT6InPFDqj2k0K9i6je0X0m6z4uqGtdR/bBRw=;
 b=jTZVvqGEISyZxRMf6av5tIeh39XLVopBS4i0i8TLMr+go99qBphu2i/+91OeSFZjGbF0
 ojcpHiNwAW2aTVFaYZYYEQme+CKSG9oGK9cJJJhGCIjjL3RSXNND+Bh0vX86+Fxp5dm0
 x6+fFQd0R3Y5QC1EWsL6uZn19OeoLWQLwvGP5ppJH7EfBslP9n7/kXWzPH/SJCxx77z8
 mSkJX+/xVIwdcQNmXSd5pNKneIbnnlEZv86tuG56djJAF8TJZZ9kem2BfhZjK8u+fERY
 Mm4ZVoh3nX5cqKzqaR4PSvGmHMXNIgKv/pHeHhkkHGe2xPlfHtRYvVAXBB+qc9+n7qOW aw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=/G3ALlxT6InPFDqj2k0K9i6je0X0m6z4uqGtdR/bBRw=;
 b=PwbOjH8zCc0psidMIbgXxms25FWZGiZK0cCf4X2PlUmh83TDk2NJxOhOwErL9V2gnD1F
 dtTrrctiQctS0vLlZ4VbezO08NTnNk4vG1yy6qaZaMZ7TPmfT8jAxLl2/Nhg3aDOdy2u
 j3K5wSJ1Ez4loKJTBMKXi4GiIOp97Ol5iJ8o9AelYP2/2evfBb5ua5EulYh2GGimTMJs
 su3/qYQJ1Rs1t907cc+dnWadBVmda298/3aWNqYQSpPN2GRk/stTmJE4/+NI7IhNH0qa
 VtLYAkKvPcIVOqOlw4ev+bFlkKQs8zhoxVgNoGm3yKqd+YQpwKTOOHZ7vEvlcYRhqU3y Zg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3b2pyg9bba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Sep 2021 13:52:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18EDoXa3083166;
 Tue, 14 Sep 2021 13:52:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
 by aserp3030.oracle.com with ESMTP id 3b0jgd5dtk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Sep 2021 13:52:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJLjVI1/2ZExKYJ+XmPQ30j5s+33iVofoP6sA5oIQEK06647+fkGrIUnMwG4UZ1aXV7AA0HbSXJwxb1Qs4a/6pf98sdV22swHopgAaf3bO0Z88med71ukcoja7WT7SKsLIFdBw7U3DW3FfVAks7GrxNKsphyYyQoxFbJp7gldA6hM++IIHL4YudMPKfwifibxNIOzS/FRDkDsEbfUifVZ0Qlr8DNzy51ZxCKvWdqqLEbDUFFHumJq45LHoCSaS/4NeY4XbFjvJKWqrBj4cGvteOgImvt4BICFPUP0hPrTwAP0jUW2icVwhx2fLwmhS7uPLaxcZWc5ob1JJrH9rcIbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=/G3ALlxT6InPFDqj2k0K9i6je0X0m6z4uqGtdR/bBRw=;
 b=J5KSROdbpPTQ+8xhKdKc2ZigWb9s092sV/mf1hTjxqg2S+fc8FdSc82a6yliR3/DwrasNQaBYKl1Uzra0Iyl0hyggraxuS5CZsDl81oKai7xe3Yv+ibeVPL625ghKVIsOyHtKs7Mz1VrZrPpveuibk5Ju0908XSMzWpMRD4tF+1IGo2g7tbiC/jr4sO/BNhwFlWUZ+ZOyY4eWXvfP3pgI8y/bff8LZjlYlhyogGMYopxWgE6Krc5sbqbnCN4MvghGCHWqEpTmFR2Bdd5aP7ruMY+QRn+RU+I/ZKs5x11VtruCRqBEoAQddMOROMLB7qSZGMOWp9XUsUr6MYV/ebdgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/G3ALlxT6InPFDqj2k0K9i6je0X0m6z4uqGtdR/bBRw=;
 b=iBOk/iaGWFsTs/+dIYu3H0dRMhYL/BHt/LaQ9NCMuMDsULOU3GnebzDrxFDi7leB9Zi8sYKfmSLFmzUFExa2s04XCnEJ7wkttNewUr2UV6qhzEa1aflB0e3ejGqevXaXRthaENLJUlXARoycMj7LzDeuhtzVJ9fZcrJYh9hfBOU=
Received: from BYAPR10MB2934.namprd10.prod.outlook.com (2603:10b6:a03:85::22)
 by BYAPR10MB3126.namprd10.prod.outlook.com (2603:10b6:a03:15c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Tue, 14 Sep
 2021 13:52:48 +0000
Received: from BYAPR10MB2934.namprd10.prod.outlook.com
 ([fe80::d477:c047:7008:7696]) by BYAPR10MB2934.namprd10.prod.outlook.com
 ([fe80::d477:c047:7008:7696%7]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 13:52:48 +0000
From: Himanshu Madhani <himanshu.madhani@oracle.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, open
 list <linux-kernel@vger.kernel.org>, Hannes Reinecke <hare@suse.de>, Sagi
 Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Ming Lei
 <ming.lei@redhat.com>, Wen Xiong <wenxiong@us.ibm.com>, James Smart
 <jsmart2021@gmail.com>
Subject: Re: [PATCH v7 1/3] nvme-fc: Update hardware queues before using them
Thread-Topic: [PATCH v7 1/3] nvme-fc: Update hardware queues before using them
Thread-Index: AQHXqUm6T6C82dUskkeD5PNmrxWv4qujjQWA
Date: Tue, 14 Sep 2021 13:52:47 +0000
Message-ID: <6C03188F-7715-4DF9-AC7E-52FC975ED214@oracle.com>
References: <20210914092008.40370-1-dwagner@suse.de>
 <20210914092008.40370-2-dwagner@suse.de>
In-Reply-To: <20210914092008.40370-2-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2acbd7d-0b94-4e8d-b0cf-08d97786efb0
x-ms-traffictypediagnostic: BYAPR10MB3126:
x-microsoft-antispam-prvs: <BYAPR10MB31261340C4FEA963A0C95D38E6DA9@BYAPR10MB3126.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jlme3Je4zGOEzzcaBt6hochHBzi/qEwT7D1gT1WYk4eikQizFeC2rx2ytcsKVEabXHKVgUurLdDgSg42TyL+5A3l2yNRIXfIJfO5MKN74y7ETfUhqViniG7u+lufWKBa1goyQk7Editb1QzYQ4rA96d3s6FBUidOlB9eaFdgoQPTqFRHBWcFJHBmuyJ+EwxAiNWpWgGD4j6ekY7SSt44gzwj9+RfgWqu4RxItWArvwTx/YAYxjAD/hgDHDuj+s0yye3y/tyxlpn6rYptIODxacRWs1EDdQ78DQJhs7W/mwNxUlBlENfPrLzOSjgTE8CGMJbulj4bze+6utJYbTswru12KZ+oml5jlWp4pNVNCFlSUZNDG+F5Zwj/mVrA/QYfTH37Yv5dSr8v6EuWXeuS2AGOa3wum7zAByrEDnhlOTMyb4zdjszaVnTgBF8H4X7elzD7LpZ5loTo1SG4CzsMJvB5B+uVrHxOGO8ieqjoFvnpjzlNnnHHj1I/Oppv4mF92wcvDDV2G9Yd+GrJ9cbSULA81PWGn5TMu6tQHrQuATOh+abrnse4z50pTU3g1iTBlorvgm4RF2/HJrLgAH7jsvH2QvVfrZb/417FelNvMrbY9nAnS4zeGZpoptc8mzclbFGd90hBQeBRo7AnSZCBNKnERJr4sja0l9xU4urzCudg8V0NgWu9VvBYoaKjyqMuvMAgYzbVvZ8CQfjEwaqJ71WPqh/Vd1uEg4oWaGhOXQKrv81V1HluNU5j4Dtl+XEJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2934.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(39860400002)(396003)(346002)(136003)(366004)(6916009)(5660300002)(4326008)(36756003)(86362001)(66476007)(66446008)(64756008)(38100700002)(66556008)(2906002)(478600001)(186003)(316002)(66946007)(91956017)(15650500001)(6512007)(8936002)(53546011)(6506007)(76116006)(26005)(83380400001)(54906003)(2616005)(44832011)(6486002)(71200400001)(122000001)(33656002)(38070700005)(8676002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wzof+FX/dn/QHkWExb3Y+tp7zAukqmkXu94js1aQovKxZUL+RUuuVaS3lb3O?=
 =?us-ascii?Q?j4OMA5rFtt42vVaFVnqqAUL0HRR6snKNX+CslheEsXLqcnggscShah/5gBYO?=
 =?us-ascii?Q?ATYiHR7haYfIm+XubWEsSBa+1Djum2Dr3O1spygxZ1ge5+QDkTMnNk8mSXzp?=
 =?us-ascii?Q?w4jBR1HuxWYa6Bd4tUVE8zqvsjOlQSjHW+tLcZCUJ7O79/ANRrzE72Qj9h3e?=
 =?us-ascii?Q?gAy4Ga92WWF5GgWwm7UYXAI/DgvX+rqvEdjE+Gov7VGbpiYvtRijJbeuxGAF?=
 =?us-ascii?Q?arNuBmsLMsNYvIUxhzclKTLoRr3pLwW/lRtqrpZaY3pOx6j/u7Z/zakCe6Mq?=
 =?us-ascii?Q?ZgLneycAbzZ0Zcgu7CD76zdBMgF+UMelcWIVfN2Wh+OTFlpQHBHJ3e+FgKQg?=
 =?us-ascii?Q?Sz0tvfq9vVIe8h4PGYUOLNtip40JgEldXxXjml6qs0gfLZtznZP0+orAvyR/?=
 =?us-ascii?Q?A/WZxeKp2Xkqu1G2yCIN6ykSzBqFTJkCdzKunfHegiG+m+AWjRedK0cYHQy4?=
 =?us-ascii?Q?FhgB04NadtS6mp9MmCU05DNrXqO6ANZCAkBFQ5zOvp3G2kyKkp9wfIT+Bg/d?=
 =?us-ascii?Q?ozM1v1WSsKEEiyMIzQWlkBwpeY1OveXf6q8IrWG8/nxMapaEw4qDMOO/fzcq?=
 =?us-ascii?Q?1UlDYkt5ieelwCph51q/TqW0aOLOGHMO85mZIVt/44faJooEyEDfH3dewBDG?=
 =?us-ascii?Q?34yVRVzyZhhXKvSInfl6eqkII/9VZF2HoBvlQb/24fxZYKxHcanv7HCUnheC?=
 =?us-ascii?Q?gSF3AqE97tzEcO4wH9CGd2mb0M9cXSh1zZQkSWihnTbArkP2+ifsNdSWgaAb?=
 =?us-ascii?Q?hQTXQ+qd51gHq6gSI381l9Gza6uzhymqUxxAJoiXvuUZtaVag/uE1Z+ukJE6?=
 =?us-ascii?Q?qqYY2aGOo2C2R1wdiR9MV93WXgeAp8+sYOdsNuZarMscfx9DoXX8tFW3d2g1?=
 =?us-ascii?Q?lMmaD7TAcWSl/fbYa5WJ8SGkTvWEIWJv2wxWbx7qMY4NuqoqTDp8f7JppHnX?=
 =?us-ascii?Q?pmQNLPgpeOlw9CXd7ASJPwVsND2iHC7PRIccERvSFzW4+97/mWkZ9UUzOCrV?=
 =?us-ascii?Q?bnEOLAorB0PcjbMlyR1vdll3tnGqn+Aj/0wynYBoIVWidZEIGya30navz7LI?=
 =?us-ascii?Q?bbRo2fmkEERcsXM+Yp0Y2JriOKSsYD7lVxtOYuuqW6kT65oomTYaJIRhPPjc?=
 =?us-ascii?Q?7oGfkEW+Y3UyXlXsYewjLKb3oYXHFsb4p9ZgEJh+LADWGhUpSmIUjifo11Go?=
 =?us-ascii?Q?naewU41gagnSLyuGo6Gk7DxZRRcb27W9zWQCgs6NiFrXg4lttnNmGVSWAsrD?=
 =?us-ascii?Q?r0eGt8kBYqx/49tq4TjxpomH9X7GrXmTR72vUePeD3MBjQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-ID: <67529CA79E2B904DAD2C163C5A19C1F1@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2934.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2acbd7d-0b94-4e8d-b0cf-08d97786efb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2021 13:52:47.9643 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eY3O25tAaN3ii8r5mpYtoVfGX3FyeZYIw2pvkPF6A3VV24CHJUOKRkB5zZw/nMDUK/gYDNESv4N6pe0EoTUVteHF1w/8nEugnYVxTSg9zbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3126
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10106
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109140086
X-Proofpoint-GUID: Z-FArGX88vDMXqOtRacozcKd9fU54kOn
X-Proofpoint-ORIG-GUID: Z-FArGX88vDMXqOtRacozcKd9fU54kOn
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_065310_562212_D1F94511 
X-CRM114-Status: GOOD (  27.84  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



> On Sep 14, 2021, at 4:20 AM, Daniel Wagner <dwagner@suse.de> wrote:
> 
> In case the number of hardware queues changes, we need to update the
> tagset and the mapping of ctx to hctx first.
> 
> If we try to create and connect the I/O queues first, this operation
> will fail (target will reject the connect call due to the wrong number
> of queues) and hence we bail out of the recreate function. Then we
> will to try the very same operation again, thus we don't make any
> progress.
> 
> Reviewed-by: James Smart <jsmart2021@gmail.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> drivers/nvme/host/fc.c | 16 ++++++++--------
> 1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index b08a61ca283f..b5d9a5507de5 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2951,14 +2951,6 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
> 	if (ctrl->ctrl.queue_count == 1)
> 		return 0;
> 
> -	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> -	if (ret)
> -		goto out_free_io_queues;
> -
> -	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> -	if (ret)
> -		goto out_delete_hw_queues;
> -
> 	if (prior_ioq_cnt != nr_io_queues) {
> 		dev_info(ctrl->ctrl.device,
> 			"reconnect: revising io queue count from %d to %d\n",
> @@ -2968,6 +2960,14 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
> 		nvme_unfreeze(&ctrl->ctrl);
> 	}
> 
> +	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> +	if (ret)
> +		goto out_free_io_queues;
> +
> +	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
> +	if (ret)
> +		goto out_delete_hw_queues;
> +
> 	return 0;
> 
> out_delete_hw_queues:
> -- 
> 2.29.2
> 

Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

--
Himanshu Madhani	 Oracle Linux Engineering


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
