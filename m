Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B8FC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 16:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k3TEFV/fY1tWvZ3YW9vPFNVag3ib67O1ua5fDMvFtWc=; b=tygx/1wFBeS7FK6hQ5ZgFivTlb
	QLmf69K+g+yc3CVM/iCA8BXj9GpIEZnEcL13jSW7MtFqyArELOFfacpV4oIgp5Xms/Ax+gtNCm2CM
	XXwQxluCyEW1pxmcaCHVAw2LXQl0q6dwoMNhQ834gPAynIcBbkYLNJcyhhr+hzWVV2fepcOJ2eOFX
	eAiAORZelAQgdES5F5XeT5fOki6bNi+KYlIILtR/e/4fN4vohnBCFs7CKeWuJGhNHrV4a+/mdshZL
	vJ08Y4Ypp9uSGsLLa5WsI0Np+L3/zsH1MX7iXyjJTnDckflNg6U/TEJwOcMVCbfF5Pp3PBOLTe695
	3s5zm8ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncV3m-00D5co-Iv; Thu, 07 Apr 2022 16:32:39 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncUnY-00Czay-JS
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 16:15:54 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 237G1d6B014690; 
 Thu, 7 Apr 2022 16:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=k3TEFV/fY1tWvZ3YW9vPFNVag3ib67O1ua5fDMvFtWc=;
 b=Cb/2VLzf8Ye0N1MG7906Ooad1Ps5cXH2QoRTO5gUmrV6UVp6uFM0gfC0Em4QlWCEQUNA
 MJOtTRl2GRhLhyzUWdVbYRK7q85DcJWj1wCiroo4s5Lkk8Whe0dCn7vI4k5xqUQi0KJM
 uusMePPmyh3f/uZGLENzCu/z2apf6j5YIQSRm0fHXS9yCAiQjVZ3BgpA7H/uCAqwhTid
 6afVvA4w7p33V2aY06dpniMKSmUe7XCjKntIfhlY1wsyS321kZemNrJKVB0pw5iZW8HV
 OVmFdPKfiaT64G+teTlusW7l2I7XW2LQ2DtZ2DNp/jjWodSN2Be6BYVx98OXS8+ob+E2 aQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9v597-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Apr 2022 16:15:46 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 237FXvRn036917; Thu, 7 Apr 2022 16:15:46 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam08lp2169.outbound.protection.outlook.com [104.47.73.169])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3f97ux10ym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 07 Apr 2022 16:15:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzTI4K5IgrQMaxWLKE7ODqxvQXng3LtC1yCi1vlFahO0lG19UsRN0BdY1asftzRoQzvPMc718NDSHqxHzBe0dEYpFUGJ11oZQhdGH317rbwOQyXeCWnX8jOTndwW6btOx8ClTgqkjIlS1dDA+8TxHlhWQRwLCZoVu+p2N4ObXqQnlZRiOc4bqN7F6aRLH+lU4P6IyhjFxkW90/XRXmI0lyijOM9WIHYzCzIqxDypjIqaM/dLgbmJmFZeHuqEC+4MQrUTVg4P+PjPVVp7AwzYO1XOPXXLVyEEZG6oqz1oJK+vYTKfwmjWc75uCAzrmEqSTLyeTJvrGRcUUAa6J+c+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3TEFV/fY1tWvZ3YW9vPFNVag3ib67O1ua5fDMvFtWc=;
 b=DzZgOhpM1gRVy22NqbE/F+hs5zr/KYv5JzxeR2wCJVedh6IEFOghZyLQuR2ond8+fFiqig/wPvjZQcDN7rVMLRdbXlISYQSOmcZyHjg3zNYAmnXmt5NW/szfVOYyyYdO51Fvl2d3HiC7VP9IAfMaQTJ/3KZfozJVBQfovIPlkS4F8XhIAESStJfmQBqUgZSPP2fNVQ0fxxO05j2VOB9GXo45mV/JCIMMPdfDmmWHhcFW4DXA0WeoS0Fp9cKb/962VDOJV+sBMlbPwhUgVdTh9YGTI+91gK4YBi8G0EIPxn3x0iIZkOpYQGECTminIcN68pbtHrZnVEHPVhcQq5xnvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3TEFV/fY1tWvZ3YW9vPFNVag3ib67O1ua5fDMvFtWc=;
 b=ufD7JahJAtTgd5WhFWwNPgIfj89UWWZxzBgbpM5msuAy8sx8GtYdU2F6jV6cLT5qItkzE9YmNPS5Bctokq2UEXOVTzNxurxkwroyptL8A/h1sJNs/KRPLR32Ur6+JXRCB00Ms00KPVwFdvZsJV8TTqOGAOwmHerHvjBx33o5+g4=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by BL0PR10MB2772.namprd10.prod.outlook.com (2603:10b6:208:72::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Thu, 7 Apr
 2022 16:15:43 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::19cf:32fa:454f:7bff]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::19cf:32fa:454f:7bff%8]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 16:15:43 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni
 <chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Topic: [PATCH] nvme-core: mark passthru requests RQF_QUIET flag
Thread-Index: AQHYSdUqFpKGiT1CSkmELkSF7x4OoazjGb6AgAAClgCAAAWlAIAAT2KAgAC0P4CAAHwvgA==
Date: Thu, 7 Apr 2022 16:15:43 +0000
Message-ID: <D6A4B713-3EF4-46B4-812F-1EE70C93F306@oracle.com>
References: <20220406164109.30449-1-kch@nvidia.com>
 <Yk3FT78uVW+9rRV5@kbusch-mbp.dhcp.thefacebook.com>
 <21a3a237-5f3b-a608-2d79-e0a5fdcc0d88@nvidia.com>
 <Yk3MNrI3YfjvbRqZ@kbusch-mbp.dhcp.thefacebook.com>
 <92C8BCED-6845-46D4-BCD0-78E790A5F86E@oracle.com>
 <20220407085113.GB19062@lst.de>
In-Reply-To: <20220407085113.GB19062@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad03a8e2-c732-4dfd-52a8-08da18b1dddf
x-ms-traffictypediagnostic: BL0PR10MB2772:EE_
x-microsoft-antispam-prvs: <BL0PR10MB27725BD7A0B1BBCEC441218BF4E69@BL0PR10MB2772.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kIvCcMk2YpKeLArhMJPVxJNOdB+Htf0/G9a8WELoRk1FgecWStb8qhA8j/o5Rowi3vbpKzLVSYfEXzYhwOckrFkaqLzfxjfAWlHplvweAEyeuFYdH5lW7P12CXE0j0MowlFwMyARSjpnQBhJuPFZWDaXfLNmd09NC7QWP/0CmXXgA0X2J83hk/7X/z6up8i6FOvV8SXCa0PpiUNKM6K0RY64aDB8Q9XaHdaQ/wj/A8v81NnIuXWy01HRum748uYpspkCdwgxP59uG65ZoehRVmFz0RvXCwU4HFGJKRcc2CkX99zFHsLZdVKNcyy8ZKpvRub+RbWFbh8l8CZDtEewdyzbHUzf6AZoWGNqz5dQ+uIYCzO9uRs4Laexg/3jShV9412yfeDtnnM7XI3CoYVyZR7Mdkkl4+98/2fa56PZKqLvJaeJ6JG6oFJdxybPan/JtChR5EEqxZg5Ak1JK/f+nFCTv17FbzQUX0JnbJKWltQh5a1/Wc0CoQlkKn6DBO4UaLKomrJrjvOzxbqZlw1+ecV06Bap36cBBVOeBBW5IwGnIBRRkV+DNY7mQCQQ1ZKRiZuG5pqd4BDUaWfhpQYX5jj7sK3qyDwTHUbZcoK18LVhJlTnXXRjdYMNePNzpDlxgi1ONo0ADFXTFo5JqfTWEIsETRM5BpiwnwYqSK18wMBBHAXh1y7vQQHxv2dhnW+MK1cyPhCkPPr/TzPkJX+tRMePsx79zH4nyL3YozCIKrGaIPLtzfb7Q6gMZplTqctG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5550.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(366004)(4326008)(76116006)(91956017)(38100700002)(8676002)(122000001)(6486002)(66946007)(66446008)(66476007)(66556008)(36756003)(64756008)(54906003)(316002)(6916009)(2906002)(53546011)(508600001)(86362001)(83380400001)(38070700005)(186003)(6506007)(8936002)(2616005)(5660300002)(33656002)(44832011)(6512007)(71200400001)(4744005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXRwRVphQTh3N1p2VGxrMmZPQ3VDa0hTTVM3RTVSaVljcDFiRGd6aitwa0Uy?=
 =?utf-8?B?alRrdGdpUmdPZGdwOVpjRDBmTUxHcWMwaVk3MnVCdkNuSzlyaDV3Q3pYL0VO?=
 =?utf-8?B?dmkxNjZBNTNWeHNUaGJQU2pnc1c3UFllZGhhbDA3cXJZTThvcVFqWmNsb05w?=
 =?utf-8?B?eEZXaVRJSElTdDVlb09abWF4L3c1V291TEdFYmpRV2pXTkdieDc4ZTF2RmFr?=
 =?utf-8?B?dFkwTjlNZ3NNYWg1VXhobzFDQTRrTnVjdWIxOUFQd3RGN253RmZ2M0hlV0pP?=
 =?utf-8?B?NE1CWHZ3VFVqcnJrUFd3dnBTQzhqaUNhNWN1UHo1MklhbDFadmV5M3NFbmVD?=
 =?utf-8?B?K2U2aGhnOGVuNmM0SlBoU1cwVTh4Z1dxTkY3TjdlRzJGcm45Yi8vSHFtWi91?=
 =?utf-8?B?SGdQOU4zcGlYeHFzdjlUNEhwdmRhQzg5NGNpdktoRVF6MzY3TlRtWGFDNWZI?=
 =?utf-8?B?V2U1SzFib09kZFpDLzEzUlMyMW00V2I5TDN5UW45dWlkcHh6bSs0WmNEUnBj?=
 =?utf-8?B?bzZ2YVZ3Zkh6SE0zWk1VRGpsTDFFa2pneTh3QUdKWHE2RndpTDBVT0FTcTND?=
 =?utf-8?B?VlRIMkJkbld1VXNreWljNGZnMW5VUDdTb0R6ZHBNMUE0dGMxUHZqRFgveWVX?=
 =?utf-8?B?azRDUTF6K3crNFhTTFU2NkVLKzU2WEQ1SnR3L3BXYXJCamtKd29LajRYWlds?=
 =?utf-8?B?Y1BxVWtHQXBtemkxS2lKTmxUT0FaMmM4Qmw5TlBwMkd5bDFYVlkvVkRVQlZ0?=
 =?utf-8?B?aFhxcjdyTGlsZzN4a1ZYVjdESWdwVmlQNU5aZDRuUEhzcnZGNWQyM0tsV2h6?=
 =?utf-8?B?c3F4Z1lSK3FQS0dlWlMxUjFWMmtSZjgrTHRZSUVISUFnblJ4Szl4aVpUMHRy?=
 =?utf-8?B?MUI4MlBLeDB1M0grR2xjcVNrUmFxOTBHTzJicHpxamxTdElwVlpuaTB5dEdp?=
 =?utf-8?B?eGRqSnliclg4T2pMUlZUUndsM3BsZW0vOXl6b0hqMDBWMFBabEtOV1QyZHIz?=
 =?utf-8?B?NHRiL3lMZk9JUVpzM1VYVTRvYTMreW9KTyt2amZoOEJsOHFqUVlSZVJ6bDRP?=
 =?utf-8?B?NWlubXBiTHZKOHJLTVZuZC81N29IdkR4bVluWDFNbkxMZlIwMFlRU1dJc0E4?=
 =?utf-8?B?YWtQcUEyL0xManJUZHNZb1EzQ1IxM3hJRkJqOGVBUW03VjdhMVI1YXpIOUF6?=
 =?utf-8?B?S0RWRGpuVlhjeXlwRGpiZ2E5WnBPdW1HTHdhRFR3WVRnTjc3akJ1UWErb0g4?=
 =?utf-8?B?SThqRXJKT2cyNlczU1VZNm95NFhhbmd2aVViS1Z0UmFIRUttcU9vQzNVK0RF?=
 =?utf-8?B?SENBU2dveTAzL2F3M2F5azBoUHV0TVErang1N0d3VFYxdGVUWW1VNUt0a2dC?=
 =?utf-8?B?eG9WeEN2U3dxTmw0Mjk4M0tMR29PYXZhOHNHenJuQ2NXR1d3UlhjdGp1di9W?=
 =?utf-8?B?WkdGUkxlYlFLK2tjcVZzRTdRMVZlZW1QN3ZCdUQ3UktaRUhpSDJrNnVhSGlR?=
 =?utf-8?B?NlEwMCtUR1FOR0lucDIvWitMaEJuSWtRZnRGTlU4cXNLTVFWTWJYYWQ2NnBC?=
 =?utf-8?B?U2VpL2lQZmUvRjFVdkJLTEl4TVlEbVdoYmlSU1gzTGNhV1ZNYUNKQW9rSlVl?=
 =?utf-8?B?aVdBOFhKS2RVWVd0UHZUSGtzMklMYkRqV290RmUwV0t2QUR3N25GU01GOEpU?=
 =?utf-8?B?TlA5eVNrcWNINXhvaUs1SDE3N3ZkOWV0TUxFdHBuZnRjT1NHN0E3WXMrMnI5?=
 =?utf-8?B?QnJGdWNVb0ZPWkxteW1KUEp4ZWNpRVl0Y3daWmxQRlpBSytaVGxhM0lxMGUw?=
 =?utf-8?B?WWIzMnc3RmNiK1FLUmhPWFd3QzJ2cXZYU2syTGo4dlQ2STAyNGhla3hMaFJk?=
 =?utf-8?B?R0lJckMvNHJndnNOR0VlUlZsQWpmYWtxYys5V2pYOFRKNnZ6T3BZOXNOK1VU?=
 =?utf-8?B?Vk5UQUR0TUl6SEJUYkNtOUpyY2VuZ1pOcTM2a1FNU3VhcjVQVWNPTjRtb1cy?=
 =?utf-8?B?RkIwazlqNWVvY3dNN2RNVE1ZTUdVTnNaSjFoUWYzYXRMZTFaVjk0VlBmTk5R?=
 =?utf-8?B?bnhIYTZnYTBYdlROTXJxZ1hIWFJKK2sxRXhHdDZuOFBORzMyNlcvam1qTHc5?=
 =?utf-8?B?VjUydHRwZXh0VzFCdDFNRUZzSTN4Mk00RlBaT0gybUpkNHdjNWQybjVaZU9X?=
 =?utf-8?B?Ykx0dlpvNStFUzRDaThML2pOOE16N0V6cld0RVMySEc2Y0wvYXo2WTVJNlpD?=
 =?utf-8?B?ZEdoVUVpUUxmei9qYlRVcnE2SlRoTVNqcmhyRmhRVDlCYWE0bGtKUmNyNStn?=
 =?utf-8?B?bFBzTDVHbGpHT0V6ZGU4WXFCdU40UkwzVlUrWHhINzA1UzhRY3g1OGtrTlgy?=
 =?utf-8?Q?AFp/31Qsg3Z9LvVvzyWTJ6ZRO5lDqSTi/4TlAX+04zWh4?=
x-ms-exchange-antispam-messagedata-1: gwKBiZAsQQcHAA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD6A0DD626E4A94A9740B75F1C7B39F5@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad03a8e2-c732-4dfd-52a8-08da18b1dddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 16:15:43.5775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xhny7JkQS8qvAwMbOeA6Uwim4zAUXfNmVZ1RakC4WEgrmwxfLZRDXKjRNjKC/UK7zw8fR3Zi3tL2fOShzDfiTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2772
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.850
 definitions=2022-04-07_01:2022-04-07,
 2022-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0
 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070064
X-Proofpoint-GUID: utmpF3oh3v6TiLxbt35w11fIbZQyLkxk
X-Proofpoint-ORIG-GUID: utmpF3oh3v6TiLxbt35w11fIbZQyLkxk
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_091552_736734_8F6F865E 
X-CRM114-Status: GOOD (  19.96  )
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

DQoNCj4gT24gQXByIDcsIDIwMjIsIGF0IDE6NTEgQU0sIGhjaEBsc3QuZGUgd3JvdGU6DQo+IA0K
PiBPbiBXZWQsIEFwciAwNiwgMjAyMiBhdCAxMDowNjowNlBNICswMDAwLCBBbGFuIEFkYW1zb24g
d3JvdGU6DQo+PiBVc2luZyBSUUZfUVVJRVQgb3IgYmxrX3JxX2lzX3Bhc3NyaHJvdWdoKCkgd2ls
bCBtZWFuIG5vIG52bWUgYWRtaW4tcGFzc3RocnUgY29tbWFuZCB3aWxsIGxvZyBhbiBlcnJvci4N
Cj4+IEkgcmFuIGludG8gdGhpcyB1c2luZyB0aGUgYmxrdGVzdHMgSeKAmW0gY29kaW5nIHVwIGZv
ciB2ZXJib3NlIGVycm9ycy4gIElzIHRoaXMgdGhlIGJlaGF2aW9yIHdlIHdhbnQ/DQo+IA0KPiBX
ZWxsLCB5b3Ugc3VibWl0dGVkIHRoZSBsb2dnaW5nIHNvIHdlJ3JlIGN1cmlvdXMgYWJvdXQgeW91
ciB1c2UgY2FzZS4NCj4gU0NTSSBza2lwcyBsb2dnaW5nIGVycm9ycyBmb3IgaW50ZXJuYWxseSBz
dWJtaXR0ZWQgY29tbWFuZHMsIGJ1dCBub3QgZm9yDQo+IHVzZXJzcGFjZSBwYXNzdGhyb3VnaC4g
IFNvIHdlIGNvdWxkIG1vdmUgdGhlIFJRRl9RVUlFVCBpbnRvDQo+IF9fbnZtZV9zdWJtaXRfc3lu
Y19jbWQgLyBudm1lX2tlZXBfYWxpdmVfd29yayAvIG52bWVfdGltZW91dCAvIGV0Yy4NCg0KSSB0
aGluayB0aGF0J3Mgd2hhdCB3ZSB3YW50LCBza2lwIGxvZ2dpbmcgZm9yIG52bWUgZHJpdmVyIHN1
Ym1pdHRlZCBjb21tYW5kcywgYW5kIGFsbG93DQpsb2dnaW5nIGZvciBwYXNzdGhyb3VnaCBjb21t
YW5kcy4NCg0KQWxhbg0KDQo=

