Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD09C77B7A
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jun 2023 17:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cin1uA7xjq+810tMSBwpnU0y/OLWzIxKx2/BQOsCbFI=; b=H80jRmOB/Yt6y/t8BxGiAm/JPt
	SR1/sB+SIVBo+X/ZIpyYXp6cYzTwrBHH/3dr5hvpaiXjjPH7i1UcHPH/HWVRb/VeY9lBIrPPtH2gY
	33vGa/QnWB7bTp6Udz6Fu7qZhdSfNajYf0xIPKewOkKi5IsTtMhiwupg+c1uFQKlJUJ3DuyDoW61O
	+N6vgeMoyud7mD4/UeUZQEk8sTMo7f5Z7BNVIn1+WEhLWbyULngstTS1S+HDbKMeeMtlD4QzszpQb
	cPFr9xqF0TUcJNI7esQWpY/a7xDJUyaRBpcEwdezSBxaZwOUvOk9JFwxI7107bQP/zGh+P/QetM2e
	o9ftdMkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6wcW-006e9v-2D;
	Wed, 07 Jun 2023 17:06:52 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6wcT-006e8h-0W
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jun 2023 17:06:50 +0000
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357CJISw027925;
	Wed, 7 Jun 2023 13:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=cin1uA7xjq+810tMSBwpnU0y/OLWzIxKx2/BQOsCbFI=;
 b=FiMAZP5KXsIf8yqGlFjeACR0l6GcsZfw1CBEMSz2Frjda+QheEciYtrbXVPM3dXwjR8I
 KQKJs2DNQiZTyCM/6I5vI2qq33dfTYJRk7aWc7RamK0warlKu+rqhZV70rNKdjg2XZFg
 r3KDLG2vwckRLtDW9nB0aFgzyluQBm0pX2bNso+lrfTcdtVZxv1jREygoB5i1zYBZ/Eh
 gk/brSrG4z1Xfm6IDhsNqBt83daLYRd6dbCSxaaUAKaep8eLbY+iPmX7HfICK4ZHYEc5
 Msa6jcLIvyCTG32mQPuDO1rvze0dld6VF6Ed9Ke55/UqqAwVZUrhHeR30RoXTBaGOKKR Sg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3r2anh4yup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jun 2023 13:06:34 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357GQYsB016881;
	Wed, 7 Jun 2023 13:06:33 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3r2qb47f31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jun 2023 13:06:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jslp2P2h/HWTy2Gq+gdSS8rKE/kRoGb9Kx7nA3fKGn5mihu9+24CBu8ycpOdx/WEjW/OQAIPeXwfeP4f1dsf1d78uN+tSHO9fJLB0VUBy2mKUHGF0tBW3JKHuYCXYOWiHzGhKg9DlQNWUrUyZekh78Y3kLf3uVBZjbcxiPmIc/2kY/ZTNB0K/hAfxrP/N2FUJ1bduEYWm0ZW0Ab59Cpd2v03hItvNi5HY638ytQNB3UyclbsBwDeXgy3uVkbmYtIoMlHeBRVre5CzbpNieNnwOjbHAwcKZGvCC39iwCBqHs6/N2GlQewfe333WxZsffXoLIK1IL33OMcSRXUBM+PVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cin1uA7xjq+810tMSBwpnU0y/OLWzIxKx2/BQOsCbFI=;
 b=KLTRnkcixygG89uvVQ1XT/y9uUqz3QExdrP189r5RdquhA241SaMjtdz3DO/qwH+nKSOyNbrWgsbTNt4nVMngxUwd64lJYORvA1LuNxf/gurGBmTO2TcTRI9q5pINPjXFc4Bu9nzLoncZGY6RwABJ418QNuKD4ArqsxjjWcckCW4019KimpdWaY4epuJcGok+/iQnHcqb6l3Dr6xQk2SwF+AboCrA+NpEXXUTYJE6DsjkLVP8idoJMWaopDIwJK6nUcWk9goSPhjnuWU+95UW4xWrgPpIzfSyCpBCenvfdnHlRZ/b3+/u6Dv5C0zQ+XaNTch8nAkJxUGphprRxfJEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by MN0PR19MB5684.namprd19.prod.outlook.com (2603:10b6:208:373::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19; Wed, 7 Jun
 2023 17:06:29 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::32cc:de1d:8f66:2c54]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::32cc:de1d:8f66:2c54%5]) with mapi id 15.20.6500.010; Wed, 7 Jun 2023
 17:06:29 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>
Subject: RE: [PATCH] nvme: print disposition on err req completion
Thread-Topic: [PATCH] nvme: print disposition on err req completion
Thread-Index: AQHZl3n1oi7kbLlQg0ehKLxsPuTsjK9+yyWAgACprACAAB8sAA==
Date: Wed, 7 Jun 2023 17:06:29 +0000
Message-ID: <CO1PR19MB48853E8FB1D246D85EEC0DB4EE53A@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <20230605064933.46933-1-kch@nvidia.com>
 <20230607050059.GA19879@lst.de>
 <a8f3f9eb-7267-219e-f6cc-f36c0ca56080@grimberg.me>
In-Reply-To: <a8f3f9eb-7267-219e-f6cc-f36c0ca56080@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2023-06-07T17:05:12Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=34a4a497-5fa6-4b78-ba97-37a470306be2;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|MN0PR19MB5684:EE_
x-ms-office365-filtering-correlation-id: d3e4ca36-695b-4bf0-6304-08db6779896c
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lhd7FeyzTnfBWLVP4cPkb7CaA4WQ38e2kWiKDFfgl1tOGVUtjmqtL6BcYfTrM7DjbEE+NSdWejxWsRJKWLrzxKBPumgtC94B8iewbvwMrERRoGyy5eFY/PB+q+QeFQo29r6oZ49gL0OdDfvb5dtBJ6jrtGZal3sDXTR4wBqsgkWvGDA/i1uJPuvR4cveDjDvIBNtz1HBDZSOuOQj+L/8PHQ5oA3q1bgmx0+ENZrBPjxhlvbAp2EUCH4TjW3gTHu1+dNFoJZjG51DVy6QwXSunsRVPmMa43E8SSdD9yXpuVISi71MDbVleeWl/xB+JvA65eMPXfGcbs8uqKDNRtpX+vNF8nC/37TKddOnNfamRs+rdKQ0evvL9TiDh3c+qB3akWuq1oRXx9h1Zk/3eKlmgemVhO1BprLRhEJYVStaE2YfpLO6DxcZYaf2sCnLQjrNOWLNmO1vcpo8CJbH3xVnRl0V9aceDn8BajaMym8vdAzsRuHAbQjEW5wZdrM8AhCui2Wa5h1smJ5dWiovY4qeyG1AvBQMc2OsFAYxg2ZqJgeFgInJN7yezE0AOxpCuPODEByPuD9KX5zAJ+wUTh32oKJlo+NsTvVeJof2S0jskIIhq1dfPECA0KknIQs+jRkS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199021)(2906002)(52536014)(8936002)(8676002)(41300700001)(5660300002)(786003)(316002)(64756008)(4326008)(66446008)(66476007)(66946007)(76116006)(66556008)(110136005)(54906003)(478600001)(7696005)(71200400001)(53546011)(186003)(55016003)(33656002)(86362001)(83380400001)(6506007)(9686003)(82960400001)(26005)(122000001)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bG8xbGR1WXQ4Mkp2RkZ3eWdiVzEzS0hnZ2orUTBjdkRxc1RPTmM4RUE1QXVq?=
 =?utf-8?B?UFZ3S2hvRDlMc2l1RkdsVk1uZFp3aEx1anR4VW5KSUR5WXlwRlpjcDR5b2Yx?=
 =?utf-8?B?OXRXQUdKTkJtZ2FlN29MY2xkbkZyd05QS0RNcysyL1E0RS9XV0Ntdi85S2xY?=
 =?utf-8?B?R3V0disyTjRTSGk1THZ5SUZZQ2tMSlNaOWoybjJydFhXUHI0Wml3VjRCOWUv?=
 =?utf-8?B?bTRMNGpUaGI1K0xPWFF4ajRhNXRvdk4zbVVacFprRzVCYk5STnQ2WHBpeDhG?=
 =?utf-8?B?L0xHcFNJK0JLSW5WWDVBRTdTaC9lamxmYk1PNWU3d3J2TFVoY0ZDL3g1QjhZ?=
 =?utf-8?B?b0Y2MkQ0bzEwaHd5akZLdnc5RlZuSWtKd0FURjRqeEM1REV0b0g1ZzYrNnNS?=
 =?utf-8?B?T3RmbUZsbTRPcmU5Q0Ftb2pyN3NjaUsyemt0eko3bnVrdktiVXdBL3UzRjhz?=
 =?utf-8?B?R0VsbzNWcklrQkZnbDk1OEdaRkVzWGZYU0h4d1hybVllZ3RxUkRPQVZrTTdI?=
 =?utf-8?B?azBtdjZ6cjBwK0ZTdncyeENJdVBVdkEwQUZ3NWlMNWZPM1VKOTA3WStwV280?=
 =?utf-8?B?d3VXT1lHQWRnckpuMUl0K1BOa0kvd25VYlQ0anJkQkRjaDV2eWRiRGhnRGcz?=
 =?utf-8?B?NUpMdWtUQk0wSDl3ZGZrM0wybjlTWG9LU2RoTnZCZmppWWFNR1JkR0NqTzds?=
 =?utf-8?B?TEQwZmlzWnFFM3NkbjlmeHl4QXh5WjVlWEVZVVlqZUE2RHZGdmJZZGdMdTFn?=
 =?utf-8?B?QVhwYTl4ajk4a1BmVWRQcDF2QllKWlpsMXBqeHMxK294M3JhSnU1cEVJUWNY?=
 =?utf-8?B?ejZGN3MxbFRPc3JoUnBYZE1kL3dqdDlmZ09WVG14Nms1REw5MGhDQ29rZ2xk?=
 =?utf-8?B?T1pNSFdqNnI0QkJYYkdac1dwUmZYVUlpT3pQQkZYYVBwRWd4ay9rcC9UbnJv?=
 =?utf-8?B?b0o2QkxtMlBJNGF6OEt5ck9JbVB2TDNTY3Zya3RJSGNhK0l2cFhvMmFHTGtk?=
 =?utf-8?B?aHVwOHh0K05GSXVzMVdGUDdLUm5wcVl2bjVLQWRDYkhWYXVSRWQ3RzIxMW9v?=
 =?utf-8?B?Uk1saDNEWDcrajVBN1dMSDdwR1o0dllYMFhETXNNanp6Y25wdGxtdXZ0d3Rx?=
 =?utf-8?B?MWo5NS9WZFU3djQzZmVMYTdYcitHVng2TGNlT0ROUktZQUgyZ3VwVTkxd2pG?=
 =?utf-8?B?SGYvb1hTYU4vbnVWRUZqQitWY09CYklGbkVvTUtPbzhEWU54WDhNZHVyQXVo?=
 =?utf-8?B?NTRGb2NCdmZCekR4c3hRdzRPbGZTYjRqZmpHZHhrVlhoUXZHUTFSaGdqcThw?=
 =?utf-8?B?R3RBNU9udU53SWh1M0Mya3NJRHJYS1pFQ3RVZmNsRU95ZGpTQWUzTENMeENK?=
 =?utf-8?B?WGF3Q2hIVC9lUkhWRVFjNk11YitJNmUrSXUxZWU3ODRFSG5BZVcyOWkyc2Iz?=
 =?utf-8?B?ejBYL2lEOFFLdGQrOGtCeDkyMGdYSHBVNnBSL01OOVowYjJNdUNZTi9abFR6?=
 =?utf-8?B?MUEvdEJvclUvY0crOU5LRGpEOFQ4cXBGdUlMdWNxOVlIUENhRFFrS3p1amVM?=
 =?utf-8?B?S3BJejFpSy9wSkFvWXVDbUsrbGFKNEJ6Vm9QeDViTDFGU0NGSkFRSndSSG5x?=
 =?utf-8?B?QUorcnBOcU55MXYzd0JKNUZHSkNNRGxEWk9IbTBsdDFwQzFxeWFoS2hpM2lU?=
 =?utf-8?B?alVvME9QNkRGT1p5NWhtc1h0Snk0aVN0NWs4WlhFQzdmS05BcVFNMWlPc2Nr?=
 =?utf-8?B?MHRmL092bDBaUnpab2Z6ekR2Z3QwK01vM0VnY3NBMHJLMHplakhqc0ZpWjhE?=
 =?utf-8?B?TVVudlM4K2RDMHM2MkFMZzV2RlRPZmpmUUsrWHI3ZDNzcGZBcDhkRFpZM2k0?=
 =?utf-8?B?SkRIQUNJbDRWUnp3dWE2dG1CTTNUUm91eWJBdkpkMEZFRWkyTUVTYUQ1VnZB?=
 =?utf-8?B?bFpjNmlrVUhFcUJqZGFLN0k0bCttbkNSeEhCMHhZYmp2aE9jQWEwZ2NXanZW?=
 =?utf-8?B?UjdEcDBjS3JweHVzeGU0dm1pUVFuT0ttb2VJWUdrSTZWd0VacmpxNVEvSDZt?=
 =?utf-8?B?U25DNGZBOVJ4V2JZbjB6a0dVN0RSaDh6cCthbE1WMWc4aEtxdGpwNVhnZisy?=
 =?utf-8?Q?nBG09qh6bnbAmJWCouF+OKWLw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e4ca36-695b-4bf0-6304-08db6779896c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 17:06:29.7073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /RVOcEq1JiT71AmYLiMj8AHE0BM7qjjeAAzruUwzvCKGnkWQ9ku2GNqe9vdRHZdpMjb8P/SkNCyHnBiCVOcGzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB5684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_09,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011
 mlxlogscore=999 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070146
X-Proofpoint-ORIG-GUID: haXHQB-o6xe-bB5ccdqs4d2c2i3KdM0F
X-Proofpoint-GUID: haXHQB-o6xe-bB5ccdqs4d2c2i3KdM0F
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070146
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230607_100649_409695_232E205D 
X-CRM114-Status: GOOD (  19.78  )
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

VGhhdOKAmXMgY29ycmVjdCwgbXkgb3JpZ2luYWwgcHJvcG9zYWwgd2FzIHRvIGhhdmUgYSBkZWRp
Y2F0ZWQgdHJhY2Vwb2ludCBmb3INCm52bWVfZW5kX3JlcS9udm1lX3JldHJ5X3JlcS9udm1lX2Zh
aWxvdmVyX3JlcS4NCg0KQnV0LCBjayBwcm9wb3NlZCBhIGJpdCBkaWZmZXJlbnQgYXBwcm9hY2gg
YW5kDQpXZSBhZ3JlZWQgdG8gZ28gd2l0aCBvcHRpb25hbGx5IHByaW50aW5nIGRpc3Bvc2l0aW9u
IHZhbHVlIG9ubHkNCndoZW4gZGlzcG9zaXRpb24gIT0gQ09NUExFVEUgaW4gdGhlIHRyYWNlX252
bWVfY29tcGxldGVfcnEoKQ0KDQpUaGFua3MsDQpBbWl0DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4gDQpTZW50OiBXZWRu
ZXNkYXksIDcgSnVuZSAyMDIzIDE4OjA4DQpUbzogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3Qu
ZGU+OyBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KQ2M6IGxpbnV4LW52bWVA
bGlzdHMuaW5mcmFkZWFkLm9yZzsgRW5nZWwsIEFtaXQgPEFtaXQuRW5nZWxARGVsbC5jb20+OyBr
YnVzY2hAa2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gbnZtZTogcHJpbnQgZGlzcG9z
aXRpb24gb24gZXJyIHJlcSBjb21wbGV0aW9uDQoNCg0KW0VYVEVSTkFMIEVNQUlMXSANCg0KDQo+
PiBDdXJyZW50bHkgd2UgZG9uJ3QgcHJpbnQgZGlzcG9zaXRpb24gaW4gdGhlIHJlcXVlc3QgY29t
cGxldGlvbiBwYXRoIA0KPj4gaW4gbnZtZV9jb21wbGV0ZV9ycSgpIHRyYWNlcG9pbnQsIHNvIHdo
ZW4gcmVxdWVzdCBmYWlscyBpdCBpcyBub3QgDQo+PiBzdHJhaWdodCBmb3J3YXJkIHRvIHVuZGVy
c3RhbmQgdGhlIGRpcG9zaXRpb24gbWFraW5nIGl0IGhhcmQgdG8gZGVidWcgDQo+PiB0aGUgcHJv
YmxlbXMgaW4gdGhlIGZpZWxkLg0KPj4NCj4+IFVwZGF0ZSBudm1lX2NvbXBsZXRlX3JxKCkgdHJh
Y2Vwb2ludCB0byBwcmludCB0aGUgZGlzcG9zaXRpb24gd2hlbiANCj4+IHJlcXVlc3QgZmFpbHMs
IHNpbmNlIGRpc3Bvc2l0aW9uIHZhbHVlIHdpbGwgYWx3YXlzIGJlIDAgd2hlbiByZXF1ZXN0IA0K
Pj4gc3RhdHVzID0gMC4NCj4gDQo+IEhtbSwgbm90IHN1cmUgdGhpcyBpcyB0aGUgcmlnaHQgd2F5
IHRvIGFwcHJvYWNoIGl0LiAgSSdkIHJhdGhlciByZWRvIA0KPiBob3cgdGhlIHRyYWNlIHBvaW50
cyB3b3JrIGJ5IGhhdmluZyBhIGNsYXNzIGFuZCB0aGUgb25kaXZpZHVhbCANCj4gdHJhY2Vwb2lu
dHMgaW4gbnZtZV9lbmRfcmVxL252bWVfcmV0cnlfcmVxL252bWVfZmFpbG92ZXJfcmVxLg0KDQo6
KQ0KDQpUaGlzIHdhcyB0aGUgb3JpZ2luYWwgcHJvcG9zYWwgKHBvc3RlZCBhcyBhIHF1ZXN0aW9u
IHRvIHRoZSBsaXN0KSwgYW5kIEkgcHJvcG9zZWQgdGhpcyBhcHByb2FjaC4gWW91IGRvbid0IGxp
a2UgaXQ/DQoNCkkga2luZGEgbGlrZSB0aGUgZXhwbGljaXQgZGlzcG9zaXRpb24gb3V0cHV0Lg0K

