Return-Path: <SRS0=p1db=LY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFCCC11F69
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jun 2021 14:22:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16E8A6143F
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jun 2021 14:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E8A6143F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+KggMelsa9sb+6RbK1E3P2Lx8nBN+yqLvJaCPsIxbzI=; b=zF3kUZRtxZffPA
	o16TjcMWitqRT469Tam8+sBQkw7OTCV4Xu7py7u3/35+ON4J4iWem+WyNk9z6SmhirLWXJWdrG8Zh
	4KZnf65RrC7FYudzgr1F8y17KE9lLglMK3ca7yWQfbcDHhcsGshe/mi9Ryi0wYTpfFPvytTfIZaLm
	/459bIhmyqgLHhKi7KVnGq6W89/BV2ZAGS7PhSW74H0gW+G9f+tPVM/vU+zvHw9OK/oeYSlQJwvFF
	I2bX9HBQr7Iqq1lXkaWff8RnKGObhuN3I8fS2HIl0klRFMapxT5sRvyXRQC0tUAT8UTh7Xi7oXjIr
	lVZ/04ocj8fSZW1ZBnsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyb6S-00ELHq-Fm; Wed, 30 Jun 2021 14:22:12 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyalk-00EEwo-1o
 for linux-nvme@lists.infradead.org; Wed, 30 Jun 2021 14:00:49 +0000
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15UDwXCM005765; Wed, 30 Jun 2021 10:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=PoXxJ6rCYENCYjaqJKYCLIHG4SOE/iIZm1bMCSVhqdY=;
 b=earv7H0ncNBsfe+b85EzFxM/kI9PL+2YuXwdc0DN/tqdX+ficH5fytqCQG709zrB9ozh
 OgQ3PkO+8fa/O2d3IzybKKGfAfmToiI1/vSZtv5r03kJjWvpfarIswHDm+U6U1ExPWi3
 yAitinBbjh01Q5Hh/PwkaQud4yVWHKthWt8++YrZ6GmMVrYlPOKCV2w2S5NpJ4xszVWZ
 b0SHyH2cOczwYnlQPpuAAqdELKL82fFRRd0IEI5ysTybbNDp1Ev0Licpdbvo/g8etC83
 otGqCisxKZcsr67lMU+XyyfU5QhXce2yzyWw81oGkxlK4j/WoisB+d1dKWblZyIvH/gz HA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 39gqwjrh9k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Jun 2021 10:00:39 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15UDuCCX181615; Wed, 30 Jun 2021 10:00:37 -0400
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
 by mx0b-00154901.pphosted.com with ESMTP id 39gm5r5jmx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Jun 2021 10:00:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXfvA+hZsy56CLAvtq83uM78ooxgi5rznaGexGZhNOI4LO+TlV0NwilglFTp8aDwXYepZ0IF7dyfzDEHm0+fkjB4tMf1Gn43l3/tKGdodIF2Tm7NQm+NkhmVW1R9V/QzcRlPHBrOVRqaF3jIrCOlpiJ9/kinmPIi9yVUTssar/ygLiNmAe5NwXQDApfjo52U/cESQIdOm9ULoDzWBuzytSUIKBS1r60TO9QT9CygnYpEE7mMGKZwgLi+l9E9Lhm6PaLQ9vvoUaW98R8V1kjWDGLZAheeY+QtoYosQgrSrGt2TNdhBdPfGZvzFchMzSWuRHdRK58kZlbZAIxyRCbAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoXxJ6rCYENCYjaqJKYCLIHG4SOE/iIZm1bMCSVhqdY=;
 b=Jpu3mJCQToELUTyQNjPafU4bCqFhTlYhP0ZT5CqzFw/22oPlwSsosgYspeH3lQqQ0RKytk2ft3CrCak+TPkY9pcjpiIcl7PMmsk7RftudLg3B5itITAgxEj8FPtejK6v9LOnSDk3xXNjvTGkVfQqKx8m+SfwqhEBH4zNNOiMgQ6gdzBx8W50hY/EkVY0xycYaNm732WBzj25KeF7hHWDMM0j+/Hrf4Rt/qvE3s4OXL7A9+mMKPlbtTedbt1te5R6r/ViDBlafOxcUguRBmUr8TGOy/v0/056HWmJhQpEaFzslgEZHQEL8lUpUaJhq2mIoP7Rv9Atc0b6lJ92BVA7gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from BYAPR19MB2935.namprd19.prod.outlook.com (2603:10b6:a03:b5::33)
 by SJ0PR19MB4557.namprd19.prod.outlook.com (2603:10b6:a03:283::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Wed, 30 Jun
 2021 14:00:33 +0000
Received: from BYAPR19MB2935.namprd19.prod.outlook.com
 ([fe80::d8f7:28d4:5df5:9738]) by BYAPR19MB2935.namprd19.prod.outlook.com
 ([fe80::d8f7:28d4:5df5:9738%3]) with mapi id 15.20.4264.027; Wed, 30 Jun 2021
 14:00:33 +0000
From: "Rao, Vinay" <Vinay.Rao@dell.com>
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
CC: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, "Belanger, Martin"
 <Martin.Belanger@dell.com>, "Hayes, Stuart" <Stuart.Hayes@dell.com>,
 "Tarikere, Madhu" <Madhu.Tarikere@dell.com>,
 Christoph Hellwig <hch@lst.de>, Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: RE: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Thread-Topic: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Thread-Index: AQHXPGuycJt9Bz7cOUOllIRgoPqYsqrMhECQgAC8igCAVhOKAIAJouww
Date: Wed, 30 Jun 2021 14:00:33 +0000
Message-ID: <BYAPR19MB2935A9169D186DD3C05979668F019@BYAPR19MB2935.namprd19.prod.outlook.com>
References: <BL0PR13MB429142FD8B9FCC57C2FE451D9C409@BL0PR13MB4291.namprd13.prod.outlook.com>
 <20210429063056.GA2482@lst.de>
 <SJ0PR19MB454499BF2899EF772B1EA11CF25F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <BYAPR04MB4965BD2AE65469C96CBF1354865F9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BYAPR19MB29351987D7ABBA3F28791D978F5E9@BYAPR19MB2935.namprd19.prod.outlook.com>
 <20210430162104.GA907317@dhcp-10-100-145-180.wdc.com>
 <097e56b6-2b13-e00c-ef84-509fa0e887ca@suse.de>
In-Reply-To: <097e56b6-2b13-e00c-ef84-509fa0e887ca@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=vinay.rao@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-06-30T14:00:31.0722834Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=11b360ce-9c0b-4b09-a502-bea4668c72f8;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=dell.com;
x-originating-ip: [2405:201:a003:d134:113b:8044:2a55:a9d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40f94c3e-9f74-4753-1816-08d93bcf6d7f
x-ms-traffictypediagnostic: SJ0PR19MB4557:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR19MB4557CE13697F3836402E6B9E8F019@SJ0PR19MB4557.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CuwY2PA10BUYNu4bMOXih/TsWSL0s6PX4GMMF5PGgA39w8oChZhRzZ8jamC5xaeMdFDVP+XHrxDGSp3rSLCIeW4Gq93dKZpdCTGUIpzBGqVPcwNIdKqQx10J0SJk19kilPnhkJt0rEcjocoFkkRMmCZl9PGzzvzvc9JfBYj+zJckXlVxWpxKHhtwbAIp5ZK3AtQxbeDFcQs2aMj9aAOkn1QIedkEOHM1B8cuBhvjUNDwTt7tS7EcnQ52bp8Y7s2SuxTS4Do3Mk/b/eti1IiMz3/GoOdjBhi56eMUr97/As1qL3m7+x/7p6NsEbwHOTkDjGUuOZda6UpJGpbLIXhqYTeRTJzginnwJVT7qBUGiic7tV6/zriIvbnBaOe333+840q88r81hLDSptAv8w8FNG35KZqn4VekhmCReUbEGqv0pxnHR4CpeU01/ZlAwdfNX4VQcvMTMNgkhzCPIHhFxIBwf4v99bhf/s3P1BKWrNgtM6PRl5oWP6yKLOPIfLD4GdLWIDlYj2nAMq6iA3SXN2Yi170iCl3WNr3hbD7AMNN+wYj7jN3/oEPSGgfSNYipnv+SVc/3/ZlIMUKWnAPOLD0nInLgkkOktYli0vj7CyZkEhuW5q/s3jz5vdUZ+Ck9oTF9lcVwtRJkqPN2jq3t7A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR19MB2935.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(478600001)(38100700002)(66946007)(316002)(8936002)(66574015)(2906002)(76116006)(4326008)(7696005)(122000001)(786003)(9686003)(54906003)(110136005)(71200400001)(52536014)(8676002)(83380400001)(186003)(86362001)(5660300002)(64756008)(66556008)(66446008)(6506007)(55016002)(33656002)(53546011)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGZ6Tk1RYm5iaTVaenhCb0g2dFRJeG1xcWwwZnhkS014d3NVN0lVR0Vsc3JV?=
 =?utf-8?B?RENxTWl0R0NiT0E0UmZqKzVtTjd6ZS9OOGhPTk1qQ1NJMHJHR25YQ0xoakli?=
 =?utf-8?B?RFVZb1hWUTFEcUM2SDd5eGR3ZWFJK1hXRS82bitMYlVwSU0wdjRQOGlZTGtP?=
 =?utf-8?B?NjdxelhZZCtzaW5sZWI2ZW5Xc2pvS2RyOExrcnJBZzN4RzhSZHhVdTBodVlI?=
 =?utf-8?B?NytvRnNmM0syTjUzWGp1aFBPUWhRb1FCVVdjVG9BT1psTXBkTnlLdXd2bVlj?=
 =?utf-8?B?eE5RZXJDWklKdmp0K0VGaGRocDljcG9TbHVxdmRtaS9WVXNtdjZzNTdaK3po?=
 =?utf-8?B?Z3RmV0RaWlR2bzZtRVk4a1AweitCcTIxQnpkUjdJanZsc0ZuMmE1cUdaaGFK?=
 =?utf-8?B?Y1V2WEI3UDA1QzdVcDBXQldVNTBVTXM1UEhuVnNXeFdqQ2RySG1NQU8xT3FQ?=
 =?utf-8?B?YVNhUGxoZUg1RXBLVTZYLzRDa1JiT1ZNeFptL1p2d2VrSU1FY25xbmZhbEdH?=
 =?utf-8?B?QzJsSnpiZTIxMGxET2hBTThrWXV0NGNEYUU2RXJVTSt0R21kR0xrV0YzT2dK?=
 =?utf-8?B?L3psd3lrd2ZNcWVlb1BFYm5UU1JhVFRjQlZONEZ6RGI5REQzMThvRmc2Wll1?=
 =?utf-8?B?QUxYSE8rMWMzNU5ETWVlQzE3NGNFZzRhYnBwSnRmVjBTVHJFU1EzUU5Nc1h3?=
 =?utf-8?B?YXdMcUQwZVRnbWxNTzRsWSswS0NlR0txOGZvdWdXT2RmNXNTWTVGNkxTbDlW?=
 =?utf-8?B?ODErUXF5NGRjNWJIOU0wVmY2OEZYUlN4KzE1ckplUmJQaGVxMGFSMVZxcklm?=
 =?utf-8?B?dHFDWk9OMlJuQitRd1dRelZ2bDRLbmVsSjZqYmJZd2hET2NEVWpGay9pSHh5?=
 =?utf-8?B?V29NSTd3cFNEdm0wL2NtVDFyUEg5amYvRUhPRCtYa2g0RHNyemZOR0I0TE5Z?=
 =?utf-8?B?eU9WZkVwZkJuZjZidU11aG9xc3puSGtuYlFDSVNya3pPZnNPSVc5Qy9JdHBT?=
 =?utf-8?B?ZHoyTjZXa3BNR2s2dWJLY3RIbldLWXh5cWJKWDhEWnFNZFc0dlJXTXpkalU2?=
 =?utf-8?B?VGNYQlJkMklZMmRLdVJwZjkrdGVoUE5lYWx5OVZZbzYrZnlsS2pBY1pERkpu?=
 =?utf-8?B?bVJhUk82aEZxb21pRlo2dDhGQzJpc3VoSit3WExTaHlDMGF1S0d1eWJFTG51?=
 =?utf-8?B?TGk5T1A1SGxHcG13dENRZ1dxa1lRcnI0d01MVkFjblJERG5TeUhGdTA2R09B?=
 =?utf-8?B?NGNtSEVyenM0WVlaaEQ1dTVJckRHYlBIUkR3YmNFRkNYV1VBclorZ0hwRkRR?=
 =?utf-8?B?THdqWkIwWE80Q1ZzOStOMHJKS3BiYlNXRlBxK0VibG0wcERSOVZkcklaNUUr?=
 =?utf-8?B?UFJmR0R0NFBPS0JSb0JLK3VNMU9KL1J0eWsxb01UQ0NTSkVzSXZuNjRVRElP?=
 =?utf-8?B?THR0R2lQdFlQaWZtYjAyVUowT0Q2UTNkLzBWcVpGRGN2VmtDUTh2WUVxMzFL?=
 =?utf-8?B?VEpxN2c1Q3hPNlVqTTVNa29QWnFWblVZTDNnWGhVOU9jTHErOWNiVGdsajl6?=
 =?utf-8?B?cnpnQkZKTnRLS2RyUVAva0ZRUy9IbTB0QnBVYmpubGJ5WnEzS2YwdHJXT3lE?=
 =?utf-8?B?WU5JYzdqN296TEFLRldzem96OEZNT09nYWRrYzRScU52Q2FsZkprWnllWjZY?=
 =?utf-8?B?QUhPNnNsS1JWbytac21uVFJKc01xWWNhT1FidktBNitNWU5tL0hVRkZhaGNq?=
 =?utf-8?B?c1hQd2xsbDAvTFRXc2MyZ3M3bWJlNG1KRWUwR2RRUS9IVExrU1oxbzNzYVVB?=
 =?utf-8?B?ck1WLzltZHVUNHRKR3BGNDN5UGsrUWJVV0huU1NndllWMUNOQ0E4SDlxcDBk?=
 =?utf-8?Q?CB9hNIIlYJMoL?=
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR19MB2935.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f94c3e-9f74-4753-1816-08d93bcf6d7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 14:00:33.0331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ryAQDFwPzzkK+G4wM5ucAiG/d1HOKmq4X0vvuPnxVm7WQ6b6LFPAVmvfD6actxVDn35CyyDLOHx2aS7uQ7RmUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4557
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-06-30_05:2021-06-29,
 2021-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 mlxlogscore=780 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1011 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106300083
X-Proofpoint-GUID: h44nY5OI_oRGQOXkPds_j9VFaIkgqo0_
X-Proofpoint-ORIG-GUID: h44nY5OI_oRGQOXkPds_j9VFaIkgqo0_
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=921
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300083
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210630_070048_207410_14B032EF 
X-CRM114-Status: GOOD (  26.84  )
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

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBIYW5uZXMgUmVpbmVja2UgPGhh
cmVAc3VzZS5kZT4gDQpTZW50OiBUaHVyc2RheSwgSnVuZSAyNCwgMjAyMSA0OjE5IFBNDQpUbzog
S2VpdGggQnVzY2g7IFJhbywgVmluYXkNCkNjOiBDaGFpdGFueWEgS3Vsa2Fybmk7IEJlbGFuZ2Vy
LCBNYXJ0aW47IEhheWVzLCBTdHVhcnQ7IFRhcmlrZXJlLCBNYWRodTsgQ2hyaXN0b3BoIEhlbGx3
aWc7IE1hcnRpbiBCZWxhbmdlcjsgbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnOyBheGJv
ZUBmYi5jb207IHNhZ2lAZ3JpbWJlcmcubWUNClN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8xXSBudm1l
LWZhYnJpY3M6IEdlbmVyYXRlIHVldmVudCBvbiBuYW1lc3BhY2UgQUVOcw0KDQoNCltFWFRFUk5B
TCBFTUFJTF0gDQoNCk9uIDQvMzAvMjEgNjoyMSBQTSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9u
IEZyaSwgQXByIDMwLCAyMDIxIGF0IDA1OjE0OjU1QU0gKzAwMDAsIFJhbywgVmluYXkgd3JvdGU6
DQo+PiArIE1hZGh1DQo+Pg0KPj4gSGkgQ2hhaXRhbnlhLA0KPj4NCj4+IFNvbWUgb2YgdGhlIEFF
TidzIGxpa2UgQU5BIHN0YXRlIGNoYW5nZSBhbmQgTmFtZSBTcGFjZSBhdHRyaWJ1dGUgY2hhbmdl
IGV2ZW50cyBhcmUgb2YgaW50ZXJlc3Qgb3V0c2lkZSB0aGUgTlZNRSBkcml2ZXIuIA0KPj4NCj4+
IEl0IHdvdWxkIGJlIGdvb2QgdG8gY29uc2lkZXIgdGhlc2UgZXZlbnRzIHRvIGJlIHByb3BhZ2F0
ZWQgdXAgdG8gdXNlciANCj4+IHNwYWNlLiBJIGFtIG5vdCB5ZXQgY29udmluY2VkIG9uIGhvdyBw
cm9wYWdhdGluZyB0aGlzIGFib3ZlIHRvIHVzZXIgc3BhY2UgaXMgcHJvYmxlbWF0aWMuDQo+IA0K
PiBUaGUgbmFtZXNwYWNlIGF0dHJpYnV0ZSBjaGFuZ2UgZXZlbnQgcGFpcnMgd2l0aCB0aGUgQ2hh
bmdlZCBOYW1lc3BhY2UgDQo+IExpc3QgbG9nLCBhbmQgcmVhZGluZyB0aGF0IGxvZyB3aWxsIGNo
YW5nZSB0aGUgcmVzdWx0IGZvciBhIHN1YnNlcXVlbnQgDQo+IHJlYWRlci4gVXNlciBzcGFjZSBy
YWNpbmcgd2l0aCB0aGUga2VybmVsIG9uIGEgbG9nIGFjY2VzcyB3aGVuIHRoZXJlIA0KPiBhcmUg
cmVhZCBzaWRlIGVmZmVjdHMgY3JlYXRlcyBub24tZGV0ZXJtaW5pc3RpYyBiZWhhdmlvciwgYW5k
IHRoYXQgaXMgDQo+IHByb2JsZW1hdGljLg0KPiANCkl0IHdvdWxkLCBpZiB3ZSB3ZXJlIHJlbHlp
bmcgb24gdGhlIENoYW5nZWQgTmFtZXNwYWNlIExpc3QgbG9nLg0KQnV0IGluIHRoZSBlbmQgd2Un
cmUganVzdCByZWFkaW5nIGl0IHRvIGNsZWFyIHRoZSBBRU4gZmxhZzsgdGhlIGNvbnRlbnRzIGFy
ZSBjb21wbGV0ZWx5IGltbWF0ZXJpYWwgdG8gdXMgYXMgd2UncmUgZG9pbmcgYSBmdWxsIG5hbWVz
cGFjZSBzY2FuIGFmdGVyd2FyZHMgYW55d2F5Lg0KU28gSSBkb24ndCB0aGluayB0aGF0IHRoYXQn
bGwgYmUgYSBwcm9ibGVtIGZvciB1cy4NCg0KV2hhdCB3aWxsIGJlIHByb2JsZW1hdGljLCB0aG91
Z2gsIGlzIGlmIHdlIHdlcmUgdG8gYWxsb3cgdXNlcnNwYWNlIHRvIHJlZ2lzdGVyIGFuIEFFTjsg
YXMgc29vbiBhcyB0aGUgY29udHJvbGxlciBhbGxvd3MgbW9yZSB0aGFuIG9uZSBwZW5kaW5nIEFF
UnMgdGhlcmUgbm90aGluZyBwcmV2ZW50aW5nIGl0IGZyb20gZG9pbmcgc28uDQpJZiBoZSBkb2Vz
IG91ciBpbnRlcm5hbCBzdGF0ZXMgd2lsbCBiZSBtZXNzZWQgdXAgYXMgd2UncmUgbm90IHJlY2Vp
dmluZyBhbGwgZXZlbnRzLiBJJ2QgcmF0aGVyIGVycm9yIG91dCBhbnkgYXR0ZW1wdCBoZXJlLCBi
dXQgdGhlbiB3ZSBjYW4ndCBkbyBhIGZ1bGwgcGFzc3Rocm91Z2gsIGFuZCBJIGd1ZXNzIHRoaW5n
cyBsaWtlIFNQREsgbWlnaHQgYmVjb21lIHVuaGFwcHkuDQo+IFdhbnRlZCB0byBjaGVjayBpZiB0
aGVyZSBpcyBhIHRpbWVsaW5lIGJ5IHdoZW4gd2UgY2FuIGV4cGVjdCB0aGUgQUVOJ3MgdG8gYmUg
cHJvcGFnYXRlZCB0byB1c2VyIHNwYWNlLiANCg0KDQpDaGVlcnMsDQoNCkhhbm5lcw0KLS0gDQpE
ci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdA0K
aGFyZUBzdXNlLmRlCQkJICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgNClNVU0Ug
U29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkgR21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8
cm5iZXJnIEhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR0Y6IEZlbGl4IEltZW5kw7ZyZmZlcg0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZt
ZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=
