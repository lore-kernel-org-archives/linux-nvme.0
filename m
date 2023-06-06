Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D0DC77B73
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 03:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tBGqfzM36Wb4f3c3y6nJOQMlkfkednTP5VUV2XK+cVE=; b=JujB9TClPmF7dZv8t928pTkT9Z
	/0A1k3aZJkJYJWNWcV1vXq2cXuO0mkLTjYEWpZL6rMqizT/CPynIOPvbPlmZtadrEbaoBasrx3VFj
	KN0Lk1rG9uPkYKp6Yd4wj3Msv3vTmVLk+M1r3wfb6QBgpwRRAyEW9gakh9Aq1MDoTKbZsRPvrJ8Ae
	3CJVEIP8oVYTcyvO6VuPP5sJB0WkE+TrLmaDQkmgPiY9AuIhdmRU2Pc0w6MiSrIMVuXLb2z/qQRfC
	pqY2/PSJdi1UXMR41FCx2jSshqsQQh5mWr0Wmjto+U68QveGXqs8zwJ0GOjSEBw6uoOhLKq7jGhdH
	Eb2kTVRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6NIp-00HYSC-2e;
	Tue, 06 Jun 2023 03:24:11 +0000
Received: from mail-dm6nam12on2060e.outbound.protection.outlook.com ([2a01:111:f400:fe59::60e] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6NIn-00HYR4-1a
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jun 2023 03:24:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/J2yBMM1cP5Qd+YhPFEQD7kJ13Hu2GOogdYfHEIaZLEP5+psF2N+9PIBmiKdNnSzgy4Xu5B0E8uAgIi38QKOredCh+blIDaoDop2FQVma4Wbs7TAcy4PZTUDXW9FEoaoQDOBuh+PQx7fNyNsoLRpXHg2PabAYT9LAy98MmuXk4gBnSmOyyaE3cS3yYoiRycobvCPDR90iL8Ou+rN3JDhXJLpTdSUjQqteWzlhY+1fSAJrYavBfITDs3PazKDASf9NN3gTHoNOg95ct36Mu37DXQL14Z1joJepQu5lcOc3O2M0cj+tf/gS7xw5mYmL21M9XeuvJWEAh7u/vvoWWgGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBGqfzM36Wb4f3c3y6nJOQMlkfkednTP5VUV2XK+cVE=;
 b=hXgRuydv55x6kK++OY4JB/aPOV5tHEssamoCzU/VOJxc0y7spzcmN6e1o9IwjDH4qXnMVtQGAFYKQuF7ijz/KGlQ3HEhCZPDD7uTCHOmvQf7JCDS1Re4tt5M9Pe7aH8GQOoxbq1vljB2FP+AYvtgD7puqqvzgO9doTRK0mtmlsZhshAe81uYw5udXVOKUSOQ+o/FbfPb2FcemdhyoRErdalOZhVVC9a3ecxDeM1SE82hdtVaSW6lO+QnihJkoPo/7yfYMisRIPyOt9/PFGGVgfLc5K21AnlCHQmHAJStWs6N7XdwPIybzx0Sq7JKCA3fA+lxv1FUQEwD0SIdA5Q/Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBGqfzM36Wb4f3c3y6nJOQMlkfkednTP5VUV2XK+cVE=;
 b=p6DjyMwTY7YU50nlLKmpM7GgMFzATm6hmpKtEdbfEoIE2a0S+aUnhQEhLmDFyEOlxabpnrM/Af2JeceCXjONoQTa1qHB6lmZ9ptjHZ4l6VQ6GVO4OZ0yiSBVhzW/LUCVaDYFx5p5iYtcHhtnCZctDHvGQ7DM3F+kNVvOniS8X93LZYvGjhblJX/z06r45d9dRDAHgTNmv1vUdJRQujPAr2zPxJb9hhpPnpa+4jKQBJ7/vDs3psxzVs/ClXITJW30qcSNXPi4jz1xHOoY5sh4ZT22JfseTuZna9RaYY01Tl/Jc5aW6cj0MW9AWzpudhK+L7ZQmgZRlwlVDcxTitUWlw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN9PR12MB5113.namprd12.prod.outlook.com (2603:10b6:408:136::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 03:24:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 03:24:04 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "hare@suse.de" <hare@suse.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2 1/2] nvme: add generic helper to store secret
Thread-Topic: [PATCH V2 1/2] nvme: add generic helper to store secret
Thread-Index: AQHZl3o4u/p44zHH/kCtzfYYlr2fna98y6uAgABSD4A=
Date: Tue, 6 Jun 2023 03:24:03 +0000
Message-ID: <478ca846-cf68-c8db-d4e5-f862775d16c2@nvidia.com>
References: <20230605065125.47563-1-kch@nvidia.com>
 <20230605065125.47563-2-kch@nvidia.com>
 <ef1a8621-ae27-1b06-fbc2-b3cb1e137b1e@grimberg.me>
In-Reply-To: <ef1a8621-ae27-1b06-fbc2-b3cb1e137b1e@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BN9PR12MB5113:EE_
x-ms-office365-filtering-correlation-id: ffc12199-8d19-4cf0-6a1a-08db663d7a89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PbgdWrF+JQPPeKyAW5eBYxY8bDwYzgcJRz8H7SeANwUq7mLx74BmpmOc7OGUQOsi3Lv+/zKemzQgk+Q/Ghk+ZNatm02B6Nt+8y/nY2PXdH3vESlKAaiusUQlOi3AFXDVBBYAnpE3scZsPMuKjV4NMtkvvm/PjHgUXulSQ1W1OwguLxu5cV4oZN0+ItwdSmNpJPr4aQncz5XqWeH4O9sToO/QB7BJxOFnh55vunmc88i21DqOy3RZsGpPALxyjFB28jAJkNB+bQGddkhNe9mi6zXs4+I3hODVm9YUGBmS8Yn4mcx7c5/OALG0P5S30E8XnQBi6pEPbnrtj8sx6jk7/bVLU7iDuyG1v6nS1iKsA2Mr+9u0g7oinuQv+yybBN0ErngttWelNw7q0NrUG3X4/A7AZJJfRQYBcF6qu/qSXCqn10eAyRV9i35/nB0RPLDacHiEpj7N5id1BYKYRrGehC5NMScPjKibrUwPmH3RTW0Y6lcUO404ZHTuKDJegiNemFEBrTd6LcYZ9h4ypJvQo3jtL+GCAGXVK2iduXGPNmyin7V5zECPKS+SqoRq4vPJBgPyLSgmh1Y+TbE/2lJ3slWaDN/dOFa3WwZjUBwHDZpjmVY83Z2x3FofNV1tQWwJoPd2I8l45yEfSVs/4GgqCADEzI2YUMbMqW4eb3UUPTK3frES2/oJUU2z5NuacWqSkmbBNKXLevMqv6deF28wJU+TT3PyOry+KS5chXjhkwI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199021)(86362001)(122000001)(54906003)(110136005)(4326008)(76116006)(91956017)(64756008)(38100700002)(66556008)(66946007)(66476007)(66446008)(6486002)(478600001)(71200400001)(2906002)(36756003)(186003)(4744005)(2616005)(38070700005)(8936002)(8676002)(41300700001)(316002)(5660300002)(31696002)(31686004)(6512007)(6506007)(41533002)(219293001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVZNQlZKMG10dDNvK0VwNUNnYlN1U1NkUHRqODVaWUxjR1l0eXcySFNUMFo1?=
 =?utf-8?B?WWt2ekpYd3RwNFduK1JwWm9YelFUWG1ubnNhM0dKRXBndndkTHdTV1NnaExN?=
 =?utf-8?B?RkZEZzBxc2RZVlJoL2NXaC93NTJaQW1wR1pIQjdVaHdJbEFpaGpIWm5PSmFL?=
 =?utf-8?B?ZVFUdEpYdnFWOGMyZlNUY1dLWU8reUJJdWZGbVYrQkhDYUhIZXdBQVN5TmVQ?=
 =?utf-8?B?UzZTTEw1NVUvNDczWDdkQ3VUWlhaZ0pPelJaZzVTZU5SdEZ6MmFFUnVmdTlz?=
 =?utf-8?B?ZERNR1R1anVReW5iVzFxczBiNXBDZVhna0RZTzU3dnZpaUkzd1ZHbUw0R0N5?=
 =?utf-8?B?NDFOYm5HVlAxUGJsUmxEQlJjdTlNeGxCYXhMOXQ4dHZ5OW80Ty91N0lMQVNT?=
 =?utf-8?B?cUpDUURwRkltbnFEb1BQblNTMjdzNGVaU0FrclVHYVd1YjRQV2doM2JaRy9n?=
 =?utf-8?B?VHdwUTRIbVV1TUlJS2d0VHJQUlViTXhMVklNaC94NnJwcklpZUc5QWxGZVFR?=
 =?utf-8?B?Tyt1ejBzdWRNcXV6cmRlODMzMWIzZm5ZOVZ3MVo5M2RYS1ZFNGs0cnROc04r?=
 =?utf-8?B?YlhZZHJwc2VEQTltU1Z5bWdXaUFKN01KVVVjclFvdnplN3ZaSStOaGxCYmdE?=
 =?utf-8?B?eDViV1A3RWpqdHRwU3JFSTA4TUcrNGRaWkN3d1BsWDk0M3JVOUh1YngrMjdP?=
 =?utf-8?B?MHFQVHlFQnc0OGdvVU1SMnlBaGRUN1JxTEcvZEpxcGFRUERnekdRQm1HVWc5?=
 =?utf-8?B?MkR0TjRMR1h3cEpuT1R5KzlCMDBqbkpaTlNkMnlGblA5R0dNNHZwUnV4RFA3?=
 =?utf-8?B?OE12Unh2VDhaV3pTR3JzNUJwOThOdnRPdGNjY0ZMcWozS3R0RTF1NVg5Snd2?=
 =?utf-8?B?K2J2Y3NvUUpIMk1VUklFUDZ2clJmVTV3RHY2NDJPZUZZd3hsVmgrMTBhMWhY?=
 =?utf-8?B?TDhWcHhiTU9SbWpvMGlLLzBvbDhaVzd5VjZRWFJPZDQ2eWdXY0hmTGY3T254?=
 =?utf-8?B?WnQybW96UitiU1RFd1lSWXcrZTRUdVN4d1RDbzZiNTFaRlprQW91T0V0WHlx?=
 =?utf-8?B?T2VGemwveCt6djlHNHFaTlVzaEdCTmZTSG02bjlZWjYrb2NxNkl5bzhaRzlJ?=
 =?utf-8?B?ZzNlMFAyWkppdUs2UytuT3UwdUttL3Z5Zk1RZDRvWEpoVU5MeUgvN1ZwTnFB?=
 =?utf-8?B?MWVBSTFzL1FwS0tEZ3VMWDQyUTVjTmZrMzkvR0FpeEVFTUVjZkVOYTh5YS9a?=
 =?utf-8?B?T0J1cnUzTlRQV1owSHEzQjcxbXVSNzdIWi8zdUExNC9iTlRPUVZRWm9MVWE1?=
 =?utf-8?B?bXE4MXNjc3BOYkZDTGR1YTdMVzcyUXBGb3pJUzBhdmxHNjhVOThZVEdkb3dT?=
 =?utf-8?B?eGVmOE1HbEt4OGV6cUluN2dTNmNrU0FKcW9sNkN2Y1Rwcjc0WnVsN3g0WTl1?=
 =?utf-8?B?clRiUEFaTXRGaEd3Vkh4YVNkbXE4NmdZQitNS24yRlp3WjR5aE5YVjR0T0VW?=
 =?utf-8?B?M1ljdUptVkI5MHlYYTVCazA3K2RaUkZMaWsrSDBzVUFmaUJXN2hNS2tqUHhP?=
 =?utf-8?B?SEF1UU05bm1pS1duRUVWK1lHMVI0SFZrYWhQRlB3QkpIMU90LzhzSmR2K3Rr?=
 =?utf-8?B?cGpjVHpmOVQremVIME1JT2NFZ1NLYTdBZmxCMGRKaEdUQks0dVFMMVRkUFRP?=
 =?utf-8?B?MUlJTm5VdUZKUTlYRStpdlVtdlVxbzR2R1BnN2NiZlpMMVlqVm0vQjFvaE91?=
 =?utf-8?B?Qityd0IwSmNnSVRLSzY5b2xJazhabGNhRGpRd0NZSjk5aTB5VXB6N2ZxR2hG?=
 =?utf-8?B?aVlzbDg1dXpsYTdHa3FuTzBONGVtZFJlUDh0bHhDTitTM0J1NThZNmFkZHJO?=
 =?utf-8?B?WmphWi9ib3BZTjNOMVIyK2t2WmU2a2d4WE00NWg4V2gxMVEzajhWcGRpTW43?=
 =?utf-8?B?VE9zb1hWN3FXN0dZYUkvelU2S0lMMkVPUjdYOWJDTThnMHV6elpQbktSZW1t?=
 =?utf-8?B?RWhMNjF3Syt1TTg4aVJDdFF4SHJ6WDByUFh1Yzc4TC9kd2pVTW5sckJydWsy?=
 =?utf-8?B?eXA0aGNjaHNJZ29XemhKSi8zZzFsR0pqYS9BNFdpM2tDUStyb2U3ZTkrZFVO?=
 =?utf-8?B?ZS9Fak5lMEtvK2o3bGNmcW1GdzZSR0cwZU9hcnd3T2FhbFEvdjNmaC9zS013?=
 =?utf-8?Q?+UDqBSn3x/KAKH3wXEavu2aAGEf5YpwpcXHAxqj2BQF0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8E4FBFF087BAA41A4645ECF0D2906E8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc12199-8d19-4cf0-6a1a-08db663d7a89
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 03:24:03.7471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0SABF/jTY2SyUTCRtwATUU014xn3rFMdfns2NKktnpIsi9iputrdCXS0JPDFYe4yLPZp9UQjo22eU73r8H8/nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5113
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_202409_532862_9807D542 
X-CRM114-Status: UNSURE (   8.44  )
X-CRM114-Notice: Please train this message.
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

IMKgwqDCoCBrZnJlZShkaGNoYXBfc2VjcmV0KTsNCj4+IC3CoMKgwqAgLyogU3RhcnQgcmUtYXV0
aGVudGljYXRpb24gKi8NCj4+IC3CoMKgwqAgZGV2X2luZm8oY3RybC0+ZGV2aWNlLCAicmUtYXV0
aGVudGljYXRpbmcgY29udHJvbGxlclxuIik7DQo+PiAtwqDCoMKgIHF1ZXVlX3dvcmsobnZtZV93
cSwgJmN0cmwtPmRoY2hhcF9hdXRoX3dvcmspOw0KPj4gLQ0KPj4gLcKgwqDCoCByZXR1cm4gY291
bnQ7DQo+PiArwqDCoMKgIHJldHVybiBudm1lX2RoY2hhcF9zZWNyZXRfc3RvcmVfY29tbW9uKGN0
cmwsIGJ1ZiwgY291bnQsIGZhbHNlKTsNCj4gDQo+IEJvdGggY2FsbCB3aXRoIGN0cmxfc2VjcmV0
PWZhbHNlPw0KPiANCg0KdGhpcyBpcyB3cm9uZyAuLg0KDQpUaGlzIGlzIG15IG1pc3Rha2UgbGV0
IG1lIGZpeCB0aGlzIGFuZCBzZW5kIFY0Lg0KDQo+IEkgdGhpbmsgaXQgY29udmV5cyB0aGUgcG9p
bnQgdGhhdCB0aGlzIGlzIGNvbmZ1c2luZy4uLg0KDQpUaGUgcmVhc29uIEkgZGlkIHRoaXMgYmVj
YXVzZSBvcmlnaW5hbCBjb2RlIGhhZCBrZnJlZSgpIGJ1ZyBhbmQgdGhhdCBidWcNCndhcyByZXBs
aWNhdGVkIGluIGJvdGggdGhlIGZ1bmN0aW9ucywgd2l0aCBmaXhpbmcgdGhlIG1pc3Rha2UsIEkg
YmVsaWV2ZQ0Kd2UgY2FuIGF2b2lkIHN1Y2ggcmVwbGljYXRpb24gb2YgY29kZSBhbmQgcG90ZW50
aWFsIGJ1Z3MuDQoNCi1jaw0KDQoNCg==

