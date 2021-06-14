Return-Path: <SRS0=JVDK=LI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04E9C2B9F4
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 14:45:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7BF66124B
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jun 2021 14:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BF66124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FrPLHERwP8uywbarqfIjoH9rymtAGeaAWJ9zPl7ZTFk=; b=bYp2ZN0TEy4SQC
	Shux6ecuKE0hlAt65MFPbegKwH/WkL9T1dNhxdt0khZ6/NIDnPEoEVQIyp3RxrlohRzm75MNZkXK6
	zFkw27v2ToQz9oUbxL96QfHmQx6e3yunnY8bvEwArTmg+RE7/slmFxQUfxAUKcYhxTG/6AmR+O8nq
	GXRY/jYQSQiygNefBgOIIfi1QSVSusqzVKWIMzzxNEeSw9+7Mxc6H2im0qyxyo5uouAzI24fKSGMZ
	J1rtAvqFhOxFfq/+tZxSS1oMECTzBTnCCaYlAOejLDA3G5HWkk/osxneLStdDaho7y8UmLX+JzuII
	pjzRsyoLrr7ulsHBd7Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lsnps-00EYjN-Jc; Mon, 14 Jun 2021 14:45:08 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lsnpp-00EYid-OW
 for linux-nvme@lists.infradead.org; Mon, 14 Jun 2021 14:45:07 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15EEeMfl028928; Mon, 14 Jun 2021 07:44:54 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
 by mx0b-0016f401.pphosted.com with ESMTP id 3963v1h650-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Jun 2021 07:44:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBk3b5Y9RhXGXDVdzbX7FfAWlBtETx9EKTX5R2YVCNdDqtyFfWzvkwVY/2OcFC12YAeYaB6G70d4Zwuw1gsxOQbmql3uKv0vJChsfgSN0ZwHbXeAfz38nBfJ9FarTneycw0hkBPADCt2ntk/d1mGoaPALiVx/5FopDARt5Q/ao3t7Hd3a3NIOAvVoHtrFfJ1Logk7HAcMmh4xRwaZQRGEHlbVJApija+Z08emXA1myZALZI7waGFst+C9Q+hLCZcAQbghgqBhB1ueGWsEN7lPSscCfX4Cg8wtefkp9qP9hCoNkF5qu2gTJNb9FkrG2wWvaxxC851p8teYLrp4P5Giw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgaRdmcQWQ0F20DbQQ4EyZfY0sEab6HPqiBLcmhxKDY=;
 b=PyXUgyGKBFP2XsxxV0znK/BZXnbDn2mZ6J9tfEOwDav1aSdAe711Av8eIFPwiZ9zD3a/iaiirObmDg/cMahkVVP4PKanJPRFzlxUf5pq9qCgSYDoRy3im7FEL0bCjaB9l6P9q7S3Ub1WYm0z7o1UcUQ7QmoKx0hsHPWZ9DOm3FEPtVxPetszTmw2FuRkzeWHaFCMBcuQAYnAZ2F0tmtzj0mAQKqtCmEXp3kRyYwtJ2TWUBILLNX7XGvHzMa7MUdTO9Pr6BMtAP2stxCVDY9MaF8xgn3o9pNPDmCQI9Nc8Cw0J5TKjrDYIXNxjZgKyKFK3OuPfdA6C6AI1cAeas4jAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgaRdmcQWQ0F20DbQQ4EyZfY0sEab6HPqiBLcmhxKDY=;
 b=fEqkPHfjAMsOVo5AzAr+gpNw5qZe0i+ZICEL0oIPrNVnQSKuiVQQknpugrhVlxiTaI7s85ENaqzV5pTbsOb8Li2xrwoJk4Y3wQajqoHTO1Dm7B3VAy0XXJ901JwzCH8JVTTxn9FFxbbMdGpT9R8j/6x/6fScC7lUsJznmrIHBJM=
Received: from CH0PR18MB4129.namprd18.prod.outlook.com (2603:10b6:610:e0::12)
 by CH2PR18MB3173.namprd18.prod.outlook.com (2603:10b6:610:14::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Mon, 14 Jun
 2021 14:44:52 +0000
Received: from CH0PR18MB4129.namprd18.prod.outlook.com
 ([fe80::a0cd:d9bd:2cb4:9bfe]) by CH0PR18MB4129.namprd18.prod.outlook.com
 ([fe80::a0cd:d9bd:2cb4:9bfe%4]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 14:44:52 +0000
From: Michal Kalderon <mkalderon@marvell.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Shai Malin <smalin@marvell.com>, Ariel
 Elior <aelior@marvell.com>
Subject: RE: [EXT] Re: BUG: scheduling while atomic when
 nvmet_rdma_queue_response fails in posting a request
Thread-Topic: [EXT] Re: BUG: scheduling while atomic when
 nvmet_rdma_queue_response fails in posting a request
Thread-Index: AddVJduDAzSsasp/Srq8m1sJiLA/SwHZ/iiAAAIE7AAAC0D9AAEaK/MQ
Date: Mon, 14 Jun 2021 14:44:51 +0000
Message-ID: <CH0PR18MB412996A6716DE9AA114C09B0A1319@CH0PR18MB4129.namprd18.prod.outlook.com>
References: <CH0PR18MB4129247C2B9AE092E3C59740A1209@CH0PR18MB4129.namprd18.prod.outlook.com>
 <e059fc90-81e7-dbe8-86f4-87b4bdbd5bb0@grimberg.me>
 <20210608184134.GA339600@dhcp-10-100-145-180.wdc.com>
 <4a031bc0-fba3-12d6-428f-a378aba1897e@grimberg.me>
In-Reply-To: <4a031bc0-fba3-12d6-428f-a378aba1897e@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [46.116.32.221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da8e43dc-9246-4d69-a358-08d92f42f7da
x-ms-traffictypediagnostic: CH2PR18MB3173:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR18MB3173C6A8AAC2D7F610E59314A1319@CH2PR18MB3173.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l86ZWpT66yTNBDch47sMvKRP6K523h9JpCfdRYeKx53llAGB1UZNsVWwOySoOxZJ+8sBEYBXJ1eNoJCh4MzXPR0n7ugPCv7YVPYRMSsBNHnfA3rxZso8C+odUHO8THTfzsKOWO1Zi11/H5gmDHvL1lus0EN4o4idaftbJUtcOXhSKNnnRXGljSMu0ie/N2rZLtqIHH62hxkMqbYQ8X/VAHuoWSqAIvp7A3XKhSpPjjjBXVpwwr2GgfzSDSkkqAGh9drbHvbo6b4Id01Pe0XrLceEMU/vzXyBoD+71a/tMKtjOF4mcF6DGy1ByQrO1IgZguj571/o0UtekSOp6y8g0dqNMDj6jPU74SCFXgCFNBcQcBG1AtmZua5Jyj9Rh+M+I/S+W8xlQpMd1Pcvu9eUyu3ZjkWcHjKhXCzBUMhM52zWIIPHI48ewm4TYclo8HGORkhQVx7L0MxYPUdcea99TW/83PEcN7C1Xmo8geUMih7PGYq3DQ9AHrQ8xLh9vHwZ1WF+gmKG/hA+G3ZbMpoPykaQ8RsjfX9p1ne6bdMYFwA8FhkzuGMUbWKxXlzAqQSKNMnsRyYtVbOfOATWdTkf8jYJNF8/UJV2pMThODXShNc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR18MB4129.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(2906002)(83380400001)(4326008)(107886003)(33656002)(122000001)(86362001)(66946007)(38100700002)(52536014)(76116006)(64756008)(66556008)(186003)(66446008)(54906003)(8676002)(55016002)(9686003)(66476007)(6506007)(71200400001)(26005)(110136005)(7696005)(8936002)(498600001)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjdreThEcmdtbjVkVTgwMkNRVlQvTmRpcDhJNkx4N253SXNPMjlEdWloeE0w?=
 =?utf-8?B?dTJpOS9keG5TQTJaWGVlTmNzRGNsKzc1QXVTN253akRoUW9IbzlBQnBlY3dB?=
 =?utf-8?B?Z3hzMTIrL0tIWnYrT2k5dXltN0xXd1RRRXJRaERCaCthT1dWdFRVNEJUZENI?=
 =?utf-8?B?Zm5ma0U5RWI4UnlNbnAvbU1aakg1N2pYM0hiZ0QvZUMvcWZqZXJNUWVHa3JO?=
 =?utf-8?B?ZGlHZ1hVaUNMdm1GNjVHVExIRnduVnVLbzVQU2VjY0kwK3NXUm1QMjdNUUhy?=
 =?utf-8?B?NDRTOURJbTFMaHFOdkVBRVFJQTF5eGI0SkdZQkFVVjFySlN0OFRneDBpeU55?=
 =?utf-8?B?SjdreC9aVUFwVE1jWXp3SHZCYTVWVVZHQ3JSSkEveFFzYm1PeGxZSjB1b3Rk?=
 =?utf-8?B?cWpVN1dCcExtK1ArYXkrNWlZZytUNFNhaDdVeUZIYWpVOWo4MXBka3lXRUwr?=
 =?utf-8?B?NzR4RXpNbS9DQWVPYkRIWit6bTJnOWRaV2NERGFLYjZnRmtUSEJ2NER5RU9t?=
 =?utf-8?B?eDM1TGk5UkoyMEhTd3ZXR3Qrbkd0elpUVXhmZlY4T3NCK3MraTM5RkdCRzJI?=
 =?utf-8?B?QnV3K2FicHYyL1JlUWY4UGpJNEk3ZWtrai9RSUVadnNxaXdEY0daSzdpVjAy?=
 =?utf-8?B?Rm4wSEgvb29EOEgzeHdlTTBmTExqWnEybFQ3K1dQN2VKcm03RzhsYWwwT2Fh?=
 =?utf-8?B?QVZubWZ3VnIrY1EyWWY5NGFnWHdENlRlOGhER2I1UjJUa1lQSnorSmNUM1lL?=
 =?utf-8?B?K0tsaTdhaXBOWU42cTdCNWJPQkdVUks4L1lsSVllcDNjdk9nRVlpQUJCWktt?=
 =?utf-8?B?Sk1vQXdDN2NaMWpRUmtISzgzR1hLSEk5L2I1MlRPVUthUldBSnpNV01zUHZ3?=
 =?utf-8?B?M1poVVBKOUo2eTdJSWJaRWQ5aFNRMCtkSy9vNUllUFBRT1hPUWcwYVNyOWU2?=
 =?utf-8?B?alA4eFlSbE1FUFZvNmVGdGVWU05EYmVIQStySlR5dEd1UlNQbVN1a2ZtQnlm?=
 =?utf-8?B?NEVNcUhkWUtYN1ltd1VDbElCbTF2OThzTkJMRy9ZVXVKdHQ1Nm11WFdtV0tE?=
 =?utf-8?B?NlZ6NkpRUnVnOSttZVFxRzZ0c0hpWHNTMWgzYTNyWFEwajBvc3dUWlo3L1J5?=
 =?utf-8?B?NjBBTGl5UW1raEpSekp5alQyUjlsclZXQXZ6dXY2TDUzRmRCZ21DZmxiUm0r?=
 =?utf-8?B?eElqcDVXdm1GY0JidE9sT0gwb3R0YnJtOFNWU3pEZjdWeTg3L2RrSU9VYkJU?=
 =?utf-8?B?UkxWVVNRZTk4dzhJWjdMUW4vK2w1QXUvdURpT1lKa2xkdDNBb1R6US9DNlE0?=
 =?utf-8?B?UmxYN0J3Ny9RUE56UzJ5YXVPTm9HVnJnSEgyQXFMaXNVTTR5QTUwZmROdnZk?=
 =?utf-8?B?MHMxRXk4dVFMdWNQSFl6RXkzWEEzSVBTYkRMeU91TktnYVRlcjIwdXVRcTJP?=
 =?utf-8?B?bUhJS0s2bWszRGQ1YkdCN0lLVVlpMlcxRG5RRGhQbUZvNTdMUUx5QzdnY2FT?=
 =?utf-8?B?UU5MRnRZWEZINERxcGlQN3o5VVc2cWJWcW1haHZERTlrQ29zallaZWdZWFlF?=
 =?utf-8?B?ZUZsdWlBdW1FZ05wMzhQSjNON2FVYVJoVjV5cjJLeDlhNjI5YkFWN1BDQzBZ?=
 =?utf-8?B?K3RMa3lsWjYwWVJKTkc1dzA3RHhXVVhGZzZiWmJXTERDMzl0VDNWZTNVMmpB?=
 =?utf-8?B?Y3NPMFpsYmdGK2tId0RRVEZDQTRnMWVhQjNIMkoxQTJ2c2NtM2p6WW9yMGYr?=
 =?utf-8?Q?y1ZUMKNEXw8Ua6oed/r3CXkTL9LXkSurtgagiRg?=
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4129.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8e43dc-9246-4d69-a358-08d92f42f7da
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2021 14:44:52.0581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xoVfKNbWFva86T21XnmZuiUqK5kSdVbYLERLTJvrscxFaRYxnAY8O2jxZnQ4+V6q4/DKJkIGsLPjGmFLjCHd/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR18MB3173
X-Proofpoint-GUID: cy7K1XbqeWa9PFqtWB2LUG1D06lZCl5W
X-Proofpoint-ORIG-GUID: cy7K1XbqeWa9PFqtWB2LUG1D06lZCl5W
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-06-14_09:2021-06-14,
 2021-06-14 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210614_074506_064601_4B90BCC7 
X-CRM114-Status: GOOD (  25.78  )
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

PiBGcm9tOiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KPiBTZW50OiBXZWRuZXNk
YXksIEp1bmUgOSwgMjAyMSAzOjA0IEFNDQo+IA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IA0KPiA+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC9yZG1hLmMgYi9kcml2ZXJzL252bWUvdGFy
Z2V0L3JkbWEuYw0KPiA+PiBpbmRleCA3ZDYwN2Y0MzVlMzYuLjZkMmVlYTMyMjc3OSAxMDA2NDQN
Cj4gPj4gLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9yZG1hLmMNCj4gPj4gKysrIGIvZHJpdmVy
cy9udm1lL3RhcmdldC9yZG1hLmMNCj4gPj4gQEAgLTE2LDYgKzE2LDcgQEANCj4gPj4gICAjaW5j
bHVkZSA8bGludXgvd2FpdC5oPg0KPiA+PiAgICNpbmNsdWRlIDxsaW51eC9pbmV0Lmg+DQo+ID4+
ICAgI2luY2x1ZGUgPGFzbS91bmFsaWduZWQuaD4NCj4gPj4gKyNpbmNsdWRlIDxsaW51eC9hc3lu
Yy5oPg0KPiA+Pg0KPiA+PiAgICNpbmNsdWRlIDxyZG1hL2liX3ZlcmJzLmg+DQo+ID4+ICAgI2lu
Y2x1ZGUgPHJkbWEvcmRtYV9jbS5oPg0KPiA+PiBAQCAtNzEyLDYgKzcxMywxMiBAQCBzdGF0aWMg
dm9pZCBudm1ldF9yZG1hX3NlbmRfZG9uZShzdHJ1Y3QgaWJfY3ENCj4gKmNxLA0KPiA+PiBzdHJ1
Y3QgaWJfd2MgKndjKQ0KPiA+PiAgICAgICAgICB9DQo+ID4+ICAgfQ0KPiA+Pg0KPiA+PiArc3Rh
dGljIHZvaWQgbnZtZXRfcmRtYV9hc3luY19yZWxlYXNlX3JzcCh2b2lkICpkYXRhLCBhc3luY19j
b29raWVfdA0KPiBjb29raWUpDQo+ID4+ICt7DQo+ID4+ICsgICAgICAgc3RydWN0IG52bWV0X3Jk
bWFfcnNwICpyc3AgPSBkYXRhOw0KPiA+PiArICAgICAgIG52bWV0X3JkbWFfcmVsZWFzZV9yc3Ao
cnNwKTsNCj4gPj4gK30NCj4gPj4gKw0KPiA+PiAgIHN0YXRpYyB2b2lkIG52bWV0X3JkbWFfcXVl
dWVfcmVzcG9uc2Uoc3RydWN0IG52bWV0X3JlcSAqcmVxKQ0KPiA+PiAgIHsNCj4gPj4gICAgICAg
ICAgc3RydWN0IG52bWV0X3JkbWFfcnNwICpyc3AgPQ0KPiA+PiBAQCAtNzQ1LDcgKzc1MiwxMiBA
QCBzdGF0aWMgdm9pZCBudm1ldF9yZG1hX3F1ZXVlX3Jlc3BvbnNlKHN0cnVjdA0KPiBudm1ldF9y
ZXENCj4gPj4gKnJlcSkNCj4gPj4NCj4gPj4gICAgICAgICAgaWYgKHVubGlrZWx5KGliX3Bvc3Rf
c2VuZChjbV9pZC0+cXAsIGZpcnN0X3dyLCBOVUxMKSkpIHsNCj4gPj4gICAgICAgICAgICAgICAg
ICBwcl9lcnIoInNlbmRpbmcgY21kIHJlc3BvbnNlIGZhaWxlZFxuIik7DQo+ID4+IC0gICAgICAg
ICAgICAgICBudm1ldF9yZG1hX3JlbGVhc2VfcnNwKHJzcCk7DQo+ID4+ICsgICAgICAgICAgICAg
ICAvKg0KPiA+PiArICAgICAgICAgICAgICAgICogV2UgbWlnaHQgYmUgaW4gYXRvbWljIGNvbnRl
eHQsIGhlbmNlIHJlbGVhc2UNCj4gPj4gKyAgICAgICAgICAgICAgICAqIHRoZSByc3AgaW4gYXN5
bmMgY29udGV4dCBpbiBjYXNlIHdlIG5lZWQgdG8NCj4gPj4gKyAgICAgICAgICAgICAgICAqIHBy
b2Nlc3MgdGhlIHdyX3dhaXRfbGlzdC4NCj4gPj4gKyAgICAgICAgICAgICAgICAqLw0KPiA+PiAr
ICAgICAgICAgICAgICAgYXN5bmNfc2NoZWR1bGUobnZtZXRfcmRtYV9hc3luY19yZWxlYXNlX3Jz
cCwgcnNwKTsNCj4gPj4gICAgICAgICAgfQ0KPiA+PiAgIH0NCj4gPg0KPiA+IEp1c3QgRllJLCBh
c3luY19zY2hlZHVsZSgpIGhhcyBjb25kaXRpb25zIHdoZXJlIGl0IG1heSBleGVjdXRlIHlvdXIN
Cj4gPiBjYWxsYmFjayBzeW5jaHJvbm91c2x5LiBZb3VyIHN1Z2dlc3Rpb24gaXMgcHJvYmFibHkg
ZmluZSBmb3IgdGVzdGluZywNCj4gPiBidXQgaXQgc291bmRzIGxpa2UgeW91IHJlcXVpcmUgc29t
ZXRoaW5nIHRoYXQgY2FuIGd1YXJhbnRlZSBhIG5vbi1hdG9taWMNCj4gPiBjb250ZXh0IGZvciBu
dm1ldF9yZG1hX3JlbGVhc2VfcnNwKCkuDQo+IA0KPiBPSywgaXQgc2VlbXMgdGhhdCB0aGUgaXNz
dWUgaXMgdGhhdCB3ZSBhcmUgc3VibWl0dGluZyBJL08gaW4gYXRvbWljDQo+IGNvbnRleHQuIFRo
aXMgc2hvdWxkIGJlIG1vcmUgYXBwcm9wcmlhdGUuLi4NCg0KVGhhbmtzIFNhZ2ksIHRoaXMgc2Vl
bXMgdG8gd29yay4gSSdtIHN0aWxsIGhpdHRpbmcgc29tZSBvdGhlciBpc3N1ZXMgd2hlcmUgaW4g
c29tZSBjYXNlcyByZWNvbm5lY3QgZmFpbHMsIGJ1dCBJJ20gDQpDb2xsZWN0aW5nIG1vcmUgaW5m
by4gDQoNCj4gDQo+IC0tDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L3JkbWEu
YyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvcmRtYS5jDQo+IGluZGV4IDdkNjA3ZjQzNWUzNi4uMTZm
MmY1YTg0YWU3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L3JkbWEuYw0KPiAr
KysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L3JkbWEuYw0KPiBAQCAtMTAyLDYgKzEwMiw3IEBAIHN0
cnVjdCBudm1ldF9yZG1hX3F1ZXVlIHsNCj4gDQo+ICAgICAgICAgIHN0cnVjdCB3b3JrX3N0cnVj
dCAgICAgIHJlbGVhc2Vfd29yazsNCj4gICAgICAgICAgc3RydWN0IGxpc3RfaGVhZCAgICAgICAg
cnNwX3dhaXRfbGlzdDsNCj4gKyAgICAgICBzdHJ1Y3Qgd29ya19zdHJ1Y3QgICAgICB3cl93YWl0
X3dvcms7DQo+ICAgICAgICAgIHN0cnVjdCBsaXN0X2hlYWQgICAgICAgIHJzcF93cl93YWl0X2xp
c3Q7DQo+ICAgICAgICAgIHNwaW5sb2NrX3QgICAgICAgICAgICAgIHJzcF93cl93YWl0X2xvY2s7
DQo+IA0KPiBAQCAtNTE3LDggKzUxOCwxMCBAQCBzdGF0aWMgaW50IG52bWV0X3JkbWFfcG9zdF9y
ZWN2KHN0cnVjdA0KPiBudm1ldF9yZG1hX2RldmljZSAqbmRldiwNCj4gICAgICAgICAgcmV0dXJu
IHJldDsNCj4gICB9DQo+IA0KPiAtc3RhdGljIHZvaWQgbnZtZXRfcmRtYV9wcm9jZXNzX3dyX3dh
aXRfbGlzdChzdHJ1Y3QgbnZtZXRfcmRtYV9xdWV1ZQ0KPiAqcXVldWUpDQo+ICtzdGF0aWMgdm9p
ZCBudm1ldF9yZG1hX3Byb2Nlc3Nfd3Jfd2FpdF9saXN0KHN0cnVjdCB3b3JrX3N0cnVjdCAqdykN
Cj4gICB7DQo+ICsgICAgICAgc3RydWN0IG52bWV0X3JkbWFfcXVldWUgKnF1ZXVlID0NCj4gKyAg
ICAgICAgICAgICAgIGNvbnRhaW5lcl9vZih3LCBzdHJ1Y3QgbnZtZXRfcmRtYV9xdWV1ZSwgd3Jf
d2FpdF93b3JrKTsNCj4gICAgICAgICAgc3Bpbl9sb2NrKCZxdWV1ZS0+cnNwX3dyX3dhaXRfbG9j
ayk7DQo+ICAgICAgICAgIHdoaWxlICghbGlzdF9lbXB0eSgmcXVldWUtPnJzcF93cl93YWl0X2xp
c3QpKSB7DQo+ICAgICAgICAgICAgICAgICAgc3RydWN0IG52bWV0X3JkbWFfcnNwICpyc3A7DQo+
IEBAIC02NzcsNyArNjgwLDcgQEAgc3RhdGljIHZvaWQgbnZtZXRfcmRtYV9yZWxlYXNlX3JzcChz
dHJ1Y3QNCj4gbnZtZXRfcmRtYV9yc3AgKnJzcCkNCj4gICAgICAgICAgICAgICAgICBudm1ldF9y
ZXFfZnJlZV9zZ2xzKCZyc3AtPnJlcSk7DQo+IA0KPiAgICAgICAgICBpZiAodW5saWtlbHkoIWxp
c3RfZW1wdHlfY2FyZWZ1bCgmcXVldWUtPnJzcF93cl93YWl0X2xpc3QpKSkNCj4gLSAgICAgICAg
ICAgICAgIG52bWV0X3JkbWFfcHJvY2Vzc193cl93YWl0X2xpc3QocXVldWUpOw0KPiArICAgICAg
ICAgICAgICAgc2NoZWR1bGVfd29yaygmcXVldWUtPndyX3dhaXRfd29yayk7DQo+IA0KPiAgICAg
ICAgICBudm1ldF9yZG1hX3B1dF9yc3AocnNwKTsNCj4gICB9DQo+IEBAIC0xNDQ2LDYgKzE0NDks
NyBAQCBudm1ldF9yZG1hX2FsbG9jX3F1ZXVlKHN0cnVjdA0KPiBudm1ldF9yZG1hX2RldmljZSAq
bmRldiwNCj4gICAgICAgICAgICogaW5zaWRlIGEgQ00gY2FsbGJhY2sgd291bGQgdHJpZ2dlciBh
IGRlYWRsb2NrLiAoZ3JlYXQgQVBJDQo+IGRlc2lnbi4uKQ0KPiAgICAgICAgICAgKi8NCj4gICAg
ICAgICAgSU5JVF9XT1JLKCZxdWV1ZS0+cmVsZWFzZV93b3JrLA0KPiBudm1ldF9yZG1hX3JlbGVh
c2VfcXVldWVfd29yayk7DQo+ICsgICAgICAgSU5JVF9XT1JLKCZxdWV1ZS0+d3Jfd2FpdF93b3Jr
LA0KPiBudm1ldF9yZG1hX3Byb2Nlc3Nfd3Jfd2FpdF9saXN0KTsNCj4gICAgICAgICAgcXVldWUt
PmRldiA9IG5kZXY7DQo+ICAgICAgICAgIHF1ZXVlLT5jbV9pZCA9IGNtX2lkOw0KPiAgICAgICAg
ICBxdWV1ZS0+cG9ydCA9IHBvcnQtPm5wb3J0Ow0KPiAtLQ0KVGhhbmtzLMKgDQoNClRlc3RlZC1i
eTogTWljaGFsIEthbGRlcm9uwqA8bWljaGFsLmthbGRlcm9uQG1hcnZlbGwuY29tPg0KDQoNCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
