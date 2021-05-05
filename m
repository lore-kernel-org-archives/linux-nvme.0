Return-Path: <SRS0=YFbx=KA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A14C433B4
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 20:24:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7DCE613D8
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 20:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7DCE613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sO4dk4C68NewHgacMYd2r12pHBm0vPKv+em6FID+xc0=; b=Ao4oh6Xv4DWmge3incfJvBKMK
	OR97cbLsem9gitYxdP6Of37zb2Z20ICoupczAKOOZLP8dxnPkospMnFo7BFs1R/2nF+5W57rGcrJm
	QukU04hehcD1k9PLRhx1nyG72MTxv4e67TIIz6UQuyj32IbugaWnMtUdCR8Ol9rYSIAaLXXE531Su
	WQnE+QcAWrLFKTujN+DgBgvMOu38Lw19guiuufQ4GZsZTLV7Id+FxDeFPtao32c36V7jfByR6q6pu
	/UFIkYowrAOEly9ZBoi3FtOxVlOWXDyXRkfjVj9RQ52osKv/Qm9/mr0THgmx3bp7sfUfnAJs37kVi
	oRBnhumgw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leO3r-002G9a-MV; Wed, 05 May 2021 20:23:59 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leO3o-002G9C-GJ
 for linux-nvme@desiato.infradead.org; Wed, 05 May 2021 20:23:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
 Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-Description;
 bh=4mjVIBBID82ByxVpBm12HvLgLe6smzm08Go/T6ea3mM=; b=AOJLhr5KHRWoQdLul3BulQyU7e
 BNAAa2ocw/snVzkLXq6CsikPq/epguxVl2c6oA5C2i/4x+21BTorRS8lugiCjLeVeNTuvufdjDhyX
 FbKbB9iOm2Sd27dl9Fbuu9Fl/qKCj4zup/T3tdVXDr/alBCEuta1qIqrXSA6X6sbTIEEl0TAp5QQF
 Wrn7/GYdqfepanq3Lm/itrfzNA4KqJRIOPF/hlo+iYwFyLCY1CHJOKPSRfeRJw8JuC6HvGcqfFL13
 jWBW0hjC9GK7bTjqL4q187OWlhjdOa5KZp9my2Xf1OwwlmlM9gS6t+5WDT24zIYlZzKmNzlkbqWwm
 92B5gyQg==;
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leO3l-005F3H-Sy
 for linux-nvme@lists.infradead.org; Wed, 05 May 2021 20:23:55 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 145KKOMw048885;
 Wed, 5 May 2021 20:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=4mjVIBBID82ByxVpBm12HvLgLe6smzm08Go/T6ea3mM=;
 b=I02Dc2HSy1VyjuOyV7oeeQAeOh5uDjKIHeM7yIpW/FOsULAUXDb47uaUweupyyQqiYiK
 J/DVOnqIaCampeIdRm7Vvdsv/vMK/BWv1Le9MhCUmWso7UJGbjHDU0htRdn/JCLYthsO
 S2TI383roGwckdOheWcuytiqktCsYXCYEKjFVWo2/qHliwPhBYrHvYEPCHssv9WTqgvU
 hQALKkD+qrPKBKhEggIPOBb3EnNllzYnkPVL43tiIP53epA1c2iy1WexCWdveE2khDxK
 dTP5GMSvXgCT6binUTeUDuqKXwGk/qBEhH9teu/CIH9CWdmVRv8LVZ0sPFedxaS8eTa9 yQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by aserp2120.oracle.com with ESMTP id 38bemjk2h8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 May 2021 20:23:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 145KLIhh116098;
 Wed, 5 May 2021 20:23:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by userp3030.oracle.com with ESMTP id 38bebu3eua-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 May 2021 20:23:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgXjZ88I6qI1N3SDMAh970cFPGQV/PxhssUM/wQNixmvG+9qMa2InzUXXf68hQXHK8IhSekp00t8l+GzcP2WTEjtfvp/4Od+mu33+U3y1Jys5zNmW2rdaJXxHPwUuJnokole1tAIVD4by3JYamLH3deWyk2leeCPYVwDf/TgpyrXshfRBAjJMg7aoQt5+bCUDn4k/LOnMBlY019WotPI+0hmg4gCfVktfBoKsAJQR1poVlu+gV/OffCV76rJKkzQytky7Y201kypeQw5KzZ2Ye5Tr65srlaun2VmHI5o/xY6tmjozCqluesid7MqlqM+h6vHqVk/O+WUJ5vuYWCXeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mjVIBBID82ByxVpBm12HvLgLe6smzm08Go/T6ea3mM=;
 b=RQmnwRr6ON3IuVwPJa2B9lNq0YmaMGSqA5qf74ng9n8KA6FeHNtkYtTusaEToXybRWjZ4zrrcQqO62MkprNHa1c9FWcbsxajOo8VrYqCBHEoavlgiBH0tqIfVcIiV+wFUGKBr+u2E3WmP9h8QlheNEJiu9LYLCkZD+hFE8SiIu7N78u9xAD9UwcCSKBo3aZZc7wLeIcjyHWkZPyy/jII99xmwNA5tSu3G4UWUnER0WERzOUUUTzm194csNlNM7farYKMeLcsdrh4UIdAdRE1ECMPGqpAkE37qedjyEntzDpz909EPv+PqhsNrBr+SiTUN7ler//OzfhisjnMJOH6+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mjVIBBID82ByxVpBm12HvLgLe6smzm08Go/T6ea3mM=;
 b=AvGoN2oPo6/UcPT1qUPWmvAlebqQqcsoe8GolejejNHh3oDvSf7UBHx62RE7fHCOvmA7MCHrpz/JA7062mgLfQ5dn+S5rqoLO2VvaqmzA+XI9n+CsLhvw56fDTN5I0nvGnsfnsMctcQgGElnnCZVZW8Hnr9K9NrDoRnp4bwoNxA=
Received: from SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17)
 by SJ0PR10MB4749.namprd10.prod.outlook.com (2603:10b6:a03:2da::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 5 May
 2021 20:23:43 +0000
Received: from SJ0PR10MB4815.namprd10.prod.outlook.com
 ([fe80::5863:301d:619f:97c1]) by SJ0PR10MB4815.namprd10.prod.outlook.com
 ([fe80::5863:301d:619f:97c1%6]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 20:23:43 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>,
 "axboe@fb.com" <axboe@fb.com>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/1] nvme: Export CSTS register via sysfs
Thread-Topic: [PATCH 0/1] nvme: Export CSTS register via sysfs
Thread-Index: AQHXG26dbipyKKgQXUmKwfMgG9mkE6qJKjcAgADGWgCAAAaogIAAHgKAgAASy4CAALnSAIAAjooAgAACPQCAAB8UAIAAAnSAgEnxVwCAABk9AIAAA32A
Date: Wed, 5 May 2021 20:23:43 +0000
Message-ID: <07E6C0A9-D180-4A4E-A10E-2423094E71B2@oracle.com>
References: <0D18CE6C-4390-4040-98A6-14204DE33253@oracle.com>
 <20210318165213.GA31675@redsun51.ssa.fujisawa.hgst.com>
 <0D017D65-3D7C-4165-B25B-21E6A6FFDED5@oracle.com>
 <20210318194653.GA2690@dhcp-10-100-145-180.wdc.com>
 <20210319065158.GA11263@lst.de>
 <20210319152208.GA3794@redsun51.ssa.fujisawa.hgst.com>
 <20210319153008.GA14280@lst.de>
 <49CFFA55-5A71-4C0D-8816-11EB88087AAA@oracle.com>
 <20210319173009.GA4198@redsun51.ssa.fujisawa.hgst.com>
 <023A7AD6-3606-4C3A-8D16-5E65A55551F0@oracle.com>
 <20210505201114.GA1186772@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210505201114.GA1186772@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [75.80.184.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fb9ce47-7bb9-440e-9da9-08d91003adf0
x-ms-traffictypediagnostic: SJ0PR10MB4749:
x-microsoft-antispam-prvs: <SJ0PR10MB4749A5641C37EE0B5C308E63F4599@SJ0PR10MB4749.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G7Dr0hPoa7jkPnxt22cvevxG3ErTJeCHnRvfAW3C1wAxPokNepBuKl3VxqTPzFxsYGXrhIzvIZ3lfI340y5idzp17qo14aZ23wELRGfczyx+GvwtGJrVz5QVjipmY3RUaK3qJT0K+Rifz5iyjr3NaTeA8YHH0UyWhQtpwvrco+deJzszyxnSi00E+hC122iZacNqTaET1Do2FrZsM+5Bg2oOLvMBCBLToonoa2HBcblChk/CO+H2xAQKjgsrX7j2qXvlyGjQjFnqIR5WPrNIBSdjT3ednLh7GZUnxpx6QogMVJdJuVdUwYsWFxx3PggI6FTD/leHo46c4ZdmRdSVKSKDpaDtabLHf66XLfbdgQRF61rQXGbIZaW6ho0KtOTbqnuLGlY/Q6Xd17H6L3kq4ibgAwu46ucxwQTrnKSGs7UfUjmCE+z5zlRGqfXbz7ReLRY1KCJT9rRDYu4UKTYX9U7gJawzwrrdbHhprExHbUP0Oz1/hUmTB74HlCIUyl3pILTyYi5fc2UK0hzUu2MbC9L+2eJO5PrRm1fCRv5Ex6PG7xT6DsvbcmaiIvddAkmLXBDkTyAUL+VxrGwKP7qf0LBBjv+ukEHQFV8a7r3t+2elSz58XH7NSE+ME0PNhYOFA7rM2rxnGl3HaAEnGvErJjesgTsQHvIFA15p0PBo0G0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4815.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(396003)(366004)(136003)(39860400002)(346002)(6486002)(83380400001)(6916009)(186003)(8676002)(54906003)(86362001)(33656002)(36756003)(6512007)(71200400001)(44832011)(26005)(2616005)(6506007)(53546011)(4744005)(5660300002)(64756008)(66556008)(66476007)(66446008)(2906002)(4326008)(76116006)(38100700002)(316002)(66946007)(478600001)(8936002)(122000001)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?bUpLamF0T1Q3SDlCaGR1RHdRNlhWMWhwM3JUN055aDZDSXU1bmxma243b09Z?=
 =?utf-8?B?VlhHNExKR3VxVEI2dzhYRzZISXE4VmZkYmk0Rmw3UENSNHJnZTFmbGRJa1ZG?=
 =?utf-8?B?c1REaHprbFpNWk1NZFB0QXAyMXlrcy9SK1ZqTWVDTlZJMkRxZnF5MzdLYWdT?=
 =?utf-8?B?Vys0QkF4SXJweHBWbFYrVVhtTGUzM25QZWpLZWxQeC9JSFprSlUzY05rWkhN?=
 =?utf-8?B?NkVHY2NzZ2l0ZmpVSGl4cUs0elpoL25jeU1rVWFGTnhiYVdOVFlkUFVQVFJE?=
 =?utf-8?B?M04vU3REV2swa1REalJYWDdBaEhqenBkS0xpeEw5VFFaQ2xKNk1OMUx2RnJV?=
 =?utf-8?B?Qk1FMWtndlVTbGErWGJveWhuRDRCcDVxeDRyUlVDaERjcUJnWDRjTGVkSUNJ?=
 =?utf-8?B?ZHVPTVpIMnNCc3l4L2RnRVR5KytHemhvM3crWXJ1b2NFelVxWEpZT2w2dUlp?=
 =?utf-8?B?TUY1OEV3SWxadU8zQlFiM0tUWVZMSGJRM1h4b0FwbWZvOUU3eUorUGJ6cTh4?=
 =?utf-8?B?NFpQdllnaElRUVkzRTQxUjRNRldpU2UzN1BDT3Z6YitPeWd3VncrWHRrSWE0?=
 =?utf-8?B?SWQySkMvV1RqeHNPcE1ONnBUYnA3MXlUSVhpY2VEWFpsZy9JdXE5OHFYZ0lU?=
 =?utf-8?B?M3EzR3lOUDg3aEpIYS9qem1nSlhwYUJBNkxTZkNFNWFMbktTeEE2OHpNcW14?=
 =?utf-8?B?SVdNVEVySkF5NStEZ3pHRWlSc2F4dk84MW10ZWY3enl3Rm5FRElLWDF2ZTFP?=
 =?utf-8?B?V1RHcUlldW9zT2NoTkYyK1JnMEhrSXFPZ1RqRlRPOXBNdU1GSEhWNnlENkNX?=
 =?utf-8?B?Q0d3WHU5akI5czM3eHo3ZWFuVk5obm1IUUE5UUZKUnlZNndMY2ovTHJVZ2xn?=
 =?utf-8?B?dGVyUm8vNEpmajdHbXhZZjBQbnV2VEw0Uk5DazY2R3RxUmdaN2g4S3dqY1JX?=
 =?utf-8?B?TXdqM3lRSjlBVmxiSGJpT1hWZTJVTm02cThBUkdXc0pDMTY0WkhNWklaeUxz?=
 =?utf-8?B?QlRlT3YvZk9yU05Ec0UybGFTSm92WHZ3MVdvVUg0UTNkZThwcDlqT2ZYNXRi?=
 =?utf-8?B?NjQ5VW5TMThhcXJpRCtUQ2V2cHlpZUVhZ3pMUkljVnJ3T1p4WEZUbk5OVXl1?=
 =?utf-8?B?U0hKYXczdlI4NW04SVhXR0c4akZidWpHMXlCZEdQdVAvbVNRRE5sdzdWRTly?=
 =?utf-8?B?S3cxWFE0RFQra0pTb08reS8rYjk2V0V4MlVnc1ArMHdBVkQyRHNPQ0Q5eFhj?=
 =?utf-8?B?TEtnSW44eVdvVlhBbk5uSzRrclRSYWxQejArNXV0bGYwcS9zNnFOZ01ITHlD?=
 =?utf-8?B?U1hpMDFlYnI5Y2dyRWx0T2VZOEVMempLbER0emdHOFg2UXJkaTlHNktqbjR4?=
 =?utf-8?B?bXF5WFRNTEwyMEU0bUJIZFAzNVBqaGhjV3pnMUNKUm84NWlKdFZsUFliU0Zv?=
 =?utf-8?B?SFhuT3pCa05tZjNxOXZlcTB0UlJ3aTNYZjRBN1orUDFlMXpmVXZmeHJLbVJ1?=
 =?utf-8?B?ajR4Nkg3RWIrWGJzZk1RRkc4YjZmc0pVeGVwVEdMeWRxcXg4Q3lzdUd4U2N0?=
 =?utf-8?B?dVl1a2RWM2RnWVJlbXFkWUx0aXQxN2hQWXBFMmpqMlFZYTRwU3BmK1BuS3NG?=
 =?utf-8?B?Y3lyRVE5VDJ5UDhtNWtld1NHeGdLY2UxWnI1QzlTYkVxSmRxdVJHc1RieUQy?=
 =?utf-8?B?bzNQY1Z5b1N6YXg3R2lPdDdSYmVZcXdWT29NbHljUVpEcW8zNUhTV0tSNmJI?=
 =?utf-8?Q?N2oN6h6xYp/Us8WzfnKtSdHbrcANSLSOMvxcsn/?=
x-ms-exchange-transport-forked: True
Content-ID: <EB38050A9A485747BAE825E4A5068279@namprd10.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4815.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb9ce47-7bb9-440e-9da9-08d91003adf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2021 20:23:43.8361 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Z+OCEhRFu3vhVSRifYGrGWaaVIA71EXCPIxR3HPH+CoyF5uDnGFobIUhBHYv+n7V5dRlgou5OD2RzBF3PyEtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4749
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050140
X-Proofpoint-ORIG-GUID: 5YRV5ske-RCMJPe_Ky5-aNqfpUaA3lvG
X-Proofpoint-GUID: 5YRV5ske-RCMJPe_Ky5-aNqfpUaA3lvG
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9975
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 adultscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105050140
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210505_132354_044044_2CCCB115 
X-CRM114-Status: GOOD (  21.75  )
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

DQoNCj4gT24gTWF5IDUsIDIwMjEsIGF0IDE6MTEgUE0sIEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2Vy
bmVsLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIE1heSAwNSwgMjAyMSBhdCAwNjo0MDo1NFBN
ICswMDAwLCBBbGFuIEFkYW1zb24gd3JvdGU6DQo+PiBOZWVkIHRvIHJldmlzaXQgdGhpcyBpc3N1
ZSBhZ2Fpbi4gIEluIHRoZSBvcmlnaW5hbCBjYXNlIHdlIG5lZWRlZCB0bw0KPj4gZ2V0IGFjY2Vz
cyB0byB0aGUgY3N0cyByZWdpc3Rlci4gV2Ugd2VyZSBhYmxlIHRvIG1vdmUgdG8gdXNpbmcgdGhl
DQo+PiDigJlzdGF0ZeKAmSBzeXNmcyBhdHRyaWJ1dGUuDQo+PiANCj4+IFdlIGFyZSBub3cgZ2V0
dGluZyBhIHNpbWlsYXIgcmVxdWVzdCBmcm9tIG91ciBtYW51ZmFjdHVyaW5nIHRlYW0uIFRoZXkN
Cj4+IGFyZSB1c2luZyBudm1lLWNsaSBzaG93LXJlZ3MgdG8gYXNzaXN0IGRlYnVnLiBUaGUg4oCZ
c3RhdGXigJkgYXR0cmlidXRlIGlzDQo+PiBub3Qgc3VmZmljaWVudCBhbmQgdGhleSB3YW50IHRv
IHVzZSB0aGUgcHJvZHVjdGlvbiB2ZXJzaW9uIG9mIHRoZQ0KPj4ga2VybmVsICh3aGljaCBlbmFi
bGVzIENPTkZJR19JT19TVFJJQ1RfREVWTUVNKSByYXRoZXIgdGhhbiBhIHNwZWNpYWwNCj4+IGtl
cm5lbC4gSWRlYWxseSwgd2Ugd291bGQgd2FudCBudm1lLWNsaSBzaG93LXJlZ3MgdG8gd29yayB3
aGV0aGVyIG9yDQo+PiBub3QgQ09ORklHX0lPX1NUUklDVF9ERVZNRU0gaXMgY29uZmlndXJlZC4g
T3RoZXIgdGhhbiBleHBvcnRpbmcgdGhlDQo+PiByZWdpc3RlcnMgdGhydSBzeXNmcyBhdHRyaWJ1
dGVzLCBpcyB0aGVyZSBhbnkgb3RoZXIgbWVjaGFuaXNtIHRvIGdldA0KPj4gc2hvdy1yZWdzIHRo
ZSBkYXRhIGl0IG5lZWRzPw0KPiANCj4gQXBwZW5kIGtlcm5lbCBwYXJhbWV0ZXIgImlvbWVtPXJl
bGF4ZWTigJ0uDQoNClRoYXQgcmVxdWlyZXMgdGhlIE9TIGRpc2sgdG8gYmUgbW9kaWZpZWQuICBX
ZSB3b3VsZCByYXRoZXIgbm90IGRvIHRoYXQuDQoNCkFsYW4NCg0KDQoNCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0
CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
