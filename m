Return-Path: <SRS0=c0j7=HK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6654DC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 16:32:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D648C64E8C
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 16:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D648C64E8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gu2wkch24Evn8oEaSy9+0jnJ21ZmFCZGjJ5r3nNEdeg=; b=ioTWmag9b+FtCtwCKG5jWXGLkW
	Xi/NyRQjb7ytBvjIJIfxpbXlf1AoKDIMnOAJA/4CDXFQhzuyPQ/TBFGTZCx86P1foGdzTcH4/EgtH
	AkpkYxCSiAO7D2ICxpMt43O6Ssav7Q4LlvYumRp2Rucn/CVg1/CFxQW8gUcSXt/lOM7/XQRM3ltKD
	qfdDKRZBcQUH2k0yR0DFwFGM3Du0P8XDCNVxb7qby0OBlelbps7XS8MZZK4qnE49viqMNAibDSrBz
	wm5Mdj1CLPWSngJjSxdWdFVuRGzeKF7IKpA/BO5KPvdd6wDw0Iw+20X07J8JYnu1Sk3i3Vowavgu+
	UPQpVGYQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l99SZ-0000JW-NC; Mon, 08 Feb 2021 16:32:23 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l99SW-0000EH-I4
 for linux-nvme@lists.infradead.org; Mon, 08 Feb 2021 16:32:21 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 118G8mWf029784
 for <linux-nvme@lists.infradead.org>; Mon, 8 Feb 2021 11:32:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=jOqhcBX6wj2+Ic9OwXD3F2I3fWBCwrnbBlM5lTCX/Bk=;
 b=aozzFow2ZQn7jqkJXJqNd9MF7wIeojGPYnUo2fdKanH+VU6z0sBOWZyxgYZAgbYZ/otA
 OVDB68bJxGiyi0KEBD8OutCbbDTRrU4a4J62aJrh6HsD69T91cH0iMbveNeaR9IgRId1
 PnKapyuxoG1inOl9eImm0POQNHCt4j2+t3uA+IYtnpTkUZGIuetc/F67ou4sLqP1YhsC
 KyUTEz8e7dZjHSKHvzV9wxDt1KQ0PsKjIcMKy0J371lYhBRg49pyp+XIDh0XNCQOBhYS
 ccF32CJM11N28YNxZ0DP5bbWRsHpVIbmG3WiZO5VdahGn+PDFFxN2m9VBvgwPWJCUjNc Gg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 36hr0pn46t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Mon, 08 Feb 2021 11:32:18 -0500
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 118GARxn115334
 for <linux-nvme@lists.infradead.org>; Mon, 8 Feb 2021 11:32:17 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
 by mx0a-00154901.pphosted.com with ESMTP id 36j8ucjwu0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Mon, 08 Feb 2021 11:32:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfM8bFE0kLGpdpHKXqIjO54DkkzY5oXCsZPe1TPhWexhUt7LKIQ5c0CDeHzi+0q/TyOMXtyy9HV0xHSZJDihWW1GjRVzpWsAHQjewmfDTc5VBYac818p2O6+tYmCJEl+id33cXjYIrcnPBKKn1iSGl7cbdfga1J7SdH2PkmdTeXuZ9mOVGH7j35o9zJROoeV4t5YmDnL8/xFHpOWgzlSCcR8kgvTwbGWxtbNlb9TnPtoaw130b9rTzfWURV8L5ZeOCjoH+0/t+mXvMnb5bO2gbORiGkBqh2yIGRq7hEGKBzroYZ7Ci/zmd99a8fi4vP0UQXZTIY54pZx5VzO2MqFlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOqhcBX6wj2+Ic9OwXD3F2I3fWBCwrnbBlM5lTCX/Bk=;
 b=KvmFHLlJaso/GGncmg55BBNuRj8uztVPw/iYSkJnsYQXhDec2L/0Q1Yi+7a0sHpDSeF9WbZGdtFxAF2JrJeRafhaX9SKfczchJRSqMtB1mvIGrBad0kQd0PUmxdOK/Q2YGjIaAtgS71+97t9iv8GvoUaZ3mvorwhAo+qdvSupJnLHHxQGEWE3PPJ6LMlL9nosK3ncmqZWYxRj2lwa74MK/2mhdJQppKKJg+kzxD3C+UBB7+5RFkGbXLwlFVN11prd22mjxI0sXlSYlT2R5wUGHYioMU1WwT5SpVyZSKg6pTwzDpJlhDA074xsinlfH6QPSae/U4OOd4kgVNnbivd3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by SJ0PR19MB4828.namprd19.prod.outlook.com (2603:10b6:a03:2e7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.28; Mon, 8 Feb
 2021 16:32:16 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::c8c3:8600:d46d:f9c9]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::c8c3:8600:d46d:f9c9%3]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 16:32:16 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Clarification regarding "nvme discover" and setting IOSQES/IOCQES
Thread-Topic: Clarification regarding "nvme discover" and setting IOSQES/IOCQES
Thread-Index: AQHW/jXNiWJkYFZ+JUOKUf78fOZ49g==
Date: Mon, 8 Feb 2021 16:32:16 +0000
Message-ID: <SJ0PR19MB4544CE3903DEEA63D0C3929FF28F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=Dell.com;
x-originating-ip: [174.19.123.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f72bf0a2-1193-4d47-e1d9-08d8cc4f18b9
x-ms-traffictypediagnostic: SJ0PR19MB4828:
x-microsoft-antispam-prvs: <SJ0PR19MB48288465D1EEB01A76ED6900F28F9@SJ0PR19MB4828.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TRIYr4HW/37TQwy2lxrMRVfk2LdzyjWis8yEIUMYMl/XUA132hfarbaeMjCTDougReSn8xQPFNMQ+Q/LLpHmJ352mqq5ulcAP/ydpY/QKwvXGST67Ax0kvJUosWKUaIVnq8FOFEaO504ffcrv+5Wj7MOoXqk6qlo7VCqT2MTDrpF0qyN7hIflo34/Mp9j7a+9clt2kfJS6q4uu9OO0mV+QmdO2V2xN3g8KdVMzP58O9gfwBpUvb0GUujKytNRayvhG5v+kolT1+LRXoKTy0EaAjOsRYEdTZagIjGjSAyKfWqZm5M9nCbEswXOQHMQn0mwLOpIc0trLQYKB+k4Hgw7cPJK796bewjief1IJPLEc7NAWZfvrr12+GFF0BmuIPW2a1t818LoyhtnkcCZywUY/oX85LE7f3r65L7enSdLHlEtRDFn5mhq/B0yQ6i5L5s2Pw5r6q0vtrWc+dmlmNvTFwLcbcgA+3ZdeeYDxzfHSTJrRvRdwfuGUs+DBHayL2TSLbZLsidiB1dngZ++fU2ug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(66946007)(66556008)(316002)(66476007)(76116006)(52536014)(64756008)(8676002)(7696005)(5660300002)(8936002)(6916009)(86362001)(91956017)(71200400001)(786003)(186003)(55016002)(33656002)(4744005)(6506007)(478600001)(9686003)(26005)(66446008)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: ePVZ65C1Bf7O4U13OXYdjhakGACxqskM/cl9UO13U0dFzYhxf9qJlv4AKXBvSAZ59O0RQCxwOaapdwZuzoQVhK2J7SZEuzZ3xRe0CyAPOIEhc+MUfKpjVEz3aaO+0GYT3qBpDgBgKWMmhoZvWLsPaqoo6WowzAlm6sOAf4JTWtUEkf8G89d2JmtFrXsdBqNy7/mkHQlV6i1/8WxbrHv0iXecXbDNwY9KKiliuAqRJjjb+SD9Zvlw0U0DtFqdjS9pRiiZ8eZbSNnLvWiYij+a7dDGAtMISGDyLm3wOV0l4gM7BxHi5k2icG5hDGcQAIvG2U8p2bunmPwv+Xt8y29LUuyOOAqdGFGNJzeDVX0F9nAdZQvw6eOOrMpoXcCRmZT/1DzX92meaadzbY0T7jEa8WvvsPWtHbc1VMBS4Dm//9gXzMboCY5icNzMUQM86GU5QFqF7lUPhHz3EuEm5z6J2F52h1ki/6rb1ENAaVZyJp6MXP3FiKrruEXqWDG9jmioenJXxJ2r4fnp4lImWZIff1bWNgdA5VbX5l/JLACfll4kPWhpO0pBVnIDja4qUQLe8B6mBMRVB4QUfA43VswUgKn1pUX35TNqY/g2UeT7GhFqFviVnYHoJG9ZewPCky12v/tuZ5ONQGOG24j9D3XvPkSNbWEPEGt+anv4GX3/Fx85UbWFXucnFP+YiOjm92AftU/492ZwQ/0Z2zLyTdxX6FnmHW2qKKL11nLjpPlU+Dw=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f72bf0a2-1193-4d47-e1d9-08d8cc4f18b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 16:32:16.0729 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9Qwq6mK24AWiODy3wbuFxQNHdEVxeoTtbP1GNKh5fqm37RWOUvjyWdF7WEiYteWM7fAOAPw6iCOhD2hL/FRcCuXuvlcrAViEjI1SZJ5swU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4828
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.737
 definitions=2021-02-08_09:2021-02-08,
 2021-02-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=3
 bulkscore=0 adultscore=0
 spamscore=3 clxscore=1015 mlxscore=3 impostorscore=0 mlxlogscore=152
 lowpriorityscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102080106
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=278 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102080106
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_113220_801829_D04B636A 
X-CRM114-Status: GOOD (  15.37  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I'm using "nvme discover" to retrieve discovery log pages. And I'm using nvmet-tcp as the target.

From what I understand, "nvme discover" is supposed to set up a connection to a "Discovery Controller (DC)". During the exchange between the Host and the Target, there is a time when the Host must set CC.EN=1 to "enable" the DC. I'm using Wireshark to analyse the packets sent by the Host to the DC. I can see that when it's time to set CC.EN=1, the Host also sets two additional parameters: IOCQES=4 and IOSQES=6. 

In the NVME Base Specification, Figure 78 - Controller Configuration, these fields are defined as parameters to configure an "I/O Controller (IOC)" and not to configure a "Discovery Controller (DC)". In fact, it says that "If the controller does not support I/O queues, then this field shall be read-only with a value of 0h". 

The way I understand it, DCs do not support I/O queues. So why set IOCQES and IOSQES to non-zero values?

Thanks,
Martin
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
