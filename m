Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0431C54EBE
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Jan 2023 16:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K8gDcmw0mNH/VKH6fMtMVqxHArsbB60vfMho8Opih7U=; b=oHQgoHf3I9q7TKP9BD6af24eDU
	opw9wRrwogsDsbkid7oujMArWd34C3yWSoF6m3zJISs40mw1gqe2YE+jIEZ0PWgnrH4k38jjQRtOB
	hNL68vdAfIDw/Nc9p/MUBY0WJVCbuWZlgpzkInI5s380LnVoW+DWnaazEDmcXRjn/xDX8+R6H9DF7
	iW6rC+gSSAdLwPQ/bFYsBnHNvT0D5kuIY+B0k7ET8cnHwRoyXP59GtsH+Pw/BWb9f/Ze7lfPX+3z+
	thUR+UpXiAsshcc64eNPIu34Ml3Wk0ch7LdoD02x7pR71C9ZtSJiZblJbsJHp1LRovyHTo5I0QaZh
	865UFg8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGNOS-003XqN-Qy; Fri, 13 Jan 2023 16:59:04 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGNOP-003Xou-8y
	for linux-nvme@lists.infradead.org; Fri, 13 Jan 2023 16:59:03 +0000
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DGwSpf003153;
	Fri, 13 Jan 2023 11:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=K8gDcmw0mNH/VKH6fMtMVqxHArsbB60vfMho8Opih7U=;
 b=Dao1G4jy5/t8/pXWYuTfm1sZ5Xuzxl8X9qGPJTwtdqsQNxY3JZI3DVMAR8+wMPOyC/da
 WOH4zYe7daxN3bcUrjDNC/R3+Cod3Uu8qpDtrCQ1tyGMC93tOgR5QZi3wLh6ni63KcFt
 8bneb4drd4l0rV2+3ne/+dFEtbqdOY+ls7vh1W6mNLVDqsS+y/cP3KRWTjyzTVCODXCP
 hfcBxEKnVjhT2r41HCKj3gREMIC8TFkAmJPvFrVWKXAYmgNa+QQJnoMhUNunxleq0wXy
 8EXmAaoAYXrQGEWcLHdD7vUAMNItuJGpgieXo5HxdmOqs3fnBY/ND7uaTYKWRB1JkdNh 3g== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3n1k5axnac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jan 2023 11:58:57 -0500
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DGmEdW011161;
	Fri, 13 Jan 2023 11:58:56 -0500
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3n37ducnmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jan 2023 11:58:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/qfVd7PUGjsdlx9v3ncGSp1y0xSL//TsaOjiq/yYZMjIj5hz7FA7CHUCCk0pnNuCJwLDrE96O+YaGimlHl6CXEaO1/UsARAADPlQnC17PvsEHs2UQCxMaD/dGqz9vcOzxc3RKTZq0RuQOSxPS2bvcTa48P/SlS7xo5GxjmYxxjM5CCv8+gBgjbSVi16o4g62D+eeEJHcaTQ8RPchxXuEubDJI6Vk0haOEC6BvzIuO9G4Bwy8UcNhzll5cdABlJ8NMT18ZOesTjm4ad+jX+JQ8E1ZaE0tYsBoudLPzlTnOgln/gAoDEtsmRFsSGBE99RDgD/SAMjdY+rg/HGd1paVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8gDcmw0mNH/VKH6fMtMVqxHArsbB60vfMho8Opih7U=;
 b=llEV1EnPPc1BIyX0RLCew2+tsuFtuQIAethSzNK+IFPt+WppCGwgwaVSvBJYCE8ZTKaA+ci0O1nBqurr6h4XXfH+LWevDeFaYtx8GpXtXxVqSDYdRseC/TCT6bHNU0aF5lMhcS4Aq9XKM+FZNKI/1iSXCWCYQ+4ObDHFm7z2z05T4RY3/pgd/J5dAEgbkl53snTL99KKiQMLG3Nyr1hqwsizV5hIfPDyVl3RvVRPf73VFAarYECuZ9roDVC8EW4HEtCeVKLW7D4XWp5gKcnHzkkfW+Ld0YsGN6LkS3px1WySfFII4/ahusU+pWK73iTqEa/YphkC+VYzpJk3y/Sy/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by MN2PR19MB4128.namprd19.prod.outlook.com (2603:10b6:208:1e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 16:58:50 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::2f42:cd95:5173:5c02]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::2f42:cd95:5173:5c02%5]) with mapi id 15.20.5986.019; Fri, 13 Jan 2023
 16:58:50 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: Martin Wilck <mwilck@suse.com>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: RE: nvme-fabrics: devices are uninterruptable
Thread-Topic: nvme-fabrics: devices are uninterruptable
Thread-Index: Adklxcy5R0PWO5jhRLix9YacrkAbkgBfA/KAAAtRFmA=
Date: Fri, 13 Jan 2023 16:58:50 +0000
Message-ID:  <SJ0PR19MB4544DF0F76EBE53A5D0C73A1F2C29@SJ0PR19MB4544.namprd19.prod.outlook.com>
References:  <BLAPR19MB453154491C6DE9CB7C2A310BF2FC9@BLAPR19MB4531.namprd19.prod.outlook.com>
 <a23d94a592026e0d3fb5561329d30d819dd9a2cc.camel@suse.com>
In-Reply-To: <a23d94a592026e0d3fb5561329d30d819dd9a2cc.camel@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2023-01-13T16:50:30Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=d386cd49-c269-4240-bf12-77ea453743b0;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR19MB4544:EE_|MN2PR19MB4128:EE_
x-ms-office365-filtering-correlation-id: 3f57f472-fd1d-4975-374b-08daf58771a4
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  Vm+sqsGL36LL2/iFf7Qbmc8gkaEjiIt4hAweqqZqs+iWDpZmrL8NGnfKCTMvx7O5WS/hvenP8eZibcrA2WyjzUz11oyq2V1RGbNdlexFgZuUGvLwbLP83iPZOUK0u5dA8Ay8Fe+UCD29/2L3zfrsf3+ihrmQoIaCDfSi/eZ3jYWEYHbxjcP12u7b769yCpnuaXNKVbOu74XtuDORu0s51MqFq5hXrr/yfmqIAJdXbn9U4zZZ/DtzMHHPSO71W4yvTVcnyr1AnaIR7adu7qq6/WRO7JypJfXFcpbQGKAPJIAZmHqaX0Al+onJrsZ2ANQcw8fpom1qjDQl62oJNca/eiJf42i7+/+ntHPMd3KOK73PXZGdruNlGWrGUOMw9qEHRXgRptFSrNlnnj0sOmKcv2b7670cRXbK+rcp4GytqUVOwEYodO4GHWeFirItcgE16NWAVlTtV9j6n1AK5Z7Hi9s7Wr8iqZeF7JVtunYO1g7ZY5P0cvSrOXhbTp3fwm891za8MjsNsfGT7Kgre5Klv9edbSMjhyDSluyuO3gG52g7N7fKfyivodIrjWsvysQWtVICIJrIQZGniKulM1ttIRX5DuhFQYEyAhBpoxUEMEaX6WvS5kGj87cA3OaX17IgxWZmOmZHvCvLYfslsIOeae0XegV0yLUrme5MQ3815SauumysZ1Rm6W6cJaAKw12yiEOVChAuZZzpunET95dDU2a+Yn8JpVkJBMNNKE/45DA=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR19MB4544.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199015)(7696005)(71200400001)(966005)(9686003)(186003)(478600001)(26005)(110136005)(66446008)(66946007)(786003)(66556008)(76116006)(6506007)(8676002)(64756008)(316002)(66476007)(33656002)(55016003)(38100700002)(8936002)(5660300002)(52536014)(41300700001)(86362001)(83380400001)(82960400001)(122000001)(2906002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?iso-8859-1?Q?REhgAe5BHLpKvXLwU+qok8GG3QSs9IvJwLh4c1GL8M4pag4jumLZ9hf5mY?=
 =?iso-8859-1?Q?04GY6+a/+lz4O2sxGYZRobCpL959V9Ak7JzNI6KXEXv/+zmF7D/N/IGCye?=
 =?iso-8859-1?Q?W0OQhpDhJyJ42HJ7XiTm657ngU6eotW+hDEVOZwTfbkMm2T+xu+TZ39iR7?=
 =?iso-8859-1?Q?RAGoA2AbWmel8pHuI5UorcLVnR18zNewQI037UQfG+HWNk99MbL11Sw+BZ?=
 =?iso-8859-1?Q?DU83HyIqvFlTfifNrnPo3KkH18gRzQl3NrRjNN8UC2EmqOF+Y/npY/xbZI?=
 =?iso-8859-1?Q?e6LnXOrQuNm/JeFN1SctfZ5skKT/8kPH5PMOpmQF42TMn05Zz5OPSlMI0M?=
 =?iso-8859-1?Q?QP1gvJxmUzbGfFiffTf7XmHOxW6j+uHbd+FP75uc0VH4B1ZvDDvt1u/zfg?=
 =?iso-8859-1?Q?a8NlQSZaVgEuF54dKwn+xqcYD9YibhTxQrihVObayC/I8isA2uuOO3+4OK?=
 =?iso-8859-1?Q?tSMW3NGtuEr8iqyMyl1gFtXraNhVPLOLDOBme1O4r78Q57RdJaKhhx+NsK?=
 =?iso-8859-1?Q?vhcqhaa+pH2NumFXlY7Eg5C40XHZmOtXGAiQbG7s1/+Sq2sqB5oyL38faN?=
 =?iso-8859-1?Q?PAaPW/CbRuwJELPjcYFynSBI7SzwhcZM3wNGWGhXzHkN3NpTtPdjcFRahY?=
 =?iso-8859-1?Q?m/xLULlZARBAGzBklAu/PnO4PzL0yMxQhh291ddzqFsJZ5ML+HPZ+mKzRt?=
 =?iso-8859-1?Q?nD68748YZouec6JhOma5ZxHXf7n1L4B6p5xBp9qiUKMERIWjY3Ye6Fcben?=
 =?iso-8859-1?Q?dcqXgZrEbbOYWyWsiayce+8X6LiZ1eMtn1lr6QxuPyKGNjtIzGJMrr+bm0?=
 =?iso-8859-1?Q?nH/bZQMhsILeZyd3GmaAC/21zrpQZ0K4sS2R/gTbQNEPL4n5SSW8w+/1jU?=
 =?iso-8859-1?Q?Y9zDqVm0CjFR+Teky1TjWZXWeGMYAkuNJp8ONKsvc3/98Oqmih1zMihAaO?=
 =?iso-8859-1?Q?3BJM0rDqLbCkF2RrGFnX6cvF4clHNomDBCDorstH5Oo2KIzD44m9R8A+xy?=
 =?iso-8859-1?Q?ILBIYCflqMEl/bL3CDBvVdpqgZz1lQCn7fNkKMGnVwk8DVPYc/TWK9DTGM?=
 =?iso-8859-1?Q?40kfMsTsvPQq1NaojpQDQJmG8LeIEHSnFWiGs6KI9OV+z1zcxhyYG4wRyH?=
 =?iso-8859-1?Q?IUInznK5p0bYNOyH6XWss4/2s3W+nVfPpdYBmEgXUYGzjxJztLVmNdg0tn?=
 =?iso-8859-1?Q?RwFCBi3NrPkASd2ipcp9XcWPs1/L/5n6IiVzZyZ1RI2JSF06owoZBKcfOc?=
 =?iso-8859-1?Q?fPIeAiSUOaj+eHW0AU6O1V9dngu5CleVTiEFuF5o4p5Zh+3RW3NxjVR3Qg?=
 =?iso-8859-1?Q?mehJzG5pO/3Oy4Q+QY6qbKdt2LLCklOy/wtkqT3DV1DgCWnWRNNwnON9n3?=
 =?iso-8859-1?Q?54rjyP6ZEx7xYjVtQu8lNL/mBMAL5SY1AfXTrnFznGtD1iETDRakzcUcEN?=
 =?iso-8859-1?Q?JYKXRAVqdHkfTvBr4926lIaP5SvqwL3etUKVIxGhD0skAcihbYcTT3xche?=
 =?iso-8859-1?Q?UP6KYP1g67LMDAWEAAntiSoRUSdLRCtmfvVy4RxiWJ2kqWbJkaEZxr5Aig?=
 =?iso-8859-1?Q?kYAAKKhvYar3kt9VsfTbmlslJX9PoxqlJGzrGM2no3jtM5mMx9RsbWGR4P?=
 =?iso-8859-1?Q?3R0r5s9ktucmctbuFEim/9BtsalBkYrXO7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f57f472-fd1d-4975-374b-08daf58771a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 16:58:50.1698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MTBciHWEFrmPKXANlbJmCdpPaL1i591aLS/IwwYgq18tNm6zc8PnJqQ93D9AiZmFH7vhHYv6Esfiw/HoErGeXNjrzi/zpd8eBp+dyn2nDQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB4128
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_08,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=734
 adultscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301130114
X-Proofpoint-GUID: BSspAPuB1dXzhPQ4GJfKt4miMO_svdk6
X-Proofpoint-ORIG-GUID: BSspAPuB1dXzhPQ4GJfKt4miMO_svdk6
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=831 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301130112
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230113_085901_613523_4D3148FD 
X-CRM114-Status: GOOD (  44.25  )
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

> On Wed, 2023-01-11 at 14:37 +0000, Belanger, Martin wrote:
> > POSIX.1 specifies that certain functions such as read() or write() can
> > act as cancellation points.
> >
> > Ref:
> > https://urldefense.com/v3/__https://pubs.opengroup.org/onlinepubs/0000
> >
> 95399/functions/xsh_chap02_09.html*tag_02_09_05_02__;Iw!!LpKI!mRHjcC
> Da
> > 9GbhJbYIEQbL0gDby2fJRUEoRclC6iPBgKoy-serG9wheVae8Bfg8xF3-
> 6PccKiHA5iKfu
> > Y$ [pubs[.]opengroup[.]org]
> >
> > Cancellation point functions can be forced to terminate before
> > completion.
>=20
> I think you are confusing things here. The page you mention is about pthr=
eads.
> pthread cancellation points are points at which a
> pthread_cancel() call from another will interrupt a thread that is using
> PTHREAD_CANCEL_DEFERRED cancellability, and nothing more. The
> "cancellation point" logic applies *only* to the specific signal that is =
used for
> implementing pthread_cancel(). It has nothing to do with the cancellation=
 of
> I/O requests. The spec says nothing about the semantics of cancelling I/O
> system calls. Usually the thread cancellation will occur either before en=
tering or
> after returning from the system call, rather than interrupting it. The ge=
neral
> semantics of signal delivery apply.
Hi Martin. That's for your response.

Agreed. I should not have used the "cancellation point" terminology. Instea=
d, I could simply have said that many system calls will report the EINTR er=
ror code if a signal occurred while the system call was in progress. I've u=
sed this with dozens of projects in the past and it has always worked flawl=
essly (i.e. writing to sockets).

The documentation says that a blocked write() may return a number of bytes =
less than the specified count if, among other things, the call was interrup=
ted by a signal after it had transferred some, but before it had transferre=
d all the requested bytes.

Similarly, read() can return with a number of bytes smaller than the reques=
ted number if read() was interrupted by a signal.

I understand that /dev/nvme-fabrics is a special kind of file. It's not a r=
egular file and it's not a socket. However, it should be possible to interr=
upt a process that is currently pending to write() to /dev/nvme-fabrics bef=
ore any bytes have been written. Once bytes have actually been written and =
the kernel has started processing the connection request, I recognize that =
interrupting the write() operation at that point is not desirable. However,=
 if we have several processes/threads currently pending to write() to /dev/=
nvme-fabrics because another process is currently being served, and before =
they have a chance to write any bytes, it is perfectly reasonable to allow =
a signal to interrupt the write() and allow these processes to exit, no har=
m done.

Another thing that I've been wondering is why the kernel does not allow mul=
tiple connection requests in parallel? It should be possible for multiple p=
rocesses to write commands to /dev/nvme-fabrics concurrently. I mean, each =
process needs to open() /dev/nvme-fabrics, which gives them their own file =
descriptor. Then they can write() to or read() from that file descriptor in=
dependent of what other processes are doing. This would prevent processes f=
rom being blocked for long periods of time like the 100 connection example =
I mentioned earlier. In other words, 100 connection requests could be made =
in parallel, all of them timing out at the same time after 3 seconds (inste=
ad of 5 minutes).

>=20
> >  Typically, sending a signal to a process/thread will cause
> > cancellation point functions to return immediately with an error (e.g.
> > -1) and with errno set to EINTR. [...]
> >
> > The nvme driver does not seem to allow cancellation points. In other
> > words, processes/threads blocked on read()/write() associated with a
> > nvme device (e.g. /dev/nvme-fabrics,
> > /sys/class/nvme/nvme0/delete_controller) cannot be interrupted by
> > signals. This can be problematic especially for the following cases:
>=20
> What you actually want to refer to is (I think) the section about "Interr=
uption of
> system calls and library functions by signal handlers"
> in signal(7): "If  a  blocked  call to one of the following interfaces is=
 interrupted
> by a signal handler, then [...] the call fails with the error EINTR: ... =
read(2),
> readv(2), write(2), writev(2), and ioctl(2) calls on 'slow' devices." Not=
e that this
> paragraph goes on saying that "a (local) disk is not a slow device accord=
ing to
> this definition; I/O operations on disk devices are not interrupted by si=
gnals."=A0I
> assume the last sentence applies to NVMe disks, too. nvme-fabrics is a
> different topic; one could argue it should have socket-like semantics (an=
d
> socket IO _is_ interrupted with EINTR, same man page section).

Exactly!

>=20
> > 1) When scaling to a large number of connections (N), applications may
> > be blocked on /dev/nvme-fabrics for long periods of time.
> > Creating a connection to a controller is typically very fast (msec).
> > However, if connectivity is down (e.g. networking issues) it takes
> > about 3 seconds for the kernel to return with an error message
> > indicating that the connection has failed. Let's say we want to create
> > N=3D100 connections while connectivity is down. Because
> > /dev/nvme-fabrics only allows one connection request at a time, it
> > will take 3 * N =3D 300 seconds (5 minutes) before all connection
> > requests get processed by the kernel. If multiple processes/threads
> > request connections in parallel, they will all be blocked (except for
> > 1) trying to write to /dev/nvme-fabrics. And there is no way to
> > stop/cancel a process/thread once it is blocked on /dev/nvme-fabrics.
> > Signals, including SIGKILL, have no effect whatsoever.
>=20
> I think that SIGKILL does have an effect; it will at turn the affected pr=
ocess into
> a zombie. See above for nvme-fabrics.

I'll have to check that again. Last time I tried I did not see any effect w=
ith "kill -9".

>=20
>=20
> > 2) Similarly, deleting a controller by writing "1" to the
> > "delete_controller" device while connectivity to that controller is
> > down will block the calling process/thread for 1 minute (built-in
> > timeout waiting for a response). While blocked, there is no way to
> > terminate the process/thread. SIGINT (CTRL-C), SIGTERM, or even
> > SIGKILL have no effect.
> >
> > I wanted to ask the community if there is a reason for the nvme driver
> > to not support POSIX cancellation points? I also wanted to know
> > whether it would be possible to add support for it? Is there a
> > downside to doing so?
>=20
> Repeat, this has nothing to do with cancellation points.
>=20
> Martin


