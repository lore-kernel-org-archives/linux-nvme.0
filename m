Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0353EC4332F
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Dec 2022 18:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7lASPvc9rjZK1clILiyAsN94dScOu3F/YVT1UUS0FvE=; b=1+cLyolUtUXVNjCzUa/gzqAlck
	dxzJBsO8P2NBevO8TH5C6pWVV/iUGt9nzKNtpNl9fo5J6pD8XKNwDR6x5bbh25tlH2r2MxfH2fuYD
	INpSpxdBxy6G1VJmhEkuWaNvV9EftFtHzECXa7h76trDThifaUowXaa554zLfy4muzBMfsDNz9DXT
	vEailAJ075Zk4REczw6SoHgT+S2uUcEsFsMWiuUMXMIR+b487MDkldcpeQu4sZG2A+ORH6PjSPqsD
	M4ijRl2bmNZ9n4I34gV+9pI8+LBnS9YTBnI5RdEjrAj8klM3rYyUVwW/LQjNDqEDAH0JO4LTA9tic
	JgLfMjEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2FmL-0082PX-Rz; Mon, 05 Dec 2022 18:01:21 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2FmF-0082Jn-AT
	for linux-nvme@lists.infradead.org; Mon, 05 Dec 2022 18:01:17 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5GF0pK022632;
	Mon, 5 Dec 2022 13:01:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=7lASPvc9rjZK1clILiyAsN94dScOu3F/YVT1UUS0FvE=;
 b=ZuBf+r0Uk4c2o7YPg/Z+bP9NdStOUTBSzVUmNEX256NHzqx5t0NshXDiG2f9isBj2wWG
 JxGlzBAY+1T1F3wQYkpww1Y7eZ3vXqOsiS4T221o73vA+UwQ6cSfMSMW41Qx1N2OvPy8
 gxhRx8+ogZghPFPG+tA9J0f5iQawq0h1xBXwjNgcXrPGUv3Q2fuc+Nnnkdy4D5ccS05k
 ny96lwBd+Abc1717h0R4ZsVGym2VH248lsjXozHwWu0yglIO1HXL335wfLHPVmHWd4JH
 zkxxpxJi2bvfIU2sYH8EWcIZC0J3QUSYriNmzgKGFG7xyj04zTk3ifKjU5l+W2gVKRQs 2A== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3m840uc5w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Dec 2022 13:01:03 -0500
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5Hw7fh001564;
	Mon, 5 Dec 2022 13:01:03 -0500
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3m9msugth1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Dec 2022 13:01:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Peb+laHfeQPGwo4L93Z5aNWwiKPcRgGz+xgWpbpxEzI1ZeOochFMkNc7H7z4xOm32C28YVcWWqtdltWHc4xssdFNFqH190OLKBns4m8l5JWx5qJkv6YASghNeKhzhgk3ogc+OmeuWBaIMD9r4zxjUoMpXX9lzTTDhvFnIYo9LGXcqJmLZMhRFrZNUBB3MQFXAlGBL7PZ93zCHWpCcSv5aEEKxbDYkKTJ0YqKVJfIDNSb3EZws73IUZO3lXRtRO9/5lIlvXJearwDSTLRo4/+GhBaLKUaYTUlcFH5iklzDP2fSlkU27TpDVWqkCDMIrpoWq/R3JW7q6RFinJjaTLcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lASPvc9rjZK1clILiyAsN94dScOu3F/YVT1UUS0FvE=;
 b=m2D30vPriSOdub4LqEUjJwdsUfgzWEWqjw79w2+cOrFEhKvsOn3UOTXUo+9E/Goy5dwXJUfP3x8nI8LI8JdHiTt2V15tQcBFKpkyx/nGowZrGYGwXRfKKRXGbAa+ZIAnArwKG6CUUCIwx+rjWGU39b/Op0tgm+Dc6WCMxpA+1bAnyinCgsrPO+YXmJDMxZkYcr3LRKD0lehFrhNBA7gEeZUN5SJLjkxNeROGGn8+bGOC+mQYCteha7fnoEOz8jzVcG73oRd9E8zQIatWupomqgBuJQv4ZfjgY3xV/kbt2HLOubxyN1AK8o4wr6th5dD+CT75CthMXTA3jb0a63hwOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from CO1PR19MB4885.namprd19.prod.outlook.com (2603:10b6:303:f5::17)
 by SA1PR19MB7087.namprd19.prod.outlook.com (2603:10b6:806:2b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 18:00:59 +0000
Received: from CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::404:85:b6d7:86fd]) by CO1PR19MB4885.namprd19.prod.outlook.com
 ([fe80::404:85:b6d7:86fd%3]) with mapi id 15.20.5880.014; Mon, 5 Dec 2022
 18:00:59 +0000
From: "Engel, Amit" <Amit.Engel@Dell.com>
To: Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "Grupi, Elad" <Elad.Grupi@dell.com>
Subject: RE: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
Thread-Topic: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
Thread-Index:  AQHY+oZ3D5fYZrPgTEKaaKTSawClOq5HuhEAgAGKjLCAAAFEAIAABSLQgAAsj4CAFIQ9EIABL5iAgABoTmA=
Date: Mon, 5 Dec 2022 18:00:59 +0000
Message-ID:  <CO1PR19MB48854117F203A43ABFFDB17FEE189@CO1PR19MB4885.namprd19.prod.outlook.com>
References: <1668607073-1814545-1-git-send-email-amit.engel@dell.com>
 <1668690824-2034939-1-git-send-email-amit.engel@dell.com>
 <4effaa95-0357-7d65-1701-8ec67ce7cc11@grimberg.me>
 <CO1PR19MB4885EB9E323178E235681F9EEE0A9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <8e6fb5af-2992-dfe2-10dd-383c2c058f8b@grimberg.me>
 <CO1PR19MB4885EADF8C1E970867C71487EE0A9@CO1PR19MB4885.namprd19.prod.outlook.com>
 <a6fbc43b-7f7f-91f6-a157-186f2663b734@grimberg.me>
 <CO1PR19MB488579DCD958B74B2C8E38AEEE199@CO1PR19MB4885.namprd19.prod.outlook.com>
 <9021ae71-646f-8183-7772-7dae38a60d47@grimberg.me>
In-Reply-To: <9021ae71-646f-8183-7772-7dae38a60d47@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Enabled=true;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SetDate=2022-12-05T16:12:47Z;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Method=Privileged;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_Name=Public No Visual Label;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ActionId=b15678a4-1610-4d77-b82d-5451f0291268;
 MSIP_Label_dad3be33-4108-4738-9e07-d8656a181486_ContentBits=0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR19MB4885:EE_|SA1PR19MB7087:EE_
x-ms-office365-filtering-correlation-id: b376cdb8-8a76-471d-ab05-08dad6eaaa25
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  yy+apRKdtC3iqHUkfOUJwdSbZ5kwZ0aPMGVh0H91Xu1m2csfL9mGbdfz50UdmjT8zeI90TCXNhuQNVVJmF74s7UiV43watHvtqCCCHcX5S5F0iQAHnK3kqqL/D4r2XEL1KD5sasLKoWcJXZ4LQQfsgiDOyOQ8M+LDcfQreCld9w5FFsoN1AlDqbzzwi/fbq93ZEeK5WqJdFEk9IyKm4t5P0KoHVnIFm/gS9oDkqZt7IXjqA1mHqEvotULZkaKDMNXxhRWjvTBMHq6vec77OJrIC7UT/WlRO5IJOLIg7UxpkAPyQfJVvH+2sqzkevxRVdSwtK1A+t02EhHhN0jSaTWUlyUHv1NkUFhclyzzpqARl4u2D5rjIa6b9oYQEEoFt8d8R7TJe+1Fm+2HWr0/LIkOpk/Jj0Q66Nl0IA8icCH1dviOZERgOQC8wiZwGTFEWrMVNT5CkbrP9QMl8Wg9vzPLQl9m5U4MtDhV53DRm12XyPLx8vSc1BIVXyz20DZn1SX7GUpDHqypIdwuzJtzAgwHB/HBiUi6lnVSimg6W/7/SUfaE3C4fAh6YWlqSb+82PBMoDaRLG1pxfzNQ2vBt9muS3W+Fz5h2wHU678x4Xf3BCs+giW3wegp3LGzzTurjY8mmt4k/Fl5ZwO2vW9bd6CNoUfjYxY/paZRbyclkVB64u1S5Yt6OxVDaHgwWEQHetEYK4ZVE0nzkpx/rb0pbmPg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR19MB4885.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199015)(8936002)(52536014)(8676002)(64756008)(76116006)(66446008)(66556008)(4326008)(33656002)(66946007)(110136005)(66476007)(316002)(786003)(2906002)(82960400001)(186003)(83380400001)(71200400001)(7696005)(55016003)(86362001)(9686003)(26005)(478600001)(38100700002)(6506007)(53546011)(122000001)(38070700005)(107886003)(41300700001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?c2VXYURQMFRSaHVYbmV4RjlzNjVHblZVa1JzSjlMVWlXVTFETW1HUWltaGdk?=
 =?utf-8?B?UUFwUENrdG5FTmY5TkROVHhwcjNXeUdiSzRCS0FFc1hmUXNmUThIU2hjOWlL?=
 =?utf-8?B?bkdNYXJHTkI0d2pnaVdkeWRxTythT0hJM2NYNWZreTRPV1h4alBnRVByaUlP?=
 =?utf-8?B?T291R0h1YnpkalJvRjlTSG5VWlBveGVab2lxM0hub1c2THR4cGNSYkcvWGdi?=
 =?utf-8?B?V3pGVjMzREg0aWtYYXRwdmkrc29iaHU5SE9zRlExOFRWZnJZTHljSk9OSEhs?=
 =?utf-8?B?K09LdjBUU21NREZ3UjYzVlg5K1RYNGhwelM0Ykx4OHdQL2FZRnhuNmVrM2Q3?=
 =?utf-8?B?SE1xMmdGLzhjUGJVR25lMG5pS2lMVFJDdm1Qa0xWQjZBak1qd1o4Mm5DcHVv?=
 =?utf-8?B?aSt2WDhCNUR5NkJnbXNHd0xZazVCS0QrVDVRK0ZYZ1VBT243UGxEVUNJZlRl?=
 =?utf-8?B?OFRKVWhmWkM5L3Bvd1FYMUtUcFZxNVo4VG5OeUR6aURLSDMrTklyNUxQRGpx?=
 =?utf-8?B?cFZVNDcybHJtSnVGKzQ5ZEZPZnlRZ0ZJdStYNmNscVZvYThURERYV2FRMUtU?=
 =?utf-8?B?eEZSaHpEaVRab095YjQ3ZkNXYm1jOTVydG1icEFzRXpXRkgvMFpNSWZ1Qmcy?=
 =?utf-8?B?YkRzbWwwUHNjMzVtMzRRanZIT2htbDd1ZEpGZDdjN2F3NytaN3g5WXowdTlv?=
 =?utf-8?B?d3N1ZnlYaUlRZUZ2V3pWQnpGNGwxeEhxa1htWDJidUJyZWdUOHlpek1DbzUr?=
 =?utf-8?B?TUR3V0hRUmRtTjdYcWRwZ1phQkQ1ZjF6b3d1VXRiaG5VcnZPSE5odnFHUTJv?=
 =?utf-8?B?RDB2aWlNQmRUaGZ4OVZNNHRFK2NYN3RLdVJoOFVXeHpsU3d1M3ZXNndjWHR0?=
 =?utf-8?B?UHNCODFpWGZ2VWNYUFd5QXFUT0U2anovR0duVzlwQUxUUjVVR0V5RC9ZYWFi?=
 =?utf-8?B?Yjh5OXNUT1VRUUdZUitQd0VVdHlZeFYvYUtBa0Z1NXpxZWNqVk42RklNYW9O?=
 =?utf-8?B?Z05mN25mbVNFNGFLclVOUFlGa2ZEWDdiR0lOeDlTZmliejZwRTFlZXFvWEVr?=
 =?utf-8?B?d3EwTmcyelJlRmg0OU9RWW1XSHl3MXFzVW4wUjZBWFp4SlA4YWxXVVV1b2J1?=
 =?utf-8?B?aXRFRmdzSTAxd09OQmhtUzlrc1JYOGF5VzZDRGNjaXVBZ1pUZnQzSG94MVo1?=
 =?utf-8?B?Nk1IeDlIOVdndWpQUWJwYjFHU0VLN3FQcnV2SFRmNTRjWHNIeno5QkJSUWJr?=
 =?utf-8?B?UWhSM0JEMzNWQVFZbS9xMnpwYXpMU3ZMK2R3TVVkTHRMR2Q5aXh3d1VCcGZL?=
 =?utf-8?B?djlOR090cndCUi8yZk5EZnpaZkFvaEZ2a01SenVITXphUmZNdTBZTHhZSUN0?=
 =?utf-8?B?Vnc5RTd0RUt0U1dERDluWEtFdVdTNDBUc2hvSlY0VW1SK08ybGx3d1ZnbjU5?=
 =?utf-8?B?R3RVTDJnQTZKQXF6ZFVSVG1Na04xNG9jL0IzK3FPSUpZSitCYWdMenBvc2N6?=
 =?utf-8?B?Q2tNV0NyZUpyTVVnR0JVd0pLTmtSdjhLYWtvUkk1MmZGTVc4M3orVDZSNU44?=
 =?utf-8?B?L0VtZU50Y2VzNTRIVkhiVUlKbTFiYXZIY2lMWXREWm1yTEJxY1JQUXBrNDJO?=
 =?utf-8?B?Y1hhY0hLTWVob2N5WlppdkRiT0RpSFhPUHRWWFVSVEFLR2lmWndFTkgrbTFS?=
 =?utf-8?B?dmlhTXdBa1NGVDBNWXpLeHdqZWhQZWFCWmx5WTVKWmZQcCtEK2k0SzNxdEs4?=
 =?utf-8?B?R1czWEpKQjJrQTNDT3BKeUtpSGpoRFVVSFhrOERXbDg3NUlpei9yeTl6cGtF?=
 =?utf-8?B?N0xVODJGTE9YVVBMUUY3NDNTMGNFOW40bjlmenJBQTdieEs1cWNqRURDNldt?=
 =?utf-8?B?SVJHQTVxNnVadzVnNUtVd1FVWDRVMmZoRTZKYmNXdGZRRXRjd2FPSVlYbmpQ?=
 =?utf-8?B?S0xrQjVhVU9xdUdVRzlMQkdibGxTWkNPcVFRdncwQjZ0V1dla0tOWk9mLytk?=
 =?utf-8?B?ZUE5bStpUVIvUHkxN01EU0Z1ZG5FYzFuQWh5aXRhYjR3ZFhHN3J4OU1sWFo2?=
 =?utf-8?B?NG92ZVFNV3U2SS9XUm5EdlFHRUIwdUpUVVc5aTFxVUJPdnB6cktXemt0MVJX?=
 =?utf-8?Q?T77VxWtByYNO/Z82wQnC9l9kR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR19MB4885.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b376cdb8-8a76-471d-ab05-08dad6eaaa25
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 18:00:59.1476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m2Umro/od1hcq6wIBwdezDMfDcuil3VISQrLuCUuF2NU20vXTm4nau0wDuuyjnnSx5SRTTNa2SEDm5FeX8jPXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB7087
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212050148
X-Proofpoint-ORIG-GUID: fbeoa2KdFGWL6g3NpMXoxrQHGETJLZvy
X-Proofpoint-GUID: fbeoa2KdFGWL6g3NpMXoxrQHGETJLZvy
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212050148
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_100115_558043_B1326427 
X-CRM114-Status: GOOD (  25.40  )
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

WWVzLCBpbyB0aW1lb3V0IGlzIG9idGFpbmFibGUgdmlhIHN5c2ZzLg0KQnV0IHRoaXMgaW9fdGlt
ZW91dCBwYXJhbSBpcyB3cml0YWJsZSBhbmQgdGhlIHVzZXIgY2FuIG1vZGlmeSB0aGlzIHZhbHVl
IGF0IGFueSB0aW1lLg0KU28gSSBzdGlsbCBmaW5kIGl0IHVzdWZsIHRvIGhhdmUgdGhpcyB2YWx1
ZSBhcyBwYXJ0IG9mIHRoaXMgbG9nLg0KDQpSZWdhcmRpbmcgdGhlIGNudGxpZCwgSSBhZ3JlZSAt
IHdlIGNhbiByZW1vdmUgaXQuDQoNClRoYW5rcw0KQW1pdA0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4gDQpTZW50OiBN
b25kYXksIDUgRGVjZW1iZXIgMjAyMiAxMTo1OQ0KVG86IEVuZ2VsLCBBbWl0IDxBbWl0LkVuZ2Vs
QERlbGwuY29tPjsgbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnDQpDYzogR3J1cGksIEVs
YWQgPEVsYWQuR3J1cGlAZGVsbC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBudm1lLXRjcDog
YWRkIGFkZGl0aW9uYWwgaW5mbyBmb3IgbnZtZV90Y3BfdGltZW91dCBsb2cNCg0KDQpbRVhURVJO
QUwgRU1BSUxdIA0KDQoNCj4gSGkgU2FnaSwgdGhhbmsgeW91IGZvciB5b3VyIGlucHV0cw0KPiAN
Cj4gSXQgc2VlbXMgdG8gbWUgdGhhdCBsb2dnaW5nIG52bWUgY29tbWFuZCBpZCBpcyBzdWZmaWNp
ZW50IGFuZCB0aGVyZSBpcyANCj4gbm8gbmVlZCB0byBsb2cgYWxzbyB0YWcgYW5kIGdlbmN0ciBz
ZXBhcmF0ZWx5IFRoaXMgaXMgZHVlIHRvIHRoZSBmYWN0IHRoYXQgY29tbWFuZCBpZCBpcyBjb25z
dHJ1Y3RlZCBhcyBzdWNoOg0KPiANCj4gfCB4eHh4IHwgeHh4eHh4eHh4eHh4IHwNCj4gICAgZ2Vu
ICAgIHJlcXVlc3QgdGFnDQo+IA0KPiBXaGF0IGRvIHlvdSB0aGluaz8NCg0KWWVzLCB0aGF0IGlz
IGZpbmUgSSBndWVzcy4NCg0KPiBSZWdhcmRpbmcgdGhlIGlvIHRpbWVvdXQgdmFsdWUsIEkgZ290
IHlvdXIgcG9pbnQuLg0KPiBsb2dnaW5nIHRoZSBpbyB0aW1lb3V0IHRocmVzaG9sZCAod2hpY2gg
aXMgdGhlIGRlbHRhIGZyb20gYWxsb2NhdGlvbiANCj4gdG8gc3VibWlzc2lvbikgaXMgc3VmZmlj
aWVudA0KPiANCj4gcmVnYXJkaW5nIG52bWUtdGNwIHRyYWNlIHBvaW50cyAtICBJIGRvbuKAmXQg
YmVsaWV2ZSB0aGF0IHdvdWxkIGhlbHAuDQo+IFRoaXMgdGltZW91dCBsb2cgaXMgb24gdGhlIGhv
c3Qgc2lkZSwgYW5kIHdlIGNhbid0IGVuc3VyZSB0aGF0IGEgDQo+IGN1c3RvbWVyIHRoYXQgaXMg
cnVubmluZyBudm1lIGhvc3Qgd2lsbCBlbmFibGUvdXNlIHRyYWNlIHBvaW50cyBJbiBhZGRpdGlv
biwgdGhlIHdob2xlIHBvaW50IG9mIHRoaXMgc3BlY2lmaWMgbG9nIGlzIGZvciBkZWJ1ZywgSSBn
dWVzcyAtIHJpZ2h0Pw0KDQpUbyBzb21lIGV4dGVudC4NCg0KPiANCj4gSG93IGRvZXMgdGhpcyBs
b2cgbG9vaz8NCj4ga2VybmVsOiBudm1lIG52bWUwOiBxdWV1ZSA0OiBjbnRsaWQgMSB0eXBlIDQg
Y2lkIDQxNjMgb3Bjb2RlIDB4MiBpbyANCj4gdGltZW91dCB0aHJlc2hvbGQgMzAwMDBtcyAoSW5j
bHVkaW5nIHRoZSBjbnRsaWQsIGNpZCAod2hpY2ggaW5jbHVkZXMgDQo+IGdlbmN0cit0YWcpLCBv
cGMsIGFuZCB0aW1lb3V0IHRocmVzaG9sZCB2YWx1ZSBpbiBtcykNCg0KQm90aCB0aGUgY250bGlk
IGFuZCB0aGUgaW8gdGltZW91dCBhcmUgb2J0YWluYWJsZSB2aWEgc3lzZnMsIHdoeSBhZGQgdGhl
c2UgdG8gdGhlIGxvZz8gVGhlIGNudGxpZCBpcyBvZnRlbiBqdXN0IGFuIGVwaGVtZXJhbCB2YWx1
ZSBhc3NpZ25lZCBieSB0aGUgY29udHJvbGxlci4NCg0Kb3Bjb2RlIGlzIGZpbmUgdG8gYWRkLg0K

