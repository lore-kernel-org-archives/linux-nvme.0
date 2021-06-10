Return-Path: <SRS0=9ZED=LE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D58C48BD1
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 09:12:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A4A61406
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 09:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A4A61406
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EF+kYzrQcr5+RMdmSD7tgP7MdUxaDzPuWf12Ba0d1Lo=; b=TCEkZTqFTmUDG3
	sScAFay61ocEOcJvgX6Ycj9llEiYowuSmBv1cIwO4z27yNdavNFi/tpkEX7VFWn0tOdSLlggzw+ar
	+pKG6DHG0vdzPq8Scql8NvpSpOxK3l/TuIU1AovyWPOXNaZn4k1FEFAvYxU/ZesEw+7T1VZIf1gVN
	hx4bdPtZmhWGYsntYKb8XLpE/uJAd3vrOPiU4xJlW3rXtQhnrdEVVoa3qLu/3CDM6GUf1vG6j2XE+
	BxC9HsFPdieEji25KnGnKtj3o53wxjePh1R0nkPd1k0Bx5ca7ri4osHnBHWYJbgbFy/OcHMJrEnGB
	QISXBpVZQZw0kt4jQeig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lrGk3-000833-DO; Thu, 10 Jun 2021 09:12:47 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lrGIW-00HZTq-9n
 for linux-nvme@lists.infradead.org; Thu, 10 Jun 2021 08:44:21 +0000
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15A8gWg9022166; Thu, 10 Jun 2021 04:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=mWa2oFrcC7o2HsC4Is8flimTsVKkhOqVtNDryfqD1uY=;
 b=Qax/77J+jvyxvYVCJcZmCoyyabjObAyYHbC4y8U+8vZeF3yQy6VosjetPn6V7Ziqu9My
 esvc19lCJ+xbpQriHxdI03qiRwEzK9FEjciFULXKleEQspBqGbJ6g0iOJLuGsH11NEbm
 epOx0NPeHTsLjFmNm0tqsSE4F9K6svC5zLTmsjC9SmbEmA9868AswjAt1BqgVn9qoJGz
 maDP7ojGAml1XbGzQ9sfTN8atwqgyf6E27gjd1kWf3xSbMBDj/qjchNdvFJS9S6sftSB
 7c4YXeYmc7p7pWbG4AYjOF/BSADwF4qEbPB/Qt1+yWZd3Gi7za1rzAeHNpwatDiDE0be JA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 392wwvc4vy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Jun 2021 04:44:15 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15A8dejf117073; Thu, 10 Jun 2021 04:44:14 -0400
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
 by mx0a-00154901.pphosted.com with ESMTP id 393eg10xjs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Jun 2021 04:44:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7EbImm5zCmr1H9H2/DG5DyomTpVdaInOxNcy+KRXGwMfg3fOXJJgwH6PLPnTAW4rxls/dVSTpF05YBo3xsNWCiKYiKUxkb0fL3r9ZxBLPJbN78+C5UvMOCzqWrCrWeZXnNNrA/9INd3He1+929RqeE/O2HNaVt9XSbw/O0GgI8dZc8CJUHjnSbjaciI/J/xiDgVwhDk2ZhD2zOAHPkgPneIIcdbn2Srp7wYNMkN3nuuWowq1xx/aNrAOZaN7RPrHod+dmXND3+Sby2bFk4fQzYuUhqoslmNy/ueD3s/kZnPrS0OohMDNr0z9yQxB5hb4GEN0zlCq9hCA5vSyA681g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWa2oFrcC7o2HsC4Is8flimTsVKkhOqVtNDryfqD1uY=;
 b=T3SSyG6fZOCd1wEQ8mYmvLoDDCC9IlyemviFAGEQmVVhbfkKOvT9CH/21AePtiIoTv7UTzS8x9Crev3B/egGN2/05DiadEAp4T4VyGkTWnZv4HLh+CuzInEVAf5eiSQSb+O1lREjkqoMCTlHIxT03BXlPLgLniKyDyzPzkekoLxCsiuilK1aH2b/IN5fgxReKNzo5wYZu6m8K+xgEskv/UrGzKB40FUruhb87A952z8cK+5etAunWI0cjxpNs0OD42NsMEfpbFc4Bht/Q69D3Sgv/CEYsMJgD/fOmdQsSWP0xYdQwhfL6PCnZ7CxakQC8Y50LnYhPwJULR0qACaOmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by MWHPR19MB1104.namprd19.prod.outlook.com (2603:10b6:300:9b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Thu, 10 Jun
 2021 08:44:12 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::908a:1c5:2beb:42c1]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::908a:1c5:2beb:42c1%7]) with mapi id 15.20.4195.030; Thu, 10 Jun 2021
 08:44:12 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: nvme_tcp BUG: unable to handle kernel NULL pointer dereference at
 0000000000000230
Thread-Topic: nvme_tcp BUG: unable to handle kernel NULL pointer dereference
 at 0000000000000230
Thread-Index: AddXDsk20ALf75QRScyvzkSG+0qIDgAm6yOgAUVC6IAAEPeXkAAAsPoAAAD2GkAAAVmfgAABR48gAC/85cA=
Date: Thu, 10 Jun 2021 08:44:12 +0000
Message-ID: <CO1PR19MB48851BDA450C1CAF23965958EE359@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <CO1PR19MB48850A829FEF374C7FC156EFEE3E9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <CO1PR19MB4885314DCBFEB376C7305C98EE3D9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <e40414a9-41ef-f82c-7d1c-2583d8251c26@grimberg.me>
 <CO1PR19MB48850B44ED23C179A4E4F541EE369@CO1PR19MB4885.namprd19.prod.outlook.com>
 <b9c7e6cc-fea5-b8ce-af07-7d004116e3e3@grimberg.me>
 <CO1PR19MB48859C3254E4F3EA3282EDC9EE369@CO1PR19MB4885.namprd19.prod.outlook.com>
 <a76ecf8e-15d0-1ebc-aaf2-c93fee591602@grimberg.me>
 <CO1PR19MB48859E1CCD596402D4007458EE369@CO1PR19MB4885.namprd19.prod.outlook.com>
In-Reply-To: <CO1PR19MB48859E1CCD596402D4007458EE369@CO1PR19MB4885.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Amit.Engel@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-06-09T11:14:08.5167618Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=4f655aea-9234-4315-beed-8fbd7e4c1e79;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [79.176.203.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2aa6c05-33d8-4035-4b65-08d92bebebfb
x-ms-traffictypediagnostic: MWHPR19MB1104:
x-microsoft-antispam-prvs: <MWHPR19MB1104C5C873375113389CD8EEEE359@MWHPR19MB1104.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g4VWX1jY4sXMJ1SCaF73zifeujfsCzAHSxwyWyuExPdZOIhPzOT7L9XjPBKRK23S/OFZ3AckX8fXZZzTtRRGiEstaRpj3V6LY+4nTQLS6NFq4UcfDyfZXawCLynKusZswm3828j3LDJAA3SaAYpHJmhko9BJgmKcanGYix17GEokIDoD1JbevR09KPmHkMKzVF/g/qE34a0K0cgFB8edwKsD6Wc4ooiHCqq9hi7zHxsVD9MQymsKD6DQnN6OFEDRCaFIUQ3zvm0Qcjr3MFcm54qBo8U86OYVQVps16AqNPQg4UszTVbf5fj164dJEsBwrk8pKhI0+JK1sdzueVJZ1y8PltweF85rrJ+/4M/52m6G9mtlRj1hGsS3KQZH0gyh7/27DGKApwnNHjWF5c1ITD8H5OY9xgYrrDPBF1CsB/OeyD1lA68BONZbWB8Xp+Ci2jvrNCsZZJ0ZjjuHR1UpTJTJPOeyDB15Jw6PAFV+LIt9GJHJF8XDtuZKh0BgY78QwNL6Zf0bdvMniFMCrfx95/wq+KeK39ZVPNDZpKW10JinHWBD1Z4VxuML0lRDzD+NdUVxiOn7+muAxwOmp/75yvcpsxAZM5mtqfT0SPdfjcw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR19MB4885.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(9686003)(52536014)(71200400001)(7696005)(8676002)(5660300002)(55016002)(26005)(122000001)(110136005)(2906002)(186003)(316002)(33656002)(66446008)(76116006)(86362001)(478600001)(38100700002)(6506007)(53546011)(8936002)(66476007)(66946007)(786003)(64756008)(83380400001)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K213TE1OQWRjcU82akpubVVSZDRTN3FwbTJ3NmNsRUdrSGw5UmtKMDMyQk9j?=
 =?utf-8?B?R2t2Tlk3eGE2WEtoSnB3R2l6UHMrT2FxTW9pWXdDdmJBbTVMcjM5SFI2Mjh1?=
 =?utf-8?B?VTk5dTg3N2R4OXNPeWdkVEZSWTdjUlZ5MzV1L2pjbEFJUDdRUlg4aSszVWNZ?=
 =?utf-8?B?RVlpWTFXbDd3bG5ETmhMZ1VhdzMxL2tpNDJHS2pYS051OWVGdDh3V3pHOFFi?=
 =?utf-8?B?ZEJXYUhMRXF4WVgrZlNkRHlHRGMvYzNNV01oV0pETHFXUHFCem5wUzk4dGl5?=
 =?utf-8?B?QmhJSXNkSEVJbkJIVlF6VHJNd281T2ZoY0daazNnSXZoY2J6WGxBQ25vUktv?=
 =?utf-8?B?bmhDVmlVTjRDbkZiMmdhMUFWR1QwNHFrQUtHVERtaExwWmhDZzlHMTd5UGF2?=
 =?utf-8?B?L2lhUm1VUkhsSXc2Z0pQVjFoL2ppNUt3ZWpnNGxPYllCazBXcGpEeWN5cmZ5?=
 =?utf-8?B?WUxsOXdvRG9tRWRzcXJDT09ubXFLRCthd0RRTXlTOHVweTVSSWFzUGtRY0RD?=
 =?utf-8?B?OEZSQjlJVmRRMDErUzRLY2Qva2VGR21qTVFqbVRLQVVBNUJmS1oyRGEvRnFz?=
 =?utf-8?B?WVB1bktFSW5KT0tUeVl3cXEzNnNOdWFKVnJQWXlHRTVkdTF2aDFsdE80Wjd3?=
 =?utf-8?B?Qk1DYlE5TGNnQ0dXZWIvVzl5eThMY3R6UEVJTExzdkwxUHpoUFNtM0FpcFBy?=
 =?utf-8?B?MzNQN0ZPSEFYMndhTWtRZ3JTM2trc1c4S2dWS2hzT0VveFhFdk1ya2pDTVEx?=
 =?utf-8?B?dUplMk1sNWJyTjZJcVgrZ1BhTnQ5bDE0MW1INFJ4S05MN0FGVkkraXoxci80?=
 =?utf-8?B?dkdGWlpvSTg2amwzbUgzT1M5VHNEcGdVcm9ZNGhZWCtMZDdVNFJPdWZsL2Uy?=
 =?utf-8?B?emhLUy92a2hJQUZtY2x5NXoxV21pdFdFbXFJSjNaWTZuTUREQzVmdk02MzQ3?=
 =?utf-8?B?ZkJ2MGlRUmNZOGd5WE11dHBmbnR4ZC9pWlBWcEJSdkE5TCtXbTFIdVdwa21P?=
 =?utf-8?B?RUVML2oxOWxjU0V1Vkd4RDZiZUpOeGh0bWpnZDgrVUJ6OUlwNE5ObXRiMnNy?=
 =?utf-8?B?cDhDalJCS1NvUW1GMmZBSnhHbW1DcXo5ZUIxTTMwZ0VuUjNYS2ptNUd2RUU1?=
 =?utf-8?B?bmNGeWY2RFBCdUVRdUxyZ1RHejBCVWhXWngyWk9tT0ttblIvVldoVmVadnV3?=
 =?utf-8?B?NVdEVGpxVXQ3UjRQMG9uQUdDUHlGOWt2S3BTbHJoNkk5TXYvQWZvak5zbGR0?=
 =?utf-8?B?eC9WcHVFblB2NGViRlc2RDcvNnhKWExyeGlGRmZYVEQyaS9mcGtlbXdqcG5u?=
 =?utf-8?B?eWdYdldiOXZ4WXdGa3RBYlhVbW1jUjhxODhlQXR4dWdFdG5PWlZtMDBaSVBs?=
 =?utf-8?B?SldWNWVtZ3NoNTF3dWxZR0FwanZYZ0k1YjNXakdFUWIwbzhGc1crTmxQa3lH?=
 =?utf-8?B?MVMva3dUNFFsVmFGQS9vU1d5VFE0TUFOY3dLdnNnR2dadVZlTGw0Uk00QW5n?=
 =?utf-8?B?NkhJWG5taUdXditOZm4reHRRTHZKODRoRE4ySEwrVko5ajY4eXhrOUtNemd0?=
 =?utf-8?B?QnJJVXd1WHplMFgySmowODd6aUhXSFlSNDM0M1ltRFZINlNTWmx5Kys4Z2J5?=
 =?utf-8?B?ek1tWkQ1NHc2YmNLOHlTRHhTRVdiSDdBeGNaYnBISlE1OVo5ZXUrRHV5Qjhy?=
 =?utf-8?B?TTJIQUUxTkRMYVZ1NGNaazZEdzJXZStvaXlaVVRFaUptT3hqL1dlajRRRnVI?=
 =?utf-8?Q?IEbHzR2rS9Xd4Fz4Mafp8K8oo9W1FzLJnP3DrV2?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2aa6c05-33d8-4035-4b65-08d92bebebfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2021 08:44:12.5661 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nnh4qabhCRfQcrbo2A9Rd61EL0eY3Ovr+W10O1We0KIqbCC6qI2Pd+FJqSQJlbCkJBsunSedS7pgZT6xZQCNwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR19MB1104
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-06-10_03:2021-06-10,
 2021-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 mlxlogscore=891 clxscore=1015 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106100056
X-Proofpoint-GUID: Xmx131h2BSJsmPMii6taI10FKZkJhFZ9
X-Proofpoint-ORIG-GUID: Xmx131h2BSJsmPMii6taI10FKZkJhFZ9
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 phishscore=0
 mlxlogscore=995 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106100056
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210610_014420_507767_30CC1043 
X-CRM114-Status: GOOD (  18.22  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

V2UgYXJlIHRyeWluZyB0byByZXByb2R1Y2Ugd2l0aCB0aGUgdXBzdHJlYW0gY29kZSBub3csIHdp
bGwgdXBkYXRlDQoNCkluIGFkZGl0aW9uLCBJIGp1c3QgcG9zdGVkIGEgcGF0Y2ggdG8gYWRkIG11
dGV4IGxvY2sgYWxzbyB0byBzdGFydCBxdWV1ZSBmYWlsdXJlIGNhc2UsIGFzIHN1Z2dlc3RlZCBi
eSBTYWdpLg0KDQpUaGFua3MNCkFtaXQgDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBFbmdlbCwgQW1pdCANClNlbnQ6IFdlZG5lc2RheSwgSnVuZSA5LCAyMDIxIDI6MTQgUE0N
ClRvOiAnU2FnaSBHcmltYmVyZyc7IGxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZw0KQ2M6
IEFubmVyLCBSYW47IEdydXBpLCBFbGFkDQpTdWJqZWN0OiBSRTogbnZtZV90Y3AgQlVHOiB1bmFi
bGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQgMDAwMDAwMDAw
MDAwMDIzMA0KDQpDb3JyZWN0LCBmcmVlX3F1ZXVlIGlzIGJlaW5nIGNhbGxlZCAoc29jay0+c2sg
YmVjb21lcyBOVUxMKSBiZWZvcmUgcmVzdG9yZV9zb2NrX2NhbGxzDQoNCldoZW4gcmVzdG9yZV9z
b2NrX2NhbGxzIGlzIGNhbGxlZCwgd2UgZmFpbCBvbiAnd3JpdGVfbG9ja19iaCgmc29jay0+c2st
PnNrX2NhbGxiYWNrX2xvY2spJyANCg0KTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIGF0IDB4MjMw
IOKGkiA1NjAgZGVjaW1hbA0KY3Jhc2g+IHN0cnVjdCBzb2NrIC1vDQpzdHJ1Y3Qgc29jayB7DQog
ICBbMF0gc3RydWN0IHNvY2tfY29tbW9uIF9fc2tfY29tbW9uOw0KICAg4oCmDQogICAuLi4NCiAg
IOKApg0KICAgWzU2MF0gcndsb2NrX3Qgc2tfY2FsbGJhY2tfbG9jazsNCg0Kc3RvcCBxdWV1ZSBp
biBjdHgyIGRvZXMgbm90IHJlYWxseSBkbyBhbnl0aGluZyBzaW5jZSAnTlZNRV9UQ1BfUV9MSVZF
JyBiaXQgaXMgYWxyZWFkeSBjbGVhcmVkIChieSBjdHgxKS4NCmNhbiB5b3UgcGxlYXNlIGV4cGxh
aW4gaG93IHN0b3AgdGhlIHF1ZXVlIGJlZm9yZSBmcmVlIGhlbHBzIHRvIHNlcmlhbGl6ZSBjdHgx
ID8NCg0KVGhlIHJhY2Ugd2UgYXJlIGRlc2NyaWJpbmcgaXMgYmFzZWQgb24gdGhlIHBhbmljIGJ0
IHRoYXQgSSBzaGFyZWQuDQoNCm1heWJlIG91ciBhbmFseXNpcyBpcyBub3QgYWNjdXJhdGU/IA0K
DQpUaGFua3MsDQpBbWl0DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBTYWdp
IEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPiANClNlbnQ6IFdlZG5lc2RheSwgSnVuZSA5LCAy
MDIxIDEyOjExIFBNDQpUbzogRW5nZWwsIEFtaXQ7IGxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZw0KQ2M6IEFubmVyLCBSYW47IEdydXBpLCBFbGFkDQpTdWJqZWN0OiBSZTogbnZtZV90Y3Ag
QlVHOiB1bmFibGUgdG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQg
MDAwMDAwMDAwMDAwMDIzMA0KDQoNCltFWFRFUk5BTCBFTUFJTF0gDQoNCg0KPiBJbSBub3Qgc3Vy
ZSB0aGF0IHVzaW5nIHRoZSBxdWV1ZV9sb2NrIG11dGV4IGlsbCBoZWxwIFRoZSByYWNlIGluIHRo
aXMgDQo+IGNhc2UgaXMgYmV0d2VlbiBzb2NrX3JlbGVhc2UgYW5kIG52bWVfdGNwX3Jlc3RvcmVf
c29ja19jYWxscyANCj4gc29ja19yZWxlYXNlIGlzIGJlaW5nIGNhbGxlZCBhcyBwYXJ0IG9mIG52
bWVfdGNwX2ZyZWVfcXVldWUgd2hpY2ggaXMgDQo+IGRlc3Ryb3lpbmcgdGhlIG11dGV4DQoNCk1h
eWJlIEknbSBub3QgdW5kZXJzdGFuZGluZyB0aGUgaXNzdWUgaGVyZS4gV2hhdCBpcyB0aGUgc2Nl
bmFyaW8gYWdhaW4/DQpzdG9wX3F1ZXVlIGlzIGNhbGxlZCAoY3R4MSksIHRoYXQgdHJpZ2dlcnMg
ZXJyb3JfcmVjb3ZlcnkgKGN0eDIpIHdoaWNoIHRoZW4gY2FsbHMgZnJlZV9xdWV1ZSBiZWZvcmUg
Y3R4MSBnZXRzIHRvIHJlc3RvcmUgc29jayBjYWxsYmFja3M/DQoNCmVycl93b3JrIHdpbGwgZmly
c3Qgc3RvcCB0aGUgcXVldWVzIGJlZm9yZSBmcmVlaW5nIHRoZW0sIHNvIGl0IHdpbGwgc2VyaWFs
aXplIGJlaGluZCBjdHgxLiBXaGF0IGFtIEkgbWlzc2luZz8NCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
