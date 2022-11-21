Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B49C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 11:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y+zx4PX18GL8cQufa8Q+94YbdQhCMPFrNhGMVxOgH04=; b=JaIjmRKYuHe9HVEtIbra4txbSL
	bVQuUyLIlJHJtd/N1qXhcyJmujf52/R8kqAOxUc+MXtEKB2OVzkZfzyl8Nod7mWg5UYJxHCaiAXUw
	CMQ3eowHbgrwLTqy9uRZarwPhfma1a43f3uNhEtCqYHVMhMukCq1aZ7Nf6e34tQKfnHBwVzQzggd0
	MvhcpnS1HgtaipDc3Wha/J56EibQS4Yi+HIij/xPJKxXrAr+rHFEViMf0YdtfGqHIYHYaKpFXNLE3
	lFbwDEP5iRRRV70mlw1comkM0ST0cGDnFlJ7FyLOCWM1BM+m//TIXYk8SRlv4kRsuB7Vj4NA+T89S
	V4zaJwVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox52s-00CxJW-3K; Mon, 21 Nov 2022 11:33:02 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox52o-00CxHX-Q7
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 11:33:00 +0000
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AL9VsqY004437;
	Mon, 21 Nov 2022 06:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=y+zx4PX18GL8cQufa8Q+94YbdQhCMPFrNhGMVxOgH04=;
 b=vB9wOFO4YbmcmHvXLjtq3WZm1TrEAe4M0FWdfUa+6gAusdgSyOI7jlxrGBHwvH3cFpmj
 oGwzknEqCkkCux4Krnnd4MQu/7RQAkOHnTCbX1tvCdOT7enPcOVdgLhwe8Qne+zfx5+O
 MS2eKhVbmoZQJBVn+atUAptrjPQgQz5i/ZfGSiUw9J19Z6gcDWy2r+L+3EEnzh+WMMIC
 0TntIdp+xyshO+mamFbZDy1hAy+9F/78yli1w7cDUbmVo6qJp0GfJMQPQ9s41EdZtLZ6
 k19gpaLtqR2PRWEXZSD1oVIM8njujI0frXMlybUDmFsis8SGjTpU7OsFbtDvkiQWBato Wg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3kxu8cx5sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Nov 2022 06:32:48 -0500
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALAu70n019328;
	Mon, 21 Nov 2022 06:32:47 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3kydnvgvm1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Nov 2022 06:32:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4DcjPkHIBwANMbPodYR8REXXfTVxHtc+i/jrC1hglaF8SCi9usjivS5OQ1eezQ7EgPUXIRQwWAcWKhqJElEUF2f6roYU+TZ+nNZLGK6iX3mjXpH236BPWyCmu72/TFpE1bXaum+UEY80bZj/7Mj829DHO1itqsU5L4z1ZwPSeIQ/U7hBQGO1JbfzxdEJspZzizIWkeTI82LTfjXgoKWVj3uW1vUP1V4ZFDxVKURP41bJQ2xe/N74pWJHpQnkNBZJ6pm0Qa1Q69/KXs+/4tuKNCcx6xhAbUNb5FwzHRrsNpI9yT2rMSLZba0wi6ZdOYnv2fWS/lqGVMspu1m1E3qCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+zx4PX18GL8cQufa8Q+94YbdQhCMPFrNhGMVxOgH04=;
 b=TMnOQKc0/yEmh3kK0mBpgbHzTwMlyKmdS2vwxx3EbrupIQEnM0lCySa/x6oI2uwJjTADM/HmG4JXjc7Rtm7SqVQ1wWwLSCvzDCKDV0qVIc2CuU+vHKkziW2rLySzJKdWsppejsDZnv/KYaoHM/5bEhSipj1tX2V726cFHHv9R4bSc2sWi/06vuxCehJ+LLnLC5R921g5xyD+rvjlzzmP8dgmuYgA7xNHuXzry8q5+n7ELfDV1cNCveWrYinwmSEk7JuwJ9qnIElluYh4d1srQncgfUbFD4iHeAlm0VMUtXDiiblSpgHHDXpUbzWD2C9Ltfbeit5nvgmGJ5Mz+JHWAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by MW4PR19MB7152.namprd19.prod.outlook.com (2603:10b6:303:21a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.13; Mon, 21 Nov
 2022 11:32:45 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::404:85:b6d7:86fd]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::404:85:b6d7:86fd%3]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 11:32:45 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "Engel, Amit" <Amit.Engel@Dell.com>
Subject: RE: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
Thread-Topic: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
Thread-Index: AQHY+oZ3D5fYZrPgTEKaaKTSawClOq5HuhEAgAGKjLA=
Date: Mon, 21 Nov 2022 11:32:44 +0000
Message-ID:  <CO1PR19MB4885EB9E323178E235681F9EEE0A9@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <1668607073-1814545-1-git-send-email-amit.engel@dell.com>
 <1668690824-2034939-1-git-send-email-amit.engel@dell.com>
 <4effaa95-0357-7d65-1701-8ec67ce7cc11@grimberg.me>
In-Reply-To: <4effaa95-0357-7d65-1701-8ec67ce7cc11@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2022-11-21T11:32:43Z;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=7c68a2ec-0a09-484f-9f48-af887a75f3b7;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|MW4PR19MB7152:EE_
x-ms-office365-filtering-correlation-id: 65976a5b-b01e-40c3-6509-08dacbb41bfd
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  7fVU+FsgypA3CIREjn+hOD/gEFdc2x1onlJ1FkVn/ZFiIEnmlTbCpajEmnTcaGAJwYwkA7ipHzQjTkWh2fkeyZtIvEP+L7rdRhwoMfNpWR36ZNfk0iVuc00Rx82tKpQxqoQ3JxIRAfbbWwM6/awh4Kou5q8E0tRJ+L98FvQGzQq7zht3/VPbS1hvam7TrHmjSraxey2letJn+Arz+NrIa2Tt8qkKqmMZq0hWbYtsVI+A8ZETeid0znkGWYHqebjZkJAS+m+JBvj1EqyXUxEW9m+PQGAp/VNCoWLtDfTn/6Qqsef2VQ6ThMoCnLBahCr3JBRbEQciVyvw4BP2bNYPJ1O8j0ka9ycPsNudt4o/0mmGFhNf+SsHE2jsN0zpJMJV4IPpZ9YRFhojc/k1SeS6MSO9kSaHkUGWiMsTRWh6K5rtIyDbHpdPjdrOcvLGV0Vk914w7aOO9sveZ/We6kg3kfkzHVa0rWvpdDci4gH7drFRjlu/kg+URxqOyM3jUWHBv8ubRbb3aIfyREgEyFtgzffsFaC8CCXGPKXgsVyyBAO5kbH5/d2rEhbHPc07LtADVU5QeCNPBN7R4cmoej8tUNWUMPsw1s4I3H2i+fqNBSmjp0OSoqiZSc1AawV4CxJfu6936J2ALP3Z8/3NZB599Toz7nsKukN1L0nWzEFIFuscmjhlXqroKAEJ/TBX81bvRL9F7M0f5Rz0ORwCpgtJ0g==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199015)(8936002)(8676002)(64756008)(4326008)(5660300002)(52536014)(38070700005)(76116006)(66446008)(66476007)(66556008)(66946007)(41300700001)(55016003)(86362001)(786003)(26005)(82960400001)(2906002)(33656002)(186003)(110136005)(83380400001)(71200400001)(316002)(38100700002)(107886003)(122000001)(7696005)(9686003)(6506007)(478600001)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?UHd6R0pkb3pvTWtGclByUGM2cU5YTS9JK3NIbGtsSFRTdVZPUStxVldwVUtz?=
 =?utf-8?B?c2c1T21rb01yZU8yeCtlU043NC9mLzRRQnBsL3ZrR21ZeTl4QTcrRXNPUUgr?=
 =?utf-8?B?cVp5d2VDczV2bkRNYWxKRVZ2TkVLWkVBdUd5MHpyVGZ6Rm12Q0JtQkxHVVlR?=
 =?utf-8?B?SnI5OGYvK2tNNDErcithSWpQV201aHNHcGF5dm04RFVnYmlnNUd4a1JsbWhO?=
 =?utf-8?B?VGVZekFSbE9nVFpIdGJGejk1Q3NOclZaSTU0emNCQnQxNXBCMWF4WE9vWTdx?=
 =?utf-8?B?YjhUeExEVUJpUnNKQXRyZDRlWDQxaU5ZUFE5b0VIbURWYW00bFlzUUJsOCsx?=
 =?utf-8?B?N3Njak96b3JGd3pnMDQrSVBIZDFIY0g1NjN2NlBOYVJPZUlrTnFCRzZmNjNr?=
 =?utf-8?B?WEk4L0t0aU1hWmF3UFFqV3Z3VC9hb1RQM1VhQm91a2dUZUtGem5MdEhtdlZN?=
 =?utf-8?B?VHY1SThCbEh5dWJGZC9Fbml1blp0SUZtNHl3b1hpaU1PRDEyTmpVSmFqMzdo?=
 =?utf-8?B?VHIvT3J0Zi9rZFNFeEpvNDMzbUowS3ZIbDNJWkZqdFlDSkJKTHowNWF2ak0y?=
 =?utf-8?B?RzJieG5FbjdkbXFWMGhuRXBEYkJMT242MEd3ZEp0cG9FUTBGZDcwYm5ONVFR?=
 =?utf-8?B?S2lFTng5dTVlN0RZRWEwRkhrTDBzam5uSmFtVXNHUkJpVGtFRlFsQi8ydmQ4?=
 =?utf-8?B?OW9CUFkwY2lnZnZ3c0ludnRrWlRMK1ZIS1NRZDMrQThsVm11VzV2cVFoNmJw?=
 =?utf-8?B?M3pDaEd5cTdPWWxYK28xRFdEbnFwc203Y3JuQVQ3ckc5VmRRZTlXNUVwSGZy?=
 =?utf-8?B?eitVMUE2SlVDV3JLMDhaZCtzQXd5cTFwYkdmK1dDZXNoQmw0bFc0YXRtL3ZF?=
 =?utf-8?B?NnhVc1JTaXIrZEpvdnlsYkZFTUNyZlQ5bWxNbmFSdjBibXpuSnR3RVM4UzFO?=
 =?utf-8?B?UkcvbS8vNE1acU1iYWxZTk80THFSZElUa0hEZS9YV1J1UmlVUmIwRkdlWWg2?=
 =?utf-8?B?dGRrWHMzWCtWOWxMK2hzUXRockdkR210blVJOTlRL1RsUG9PNWxkcmpVRk9R?=
 =?utf-8?B?aEc4Q2JqRkZBOGRqdFFrdUNlYkt2QU96ajhnWWowZ01kMnJKTG03NWRpaW1h?=
 =?utf-8?B?K1FlaVdEcnBqTTVmbFU1Nnd4Z1NVNlBqbW4xUDdVaFhiQjNoZE1rRXplKzlU?=
 =?utf-8?B?U1gyOHpjaGt0YTRoN3hQSUpjeWk4emQzczZyQzFqM25hcEo5UVRYMkxXSWRM?=
 =?utf-8?B?cWE1QmFrK2VIbGdMaFl1M1cxVTc2WlQvRGszdTBrUEZRQW1uNWE5eE42eUU5?=
 =?utf-8?B?TDJ1Tm1KRGgwL052VTROeEcxYWZGREtmeHVDZWJkU1lpbWtsd2x2cWc1eXI0?=
 =?utf-8?B?Wk5YRTNpNWJlcTBHMGV6U2UzMkRXMURqdlpyU2w5cTJtMWlCQngvbDRyNWpm?=
 =?utf-8?B?YzUvVy9IRkhnNzNGdU1td0xFeUNXOHJYSHpwUExRaWVuUEJFcVVBWjhjUzRR?=
 =?utf-8?B?OXpPNU5CN29jajk3QlY4NUIwYVNGN1MxZEJPM3ZHT3VSYmRxY0JxRDNjaXlT?=
 =?utf-8?B?M09HU1h3T1haeUo0WDA4ZFBkc3kyemFJK2E0Ni9nMkZncS9sUkFBSHQ2eVZx?=
 =?utf-8?B?aEhmVHBIUjdEOTAyV3oyQUFtZThMR0puS3lReTZoQkVSYXc3WDdIMERFUmM4?=
 =?utf-8?B?RFJIbmVxRkJnbXhFZzZ3UmFyWngrTTZBZG55OC9FS2p3K293WjdkbzJzNGZw?=
 =?utf-8?B?cklkMTZjVTdBR1haeXRXcXJTMGVqV0VVNno1bUlLa0tlaXBBSHNFS3B1a3Ew?=
 =?utf-8?B?TGpaeTVNSEo2V3kxVVVkY3hBaVptb2lWZ2V6d3FSZkVMOW9LVDlEajU4eHRG?=
 =?utf-8?B?UDVOWU5ORUFnQk9veS92bmZNOE1LMnVSQys0NHpxYk9Ec0tsaC96aGpQdXc2?=
 =?utf-8?B?RU42RHBYQnRBUklNUnBCZ2VkU3dvVWZ6TWtseDBoa0NyVjNoOWM0TVJqRExL?=
 =?utf-8?B?TldQV2NWbVVMMWRxeVVvQ0MzdndBMmhyZWRhak1FUnVjVWJoSVBlaTVCb3R4?=
 =?utf-8?B?UG5NbWhEWHpZQ0xnZGVNbjltaTV6V0M2aGwrZzdkVmVwaFE5cTdKSFBsZ3hQ?=
 =?utf-8?Q?8rGYy1U4qlPWDY2Q2ZwPALcr5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65976a5b-b01e-40c3-6509-08dacbb41bfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 11:32:45.0177
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uqPDUzm4skpCsmyC8Uy3utcN46JY5mTxfIzv8P8hjGsiFjm7X26dEMMqzs44Cgf2b3iWITXTttalagKd9nM/Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB7152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_12,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211210089
X-Proofpoint-GUID: 0k_YlK-3FlLSy18UTDXWrPbqiOsC4Ke-
X-Proofpoint-ORIG-GUID: 0k_YlK-3FlLSy18UTDXWrPbqiOsC4Ke-
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211210089
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_033259_140189_14449E27 
X-CRM114-Status: GOOD (  25.51  )
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

SGkgU2FnaSwgDQoNCkJlbG93IGlzIGFuIGV4YW1wbGUgcHJpbnQgb2YgYSByZWFkIGNtZCB0aGF0
IGlzIHRpbWVkIG91dA0KU2hvdWxkIEkgYWRkIHRoaXMgYWxzbyB0byB0aGUgY29tbWl0IG1zZz8N
Cm52bWUgbnZtZTA6IHF1ZXVlIDE6IGNudGxpZCAxIHRpbWVvdXQgcmVxdWVzdCAweDcgdHlwZSA0
IGNpZCAyODY3OSBvcGNvZGUgMHgxIHN0YXJ0IHRpbWUgNTAyMjAwODgyMG5zIGlvIHN0YXJ0IHRp
bWUgNTAyMjAwODEzMm5zIHJlcXVlc3QgdGltZW91dCA1MDAwbXMNCg0KVGhhbmtzDQpBbWl0DQoN
Cg0KSW50ZXJuYWwgVXNlIC0gQ29uZmlkZW50aWFsDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPiANClNlbnQ6IFN1bmRh
eSwgMjAgTm92ZW1iZXIgMjAyMiAxNDowMA0KVG86IEVuZ2VsLCBBbWl0IDxBbWl0LkVuZ2VsQERl
bGwuY29tPjsgbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnDQpTdWJqZWN0OiBSZTogW1BB
VENIXSBudm1lLXRjcDogYWRkIGFkZGl0aW9uYWwgaW5mbyBmb3IgbnZtZV90Y3BfdGltZW91dCBs
b2cNCg0KDQpbRVhURVJOQUwgRU1BSUxdIA0KDQoNCj4gRnJvbTogQW1pdCBFbmdlbCA8QW1pdC5F
bmdlbEBkZWxsLmNvbT4NCj4gDQo+IFRoaXMgcHJvdmlkZXMgYWRkaXRpb25hbCBkZXRhaWxzIGFi
b3V0IHRoZSBycS9jbWQgdGhhdCBpcyB0aW1lZCBvdXQNCg0KUGxlYXNlIGFkZCBhbiBleGFtcGxl
IHByaW50IG9mIHRoZSB0aW1lb3V0IGxvZyBtc2cuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFt
aXQgRW5nZWwgPEFtaXQuRW5nZWxAZGVsbC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvbnZtZS9o
b3N0L3RjcC5jIHwgNyArKysrKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC90
Y3AuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jIGluZGV4IA0KPiAxZWVkMGZjMjZiM2EuLjVh
YmFmZjVkNmY2ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMNCj4gKysr
IGIvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMNCj4gQEAgLTIyNzcsOCArMjI3NywxMSBAQCBzdGF0
aWMgZW51bSBibGtfZWhfdGltZXJfcmV0dXJuIG52bWVfdGNwX3RpbWVvdXQoc3RydWN0IHJlcXVl
c3QgKnJxKQ0KPiAgIAlzdHJ1Y3QgbnZtZV90Y3BfY21kX3BkdSAqcGR1ID0gcmVxLT5wZHU7DQo+
ICAgDQo+ICAgCWRldl93YXJuKGN0cmwtPmRldmljZSwNCj4gLQkJInF1ZXVlICVkOiB0aW1lb3V0
IHJlcXVlc3QgJSN4IHR5cGUgJWRcbiIsDQo+IC0JCW52bWVfdGNwX3F1ZXVlX2lkKHJlcS0+cXVl
dWUpLCBycS0+dGFnLCBwZHUtPmhkci50eXBlKTsNCj4gKwkJInF1ZXVlICVkOiBjbnRsaWQgJXUg
dGltZW91dCByZXF1ZXN0ICUjeCB0eXBlICVkIGNpZCAldSBvcGNvZGUgJSN4ICINCj4gKwkJInN0
YXJ0IHRpbWUgJWxsdW5zIGlvIHN0YXJ0IHRpbWUgJWxsdW5zIHJlcXVlc3QgdGltZW91dCAldW1z
XG4iLA0KPiArCQludm1lX3RjcF9xdWV1ZV9pZChyZXEtPnF1ZXVlKSwgY3RybC0+Y250bGlkLCBy
cS0+dGFnLCBwZHUtPmhkci50eXBlLA0KPiArCQlwZHUtPmNtZC5jb21tb24uY29tbWFuZF9pZCwg
cGR1LT5jbWQuY29tbW9uLm9wY29kZSwNCj4gKwkJa3RpbWVfc3ViX25zKGt0aW1lX2dldCgpLCBy
cS0+c3RhcnRfdGltZV9ucyksIA0KPiAra3RpbWVfc3ViX25zKGt0aW1lX2dldCgpLCBycS0+aW9f
c3RhcnRfdGltZV9ucyksIA0KPiAramlmZmllc190b19tc2VjcyhycS0+dGltZW91dCkpOw0KDQpZ
b3UgY2FuIGdldCB0aGUgY250bGlkIGZyb20gdGhlIGNvbnRyb2xsZXIgZGV2aWNlIG5hbWUgd2hp
Y2ggYXBwZWFycyBpbiBkZXZfd2Fybiwgbm8gbmVlZCBmb3IgaXQgaGVyZS4NCg0KV2h5IGFyZSB5
b3UgcHJpbnRpbmcgdGhlIHRpbWVvdXQgdmFsdWUgKGluIGt0aW1lKT8gV2hhdCBpbmZvIGRvZXMg
aXQgYWRkPyBZb3UgY2FuIHNlZSB0aGUgcmVsYXRpdmUgdGltZSBpbiB0aGUgbG9nIGFuZCB5b3Ug
a25vdyB3aGF0IHRoZSBpbyB0aW1lb3V0IGlzICgzMCBzZWNvbmRzIGJlZm9yZSBieSBkZWZhdWx0
KS4uLg0KDQpZb3UgY2FuIGFsc28gZWFzaWx5IHJldHJpZXZlIHRoZSBjaWQgZnJvbSB0aGUgdGFn
IChsb3dlciAxMiBiaXRzKS4NCg0KVGhlIG52bWUgb3Bjb2RlIGlzIGZpbmUgdG8gYWRkLi4uDQoN
Cj4gICANCj4gICAJaWYgKGN0cmwtPnN0YXRlICE9IE5WTUVfQ1RSTF9MSVZFKSB7DQo+ICAgCQkv
Kg0K

