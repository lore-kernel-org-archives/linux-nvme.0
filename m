Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2CEC5DF62
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jan 2022 23:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KfL2VAGKH+JO2smeeQWVgWz2FVtUWzGefAYPlQAX7/M=; b=3dx8PE4n2M0vpdrAEdT7Ap2nI6
	24oD7l2rDFvHE2gbFxJc9Va09uBHay4jMcSJ9Tde6Ko736goz8p6cr/426dZ90gBAP3XHDTKS0cuY
	jSwNierjafK0Xcd1FpFqYE0YJS4Jcy30i2oyjFNNW19jqRdAIL6c3sqzWMNQQktj8F416xs/YPLdv
	v9Bj7V5zQlPnfrcm5USG1mKr8U1BGTFBDJcpjJIGEuW2AKyfHgAWtsf2cyu+d+z7TotvCF+Z4FLIw
	Ba3hEPqCxJVPpcK7aeohSNxg5pVpAydT6Jy2/fCQLsX8R47g9BJcFGtk2SAom0vbxp7GJ5mSVQ2eR
	SmeG4pZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCV5j-009hP3-AM; Tue, 25 Jan 2022 23:19:11 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCV5g-009hOg-S5
 for linux-nvme@lists.infradead.org; Tue, 25 Jan 2022 23:19:10 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PMn95k019648; 
 Tue, 25 Jan 2022 23:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KfL2VAGKH+JO2smeeQWVgWz2FVtUWzGefAYPlQAX7/M=;
 b=Gc9W23s9f51OjHFBdNlKuzaiqy9ecFojwWuTE5d+JmBdK69zGCKv7jRhgrzxHWXLlqo3
 Q/lfEW1DVYOUkgk5LGPQ3Zox1Sqt4m/zoKjgpwnOA+jcVVyPQOK5XqYR1utL2vy5hx8W
 kVlX08Fbq/fdPURX6L+bp5JqkhJG4CFBG2eKlzR/0D1XxUOFjTbQy8SrPfaUQT4agHVA
 2fZZpYcIdz2+xqmw4YIievaR3EMA2HfbSPBq0ynz5TCTCboBI1B/mZqm4GgP2OiSblGh
 tqwNNaxrhlffl6vpqxc9+ZIfXUo3mSXPzqACyvls6RK79QyxUJpW0NMlSqAyGd0VZRBV pQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dsy7avrmw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Jan 2022 23:18:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20PNBISi193090;
 Tue, 25 Jan 2022 23:18:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
 by aserp3030.oracle.com with ESMTP id 3dr7ygs9xq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Jan 2022 23:18:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOvrE+7RAOjtImIlkRpkV1AqA0LDRh8aMCCCownPmbHOv5T69cMtK1aE66OqpY9GbEYqrvoapMxVDZ11E4iE7nlxOU1qG063jLkX1ejV46WHKfz9NwpuFWfEN/ZCOOasej/QQozXOD4rGbW5jHW8cOCdEQ422e8CekudwuaeQxZWcuSxTGnhW2SbBdHBpetzXlT+hayGgaoZ+4iL6DY0ovY9OOVQDBz37jFVyLySwpZOtiCXqSO/QGW7GdBrDqXDl79TWLfBGStAjepMs1c/34ToWO+TaQTfmWLeng8zv242bi7zwFNEdvQ8LJBMCXBebP3UlF4i3zhmnDaC4t5lew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfL2VAGKH+JO2smeeQWVgWz2FVtUWzGefAYPlQAX7/M=;
 b=SkbktsaLDA1XWeFEcwo9MdpoovoFjfkQrmZfjGkoVe+zGqxdVgE3Y8j9VGEx8FsVVsu0ZAflNPaXFBC65ytAC6YIchIjF1rKFvvfxoxiIpY2jwNvyoPRTpK/xt17nwq7defoHXH7khZEEwKAChSdCHF85AMU1D1Qy/dwcHtKlBmmrc8kW//moN0S6pG5STukRseE1y96vAGgkALLIZKgZzDAhP1At2nPcKlM+cLKqyOtiw8NetafssaqoBkUEa04+k4p85AEOA+90fXWfWJiJohoGyzKBJb2NczrBTWnxayoGAs306LTa2h3y+pRLuaKF50hdfI/UGydJMm+3W2E1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfL2VAGKH+JO2smeeQWVgWz2FVtUWzGefAYPlQAX7/M=;
 b=N5XMZT/8Yk+vOzMX6tpMOqUmsn+ZSxXgrioYckKAMMfea4sDpE6C94CCSHhl3KjYYNItk/zSzb0A2aeWph1vBIMOO/Pj66E53YunZO8EPBJp1WVgH9jADUrvzDb6dXSqd85s7MX8xwaqnBG8rloyYrNAqYxEkQlfvuLY9LDDRFo=
Received: from SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17)
 by MN2PR10MB4222.namprd10.prod.outlook.com (2603:10b6:208:198::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 23:18:55 +0000
Received: from SJ0PR10MB4815.namprd10.prod.outlook.com
 ([fe80::4048:6aa0:455d:7844]) by SJ0PR10MB4815.namprd10.prod.outlook.com
 ([fe80::4048:6aa0:455d:7844%4]) with mapi id 15.20.4930.015; Tue, 25 Jan 2022
 23:18:55 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V4 1/1] nvme: Add verbose error logging
Thread-Topic: [PATCH V4 1/1] nvme: Add verbose error logging
Thread-Index: AQHYEVOCjJcCogv0VkeuvVM/pcPtAaxzgryAgADDyICAABPggIAABs2A
Date: Tue, 25 Jan 2022 23:18:54 +0000
Message-ID: <588E177D-171D-4389-BE4D-4D64B525E8F3@oracle.com>
References: <20220124185144.53810-1-alan.adamson@oracle.com>
 <20220124185144.53810-2-alan.adamson@oracle.com>
 <bd45587b-9e6b-8637-a511-7d4269597d51@grimberg.me>
 <BB566CE6-19C1-472F-978B-564A2EC4C4EC@oracle.com>
 <1e95d514-7846-4a41-6b7a-9955fa903a52@grimberg.me>
In-Reply-To: <1e95d514-7846-4a41-6b7a-9955fa903a52@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f7ad758-1e17-437b-1fa2-08d9e0590e91
x-ms-traffictypediagnostic: MN2PR10MB4222:EE_
x-microsoft-antispam-prvs: <MN2PR10MB4222D3ACB36883B6558B9BE3F45F9@MN2PR10MB4222.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hn+jskUxaHcdcj4YEDGF32mwSfIGDdtdwMClU1DruxYRrU5WXqsjP6nxrGGmS+NqEmMnWs2pBy4xPr1xrMR+dHl8UuPUVrAj/Hfs/jU/ANodVqOaVJ3Y4mm9vLtDeRHtwipGaso93zJTkxQY/7Ywva6ZjxDpK413q2iWs74E0ibtzDhmjNIsmz6jGYucIJtCp1c0pTv+pSxXxxuMUxSIbkWwBWz9j0w8f4foTqbDNDYEYuDcY7ksdxkdltZV8Iv3nxdpOuRY9gBIJNLPqDRiKVRptlk5IpvYGMv9A5JwP54nvU10+Ajhp0W9Ck+RduQHv3itXWL2vL2PkitHUj27Vncaw0sr9sfELFAbQFsfMFrimeeHkbs/IqjsKdF0sBE6/cym/PmVSwWHPKwxoIkMP2smMGurqkD/XNoHOtsm3Fgfr8FrW6uWhboLipkWF0osDnPJsz46qAbPdRANUBq/iUr+0RQkM3wYAWwrustmbAXRiGriUAytV3dUAFW2aZH1ms9KsVj5yxagRkFr2Rq2vM9JqKawtNYDoSvZl1br01rPhOKc9DXyKfrQhlWqA0zeFNcTI6Krtt37DWQAVEJDFAFwoo+NBJjdIjGSKoppDpUY4I61LhtQ4atXolvMtq2E80nmD0ZAmOt5gYApPk14LWV4QJnrrBJ59ziFwwcoCF2B6oneyILntGIV/YLEpdfuaNYMQIaG4m6nNZ+7cKfifdhF9vYuTQI0zEZsr4WI0RIud92b+2QASp0ySZEs5aII
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4815.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(53546011)(8936002)(71200400001)(83380400001)(508600001)(38100700002)(86362001)(8676002)(122000001)(36756003)(186003)(66446008)(6512007)(54906003)(6486002)(33656002)(6506007)(5660300002)(2616005)(4326008)(64756008)(316002)(91956017)(6916009)(66556008)(38070700005)(66946007)(44832011)(76116006)(2906002)(66476007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3JRVlZlS2F5bjkrYnJZQjZPdGxHMnh0Q09sZnlRYy9lUTFweFUvZ0F3UmZE?=
 =?utf-8?B?MHdGTGdmZ01tYm5oS09BZ0R4OHlUdEpDWXRGQjVWK0dQd1RKbHJhWVQ5MlBu?=
 =?utf-8?B?bkJqUEc1aUdZUDdQQ2xBVDd1QzErYysrQmF5UTJNRGg1YjN2RkZkTHRaSG9P?=
 =?utf-8?B?SmxYd2ZRa0s1ekJVeTBEL0kyM255YllWOTMwZzRpZXJuTXFxK0xzSitWOHU2?=
 =?utf-8?B?Q0pkcUlWSmlyZHlRNmE2WkJDS3VkaHMvT2NQWktna2lxQTBraXk1My9Rc2JW?=
 =?utf-8?B?TjdzT3VkaXlTT0RRWFc0elk0cnB0c2wwellNUDhUU01SNWJFTVZxTkkyRXBV?=
 =?utf-8?B?aSs5TGN2N3VMOENnL1c0VGhDdlEycWVFdHJ3dk85R2RON1NtNFFWSFRadzM2?=
 =?utf-8?B?NTRwbWxmWnVSanRQdmRIanUvZnpFT1p6Uk1iY2FnbjJhckJWb0l6YVgyK042?=
 =?utf-8?B?TVBBWmFaSlF4dzI2QmFyN2ZVSVFGUC9QM1BvZ2VuWjdySzlzd0NTdEY3QVRI?=
 =?utf-8?B?OVM4cFlwcUtrQ01xQXB1NDJUKzI2TzNYdGdFU0d1aDVIaXZ5VlVzdVMrc0xH?=
 =?utf-8?B?cEx1Q3duNFhzVFlLZmVzMWQ5VmNNaXBQMklML0w5MEZiZ0lPVzQwQk1HQ2NN?=
 =?utf-8?B?aEU0WHJ1WE5udXI3blFCa0Y1bDJKMVV0UE9HRE4wMUloUVZxVUJEbnhIeVM4?=
 =?utf-8?B?Ly9MSUpzODVIeTJOOXFCK3hYMGpiU0lMT3ZRelVEQUdYNGplS280bVlCMUhI?=
 =?utf-8?B?QXpqUVNhZVdZVXgyQXhDUld6TEl5NTllSkoyYjl6MTQyaHltZTl0QkpIbzJZ?=
 =?utf-8?B?VDl0Z04xeGh6cVN0aHM1VnVHZ2hvYkIvUHlEVDM5Nk5wejdDL1hncVJCTGFX?=
 =?utf-8?B?bmJab2dkMlh1Mk5OdUEyQ0htY0hpUHIzMHdqN2IrNVZPVlpZdFAzeFIwcTNM?=
 =?utf-8?B?K0ZxRWxEcks5ZlR5cDYxRDRScWxGejFPWmRORVVTM01SakFqN1VVbVcra2Zj?=
 =?utf-8?B?RnZlOGV6Y1pUc0diY1FWTFU2V2tDVUZYOWdxdUxpelpkN0dGRHRvMU9UdDRn?=
 =?utf-8?B?S2UwakQ4cHo1cVBaWTBuZmQveFJGWnVBL1Q1QVhoeEx4NUp4YU1hR3F0b3pi?=
 =?utf-8?B?cHB6eE85T0o1ZU9WQjBrRno4RGhhR0hkWjErdHZVclg4aWJtVXNzN05ReUJu?=
 =?utf-8?B?N2xhZjhpUk5TVDFKOHFnUm4xZFdSemJWd1VIcHVSQkVHaFNQUGlrTXptemx4?=
 =?utf-8?B?Y0U0YzNrVXpGQWY0VUFMNUlOd0NSK29OLzYyOU9OenpNSndnTjRrN3ZsUnlx?=
 =?utf-8?B?OFB2cU9iRTNQSlpvMlJOUUN1d1RpdmllRVRKdDJVOEZVVW5iTjVNM2YwRkxO?=
 =?utf-8?B?dnJPUGw1cXB5VXUza2k3UGlCQmdDK0xsSVdVUGxMck8veWhwLytORnY3anZU?=
 =?utf-8?B?MkFPTVNtOCtnM2VCS0RJay9aUnF1d3JrZzdCUDNQTE5LRVhhZTlycFZackNh?=
 =?utf-8?B?T0xML0ZkeXBPWFowMVhnd0k1WFZmNUMzN2Uwdm9uTDFucVRJUVp5T2hXUFBU?=
 =?utf-8?B?Z29BWEg2NEtUZVFLbFgyY2xVUFFQMmlGMWluczB3dHhKcVZ3RWpLWnNhcEc0?=
 =?utf-8?B?RHgxZ2krUlVPY3JLUTVyQlMvUmVkcGNTTmRVVmlPOTJwdzJ2c2ZVNWpSV0RO?=
 =?utf-8?B?MGtsNy9Lc1pJdFBQdmFwb25UQ1ZtaS9ydU9CMkZLNlRQbjhvUGZGdVpiVnRQ?=
 =?utf-8?B?bVlqWTJVZlZSWG1ESWFTeStTcERBWmp3dExxdEdSL1ZRL1Z2WEwxNHdGOUx1?=
 =?utf-8?B?Zm81ZGloREl1Nk91Y3JrSElNUzdFL2FqbVF0eCtSejlJR0F5Q3VnSVBjWWR1?=
 =?utf-8?B?WURrTmFFbzJQTFVlM2l3bVBpcUFXSjJIWmFQUDVqQlRHUnNTc3BqcFNBdjlD?=
 =?utf-8?B?L3A5MGxXVjRQZlkxb1NjUWNFQllPcUJIUUc1Zjd2bEVrMU5zdE9NRlRyMjIr?=
 =?utf-8?B?dnBpOXFzV21mY1IzOWlKaHo3aHM4cld3NmtudXkxMzZRcFdGYkphL2FPeEMx?=
 =?utf-8?B?cFpMdlN2bTdObXdFaklhamt2Sm1ZQ3E3UzZhTDBTbXBlYmtYWnJvWWliditX?=
 =?utf-8?B?SEVObVBYRDR2VERxVHRNZnJZQzcwWFRIa25sU2w4MFpDNVdKVjZOKytKcmQ1?=
 =?utf-8?B?NWpMaERtZTBFT1BOOFh4ek55U3h6TUxpd1ZTWXRnRm5sVDF3WmcwSWN2Y2Vo?=
 =?utf-8?B?MTZTb2t5cDlxTWRtK3BweWhNME5BPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D33A3EA7F4A2AF429D2820917E4A7C5C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4815.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f7ad758-1e17-437b-1fa2-08d9e0590e91
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 23:18:54.9645 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: he7K6vSJuoY3hx7MIFt/Ed4cILtO2Ea97hYRK8VpquA1SMu18aoORW+KlWXI1jbFvlLmiIgK5QPP5TMrVkreGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4222
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250140
X-Proofpoint-GUID: PHvdYkDD7zuzoF-GuwM7kWVD77Sq8jCu
X-Proofpoint-ORIG-GUID: PHvdYkDD7zuzoF-GuwM7kWVD77Sq8jCu
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220125_151909_035503_7CB6CFBA 
X-CRM114-Status: GOOD (  22.44  )
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

DQoNCj4gT24gSmFuIDI1LCAyMDIyLCBhdCAyOjU0IFBNLCBTYWdpIEdyaW1iZXJnIDxzYWdpQGdy
aW1iZXJnLm1lPiB3cm90ZToNCj4gDQo+IA0KPj4gKyNlbmRpZg0KPj4gKyBpZiAoZXJyX3N0ciA9
PSBOVUxMKQ0KPj4gKyBlcnJfc3RyID0gICJJL08gRXJyb3IiOw0KPj4gKw0KPj4gKyBpZiAobnMp
IHsNCj4+ICsjaWZkZWYgQ09ORklHX05WTUVfVkVSQk9TRV9FUlJPUlMNCj4+ICsgZm9yIChpID0g
MCwgZW50cnkgPSBudm1lX29wcyA7IGkgPCBBUlJBWV9TSVpFKG52bWVfb3BzKSA7IGkrKykNCj4+
ICsgaWYgKGVudHJ5W2ldLmNvZGUgPT0gbnItPmNtZC0+Y29tbW9uLm9wY29kZSkNCj4+ICsgb3Bf
c3RyID0gZW50cnlbaV0uc3RyaW5nOw0KPj4gU2FtZSBoZXJlLCB0aGUgbG9vcCBsb29rcyByZWR1
bmRhbnQgdG8gbWU6DQo+PiBpZiAobnItPmNtZC0+Y29tbW9uLm9wY29kZSA8PSBBUlJBWV9TSVpF
KG52bWVfb3BzKSAmJg0KPj4gICAgbnZtZV9vcHNbbnItPmNtZC0+Y29tbW9uLm9wY29kZV0gIT0g
TlVMTCkNCj4+IG9wX3N0ciA9IG52bWVfb3BzW25yLT5jbWQtPmNvbW1vbi5vcGNvZGVdLnN0cmlu
ZzsNCj4+IGVsc2UNCj4+IG9wX3N0ciA9ICJVbmtub3duIg0KPj4gQ3VycmVudGx5IHRoZSBudm1l
X29wcyBhbmQgbnZtZV9hZG1pbl9vcHMgYXJyYXlzIGFyZSBub3QgYnVpbHQgYnkgaW5kZXggc28g
SSBuZWVkIHRvIHdhbGsgdGhlIGFycmF5IHRvIGZpbmQgdGhlDQo+PiBhcHByb3ByaWF0ZSBvcGNv
ZGUvbmFtZS4gIEFyZSB5b3UgYXNraW5nIHRvIGNoYW5nZSB0aGVzZSBhcnJheXMgdG8gYmUgYnVp
bGQgYnkgaW5kZXg/DQo+PiBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IG52bWVfYWRtaW5fb3Bz
W10gPSB7DQo+PiAgICAgICAgIFtudm1lX2FkbWluX2RlbGV0ZV9zcV0gPSAiRGVsZXRlIFNRIiwN
Cj4+ICAgICAgICAgW252bWVfYWRtaW5fY3JlYXRlX3NxXSA9ICJDcmVhdGUgU1EiLA0KPj4gICAg
ICAgICBbbnZtZV9hZG1pbl9nZXRfbG9nX3BhZ2VdID0gIkdldCBMb2cgUGFnZeKAnSwNCj4+IFJh
dGhlciB0aGFuOg0KPj4gc3RhdGljIGNvbnN0IHN0cnVjdCBudm1lX3N0cmluZ190YWJsZSBudm1l
X2FkbWluX29wc1tdID0gew0KPj4gICAgICAgICB7IG52bWVfYWRtaW5fZGVsZXRlX3NxLCAgICAg
ICAgICJEZWxldGUgU1EiIH0sDQo+PiAgICAgICAgIHsgbnZtZV9hZG1pbl9jcmVhdGVfc3EsICAg
ICAgICAgIkNyZWF0ZSBTUSIgfSwNCj4+ICAgICAgICAgeyBudm1lX2FkbWluX2dldF9sb2dfcGFn
ZSwgICAgICAiR2V0IExvZyBQYWdlIiB9LA0KPiANCj4gWWVzLCBpcyB0aGF0IGEgcHJvYmxlbT8N
Cg0KTm8sIG5vdCBhIHByb2JsZW0uDQoNCkFsYW4NCg0K

