Return-Path: <SRS0=Nmvj=PI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A91C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 15:41:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A226137C
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Oct 2021 15:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 08A226137C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=itP7Yh/c3ZvoT2KU6qKSvUNnbP+FLku2AddBJE6WRxU=; b=WmRoX/hhDpHvP2p/20VmsGhnr8
	nOm0ebjZkwSVqYvSYC1BWJ+5CZapft2IFur2BbxMecTL48YrTu4H/N0sUjTEyZJfi6Wc/5Uvyy1nj
	ub2NpDj0fZxiUq+5rSeABJBf6CfgJOlqrXBiPdfbxnRA4wxZGF6F3NJKSxWPwqfHpAMDRTTrdMdRa
	GshHar4KipQEQW1+svGz1o5gRipVHgbSa8OVTFNcW+f9AYwFUHApvhOv0htGGadEth1wUR3jo7+kO
	ENGyigeKcHxENjQLeBbtAXbOqPv1WeAKCB7Oa6fjOnIU6WDZR8ZclEC5pRfH5iveB0nWzUTEuHLKK
	bXKRIVFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mdDif-0056XM-Bd; Wed, 20 Oct 2021 15:41:33 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mdDic-0056WD-MW
 for linux-nvme@lists.infradead.org; Wed, 20 Oct 2021 15:41:32 +0000
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KDEp7C009240; 
 Wed, 20 Oct 2021 11:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=itP7Yh/c3ZvoT2KU6qKSvUNnbP+FLku2AddBJE6WRxU=;
 b=IaUOr/hXaSMKfz6cf8Migxl3Pf7inMlrSLJrmNr3w6TdMqvui/fB6lR33e2wcBDAfT6g
 UlX2+Hzkqd9mG8c15S5vvpz9Rd3Wip/cA9swJIFKlMLS4dFdaCjttQOanOzgqUlVenuu
 7a1FmkssmTHT3EAldlma0sJXRZs1TQefDEDKr7WRNxwkZKfCI/eosqX/pjblMr85iAGf
 1tsUBrg9HcSnQPU/MlRFZ+dh7hF9ymzVw0sKvNXvj+MRzNwQTAUjjr41vO4cVCysEuMH
 HpFHWWcaf6LBb3Z+HG05hpoQ6JMhaNwRYOcSziJl1nymUDT1atzvk7hnzigiiY+IMfXe 8Q== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 3bsx1mdv5s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 20 Oct 2021 11:41:23 -0400
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 19KFKAvG151533; Wed, 20 Oct 2021 11:41:23 -0400
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
 by mx0b-00154901.pphosted.com with ESMTP id 3btbyerrea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Oct 2021 11:41:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmfvVxOyCFWJa/G37ropBBm7q5AMv2Z/wUS9VS5MW/MT0S/oJWH/FVd8eJllgXhVvwbjKhEQQQ26CpHL56DIDvtmobt2Q+V3QlxyICH/s8X2OKl2HSU+ZidXVMZHOlxMxBx83WoXhcOdOVG3GMvZqc4/43kDQolVPSOiIzgCyGifU1Sh8/iezrPmjPZai2rKJoejJxJz5/pfNiPrn6/okNG+j1KPQq7U9hYUE9+WeMF3ngKRAtHkcVLSAOXjTdi8+D6VP31aVPqiHpwUYyO7jdgRcjoFVVRMYLEXklulhm4BqYLjeFJufn1zHs9EcvMpu59cua9RUkzEJNAQp89RSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itP7Yh/c3ZvoT2KU6qKSvUNnbP+FLku2AddBJE6WRxU=;
 b=WFY+1y0i3cz1Z+Q2nAQkN72gO+k4MOfeuEf/XLCU6up/szLVPzyPeXnaRChQWbIimSlUxx44jyVCsYl6mjaQuf03cwQeCkHdF6kl0Bl1bBKJawZ6yo/K1tdperQoCGOZwrF1vwpm79re+R38IquPAs27p6qBaso09W6HWICus6i6pSnsj8gD3pcgEjDjvoyPIt664kDWEpMCuRMrPVDK+TXmf+D5DFh8eSLxsIZoveSzFs+8kiK1tO3Ttn4bV5ZGmt1uypjETxeVAJufgDWjvFYGIzgbVBovthtDWOra0+5nZGog63OPcbH5BC/00cIy7vcpI7H3moyJzrBeqru7Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM6PR19MB2810.namprd19.prod.outlook.com (2603:10b6:5:13f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Wed, 20 Oct
 2021 15:41:20 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::4018:5f76:c1f9:418e]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::4018:5f76:c1f9:418e%9]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 15:41:20 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "sagi@grimberg.me" <sagi@grimberg.me>
Subject: nvmet-tcp: dead lock on host disconnect
Thread-Topic: nvmet-tcp: dead lock on host disconnect
Thread-Index: AdfFyBRNHn92rOYAS2uAyj4ILrcjnA==
Date: Wed, 20 Oct 2021 15:41:20 +0000
Message-ID: <DM6PR19MB40117B55AC00469501C2301AEFBE9@DM6PR19MB4011.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2021-10-20T15:41:18Z; 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=c351ca13-b567-4137-8e6c-644e42fe613c;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=dell.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a65fb840-329b-45c4-f44d-08d993e01087
x-ms-traffictypediagnostic: DM6PR19MB2810:
x-microsoft-antispam-prvs: <DM6PR19MB2810006D3AB075977A7E4081EFBE9@DM6PR19MB2810.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kOOjxx2fKBB7lxKt5oMK2VibiILH6nfdCdVpRDFF4q/BMl8rh/bpj6UaC5cTW1/hhheQm+05xa8Y1ZdNKtvTQCknXLuY/RZdmkQA+H/AefNsReFX4rHaoY9feEwZjHS6FJn1byg8PDZ+DCTcS+sGObNxPC3UI2R9sA0auEBq0QnhBYbPOOINB+w7VcAJBd09uJPDAlo+4CFyuGEuhQkgLGGpckVoAUHZBz36EnUitgMxTOHF17dsPpTvZAK+mm2NIqsi4xybfceDRklpUaZBzDs2JFuDRO4PkDxzR0qotlFNmYeAMonGpde6hdtJvkC3TYbAOL2DcAv/46XtIi4YZx5+uB5bWTpGe0QE43+vZUCb6ENBjTTGSRkUkcSD6BfulWQ67Si0f2E+v1XLWmzBlmAVP2jEwN+RqTEeCE4Lvlfhs849bujIRVOpQVSa3TyJGRNM76+2cMy8RZ3L9xRq7zDQoarVx1m52N7gRs2J2nP/6tWy/rKq6dqoke35U5aQmEMtGsxcwatdvpChoFpGgOcA+z7g2ztBIWbrGMYYQW2HISKHhiyNOD39PrL4knsFE+rVFRq0/HhM19qNAnIayKeismNbyjP0tII8RGyX9YA/6iXkS9XyCkL97APe2O0NDmwungeywTeXwv3GfQYi5n4rJOeGCBidSAAlj/cXthmlC/FEcgH12Mf+GgWA5Gv2HNtyxOAfP24wqIt2VQJE+5iL1IbDl4W8g+ovNIL8gtlW469RYx2cbNyhYA6AdiVN+C0wrqWM2Nl4QpgpEkmxCFLgxRs+3Z/A49IFpBB9evE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(122000001)(6506007)(38070700005)(66556008)(66476007)(82960400001)(64756008)(76116006)(66446008)(2906002)(86362001)(4744005)(508600001)(5660300002)(4326008)(33656002)(8936002)(8676002)(26005)(786003)(316002)(55016002)(966005)(83380400001)(66946007)(38100700002)(6916009)(52536014)(186003)(71200400001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUtNV2lkYWhLNWg5YlJPRHhrcTEzak03eDhadGpTT0RicmtMTVZ2cHN4UVdV?=
 =?utf-8?B?b2xBQWx1MmxpKzJPeEoyb2ZyWE8zU20xWXc0Yk8wTkVkeG5UT0VQS3gwaGxN?=
 =?utf-8?B?cDFZcmxYZ2orS3o2NDZoZThxYUw0bWVRdytBMjZENWU5RGlEREVBQ1JlRFZJ?=
 =?utf-8?B?MEd4cm50ZmZtNXZSZlJqMDBEQ1RoZHRJTUkzNndGcTJIYzNKckx6M2RHSnBF?=
 =?utf-8?B?SDF2TlBJODBuWjVBT09KZ2pENnBQdjdZQzdDdVBod3MrVWxBZ3NXOTBQNXNW?=
 =?utf-8?B?WHpZaSt0d0wwTVpDNjRFWWJVdGJvRTEva2IyeGpUQm4vb3gzTmNnTTZDbkp0?=
 =?utf-8?B?RG9vdTErcS9aa0U4c3BtUmVZUUdTVU1kTXZ2REUyT1hMNlRubnF3aEs3amMr?=
 =?utf-8?B?eENFMmhxRHdnaEIzL3JMT0NhQ0EzRWFOekxmbmhLc3VuNllOOUU2TjUxZlR4?=
 =?utf-8?B?NFR1ekhZbW1SclJKUmFCWWg0QzMvVEJKMGVVUjRYNlJlYm1xLzY0emlNNit3?=
 =?utf-8?B?YTFiSDlmMzVzdnB1amNHeEZJRlRxb0pNWG9ib1ZmeHppU01JZ01KeTJyYlVI?=
 =?utf-8?B?SnI1VTNtS2JJWmRGQzlyenVtTUJybmJjWDRSQzg1bjJkT0ZweE83TVZteHFQ?=
 =?utf-8?B?ZXowazVFWVJ3Y2xENkEvYytLblNVbHo2NVVHdHczeVJhYllzaWJYWVk2VHhM?=
 =?utf-8?B?bUVWeXBvM2IzMTUvdk51M09PUWdDVE5lRjVFS1dITENlb0ttUG5ib0cwbVZY?=
 =?utf-8?B?VmhOdVBLQTVXUjVZdWdKWFVibWY2ZUF3MHdjdlk4cWlHcEVvdVNnaGxwRmNU?=
 =?utf-8?B?UXRkRW01K3h4ejZ4ZUtLbGkwTnVqY2xLWHdqcC9INGpRUUF5R2taanp0OWU4?=
 =?utf-8?B?Y2QxUDRnQy9tWGJNSDRIZTdtUmV0ekhSck5Lam1FMFFXb0RjY3Q5MENqSWVZ?=
 =?utf-8?B?Rmo1OUt2dm9LeTRBYTZpMnI0WmQvckZmd1ZwaXN5aWJoZHVCQjFCdVBUS2Rp?=
 =?utf-8?B?d0dNSTlBcjE5eldUcW1BeG1xZEgvR1RaYisydHE5WHF4WDZRcDhnYkt1MnNv?=
 =?utf-8?B?SWpjL0dPcENBVWFtTDhCZDVBOTdKdGJYN2FJR1VzUlZWUHZnL3BYWUJNYWlh?=
 =?utf-8?B?RkxGZHMxTUoxS1Iya1VzWGFJWHVrUk9rditUeTI2TG5FTlZYZXplOTRsMjBl?=
 =?utf-8?B?bWFxR01USU5VS0xOZndWWjRtSXAxVFl3SmJHWDFTdFpFTXVWcmM5RzdlMmx3?=
 =?utf-8?B?enNJdjh6YlA5Q1ZrZjBtQS9oZXBrT24yQm9OYTB0cFI1Y01BQ2ZiNnlZU1VU?=
 =?utf-8?B?TEJTZ2hrRm53aXp5NDVBRHZsLzBkbEJLaU1CSmFKeGxiTURUK2FxK3B5emRR?=
 =?utf-8?B?dHFFbXM2cWFOSUpWc3hzRTl4dHVEdVpCTE5SZWVvN1FSQnRFMXhOUC8rd2pF?=
 =?utf-8?B?ZFpwWEJGY21zTG9tR0RzTkZuZXdsOC8rWlF2RXdadWxvZ3R1aUpQTUVTSzVx?=
 =?utf-8?B?dEJmV1ludVN0RzY5clM0MWUwQnpZZytETXRGTDlrMWNYZS9yNCtUdjJZQkJi?=
 =?utf-8?B?TDB2N296Z2xxT3ZoQit0bnJaMzZjTk5oUnJIci82VGFqQkdiQUZiNnFZU2Rz?=
 =?utf-8?B?MTFmaWpYQlhHTlR0cmR4a2FHNHlJeXZkeEpMc0cxVDFINjFIVjlxYU1GSHZ2?=
 =?utf-8?B?YUVGL2FYMXNUYi9VU0UwQ2p6QUtsNUhQMGlKRkpTQzF3NkZYUmpqTFExQVBi?=
 =?utf-8?Q?ZuWvAWpuR5vPZ6blxI=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65fb840-329b-45c4-f44d-08d993e01087
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 15:41:20.7524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xTrzyPy3hI8ITDjLWUef2w5dsmlBX2LahKQXss7xs3zqhucburefK+etHtx2m7KgWNyH7gP0KQnC7vm8+P6ppw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB2810
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.790
 definitions=2021-10-20_05:2021-10-20,
 2021-10-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=318 clxscore=1011
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110200089
X-Proofpoint-ORIG-GUID: 323tdN6DrKjWfyZA94jFXp6WE5v8Fwa4
X-Proofpoint-GUID: 323tdN6DrKjWfyZA94jFXp6WE5v8Fwa4
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=453
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110200089
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211020_084130_944970_CF840BEA 
X-CRM114-Status: GOOD (  14.33  )
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

SGkNCg0KV2UgYXJlIGZhY2luZyBhbiBpc3N1ZSB0aGF0IGxlYWRzIHRvIGRlYWQgbG9jayBpbiBu
dm1ldC10Y3AgbGF5ZXIuDQpPdXIgaG9zdCBpcyBjbG9zaW5nIHRoZSB0Y3AgY29ubmVjdGlvbiBp
bW1lZGlhdGVseSBhZnRlciBzZW5kaW5nIG52bWUtY29ubmVjdCBjb21tYW5kLCB3aXRob3V0IHdh
aXRpbmcgZm9yIGl0cyByZXNwb25zZS4NCg0KVGhhdCBsZWFkcyB0byBudm1ldF90Y3BfaW5zdGFs
bF9xdWV1ZSBiZWluZyBibG9ja2VkIHdhaXRpbmcgZm9yIHRoZSBpbmZsaWdodCBjb250cm9sbGVy
IHRlYXJkb3duIENvbXBsZXRlIG9uIGZsdXNoX3NjaGVkdWxlZF93b3JrDQpXaGlsZSBudm1ldF90
Y3BfcmVsZWFzZV9xdWV1ZV93b3JrIElzIGJsb2NrZWQgd2FpdGluZyBmb3IgdGhlIHNxX2Rlc3Ry
b3kgdG8gZmluaXNoLCBidXQgaXQgbmV2ZXIgd2lsbCBiZWNhdXNlIHRoZSBjb25uZWN0IGNvbW1h
bmQgaXMgc3R1Y2suDQoNCkkgaGF2ZSByZWFsaXplZCB0aGF0IHNhbWUgaXNzdWUgd2FzIGRpc2Nv
dmVyZWQgaW4gMjAxOCBpbiB0aGUgcmRtYSBsYXllciwgYnV0IEkgZG9uJ3Qgc2VlIGFueSBwYXRj
aCB0aGF0IHNvbHZlZCB0aGF0IGlzc3VlLg0KaHR0cHM6Ly93d3cubWFpbC1hcmNoaXZlLmNvbS9s
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnL21zZzE3OTU4NDYuaHRtbA0KDQpQbGVhc2UgbGV0
IG1lIGtub3cgaWYgeW91IGhhdmUgbW9yZSBpbmZvcm1hdGlvbiBhYm91dCB0aGlzIGRlYWQgbG9j
ayBpc3N1ZS4NCg0KVGhhbmtzLA0KRWxhZA0KDQoNCkludGVybmFsIFVzZSAtIENvbmZpZGVudGlh
bA0K

