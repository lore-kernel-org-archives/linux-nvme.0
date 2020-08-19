Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88753C433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 16:05:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F3E72078D
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 16:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QCl+tYpU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="Au6SaRep";
	dkim=temperror (0-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="ih/JInUr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3E72078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rbwVL/GpA1d6T6lTPPFCdSfkK9FJwbsM1qdoRZd0vNw=; b=QCl+tYpUAGqZmWCTat3Mkt/a1
	NJKWkCKTbkxiV01gKTcdh5Fc+7/YPe96G4w0BRrU0w8UzTVhtV5cQBtCip/MkmH1POItf7YOcFL1Z
	UtFUnh1j9GqW9s3Rbx7faxIcMObGbfGPWoGS5jx9DSKrVoitK7cojoBnNSCe6Ywett5jQfwGjqvOQ
	XDqolcRj+AjXPEAK0x23cj+CSXFhHwK21R9LEGA+XIU8VLreQiqjFU22deSx9an0A21p11q/3nNOF
	Wk1kp8ot1335/SqiH8KS6gu9p91DXiwmEJR9X+b1yj1V8oaVNias3cq0xfs4QvLC3jmAawc6cW4fg
	l85yBCT6Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8Qap-0003PS-NI; Wed, 19 Aug 2020 16:05:39 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8Qae-0003Of-FJ
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 16:05:29 +0000
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07JG2FTJ019826; Wed, 19 Aug 2020 12:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=N46NisczKD/CPeIhXggrDBZJ40GU1T7f+htyy6GH/t0=;
 b=Au6SaRepDENg/jX/FkeMgeWuq+B6Cbn5M2VQo7tLzLNdIJkFVBbHK7qVQWZwhmTDMDRb
 LdOAY/qRTlg4r0mkEogpaaNQXMqHi0w7wle4mH2E5ojmFfNdBRUyp2WQCiEwmDqvGWCV
 9GiKvYw5OlkKc0BOge0yjj/YQNKro8R6GEAIsLvOVGGEINl9Jvh2i1u/NolkJdlIkCfb
 BTistxgFOObSWGm+6OVT07s6bNEHmTwNSkiDc8H/lagWMLGTrTT7MzEsiD5weY6ArgmX
 l6TWu7eRJTG3q8PVjUzYFHIuN4aBEIvW88wN2DuG9Ux817LzHmJY8wsE4HQvrAmtU5uy 1w== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 3304emq6nj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Aug 2020 12:04:35 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 07JG1UcH159718; Wed, 19 Aug 2020 12:04:35 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2056.outbound.protection.outlook.com [104.47.36.56])
 by mx0b-00154901.pphosted.com with ESMTP id 33162u9q18-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Aug 2020 12:04:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cE6BPrrHNkPnvKfHQOceuOm7m27XH49eJ9vdPQuWh3zXCSAyozmuK0NvZOAqQCKKy0XATB+j4qrGHdTzs1qrZ1QiRYfAGyN0RkDSnB2MCjzwqPJttwtKxnckuOmA+5JCc5BJtqRiQ6TJ0scpdHazw43v3jaknlUSW7443eL0yGzlpJD7VYoJc0LvNkeNS5OaaYc73Q8w2pofQCElMH4UuVPlAoFecUiEHHG+mmMHRlD9YOmPsrneRIcNDacUlqUQ8xXxPTkNp3kfN4u72BOgbsMFLOK9TXdgU6pHH9PmfzDcDontE1b1tyXLKDlGlXlQjbuBCrQyRPWQoDORDcjYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N46NisczKD/CPeIhXggrDBZJ40GU1T7f+htyy6GH/t0=;
 b=HgMOQ4yWAg5AdeXsutfaz/GJQcqa5TWGfWFcW5zXWXqIBgJ+E1SoAS19y6FWGPviFDBBNxSFyrdxgLsF9kzNR9DYBYqa4CGJV77wnb+bkDn6cNwHzeBQG4FshnIWWxxC6Qney0Bsf9Oz/8De6C8g7412JZhx3Woi5XJFGHmr6ZWPMXZur0QFMPDIiBnFov6mBjWRYBs913cpK8MKpq9x/rXJz5jUzCajpQ9jLBORqphobVA4oeeH3LbKgQljv9bmEb0ep85oAb6S5pF+W7HGTlhPqSy51JDq4wDgzlzgW7rlik3OdHJP1NzJIpKxbgCjvukfAiL8sFGqdjvwxaAI4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N46NisczKD/CPeIhXggrDBZJ40GU1T7f+htyy6GH/t0=;
 b=ih/JInUrUf7yQLCyzR9+eCNkyKGsoAgo+KujkSv2cCEzlQV02uXdKeO9jbifkOPdyKTMg0jIiz8nai1zvasROjoB8RltLmU+IRhiX0tF7h2BezDasc+TlXkYPiHe+TtyjPy+c/fDWaxWaXQK77SvVB/+Oz6cqegqP6Pt/SuyQAc=
Received: from MN2PR19MB3005.namprd19.prod.outlook.com (2603:10b6:208:109::21)
 by MN2PR19MB3054.namprd19.prod.outlook.com (2603:10b6:208:10a::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 19 Aug
 2020 16:04:33 +0000
Received: from MN2PR19MB3005.namprd19.prod.outlook.com
 ([fe80::d51d:2072:5eb1:10a1]) by MN2PR19MB3005.namprd19.prod.outlook.com
 ([fe80::d51d:2072:5eb1:10a1%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 16:04:33 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH] nvmet: Set ctrl->kato to a default NVMET_DISC_KATO value
Thread-Topic: [PATCH] nvmet: Set ctrl->kato to a default NVMET_DISC_KATO value
Thread-Index: AQHWdSwQNt51xVzDuEiiv7DIlV0weqk+DpiAgABKkQCAAAEugIABJRfwgAAPwACAAAUT8A==
Date: Wed, 19 Aug 2020 16:04:33 +0000
Message-ID: <MN2PR19MB30050F8BE320428D55B32231EE5D0@MN2PR19MB3005.namprd19.prod.outlook.com>
References: <20200818065114.57532-1-amit.engel@dell.com>
 <20200818162731.GC27196@lst.de>
 <0b3027b3-e4ef-3e45-9b92-babe09e34e6d@grimberg.me>
 <cdb5a25d-ab1c-bd6f-2608-c51e169ad87a@grimberg.me>
 <MN2PR19MB300552C9AAC6400847E51042EE5D0@MN2PR19MB3005.namprd19.prod.outlook.com>
 <17f4ef7f-1a1f-4e0c-5219-117bc752d959@grimberg.me>
In-Reply-To: <17f4ef7f-1a1f-4e0c-5219-117bc752d959@grimberg.me>
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
x-originating-ip: [152.62.109.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20620d5f-8958-4622-2cb5-08d844599017
x-ms-traffictypediagnostic: MN2PR19MB3054:
x-microsoft-antispam-prvs: <MN2PR19MB305436578CF3552B9491A428EE5D0@MN2PR19MB3054.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eKNxOHWyDIsAURNGXu4Po4p5Yc6QQgg/wCD/kuZsZX1FQJugqZLCEVf8PZedtXG4SN/y+D9eX8Hc/AHUzE5suHxp0LwTpAIpacr+sSOKDhEP3nN/ngKNvm09IjwbEIXRoM83rhhAtMhAuCy/JoN6+qsTCMf1GG1WlgpmzuEyxQaRi6+cHKU/ePCY9Z4+YL6n6xckc2yGnGChEgSkhoYKUm+kcpTQVbAA5XfHYspPtQID7N/JcUk5fRY19/+ZHmO+NK3LzgTDxQl+CxSYhgiEqFKOUrV0Xgr458wgy2DD4TODSjaAF7T0alrf1oDIUo2Zu2/VCSiJxT1I+4ROHMKqoqpn7RtdNljapV4clKk4+1qGGfIGD1TSOwVDUh0uZZAPGDIuCZxVugyh7VvaVnCOCQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR19MB3005.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(33656002)(966005)(76116006)(66946007)(2906002)(83380400001)(498600001)(26005)(55016002)(4326008)(8676002)(71200400001)(52536014)(110136005)(66446008)(66476007)(64756008)(9686003)(86362001)(186003)(7696005)(53546011)(8936002)(6506007)(5660300002)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: n7RnRI4n9cBYo+76A3fYtf6uLowf5eE1imd+uHMTjt9wMZKqzu34mAeNdSI3zaoqo9SQsijmkWlEUK3rM3/j0lKVzOPH6U7lFqZnc9O8N56xu2mnydo4slX//zhojTtQ8TJmlqiyVMahpvJZIXNy6IImLWhOwyAr0gL+njwakfbwEkDVYNU+KKiayv4gyJQpNdBynQ3PCuErUzDNCStWUV+B2ttshf8kQ6ylQaRtAJfP/kYxdhE817OWhthoEpm3Cca/GcXB1mL6fsEyE6xOybbsY1eHGMlLr8BWRNSso3OHjSLccg4WChLXu5QUjYRd64znq+xBwJY+J8zPYP+ZNL0WNba6jeMh5fGRMd9LGmpheqO63h7nY3Jk15I/p9yns9wwYp3Og2Xzeo7c/n4neqfzDyIjRQk8Z75whrAULgi38VeZa864jekNpV4uhuotslc1BsGmN2hbET3L7STlMD1H13QRrPsQ28yJLRU8x6wbjOyGVDQZ0TC3ggaEiJPMycpf5mEr8ulkVznnzBUM/3toZTGo4PumcOosuElWdxQmihfK7x23+/LWmKG1fn+eXeECcdg4B0ipz+T9ZiEIDSVIB9OGim4x+c/G6akym6DZdDsLSAF0yb34uSZacLmQx5JHyhfiNZMWo9gMB03BnQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR19MB3005.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20620d5f-8958-4622-2cb5-08d844599017
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 16:04:33.1132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z2lEI0J4DK+y5c76SA/CAmrOi2pGVsJfP9PQaFmiecMUqbkZ3TY3bNd6SoWxwr/mywL69Te9C03LXiPbG+oSCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3054
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-08-19_09:2020-08-19,
 2020-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008190135
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008190135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_120528_761562_6479D3CF 
X-CRM114-Status: GOOD (  21.24  )
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

SSB3YXMgY29uZnVzZWQgYnkgdGhlIHdvcmQgInJlcXVpcmVzIiB3aGljaCB0aGUgc3BlYyB1c2Vz
ICh0aGVyZSBpcyBubyAic2hvdWxkIiBpbiB0aGUgc3BlYyBhbmQgInJlcXVpcmVzIiBzb3VuZHMg
cHJldHR5IHN0cm9uZyk6DQpOVk1lLW9GIDEuMTsgNy40LjggS2VlcCBBbGl2ZToNCiIuLi5UaGUg
TlZNZS9UQ1AgVHJhbnNwb3J0IHJlcXVpcmVzIHRoZSB1c2Ugb2YgdGhlIEtlZXAgQWxpdmUgZmVh
dHVyZSINCg0KVGhlIHNhbWUgInJlcXVpcmVzIiBpcyBhbHNvIG1lbnRpb25lZCBpbiBSRE1BOg0K
TlZNZS1vRiAxLjE7IDcuMy41IEtlZXAgQWxpdmU6DQoiLi4uVGhlIFJETUEgVHJhbnNwb3J0IHJl
cXVpcmVzIHRoZSB1c2Ugb2YgdGhlIEtlZXAgQWxpdmUgRmVhdHVyZSINCg0KVGhhbmtzIGZvciB0
aGUgY2xhcmlmaWNhdGlvbg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGlu
dXgtbnZtZSA8bGludXgtbnZtZS1ib3VuY2VzQGxpc3RzLmluZnJhZGVhZC5vcmc+IE9uIEJlaGFs
ZiBPZiBTYWdpIEdyaW1iZXJnDQpTZW50OiBXZWRuZXNkYXksIEF1Z3VzdCAxOSwgMjAyMCA2OjI0
IFBNDQpUbzogRW5nZWwsIEFtaXQ7IENocmlzdG9waCBIZWxsd2lnDQpDYzogbGludXgtbnZtZUBs
aXN0cy5pbmZyYWRlYWQub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBudm1ldDogU2V0IGN0cmwt
PmthdG8gdG8gYSBkZWZhdWx0IE5WTUVUX0RJU0NfS0FUTyB2YWx1ZQ0KDQoNCltFWFRFUk5BTCBF
TUFJTF0gDQoNCg0KPiBBY3R1YWxseSB0aGUgc3BlYyBzYXlzIHRoYXQgTlZNRS9UQ1AgcmVxdWly
ZXMga2VlcCBhbGl2ZSBzbyBpdCBzaG91bGRu4oCZdCBiZSAwLg0KDQpOb3RoaW5nIGluIHRoaXMg
bGFuZ3VhZ2UgcmVxdWlyZXMgaXQuIFRoZSBrZXl3b3JkIHNob3VsZCBtZWFucyBhZHZpY2UuDQoN
Cj4gTWF5YmUgd2UgZG8gbmVlZCB0byBzZXQgYSBkZWZhdWx0IHZhbHVlIGluIGNhc2Ugb2YgemVy
byBrYXRvIHZhbHVlID8NCg0KTm8sIHRoZSBwYXRjaCBpcyBmaW5lLg0KDQo+IE5WTWUtb0YgMS4x
Og0KPiA3LjQuOCBLZWVwIEFsaXZlDQo+IFRoZSBOVk1lL1RDUCBUcmFuc3BvcnQgcmVxdWlyZXMg
dGhlIHVzZSBvZiB0aGUgS2VlcCBBbGl2ZSBmZWF0dXJlIChyZWZlciB0byBzZWN0aW9uIDcuMTIg
aW4gdGhlIE5WTWUgYmFzZSBzcGVjaWZpY2F0aW9uKS4gVGhlIE5WTWUvVENQIFRyYW5zcG9ydCBk
b2VzIG5vdCBpbXBvc2UgYW55IGxpbWl0YXRpb25zIG9uIHRoZSBtaW5pbXVtIGFuZCBtYXhpbXVt
IEtlZXAgQWxpdmUgVGltZW91dCB2YWx1ZS4gVGhlIG1pbmltdW0gc2hvdWxkIGJlIHNldCBsYXJn
ZSBlbm91Z2ggdG8gYWNjb3VudCBmb3IgYW55IHRyYW5zaWVudCBmYWJyaWMgaW50ZXJjb25uZWN0
IGZhaWx1cmVzIGJldHdlZW4gdGhlIGhvc3QgYW5kIGNvbnRyb2xsZXIuDQo+IFRDUCBsZXZlbCBL
ZWVwIEFsaXZlIGZ1bmN0aW9uYWxpdHkgaXMgbm90IHByb2hpYml0ZWQgYnV0IGl0IGlzIHJlY29t
bWVuZGVkIHRoYXQgVENQIGxldmVsIEtlZXAgQWxpdmUgdGltZW91dCBpcyBzZXQgdG8gYSBoaWdo
ZXIgdmFsdWUgdGhhbiB0aGUgTlZNZSBLZWVwIEFsaXZlIFRpbWVvdXQgdG8gYXZvaWQgY29uZmxp
Y3RpbmcgcG9saWNpZXMuDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fDQpMaW51eC1udm1lIG1haWxpbmcgbGlzdA0KTGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnDQpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW52bWUNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
