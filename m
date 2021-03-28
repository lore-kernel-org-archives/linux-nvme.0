Return-Path: <SRS0=L4Tp=I3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E175C433C1
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Mar 2021 18:25:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D46BF6191F
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Mar 2021 18:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46BF6191F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DpusxWKFtA/eTtEEoqBSIlIhyLmC+Er97Nv7S/9GVo4=; b=UNkCjDTTD4cAlOac1vheKgJ/H
	bMK3jNJI5taedf7uZK1hxbP9QSJqc/vmcKvX0XNaVk19NfKFaSsJNO2uhAX8xk+nyqTUnbxT2sFW6
	QOhyzk14X4xcUsgEb/IuoKRePt6HMsCa7Kq309ik4PEMSwLzUsmh9AC9RG5QQWLZW5G/Cl01ehd4l
	BFqa6dTz8zlv1V6SWgrSVjPgerjO3gDB+TLYqWhMQblpN4MDSOxAsbWKl/UCHnvm8lyUpBYDkbKVJ
	3ZmDTwnYUbfXxFqe32zKLb5Cozo+f8FtvjhZZogvTn3u89umbOKOdExVzm1/kMrsV3VNcTxRDR5Wo
	CErp/8Nqw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lQwZD-0012hR-L7; Mon, 29 Mar 2021 18:24:48 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lQpEN-000aVa-Bk
 for linux-nvme@desiato.infradead.org; Mon, 29 Mar 2021 10:34:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From:Sender:
 Reply-To:Cc:Content-ID:Content-Description;
 bh=EtVV9k9gCqHTOhGpp7iXW7mpDf9hDODC4+OM4ftfhrU=; b=LlgOO66Azqh2EkGo9ovRbUgxjA
 6yagGQZPwupcr+hvKjySFJFhKkZ0ysdSLe/ObYPDc2AcBXLeZYafuGt7ki34jIR25ZO6N0gQmI9P8
 OMCY7zTESZNY6vRW3wSDZXyfFpcjlzExkdUWDaiS+jg1UCCbp9of++zsytue17z9WQ1rBaZSuSGtK
 1qzOXzeoW0x7ifdBukuInp8i/AIBOJhq9DjnC73L1WlJJ67wIQh7Qs5UfPsIZh9OtNv4DEBgyIiJb
 Nu7HDKqs8djMmhJD+HYZhVafCfZ6q6NWiqE1eD/mcyszvyBhamVCUsCkGu9ZMAhu5Znisl+YluLAd
 HlUUrIqA==;
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lQS61-00039v-6X
 for linux-nvme@lists.infradead.org; Sun, 28 Mar 2021 09:52:42 +0000
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12S9qBCO004892; Sun, 28 Mar 2021 05:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=EtVV9k9gCqHTOhGpp7iXW7mpDf9hDODC4+OM4ftfhrU=;
 b=kXf/nqmihZtH6xcVrU5jtn8lbNZfkTWEcoHWO/gh/Q8ZmGjyqkUusRGHfpTlGeRd4WrG
 QscWY7cvBHTp5YJ2S7ikF9KkWjuyukScHCFONdH9Hh9GbtSgVpKRYpGic5nTphQtSnSv
 scFJLRYwpB+52Lm8vRtyTAowD8+E6yNFzIvIGMfrQZTz7fbsDeTe9FJa4kUOm39Byf0z
 IWg9lkuy/yt+1ctVYw/S6UoQG2udXSS+JRRVcVe7dDKnV+fN+7O7WV7sEvrb4h+aIZSZ
 FnSq3hABjvBVF0gh9RIR5TPebIQpH3RW2vH2KC+ibxzCc35apAEsjpaziX29dffIYcuB ng== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 37j0hxsmnx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 28 Mar 2021 05:52:26 -0400
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12S9j1CA035455; Sun, 28 Mar 2021 05:52:25 -0400
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
 by mx0b-00154901.pphosted.com with ESMTP id 37jj19258e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 28 Mar 2021 05:52:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIBwH0rRLRwemfd2+dQmkTqrT4nSprAYYYxnOfk7sUzXcUYHPRemIzC0LgKcdr7U+hK8bXe/EHdQ1FPI+WEQ3YmAXnCRdwTboluV3s+ngG7rbKxTvP0NHNasaHtY/Pm8MyR3ejpqoESteFCsQsF4wdQe732x5WR6zpE0UVB/TamYHHRHpgJ14ZN5b7dR5fT749Unmn6kK+mbz14DnbHGulO0eBiPsnslmQ24fX4/L3i4dfG9XkDEWLrla9J3U2D8i+eH1QnCBD90paeHyHtaYXsujBtF6xMf3AtmMqyUkzGYnA1aFFch7X9aRoU1OpQ80KiEPSsI6FbH0n6dSFi1IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtVV9k9gCqHTOhGpp7iXW7mpDf9hDODC4+OM4ftfhrU=;
 b=klmKg6yPCd7Aw6Q+FrgvDtIWTrkhK4rFWVm26zcOfqVHgagGrielmh6R1r/WiIjS/DpljQqDcCNf43ds95pXOukgdu2xMl7aEq2honYKnyY60PBxMMI/Sz0fZt2KswdAJubjzxY4UIsieI07poL94bTVXvYJBbigO7w9qCSWO8vbcIv3fhneJXXYpYPjU5YM8olUvh+dav6nSAU7akUG71nr3Jbu887ImCxQeY/+ojoK/Q1G7ngxI0X5UqHr5YN1dyEvs78cjBRBrjTeljb7dtZ/Hm1bAXPEE3iwDPKPh8WyCmchkbsLCuLKBRqe+zkzKrEe8uH7kb0LXimcJynyZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from DM6PR19MB4011.namprd19.prod.outlook.com (2603:10b6:5:22b::15)
 by DM6PR19MB2585.namprd19.prod.outlook.com (2603:10b6:5:186::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.30; Sun, 28 Mar
 2021 09:52:24 +0000
Received: from DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9]) by DM6PR19MB4011.namprd19.prod.outlook.com
 ([fe80::f426:31e6:5782:14f9%6]) with mapi id 15.20.3977.033; Sun, 28 Mar 2021
 09:52:23 +0000
From: "Grupi, Elad" <Elad.Grupi@dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH v2] nvmet-tcp: fix a segmentation fault during io parsing
 error
Thread-Topic: [PATCH v2] nvmet-tcp: fix a segmentation fault during io parsing
 error
Thread-Index: AQHXImnP12JJHSExREmbK5ZJuH7cCaqWwfMAgAIbbTA=
Date: Sun, 28 Mar 2021 09:52:23 +0000
Message-ID: <DM6PR19MB4011B8E5826EBEBB5FF024F1EF7F9@DM6PR19MB4011.namprd19.prod.outlook.com>
References: <20210326175941.22734-1-elad.grupi@dell.com>
 <19a3554b-1247-ffdf-4729-0841945b76ba@grimberg.me>
In-Reply-To: <19a3554b-1247-ffdf-4729-0841945b76ba@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Elad.Grupi@emc.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-03-28T09:52:21.3989578Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=4a7200e5-e8ae-4095-9aaf-619d80efb21c;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=dell.com;
x-originating-ip: [77.126.55.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ff91a6b-ef13-46e6-b3c1-08d8f1cf3002
x-ms-traffictypediagnostic: DM6PR19MB2585:
x-microsoft-antispam-prvs: <DM6PR19MB258575798AC1235084360632EF7F9@DM6PR19MB2585.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 25G8tbuX80xqxxz824KVob/BbGfM8LOfQgd1U63Jxu0anNb7BBhS2jTiPkiRoXd6MgU1LZPw6SxP0NriF1ZAGlXn92/pGcz4/lzoAw8eDUPaMjgWwH90t82TK2iG2W0zkbl5XOnDpJFw2Dyk6ye2Dyi7KDgSIL1rOBretuFXkq/P9zwi74bVtXLuZeFLBqcrvkV/Qr6WzITEy4zo4cpr2p0s2mJZHi2e+0Xqc4/5qYwo7fvtJkW3C8HI63NbIY12wshabN6jr9RMbWZvuIZ6cC0f/rI5bEeOaAdToikOnjC+RXRW+GRrTi0CG+74yTsbwMpSRSDsKGovkzfbiXyg1gIBy28Ebs6jm35Wqi8DJIqxCFyiydnKDYv1B1jP+U+Ve8QluXpGEOdDAWOImes0UzQ1ZoN8YAG+Rdmh3B2aHVl+ylYfSCd+tb1cHead/qzOlX2qTeWZFHn0BQbKE558OU2DjuiYc4jN4NxRe0RAZBBL/f7qItFnZZmmHj97DuGd21ggbG8ZVjUL+2Pa01u4eRQVEg3Qrvzq3BIL65izzArOggGiq0XdHS0fk6F6ppCg7/S918V1JsscMPOB7B48ed5DINc+sOG/a8lo1ZMdANULdXOglynOoLzpFs4RahteGlYkk9N5/GpKuuUI4D96Wmdi8sJUxnziM27q9WQZiX0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR19MB4011.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(76116006)(186003)(7696005)(66946007)(316002)(2906002)(786003)(110136005)(38100700001)(33656002)(71200400001)(5660300002)(8676002)(66556008)(52536014)(66476007)(66446008)(64756008)(26005)(55016002)(8936002)(83380400001)(86362001)(478600001)(6506007)(53546011)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?VnpJQmpWMUZ6disrY05EUndwQXM2V3I2SU52TjQ0RHo5ZTVFQzdJckc4dlQw?=
 =?utf-8?B?aWtSSG4xZHpIWEFjV1FCTnpPUnNCMk1pOFRmc0hLbCsyMmhKOHJtcGFWZTl0?=
 =?utf-8?B?T0R4UXJvWHZWV1NqUzZaSmdzdGozMWRyRUlhMmpzRkhPN0dLckRGN1h4ZnI2?=
 =?utf-8?B?TU9FM3cxeUJoRG1EN3lSMitHVktMWlB0L3d3QTYvVlpsRTBCZ2RXWU9SV2Vm?=
 =?utf-8?B?ei9nTGRCVjdQUVU4c1owbFlYVWluN2RHVHhKYzY3cnoxOEJ2T3FSNm10ckR3?=
 =?utf-8?B?TkpBeHZtckVFR1VmTlVja0lRemlhSXpXanRQUnU3dVF5YXRkc0N1blBnWTkx?=
 =?utf-8?B?NFVFYzEvNm5rWnhEd3dQdG8rTWVGUjA2YWxwSjFSTTVQV2VMTnVPK3A0d0w3?=
 =?utf-8?B?M1pidWJwbE9pVi9mVHFoR1RleUlGWDNEL2EwcVMvTUREQ3I0SWZJWGxOeVB0?=
 =?utf-8?B?UWNvRy9PalhFeVMxRWJYU1hYRXZ6c2JXN3JmN2N1RHRXVjRyL0NnazU1eHZ3?=
 =?utf-8?B?NTd1NTBHTDlRRklpY1h6SWhicjlCaWdMeStVeVp3VHp3MWR1em9IdmRvV3Zn?=
 =?utf-8?B?TERobXIvWWlCSitydmtzMnNHNmhKUE9GNkpPdkt1SDMwdU04MHAwMUZ2MDZ2?=
 =?utf-8?B?QjNjcHBDdFJXNTV1Q2VEbSt0RGZ3cGxXR0ZUeWIrNCtKNUdoSnd0OXBlcEVX?=
 =?utf-8?B?QkYrU3pPVlE5NXNGUzBnTjNhTW5xbzkzM3kwZHZSQ0xvR3E4VzZyUHdrNW9m?=
 =?utf-8?B?M0pFVUgrLzZ1UEJhMEkwNUdRR0gyWXVHTnNUQmZZVXgzdDFIVk5RckRmNjVz?=
 =?utf-8?B?YmVoVGtkYnI5VnZveGJSRTNKV2xUNS9CUjZ2RmxVeGlITHJSZURWWVpOREdn?=
 =?utf-8?B?WDVMSVhQTTluNGhsNXcyYzZzQ01zbXJwSDZndlFxWmxtMFJGaVRpbFAxNDFP?=
 =?utf-8?B?QkFZNkRtSjkvZ0xkNUNWa0VOZWp3dWVHNW5lSkRnY21hT0I3cTJHWlU0Z3hr?=
 =?utf-8?B?bUl5MHEvYjJjYzhpMHB3RjMvSTd4ZDhFMklheFh0SEpnYXpXMkp1Z2pzVjVx?=
 =?utf-8?B?ZDY2dXBjMWIrTFdHa1NDWVVnQ2dpOTdLaCt5WmlpWmRTSGJQNmVEWVZIaUt3?=
 =?utf-8?B?U0pRcWk2aDgwcE1LVXBJYWR5V0NpalhkNXBtdkFVZDJJVlJLZWg0ZVFlVGZB?=
 =?utf-8?B?ZGhZTWNIYUVIYUlrTlk5RlhuRTgyYVoyRkZVNVBpK2JhN2xuMDAxV05pNWtS?=
 =?utf-8?B?Q3dzNXNramdqVG9XLzFkWThUWXVPbmxwRGdBSkU4RS9DazRKcTBsMXZ5S0pT?=
 =?utf-8?B?SHhUc2FRUjhnK2VZYTRFakNHNzlDKzJzUEpBdElBWXllUkZBSmhoY3l4REN5?=
 =?utf-8?B?YlloRWhGNHpkZ0Jvald1ZHFIbHFHaDZKK3kxTkJjZDlkK1B0Q2tOVEtBZmp6?=
 =?utf-8?B?MHcyVnI2S3hsTGFGOWNzdU1JREV0YTJpaDIyaGlJVEpMeGovaEUvWlNzTi9y?=
 =?utf-8?B?ZDZCYjJqcEdrR29QdkpLNG1OVGc2dzBLd1RqT1NxelpWZ1lEYk9NdnhhbnRG?=
 =?utf-8?B?MTBEMTN1dGcybXgzdngrR1hTNTRwMDkwVm1JNUxERXQvdUNQcjFiRklwa3JW?=
 =?utf-8?B?am1FOGsvbzBCRkludUQ0cUdUamRLMHdFN2Z6RFdOZUl2NmdOVlNnVU0rVlpJ?=
 =?utf-8?B?dy9mb0IyT0kxbzF2RE9aQTBzYWx2bk8xbkw5bTArNnBhNkxmdGFoN0lqQm5o?=
 =?utf-8?Q?r7N0Tj9eJrC2JIbDCFDFE5dMD/GMMXQG1qt68gn?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB4011.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff91a6b-ef13-46e6-b3c1-08d8f1cf3002
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2021 09:52:23.7021 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PcLWKG5r3Pq0+asWcxV1BKEUyOBpvPeUAwzfcMsDeszxOX1hpEN4QcQcfjFWpbrE60fDdGh1IsLhaA8t+st2tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB2585
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-28_05:2021-03-26,
 2021-03-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103280073
X-Proofpoint-ORIG-GUID: nGQH3w6uM0haTH9YQeE0L62jqJdU27GW
X-Proofpoint-GUID: nGQH3w6uM0haTH9YQeE0L62jqJdU27GW
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103280074
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210328_105238_462750_86441D77 
X-CRM114-Status: GOOD (  27.12  )
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

Sure. Done.

Also avoided queueing failed REQ as discussed with Hou.

Elad

-----Original Message-----
From: Sagi Grimberg <sagi@grimberg.me> 
Sent: Saturday, 27 March 2021 0:03
To: Grupi, Elad; linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvmet-tcp: fix a segmentation fault during io parsing error


[EXTERNAL EMAIL] 



On 3/26/21 10:59 AM, elad.grupi@dell.com wrote:
> From: Elad Grupi <elad.grupi@dell.com>
> 
> In case there is an io that contains inline data and it goes to 
> parsing error flow, command response will free command and iov before 
> clearing the data on the socket buffer.
> This will delay the command response until receive flow is completed.
> 
> Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
> Signed-off-by: Elad Grupi <elad.grupi@dell.com>
> ---
>   drivers/nvme/target/tcp.c | 29 +++++++++++++++++++++++------
>   1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c 
> index 70cc507d1565..3bc0caa47873 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -702,6 +702,17 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
>   			return 0;
>   	}
>   
> +	if (unlikely((cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
> +			nvmet_tcp_has_data_in(cmd) &&
> +			nvmet_tcp_has_inline_data(cmd))) {
> +		/*
> +		 * wait for inline data before processing the response
> +		 * so the iov will not be freed
> +		 */
> +		queue->snd_cmd = NULL;
> +		goto done_send;
> +	}
> +
>   	if (cmd->state == NVMET_TCP_SEND_DATA_PDU) {
>   		ret = nvmet_try_send_data_pdu(cmd);
>   		if (ret <= 0)
> @@ -1103,9 +1114,11 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
>   		return 0;
>   	}
>   
> -	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
> -	    cmd->rbytes_done == cmd->req.transfer_len) {
> -		cmd->req.execute(&cmd->req);
> +	if (cmd->rbytes_done == cmd->req.transfer_len) {
> +		if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
> +			nvmet_tcp_queue_response(&cmd->req);
> +		else
> +			cmd->req.execute(&cmd->req);

Given that this is called twice, care to move it to a new helper nvme_tcp_execute_request?
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
