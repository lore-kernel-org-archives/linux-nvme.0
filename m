Return-Path: <SRS0=KdjD=LS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D835C49EA5
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 12:34:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04DC7613F3
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 12:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04DC7613F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WlilJPsiyE1kzF2OOsdqmUm+x++CKeBk2oE5MF91Ies=; b=RmpE6RXGPvhJTs
	Dh2zAr2XKCEsBvTGKY9hCRaWdjs+cj8Larl2DzkHo7QSTdFs4iNBmrz526WUnr4yIql3e0/1Zwc5G
	C33uVUgOjaHT2T+8YjJwK4kPdZ6a7WJvZa07wTKrIwgKwN3x3FL0JuuL5h7dd0SPIzxs8zy0bt6al
	CuyfeXRH99x4TQ00IN9lz9Zs649Ql+XHY3IdBh7jYxOvKu3yDuFbksMAZgEOYzpM7XIWJHHNwM4HY
	ogfwKDTqJcKPAFENAt/gjL+ujqWMwczLfABOFDlTiAiADDZCp6R0RwbI5to96VLTk2j5oaeMxuW5s
	G9uAI5Ae/F2vbKnT9TwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwOYR-00EcX3-3g; Thu, 24 Jun 2021 12:33:59 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwOYO-00EcVy-NL
 for linux-nvme@lists.infradead.org; Thu, 24 Jun 2021 12:33:58 +0000
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15OCS6YO029738; Thu, 24 Jun 2021 08:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=RuNo6Zi8+zp+UGRtCxbZJWFy5JP7MGQrk0DJF/uIbq4=;
 b=hgOnJEqKH5IdZV7teG5dziZ2QjGSLCXNB+4a7SAJowF8ju7UnWx4ApQKscrMNhKcBDuO
 E5HJakjoBZ+drsdbX4IOyce6UmZ+2vF1XVJe2tA3nddViGbqDRfuPsin9njn/BeDtdIz
 g8NG+Y5TLNLLJHzKCUjXIDHrYEQjn9WztOK2aAXuOpbGQdy/rSqjUFSSt1hlMK930iUp
 s7s42y0X11wpERwONO/35AoQQownRUtfuCtOQk1XvmKGK8jDm/Q15ryzwU8x3a6VR+gp
 V7QTcKnWLbIeCGlX0xDnUroUOm0Y3ovNfXPwlhzT5y47jxcEbRtRGr3bNKXonKxQDeEn WA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 39c046peu2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Jun 2021 08:33:54 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15OCTfo8115024; Thu, 24 Jun 2021 08:33:54 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
 by mx0a-00154901.pphosted.com with ESMTP id 399x5m7h48-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Jun 2021 08:33:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpzUq0loy1GbA50mSG+Djvna+yPIyYM2G7XvYewYtlj5ls8jVqNHHlQNpFBxmQvsUV+k/BSYDQj3ALQ1MmtHNp+FBdRkXp76KOziimBKpHTZ5y47orPLv5Jr4ZHeFD0WvxEAW2ok62QsHnGEkgtcUeFy5jaBe+4/s+h7hKRR4FXuwvpOHX8hv5vsBHr8k3HGACu/45UNJLzbnpai0Gz0OW3gcESuwWl57i+/9nG2MRbp1O17zLQeQqrpkYu+SyKCaqqYvoyG5xVibCdsxINXV/mHhRZFWimMatjZuh7tyVDdDbiq/2AW6eHyr9ifDng3VjlBMw9GgW0eDmXPUYs9zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuNo6Zi8+zp+UGRtCxbZJWFy5JP7MGQrk0DJF/uIbq4=;
 b=iDKO9Q6pFVRnP1j5MbR94WutNKu7M4JvSMQJvRH0BbLa61ccGZqQcJcqRIySDq0xfB5pb0IaibNJUrJCWVolesl3jDd6CWfJi8a9RsOjbpqM1gZxmQC9UBFn+zI56eOhD4mWgNkOlyUzeK/IhRzvsgoKpptvQIP9x4H+5A3eNReL7a7Y5hDkmt+qU7lCu52q2ih9wGU0tB74lZz7PurwYrxW1BBLzv1DKbgynrB1/uuuKOhp5JVpXpMcUmW4MplJUAvmLlESElEnBTbWSsw4cx3BJzjSi+Lbg3tTuR1NS9KF3vBAWmHKlPaGkrfoAG4LM9aS7xPcqYpHCzkUrXSiTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BL0PR1901MB2067.namprd19.prod.outlook.com
 (2603:10b6:207:33::32) by BL0PR1901MB2033.namprd19.prod.outlook.com
 (2603:10b6:207:1d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Thu, 24 Jun
 2021 12:33:50 +0000
Received: from BL0PR1901MB2067.namprd19.prod.outlook.com
 ([fe80::acbe:4dc:8bab:7dfd]) by BL0PR1901MB2067.namprd19.prod.outlook.com
 ([fe80::acbe:4dc:8bab:7dfd%6]) with mapi id 15.20.4242.023; Thu, 24 Jun 2021
 12:33:50 +0000
From: "Anner, Ran" <Ran.Anner@dell.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "Engel, Amit" <Amit.Engel@Dell.com>
Subject: RE: [PATCH] nvmet: allow setting ctrl to ready without iosqes/iocqes
 set
Thread-Topic: [PATCH] nvmet: allow setting ctrl to ready without iosqes/iocqes
 set
Thread-Index: AQHXP2gxgHuXTqF1fkK8viMU+Du7qarTDG4AgAmiceCAAdkmAIBE401A
Date: Thu, 24 Jun 2021 12:33:50 +0000
Message-ID: <BL0PR1901MB206733CD44E09D208EEA9D0791079@BL0PR1901MB2067.namprd19.prod.outlook.com>
References: <20210502153106.18970-1-ran.anner@dell.com>
 <20210504091236.GA22900@lst.de>
 <MW2PR1901MB20756A164FC6DE36BE5D718291549@MW2PR1901MB2075.namprd19.prod.outlook.com>
 <20210511163348.GA18486@lst.de>
In-Reply-To: <20210511163348.GA18486@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Ran.Anner@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-06-24T12:33:41.0111305Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=167dabb9-2d33-4131-adda-2f134e3b816a;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=dell.com;
x-originating-ip: [109.65.198.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30f04e54-ca7d-451e-1b1a-08d9370c51de
x-ms-traffictypediagnostic: BL0PR1901MB2033:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR1901MB2033CF4FC2977A30F3D9B92D91079@BL0PR1901MB2033.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EcbJ1J1VrSpYI1bBmMADqzNfpe+MYzBLz9Da6rCdo/cTkw1I9Hk9Mi3l1W7se6JQY+0OaP9WBgGIutnbhmgIDxMmzcq/kkVUFf26BDFbrE2V4h+oyvBylNMKc4hkRDuTPI8Us2DgZ5UcR/bdmZRgQ+d8Tj6kGaOm5JwV9N7UD1bPDHeYCvoA4yM9AbSw8WYJyh95EChRDvkWfk01k+oOcMMGOlEyndIB979D6c+xlYFzgJieEOF+TORNW19eH2Q5A4lc6rWecK/HtVyYnzWCZ0nOinsc6HOMqscpH7TqD/sccEBj1lEvREy4eutG9iM1grMxb1l7AII3X/NYgleX9B3EPfIc1h3MlUgt9mxk3SMMN8AfHCz8QSehxSyfZs5rOeFIB6TZODYI76sQOPPSewJto+ImS7CuWlkvN3862KeXcQJ8AtitebRg9egrvNpC8grKKCvw9oBmgmkPX0K9hZ68Mtu8lmO5tJSKKBQf02aNXFuttphW4HN6Aukw7VRi0WVFlmetLJOFVFk1vbht4gcp2s7LxiMtltDa2ofmZ5Aq0anAlupOmYHUbFVznwUcrlyjsyI7C1l6zZLcyaLt95rRs+V/6e3sPCN39uxfcrAGS2WFXiMxPwpTst49MA8XelGgkh60xSoPOgSV42kSWg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR1901MB2067.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(33656002)(110136005)(71200400001)(478600001)(26005)(6506007)(53546011)(107886003)(5660300002)(7696005)(316002)(786003)(55016002)(52536014)(186003)(2906002)(4326008)(9686003)(8676002)(38100700002)(86362001)(8936002)(83380400001)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6zS15gpgfWbk6ci27ckRizo/wNJvAdGlItQBLMohV4VbkaIAkDJLOOUBKCXO?=
 =?us-ascii?Q?lyPDI5StUCZbF5bjuGEJadi5MjcMCsfQg515Pmkot1lFaikgYxUqh++M8d84?=
 =?us-ascii?Q?RYoVOmHelegHqJLHdRI2qwWdWBG/+/8Xacri2sVasKfPu1Aatah553LN5u0h?=
 =?us-ascii?Q?1RIaqQLMlck7bFrGAquRgVHCrZkIBZxA9WA0rdabcgynSnRHrpRuXHJAhp4o?=
 =?us-ascii?Q?YbzxVniNNMNO632OW/25I7IBMag4kEJjgiGM3ItGWibvrF0RJcg2newWycpI?=
 =?us-ascii?Q?wNzifsyHzsNfFzXVViL1o4x6flIHDyTjxeCGbtmZqDBSQB2x/X2ahmJnrfVw?=
 =?us-ascii?Q?2793sLrI7bjtJNGQEtvcSNvykJMH2EVs+zpsFCcSdj3D7A2Y2u4Uk6+ExFtw?=
 =?us-ascii?Q?DdfeVOEI2KcAAwWqErWYfp5TTEYdfpLWUrNXmuqDPYswgsXf9i3C9WNeD/Ty?=
 =?us-ascii?Q?g94POYOFvSS6r8gxvXvfqP8AC4p/LkQJTNAoXFMNSvb5nqdwT+PcsR1VM2qX?=
 =?us-ascii?Q?L+Trk3yxVymjbPO+AcCfvxSTZenQMJbwtKeIH/s41G0RjfEOAf9zVdma6Uod?=
 =?us-ascii?Q?LJcWKPfErqtLWON+EjyEOWOpkxlfpE+KZhN65PkIc2QIyTI1lXIu+kyx9CrY?=
 =?us-ascii?Q?FRW359RGWgfrjdBwUpJL/OERkNOM5IxRwAD24Hndmse+KhJHBHKaZcZ5lePU?=
 =?us-ascii?Q?oIrVPnqdEHMoyhL7fu5adkSFY0NuxbyG/118gYgC6aBWZaPXdKAPrsxkusRN?=
 =?us-ascii?Q?PEVNF5kjL1SOlbpOGIAFrQwU8kxCPWEi2/F0g58U/YU2jSiDRWpFXNGDT5yb?=
 =?us-ascii?Q?bFsPbEd1+4B2qmErcmaOA5V4ruPqc8hyPP29CIKHf/7DmW9G+Vj9Ob4OpLev?=
 =?us-ascii?Q?8C5YvI+f4n0rr1RNpeXCWi1pglhSp3SnLeSHHymDSJA2QioBrCrMtbl3J60S?=
 =?us-ascii?Q?LjEdyDTwARpSrGX4oUqVoG7IbJM4mKnyb2eJbR6kl4OsMscwktrdELBAgrUc?=
 =?us-ascii?Q?qiwHkkJJQjN8uffUaVuZJ4rGLGWhDr11KE/bMvWvekCWiqhMQCTZ+4fF7j+E?=
 =?us-ascii?Q?2LjBHLC6lMDpMBo2VLM579N/gblMystiRc1TpTqJyD+mz3AUN8DzCDwpYhTJ?=
 =?us-ascii?Q?Gfz1SdEhLNJeDgkraZqtuFDhd4ibfkEajNpJBhdQ4JRmKchPizk88Tuc6VSu?=
 =?us-ascii?Q?VFm6unODmGtuTSf9NCV3k3vqaxriR0K8EgW+YscNCpYb8qMpjYHeAr7r5S2j?=
 =?us-ascii?Q?/sAh29dnUL3QMeratldclEeGVZ2pQJvXVgjr8MD4THc+2qGxbzCXHokOEL6K?=
 =?us-ascii?Q?SH8MPjZkyrXaXDbwwPOorS3K?=
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR1901MB2067.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f04e54-ca7d-451e-1b1a-08d9370c51de
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 12:33:50.1052 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 52IDrk7cD4iqZfZSl/uH/y9dAYRIIerranygoUo4Lb/27jC1qwgXvrXEWDdplXexX18yCE+763KfeiYTnC8Gfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1901MB2033
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-06-24_11:2021-06-24,
 2021-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 mlxlogscore=572 clxscore=1011 malwarescore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106240068
X-Proofpoint-ORIG-GUID: G6jcpS7I-RUIrvidvB-IS0YY7eowPokG
X-Proofpoint-GUID: G6jcpS7I-RUIrvidvB-IS0YY7eowPokG
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=693 bulkscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106240068
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210624_053356_973105_E4972F3D 
X-CRM114-Status: GOOD (  27.37  )
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

Reviving this thread.

-----Original Message-----
From: Christoph Hellwig <hch@lst.de> 
Sent: Tuesday, May 11, 2021 19:34
To: Anner, Ran
Cc: Christoph Hellwig
Subject: Re: [PATCH] nvmet: allow setting ctrl to ready without iosqes/iocqes set


[EXTERNAL EMAIL] 

Please resend the mail with the mainling list in the loop.

On Mon, May 10, 2021 at 12:27:36PM +0000, Anner, Ran wrote:
> Hi Christoph.
> 
> This is for IO controller.
> We saw a host behavior where only the cc.en bit was set and the host was waiting for csts to indicate ready state.
> >From what I saw in the nvme specification we should only fail connect commands that create IO queues in case IOSQES/IOCQES is not set and csts should not be effected.
> 
> Thanks
> 
> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Tuesday, May 4, 2021 12:13
> To: Anner, Ran
> Cc: hch@lst.de; linux-nvme@lists.infradead.org
> Subject: Re: [PATCH] nvmet: allow setting ctrl to ready without 
> iosqes/iocqes set
> 
> 
> [EXTERNAL EMAIL]
> 
> On Sun, May 02, 2021 at 06:31:06PM +0300, ran.anner@dell.com wrote:
> > From: Ran Anner <Ran.Anner@dell.com>
> > 
> > According to the spec we should fail creation of IO queues if iosqes 
> > or iocqes properties are not set but does not mention preventing 
> > from changing ctrl status to ready.
> > We have seen host implementation which sets the property to 0x1 and 
> > waits endlessly until ctrl status changes to ready.
> 
> So is that for a discovery controller?  The spec says the field shall be read-only for them, although we don't reject writes to the property right now.
---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
