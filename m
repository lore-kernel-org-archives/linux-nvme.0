Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815B4C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 18:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jM7FB+sksR7ubo/keI1t+yqCSInGGT1ls9UkTn5ksdE=; b=dnfMIf3sUybUaOy1F25sfVxAHs
	IqLsc6/NM5bIXo/mYIfthP0Gxi9AwMcjMRAgzXsiCOte/9wUhMdJXYoVe76G0ESAmLjwya0y20rJs
	ziptxssNpdLlhDPaB2vS00JOIo4tjJ1pKYt1NXrTeRV14SNuwhDud7vftHQwv+wBrPOPnn5URl1Z2
	yq89Ne51O+sRhHmks5zSF+h86yJOGAHfOHmjk9hrZ2HDRda66sJuZDX0ah3kOQk/hpxZvPDtnmcB8
	4gCkZxk0lrnldgrhhyEssCTp8YPNtaV5bWOqJCL5sqrUWF0RR7i5N3R7g/3aBWGfFz2GXIlBJ1Ua6
	Zp8DEH7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3ipV-006kQx-D1; Tue, 21 Jun 2022 18:42:25 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3ipQ-006kG1-HZ
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 18:42:23 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LFktAX004714;
	Tue, 21 Jun 2022 18:40:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jM7FB+sksR7ubo/keI1t+yqCSInGGT1ls9UkTn5ksdE=;
 b=emKR4EuZM3YS07r/exv5gN9w56k/q9zZY5dsEVlK1ADvxNhul4lZALJXHBpbc0FDX6N0
 tDyUvgrbv9qWLDWgESIH6Hq8UkLCCX8NvFEZDF9yItRykZ90LJZMlhUxApmRmN2IGXka
 gHJ/fn0yBmFMGIMOfMzYQjkjKCUb6hkAO30RigN/M3KZsIYguWq9j5wkvICcCJzN/Hyl
 PIvX6/Am/XCNibALROliBRXdPnz+ruGDn8rwgVOyqTP+u6b3F3JXJ6vVxRsHB81w0hvm
 3jv5tygmmtKDlA1KX2cTdpgNa2qEZ8Zee316wBnIWc30msOwqC56rs+clTkcO5axOKac Zg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54cpcqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jun 2022 18:40:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LIaaCV032901;
	Tue, 21 Jun 2022 18:40:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtg3vg0ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jun 2022 18:40:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lwe4k5fek5Q7NOuMp5OedC9k2Ih+76VRy96ydAJ3Vdme/7Dezo5G2OMi3U41DSPSyioksqloUbbQ1u2IecLglgM6l1evGn4h2OgF07E6cJLUTky0AJAZFZ1m9EIqPI7Sg2K2zDn8SZogYIkVo+xarC1puu50vEyqSUsOlib1uBqAylX9SNxS2zECb23a+jMwVUkHwBRRIqkm8seI+CVjzZlxBdHK5GwUyoxOhNTHA4NaCJnjRIM95DOY+aV5FwGhuPdIGTmvpWb90MiBWfnF4D74Dap+Rx2XcTA0C+YYMhsH3iiUlaoteK14mRDbPuVu/Me1h8m+5XMFpNJ7rUk2hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jM7FB+sksR7ubo/keI1t+yqCSInGGT1ls9UkTn5ksdE=;
 b=bzT1b0pCoW+LlfjMvtcXYfm8qQTopqX2g3lz/f2xqlPqcgFVqFUNC6RvQkcDJPsy8HX9P0h9qRsTUiVr8fVuePGMQUL6/w25zmU++AJSFWR74R955AioSneHJYn97KjjkMg7jR0EZzvDAP0ZR+IGe1fgGC2Cp8iQp1LcLXrOm384qKoZ79Iw7Zij1vX6K4RU0bORJjTOGAt7jgRjIGpcgV7MZRYxKGJAyqkZALYmvE3gNx0jbqK3FhHhAp60RiraLX3rDftJGIWXGesfzj+IvAi4RP1Bxu7RS6jXTm3dU68gKYMxur0BJj798ZYKwkuFhxNaWdsh7bFMYKzfTQC2Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jM7FB+sksR7ubo/keI1t+yqCSInGGT1ls9UkTn5ksdE=;
 b=pc28DYsxpWkrBnhWZy5vsJFdGrC37AUnSsxZSHljJoz/i9aMc/sQbHGFd74qUhvq1/iBMg5MoU87d1iFNt4KHckwvx/tU5q3GQ+XlBCuMlZ9bWur9XVSyOAwmXCF1txaPEl7t6vtxbROe2wdr2mZWUZ9l9mcmt7PkLVuu82cFP4=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by BYAPR10MB3605.namprd10.prod.outlook.com (2603:10b6:a03:129::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 18:40:50 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::5064:d3d3:558f:63b6]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::5064:d3d3:558f:63b6%4]) with mapi id 15.20.5353.021; Tue, 21 Jun 2022
 18:40:50 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
        Klaus Jensen <its@irrelevant.dk>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Thread-Topic: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Thread-Index:  AQHYKbXc39T2BoiygkiETee4KuxaGazldeqAgABJzICAAB64AIAAlJYAgAAa2oCAA+JBgIAADcuAgAwnQ4CAAhongIBKtzYAgAJPjACAAKy4gIAADwUAgACTr4CAAVjIAIAA5nIAgAhBGoCAAmhFAIAG61AA
Date: Tue, 21 Jun 2022 18:40:49 +0000
Message-ID: <572E6BCA-2B80-46BB-9FBE-F6AA3D7C8FAC@oracle.com>
References: <C85067CB-3909-4B62-A86D-467827EBF96E@oracle.com>
 <20220420073641.GA6859@lst.de>
 <26796ED5-859F-4844-B1D1-7C2FF5126E40@oracle.com>
 <20220608075252.GB13027@lst.de>
 <F8EC1673-8434-4294-ADAF-96238E65A7AE@oracle.com>
 <YqDy0BIgLbAVRw2u@kbusch-mbp.dhcp.thefacebook.com>
 <20220609035323.GA31248@lst.de>
 <6ACB62F8-BFC4-45A3-9886-E05DB45248D5@oracle.com>
 <YqNRPEpZgT8Xn9Nr@kbusch-mbp.dhcp.thefacebook.com>
 <B396ED69-5559-40F0-92F3-8B319D90584C@oracle.com>
 <20220617090100.GA7767@lst.de>
In-Reply-To: <20220617090100.GA7767@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a4ff329-194c-4cb8-7aac-08da53b59033
x-ms-traffictypediagnostic: BYAPR10MB3605:EE_
x-microsoft-antispam-prvs:  <BYAPR10MB3605C5A8770414F809CEFD44F4B39@BYAPR10MB3605.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  HH5lj1Amp2c6sl/zISIK6HAZ10YXs5Wn9cq/EiEJeaARTcVy/V4EWFpllYqVja00C345rka2jgHLdRt8GQUhog47KphHXmGEqD8zbyK229LfnV1EBr+JyW1wN/j44JeQN7MD96oAzE6oyycgv68OquvgEiBnvojDg9042G5EFYYfsHs+afIMdp7FRUL35iPXZsmDzhtifWWisJv2cSOp0FklfC410yP2wG3krYS22BGPDQ/RBP9VxriLrUw8ggWxcyKDEOAwQIjouYCR+opedkDuPKWoArw1fq1V/Qsj/3dBOipe3UEw8AAHe3DmI3zzIcO8wTT8lrMlyiHicEdOy1si+Sv7RhWgYsQsr8paOYXERwmuanlNU7vCGmz08HBINn8vSw3jENB9QTefwwvFjemHsH/NlVV1H0P+R5OZiPn8JorXtYXr+186EAfGyWkVHSOWm82TSK8Lmro4H3T42U7rVYxjP6rhvtIjEs0EPz5mVmgq2ZSAq6iY5h9RE9WHFSyXrsAI1X+dQDc/w6iHeJteYa4vFqoJEwPCOPdDspmZBoijdzMpdJsEXVbArJ5Y5AvPxotSnjpei3ihKmbOqPBMNjGY0CsSYVAGTfNydvplmTGsM6QOw/+HFZcBHPgu7Skrw+AeAAeqKQClIqi50vBOePG2hV4mRL3oVqNy8Pd75+kZNYXa6SQVmu9ozc/rulddro24Yvl4UGggIjMga9furIUWSDmUcphHwssKE/NXWt0S8T/jguRMIyawv4tn
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(346002)(376002)(366004)(39860400002)(136003)(6512007)(41300700001)(53546011)(2616005)(44832011)(8936002)(36756003)(33656002)(38100700002)(5660300002)(2906002)(6506007)(8676002)(66946007)(83380400001)(66446008)(86362001)(6486002)(38070700005)(64756008)(4326008)(122000001)(76116006)(478600001)(186003)(66556008)(66476007)(6916009)(54906003)(71200400001)(316002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?NHR1SnhYRlEyNjB3bzJXTzQ3QmxjMkNZY1pKRlZoZFFQcVY4YWQxWWt1R0Zh?=
 =?utf-8?B?a2NOSmZ3cWtjRUoybThMVC92YmhZNHVXdHA1eUI1bG90NHZ6ek5CR0VNREhX?=
 =?utf-8?B?YUlORGNwdmU3eTV6VU1SdHZVck1LZlRBY0h5K2pBSmtlbFR2bjJnUE1oSjls?=
 =?utf-8?B?NHJKQVlrNHUvYldJVjNNd0FOa1ZhKzdQMndTM2lORTdGS0treEtYcldCSUZz?=
 =?utf-8?B?SzQreTBiRjlZODZPN3hyTFN2Q3MxSmRxemZ2eE1pMGNvMzl2OVVDZTF4OFZp?=
 =?utf-8?B?cnB5R2hvdWExWEVBUWxRdlh1QkxEUGNZUldQU1Q3NnZHOEtDbjhxY2JJZXh0?=
 =?utf-8?B?RlNvNGNxQ3VpY3VEMFdXQlJiR1VzM1k1RjRhdTNYWjB3WnhVNFNJM0cyUnN1?=
 =?utf-8?B?aVJyUVFzV1hmeStvMXNUWVhRS1JYVEdkWmp0VEhTcnJQRlN3SXV3b1h2MnBG?=
 =?utf-8?B?Y3BUVnJOYkdvUnhBdnFtNlJhMjFJNWxVWEZjaWZhK0plQnd6R2RseXl4TGJr?=
 =?utf-8?B?LzltamNMQVp4b3kwcDEySnhYMFlQczBpektVUkc4YnZCdlp6QWJVNC9IMFpH?=
 =?utf-8?B?T1YweDBpSnd4N2dPZHNMdkxiZ0dqOFVueDFRL1RoZ0VxQW1Rd1RHNmZpSkVa?=
 =?utf-8?B?bWNleGNUMVI2SlpQcVNFSVcybUJqT2FhcVlkNkFXMGJDUFZGTm9MWlBWUlJ4?=
 =?utf-8?B?T0Z6UDdKRU1vTVlqYjR6b3VTd1pLbEVsSENoQ1ZHc3hUdDBXemdncXMxRldS?=
 =?utf-8?B?N1JDcnA1dktFUitYQjdoSGJOM2p2YXFrdjdDcHZhTmVrcFNKTGYwU0VPWHcz?=
 =?utf-8?B?RGhWNW9hbWx3OUwvclBNOW4za1gyZHZ0N20ySXhCZFlpM0JkTnh2WTBhRGl2?=
 =?utf-8?B?TWY2ZWVSZXVkcVBFeVZVREt2cGc1T0d4enlVd1lhemlBbEZrSHhxVTM5ZVBI?=
 =?utf-8?B?aXJ6b0dTa0xpSkJGK0ZkWXBBWldVNFl3d2V1VzhVeFNLMzJCOGVtY1NUUmV5?=
 =?utf-8?B?S011UzFWNFBEYlFZc3ZjWlk5VHQzZWRBR1ZjYStiRVdCTXZCclp2Tnc2UG5W?=
 =?utf-8?B?YXpsRWJIV3prb3dqc3FVUER4d1drQzJ5RjJ5dWw4Z2tVNVdyR0o5Zng1RUc3?=
 =?utf-8?B?c3c3K2p0eWtycGhHQ0daOGdnVHlVNmFwR0FSTmtGenpsaEM4RW5xZnNndklT?=
 =?utf-8?B?TEMzZlArNkduYS9vOWo1d0F5VlpWRjZOV3RsUzZCNFFUbG5VcE52bC9mYks4?=
 =?utf-8?B?UFQ2WUdsYWpCTjV1WjFJcnZSUXFET09HajJvZXpzM2FJNWlpVXcrb3kvYy9Q?=
 =?utf-8?B?Q3JSNHpjbThMQ0psQlhJQlphMEthRVhqSEhCZnRFTHJVbWNqVUJ4eWNscmIx?=
 =?utf-8?B?N2Q1MWNsUmxOSFNaRCtwdkR5ZGFSNVNESWdWYkhWRnAwR0ZXTFBWemJHSTYw?=
 =?utf-8?B?aTB0b21mZkZMQkFjS0hjVjFiQ2V1MDEwQ081em4yd2V2NnpQMmVXVFZQaU81?=
 =?utf-8?B?YTBIbTFrMTZwc3hyS1owbzllQkpUQTRSMlNzR0dRMnlTbjB2bTh6THYwUTZi?=
 =?utf-8?B?b2ROS21zVTdWZWpKejZEOVRjK1oyYUovNjJaRWNoWjFzd1ZuUVd5ZE5xaisy?=
 =?utf-8?B?MGUwZWJLR3pYeFp5U2hzRXF2d3NkV1VSL2Vxd0FnMnJ6ZkRPeTVOMmZRTWVo?=
 =?utf-8?B?c083Y3R0NG9ORDlaVXZvYTVEVEpCNW5DdnRWOFZrTTZhUWkrTklHU0owajd1?=
 =?utf-8?B?bnV4Um9TYWppeUsxOW9PS05rR2swY3RaQ3NnZEgvUVo2a0tIQnVQdEY0M1p5?=
 =?utf-8?B?amxKT1NnbHdmMWMxVXJZSW9qUEs0UVBCK1puZzM4cHUwRURUYWF2NG9Gd0Rp?=
 =?utf-8?B?ZkRhbUFTV3phejlzSnhtbmVveUZEMTJaY3JvdWVYbXNIUUlTZ2pvdTZDaitn?=
 =?utf-8?B?Nkd2RHB5RWY1RHlkZ2VNaCtqK1JHNGlua2pSUTBVN3lVZlBURkgxQW53dUVa?=
 =?utf-8?B?KzZWUDA2dURGakVMRE80MTNWS3RJcU5SSzZCcFBkVlZqOEFKU3pBSFZrT3Vw?=
 =?utf-8?B?T2NqRk1lbitKUWRPMzdXMG1WaG9ad05KQjhlbEVPa0dscFFLa1ltMXpBczQ0?=
 =?utf-8?B?OFpSR3QrM1o0Ti8vMDkxWUdVVXh4OFhxQjQ5U3hqb2lydU53NUhLMnFTMmpu?=
 =?utf-8?B?eXJBTmxLUExUNEFHYm9tTHp4cjJaaTR6eWRTa1VseStidmhSME9nVE13c0RC?=
 =?utf-8?B?OW1SZWUxaFJJVjNabWpIcGJtbGttb1k3R2ZCaVZ6V1EvWTVyZ3RSeEkxY1Fy?=
 =?utf-8?B?SFYyU3BWbjg4TTQ3T1JkM1pTS3ZkM0k1WkNIQ2MvT2VwejJ4ZTcrOUhFaGRR?=
 =?utf-8?Q?tLyaFUsTCWzo94iZMRUv/oBdX0VIUxqIdKi89mWT5ofzi?=
x-ms-exchange-antispam-messagedata-1: JrG24Nwfk76oCA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <4756D3F56F258342BC3CC3F67D603E22@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4ff329-194c-4cb8-7aac-08da53b59033
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 18:40:49.9669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8SwlYt/bRet1pakJ3ilvjPmqtpeBV7ucQ84xdW4jdIbRJ96zZ06GkxUNEV9FR3oobcBtgffXpoejZIgCTQNZ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3605
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_08:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210076
X-Proofpoint-GUID: -H-FMXKZ7q7JdLxz3P2pUiG_ONY-CuwP
X-Proofpoint-ORIG-GUID: -H-FMXKZ7q7JdLxz3P2pUiG_ONY-CuwP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_114221_486709_DE121FD0 
X-CRM114-Status: GOOD (  30.93  )
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

DQoNCj4gT24gSnVuIDE3LCAyMDIyLCBhdCAyOjAxIEFNLCBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGxzdC5kZT4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIEp1biAxNSwgMjAyMiBhdCAwODoxNToxOFBN
ICswMDAwLCBBbGFuIEFkYW1zb24gd3JvdGU6DQo+PiBIZXJlIGFyZSBteSBsYXRlc3QgY2hhbmdl
cy4gIEl0IGluY2x1ZGVzIGFuIGludGVyZmFjZSBmcm9tIG52bWUtY2xpIHRvIHNwZWNpZnkNCj4+
IHRvIGNsZWFyIHRoZSBJRHMgdXBvbiBjb25uZWN0Lg0KPj4gDQo+PiBXYXNu4oCZdCBzdXJlIHRo
ZSBwcm9wZXIgd2F5IHRvIHNlbmQgYSBjbGVhcl9pZHMgYXJndW1lbnQgdG8gdGhlIHRhcmdldCBz
byBJIGZvbGxvd2VkDQo+PiB3aGF0IGthdG8gZGlkLiAgTm90IHN1cmUgaWYgdGhhdCBpcyBhcHBy
b3ByaWF0ZSBmb3IgdGhpcyBjYXNlLg0KPj4gDQo+PiBUaGlzIHdpbGwgcmVxdWlyZSBhIG52bWUt
Y2xpIGNoYW5nZSBhbmQgYmxrdGVzdHMgY2hhbmdlcy4gIEkgdGVzdGVkIHdpdGggYm90aCBsb29w
IGFuZCB0Y3AuDQo+IA0KPiBXZWxsLCBpdCBjaGFuZ2VzIHRoZSBudm1lIG92ZXIgdGhlIHdpcmUg
cHJvdG9jb2wsIHdlIGNhbid0IGp1c3QgZG8NCj4gdGhhdC4NCj4gDQo+IEFuZCB0aGUgb3B0aW9u
IHJlYWxseSBpcyBhIHRhcmdldCBzaWRlIG9uZSwgdGhhdCBpcyB3ZSB3YW50IHRvIGNvbmZpZ3Vy
ZQ0KPiBpdCB1c2luZyBjb25maWdmcyBvbiB0aGUgdGFyZ2V0LCBub3QgdGhlIGZhYnJpY3MgY29t
bWFuZCBsaW5lIG9wdGlvbnMuDQo+IA0KPiBUaGF0IGlzLCBhZGQgYSBuZXcgY2xlYXJfaWRzIGF0
dHJpYnV0ZSB0byBudm1ldF9wYXNzdGhydV9hdHRycywgc2F2ZQ0KPiB0aGUgZmxhZyBpbiBzdHJ1
Y3QgbnZtZXRfc3Vic3lzLCBhbmQgZGVmYXVsdCB0byB0cnVlIGZvciBsb29wIGNvbnRyb2xsZXJz
Lg0KDQpMYXRlc3QgY2hhbmdlcy4gIEkgbGlrZSB0aGUgaWRlYSBzZXR0aW5nIGNsZWFyX2lkcyB1
c2luZyBjb25maWdmcy4NCg0KQWxhbg0KDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFy
Z2V0L2NvbmZpZ2ZzLmMgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2NvbmZpZ2ZzLmMNCmluZGV4IGU0
NGIyOTg4NzU5ZS4uZmY3N2MzZDIzNTRmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9udm1lL3Rhcmdl
dC9jb25maWdmcy5jDQorKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2NvbmZpZ2ZzLmMNCkBAIC03
NzMsMTEgKzc3MywzMSBAQCBzdGF0aWMgc3NpemVfdCBudm1ldF9wYXNzdGhydV9pb190aW1lb3V0
X3N0b3JlKHN0cnVjdCBjb25maWdfaXRlbSAqaXRlbSwNCiB9DQogQ09ORklHRlNfQVRUUihudm1l
dF9wYXNzdGhydV8sIGlvX3RpbWVvdXQpOw0KIA0KK3N0YXRpYyBzc2l6ZV90IG52bWV0X3Bhc3N0
aHJ1X2NsZWFyX2lkc19zaG93KHN0cnVjdCBjb25maWdfaXRlbSAqaXRlbSwNCisJCWNoYXIgKnBh
Z2UpDQorew0KKwlyZXR1cm4gc3ByaW50ZihwYWdlLCAiJXVcbiIsIHRvX3N1YnN5cyhpdGVtLT5j
aV9wYXJlbnQpLT5jbGVhcl9pZHMpOw0KK30NCisNCitzdGF0aWMgc3NpemVfdCBudm1ldF9wYXNz
dGhydV9jbGVhcl9pZHNfc3RvcmUoc3RydWN0IGNvbmZpZ19pdGVtICppdGVtLA0KKwkJY29uc3Qg
Y2hhciAqcGFnZSwgc2l6ZV90IGNvdW50KQ0KK3sNCisJc3RydWN0IG52bWV0X3N1YnN5cyAqc3Vi
c3lzID0gdG9fc3Vic3lzKGl0ZW0tPmNpX3BhcmVudCk7DQorCXVuc2lnbmVkIGludCBjbGVhcl9p
ZHM7DQorDQorCWlmIChrc3RydG91aW50KHBhZ2UsIDAsICZjbGVhcl9pZHMpKQ0KKwkJcmV0dXJu
IC1FSU5WQUw7DQorCXN1YnN5cy0+Y2xlYXJfaWRzID0gY2xlYXJfaWRzOw0KKwlyZXR1cm4gY291
bnQ7DQorfQ0KK0NPTkZJR0ZTX0FUVFIobnZtZXRfcGFzc3RocnVfLCBjbGVhcl9pZHMpOw0KKw0K
IHN0YXRpYyBzdHJ1Y3QgY29uZmlnZnNfYXR0cmlidXRlICpudm1ldF9wYXNzdGhydV9hdHRyc1td
ID0gew0KIAkmbnZtZXRfcGFzc3RocnVfYXR0cl9kZXZpY2VfcGF0aCwNCiAJJm52bWV0X3Bhc3N0
aHJ1X2F0dHJfZW5hYmxlLA0KIAkmbnZtZXRfcGFzc3RocnVfYXR0cl9hZG1pbl90aW1lb3V0LA0K
IAkmbnZtZXRfcGFzc3RocnVfYXR0cl9pb190aW1lb3V0LA0KKwkmbnZtZXRfcGFzc3RocnVfYXR0
cl9jbGVhcl9pZHMsDQogCU5VTEwsDQogfTsNCiANCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUv
dGFyZ2V0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jDQppbmRleCA5MGU3NTMy
NGRhZTAuLmQ0MjAzZDU4MjM0MyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvY29y
ZS5jDQorKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2NvcmUuYw0KQEAgLTEzNzQsNiArMTM3NCwx
MCBAQCB1MTYgbnZtZXRfYWxsb2NfY3RybChjb25zdCBjaGFyICpzdWJzeXNucW4sIGNvbnN0IGNo
YXIgKmhvc3RucW4sDQogCWN0cmwtPnBvcnQgPSByZXEtPnBvcnQ7DQogCWN0cmwtPm9wcyA9IHJl
cS0+b3BzOw0KIA0KKwkvKiBCeSBkZWZhdWx0LCBzZXQgbG9vcCB0YXJnZXRzIHRvIGNsZWFyIElE
UyBieSBkZWZhdWx0ICovDQorCWlmIChjdHJsLT5wb3J0LT5kaXNjX2FkZHIudHJ0eXBlID09IE5W
TUZfVFJUWVBFX0xPT1ApDQorCQlzdWJzeXMtPmNsZWFyX2lkcyA9IDE7DQorDQogCUlOSVRfV09S
SygmY3RybC0+YXN5bmNfZXZlbnRfd29yaywgbnZtZXRfYXN5bmNfZXZlbnRfd29yayk7DQogCUlO
SVRfTElTVF9IRUFEKCZjdHJsLT5hc3luY19ldmVudHMpOw0KIAlJTklUX1JBRElYX1RSRUUoJmN0
cmwtPnAycF9uc19tYXAsIEdGUF9LRVJORUwpOw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90
YXJnZXQvbnZtZXQuaCBiL2RyaXZlcnMvbnZtZS90YXJnZXQvbnZtZXQuaA0KaW5kZXggNjk4MTg3
NTJhMzNhLi4yYjNlNTcxOWYyNGUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L252
bWV0LmgNCisrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvbnZtZXQuaA0KQEAgLTI0OSw2ICsyNDks
NyBAQCBzdHJ1Y3QgbnZtZXRfc3Vic3lzIHsNCiAJc3RydWN0IGNvbmZpZ19ncm91cAlwYXNzdGhy
dV9ncm91cDsNCiAJdW5zaWduZWQgaW50CQlhZG1pbl90aW1lb3V0Ow0KIAl1bnNpZ25lZCBpbnQJ
CWlvX3RpbWVvdXQ7DQorCXVuc2lnbmVkIGludAkJY2xlYXJfaWRzOw0KICNlbmRpZiAvKiBDT05G
SUdfTlZNRV9UQVJHRVRfUEFTU1RIUlUgKi8NCiANCiAjaWZkZWYgQ09ORklHX0JMS19ERVZfWk9O
RUQNCmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L3Bhc3N0aHJ1LmMgYi9kcml2ZXJz
L252bWUvdGFyZ2V0L3Bhc3N0aHJ1LmMNCmluZGV4IGIxZjdlZmFiMzkxOC4uZDA1ODdiMTA4OTVj
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9wYXNzdGhydS5jDQorKysgYi9kcml2
ZXJzL252bWUvdGFyZ2V0L3Bhc3N0aHJ1LmMNCkBAIC0zMCw2ICszMCw1NiBAQCB2b2lkIG52bWV0
X3Bhc3N0aHJvdWdoX292ZXJyaWRlX2NhcChzdHJ1Y3QgbnZtZXRfY3RybCAqY3RybCkNCiAJCWN0
cmwtPmNhcCAmPSB+KDFVTEwgPDwgNDMpOw0KIH0NCiANCitzdGF0aWMgdTE2IG52bWV0X3Bhc3N0
aHJ1X292ZXJyaWRlX2lkX2Rlc2NzKHN0cnVjdCBudm1ldF9yZXEgKnJlcSkNCit7DQorCXN0cnVj
dCBudm1ldF9jdHJsICpjdHJsID0gcmVxLT5zcS0+Y3RybDsNCisJdm9pZCAqZGF0YTsNCisJc3Ry
dWN0IG52bWVfbnNfaWRfZGVzYyAqY3VyOw0KKwl1MTYgc3RhdHVzID0gTlZNRV9TQ19TVUNDRVNT
Ow0KKwl1OCBjc2k7DQorCWludCBwb3MsIGxlbjsNCisJYm9vbCBjc2lfc2VlbjsNCisNCisJaWYg
KCFjdHJsLT5zdWJzeXMtPmNsZWFyX2lkcykNCisJCXJldHVybiBzdGF0dXM7DQorDQorCWRhdGEg
PSBremFsbG9jKE5WTUVfSURFTlRJRllfREFUQV9TSVpFLCBHRlBfS0VSTkVMKTsNCisJaWYgKCFk
YXRhKQ0KKwkJcmV0dXJuIE5WTUVfU0NfSU5URVJOQUw7DQorDQorCXN0YXR1cyA9IG52bWV0X2Nv
cHlfZnJvbV9zZ2wocmVxLCAwLCBkYXRhLCBOVk1FX0lERU5USUZZX0RBVEFfU0laRSk7DQorCWlm
IChzdGF0dXMpDQorCQlnb3RvIG91dF9mcmVlOw0KKw0KKwlmb3IgKHBvcyA9IDA7IHBvcyA8IE5W
TUVfSURFTlRJRllfREFUQV9TSVpFOyBwb3MgKz0gbGVuKSB7DQorCQljdXIgPSBkYXRhICsgcG9z
Ow0KKw0KKwkJaWYgKGN1ci0+bmlkbCA9PSAwKQ0KKwkJCWJyZWFrOw0KKwkJbGVuID0gY3VyLT5u
aWRsOw0KKwkJaWYgKGN1ci0+bmlkdCA9PSBOVk1FX05JRFRfQ1NJKSB7DQorCQkJbWVtY3B5KCZj
c2ksIGRhdGEgKyBwb3MgKyBzaXplb2Yoc3RydWN0IG52bWVfbnNfaWRfZGVzYyksIE5WTUVfTklE
VF9DU0lfTEVOKTsNCisJCQljc2lfc2VlbiA9IDE7DQorCQkJYnJlYWs7DQorCQl9DQorCQlsZW4g
Kz0gc2l6ZW9mKHN0cnVjdCBudm1lX25zX2lkX2Rlc2MpOw0KKwl9DQorCWlmIChjc2lfc2Vlbikg
ew0KKwkJY3VyID0gZGF0YTsNCisJCWN1ci0+bmlkdCA9IE5WTUVfTklEVF9DU0k7DQorCQljdXIt
Pm5pZGwgPSBOVk1FX05JRFRfQ1NJX0xFTjsNCisJCW1lbWNweShkYXRhICsgc2l6ZW9mKHN0cnVj
dCBudm1lX25zX2lkX2Rlc2MpLCAmY3NpLCAgTlZNRV9OSURUX0NTSV9MRU4pOw0KKw0KKwkJY3Vy
ID0gZGF0YSArIHNpemVvZihzdHJ1Y3QgbnZtZV9uc19pZF9kZXNjKSArIE5WTUVfTklEVF9DU0lf
TEVOOw0KKwkJY3VyLT5uaWR0ID0gMDsNCisJCWN1ci0+bmlkbCA9IDA7DQorCQlzdGF0dXMgPSBu
dm1ldF9jb3B5X3RvX3NnbChyZXEsIDAsIGRhdGEsIE5WTUVfSURFTlRJRllfREFUQV9TSVpFKTsN
CisJfQ0KK291dF9mcmVlOg0KKwlrZnJlZShkYXRhKTsNCisJcmV0dXJuIHN0YXR1czsNCit9DQor
DQogc3RhdGljIHUxNiBudm1ldF9wYXNzdGhydV9vdmVycmlkZV9pZF9jdHJsKHN0cnVjdCBudm1l
dF9yZXEgKnJlcSkNCiB7DQogCXN0cnVjdCBudm1ldF9jdHJsICpjdHJsID0gcmVxLT5zcS0+Y3Ry
bDsNCkBAIC0xMjcsNiArMTc3LDcgQEAgc3RhdGljIHUxNiBudm1ldF9wYXNzdGhydV9vdmVycmlk
ZV9pZF9jdHJsKHN0cnVjdCBudm1ldF9yZXEgKnJlcSkNCiANCiBzdGF0aWMgdTE2IG52bWV0X3Bh
c3N0aHJ1X292ZXJyaWRlX2lkX25zKHN0cnVjdCBudm1ldF9yZXEgKnJlcSkNCiB7DQorCXN0cnVj
dCBudm1ldF9jdHJsICpjdHJsID0gcmVxLT5zcS0+Y3RybDsNCiAJdTE2IHN0YXR1cyA9IE5WTUVf
U0NfU1VDQ0VTUzsNCiAJc3RydWN0IG52bWVfaWRfbnMgKmlkOw0KIAlpbnQgaTsNCkBAIC0xNTIs
NiArMjAzLDExIEBAIHN0YXRpYyB1MTYgbnZtZXRfcGFzc3RocnVfb3ZlcnJpZGVfaWRfbnMoc3Ry
dWN0IG52bWV0X3JlcSAqcmVxKQ0KIAkgKi8NCiAJaWQtPm1jID0gMDsNCiANCisJaWYgKGN0cmwt
PnN1YnN5cy0+Y2xlYXJfaWRzKSB7DQorCQltZW1zZXQoaWQtPm5ndWlkLCAwLCBOVk1FX05JRFRf
TkdVSURfTEVOKTsNCisJCW1lbXNldChpZC0+ZXVpNjQsIDAsIE5WTUVfTklEVF9FVUk2NF9MRU4p
Ow0KKwl9DQorDQogCXN0YXR1cyA9IG52bWV0X2NvcHlfdG9fc2dsKHJlcSwgMCwgaWQsIHNpemVv
ZigqaWQpKTsNCiANCiBvdXRfZnJlZToNCkBAIC0xNzYsNiArMjMyLDkgQEAgc3RhdGljIHZvaWQg
bnZtZXRfcGFzc3RocnVfZXhlY3V0ZV9jbWRfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QgKncpDQog
CQljYXNlIE5WTUVfSURfQ05TX05TOg0KIAkJCW52bWV0X3Bhc3N0aHJ1X292ZXJyaWRlX2lkX25z
KHJlcSk7DQogCQkJYnJlYWs7DQorCQljYXNlIE5WTUVfSURfQ05TX05TX0RFU0NfTElTVDoNCisJ
CQludm1ldF9wYXNzdGhydV9vdmVycmlkZV9pZF9kZXNjcyhyZXEpOw0KKwkJCWJyZWFrOw0KIAkJ
fQ0KIAl9IGVsc2UgaWYgKHN0YXR1cyA8IDApDQogCQlzdGF0dXMgPSBOVk1FX1NDX0lOVEVSTkFM
Ow==

