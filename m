Return-Path: <SRS0=D26X=KB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96084C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 18:29:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B823B6101B
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 18:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B823B6101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QxWpkvS2/XvCOE6Ms1IX5eDwerOjLyJHsGiLxmbDDx4=; b=nJoZJBX4kXeyTzz9FYUTZvW+x
	8ovFsAcrCW5FZojXtvatpGkv312GVq3KBgek9dSZM+zvnQpK3gedqt5aZhqbbA2w5bc0Cad87CXtP
	U07h+CSaPDsye5CkVYzxCq1qJcv9xk5mVWn5hAKYUD1+JF+t/158mgeXKDo6qKZuSQlToAMMULzi5
	zschhzuvGiypaIvTg6jm4KiGS4OqLgY8Mci4NY8d5dyM5B5AOeoZ8dItkUOOJKekiUr3OVeOtH6Hf
	iutH/kp0PNUykrmVVZwqBG23Q7JASCJiG8nCcxjARi2BmwszZeyY1Jpmm0rZ9MHPBOD443agLDEAQ
	zLloS9Jiw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leijx-0052c8-Rp; Thu, 06 May 2021 18:28:49 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leiju-0052bf-0M
 for linux-nvme@desiato.infradead.org; Thu, 06 May 2021 18:28:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
 Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-Description;
 bh=hvTT45g9tZqjcujVyOPVSdSheqF/6pUAaDu74YIKo8c=; b=Dk60elViiNBRaUk6l7HQ0C9VZT
 2Rn+H3VxnnRTqry2I3bSaRg2D/oLeW97/K5tEq23aBYx2EDvRGx2BGue4ad08sFi9s0/Fu/uOkPFj
 PzqlO0Dl0RIFG2UVkqvzhGPeFrA2k7e04drEsuZlKBq+djhIexco2D8ROEIR1rtOEv8KQePpCqbBb
 5kKIGooa7Ukpqy0SdrWuAHhHW6XtnRCWY2QiqrEqdibIWMxyXXi0/mLsn76pCC9UfmvE9QAhnzJmM
 1vQahrNxH5jA5J5aydcIZJwDbWySEeeyIZf8TmspycbAzgYUoVPUOsLT9UlFMIFb5gQw9BmIrNNDX
 M3Hx/57g==;
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leijr-006HgB-39
 for linux-nvme@lists.infradead.org; Thu, 06 May 2021 18:28:44 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 146IKLpN169407;
 Thu, 6 May 2021 18:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=hvTT45g9tZqjcujVyOPVSdSheqF/6pUAaDu74YIKo8c=;
 b=j41HSOjTgOj+lnpkXr6w2SHyWU8WqA3F7Bxu0qQMXp75vLuI6p6hVidAnLWKnA5WoG7H
 jWUjj8S/CSCJAiPsD8UUNf7GKpIVzZc/NHKbwkHqC5WFN5XErt4Lp3OwL3LjvL17xGUT
 CBZDXGl9MEJ9kuwt47x6bqOL1tMHs3etHu3W8D+KitAhSnP/E+Uvx2c3/cWW177d6mQw
 sH5nT7Cs0tjoiWWmcWpFKHW/yA+3OBaT6AQWOMaChiR7jSp/uWH+LL8O03S371wRrLPg
 ZN0ngfvVHwQlj4p5pMpDObOfJuXdE5nptXDzIcia70jf5edndYfuz3dl2s8BSQ/1tc0c Jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 38bemjnwhw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 May 2021 18:27:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 146ILLXI101535;
 Thu, 6 May 2021 18:27:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
 by userp3030.oracle.com with ESMTP id 38bebvqt46-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 06 May 2021 18:27:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMbaFGZz4vam384/EbIE7Q6gp7UKoktV1TzALkBTv1A1qN567sKa2vMYETZ36L1QMBd7U48BWHB36tIxOoWLipUsDMEmdtadeIXmGc9e9eG9LtXt8/B3yYPIzUTlxL/bkmXMJOXq0C0sIZxqP0bYoF74QceI4VqRGpQaXP4czimt32yr9wtMojXG00idGsoATRwfRMrejXKc55Cw7UBrAlfqsmtDeefSDtp9p4YKManPo/d59Q0oF8qEfR2b9LLE6Gr7rXVLdV2+tU8LlzpbLww2qhm5IgyyqGbzCrwPgusdzRnOfrh9JxHYhYGN6TmX02XhP7ZMv+k9yjVRg2oIoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvTT45g9tZqjcujVyOPVSdSheqF/6pUAaDu74YIKo8c=;
 b=Ws6aMzfN0ahuNnAwqnzzhHOQ9tEiAnzwyfxnHId3ly+NEjdPXSObb0rcAUoh5zgsVo9aAVus8GqP0+nIspgUCwjScjsarVMkPYSM6knZ4HG0KUrZo2GP3jXNIg+V+yYlPgefM1YOoF1S9l+uC+B6Pm2o4LwJBIGjRfvtWn2TPsx/aE6RUTJPRpJ3NcgK4+TQQMO5545f9c5AfWkzYMQBpjw7seV8jK6NJzF/V7gbrSWaBkiKw9Qi0n/HJJPiVXB2+wHhK/Pkhh0sb6ywaHlYrd7719xsLjwL860t8l9fgIx1Ko32NjAcqc3JDRmBnMfPaZczbYblNM905+xue5bzZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvTT45g9tZqjcujVyOPVSdSheqF/6pUAaDu74YIKo8c=;
 b=HDR/BVaQWNBCK+wkfSxDQohqfEJJkgptIHsimhDmycp6zzdi0ULm7/0ptqqqAvjeyn0DbYUFw5uFZTzGh+M8P6E4xodALkg/g/y2oRJx6tho1dlktZ30qBZYD8tIJQaxd3jYqhBOOGrELT+N9btj8GCv727a3JZJOgccrjm5EZg=
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BY5PR10MB4227.namprd10.prod.outlook.com (2603:10b6:a03:208::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 18:27:50 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::50bb:7b66:35ee:4a4%7]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 18:27:50 +0000
From: Michael Christie <michael.christie@oracle.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "Belanger, Martin" <Martin.Belanger@dell.com>, Hannes Reinecke
 <hare@suse.de>, Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 1/1] Add 'Transport Interface' (triface) option. This can
 be used to specify the IP interface to use for the connection. The
 driver
 uses that to set SO_BINDTODEVICE on the socket before connecting.
Thread-Topic: [PATCH 1/1] Add 'Transport Interface' (triface) option. This can
 be used to specify the IP interface to use for the connection.
 The driver
 uses that to set SO_BINDTODEVICE on the socket before connecting.
Thread-Index: AQHXMi7iXUsEQ8I2O0aPQOLx1K5rTarT2uGAgADXPgCAAGAzAIAAZNaAgAFvg4A=
Date: Thu, 6 May 2021 18:27:50 +0000
Message-ID: <BA06FEFB-DDD4-46FE-824B-4EA2100CDAC4@oracle.com>
References: <20210415192848.962891-1-nitram_67@hotmail.com>
 <BL0PR13MB42917AC33BFFC7DB2440D1149C4D9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <b47456a5-69ae-1f33-30f0-aa25906668f2@grimberg.me>
 <27a0071d-7c7b-ee5b-41a2-d5eb8de12928@suse.de>
 <SJ0PR19MB45446577ACEA270069ADB738F2599@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <4a5680c2-9a6c-377b-2666-cbc1fe105cb5@grimberg.me>
In-Reply-To: <4a5680c2-9a6c-377b-2666-cbc1fe105cb5@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.6)
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [73.88.28.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 728fb3e2-b5c0-43df-d579-08d910bca7e9
x-ms-traffictypediagnostic: BY5PR10MB4227:
x-microsoft-antispam-prvs: <BY5PR10MB42278ED871BEDB8541BF8F01F1589@BY5PR10MB4227.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i0Jo5pEqK9wmaprZcq1jVus4J60+uXUM7u7Agf015bQDAgerJVjGT7VS/pcO4n75wTOMI2K5TLtjhEyG08KudqyHCawOx9y1FptdytPxRlTKE1mWbGSLq0QutBd34wI9Q4gCUsDkw94agF8HFqAkRzxCXZMO0S4HJBlLZFdOsYhYE1K8QWNN9e7uYJ7vNh7VzcOIlOnpMFSQv3Vz6M/eyNidUusiJQbx0KVQN1l9UztiLf450mMs2N/yGdj2oSTaW8hOWs4C/84Ox8vs+cJnSZ1TwvQDJK70PyWB0NnIcsOVgLdggKilVf4d5p9yAeqNxI1ZnDh+x+LHOMxuBOS3REOBdOBsW2Ab3gsJ7j9ksNgxUHVO1Psj8gospgNC0V4xypa24efTPS9W9oeJ53i65ROe6kBIkvVvry+anveUxJaKUkCCpPvHptc/xs2N2wzKkUOh0I3dw38rHGQLGJUjZ+4jBrDbIQW3QcmYhvjOP1uIZwpsoj+FKbf/keYuj5yWNG0D3mLjlAsJXtQpWjlud1eJOOclUhYu4SVt4MAdfFFb8j4/sn+5J3QLZ058dRfpsJ1EAwkfuTfVRVSpCFzUvZ+V2pDqSMpGz6OnidOqprj/6ZBtMCvZuYqikLMdcJTSxgleolVU7MdcsEI5zppQqK2w8S9xu97SdJ0W3PFINLA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB3573.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(376002)(396003)(136003)(39860400002)(346002)(186003)(8676002)(6506007)(26005)(66556008)(91956017)(38100700002)(71200400001)(36756003)(6512007)(53546011)(2616005)(66476007)(122000001)(54906003)(2906002)(33656002)(316002)(4326008)(66446008)(64756008)(86362001)(8936002)(66946007)(66574015)(5660300002)(6486002)(44832011)(478600001)(6916009)(76116006)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?WGdDNDFHVmc4bEFqbjlSb1lpVVFTWXNIVE9RUDA4UVRmZjZqd1lUTjNMMVVw?=
 =?utf-8?B?UUhDMHVPbW5uWlpIMkdhMVNIcnVldzZZMlp6UW5kUjJLKzNGZ214WWpPeEJw?=
 =?utf-8?B?TFQvUWF6NUs1dlBnb0dQVkhFNkgvZ3c0Q2lNcjFuMG1mNERDeS9HYmxkUzB2?=
 =?utf-8?B?TktMQVZHYjV1d244dFp6MGp1Y211Q01qTkdpdGI4N1pibjNERGd2QmVlMzAr?=
 =?utf-8?B?ZFZXSTJ2RGxYTWpGYjJoWEZLQXVJcSttOU1IODNkS1lCS0drbndrQjduZzNl?=
 =?utf-8?B?RXl4OHNERVM0NTMvMEhJSmxiemZDVTFuT2R0TGlDenFqakJ0V2FQUXMvUHg0?=
 =?utf-8?B?QTVUY3RMN2VmbUNTTHRiNm9tQ3UvY1NDbkxsaGhNSCtyTEkyNjNqdVVyNkx1?=
 =?utf-8?B?SFBSdTlJYWpHN1Z1RTBoTUROdmlOZnVoWGNVdXlCKzVnZVEyNDNxMGlJc205?=
 =?utf-8?B?QTU4SWhHS1hvK0tUMUJqSzJ5bXluOWFHa3NleS9VMDNjdUVsOHhMWmRUdGJR?=
 =?utf-8?B?MDY2NFRZN2hUbmJVbUladUFyelF1U2lnRGl1enlRWkt4UlRHS1l6cFZQNGph?=
 =?utf-8?B?V0FrM2ZJcFNXdkpySytrNlBRUzdqUEhXdWlyREExT0FFOVJ5R3c3RVFOdk5Z?=
 =?utf-8?B?RC9WcWtVT1c3eDJ2TUZBNlZHVmcvQjdLbTNsa28vVjJSY1Z2RzZQMmpmNXpl?=
 =?utf-8?B?bUYxd0k0dG03YlNUQ3pwMW8vM1YyQ2pZdk4valhTQXFiZXM2N3FsVUVVTXRp?=
 =?utf-8?B?UGp5dG9meDVzYXVTeTMyTk1ySUUrUnhPMkNSdEtwcWVNVUFVV1I3U2Jla1Iv?=
 =?utf-8?B?cEJ1bUhTYms0YXRRaytIYmlPRjNmbTVzbGJXb3drZU56VkxPVytRWHNXWmhm?=
 =?utf-8?B?ZGpITThWTFZwN3VETk95TUVTWHRaV2hlN3V2SnJCYUJTa05oQzV6MVpFSHBa?=
 =?utf-8?B?OG84VnpBK2Y5aTROUlhCWWRXQzhaSkFNcFdJcFE4dURMK3o3UlQ5TkZPdVY4?=
 =?utf-8?B?SlF1Z09tdVhmUHRrVis3SHV0NWp0OXVLSnNNL3lNNjJCN0d0R1pSN1V6WWxn?=
 =?utf-8?B?eTFSYUpoUmplS05kazQzREtUUUlTbEgyRllyWGJlQnNqMGllMGNVNUpxYi9N?=
 =?utf-8?B?cDRGOUtRK2cyanFvTTJBOE44MTQ1RGI1VGFIWXYyc2dFMmxIRW1ZckNXcW1X?=
 =?utf-8?B?UzVCWkV5QnNZZEIzUFh6RSszNFlHdHU2NTR4VzdUU3FySDBjQnlJc0JCenhI?=
 =?utf-8?B?UXhncVd2bjFJbjc1MVR5R0s5ZjEyNUh4ZzIwMllwQlNXcDB2czFOZHRoSjU0?=
 =?utf-8?B?d1VNcW1QUERLT0phdE1uK3lXZU1VdEF5RFpWb1huOGp3TW9ES0Ntcnc3Zkc3?=
 =?utf-8?B?NitUY0htVzNFY3BtUzZ3dHVIaHJ5a21iNGFVdXZQbVgvc2pjV09lbE1sdFVx?=
 =?utf-8?B?WjIvbk1tV1lIcmxxR2N2Mk43ZkZ6cVA2S3ZPODN1bGNjT1cxTW5HOVZQY0l6?=
 =?utf-8?B?QVVQR2x6blpPVUZUSjNCcmJTUmFub3JBakZGWFgxT1diaVJBYkp5THE3YldL?=
 =?utf-8?B?TXQxc2F4RkdiZ1VRVlRjL2U2cnB1ajg0TG5ZT0orZGdVNTc3OUJXLys5M0lU?=
 =?utf-8?B?RzRxZ2lBSnowQUNodXVKMGxlVTYycFJZajJ5Q2NhUlNjTzBCVWtoWEFCVGk1?=
 =?utf-8?B?dGk2aGMrYVhxZm11aWJLZ2xQRUx4YXNSYjBoSFJpWHN3RVJ4VXdiOGlVUHI2?=
 =?utf-8?Q?+cwB9d29t6yTmtwQaawYu3cQzT+H3dCJiEnTtie?=
x-ms-exchange-transport-forked: True
Content-ID: <AA674E951228E244A32975146AD8EB1B@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 728fb3e2-b5c0-43df-d579-08d910bca7e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2021 18:27:50.5742 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dSGdeQW/LdCePHlqgM2I6Co8YWHzWhUb6erdRvDBcg4PVruDgPy/oBXfIUiYG+0lsceVcF/GhGRBCcDbfAfI5Bm6AMz0bTdI0HDLHN+7/0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4227
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9976
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060127
X-Proofpoint-ORIG-GUID: rqqbpcI6BhAoPFQhvsW7LrNtcWZEefk5
X-Proofpoint-GUID: rqqbpcI6BhAoPFQhvsW7LrNtcWZEefk5
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9976
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 adultscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060127
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210506_112843_314890_51847A72 
X-CRM114-Status: GOOD (  31.38  )
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

DQoNCj4gT24gTWF5IDUsIDIwMjEsIGF0IDM6MzIgUE0sIFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3Jp
bWJlcmcubWU+IHdyb3RlOg0KPiANCj4gDQo+Pj4+IEdpdmVuIHRoYXQgdGhpcyB3YXMgdGhlIG9y
aWdpbmFsIGludGVudCBmb3IgaG9zdF90cmFkZHIsIHdoeSBub3QgaGF2ZQ0KPj4+PiBob3N0X3Ry
YWRkciByZXNvbHZlIHRoZSBpZmFjZSBmcm9tIHRoZSBhZGRyZXNzIGFuZCBzZXQgc29ja29wdA0K
Pj4+PiBTT19CSU5EVE9ERVZJQ0Ugb24gaXQ/DQo+Pj4+IA0KPj4+IFRoYXQgd2FzIG15IHF1ZXN0
aW9uLCB0b28uDQo+Pj4gDQo+Pj4gSSB3b3VsZCB2YXN0bHkgcHJlZmVyIHRvIG5vdCBoYXZlIGFu
b3RoZXIgb3B0aW9uIHRvIGRlYWwgd2l0aCAoYXMgaXQgcmFpc2VzIHRoZQ0KPj4+IHF1ZXN0aW9u
IHdoZXRoZXIgdG8gYWRkIGl0IGVnIGR1cmluZyAnbnZtZSBjb25uZWN0LWFsbCcpIEFuZCBvbmUg
Y291bGQNCj4+PiBhcmd1ZSB0aGF0IHRoaXMgd2FzIHRoZSBpbnRlbnRpb24gb2YgX2hhdmluZ18g
dGhlIGhvc3RfdHJhZGRyIGFyZ3VtZW50IGluDQo+Pj4gdGhlIGZpcnN0IHBsYWNlIC4uLg0KPj4+
IA0KPj4+IENoZWVycywNCj4+PiANCj4+PiBIYW5uZXMNCj4+PiAtLQ0KPj4+IERyLiBIYW5uZXMg
UmVpbmVja2UJCSAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0DQo+Pj4gaGFyZUBzdXNl
LmRlCQkJICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgNCj4+PiBTVVNFIFNvZnR3YXJl
IFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIDkwNDA5IE7DvHJuYmVyZw0KPj4+IEdGOiBGLiBJbWVu
ZMO2cmZmZXIsIEhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKQ0KPj4gSGkgU2FnaSBhbmQgSGFubmVz
LA0KPj4gQ29ycmVjdCBtZSBpZiBJJ20gd3JvbmcsIGJ1dCBpdCBzb3VuZHMgbGlrZSBob3N0X3Ry
YWRkciB3YXMgcHJpbWFyaWx5IGFkZGVkIGZvciBGQyAoYXQgbGVhc3QgaXQgd2Fzbid0IHRlc3Rl
ZCBmb3IgVENQIHNpbmNlIGl0IGRvZXMgbm90IHdvcmsgaW4gaXRzIGN1cnJlbnQgc3RhdGUpLiBJ
J20gbm90IGFuIGV4cGVydCBvbiBGQyBhbmQgbWF5YmUgc3BlY2lmeWluZyBhbiBhZGRyZXNzIGlz
IHRoZSByaWdodCAoYW5kIG9ubHkpIHdheSB0byBzcGVjaWZ5IGFuZCBpbnRlcmZhY2UgZm9yIEZD
LiBGb3IgVENQLCBob3dldmVyLCBpdCdzIG5vdCBhZHZpc2FibGUuIFNwZWNpZnlpbmcgYW4gaW50
ZXJmYWNlIGJ5IGl0cyBhc3NvY2lhdGVkIElQIGFkZHJlc3MgaXMgbGVzcyBpbnR1aXRpdmUgdGhh
biBzcGVjaWZ5aW5nIHRoZSBhY3R1YWwgaW50ZXJmYWNlIG5hbWUgYW5kLCBpbiBzb21lIGNhc2Vz
LCBpdCBzaW1wbHkgd29uJ3Qgd29yay4gVGhhdCdzIGJlY2F1c2UgdGhlIGFzc29jaWF0aW9uIGJl
dHdlZW4gaW50ZXJmYWNlcyBhbmQgSVAgYWRkcmVzc2VzIGlzIG5vdCBwcmVkaWN0YWJsZS4gSVAg
YWRkcmVzc2VzIGNhbiBiZSBjaGFuZ2VkIG9yIGNhbiBjaGFuZ2UgYnkgdGhlbXNlbHZlcyBvdmVy
IHRpbWUgKGUuZy4gREhDUCkuIEludGVyZmFjZSBuYW1lcyBhcmUgcHJlZGljdGFibGUgWzFdIGFu
ZCB3aWxsIHBlcnNpc3Qgb3ZlciB0aW1lLiBDb25zaWRlciB0aGUgZm9sbG93aW5nIGNvbmZpZ3Vy
YXRpb24uDQo+PiAxOiBsbzogPExPT1BCQUNLLFVQLExPV0VSX1VQPiBtdHUgNjU1MzYgcWRpc2Mg
bm9xdWV1ZSBzdGF0ZSBVTktOT1dOIGdyb3VwIGRlZmF1bHQgcWxlbiAxMDAwDQo+PiAgICAgbGlu
ay9sb29wYmFjayAwMDowMDowMDowMDowMDowMCBicmQgMDA6MDA6MDA6MDA6MDA6MDANCj4+ICAg
ICBpbmV0IDEwMC4wLjAuMTAwLzI0IHNjb3BlIGdsb2JhbCBsbw0KPj4gICAgICAgIHZhbGlkX2xm
dCBmb3JldmVyIHByZWZlcnJlZF9sZnQgZm9yZXZlcg0KPj4gMjogZW5wMHMzOiA8QlJPQURDQVNU
LE1VTFRJQ0FTVCxVUCxMT1dFUl9VUD4gbXR1IDE1MDAgcWRpc2MgZnFfY29kZWwgc3RhdGUgVVAg
Z3JvdXAgZGVmYXVsdCBxbGVuIDEwMDANCj4+ICAgICBsaW5rL2V0aGVyIDA4OjAwOjI3OjIxOjY1
OmVjIGJyZCBmZjpmZjpmZjpmZjpmZjpmZg0KPj4gICAgIGluZXQgMTAwLjAuMC4xMDAvMjQgc2Nv
cGUgZ2xvYmFsIGVucDBzMw0KPj4gICAgICAgIHZhbGlkX2xmdCBmb3JldmVyIHByZWZlcnJlZF9s
ZnQgZm9yZXZlcg0KPj4gMzogZW5wMHM4OiA8QlJPQURDQVNULE1VTFRJQ0FTVCxVUCxMT1dFUl9V
UD4gbXR1IDE1MDAgcWRpc2MgZnFfY29kZWwgc3RhdGUgVVAgZ3JvdXAgZGVmYXVsdCBxbGVuIDEw
MDANCj4+ICAgICBsaW5rL2V0aGVyIDA4OjAwOjI3OjRmOjk1OjVjIGJyZCBmZjpmZjpmZjpmZjpm
ZjpmZg0KPj4gICAgIGluZXQgMTAwLjAuMC4xMDAvMjQgc2NvcGUgZ2xvYmFsIGVucDBzOA0KPj4g
ICAgICAgIHZhbGlkX2xmdCBmb3JldmVyIHByZWZlcnJlZF9sZnQgZm9yZXZlcg0KPj4gVGhlIGFi
b3ZlIGlzIGEgVk0gdGhhdCBJIGNvbmZpZ3VyZWQgd2l0aCB0aGUgc2FtZSBJUCBhZGRyZXNzICgx
MDAuMC4wLjEwMCkgb24gYWxsIGludGVyZmFjZXMuIERvaW5nIGEgcmV2ZXJzZSBsb29rdXAgdG8g
aWRlbnRpZnkgdGhlIHVuaXF1ZSBpbnRlcmZhY2UgYXNzb2NpYXRlZCB3aXRoIDEwMC4wLjAuMTAw
IHdvdWxkIHNpbXBseSBub3Qgd29yayBoZXJlLiBBbmQgdGhpcyBpcyB3aHkgdGhlIG9wdGlvbiBo
b3N0X2lmYWNlIGlzIHJlcXVpcmVkLiBJIHVuZGVyc3RhbmQgdGhhdCB0aGUgYWJvdmUgY29uZmln
IGRvZXMgbm90IHJlcHJlc2VudCBhIHN0YW5kYXJkIGhvc3Qgc3lzdGVtLCBidXQgSSdtIHVzaW5n
IHRoaXMgdG8gcHJvdmUgYSBwb2ludDogIndlIGNhbiBuZXZlciBrbm93IGhvdyBhIHVzZXIgd2ls
bCBjb25maWd1cmUgdGhlaXIgc3lzdGVtIGFuZCB0aGUgYWJvdmUgY29uZmlndXJhdGlvbiBpcyBw
ZXJmZWN0bHkgZmluZSBieSBMaW51eCIuDQo+IA0KPiBJcyB0aGlzIGEgY29tbW9uIHNldHRpbmc/
IEknZCBzYXkgdGhhdCB3ZSBzaG91bGQgcHJvYmFibHkgc2VlIGEgcmVhbA0KPiBsaWZlIG5lZWQg
Zm9yIGl0IGJlZm9yZSBhZGRpbmcgYSB1c2VyIGludGVyZmFjZSBmb3IgaXQuDQoNCkZvciBpc2Nz
aSwgcGVvcGxlIHVzZWQgU09fQklORFRPREVWSUNFIGJlY2F1c2UgZm9yIHdoYXR2ZXIgcmVhc29u
IHRoZXkNCnJlYWxseSBsaWtlIHB1dHRpbmcgbXVsdGlwbGUgaW50ZXJmYWNlcyBvbiB0aGUgc2Ft
ZSBzdWJuZXQuIFRoZXkNCndvdWxkIHRoZW4gd2FudCB0byBoYXZlIGNvbm5lY3Rpb24xIHVzZSBl
bnAwczAgYW5kIGNvbm5lY3Rpb24yIHVzZSBlbnAwczEsDQpldGMuDQoNCkkgY2Fu4oCZdCByZW1l
bWJlciB3aHkgKGl0IGNvdWxkIGJlIGEgYnVnIG9yIG1heWJlIHRoZSB1c2VyIGNhbuKAmXQgY29u
ZmlnIHRoZQ0Kcm91dGluZyB0YWJsZSkgYnV0IGp1c3QgZG9pbmcgYSBiaW5kKCkgd2lsbCBzb21l
dGltZXMgbm90IHdvcmsNCmJlY2F1c2UgcGFja2V0cyB3aWxsIGNvbWUgaW4gb24gZW5wMHMwIGJ1
dCB3aGVuIHlvdSBkbyBhIHNlbmQoKSBpdCB3b3VsZA0KZ28gb3V0IG9uIGVucDBzLiBCdXQgZW5w
MHMxIG1pZ2h0IGJlIGNvbm5lY3RlZCBpbiB3YXkgaXQgY2FuIG9ubHkgcmVhY2gNCmNlcnRhaW4g
dGFyZ2V0IHBvcnRzLiBUaGUgdGFyZ2V0IHdvdWxkIHRoZW4gbm90IHNlZSB0aGUgcmVzcG9uc2Uu
DQoNCg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==
