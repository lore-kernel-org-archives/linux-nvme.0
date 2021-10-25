Return-Path: <SRS0=jIqL=PN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A520DC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Oct 2021 08:47:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D0E604D2
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Oct 2021 08:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 40D0E604D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ujVGa3NkdBhcKqYrGzS6eqC7/tPCdrxPfYenHsHMMxs=; b=2r6R/hE0O35ieWjSq5XaKl4RFp
	9/bbj+t9EYJFFsT0ryGl6bq3MXZW4cJdwdolJBhW1g7y/AtCZaebBsNsoiwqDmI3CBuJLd/q36IS5
	gDaZ88evLvA3gkVyJGFHkKi/jfKTsUbTOwPs7wrZ8Pg7Cr4QbLIBgeUvsQBEmBn7DydAv+2XwsGDE
	zw4cN/VJqq0a86qUuOYWg2VJEajHFT/PeWE2PwDDC6AvuuW3xwimi1wQIH3m3rShg4MS646QK7lLL
	f7Eaojg6Jg7Lk8kpMfrGmSfWxyWssVYtQjcBCavAkKWW1KfDT5qILH6arQZ2vyS+Rv1XOQVr7foX6
	knjKon2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mevdk-00Frtj-GC; Mon, 25 Oct 2021 08:47:32 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mevdg-00Frsy-QF
 for linux-nvme@lists.infradead.org; Mon, 25 Oct 2021 08:47:30 +0000
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19P0sKkc028063; 
 Mon, 25 Oct 2021 04:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=ujVGa3NkdBhcKqYrGzS6eqC7/tPCdrxPfYenHsHMMxs=;
 b=lbsE20HYdRvGFdUHD8U+/GK95sZLCoUbgW/UW+b3YhEwKgcawm4kLlS2KhKEiSF5LVIR
 GAXh9jeVclYkypcLfTonPaNF4Q/uL8bHhgMc2RfJ6F9wDX1D+AVqx1MxRcpOXo5MVMfM
 g8oZEIevlWZBN1Zdk1Dizq0Sq3zRhMvhO1X3ONqgU8S95k3cPOWFxp//UT4/ZZwLWwVd
 kWBDRCjSIB5/UCmld8KDJlRxUWR9eDrj2IarlJzyJ5VjxeYzSlHSF13AzlxOAPsTEmnf
 eXc5kIwxiSiKWuTBLx3x2BOWdldaJUDx3uan7hNaMXKAV8fogilqBeCWG+l+Imz+2Vvf jA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 3bwjev99ts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Oct 2021 04:47:17 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 19P8duSB190037; Mon, 25 Oct 2021 04:47:16 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
 by mx0a-00154901.pphosted.com with ESMTP id 3bvyyjjxyy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Oct 2021 04:47:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jts/BJsBhoPRcG1T8fvyv9FCEDCzVOriI3+UxapbsqmfBHvAyWqg5Rly4n4kXIEBpDNkVvGEwoD94oG9NBE7/C6JkcLQIc43Vm3DevV+d/A9SujTfBD71nXEcMIC1JDH91gCLv9w5Q2rthAD8UMB2q1qtUcRgCLrhH9KvZWlEAsEdIs0V6l7+J1Beax0Ugh2hhs9gCl0ZEyMk2HIcKGgZi0tmybORt5J9lQkJFKhQXCY1l5cA57veul7xYiEJahxV8KyxDmH+dr6r+e76r4zj6d5Ib/I2aYIwl77mRpolOW0ELuteZQ90C/274hNOcwMd1X8BmYI1JqcysgHKxXosA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujVGa3NkdBhcKqYrGzS6eqC7/tPCdrxPfYenHsHMMxs=;
 b=T4YasMQVZ6v91nSCz+EDCEOSOWmfzlNJitRNTx+w2W++qs2u+qRoSeiCJ+xMAusks4nJIYkZSOaOsdPIAq6eFTTGxHBM2zDtx6Ey7uW19tlJyoyrveBibnBDB0/Ze96Z/rrvPgpE8R9nNUCbWOm9NVHFYFOasEtfC8dwwR5p8hZ9Aoxe+5ynjNe/yG0r3vp8uaHN3NJ7KmYx0Imwb73XWl26YehnobBPvJsbF8FoSfeDs8SX+DehsTPyyAOLShk8dfwPIrHeS+BQhJOV5Sz9YjB19YIMXp+TNxeeeUAdFCHnc4bglEJyJdMHh7M1MjqvMro+3am/HycIml8WCPsUKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by MWHPR19MB1406.namprd19.prod.outlook.com (2603:10b6:300:cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 08:47:15 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::7d75:a751:e366:2bc6]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::7d75:a751:e366:2bc6%8]) with mapi id 15.20.4628.018; Mon, 25 Oct 2021
 08:47:15 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>
Subject: RE: [PATCH] nvmet_tcp: fix header digest verification
Thread-Topic: [PATCH] nvmet_tcp: fix header digest verification
Thread-Index: AQHXxN0a4q6RYcEmW0GV2etyjeOl+avaPSUAgAAm1hCAAcj9AIAHPKyg
Date: Mon, 25 Oct 2021 08:47:14 +0000
Message-ID: <CO1PR19MB48856AA2F52E022418DEA773EE839@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <20211019113307.31852-1-amit.engel@dell.com>
 <2f46c62b-a8c4-5d48-17c4-ac33dec8a318@grimberg.me>
 <CO1PR19MB4885C691C3B1B15AA139A9E0EEBE9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <4a71a194-c715-a38d-6b3e-560eae714451@grimberg.me>
In-Reply-To: <4a71a194-c715-a38d-6b3e-560eae714451@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2021-10-25T08:47:10Z; 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=2431a25b-5e03-43ea-9522-9fe62ca147c9;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=Dell.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6c17e1f-7203-40f3-61b8-08d997940b4e
x-ms-traffictypediagnostic: MWHPR19MB1406:
x-microsoft-antispam-prvs: <MWHPR19MB14067A24863261B61CF88A74EE839@MWHPR19MB1406.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B5Twc2dh7BjnATHGlCHEFj5WVIlYyhH7qpq78FHaGi+OKP3WAwMzsOlXQHl0rzvF3IECNITkybdfI8xH/MP9PKyF1hvO8YyPMiq0d9kFsOX8x4TXu3i8LWlA5CH+gBvHxv78+XkG8OdBxw2V9QFD1JhJHh3Xc8TR+LC6sI1X4i96ymUqZZUxA8w0XJNCyD+1pOQx8DMtr1Eptfp3Su94R2qfAJn2L9BG1HVGqjLf3h94nFm/ofOmhDqFtGT14jgDRNEVafmtMcx0Pp8vwI2iQ9WyhrGRzWr+rIxp3bHSUai4vR1deL8XxXWCXUVNGU0weItjTXKOnjFFpMfhAPCkS0sfU5JUawmUYDtRou0MSuQ4dIp98udtjayJpyKuHr1IRBt3lwHt1DJdRkizudd5m1eeV/4wYeGCQeFo+QzCdwwVMQr1bv/NMx8uQC6mOFDu8HVBAniMeBDjcDlKOe1J8ninmUMoUwtn4JCtEptosmg4piw4Jgar+++ZJ1rL/wVJiKdp6yzYIqg/VFx8AAuyQnTRV/bAI3PlNPGeE21RDwXXav5L6hR14mbqLXwCfSCZ5cZWqJaT0NQCY+mG9Ytz5/SoyvsEDhd/6aPPnwTJN/hYto9odYUtyPCBetXUgflbxnsmbuzcA9wvKj/Z0mupRhfvAiCXuWdWx1Ca4jlWK3q7WH0rCFeMyRV7W2wwu/dse47aTJffjMS/Bf4Z//Qx1Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR19MB4885.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(7696005)(2906002)(5660300002)(6506007)(52536014)(15650500001)(186003)(55016002)(122000001)(33656002)(38070700005)(86362001)(38100700002)(26005)(8936002)(53546011)(82960400001)(83380400001)(110136005)(9686003)(66476007)(64756008)(786003)(66446008)(316002)(66946007)(508600001)(66556008)(76116006)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGwySVZXb083NGFTcmNrSllUWTFjc3U3Y2srTlVHa3lHVDdsYkdhWjc5WkM0?=
 =?utf-8?B?ajU5K1A5MCtqVTZjSTNFMWQxUkpBQlNRc2lsMFduRi95RnFremdocUhKemNk?=
 =?utf-8?B?V3pGaXVyT205TXdaTGFuMmpuaXplNXhmZ2NoaTlSQU1INjROUyswZFFBWlY4?=
 =?utf-8?B?bEZhWkg5aVhBZE5hUmpCQTNGbmdFVzFxZTdDU21DVWI1eE0vRkt6UnpmcU1P?=
 =?utf-8?B?bTkxMWx6MHZLRVJNeWZFVlBKZGFrN25ubWthSkdETG9FbkRCNDlOemlIcnl3?=
 =?utf-8?B?blhpUDRoWjlNRkZlaTd5UGdxZTB2REVQMlZ4RXVNUzNjdGp6aU9hZlhuWnkx?=
 =?utf-8?B?OThtSUxVZEM0c20vVTBkNUlkQmEvWlc3Vm1qR1lQUWFYV0plNUhaWkJwQnVl?=
 =?utf-8?B?SDdtNXhRWTFwM20raUp1c0VDTkd5aEZTMFBKTXVzTUh4RW5aSWNpUVQ0OUEv?=
 =?utf-8?B?ZGhFZEg2alQ5WHV1akNpN0J0TldVeHlrRFFJdHBKY2dXSjg5a09keGMvUmwx?=
 =?utf-8?B?NWRrRVRnaHY0Mlc1dmFzOTYrSENMRFdmVHZDNzEwUXhLRkhoYlVmWVVVdEYy?=
 =?utf-8?B?K1B3RGVvOHlpVWcxbnp0dVh5WDlHYzEwVm1lRDVCbVhKUG9zemRyOHRxR081?=
 =?utf-8?B?WUZpU1M5QUxPVGdZUmZhMWJkL3doYWhSVUNGNmZMUFRyN08zM3JPY2NLTWhw?=
 =?utf-8?B?eUFnc3IzdCtteERIWTZ5ajI1V0NvdXFBcFg2a2F5Y01IbmVNcFJnZ2dXbTZX?=
 =?utf-8?B?dTNNUTBIalBma2NUYlQ1VEJYRXNXOXZaVVM2RzhySTRqSlFOemlmRnNrNDFL?=
 =?utf-8?B?cDRWb2lGVnFvbE1xWFVaN1J0NTArK1htTUJxcExRdHZONGRsSHJVNVBQdGhR?=
 =?utf-8?B?OFZxaUgxNDI0UVpmckJobFRpZndQZmp5d1V2dUNVUVQ2dUN4akZocUhyWDNv?=
 =?utf-8?B?L09LNWtPWFRIOWZWeDVDM0R2c0lOVEZ3enJJcWxxa0dxSjNVZDlORWJVV2lV?=
 =?utf-8?B?TS9uVk9lZkM2UWZZcGFwTEFXb05EMkdwVTN1YU1vQ0ppQTE5ajk1T1JmdFJ1?=
 =?utf-8?B?enhrSEhUc1dzSnVSYzY5UzMvQTdGbGhBOG50aHpHMVRXWGVGWElGWVY2T25Y?=
 =?utf-8?B?dVNDSEpQUmVZNkxPNVo1YWpvMmJEZXQwb2RNTFozbEF6MnBEMjhBU29sNjZ1?=
 =?utf-8?B?VVNwbFF6TWlhTWVGbHZaVGJlNk5EQXhLcnRKczVZeWVuakwwZlJxU1kwU1Zp?=
 =?utf-8?B?d3hFSDQvaGZ1T0h3MzFLMEVuYmgvRHBqOUFFdWtZMWNEODl0VmZXYy9URkxx?=
 =?utf-8?B?bWpCdjc5SDFlVnI5U1M2Vm1JNkVYeWlKbXBIMGN5N2pTaFYrNmlnKzk3bkdz?=
 =?utf-8?B?azhKU1REUnpEaVp2dERsSEd0b01NaWJMZlQ1bVRuWnRaODEvdFhBYXUzVnV2?=
 =?utf-8?B?cjdRZjNsUGUwYmJST0JoRWxvNWF5U0NyaWMyS2lLdXA2V0xoRXFDY09UWVh2?=
 =?utf-8?B?T3VKdDhEQ2JybEtVLys3bW92OTVGQ1FubSt6V0I3Y1ZOQnJHemxFK3RmVHBw?=
 =?utf-8?B?TGpCZml1S1hZNUtaNkgzOVdlcmJoT2pKK0Q4N0RUcmN3RVpEc3VteUFzS2JD?=
 =?utf-8?B?VGZiTUNzWFo5Y2FNLzFkWWFQNE9OS1JyNjdCVnBPVzF0ZmJ0VWx3SW8xRndJ?=
 =?utf-8?B?bElxM1haQWFwRTl5NGxaLzhaYnB3TlVPd2FwN0hEY3pYS3FvczdNUWxrOW5x?=
 =?utf-8?B?d3EwcEUxZnBHMHlpRVhMUmNlYW0rcEdtSmJnNmFOVFgvOWl1ZEZkelpzaldv?=
 =?utf-8?B?Y3BCT24xVkpFQktMdUFUREhPeXBRaGViUU9XMnhJMkptUTQyMlRORTF2MHBx?=
 =?utf-8?B?TUtZRXdNdzVYMng5MG4vajdZVDJOd1QyblhIa1pKQUk3dGI0aE1BK0h0WUUr?=
 =?utf-8?B?T0RMWnprWm9PaEQ5RnB5eWZYcjFpUElWa2tCNkN2L0ZCM1JBUllsNzUxQUpR?=
 =?utf-8?B?a1JHcXlJa1ZlOS8zbzRJSmllemVqNWFuTFpBeTNqalFLNUVkbzlha0VaWjR4?=
 =?utf-8?B?MldVLzBCdFkxYjhVK2RwUkxlNmNuQnN2Q0xGSlpjWDU3Mm5KQi8wcXlLMnpy?=
 =?utf-8?B?OVRFbVhMcTZLNTJuN1E1dStGaERWNkQxY1N6RTJqMERteHZNS293dUpBZ3Qr?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c17e1f-7203-40f3-61b8-08d997940b4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2021 08:47:14.8165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /MHyq5MOLEni4HkCdoStEm5+U8fi2WozaB/Xfc58ZYIOkJDyh7kiPeV26wriQH2/Ks9j6PviHgxpC0Uea5C2SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR19MB1406
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.790
 definitions=2021-10-25_02:2021-10-25,
 2021-10-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=848
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110250051
X-Proofpoint-GUID: H168jCtOZ7sXuhc0jCME_c77wp89xo9p
X-Proofpoint-ORIG-GUID: H168jCtOZ7sXuhc0jCME_c77wp89xo9p
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=990 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110250052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211025_014728_923707_C1320A91 
X-CRM114-Status: GOOD (  16.08  )
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

SW4gbnZtZXRfdGNwX3RyeV9yZWN2X3BkdToNCjEuIEFmdGVyIGtlcm5lbF9yZWN2bXNnLCAncXVl
dWUtPm9mZnNldCcgaXMgZXF1YWwgdG8gJ3NpemVvZihzdHJ1Y3QgbnZtZV90Y3BfaGRyKScNCg0K
Mi4gdXBkYXRlIHF1ZXVlLT5sZWZ0ID0gaGRyLT5obGVuIC0gcXVldWUtPm9mZnNldCArIGhkZ3N0
IGFuZCAnZ290byByZWN2Jw0KDQozLiBhZnRlciByZWN2bXNnICwgdGhlIG9mZnNldCBpcyBncmVh
dGVyIHRoYW4gdGhlIGRpZ2VzdC4NCg0KU28gLCBJbiB0aGlzIGNhc2Ugb2Zmc2V0ICE9IGhkci0+
aGxlbiANCg0KVGhpcyB3aWxsIGxlYWQgdG8gbnZtZXRfdGNwX3ZlcmlmeV9oZGdzdCB0byBhbHdh
eXMgcGFzcywgd2hpY2ggDQoNClRoYW5rcw0KQW1pdA0KDQoNCkludGVybmFsIFVzZSAtIENvbmZp
ZGVudGlhbA0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogU2FnaSBHcmltYmVy
ZyA8c2FnaUBncmltYmVyZy5tZT4gDQpTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgMjAsIDIwMjEg
ODo1MyBQTQ0KVG86IEVuZ2VsLCBBbWl0OyBsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmc7
IGhjaEBsc3QuZGUNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIG52bWV0X3RjcDogZml4IGhlYWRlciBk
aWdlc3QgdmVyaWZpY2F0aW9uDQoNCg0KW0VYVEVSTkFMIEVNQUlMXSANCg0KDQo+IE9uZSBvZiBv
dXIgdGVzdHMgZm91bmQgdGhhdA0KPiBXaXRoIHRoZSBjdXJyZW50IGNvZGUsDQo+IHJlY3ZfZGln
ZXN0ID09IGV4cF9kaWdlc3QgZXZlbiBpZiB0aGUgcGR1IGhlYWRlciBkaWdlc3QgaXMgYmVpbmcg
DQo+IG1vZGlmaWVkIChzeW50aGV0aWNhbGx5KSBGb3IgZXhhbXBsZToNCj4gSW4gY2FzZSB0aGF0
IHBkdSBoZWFkZXIgZGlnZXN0IGlzIGNoYW5nZWQgdG8gMHhmZmZmZmZmZiwgcmVjdiA9PSBleHAg
DQo+ID09IDB4ZmZmZmZmZiwgYW5kIG52bWV0X3RjcF92ZXJpZnlfaGRnc3QgcmV0dXJucyAwIC0g
d2hpY2ggaXMgd3JvbmcNCg0KTm90IHN1cmUgSSBmb2xsb3cuIENhbiB5b3UgZGVzY3JpYmUgaW4g
d2hpY2ggY2FzZSB0aGUgcGFzc2VkIG9mZnNldCAhPQ0KaGRyLT5obGVuPw0KDQoNCj4gSW50ZXJu
YWwgVXNlIC0gQ29uZmlkZW50aWFsDQoNCklzIHRoaXMgY29uZmlkZW50aWFsPw0K

