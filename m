Return-Path: <SRS0=hCdm=2C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E69C43603
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 09:14:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEEDB214D8
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 09:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EDfDyVsJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="TreVaj8O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="bb3HBdLH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEEDB214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=en2iUVkqFUrIGIgqaouVG6FZLRsJwzstlVyxs1p2+8g=; b=EDfDyVsJnmI5nM
	HyzzNtiRhvHtwJuPWYPSM2TCVNwJb2AQAmRrvhhIdgBN9YOhQ0gWdASeKlvPZnzVVtnmzBPKmK04O
	8y5ykaya77nSDYVJgNdDe32TqeTnAw+CLs2WSbKSN5QKCHgDZxRw7Te/q5fJsWr9JKxg9bGGLMpN7
	Mxa905Gi8BW6hC1WqF8lWk/U6iFC3k1q0+CHlW1OgTxfllqjdCdqtAl8xViNtg7m6FaQNxMg3aZoQ
	3X3FALxkJ7ahNu9hSPcHSRK1lTcWeN+5tZA/5uS8UBOGL9DfO77u/RQLG1fQ8/ZK7QlH3U3MT56CQ
	uKRI9TiA5HPffn7OH9Kw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifKYA-0006CH-SW; Thu, 12 Dec 2019 09:14:22 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifKY7-000680-KJ
 for linux-nvme@lists.infradead.org; Thu, 12 Dec 2019 09:14:21 +0000
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBC98rd8012374; Thu, 12 Dec 2019 04:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=NLIwpnkeSA0MrbS7EkKWMbBEvo7xxDhHHBzAFmYrUiA=;
 b=TreVaj8OI3OAkVpj7pIeL2LfsZxozzZvpZkBh6hOsc4vsBfAbSq7Hb7gSm+wEk7DXol8
 sAXGdeBB85fTnBu3eGn+vx8vaNYu4/5I8U5YPJQPVjC2bnQvibpXHL8lvUH6vXmkTKyF
 WbSZPdO3xxYhpKu/gqzBmhBZebBI5X6pZmIP0Ylz/NjXBmAmq/siN+Et6DXIpoFL7iRE
 s8F6wpew+HzLuXn5B0tjNuTZRyrMTdaYy5L+9IduZNKID2ACyMtegNZaLrvPTeq875ex
 Rq/0tpHjRckFXgZcSIAp329iVeuyP1G6KYisVQz7iwfUAq3/M79gxZWX9R8tQ9yX36V7 aA== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 2wu839a4xk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Dec 2019 04:14:17 -0500
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBC9AG27015676; Thu, 12 Dec 2019 04:14:17 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
 by mx0b-00154901.pphosted.com with ESMTP id 2wt48cy043-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2019 04:14:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieQ1g/PRCiD6ENf1EfnXrYQCMDfB0l7kL2bmiqTmlIzGiM2GNLYfCPbJGwyVK2VsV2oSaDwXv4FgpPlYwdYcbs+JWNAOt4wCZB4NkfCb0vgzIVxOX0G/zME4ciF5FAD0O25gE3VwlQEElEbMnNGPTFhgO1MtkWvrWwClt6+64Jy2Ch8mk8wn2ZQNsGLOu96+7B0G2rZxpQHRPAJS+5n+17sWPy+53pu27649Ijthi6vAbtuEZu7QIh3q176FbYhobmxNpa78pXX80lkVldoD0y4NEmub8jf2PFwHdmCsTSIgHEmN3MdqsiqVHg7RiW7WDhcEr3xpWLS9+++2PrY6Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLIwpnkeSA0MrbS7EkKWMbBEvo7xxDhHHBzAFmYrUiA=;
 b=R3SJhl1NWzeStM7M2nAJR2cjVs9VC0viUz7oJmEbNrCZ5C8pablib4Atbsv/w6yjsRYSUsJbTTmZq3tmmoxxiS3M8TRqyEOu/VT1r8lzezaF/czGvj9X0/vxHoxO8ljs/Ai6hPGrU3iMLj+vuzsVTC8mEgzubzaghLcFKl6CRbtJWLpwCnU5AbaivMhJZKA5PL8kLYGH6+UvbjOMzruTPAQTfhclBZW2cbv0Ze2/Rc95j8lE5+IJujCkPY9BIcKA8Nc1JWjuJmZx9BgmaRgTr5Dq1ARRE81SoODDHFPU9EVxizxj4ipAg3BnLJfXMElo9u4nN0lmDvguTEnn2Ucumw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com; 
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLIwpnkeSA0MrbS7EkKWMbBEvo7xxDhHHBzAFmYrUiA=;
 b=bb3HBdLH09FiX9m5reFJOTSf8kNmacM64efXx7LIzzFEY/f+Gdw1nkMr1PuRJLoMHUDTuGQqBeSTzFtFzCiRP47LR1oQEa9aIk6Lyk8Sx/S2fqAoR9+qcxxybyXl0xJy+TIEWrxdmCXVeO/0htFsn0iRA0IJ9/RzGaqsDopkxso=
Received: from MWHPR19MB1487.namprd19.prod.outlook.com (10.175.2.8) by
 MWHPR19MB0989.namprd19.prod.outlook.com (10.173.123.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Thu, 12 Dec 2019 09:14:15 +0000
Received: from MWHPR19MB1487.namprd19.prod.outlook.com
 ([fe80::885f:1a1e:735e:2848]) by MWHPR19MB1487.namprd19.prod.outlook.com
 ([fe80::885f:1a1e:735e:2848%7]) with mapi id 15.20.2516.018; Thu, 12 Dec 2019
 09:14:15 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni
 <chaitanya.kulkarni@wdc.com>
Subject: RE: [PATCH] nvmet: fix per feat data len for get_feature
Thread-Topic: [PATCH] nvmet: fix per feat data len for get_feature
Thread-Index: AQHVryqPEbFoF0GqL0C0cLNSgLqskae2OMWAgAABwUA=
Date: Thu, 12 Dec 2019 09:14:15 +0000
Message-ID: <MWHPR19MB14877764B733AF1DBA135A96EE550@MWHPR19MB1487.namprd19.prod.outlook.com>
References: <20191210072201.9631-1-chaitanya.kulkarni@wdc.com>
 <20191212090717.GA2399@lst.de>
In-Reply-To: <20191212090717.GA2399@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2019-12-12T09:14:12.6338572Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-originating-ip: [152.62.109.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 285023a2-1090-4d52-5e15-08d77ee3a8f3
x-ms-traffictypediagnostic: MWHPR19MB0989:
x-microsoft-antispam-prvs: <MWHPR19MB0989C354C3936E0E70E54F4EEE550@MWHPR19MB0989.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:1360;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(136003)(396003)(346002)(376002)(199004)(189003)(7502003)(13464003)(6506007)(53546011)(66946007)(8936002)(186003)(4744005)(7696005)(71200400001)(66446008)(316002)(5660300002)(81166006)(81156014)(8676002)(66556008)(786003)(110136005)(52536014)(76116006)(66476007)(478600001)(64756008)(9686003)(33656002)(2906002)(86362001)(26005)(4326008)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR19MB0989;
 H:MWHPR19MB1487.namprd19.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: Dell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HB9Cw+7CH2aDzHiZfxvTxFacDBvfggL9H4xPSWNwGLhMDqlhnLvzijei4wqDN8GTdCbUkneUAs4JM9hAL3J+GgYap+b7a7oPYz79Ynd4LIUhpnz/w/H6CY1jYt1Wd2Ii/tUOhkZwlzM4O47Ov2bZGuvIxjm1CGhZ5JU38VPy+FyGBLufFocXEvYE635o4j+GHbf9x/FVNnkZKw1uxD8mQwHzfnDhdGz4cW35XlDQOdpNq+6z4adRrX2JpYvx3Az+sOk+LccujcDi4DaU5XnRNca8fp++cOPazyjMgqzRbPxkRKKZOQHX/3jPvwiAWSiAlaNA12RyStP9AIK7LRv90iOlSeFIoXykSZDSxH9ZumQZVo/asPj93uSgRdu7Ai3P54MJQDaXwNPPb237+Sz+/YfhjGjBU1RZ2PRY4BaIdvTkyGi2TE1GLqoHCyvSF/smAFOW7/E1+fIksSRWbokvQWMZD3bkCfGB6rqHYNV9EJNYr/jag1PJ9lErRuVGeDoVOTFjlFr46QSK+/UcxNE1Lg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285023a2-1090-4d52-5e15-08d77ee3a8f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 09:14:15.1862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x3x5xpSrRYSjKFGfKh0N26Vgl7CwlhZd9jjTVTfCAdrOVwvmm9CiQyRp0k8bfD/+nD6Gm2CWe0jIrhZ8WvR3AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR19MB0989
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_02:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 bulkscore=0 clxscore=1011 adultscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=874
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912120064
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=887
 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912120064
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191212_011420_002301_2EB507DE 
X-CRM114-Status: GOOD (  13.00  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Chaitanya, do you fix the double author line? Do you want me to do it?

Amit

-----Original Message-----
From: Christoph Hellwig <hch@lst.de> 
Sent: Thursday, December 12, 2019 11:07 AM
To: Chaitanya Kulkarni
Cc: linux-nvme@lists.infradead.org; hch@lst.de; Engel, Amit
Subject: Re: [PATCH] nvmet: fix per feat data len for get_feature


[EXTERNAL EMAIL] 

Looks good except for the double author line:

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
