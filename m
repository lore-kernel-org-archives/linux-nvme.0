Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612F7C02194
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Feb 2025 18:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HwmwhWszbl+kwijD4XR2MKNznP8bHsCCX+ZALnwYgvo=; b=4H+JyCxHJvEZZ+NVwd9sKywAi6
	gAoCsxZSD/W/Wc7b3SjNHGTeVIQHonqI1yv7EbFl8C5PKyrsRVRFvlNCK3QvleufJvk0IFDUDg7iL
	owPKXz/e0azNuMpp94sSG3iddy4vORsenYLGUyIbwHEcxTjETCpHxLSms55ihfPORWr+e/pw3hfvd
	KjNzIlZqSBgYSsoyRjcTm9qobHauiTXKv/RNgH9UIfFsI2Y9TrEaQ6obc373nMxFIU03A6r5fWwq4
	xvAfW4GApDx3dQ9m54PLZmKhetcwV+3a2pUZtdOMq/7Xji6w/8yYD9q5X/pzRW6GIVhWYRR66ZEqo
	eIPi0RSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgTBa-0000000Aj29-0XWX;
	Fri, 07 Feb 2025 18:34:42 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgTBX-0000000Aj1H-3q17
	for linux-nvme@bombadil.infradead.org;
	Fri, 07 Feb 2025 18:34:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=HwmwhWszbl+kwijD4XR2MKNznP8bHsCCX+ZALnwYgvo=; b=o8N339rWsVblEa7X9RhbBVHL1J
	6ShOg2qxgaOf8YROYaROTmSLTp/terdZ0O2Q77m2LiCOLfD9sMNB+wp3u5mZffb+7iZ7O0/UeZ7UV
	hPdNRjXLNR9ASlJdFIc6hiWyXqpvS3nF0w2FYv18nd4C8CmVBKv4Uf1jsYXrVYffN531/6CW5Mcvm
	qqTnNY6IyaxzBPaR2GtPn39OeFnnUXCxIWQiTZqcQUWwF2z8UJTEASRpx59pzKMUKlkozEONyDVAX
	B6Q1s8A7zZUqxrk1t0+e/2ToAYgVZUiKsYLT7misW7l2yx2aUQs8JYuGOfhyV9FNTpuXm3RJLOVL5
	FRsVNt3Q==;
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgTBU-0000000HILg-3Xoq
	for linux-nvme@lists.infradead.org;
	Fri, 07 Feb 2025 18:34:38 +0000
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517H287k007749;
	Fri, 7 Feb 2025 18:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=Hw
	mwhWszbl+kwijD4XR2MKNznP8bHsCCX+ZALnwYgvo=; b=gs72iF87nhSiNItyhY
	78ZdNp0rO0NTYIXp/OirZ2XpK6neb3mTOn9BEB50sf0830uoTPD1oZToqwYUL0oQ
	rUhpuWmF8wxf5RwM6CGzTignHvpsdShJgx7LhVmMhJA5ol7ULqcsEGND4HOmdj3n
	BbquqKn+DhCOlMjZub8D6d+SSyhWGh93vXHHoUJtoQ1fciC/MXtLhfYiChDuNeqX
	vcbDtfBrO/c/9nFE3EtudXwyF8V7Xe4x3aECackaBBtqsikuYKvL/TOsu0N6CrqD
	yXPmnUMgf55A5MSUjJcP44g1Rna1sG/EySNKA0Kkr+sXps3UDgnkleh9eChwYS5n
	kSog==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 44np7k0mc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 18:34:00 +0000 (GMT)
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 94E5C804791;
	Fri,  7 Feb 2025 18:33:58 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Feb 2025 06:33:46 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11 via Frontend Transport; Fri, 7 Feb 2025 06:33:51 -1200
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.58.206.35)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 7 Feb 2025 18:33:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usEBjZ1nTysIXnzbubAmogWKKaDaplE7i2Lo6uMUN1nPp8KwVb3DUOBH5v0qugLTiPinsnDKuV918zslcgvqhbybs5uteaNen1jPOqzI82ov1nVHGgbw+1pHsJnwOngPXnf1eQ6EseOWCwrc9fzlOgdbLrAeHjqmNX1Ipk63Hqv9NCGG9ho3nPFJhuFiA8/epSpC583V570h2OwN63s2g3WxBquWQx9jlNnCdT4cUe1if5AgDUGBayjDPzjUNPx1cT+xaxfciTii43a6AZZq9NYtnJJomSGQ8dmBWjbA6NL1SJDKHwOq1RN7YAHfoBM6VOPko7BeI9ziMxnHebILSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwmwhWszbl+kwijD4XR2MKNznP8bHsCCX+ZALnwYgvo=;
 b=Xtc9IqqcI9/b1MyRGWM6sono732lKiLAIOtMMU2rBjaC4gYPE/CbAwf2mAAFywiQ/hleoVDCaJwYCTBWR1uA3K7DyHj+z1XvbWb8IJ9GjVAoqk+J+aHapMciZIx8LIy2BDTtNJuAX0LbSZaZIpwpZrGc4tKxv49hhtR5aUyBadX43D2w3/rRZxwN97zpA1vhWNraGYq649ZPxgrYuqiNrTtEsptQcSNmWbK99pg472rGzeMlhnQOLeg6cAVo/jo/V4Oou/oDWs6fcIZ3j/3v/QN1i1OxSmhBeMe8KHCilw83NiLw9dPxOUUXI7h8gIa9EsN3yT03JSip5dG+vvP8ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:166::10)
 by SJ0PR84MB1387.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:431::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Fri, 7 Feb
 2025 18:33:48 +0000
Received: from PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e5e3:faca:6327:836]) by PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e5e3:faca:6327:836%3]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 18:33:48 +0000
From: "Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@infradead.org>
CC: Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "Mohamed
 Khalfella" <mkhalfella@purestorage.com>,
        John Meneghini
	<jmeneghi@redhat.com>,
        Randy Jennings <randyj@purestorage.com>,
        Keith Busch
	<kbusch@kernel.org>,
        "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>
Subject: RE: [LSF/MM/BPF TOPIC] TP4129 KATO correctoins and clarification
Thread-Topic: [LSF/MM/BPF TOPIC] TP4129 KATO correctoins and clarification
Thread-Index: AQHbc8Iz+czm4vBBUk+Is19CrVgMobMwnnSAgAAZaICAAFidgIAAKHjggAeu4ICAAAnKYIACpG0AgACZ2kA=
Date: Fri, 7 Feb 2025 18:33:48 +0000
Message-ID: <PH0PR84MB1358F15194EBAF119FD0351A98F12@PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM>
References: <63af907d-9cdd-4956-9978-4e77389b1716@suse.de>
 <Z5yYk7vHIhMfiPz1@infradead.org>
 <527f476b-18e3-43f9-98c3-d19a25a6488a@suse.de>
 <613065bf-ad13-489e-9d57-408684e85923@flourine.local>
 <PH0PR84MB1358752FEA88D5EF0971B27E98E82@PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM>
 <Z6OMGweV-wUI3iVn@infradead.org>
 <DM4PR84MB1374EB9468EC63867217240E98F72@DM4PR84MB1374.NAMPRD84.PROD.OUTLOOK.COM>
 <67b7e3e2-ce79-459f-a451-8d4dfbae299b@grimberg.me>
In-Reply-To: <67b7e3e2-ce79-459f-a451-8d4dfbae299b@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR84MB1358:EE_|SJ0PR84MB1387:EE_
x-ms-office365-filtering-correlation-id: 95b95b18-60ad-4b6a-36c7-08dd47a5f648
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K1prOHZiTzB4QWZBcVh1cFhhWWxCTlFUem9WbVpUS3hNSkRUUEFZTzBpM2NY?=
 =?utf-8?B?d2E2d20xcjg3OFZLV213OHRMRkR3U3VObG1VcE1VWDhpSGo1U0F2d1ppT1A5?=
 =?utf-8?B?ZjV1eXZZSWtBcnk5eXdPbEcwemp2b1QzT09ibHFtYlV2WjFpclJFVDl0MVcv?=
 =?utf-8?B?T3R5RjBoTGYvR1dvbGg2TlQxTWdFSkNIcmdjYkt2M3VndWxMQUFWdkJNMGgw?=
 =?utf-8?B?KzlmZy9zVkgyUzFkNitnQnB6TzQ4ZWx0UlBrVUhLT1dsWjU3dlNaWkdpUVNQ?=
 =?utf-8?B?OXZFaVArTEd4WGNoSFJyVVdaeHprNFp5U0VURWJlbW9wbWlpNVI4ZnBtQlQ3?=
 =?utf-8?B?bmV5eG85OFF1Nk5IRWlabmlOb2ZDV0tHTXBtREdzVG5nVUFMdDFQMll3WjV0?=
 =?utf-8?B?K1RRY1ZRK2k1bnhqNTNrYUZLNFN3dnVtcXNNZjBrOTFLZTNzbXpKZmlBMjly?=
 =?utf-8?B?dUREVXRmaUJYZlZDcGVsbTBJZnlwcFBlVGN5OVZxaVhpdjFzelRuU2xlencx?=
 =?utf-8?B?bU1zQ1dKN1ZoTVJucnJKblBRTmhvaGxDNHlWTUViaEFNM3A3OXdoRTgzOHB2?=
 =?utf-8?B?czZDSFUxRDduT2Y0b01TSlV3L3Bib0pxNHdHMlF1U0dvQi9jTDEwZWZXM29Z?=
 =?utf-8?B?WnBCdE9LMnJqZlhCaExlV3BpaFAwNWtEN2tNbHRPMU1jay9iTDBwa2VmcjVi?=
 =?utf-8?B?aDJUSTMxdkVYbTRlMDR2UEc5WHR5ZFNFbklvMUQ2YjU0NGVpR1Q4N1RrRkwr?=
 =?utf-8?B?VSs4T1I2UUVsUGEva3JCcXhpeEZLVndDTXpiUC9iRFgxWkdsSVI1cVFKYnFT?=
 =?utf-8?B?VVR0ejFTUWp5RUdJOFphWnVYcVh1UFp2a1kvYXFXTjErVkI3OHNYdHFYclF6?=
 =?utf-8?B?YmhWQkRZS09QekJTbFFmOHgwNlpBY1Q0dGRNeTlFelNIWVE2SFZJTGFEbUpN?=
 =?utf-8?B?Nkw4aDNzcVAvRWFDZUxZN3VURnRvMTlTUjZ1SG9yakFrZFh4L3NZMktibWl4?=
 =?utf-8?B?bVdUV3ZHa1BrYVRMY21CWWFkYzhyalNqdFdJQlEvejVaWm5mMjNtQXFpcjZG?=
 =?utf-8?B?NnF5eUViWDgvKzIvQVJsZzZtTThiVHVQcEd6eFVZQTBDTVAxSjVERGxDUndo?=
 =?utf-8?B?TUxTV0Jqb2t5VDVqa3ZacVAxbkVBc3NYS2FDVUNha20vbEZMRWN1L2p3RnRT?=
 =?utf-8?B?OXBaU1NzTWlSOTh4VnF0UEVOMTVab3QrRjI2N1RPaFoxRytpUDc5aGl0OUpi?=
 =?utf-8?B?MFRsckgwOFZsSVRucjFnbkt5NmtwMndlVEZOdmhTbnhxalZqYjg5N3hUTlo1?=
 =?utf-8?B?OVRqRSsrTHhwVEFadDRUeGFnbXZoREt3UVIzTmJQR1k1R2NxdXRQMWVhaGtF?=
 =?utf-8?B?c3YxTDFmNEdya2ZLUjM2MndCQ2xoYUNQVFpsdXA5TFdUVTJNTjUwKy9KY3k3?=
 =?utf-8?B?aWtzNzQ2OTFBeVZZTXJWSnhhV3l3M2Q1azBGMHlEM0lnOU04Q1AxZjZ3SUhp?=
 =?utf-8?B?amNYZ0tPZmsySm16bWMxdERtSURpdlc1SU40Wi9rV2NPZVNVdDZiQW9UVmg0?=
 =?utf-8?B?V2NVS2xEcmtXYnFiZ0c0SUpkZUEvU1VGMzNYOVl2OEsvUTRMaFRBRUE0eW0x?=
 =?utf-8?B?NjFQSWxnSUVLcE40eUUrZjF3SW5xMnhpSHBidTEyaS8yTUs1bHViVzJ1eEJa?=
 =?utf-8?B?c3pzcHVIdG9rKzJORkpvR0I0MjB3aHZySnJzTW1BRlhKdEpCeDl1UGdCaUFo?=
 =?utf-8?B?eWhsVWVkNWdPNHV0MWEwK092RytOYi9qdHV6aHdIVnB0N2NmcGZqdEhUaEhx?=
 =?utf-8?B?UXFXeXBsTFdNalV1RmFXRk9rV1JtNERhdElUenhRSHdEbVE3OUNUY2wrR3ND?=
 =?utf-8?B?Nkl4ZjNmM0x4U2htaGZyZzJqMm94b3ZlekNoV05lL1oxSWlTMkNIc29qbUZZ?=
 =?utf-8?Q?KbKJEdItaZWcSHSwxJ4Kd06NkTMkqkQv?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WENrR1FnRTFDeExYZGUwNU5KUXViQ0pxbFNDMGpNSnQxK201SzRabHJHTWk1?=
 =?utf-8?B?NVBnQUY4dDdNMlhCbVdpUncwU2NPNEdGUDNGSUI4Y3MrSDlnWG1lc0tTVTEw?=
 =?utf-8?B?UDRlSWFhUFJINzdJZ2toUmhReTFmNjd6NDZQZGR2cUQzOG5DUEJYSnh0clcr?=
 =?utf-8?B?R0ZKYzY1UE8wbGNPeWtFK29ycEkrUmhwbHJaVDJOY2FxMk5xUzVyRncyNll1?=
 =?utf-8?B?UmE5aS9DcVRvSFpOQ2hMeGJlYTlENGRpNzN0cmxNWVdDaFVrRzRIdi9XeGVN?=
 =?utf-8?B?TVBTQzJWMk9GM1RWaFNJUHh3Ni9SU2E0c1Z6RGhQbXpIdS9YeHBWYWJvRkNZ?=
 =?utf-8?B?U0hKckxWREg5eUh1Z2NueDdhMXNzcUJReUYxZ0dkbUhyVVpna2J1WUcrNHgv?=
 =?utf-8?B?YXJ6Q1RncFl3R2xjOUVmUWE5RTdGVFlpdFljZmsrTURkc0ZTbTdwcldBRW1s?=
 =?utf-8?B?ZEc3d0lRNW5LaGxtTDRJWFRhejExbmozeWYzMGdRZnEvMDBzZkt4cEcxYnh6?=
 =?utf-8?B?b2pHQjdSeC9JVHZpajZjRHdsbEcyVzVoUFRWeEZiaEtCdkhKRktWamhFMmhZ?=
 =?utf-8?B?ZWU0aHRHclpEb2Z0OEh1TFFjb0pwOGx0bkpqcnoxdU5YOHVnVmJZOU9Cb2xn?=
 =?utf-8?B?WjlmVjNNZ3A3QjdjTTQ5dCtPT3ZWMEFZRVM2Z2tGT3RjYjNWNkFPdTdSeUlL?=
 =?utf-8?B?dGQ1bXhHWFlHSEZKNUpSdlkxd3REZjdhREhCMHFEc25iRmlhNHdGMWpwbWov?=
 =?utf-8?B?YUVEYnN3bGx6eFZIS3BqRFRUUWJ6bjZoTENySXJvOUxDRzdQVkVDNVNWbHJD?=
 =?utf-8?B?dmhmaWxWaElDOHdLZ1lnK0liY1JVU0R6UE0wTzlwalVLSFV3aXJ5Y3VkZWw2?=
 =?utf-8?B?YVg4L2VDalA4TkY3OERYSzVCRzFacmY1d0haWmpLbFZ0Q242SUd1V3FJVzFJ?=
 =?utf-8?B?SVN6a2RoTWZqQ3h5eFpjU2V3bjJxWjZsMXdMVmgvZENKSDN6bGRxOWNFMVgw?=
 =?utf-8?B?UGNicVdtTWtOQjUrMmhsV3RNeGZOamZFYzRKUzVNd2RadVRMQUVEWlpCMm1U?=
 =?utf-8?B?aHIrZUV3QW9DRzBLb2l5WlJjQXEzYndQUTFPc1BRM1hVVENvWXlBOVhRVS8r?=
 =?utf-8?B?dXFXOU5tTkZSWEg4WWpFcEQxM1pQRzFTbXR4TEZFd0lIZ2dDMWh2cFVPMFBx?=
 =?utf-8?B?WGFqTXFFOWxpenYzR2pjSFhEcFl3MTNrblRsbUxyeFFoM2FRL3BYTFgrdTd2?=
 =?utf-8?B?SnoydlVLQTBwT0k1WWE1M1VCcmhjcTJIdVk0cjE5QXdDeEsvN3d0RWxmQ2NK?=
 =?utf-8?B?UzVSN2JwZ0lPSWRibGV4dktZcmw3WEhXa2szbDRxQm1wTDN4R3BTK0xHaURn?=
 =?utf-8?B?bFlUYStYbnNHODlhamh2UkNEOVJhcjBNMHY3YmVDK2JiZDJxQkNhWjkzaHpY?=
 =?utf-8?B?QVkrYWZKbytINTdFd2s1RURoTnRUenA4enN1ckZVakJDRkN2WmxtRjlRZjRH?=
 =?utf-8?B?bHl1VDdiY0NYU0czSkhYNnR5dmFQM1RtYW12azN1VGhnL0pMWTBXaXUrUHM2?=
 =?utf-8?B?RWFvL2FmTTIrVTVtRXozZ2VnNi9paW5TUDlxdEdSelBpV2sxc1cra1hKVTMr?=
 =?utf-8?B?MVdhV0FnMktrUFdmdGhXak5QRzJyazJCck9BZ2NXM29ob29uWDlwMk9vT0dD?=
 =?utf-8?B?UjVxb1ZIM3B6Rk5MZGhpU1ZhOTdKb3BXaWVGaXdOWUJ2L3YrS1BxOWJOc3Rw?=
 =?utf-8?B?OEppMFMxaGNYNSt6ODNSNk5lQkZOMGhVR2s4aW9RQUhuZitCMjdjbWx5bDc4?=
 =?utf-8?B?UnJNYzRqbGZxMWp4Y0tQenM2cXg3MGhpaHhnTTcrVWt2WTJyS21ZelBKM1dP?=
 =?utf-8?B?dHhZL3hieUwrbnJlVVFWTXVvdTloUk9YVnh5QU5tRUVPWDNsbFl2c1ROb0VT?=
 =?utf-8?B?ZCtHOXdLMG85L2F1cjl2ODBHbnhxSFZmUzlaZ2JXeGZveGxQUzlXQ3lCUVpP?=
 =?utf-8?B?QlUwWXNFRzdaZFV1Z1BnMEczUkd2WFB6NUdIWUdNYjhiOU9OMytmV2VwZklN?=
 =?utf-8?B?SWp5MHdRR01JMFVSUVdxazIvanZnbitUcHJOYTdZbnZ3MWlBM3lXdHI4anFC?=
 =?utf-8?Q?ulJGGWkA4AD5nyUanBXWns397?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1358.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b95b18-60ad-4b6a-36c7-08dd47a5f648
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 18:33:48.2972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3QDOyNZFX2Ss6ArXpi76QAI/ke8RlbWNnwIbSnGMwfKgyK6/3dvuuXKn/J36k09ZVuVWYwOm2lrSlin5ksa4FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1387
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: -zEqPz5NBqBmPbl_3VnKtpnslJZI9WRw
X-Proofpoint-GUID: -zEqPz5NBqBmPbl_3VnKtpnslJZI9WRw
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_08,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070138
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_183437_279176_D7494B99 
X-CRM114-Status: GOOD (  15.91  )
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

T24gMi83LzI1IDI6MDEgQU0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+Pg0KPj4gUmVhZGluZyBi
ZXR3ZWVuIHRoZSBsaW5lcyBvbiB0aGUgdGVybSAiYmVzdCBlZmZvcnQiIEkgdGhpbmsgdGhhdCB0
aGUgY29uY2Vybg0KPj4gaXMgdGhhdCB0aGUgdGltZXJzIGRvbid0IHByb3ZpZGUgYSByZWxpYWJs
ZSB0ZWNobmlxdWUgdG8gcHJldmVudCB0aGUgZ2hvc3QNCj4+IHdyaXRlIGRhdGEgY29ycnVwdGlv
biBpc3N1ZSB0aGF0IHdhcyBkaXNjdXNzZWQgYXQgTFNGIGxhc3QgeWVhci4NCj4gDQo+IFVubGVz
cyB0aGUgY29udHJvbGxlciBpcyBhYmxlIHRvIHJlbGlhYmx5IHVwcGVyIGJvdW5kIGl0cyBhYm9y
dCBvcGVyYXRpb24gb2YgDQo+IGFsbCBpbmZsaWdodCBjb21tYW5kcyBJIGNhbid0IHNlZSBob3cg
dGhpcyBpcyAxMDAlIHJlbGlhYmxlLiBXaGljaCB3aWxsIGxpa2VseSANCj4gbWVhbiB0aGF0IGEg
aGVhbHRoeSBtYXJnaW4gaXMgdGFrZW4gc3VjaCB0aGF0IGl0IHdpbGwgbm90IGJyZWFrIGluIHBy
YWN0aWNlLg0KDQpUaGFua3MgU2FnaSAtIEkgZ2V0IHRoaXMgdmlldy4gSWYgYW4gTlZNIFN1YnN5
c3RlbSB0YWtlcyB0aGF0IGFwcHJvYWNoIHRoZW4gDQp0aGUgdGltZXJzIHdpbGwgYmUgYmVzdCBl
ZmZvcnQ7IHRob3VnaCB0aGF0IGFwcHJvYWNoIGlzbid0IHRlY2huaWNhbGx5IHNwZWMgDQpjb21w
bGlhbnQuDQoNClRoZSBpbXBsZW1lbnRhdGlvbiBvZiBDUVQgY291bGQgYmUgYW4gYXJlYSB3aGVy
ZSB0aGVyZSBpcyBhIGRpZmZlcmVuY2UgaW4gd2hhdA0KaXMgc3BlY2lmaWVkIGFuZCB3aGF0IGlz
IGltcGxlbWVudGVkIChvciBpbXBsZW1lbnRhYmxlKS4gIFRoZSByZXF1aXJlbWVudCBpcw0KdGhh
dCB0aGUgY29udHJvbGxlciAic2hhbGwiIHN0b3AgY29tbWFuZCBwcm9jZXNzaW5nIGFuZCBjbGVh
biB1cCB3aXRoaW4gdGhlDQp0aW1lIHJlcG9ydGVkIGFzIENRVCBidXQgSSBrbm93IG9mIHN5c3Rl
bXMgdGhhdCBoYXZlIGNvcm5lciBjYXNlcyB3aGVyZQ0Kc3RvcHBpbmcgcHJvY2Vzc2luZywgYW5k
IGNsZWFuaW5nLCB1cCBjYW4gdGFrZSBhIHZlcnkgbG9uZyB0aW1lLiBJbiB0aG9zZSBjYXNlcyAN
CnRoZSBzdG9yYWdlIHN5c3RlbSB2ZW5kb3IgaWRlYWxseSB3b3VsZCBpbXBsZW1lbnQgc29tZSBz
b3J0IG9mIHByb2Nlc3NpbmcgDQpiYXJyaWVyIGJ1dCBldmVuIHRoYXQgY2FuIGJlIGhhcmQuIFNv
bWUgdmVuZG9ycyBtYXkgY2hvb3NlIHRvIGRvIGV4YWN0bHkgd2hhdA0KeW91IHNheSBhbmQgcGlj
ayBhIGhlYWx0aHkgbWFyZ2luIHN1Y2ggdGhhdCBpdCBpcyBoaWdobHkgdW5saWtlbHkgdG8gYnJl
YWsgaW4NCnByYWN0aWNlLg0KDQpWZW5kb3JzIHdpbGwgYWx3YXlzIGhhdmUgdGhlIG9wdGlvbiB0
byBpbXBsZW1lbnQgYSBkZXNpZ24gdGhhdCB0aGV5IGZlZWwgaXMNCiJjbG9zZSBlbm91Z2giLiBT
b21ldGltZXMgSSBmb3JnZXQgdGhhdCwgZXZlbiB0aG91Z2ggSSd2ZSBkb25lIHRoYXQgbXlzZWxm
Lg0KVGhhbmtzIGZvciB0aGUgcmVtaW5kZXIuDQoNCkN1cnRpcw0K

