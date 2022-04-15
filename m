Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B61C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Apr 2022 11:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xFA77pirtVl0z/xDTUMBWcltGgkplqtyoqJxEihT6j0=; b=w21JiP9mWQbvDt
	j5oXHdFiD7uoOuIUUGNUAx9lYjeMEnAlPnVZV5vJZfgSZkM3uMunU1XanELgkWM3nP088mwyiphhi
	FYhwSDFmJjcXbRripIGcYcUgglSJSBUH5/8q+3Oay22kzxXjPyr0ynKTDBYpalp4hp97tEEaPcMLS
	M/v8jntnZfznGOXadp5uXWU4FkgoJzkvX0Qk4sTiJwFy4DwIlX8UDX5CN42dfRAH655F1OkE0UrOU
	LF3A9/Asx3Cz241DBiNDwRf8WCxmtuQ7hYBR/EmG4XTrtRfa6+AvaS5egqH2Rf2D2Ls5YLjtd8Nmj
	Qlzu9iXNmJHdJH3czUyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nfJqe-009lKK-MG; Fri, 15 Apr 2022 11:10:44 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nfJqb-009lIZ-4c
 for linux-nvme@lists.infradead.org; Fri, 15 Apr 2022 11:10:42 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23F7LQND017803
 for <linux-nvme@lists.infradead.org>; Fri, 15 Apr 2022 07:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=smtpout1; bh=xFA77pirtVl0z/xDTUMBWcltGgkplqtyoqJxEihT6j0=;
 b=YNbyler1hLZ9xgW7kIyAWSXj5MpSDD5PhtGYqypOw/hv0yP5MtZ6HcGEIF509fck8xbH
 KT2LsWUX5UOu7NVleA6H0eWF9TBJPL2zRzJ+Hi6xI5DtzIt93++oFEe+4uzSuHOr+z10
 eQa/8KkQKGGPFCdtW+8FiYkDsb0MXu7hOfhFAPVfjVFFFC9aF3s46nfkMVN35QmHpGpG
 3ELSjFDf9glVB4D3ysGbAKWvGif/M0K1Fu/Dl3lnWVW9mh6EyrEZRmJL/TYgHlKUc9Fe
 ozOxnZfrlx/122nCZDuvWx1Xq7fLLqhQT/ZZ+JYpwVMHOYeTLUjUfCB61LcxNg61Gasm VA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3ff48brmma-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Fri, 15 Apr 2022 07:10:36 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23FB839J018697
 for <linux-nvme@lists.infradead.org>; Fri, 15 Apr 2022 07:10:35 -0400
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3ff6ee0wu4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Fri, 15 Apr 2022 07:10:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=do55MCZs59D473wBZ+IWfdb0XvxmXe15H7XTyPXbN7iRp8o1ncEi2uIYtglTQB7oZiBXh2I6CvKwc304TpMqR7Q+MAjS/Jte2GjGqJb0CFUExMefCFld+EvN5SH8NDZQA0l0JyCSlDM5U2rV1VPKYg5JLBHSamr1cYeZhwRIq9hw0Q96LodaC3ooMGoj2Ef7V+F66iAP5+VA5OcTcYqZqSh0ibj2kDpYZgVJQUqdysMcpdww6/MBkG7dzuoPe9U6y4MsmeI1c5DxjDvUlohtfHInBbjTm6E85YDiPgw4sqD70Zu8ZjaykphFa6KAFIgWy2YXDOog56cIQwfXz/IsgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFA77pirtVl0z/xDTUMBWcltGgkplqtyoqJxEihT6j0=;
 b=eLs3zuxa84RdvNhW0wPUvNxUkUI+GjCjMibqlBChlufqSiEfTjxSYaBZCZ2j/Puxw2Xs6WM1bHi61Rtme3z6vuw2r3TGg4qvh61/V9R3fFOH1Jy7vedtvszjEySvZXMSMJPbw5F5KLOny1HY64+7CHc4GZpawJal9CXXICpbWbPWAXE0TFXAtNQTn+McKC2bmHqM7moKoQhbiwvqAaf7cruvFxjErLc5TYGZx0niSU6p2YVFZelGmz9HM7HkK3PA36pxQaDotLO3pnhvM9la9UR+z/3bZbpYepEwt8bz+wB8H+rb+2zmd6bIEUeavkcc4j4MI1+g2aFDIkdN+5wKMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by MN2PR19MB3984.namprd19.prod.outlook.com (2603:10b6:208:1e8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 11:10:29 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::b9bf:8641:ef3d:3253]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::b9bf:8641:ef3d:3253%6]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 11:10:28 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [ANNOUNCE] nvme-stas v1.0
Thread-Topic: [ANNOUNCE] nvme-stas v1.0
Thread-Index: AQHYTpgB+8+TWyW8K0yAOZj+szVRSA==
Date: Fri, 15 Apr 2022 11:10:28 +0000
Message-ID: <SJ0PR19MB45449B42DC1CE1213CC19CDEF2ED9@SJ0PR19MB4544.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=True;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2022-04-15T11:10:28.179Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=No Visual
 Label; MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Standard; 
suggested_attachment_session_id: 678bab61-6505-cbfb-9095-884d8b6874a9
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7600ea33-dd08-4e57-30f1-08da1ed08cac
x-ms-traffictypediagnostic: MN2PR19MB3984:EE_
x-microsoft-antispam-prvs: <MN2PR19MB3984F5E4DB783350F31C0A2CF2EE9@MN2PR19MB3984.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hnQZ7KpgJiUiq78y0quGcmbRv3PQsMWzm9yAuJNqQehDgFobWo4rnTaP7hM7PszzHD8wmzS5adyxdQiVwLw2Jc/+zY+7cNmSxmM6+McHaVvxCCe2FKrDlT/zz5rQ3UUGFmv8zcDfnlCtIAiP57pMLClSyDyplYIvjtA4gaqP8x1KxaaDoHmEW/Hg6mpVO7Pd94yKRYdX6kUBWDmXHOXxnRUEMJEW44zbM0WIZInKsCI4K2WO1lYvZPLPStA9/XJqFckrZRiprUE+7dTwdLkxnm2RWOVaAgI1Je1NAU+FEfDn3FcLeyLr73zLg4KJoEx7BvvnVxit4qY60pxxq917aBGqUNWYOlOYYmd191y2DC9c4Dud+VwFwEguL8rg8mzKpz+RhrvwtIMdEq1lzCPTkGCXukd/aMVAi4wXfnlFImaHBXFF0qPiB6DuhrpzJ4E0ei5qCjFeSZkdgEboYwrbR1r4m229mMtB4MPdCR0hpd8V+s+SAKVRAZyFbummi6au6trR5SlXiFdhReeAjk9ndu6ihdXfflD/UIVGzz+yaS2l8f/IMK1HOj8gyQvA+LEkNbJSEwzqtm2BVE2SFCjTE3FqPWIrnL2M+2IHPloB1su7kkt/jVheyEVlzwUUCLFRsIy2sYItNEklemYWkL+hrgqzPCkCeo2c8YjWp2Bo8TlD7AsfHee7gkk2nxwAx4IcoBIQS2blOTU+DgZ5UDha6QymVReGl3tF6udgZa4Y6Uj49MyNoL6SnV995x1pcdN4Io0VwS+VZjc0V5Dmzmdi07J8zBVT62pBienw9dBPF8A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(9686003)(7696005)(38070700005)(66946007)(6916009)(6506007)(33656002)(122000001)(71200400001)(316002)(83380400001)(76116006)(786003)(508600001)(91956017)(2906002)(966005)(52536014)(5660300002)(38100700002)(186003)(26005)(8936002)(55016003)(82960400001)(64756008)(8676002)(66556008)(86362001)(66446008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wl2Juka0TPhZY1du2GWjcsywnJd6s3P00wtg53ZM/epbd/1S3o6titMg35?=
 =?iso-8859-1?Q?ZENmWSGtQ1GwzQ/6RnIfftoA1bIk1egmWhYW6rtkLlgJb/+SiSuaCKshTM?=
 =?iso-8859-1?Q?uDLELoGslFmMiFu29df+lE7SXuAQuUI9vlNmIq1ULlhzS2D3CQhx+3d+9v?=
 =?iso-8859-1?Q?qxmYXTpYFk5KjZj5/bCmf41ju8sDE418p3YYBv2/KppDjneDfnWc34LTJw?=
 =?iso-8859-1?Q?FGjRf8twK4yXtkOz2mI3NNtsy61TakNJWqHtpyzoXqcHdWTTxpyCuzSgp5?=
 =?iso-8859-1?Q?QkmoCfU5KBPdt7Y3y2RwE4a4r0JTt6CTWl76nDt+LdzX2Rc1/nThitR6uY?=
 =?iso-8859-1?Q?NuKhEFv6kQqfQOnn0xkxb7757RUywxPVL5PBL7ihBSldp2yydO+oULdenS?=
 =?iso-8859-1?Q?oYXimdko7UIv6pnvEDj/ii3YYJLt/mOddAevD/kSnemtiH4N+tkV3w4/Vc?=
 =?iso-8859-1?Q?+gCxjExEagjGKQtrH2he21kyc4lBeTfSPq/gmSypcEJY0d3afpFqHf2RxW?=
 =?iso-8859-1?Q?HKi0/b5td6nKNmuA1ljonRweJ7ytedngO95W4DkQPRkkflyU3fYNRpz9Hz?=
 =?iso-8859-1?Q?87/Eme0E4X9/xzGPHY98qInewSQaK4vrt9qgGv7LnN5QA6H2L/IvEtY1mF?=
 =?iso-8859-1?Q?ZNUwpVvjmCL9N189FQB8qdJYF8Y6QT0pF7HWGRrjUVoewY1u0S1vfNq2j/?=
 =?iso-8859-1?Q?a6k7IpwaPAtgkMalxMkfScgtsFSiLTNOxBae+FkMGi7IiSTEo2eAizBPMV?=
 =?iso-8859-1?Q?Xahw4dVnTt75Ns9MORrARAlC5iNSSGGjlub40MsjO9r+EsQfjzq/LJ+tAm?=
 =?iso-8859-1?Q?/sH4vpoLxLDoSSFEphWM9pHBDuIbb8/z8MNqeaOO5JJ34ykoEqAriM5KIC?=
 =?iso-8859-1?Q?1AWZ6r7CrjJIQQb3ECsnFmxeurR0Bg5i9MKB6x9SkHR75kWTzst1U2eI1A?=
 =?iso-8859-1?Q?txy55otf9fYZNoV8fIPfJGjrDnxz/C11SsdBpZ336wVRWFONuCRyDRgaaZ?=
 =?iso-8859-1?Q?x/Dgl0HdtOCHVB5cPjqYxncodjo4KaXzKgE0GAhMMbrC2xFeuIUmBO3Yb9?=
 =?iso-8859-1?Q?PIAKRnp5H5OjmHFZ17LmsxldzVz6J1qqRFYUfP1SNcUMISbRuz/H5G51JU?=
 =?iso-8859-1?Q?lDs/rMH93F7MbtY3ImiuIFf/OeW3IxRRCxY7omDIzS3iFsClRUoVQfaUNX?=
 =?iso-8859-1?Q?BOFCOBAcBwHh/eDdytxDiEJudwbA/TfG7KX6L6KQMK9un5bWzToailgWb2?=
 =?iso-8859-1?Q?YOBfdNZq9djkBADShVSRjixW+7dH9trlBF61Fr7L9p2c40lGm910qX28bt?=
 =?iso-8859-1?Q?IF3tmoAXA/eCBKKNAUiVgQQgdG7Q/EJDtdtjTyAcVxLvgmWGuLCCvSWaXa?=
 =?iso-8859-1?Q?7a51wvlzp8viBi3cmVCt/iLWCc6VqdTK7pOr04QIKNW0b6jtrMQ4Ti3pc8?=
 =?iso-8859-1?Q?nmL5MzztBYJyFwxCubOpGGQFLfyAjQhtBMXB3kMikIL52IeBAAVQNw77Qa?=
 =?iso-8859-1?Q?uiunD6n8/WG868DZUAxY19Z++uT7v/ttw48a0rbSp8VQD3VlWdKh/L++Kn?=
 =?iso-8859-1?Q?HVaS1rLkvobS2INyWyqJAfN9jVmjLAx4OukjNn9ZEZTuWL0VziEugoZhzB?=
 =?iso-8859-1?Q?emYPg6U+GQsFUASVfFD9Kt4qD+wpo8duch4/BgOSiXXs+1n2jVyc5PmPPb?=
 =?iso-8859-1?Q?noQWKnKRX+sTy0Rk5ubFHT9MOCYjlxOwcXVxy/lvx1+G3Edycs0LbHgmc6?=
 =?iso-8859-1?Q?D8yMNsWChhtjhnVXeqi15+RcctG70HHf/pvvVYDcKFUGBlW3WKkTfYRK6l?=
 =?iso-8859-1?Q?oCR/LXWXzw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7600ea33-dd08-4e57-30f1-08da1ed08cac
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 11:10:28.7222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NWU9fPTyDL0XJnDteO+f5bV2mJJ3ryp1+FH6g2vFrHQkjd+qIRDRn9+jY3JezSSn9MKMtqKzncInICFtQ0GfHyqSRPTmjxDrUMnSAgzuXDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3984
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-15_04,2022-04-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=3
 malwarescore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=3 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=3 impostorscore=0 bulkscore=0 mlxlogscore=154
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204150066
X-Proofpoint-ORIG-GUID: x2N9Gl9KGpQwsh_Ub35ppVHlk12-kWOm
X-Proofpoint-GUID: x2N9Gl9KGpQwsh_Ub35ppVHlk12-kWOm
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxlogscore=279 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204150066
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220415_041041_316387_B9194E47 
X-CRM114-Status: GOOD (  13.38  )
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

I'm pleased to announce the release of nvme-stas 1.0. =0A=
=0A=
https://github.com/linux-nvme/nvme-stas=0A=
=0A=
nvme-stas (NVMe STorage Appliance Services) is composed of two services: st=
afd and stacd. Both services are written in Python and use the newly releas=
ed libnvme library. The goal is to automate configuration of NVMe-oF TCP on=
 Linux hosts while still allowing manual configuration. See the README.md f=
or details.=0A=
=0A=
stafd (STorage Appliance Finder) automatically locates Discovery Controller=
s (DC) using mDNS as described in NVM Express Technical Proposal TP8009.  I=
t also, retrieves and caches Discovery Log Page Entries (DLPEs), performs e=
xplicit registration with DCs using the Discovery Information Management (D=
IM) command as described in NVM Express Technical Proposal TP8010, monitors=
 for Asynchronous Event Notifications (AEN) to determine when DLP entries h=
ave changed and need to be retrieved again, and monitors / reports errors. =
If stafd fails to connect to a DC (maybe due to the network being down), st=
afd will keep trying at regular intervals until a connection can be establi=
shed.=0A=
=0A=
stacd (STorage Appliance Connector) uses the DLPEs that stafd caches to set=
 up the I/O controller connections. Like stafd, stacd monitors for errors a=
nd will try to connect to I/O controllers periodically until a connection c=
an be established.=0A=
=0A=
A special thanks to all the contributors, whether it was for code reviews, =
documentation, testing, brainstorming sessions, or clarifying the NVMe spec=
ifications. =0A=
=0A=
Martin=

