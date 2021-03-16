Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EA7C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 15:52:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E98F650F4
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 15:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E98F650F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WePyNgw8A0ppfmBuuwuriT3uxIqxh+cE4xNdJutEEtc=; b=Wka9q/TN1EhEk1UiIya2LyDZY
	SubTKoK6cLV214PTnDk3MZXcLZ5jO6oLokWCEm2sDDQuOBAyl/LLnHCzsRHUWGcU7OpwwyoHBT+gS
	yXHKmgUac1JGfPagkDba7L21MVglKzJwc7o2WYDmWRusNYi7Gswy6OQX5uxID4R371SARvDWnEPu8
	pd5IEf0tAIfOWsqukbEbFYPXjkMXdWwDASc3Ninnz2qQvywX6jdC8XB40QaKvxmiEpFZEbJshWen+
	1xDPYNL6GjMx4OQohjht/MhMuFuqIzGF9lWjZF3G6y2WMmy6c0cDPnCYpyROuiCTVWXj0c99XR13+
	CZGKRbnFw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMBzj-0019Dj-5N; Tue, 16 Mar 2021 15:52:31 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMBzc-0019BT-BZ
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 15:52:28 +0000
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12GFg5DP000308; Tue, 16 Mar 2021 11:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=8irhvFwgHrut2bkbfG5xnBqCJb0E2FI9rCofPtToH5Y=;
 b=GWl2AbKw/AYqHQajxrpwt/o/o1XqVTO4nl+35tl+ajCoOoZ20SDsG1EJA/4vy0u6xAp7
 YV1Ev6B5bTOkXafBaBKGFG3JHor0KaXbdL/ZN2UojAl4aqgbKcnXibGgCMqGulfrFd3V
 cy1ElqGzAObAHon8dM/Z+Hd4FZHkAxQccbwkEee+jJWPNTtGZ1WSuhNxptFRuzPXTLZ5
 rUJHjl1ONF1IRFi2qeZvPkOKYKSAbFydFmom1wjgAfgtpjKFTiNWRcMRDXD3Aox8tyFO
 NqqgCnYPiT/WDfGygSgrM9M3xKU2v7IrvQTn5te5uV+WgA9vGuZstDZH7kkARz9yhpK/ xg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 378ru99ap0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Mar 2021 11:52:20 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12GFdlew002315; Tue, 16 Mar 2021 11:52:20 -0400
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
 by mx0b-00154901.pphosted.com with ESMTP id 379b8nk8fa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Mar 2021 11:52:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhynHfK6B35/3iyCZzbCNtWtT7wHu4PKejco7FQ9sFhOdudeBAH9C1kSB6pU3gQL2ngrQggiZubAMVNvRMkZg4+1QWY1Nzkq0/RPs+dW5Q6CRlG1eamb/RhQheYCqwR5e0kII5Q5jXpSevW6BZDVNBfMijQ8Pzjj8HIOp4ofDO+brFiW576wTNsIdU8Xl27QcUmmb/C6t29GytydGDl2sRMg6rJORiciMUH6F6qJkpgfREJ4LMzBblP0kxzoIDXBPwH9hRSjGn4621HQVHbcKEQ+UXkOJIGsTGL4xMCQdLxoJV2cqFfPrGAiKM3d+A+NutvGtx7rMTE6lDKYLepS2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8irhvFwgHrut2bkbfG5xnBqCJb0E2FI9rCofPtToH5Y=;
 b=S/1bp+eA6nWBJBWpSwzEylqUCUK959a/toUNZZrtMf/IdjJSTDXOcMjWj/Hytpm3vgw6REsVw3v8gfRKyO9iB6WWGHSd5w292aLKBliqblN/1uF6qzUnMRqVsJtaOwm5EZjDLJF3KuzUiyDJvJOoYsYy4PWb/cIHSHj0GyZyi0cD6Eok/eLCLjHYrnyNt1I8ezI8CoWbhgSbRe1FgY/9va+S+ucj8oTHQQeYk/HsNzqEMpUlMhSAKKkZE/ZsWFyy9LGoRKkxA7hBAwsPe5B5V2IpQkJ9EtWNmegHe1XhIqXf/+683D/fFU/Z9UV6TGXnjvq4uMw4hZgP1odor31/Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM5PR19MB4695.namprd19.prod.outlook.com (2603:10b6:4:a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 15:52:18 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9%8]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 15:52:17 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Hou Pu <houpu.main@gmail.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: RE: [PATCH] nvme-tcp: fix a segmentation fault during io parsing error
Thread-Topic: [PATCH] nvme-tcp: fix a segmentation fault during io parsing
 error
Thread-Index: AQHW6aKA9bVKdUdQXk+axFkWm5Fl+KomKNIAgADakqCAAJ7gAIAABJXggAHRIICAAh/SYIBbJGOAgABnaXA=
Date: Tue, 16 Mar 2021 15:52:17 +0000
Message-ID: <DM6PR19MB40116B3A8A9751C4BA926521EF6B9@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <DM6PR19MB4011D61F1BF2A4F66228E9EEEFA50@DM6PR19MB4011.namprd19.prod.outlook.com>
 <20210316093539.16125-1-houpu.main@gmail.com>
In-Reply-To: <20210316093539.16125-1-houpu.main@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-03-16T15:52:15.3157337Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=b774ea5f-0fac-4391-a065-7cc7f20a5de8;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=dell.com;
x-originating-ip: [87.70.20.76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82e1665e-9318-4896-799c-08d8e8937a22
x-ms-traffictypediagnostic: DM5PR19MB4695:
x-microsoft-antispam-prvs: <DM5PR19MB4695CDF2E89083A142AAC2EDEF6B9@DM5PR19MB4695.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t0xjGD5ILzRrnEMDgbiqG/bHB1c5eBceZupDF+vNKHmpQbvyPuNhATuaSFv+Q8X6VRmp1JHKggf3XWXn4WUFZ8a4BTHSBl0sr/HzzxZwX1SE082JpzP1CepV77qxHu0c70atnSr4iD9vkiolKf77xXQbKbFRzcerOGV+aTk/w0QL+h23Qflyq6aXz2BdUhS3sr7Z8Zs8NTptmnLJSlKlBEwpmWiQKvjd41n2i5KPQwlg3tB6OoG3DB2j3CJALPwJBFjGQnBn+ZFBYUO37oQ4emjCmFZItCSK+MtJNUXxTO0v1QkoNrqLYDi3jgFfzNYhat2zkmgeVujYIGmFlecpYkkYFPVVrA5mCfBwMRWqQVuXiu8ulC0/9484ZpnNaSow27W6PHhwO19fCVP5X4OW0tBD6Clag4O5k8a2GVhkqB0rxDeBfHESnBeY1wHH9CLrLcGG8j1nPPXjoU44Iqz7qEBk8/sgZenp4S02sawXMl478+9sgO2IvXWdR1raBRBapN540xnGY9c3CKSboE9aj/CTusVT6O4DHX+YPs/0rZQiCfQ01p2lBnvyh/EVmXPE0fRe0VpyVWqBiwe9WpsSFqqrDBR9ZDM/8LIyrSJCv9Lo11JmAoBs1jboUFi8xAcsMesu2dolQUAT8RlFIgGLSQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(8936002)(33656002)(66476007)(71200400001)(2906002)(7696005)(478600001)(9686003)(186003)(4326008)(966005)(86362001)(55016002)(54906003)(66446008)(8676002)(6506007)(26005)(5660300002)(52536014)(53546011)(6916009)(83380400001)(786003)(64756008)(76116006)(66946007)(66556008)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?WHllbkUvenBXR2RDYnJrTTZDWlEwbXZyU2k4UUZ1ZXVOcjNGLzYza2FycHlL?=
 =?utf-8?B?ejVXdjFJd0lzSWtOcnVSc2wxdk1OYzBROW15WUFuNk4xLzU0SUdMTFlOaUxn?=
 =?utf-8?B?OEtoNDB1c0lOb0lUOCs1WTVCbkRYcEpBS0pmczVxTjBIQ0wzbXJ2NWVid2g5?=
 =?utf-8?B?QjBPWVY2bHFGRnNocFJQcmorWW51elM5RzduVS9YOTlyL0hYYWFJbkw3VUJ4?=
 =?utf-8?B?UTMzSDBMQ09sZ3gzL1RIZy9mVElFY0ZHVDFlaGZiSkVCcUNETXhaS0pEOHU5?=
 =?utf-8?B?dWRQRFVGdWFlNE9WME01N0RjNnB3MHdjNjkydWtaMUVWWXZqOE5yWUc3bjJt?=
 =?utf-8?B?Mm85WFRxWjBLYlNnU1FQRGRwelR3cG9vbWpuNU83QXVVcU9vd3J3RUs5a1h4?=
 =?utf-8?B?SkJ2RGlHYnZybGRoeHVMR011QUpZdWNjdVc0ZHpLUEs2RWFTZFF2ZXU1TG9t?=
 =?utf-8?B?ci9yMVVudlpmVmF4MTNwS0R0ZUZOL0ZpM3N6a1I3cVI3QUQ0SzNzVTUvb2F6?=
 =?utf-8?B?M0xQZlFQdmM5Q3hndHN4ZjJIelNtZFBSS29BdWU3TEJaNUhYcXcwb1MyN1NY?=
 =?utf-8?B?T0hpWVRWYnBjU3lick01cXBaMnVlb0lWb1JUVnZkMmZ1QjlUZ3BSbVdJUnMr?=
 =?utf-8?B?bVdHc0tiMS9CTU0vUjdTYndtMG9QS0pzVkFDdUdzRHk5OXB1dXhLazhlZ3Ju?=
 =?utf-8?B?dFBwdFFmVkg4ejRrbGQzNXllQ0RHOFRFQk80R01ZZ0pGK2NqajA0VVp5Q1Nj?=
 =?utf-8?B?THprU1V3c084ZW1OSWIwWGNPb1JPcmVkT0hBMk9BOFpQb0ZEc0s5dXZaY2xG?=
 =?utf-8?B?VVByM3BZVjRUWGNQRmtnWUZxaTlPL1NCRVJEMVRkbTk1U2lnb1d5SkJBbDk5?=
 =?utf-8?B?VWc3ck9GY3ZXTnNxMGdnUWhyNnVSZDQxejVCd0xERUd6b1dUME5TQVdhNjUr?=
 =?utf-8?B?UURYRGlVRmh2eGU2d2s0VVdFRDJZL2lMVE5xcStiYTVrckpCdmgrcXpmTkpH?=
 =?utf-8?B?Smc3ek5yb2Fmekx4cEk0emxsV09CSUtnMUxJVVBKcE9QaURBK0hGV055TzZK?=
 =?utf-8?B?akhaQnRGTWVkbmg0VXBIMWVZbzZGSm50Zzd4aWRqZWxRcGtUemVTa28wdkhZ?=
 =?utf-8?B?SFpubmc3ZWUrY0F4VjlzS243VGh3dGZFelRxT3dTelJUQkc1MXJtaXVielMz?=
 =?utf-8?B?eWt2NkdTeG9VR3NtU053b1hxVmNaeVBRT2c5NFh6eGMvWWo3QkdyU2tXdFVM?=
 =?utf-8?B?UUtaTE5vLzFUOVlsVHo4Z3RvSGVNMjAvQUdtd1VmWUI4dlo4ZVMrUTk2dGJK?=
 =?utf-8?B?TG5oZGFlT0wyQ3NSb1pKMUpZMFladnVXZ1FzSW1kVFBFTm9vVHAyQXA0MXRK?=
 =?utf-8?B?L0xROGlQMEErS211OEtyVzlncW52aWhrUjhFeEZhcElQZ0hYY2tkb0FHL2lQ?=
 =?utf-8?B?VkFFRVpUR2I1VndMUUZlbUlmaGhwemtqdjBWY1dweU5KVE5rVWxUZllrM2tI?=
 =?utf-8?B?L29Rbm93OS9rd2trU2ZEV25pRDhlUGxOU1VMd1dWOS90UitEUkk2eHM5UkE0?=
 =?utf-8?B?R3U2WFd4NkovTzhkR2F5V0pHVG9NQnR5aDluNWFJQ0lJYXFXdE85cUNxRERU?=
 =?utf-8?B?dS9Uc25SL0ROUWhzZEpPNTcrMkU1eEVScjFWMFNlSC90bGs2Z0dRQzh4b01q?=
 =?utf-8?B?RENxNHlpTlNKOEpWcVpSRTZ6ck1WTnZ4N1Z3dG9kcVFDNjBDZWpGYVQ4Qzh5?=
 =?utf-8?Q?9kNKJfL7/RTs4ACL6Q=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e1665e-9318-4896-799c-08d8e8937a22
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 15:52:17.9263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 878jB7w1OwZW5Eehs9ClToKGHYVc7IWNCTvWTshhjSa8dMX0V97dwTVJxmRFSXtvFJQ6h/obg23ZwEr0nVjjeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB4695
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-16_05:2021-03-16,
 2021-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103160105
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_155225_906319_44F40168 
X-CRM114-Status: GOOD (  18.62  )
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

You are correct, this is the same issue.

I have reviewed your patch and I have two concerns:
1. As Sagi mentioned, you might not have all the inline data in the socket at this point.
2. You might get hit on the last round of the budget of the receive loop, so you will still have a chance of hitting the response flow before reading all the data from the socket.

Elad

-----Original Message-----
From: Hou Pu <houpu.main@gmail.com> 
Sent: Tuesday, 16 March 2021 11:36
To: Grupi, Elad
Cc: linux-nvme@lists.infradead.org; sagi@grimberg.me
Subject: RE: [PATCH] nvme-tcp: fix a segmentation fault during io parsing error


[EXTERNAL EMAIL] 

Hi Elad and Sagi,

I think this bug is the same one I am trying to fix. Sorry I did not notice Elad was trying to fix this in time.

Elad, could please take a look at this thread. I think these two bug are same.
The callback is same.

[PATCH] nvmet-tcp: finish receiving before send back response if nvmet_req_init() failed.
https://lore.kernel.org/linux-nvme/a4ae0e4b-3d59-3a5a-1533-4545e2e4633e@gmail.com/T/#t

>@@ -476,7 +477,11 @@ static struct nvmet_tcp_cmd *nvmet_tcp_fetch_cmd(struct nvmet_tcp_queue *queue)
>   	  nvmet_setup_c2h_data_pdu(queue->snd_cmd);
>-	else
>+	else if (nvmet_tcp_has_data_in(queue->snd_cmd) &&
>+			       +nvmet_tcp_has_inline_data(queue->snd_cmd)) {
>+		nvmet_tcp_queue_response(&queue->snd_cmd->req);
>+		queue->snd_cmd = NULL;
>+	} else

Here when we get a new cmd and find it has data remains to be read.
I think that in fact this request might already been replied by nvmet_req_init().
And the inline data should also be consumed by read it from the socket.


Thanks,
Hou

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
