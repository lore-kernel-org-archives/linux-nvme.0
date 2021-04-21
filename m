Return-Path: <SRS0=D0Wy=JS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF33C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 13:29:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84DE06008E
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Apr 2021 13:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84DE06008E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=92XbN9Nnra1uEZScyN2koXwZsrS6/eA0cTV6TxnjSN8=; b=J8ummR1PNRDMUL/FHY7KBrCqQ
	5ldzAm7HJIcg4PRzmJPxS7sQODqH+DQ9FBDpXKoFMAYIMhha3dNhM8CqtFOPfwogNVFS98hICdzrU
	0haNyBAHUmhOjMtHjMC0y8QS25suJJXi4TA43pKE7HzZyr3Hk2DpLVp9VWvT7XXNTnh+6v06dCL/M
	BsuqC+uljXDI7oN/xZ+8KmodAuUywtg9Su7EkGIWqYrSk7yHHC6UL187uSq2jFVtZNhBFd1G7elCi
	bS5ZzWE3HRiOkhVSCxbODWxoS7Po7lXyAkxZFXhViCLaPt89UaojV/icwVWqKD+r/tmQK6QFIB8L4
	+VytEooZQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZCvB-00ESpg-N1; Wed, 21 Apr 2021 13:29:37 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZCv8-00ESpJ-VM
 for linux-nvme@desiato.infradead.org; Wed, 21 Apr 2021 13:29:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=a8DKOcoQ0AS9RFsRzhc/5tEA1G3X59YvFHZ46wkWwbo=; b=w/qCPaO8ZcwTEtv4yP8n/t4rh7
 3EHlW0YMDRagagbpOKkVAgA+1sLz52b5UMCpw1FLp4wGENlgnGuRHMYbNHGbiXDXI2GutFXkV9TTD
 DSRNPX8mUpL6NR39QNqen7TL+UDoSoSa0DQ/Ns+arvMO22qOFOg4XrFmPJzSPIS1NdC82xKIYeFlT
 WWYb8rYa4uNVDxU9/NvvxGbPet4n0v2mtCtAcAZuOm/qUqkBf66OJ5IZpKsBxkmsamItdIkuqnGsm
 WOLQV09nIbwYXLmnOw/wc57DoHL/JZOpZNdWSJLEI+6QhcIIjdg/GMJCrrz60uljJDMuq6R90dGT3
 6gNgfD7Q==;
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZCv3-00Cuzp-1L
 for linux-nvme@lists.infradead.org; Wed, 21 Apr 2021 13:29:33 +0000
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13LDRE49017733; Wed, 21 Apr 2021 09:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=a8DKOcoQ0AS9RFsRzhc/5tEA1G3X59YvFHZ46wkWwbo=;
 b=wu13tgvbUlZm2Eu4MZgxyNl8vs0T6tO2iTIHjB8l3v0LVXbbYB5ibqnowoKWtuiMoRXb
 FBe2LZXUuQmDNSbOtT3tm7T9MIvJm6iMsmo0WJFoPYK/YYL4kjFxApnUl3UTQSCMeDuQ
 1/ZFJWLj7dpXHsv2tjOmAklTY62BpA68ehJ2PL8BjFqpnWt1w3t3MtcEKNwzENyzkrJm
 GQlHIHT5OdOgSgrnUG8D/5B/NHf1K7TJBgk9GlF4jcpm5OFu4lD6KxyAb2igQIJd/IAq
 H3tDKp7MRndbpMULz8eNINK2gTIF2Co68/6wAMKmSpOTB0cUII7QxesRFVa8+twRCfWb ow== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 381kdh6s51-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Apr 2021 09:29:24 -0400
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13LDJeLX031093; Wed, 21 Apr 2021 09:29:24 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02lp2055.outbound.protection.outlook.com [104.47.36.55])
 by mx0b-00154901.pphosted.com with ESMTP id 382e8qnv89-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Apr 2021 09:29:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhhGRu0MD8APcYDxj+s31OGLflzWr7fO/EpImSXOT/+mbS5pLVZgHkYgS9N2Bo99zfn0PT5H/hwS7856qavQ1G4ubWaU1nYxkx7J2hYl6r4cAl89fhsZztQvdQjkQh7ead8v46Kx9b4i+WqPvKPF0Z1j5LAnOxV0sQDe24fJdvY7cgMmziJqkIZhw7c8tviQs435E3qXIxvCP0Zl0oG62dp7MwwLVenkTA/FOSHy+LvH8l3n5312ERiJTINC2JMQkoJ1+6JZJ2ZqLVBJ+y7uTtb0cXmHGERc77PgsiY1t6h1ydnhjOg8/18U0HFFnir+9SGPcG/7QTGTUIGJ5Zt9ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8DKOcoQ0AS9RFsRzhc/5tEA1G3X59YvFHZ46wkWwbo=;
 b=btXT4xD+AFHNIQA0f9c2Es5gmItxau0ecr7QjhqaH/Qz/U4gHwmJ73x/DHre2xj3BAKgaV/uuDYrTVaV1PXJFxdwdWEDlQIfKElCsNm1rDueGNnMl/l5aRzhcxh2aXT1+k6Ltva7LLeNIVCQCPQRaZl5UvLRgQZ2j1NMsPfvpK0r6bFK05TzBiKTDXexUMftAS2bb5Fsf2un7d/o63kA2j6QNQojN4jS1Zx/OIKc0GY4lwlWNT+sEB80IrvvYLjCLCVV3UR2CDEJWpPpOm00fDbfuHj3uhDv/P6gYTPf5Ync1yNMNFjObFJ0m+nS7lqnglBo3Mq/CYUgfbpLcxqIbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BL0PR1901MB2020.namprd19.prod.outlook.com
 (2603:10b6:207:38::12) by MN2PR19MB4096.namprd19.prod.outlook.com
 (2603:10b6:208:1e2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Wed, 21 Apr
 2021 13:29:22 +0000
Received: from BL0PR1901MB2020.namprd19.prod.outlook.com
 ([fe80::217d:8aae:7fb3:6e4b]) by BL0PR1901MB2020.namprd19.prod.outlook.com
 ([fe80::217d:8aae:7fb3:6e4b%7]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 13:29:22 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Hou Pu <houpu.main@gmail.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: RE: kernel panic due to a missing work initialization in case of zero
Thread-Topic: kernel panic due to a missing work initialization in case of zero
Thread-Index: AQHXNlaTW+sSkbzdnki//B8xa1fnH6q+8rqQ
Date: Wed, 21 Apr 2021 13:29:22 +0000
Message-ID: <BL0PR1901MB202094CEE464326497214246EE479@BL0PR1901MB2020.namprd19.prod.outlook.com>
References: <BL0PR1901MB2020A15CA929276AB8FC7E52EE489@BL0PR1901MB2020.namprd19.prod.outlook.com>
 <20210421023205.8743-1-houpu.main@gmail.com>
In-Reply-To: <20210421023205.8743-1-houpu.main@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-04-21T13:29:19.3857798Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=849935aa-b82b-471a-b215-45ddaa61d379;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [141.226.10.89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8cc7ba3-f739-44c2-e6c6-08d904c979a3
x-ms-traffictypediagnostic: MN2PR19MB4096:
x-microsoft-antispam-prvs: <MN2PR19MB409627A3DA61ED973A395EF5EE479@MN2PR19MB4096.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ie0BRNwleNWGkq0PPpCgYifLrjR/0p8SlTex1yce3sIGN0ZeJv9dXiI//MSqRuTOuBe4zPOo004B0RYolZvI4n5C/ufMCxqS0KMgND13ZIfiLo0Xj/P+xS3h82IZ+E3RX44wszT4sQ+HTTQlRQEwInUd1Q8/bPe7rRySPFIIS54cS4kEc0AuhyGT0gLuuJ/vQlCEEm+ExV2NRhrRvKYCO3yhz0IhWyM6ImBuLGhXcVkqAXJ0rMEw7VeMtB6Qi4skVjod7kDzMU1ziqoJRW9xKjW1W+qSVHcwGWPoSzeQvbqtydqxePqaeN7KHeljbFK9cZ1D2nLnFZ4X7SSx57PHPOS1mnRLA14Bv62bp4VU7V64cKv/ySLi988WJI1KrrTCWGg8Gk3cLz3RDs+qhJ7jThPpPIe00X0DsQwFpX82VgiOU9Kojf/OH9IogJNvy+L891lxhwFW+WNR63mdFIXaRZeWAetorMB2EIhVtWl82OmiIwhjPDkcFb6StMRXxVmE3K0WUiPDvpjnFYL4a3etML1ZGr23X/nGisJf1h6S9OnTGMrvpNizsjay+2/1/ip7Rz1l5OqF+6CMTWjy6RlhT735s9Ph4ZtVoqwnVd0jkJ8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR1901MB2020.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(38100700002)(478600001)(5660300002)(71200400001)(66446008)(786003)(7696005)(2906002)(8936002)(55016002)(66476007)(122000001)(9686003)(83380400001)(66556008)(4326008)(26005)(54906003)(6506007)(66946007)(76116006)(316002)(6916009)(186003)(53546011)(52536014)(86362001)(8676002)(64756008)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OmWsIhG1elTSSXax7LgfZue81gq6+oY4rLw3wmYj7aQcPG/8gdwmRZY5yu24?=
 =?us-ascii?Q?9Ep0YZjJ5BMOF9WhrnFRZtyt181aE0Sp8vIzJcUx+gLpw3c5BIupg/eFXDbp?=
 =?us-ascii?Q?+Uakvi4wwjVfMeRkEgeLB2zsE28foH5H34om3uRYds2nVs9B5TtOdSH8S1jS?=
 =?us-ascii?Q?WM70rLpLq1EgCbW5NYgib5TV/ml4qepK0kcAy7Jrk7Q3mbatbX7jOCRh+Hez?=
 =?us-ascii?Q?sykNu2F0T6BU8ZnIQUfFQwTk78PrjaNYps75tvoTB4f7Yp5a6fc7X8WUZmTP?=
 =?us-ascii?Q?k6H+tb851fAJhm9Jll0m+PxCeTamTUCwCUVaEHP6EfcOuVMLaeRYAgk2ts5d?=
 =?us-ascii?Q?Cd9eXIG6OKk0Up8ACg7DXrshUz9j3UoxpQiaRmah+WSEi8vPmHrPUQvZLCrH?=
 =?us-ascii?Q?HxfZRpyX2+miCcK3ViTj9kWpPFvTJNpuSGW4faHQhAjytS1k4vyBYGM7WibV?=
 =?us-ascii?Q?fXqxVjTk5w8OfJkbluZec40OtLWuqUbYXkKyiPx+DfsSLehFZ8YO4GBSp4Z9?=
 =?us-ascii?Q?n8XEtgk8wYiY0PwbvOH7XF+MUTTHXfSekRrLpU0JG25xauxGfRtvxGB43Nt2?=
 =?us-ascii?Q?hkwRH0y/GJ8Wgb8MBq99GbV0rs/M7cwCQkPSR9huKxPg+0mam55we4npoZTm?=
 =?us-ascii?Q?+v9VzGjgHU9tmygqcZ+3ycqP8Ae+nlolRIKRVINAmzA34Bq7b00FUu+A3JpM?=
 =?us-ascii?Q?rUMFvomOKkXrhmpgqO31pAkTHnzKNVL3IXvNNuWT4sVd71YLD570tKK3h4wE?=
 =?us-ascii?Q?e4kYPfmnFlrA/FuxBMDzSuz2dZQSiCWJ/apoH3702u3XC2cvkuPqAJMmP0ht?=
 =?us-ascii?Q?ZefC99kXSEU3mmawJx4odb4irsX06pbPnjpVc1/oPNfDVsr6jbEfLONkCm9F?=
 =?us-ascii?Q?BcHpMOjPKt40G+XYftBa1nc+vM9kMsZCtTFtQk19kxP7Jwq+THK5rNfFAHV9?=
 =?us-ascii?Q?aB2POhBBBJ7Jtl/xernkgYvYEtwpQTogg4EcxBo8ta3B/aMfa9RJRvKLeGFI?=
 =?us-ascii?Q?YY4bhf8mHlI+SbUcZH6OiEzmGpb90DfBwt2skMOexbPZFugMvLcJWjaH2nQy?=
 =?us-ascii?Q?p/CwAUrr0gNbCzNAIZCTZD3xpnSc/lhxvlZWfwyc1A5dOFtovkMumaTEIJ46?=
 =?us-ascii?Q?uLT0Pg2ol8nITowIE3T3w0Q6rfJgpHDOlXD8dTmq9PMLxSbW+dvfn9qcYaTO?=
 =?us-ascii?Q?jtTK4yAo/FSKihQEWNqL9f3TUD/n/T3cH1Jyc92KgK6T90oG7bDjaJaCsPjj?=
 =?us-ascii?Q?0ZI99gbbJ+/vyWWeJBdEFCSNlLfls2mEKM8bULFXvNNxoi58Ixknoa9kxuGp?=
 =?us-ascii?Q?kKh0/ooST/wI6AZWdUhCXocb?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR1901MB2020.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cc7ba3-f739-44c2-e6c6-08d904c979a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 13:29:22.4498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CRg71bGUILlO5pb0NahhqFR5GdujaeN+7cmqI7g2P4qN0qwT+02BRUxISdh8WngIOJd/tRR8xWZfVzfefrIAuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB4096
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-21_04:2021-04-21,
 2021-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0 mlxlogscore=793
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104210104
X-Proofpoint-GUID: d1d4Pl8F3EN_Rhc2XHFgDfSPHkqRGgVX
X-Proofpoint-ORIG-GUID: d1d4Pl8F3EN_Rhc2XHFgDfSPHkqRGgVX
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=901
 suspectscore=0
 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104210105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210421_062929_154293_F354A428 
X-CRM114-Status: GOOD (  21.52  )
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

Hi Hou,
Yes, commit 7b96918a173 (nvmet: avoid queuing keep-alive timer if it is disabled) fixes the panic we hit.

One comment:
It might be more elegant to move 
INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer);
From nvmet_start_keep_alive_timer To nvmet_alloc_ctrl
This way, we will not INIT ka_work each time the keep alive timer is started
(each nvmet_set_feat_kato for example, will start_keep_alive_timer)
IMO it make more sense to INIT_DELAYED_WORK only once (as part of alloc_ctrl)

Let me know what you think and if you want me to provide this minor change

Thanks
Amit

-----Original Message-----
From: Hou Pu <houpu.main@gmail.com> 
Sent: Wednesday, April 21, 2021 5:32 AM
To: Engel, Amit
Cc: linux-nvme@lists.infradead.org; sagi@grimberg.me
Subject: kernel panic due to a missing work initialization in case of zero


[EXTERNAL EMAIL] 

On 4/20/21 11:46, Engel, Amit wrote:
> Hello,
> 
> We hit a kernel panic as a result of the below sequence:
> In the current nvmet implementation, as part of 'nvmet_start_keep_alive_timer'
> nvmet_keep_alive_timer work will be initialized only if kato != 0
> 
> when nvme connect cmd is being executed with a zero kato value 
> 'INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer)' will not 
> be called
> 
> once keep alive cmd arrives, we call 'mod_delayed_work' for a work 
> that has not been initialized this will lead to kernel WARNING:
> Apr 20 10:32:59 FNM00190700796-A kernel: WARNING: CPU: 11 PID: 75133 
> at kernel/workqueue.c:1447 __queue_work.cold.55+0xc/0x3c And 
> eventually to soft lockup

Hello Engel,

Could you verify this with latest nvme-5.13 branch? I think this might be the same problem as commit 7b96918a173 (nvmet: avoid queuing keep-alive timer if it is disabled) fixed.

Thanks,
Hou

> 
> A simple fix for this issue (I will post a patch soon) is to 
> initialize the work (as part of 'nvmet_start_keep_alive_timer') even 
> if kato == 0
> 
> Thanks
> Amit E

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
