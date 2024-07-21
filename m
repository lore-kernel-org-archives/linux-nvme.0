Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFEEC3DA5D
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Jul 2024 17:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GluJMpCTcwUqRM+sNml3+4dkwjUcJiuvEXMOZP3tWCM=; b=ucxPdyseTBDE6n
	oX0zLc1QIuYyJuK10YzwLhozNtw9BMfM1u4itxWosHy8VrmMfu01t5biVetNJNL+W8GUZXSoHZZtJ
	82G+P+NJi30FRFL46YzIoTWQHBJ1L9sdwF1hPQWCVjey339KwZzn6m8HXv3bvMZvou6ZO/p40wtnD
	5Hq+NWXq9nUdQ7cHCcP5XIvwdEinEeLsAp3ixquADBo08AdcdwJ9jrl8WM7IrGTcL+3e2otHLMqG5
	liPIqDV/jjPLp7SyDac1qtWxH9rMGFwk0Wk2dIRtny+xpWSV+xfzkWjMaXIJr7XGv12x8E/nF8nCr
	eg8aV/bwLLkTHlg9LzAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVaix-00000007Hya-0ARP;
	Sun, 21 Jul 2024 17:51:55 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVait-00000007Hy5-0lTP
	for linux-nvme@lists.infradead.org;
	Sun, 21 Jul 2024 17:51:53 +0000
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46LEaj4e007518;
	Sun, 21 Jul 2024 13:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from
	:to:subject:date:message-id:content-type
	:content-transfer-encoding:mime-version; s=smtpout1; bh=GluJMpCT
	cwUqRM+sNml3+4dkwjUcJiuvEXMOZP3tWCM=; b=PlBiOlDg0WQrxEr0MHeFuOJ7
	Z53EOuExwfqiYezNFmwbAjMg3ilq5OzfDKtEZTtb9zx8BGI2w8BL4sr7zdTW+wDh
	OqqgxEZY+7Hv7AMed8uBBo5ILWyDvt7sGGV4sZ4TU5xT+Tjl9u4oVwRRUphqc99K
	8RgODW0AliuZWCcgRPVzCsHq+MKhT7mLZtIx1nVQHo+rtV3cJ8GoaC76iM7t42QH
	LtcRaqwvhbLVwDZFJwu857s1/HBR6ADoacb2eQ+aSzOscMve5uv9ms+rZtu/DGnv
	+WPVBuuQg8FHqIl9V/02BmxfbQjshRjwxK4tFG14UCchuGmyJzKpQd3ipUAJdQ==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 40g8a0kbhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Jul 2024 13:51:35 -0400 (EDT)
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 46LHevPp033513;
	Sun, 21 Jul 2024 13:51:34 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 40gtsm59p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 21 Jul 2024 13:51:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FVxq8la3miLjRScpyj+61KUKS1Qlg6L5nouP7IHraOWNK9lEpzpUuV5xBd25rIk/5al7be1X+8H6GxLSMlp7FbqOC0hf4WzITz0nbqUpvljXnfS7pVnqtUtKoMIenrjmF+WZmh+4opBWfZB9wkmrVY8rWTeA0CkX0oWIY3ysdsVeFm19yuqYZFrsnqSsy7FEUMQUyDelAIJAte/Ssqo3r4j8xLSkeI0yt9zA+VUhNr/RsTag7LOCU6SXojbrsBg1Bk9ASi/55BozJERWg0RobPZiuKeP6a2NdEguaU+bxXrfKvyJ372TPo5Iy6QjXRL/tcUugFJ84ohk/qSNp9EgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GluJMpCTcwUqRM+sNml3+4dkwjUcJiuvEXMOZP3tWCM=;
 b=MHniiTXAs5r4UzirdRtKa2FqexhQiwa/DtfCUwFnP6t0rx/28argrO8twL2IgtVmLD1fht1n4zKbR7odB83avnaIv2y+P1v0b0M/V9H1FLO9h31j3u1QZtknXxXy9fGeXvxWVlO4+yupJBKvAbq9ylTIOShUO3h+tDZu/S+fR6TYSO74k9y/AU8+GkajbEjdbuwXCcKKOIHQNVoiIE6ekJ+vBKm/kiC72MT7vDb2wCwaTX6UJLKs7z3w9UVRuE1aaY21GvjeTqxBEszmkrfm1MO1vod8dypgh6pc9GkWOx8MBGiZvuEX9ceY/s32lWeiwT0MrbWZ50zH96kzAEXkZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by CH0PR19MB7911.namprd19.prod.outlook.com (2603:10b6:610:187::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Sun, 21 Jul
 2024 17:51:31 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::893d:3ce2:a0ab:1a82]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::893d:3ce2:a0ab:1a82%4]) with mapi id 15.20.7762.032; Sun, 21 Jul 2024
 17:51:31 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>,
        James Smart <james.smart@broadcom.com>
Subject: nvmet-fc race may lead to a kernel panic
Thread-Topic: nvmet-fc race may lead to a kernel panic
Thread-Index: Adrblnw7l3fMB63CS5O5ryuSgoZIyQ==
Date: Sun, 21 Jul 2024 17:51:30 +0000
Message-ID: <CO1PR19MB4885A4E58A6BE1CF9C044C4FEEAF2@CO1PR19MB4885.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=ef1a93a7-59ce-4b1e-a8e5-83862a71b866;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=0;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No
 Protection (Label Only) - Internal
 Use;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2024-07-21T12:23:34Z;MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|CH0PR19MB7911:EE_
x-ms-office365-filtering-correlation-id: 0dcf960d-4ae3-4353-8850-08dca9adc0e8
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N3RiY1N1dGh4ZXZOWXhTZVBTYURDNEJOelpmUENWUGI2RlRCYmo1U2VDUGc3?=
 =?utf-8?B?b1RtczgxVjgwNUt0YTFDblZrMVFIYkZuUjJYVXZ4UzltaFFGSmoyL3VFeE5q?=
 =?utf-8?B?TURZR1E5RUZ5TURoTW10dUU5cCtxemdYZHVrTDMxbkhVOEIvbGt5NlE1bCt5?=
 =?utf-8?B?ZFhweDJ1YlQzSE5XOW5kREVNSkk3S1lCWVM2SHBiWVFyWm9IMkl1SmdkNU5w?=
 =?utf-8?B?WjI1M2xBWTd2aXI5S3RVU3ZmUHNkRGFKSXpienMvSnNyQlR0RlZTVUg2c2FQ?=
 =?utf-8?B?d2M1Z3ZROHhsckJWVC8ydWpHU0tIM2Jxa2RxOEJoRkh2WDVmL2JSNEVRMVZo?=
 =?utf-8?B?ejFjOUpHNktUenNVTXZ3NmtIWlZ6cE1oaUNmbjNHaHEvYWQxWmhrU0xYdGhL?=
 =?utf-8?B?QUloWm1QR3hyenYySzBYbDl4d3A0OTAzNnR0TUtmcjZZaEJjQlFOeTdwOHRa?=
 =?utf-8?B?OTVXMTFBOVZkOHRQcXNNZHkrNE5UQjBFTCtYc2pybG5NS3JBUVlSTVNpRGhh?=
 =?utf-8?B?K1dYRS9sV0FRNGZUWXg1L2NnN3o5NHJicXh4MVZGQjRuMzlBM2wwUDRWOHlH?=
 =?utf-8?B?aXdVWmZvMUYreDlBWWRXSG9xM3JLVXRXd1R3bHFGOGo3V2c3VVM4dzhRa1pD?=
 =?utf-8?B?clVvaFFENlZiVHN5eXFrdHppS0M4VmZDaHdqdkpjTDhxbnZqdk9mSUg0UnJ0?=
 =?utf-8?B?OUZWcllNM24zMUFyd1NsZmNqZlNpb21uN080dnpvRmoreDFCVllmQ24wVFFT?=
 =?utf-8?B?M1AvOU0rUXlDejQwek9COEZaUkpHZkZGamFmQkRFK1RFdWs5ZW10VGx6Nmlp?=
 =?utf-8?B?NU9FK3JWV2hjWXNvQi9aR3RlbzIyTFVLZk03d3ZNR2VXSGZTVHZvY0dLb1NW?=
 =?utf-8?B?WmtzOVp5bHZxMEY3SGlsbnhSc1FiQVAwZTg0MkNUV2JYRlB6RVlBRzhQeEJo?=
 =?utf-8?B?VStiM29UcXJWLzBxSDFZNnNrNWkzNzY4L29mNVZobW1lcmlrQ1pYbmV1WFJR?=
 =?utf-8?B?QVpPcjNPVzVRRndhWXZzeWl3cERYeGtBaStYTktqVEViaDVoSHBXc05yREln?=
 =?utf-8?B?dW83Q1RkRW9rR2R5OGpKbGo4SThLVSsrdXhnaTFSaDBKQnlrVXBjRUJYeTVj?=
 =?utf-8?B?RGQrVEx5OGh1QlBmZzVCMXROZE5JOVJMNEVhcnBFOGNIb3FlQ1RwWkk2UFIx?=
 =?utf-8?B?UTR2WWZ5VHExMTNwN1hHVTJCb1o5aEFpZHZ6ajIzZWhGQUx1aUJNcGhPTVBR?=
 =?utf-8?B?b3E1djR6aU9YdENCZm9QdGcrQ2ZlbGMzVEErVFVTRHI4NjBDVTJ0UTNhNURD?=
 =?utf-8?B?Y3lHUDRFQ2JzeWJrYy9XTjVhOUM0VFp2NWoxbSt5VUkwL0E5UHJCRWpUL0Rp?=
 =?utf-8?B?cmRYZkVNUkEwN2VLbHhOWWNxelBnTTdGVThJYnZ6citZOVNMa3VPV25yd1N4?=
 =?utf-8?B?aDI5MmdzN2EvVDdrNEc0bG80QjVZTm1lK3QzakdCOSt6dnZsaWNYREc1TnVH?=
 =?utf-8?B?YkNyMzg2ME1DRHVxWXAyZkVodXdka3RlRXVGNlE1OHdDUlRRS1ZDOWN5SWFj?=
 =?utf-8?B?bXlFMGN4S1JxeHZuTlBhR3FKOWcxR0diYnEweVBEWTdMYVlTaGNGa2duaEU5?=
 =?utf-8?B?alIwS0NhbGlHTnBHL210SXlxcitRb0cwZi93UXQ4QUlsT1NZckZ3aVk5ZlBp?=
 =?utf-8?B?b3RiVnRqTk4vUlY0dXZYUjNDWlcyY1g3QnNlYkdqcHdWNXRNR0NQbmJ5WDlQ?=
 =?utf-8?B?UFhBbjhkMFFRTkRaTTZud2l2LzF0ZHgrdHJjMXdsWThlcS9uL216MHpQQnRq?=
 =?utf-8?B?RXVKTGF4Y3k3YlJSalJJeXNnSjRRWXB2T0pPdlVETk5taFUyK1FONFR4VnY0?=
 =?utf-8?B?Yk9pRk45RkdBVWx5YStOQlZjVzJoV2RIL0EyWm81L1MzRWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ak5ua1NuYVM4b2h5UkhEbDVvTmJ4VjR4dlozRGZjU2N2blJzMDZOOHNsejB1?=
 =?utf-8?B?RDRsM0hibXQxR2Yrc0VmOVhNR0N6UnpZSmNOcDZscG9uaDlYM3JpT0pXbFpU?=
 =?utf-8?B?ZHoxYWozL0F6dXRQQmNwQVpYMFZDMXI4L0NVS2ZiOWt1TEhJMVRveGc5QVd3?=
 =?utf-8?B?MHdOaTBIb3VxWnM0ZGxVTGk5RURoaUUyTDJrVjNVbFdja0JhOFpHdU8yR083?=
 =?utf-8?B?bVRleXBNOXpLdkh1Tmo5VjF6ajVqRHJUdFRpYjZGMVQ3VE9NMlc5L1Y4UmlG?=
 =?utf-8?B?ZlBERDBmS2hIV1NJUyt5Sm41VjJVOTBEVmtwbzhnNHRpWmd6a2cwcjUwZW9i?=
 =?utf-8?B?RWVlMUVjUXd1WFpaandxWHlzRFJiUVJpSUd3UWM5TlFuZFNqUnYxSXB2QkpO?=
 =?utf-8?B?SUE0LzVWKzdlQWx3RFlTMURHdGw1WDZmaVdJRUNhdm5kQ01qTDJuQUFYajVP?=
 =?utf-8?B?WmNURG5MSXB4elYwbHQ2SEhCaEpOZHB1ZGJJSFhBaFFqTGUzZHVzMGM5Q0dj?=
 =?utf-8?B?T2JBVlJZUWsyTGVJSTA4ek5QNXc0Y3I1b000eUhwUUNYZkNzdDdFOG1URElW?=
 =?utf-8?B?RXRJVU5ndURUUnBQWEZpWTluaHJnRDJRZGF3dTZqR2ZGY3c4OFZWVTF6cTFn?=
 =?utf-8?B?SXZjM0o1b1EwZEMvSXA0Zzg4WlNzYkp2czA3d2hHcHBLdTVkeFNJTGdBQndS?=
 =?utf-8?B?WjZnWjRucDM4K2l3b1FkUG1VS2Qyc1NpWXFsNi8rbk5aNGxMQ0MzcjhTbW9O?=
 =?utf-8?B?azh4eFA5OXcreFRnMUNvYXJuanZlakFaOEI2SGxxeUowOW9zZzVYQm1uQ25O?=
 =?utf-8?B?RFVmQzFrbEhESDVsQW9wSFRsMGQwa0tBcm1veDdKVXZSWGFPR3FBb29VUHN0?=
 =?utf-8?B?eFhmWjhPS3BTQ2FhN2hsMHN4ZXl1ZTNRRTJkY3NYUnFaY0lwN3ppY0h6YnBu?=
 =?utf-8?B?cHowWXVYVytERlNiVXVnTkY5b1NOTlNsd2p6VEp1MGRiYytVYUpSanpvSWVX?=
 =?utf-8?B?TnVreXdkZnU0Yjl6Zm82SjFGYXc3NXlZaHViM3huMzZHMktUQnprZUR6RDdB?=
 =?utf-8?B?WWNia0ozTFdnQjNBMFZDdXhwaWcvL0hmYWlDcU1sUTE2MzgxZjJhR1RMYWx4?=
 =?utf-8?B?Q2JVbzV4bUcveFl6UWNYMXduTEJoeVRRMzQvdWVnVUkxa0NKRm1CaEVPNFNM?=
 =?utf-8?B?R2c5ekxyVXZVKzkvdFBOV2hkMkpyeC9tajFmY0VrWnFNQ0pobXpuQUExLzk1?=
 =?utf-8?B?Qkp2S0FsT0R0RThRWFQrTnFYd3BhZFdDSytHNVZoOXU2ajlRUEE4TG1CKzJo?=
 =?utf-8?B?VDFkcC8wcnYxZ0MvOHJwZG5EbWVnRkxwNFFJUzBhUEpocmZ6WnZxWGhRWGhx?=
 =?utf-8?B?MW90L3hFZkVza3lkbXVDL3lVZHlZQVF3RVR1b3R1VStUQzhocnlnNDVvQTJ6?=
 =?utf-8?B?TkZNcks0SlArVzl0Yjk2a3lGdk1NYUlWZXpjMFp1S0JraWdpQ3FXOWdZUUJt?=
 =?utf-8?B?UUVJc2pWa082TFhJNmJoWXUwTUhyVElyVWx3dEphNmdETU9SaW5lMVpxbGhs?=
 =?utf-8?B?UU9OeHNuUEpCeGJEYjBDeTB3MW85NFk1ZDVkbEp2Q0hXcG1QMlhobFN3WFlI?=
 =?utf-8?B?QVBXZHBwNDEzVDNVYlVlMmdiQ1F6a0Y1aDVVSWIvRGRtazRyYU5HMXNwTjZC?=
 =?utf-8?B?aGp1T0t2dlc1Zk0zcitySmZ5SmlKR3pmdDFSTzhVMzl5ZWdBdzErOWJncXRU?=
 =?utf-8?B?Vy9oUFhCd0ZnZ0tCOFpmanluUFZGVVU1MGJKbHlPNitJVGtuMVBZTVJmVHBw?=
 =?utf-8?B?OVl2TmhER09icVdCMXVrMWdTWUlBNWRKSnVxYldZcFhDWFQ1RkdlL0o3QnlD?=
 =?utf-8?B?SXY1K0tRMkFIZW13dVE1OTBRVzhZUExwNC9QWGtlTTM0NUFaZmJzZGhvRnVy?=
 =?utf-8?B?czhERTJIQUovdWcvVkFNZDZkUXMvTkdpcXBqM0tEMDd1S3NkWk03VnpSVWhJ?=
 =?utf-8?B?aXVidEluRG84R1ZBUlN1Z2U2VW4wS2dwZDZxUkVPb0NTQlZqMzVCZ1pXZmNl?=
 =?utf-8?B?dk1uQ2ZhSlp1MG43VDFtQ1RqazV6QW1YbTUvcTUxNlZrUEw4aGRQcVVSSCtI?=
 =?utf-8?Q?RnBM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcf960d-4ae3-4353-8850-08dca9adc0e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2024 17:51:31.0146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0oq/MlLwOfKogykCIB046IGHOoxcTRNB72Jh1Ieh6WaWbQ3Bs2GLO3WWMxlxSOpkMOcxriYgfMXzMYVpiFKJAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR19MB7911
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-21_15,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 mlxlogscore=554 phishscore=0 priorityscore=1501 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407210142
X-Proofpoint-ORIG-GUID: 3wDV0jOGLgypD_T6RYJwIf1DMLViTxWV
X-Proofpoint-GUID: 3wDV0jOGLgypD_T6RYJwIf1DMLViTxWV
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=511 suspectscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407210141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240721_105151_324517_A74C1C84 
X-CRM114-Status: UNSURE (   9.39  )
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

SGVsbG8sDQoNCldlIGZvdW5kIGEgcG90ZW50aWFsIHJhY2UgaW4gbnZtZXQtZmMgdGhhdCBtYXkg
bGVhZCB0byBhIGtlcm5lbCBwYW5pYy4NCkRldGFpbHM6DQp0aGUgcmFjZSBpcyBiZXR3ZWVuIG52
bWV0X2ZjX3JlbW92ZV9wb3J0KCkgYW5kIG52bWV0X2ZjX2hhbmRsZV9mY3BfcnFzdCgpLg0KQXMg
cGFydCBvZiBudm1ldF9mY19yZW1vdmVfcG9ydCgpLCAncGUnIHBvaW50ZXIgaXMgYmVpbmcgc2V0
IHRvIE5VTEwuDQpBcyBwYXJ0IG9mIG52bWV0X2ZjX2hhbmRsZV9mY3BfcnFzdCgpLCAncGUnIGlz
IGJlaW5nIGRlcmVmZXJlbmNlZCAoZm9kLT5yZXEucG9ydCA9IHRndHBvcnQtPnBlLT5wb3J0OykN
CkF0IHRoYXQgcG9pbnQgJ3BlJyBtaWdodCBhbHJlYWR5IGJlIHNldCB0byBOVUxMLg0KY2hlY2tp
bmcgaWYgJ3BlJyBpcyBub3QgZXF1YWwgTlVMTCAobnZtZXRfZmNfaGFuZGxlX2ZjcF9ycXN0KCks
IG9uZSBsaW5lIGFib3ZlIGFjY2Vzc2luZyB0byBwZSkgaXMgbm90IGVub3VnaCB0byBhdm9pZCB0
aGlzIHJhY2UuDQoNCkFueSB0aG91Z2h0cz8NCldlIGFyZSB3b3JraW5nIG9uIGEgZml4LiBvbmNl
IGl0IHdpbGwgYmUgcmVhZHkgd2Ugd2lsbCBzZW5kIGl0IGZvciB5b3VyIHJldmlldy4NCg0KDQpU
aGFua3MsDQpBbWl0DQoNCkludGVybmFsIFVzZSAtIENvbmZpZGVudGlhbA0K

