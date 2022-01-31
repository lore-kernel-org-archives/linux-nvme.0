Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D640C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jan 2022 17:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=40j46MZZGqfM9qW5iBO6EtpAcbJHzSyKuogdLioswpc=; b=KV5xGZcd1f1mCYqnQWlKaShkqJ
	x1RBPD9OMk8RBTlhypAjEpw/rHbP7sPLuX6zDoFlgDcwhnax1XTJz4QdpnULU0YG/IWpPFfO8eoEN
	jO0+UYB2gz40nM77tv/1GqqYVdhKko8kKg2Gu1fN7yemgPaWPrIM8ww4pMm9lLE+q0pwU6Zx5ziX2
	XxqDOWmg6zD09ia8FYngmZeVawnWDcluCz6jM4UQZeHUe777bcz6USg+fYIVqBvOhZLFzGeyRhiGI
	6vWvTFvpWVd1Eig6ke2UVMTzAY/AXwKbj3Oihw4g06pPBQLeBkMNwExl0AzofHtBznRd8IKxANcOw
	hHHR9PzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEaYw-00A9KL-8c; Mon, 31 Jan 2022 17:33:58 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEaJp-00A3Z4-Hh
 for linux-nvme@lists.infradead.org; Mon, 31 Jan 2022 17:18:23 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20VAX0gQ014865;
 Mon, 31 Jan 2022 12:18:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=40j46MZZGqfM9qW5iBO6EtpAcbJHzSyKuogdLioswpc=;
 b=Ef2GkLRVKTXSEVB0YNmptAHFEG1vKlBhLxJQykgWC+rOF7ent+lW4NzKxboYkF7GbO5x
 9yjtb09PF3tUtZqSB5T8lApTiQGn/9WnxwY3fgOc4YjFDX4Rx6bD2r04jsrpK/XwWBjC
 b9P+hRhBo1TL7iyolzi872p+d1mVyeVx5IE9UQVYQBIknFglT837C2T7uYisP1kautWA
 7UKghvZfx+TTsAyRYMR+Qsp9HV3ARkqo9BuXxUCKBkeB3wx8pziFEJid2rHE9t3y5TEY
 CcgPBmWjAHdN6JWKhLPg9DJKGlxuKRE0p8uEqwBeUpm55wck3a5yk4THQ9efyitbEKO9 bA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3dw2fpx9kw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 31 Jan 2022 12:18:00 -0500
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 20VHEqHE015238; Mon, 31 Jan 2022 12:17:59 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
 by mx0b-00154901.pphosted.com with ESMTP id 3dwkenjetb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 31 Jan 2022 12:17:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4XVTY9NQaKshAajA/Z34xIO2p1Z7edDB8+zD6h1dUK3cEeViUwMseKoMqg+b9vyNmkqymfLBhl1ZKuV5KdMNGbk78rz1jHK9e0VZbZOG0aBPjQ2wHKgnNsRQh75o/J3bhdTudcxzD8XaPPdqpH7Q00ECxOAODrSJgwMGE1eP5fpGvw236JqbWj1gDtIhY8SqjHk7z6poivz++xBros9DoEIAki59Kwrmq+u3c9O9dWiLyftpPrcfr6Kc7Fbu5j8mKSJlFtJPcoqLZXfxs12R/AWTI6NHWYW34E5Mhd5As5zWRcAwb2FDUW2dgb+YgaPhsXFico7OAc6Q1dQynw5AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40j46MZZGqfM9qW5iBO6EtpAcbJHzSyKuogdLioswpc=;
 b=GN9IsPcOIU6gM6OSXpfKPbHsSM5W2bi7wQIfTByjPjZFXceWNxUVFISf/R48OYJ+DuzkKAgDpErl7wGQD/2R1TnHzQuHjUbpS6pH6zfNhIffPwL5x5HJd0Z0He0DU2AR9GJI7T7HsER15vUbx8zrV5EzgRckpSFuGV+WUTolsmx9FKayWe6nCCIVSTstUoY5yxkWxsMrRUatEpAGjPIuDrMzYiKHGeZ7kFZl8vMHrDaueWflS+1fzS55wl5OF6h6jF5AUlK+DPiHoyZLuswzmoopDhNpNV/UKwrqGK3HAVK+Rz2lskQ1jQusJYk6ryncQRgvN/DEiuBWfXbjBI9WUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com (2603:10b6:a03:281::7)
 by CO6PR19MB4753.namprd19.prod.outlook.com (2603:10b6:5:342::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22; Mon, 31 Jan
 2022 17:17:58 +0000
Received: from SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::719f:7855:b24f:f0d9]) by SJ0PR19MB4544.namprd19.prod.outlook.com
 ([fe80::719f:7855:b24f:f0d9%4]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 17:17:57 +0000
From: "Belanger, Martin" <Martin.Belanger@dell.com>
To: John Meneghini <jmeneghi@redhat.com>, Martin Belanger
 <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hare@suse.de" <hare@suse.de>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: RE: [PATCH 3/4] nvme-fabrics: add tp8010 support
Thread-Topic: [PATCH 3/4] nvme-fabrics: add tp8010 support
Thread-Index: AQHYEfxP/F7s1ilTfEGG+nDhesZTRKx9ZNiAgAAAhYA=
Date: Mon, 31 Jan 2022 17:17:57 +0000
Message-ID: <SJ0PR19MB454431C4643E2CB5C0BB45C1F2259@SJ0PR19MB4544.namprd19.prod.outlook.com>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
 <BL0PR13MB4291A94BED970C6599BBC6679C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <047b496c-e3a4-bcaa-c542-3f933ed8d54a@redhat.com>
In-Reply-To: <047b496c-e3a4-bcaa-c542-3f933ed8d54a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Enabled=true;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SetDate=2022-01-31T17:17:55Z; 
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Method=Standard;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_Name=No Protection (Label
 Only) - Internal Use;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ActionId=55d508c2-117c-4b56-8be9-0dbdb9779170;
 MSIP_Label_73dd1fcc-24d7-4f55-9dc2-c1518f171327_ContentBits=2
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08313d88-f441-4f4f-84c2-08d9e4dda066
x-ms-traffictypediagnostic: CO6PR19MB4753:EE_
x-microsoft-antispam-prvs: <CO6PR19MB4753BEA4EEB69E70782214D6F2259@CO6PR19MB4753.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jHAl2jeasjWtdfnv73kvutHcLXSZN2hid1yuzDpTDAPpQ6OdRMaCqVuh4StHAY1JJIVjEQJIiq59SnV/KjrTMMv9r6BS8s08LZaiGWKifxdocHLVTLY0Kl0UBPUMpWPwxkAz5ll3LZMQpX9g8M4sq14CZEfuEAo8BMO2SU4hs/LLkwY59uoL9fVPuZV20m26zECBjVar9xGwK/QrxV/4NQ3+MxNeKsEU5G/mio6+xXzJl10vo7SVD6pL0aE8UwfvEyk1gs2w+QFzcLuDvog2Hfpa0YOXgAEuCX0ZK5GOIpi1RkKaTKaCqLZT1wvTNXrwTRN1a4B7mWqJ5dMFn4XyC0xpp5RLbSPQYNPWfPkoj64Xudu1GgEwp6Nt7hQLrWZQv5itcbooa8Otn1KDIw5oeDcyxFYX8VPhvExuoCdkmdFSeUW553y81Py/xhNEXdNHbvz36A3zec+hZUw1EgevyWmDsOw8hCbjU/PmZiG5Rw6zb0vIxOU2C5scsfs2vhuYMpKmWDLVgd0Jlu4Q2qWNBBU1X5QjWFGkiNtd/Nnis9WUd+NAewJ7d0QWlKJENOvYJD3kOF6z70SxnA/8s8hJbuiuFYyeF55HFYve1GxdIYUb2xM06kCJRQPafCVrEyjlDaz5IVhNaiUALDtbF729k9yGfqlyaM6sqGpqtuATgn9Jo996v8uPM+ceoVh6QW/BzcNhjD2ks9MHxxaP9WPPYAneVBFOAfdg/UMIFPeTgp4la1J4r3RgOoaFVlmmz+dNwFIYhZ9bPmTi8odnsET3JnWJmkhiHjbSo/s8IhTPz0lT+G5UakUuW7qsTuWBx1TniU4zWLQVJ0rNfInpvjyUappokeoGdIOU5jpyRHZeKrw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR19MB4544.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(55016003)(66476007)(66556008)(76116006)(52536014)(8936002)(66946007)(5660300002)(966005)(4326008)(33656002)(8676002)(83380400001)(786003)(122000001)(110136005)(86362001)(82960400001)(54906003)(2906002)(26005)(316002)(186003)(38070700005)(9686003)(7696005)(53546011)(508600001)(66446008)(64756008)(38100700002)(6506007)(71200400001)(15398625002)(43620500001)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEcxRFNEYk5VQmhiU2hlWjNHSWRJbWI3UGZMUmo1anRjeE9JN1h5eFNTeE0x?=
 =?utf-8?B?OXFWQjUwSklxM3JwUnRZalJGRFRJUG43ZWQ4ZXplUm9Bd3ltdVRxckxHWGN3?=
 =?utf-8?B?NWRkRnBnaFVETGNLdnhVd0RlWnpkNGhPazMyVVllcVl5SzNoSjJQN2dLN3o2?=
 =?utf-8?B?VlplNXliUkx3RHpVaFMreWpsaU41VUk4SXJCbHFzQncyNUZoUkhpclZBOW5i?=
 =?utf-8?B?cDdxblYxaGxEVmlrVXFSZW8wSTFvRkpYdmIxWWw0WUE4dmdwU3Z0SWRJZVJ3?=
 =?utf-8?B?aG83NzZ3ZWpZYk42bzdWYkFwL0doTTdLVHNPTnl1U0JUM2lEbzBPbklnSE9k?=
 =?utf-8?B?RDYxTGYyUmVCd3RqWlhHL21oMUMwT2I4eWlSSmxmM05mT0U5K2tZRGwvc0ha?=
 =?utf-8?B?OFpVSjczN0xicHlaYklzaE1Cb1Z0amdlbkttTVB0MEVLMThRdjREdnl5blh5?=
 =?utf-8?B?a3ZrWVJrZ1ZIeG5BTSt6akRzZ083Z2xVMGJqOUw0bllkQ2VYMmJmQndCTlE4?=
 =?utf-8?B?Rk9GM1VhVzcyVGN3TVAxakg2eTJJanhLTXZJaVJIYys5T3JiYWhvSHIrTW41?=
 =?utf-8?B?SFkvQjF0SmJnNFFyeW1YMEFqZ2pYNlZOdGdESDJudW5QNFdKUDZJcW9JM2FW?=
 =?utf-8?B?QTRoeXR3RENGMzQxNkRvd2NoL3R2a2NRQ2Y3K0dIOW1FTUY4SUg2RXVqY3Yx?=
 =?utf-8?B?VGI4MFZkSWJxRnE1T2VQb2llajNHWkdVWDRlb2dNZmNhVHorM1VvWnFRalY3?=
 =?utf-8?B?R2sxUmw1d240V2JndkhBTUpqYTFYUlMrWTQrTkVzZ0gybkZBaHVMM2R6c09U?=
 =?utf-8?B?cUs3OE5zZTk0dUFQTHV0Y3hOVm5acTVFYjErVjZJa1RjL0xjT0Y4MFpSZjFS?=
 =?utf-8?B?UmdiZnFqeCtaZE9QdU5uTmFLWXNKVnlDcTFsQzNPZVZaWG95ZjJVVnRINTc1?=
 =?utf-8?B?K3J2WWlDNDBVY01sY25XM0xnMjNZdExPT1VUOGkrYTRVQjN0SzEycGtJL1JE?=
 =?utf-8?B?NCtqVTNueVR3cmhzT3pTMVlrdE9lSG9nZE5QQTBsYVVRc1ZhSUNBbjlNN1Vs?=
 =?utf-8?B?MHc2ck9RSXA0dk9paWZsWno1dGxObEhCR3FqdHpUVG1jQVFKei9UUWsvVlZN?=
 =?utf-8?B?TFZ2TG1WaUE0UmVIdk0xV3d4YUxRTUNuTG1EU3BRaUgyak5zS1pwSXU1ZjM4?=
 =?utf-8?B?S1N4a1M3b29BWVcveFBNclYvUWFWbmh3ejBNc0NqaFdaN0hSN0tBK3loS1I2?=
 =?utf-8?B?TEJvK1NxODJoKzArL2N3Nnd4UU1oNTc0THc4emIyWFhqNElINVQwTlpRSXN5?=
 =?utf-8?B?UXlRN3JvdTBsNTEwOHUwVDhuSGpab1RUN00yNDFxQzdHdUcwWFc5WURPbU8v?=
 =?utf-8?B?dDlVdklmRWd3ZTlIZUFNdStsN1VwYWdnL2ZKMFFNR2ZBVS8zMEVhd1Jkd0RP?=
 =?utf-8?B?MEs2cTRjWU9panpyN21xUkRUdUx1L3B5Rk1URmNGQktKcGNDZFZxRzdwbEdo?=
 =?utf-8?B?QlRlSFVPNjhjaGluWE1yKzRZUFIrdDc4VXE2aHh5YU85UE5nK3IrVmhCZTNn?=
 =?utf-8?B?TS9uSFN3MEhuL1lpNFdQUmZOZTRtUmR4Zk5GbjFWS1F0ZC9vK2pBUmJQd1VP?=
 =?utf-8?B?dnFiVVE5TWlXUEpoeEJWT2hxbitwOU9NVlM3U2RROXltRitSTWhtK2dGU2Rh?=
 =?utf-8?B?WHIyYXZNVVo0WFVRNzJaZGhQdDdjeG80d09RZFlzaVVVQ3d5S2doYjBDeHdG?=
 =?utf-8?B?R3hWVUtGUkh5YTRjNGRWOS9OVzBKYk9nZ1dYV1BGaUlsMTZ3SUZrNFB5QWZr?=
 =?utf-8?B?YlcvZVdCVVBkMzRDc1EvVkU5SnprRDlCdnNkeHlsTXdLQitRbC9Lb2E1Tno5?=
 =?utf-8?B?ME9RMmRBdE84UmdwY1BubUlRbzNLRERiTTU4UFFDK0hvOHE1eXJkWHo2UUtz?=
 =?utf-8?B?VzUvMDhJQTdtdGRYUzFTQm13WTJKU3VMNFZzcWxJKzZ0L2pPZytnSDFmTTZ0?=
 =?utf-8?B?R2JVUGVqMjczZU5uMWIzNWRod2UyeE92cE55eERoUHc3K1VHZldVZ1k5U0dW?=
 =?utf-8?B?WFFnQnRPVHVKOVZwTDR4RkZTZFpRS0gzWld5MWQ5dUhGcHNTdHpEcEdRTkVi?=
 =?utf-8?B?b2hscmhwMVlmSmhNRUJUOHZCbjdmVmRqajB6aU9pWFhKYUVVWlFmWlBULy9q?=
 =?utf-8?B?MDhSTFErZlpUNDMrazFmRThyQUxVUS9ReVpELzN1T1JEdnhRZTZIUTY1Q2lJ?=
 =?utf-8?B?K1JaZy9xczNldjd1R2dadVVHQ1lRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR19MB4544.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08313d88-f441-4f4f-84c2-08d9e4dda066
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 17:17:57.8989 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wqo/GrUIn3FJPFmks7HvAXyFYyoHI6c07adoVGS/6vAw8HBWqwLPmbx/Vt9wHBFDsxVXrGH7QbAfn9SsTWkapQRycInf802LTyYsQCziByc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR19MB4753
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425, 18.0.816
 definitions=2022-01-31_07:2022-01-31,
 2022-01-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1011 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201310113
X-Proofpoint-GUID: NGXGFHxCx-FgFz7bNdKuhKKzm_qQANpB
X-Proofpoint-ORIG-GUID: NGXGFHxCx-FgFz7bNdKuhKKzm_qQANpB
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201310113
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220131_091821_707966_4EA446BC 
X-CRM114-Status: GOOD (  24.04  )
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

PiBIaSBNYXJ0aW4uDQo+IA0KPiBQcm9wZXJseSBzcGVha2luZywgcmVnaXN0cmF0aW9ucyBhcmUg
c2VudCB0byB0aGUgQ0RDLCBub3QgdGhlIERDLg0KPiANCj4gQ29ycmVjdD8NCj4gDQo+IENhbiB3
ZSBwbGVhc2UgY2hhbmdlIHRoaXMsIGV2ZXJ5d2hlcmUsIHRvIGJlIGNsZWFyIGFib3V0IHdoZW4g
d2UgYXJlDQo+ICJ0YWxraW5nIiB0byB0aGUgQ0RDIChDZW50cmFsaXplZCBEaXNjb3ZlcnkgQ29u
dHJvbGxlcikgYW5kIHdoZW4gd2UgYXJlDQo+IHRhbGtpbmcgdG8gdGhlIERDIChEaXNjb3Zlcnkg
Q29udHJvbGxlcikuDQo+IA0KPiAvSm9obg0KDQpIaSBKb2huLiANCg0KVFA4MDEwIG9yaWdpbmFs
bHkgaW50ZW5kZWQgZm9yIHJlZ2lzdHJhdGlvbiAoRElNIFBEVSkgdG8gYmUgc2VudCANCnRvIENE
Q3Mgb25seS4gSG93ZXZlciwgdGhpcyB3YXMgY2hhbmdlZCB0byBpbmNsdWRlIERpcmVjdCBEaXNj
b3ZlcnkgDQpDb250cm9sbGVycyAoRERDKSAgYXMgd2VsbC4gVGhhdCdzIHdoeSBJIHVzZSBEQyBh
bmQgbm90IENEQy4gDQoNCkFsc28gbm90ZSB0aGF0IFRQODAxMCBpbnRyb2R1Y2VzIGEgbmV3IERD
VFlQRSBmaWVsZCBpbiB0aGUgcmVzcG9uc2UgdG8gDQp0aGUgSWRlbnRpZnkgY29tbWFuZCwgd2hp
Y2ggaXMgdXNlZCB0byBkaWZmZXJlbnRpYXRlIGJldHdlZW4gYSBDREMgYW5kIA0KYSBEREMuIExl
Z2FjeSBEQ3MgdGhhdCBkbyBub3QgY29tcGx5IHRvIFRQODAxMCB3aWxsIGhhdmUgRENUWVBFPTAg
DQooaS5lLiBEaXNjb3ZlcnkgY29udHJvbGxlciB0eXBlIGlzIG5vdCByZXBvcnRlZCkuIFNvLCBy
ZWdpc3RyYXRpb24gd2lsbCBub3QgDQpiZSBhdHRlbXB0ZWQgIGZvciBEQ1RZUEUgb3RoZXIgdGhh
biAxIChEREMpIGFuZCAyIChDREMpLg0KDQpIZXJlIHlvdSB3aWxsIGZpbmQgdGhlIHJhdGlmaWVk
IHZlcnNpb24gb2YgVFA4MDEwOiANCmh0dHBzOi8vbnZtZXhwcmVzcy5vcmcvd3AtY29udGVudC91
cGxvYWRzL05WTS1FeHByZXNzLTIuMC1SYXRpZmllZC1UUHMtMDEyNDIwMjIuemlwDQoNCk1hcnRp
bg0KDQo+IA0KPiBPbiAxLzI1LzIyIDA5OjU5LCBNYXJ0aW4gQmVsYW5nZXIgd3JvdGU6DQo+ID4g
Ky8qKg0KPiA+ICsgKiBudm1lX2dldF9hZHJmYW0oKSAtIEdldCBhZGRyZXNzIGZhbWlseSBmb3Ig
dGhlIGFkZHJlc3Mgd2UncmUNCj4gPiArcmVnaXN0ZXJpbmcNCj4gPiArICogd2l0aCB0aGUgREMu
IFdlIHJldHJpZXZlIHRoaXMgaW5mbyBmcm9tIHRoZSBzb2NrZXQgaXRzZWxmLiBJZiB3ZQ0KPiA+
ICtjYW4ndA0KPiA+ICsgKiBnZXQgdGhlIHNvdXJjZSBhZGRyZXNzIGZyb20gdGhlIHNvY2tldCwg
dGhlbiB3ZSdsbCBpbmZlciB0aGUNCj4gPiArYWRkcmVzcw0KPiA+ICsgKiBmYW1pbHkgZnJvbSB0
aGUgYWRkcmVzcyBvZiB0aGUgREMgc2luY2UgdGhlIERDIGFkZHJlc3MgaGFzIHRoZQ0KPiA+ICtz
YW1lDQo+ID4gKyAqIGFkZHJlc3MgZmFtaWx5Lg0KPiA+ICsgKg0KPiA+ICsgKiBAY3RybDogSG9z
dCBOVk1lIGNvbnRyb2xsZXIgaW5zdGFuY2UgbWFpbnRhaW5pbmcgdGhlIGFkbWluIHF1ZXVlDQo+
IHVzZWQgdG8NCj4gPiArICogICAgICBzdWJtaXQgdGhlIERJTSBjb21tYW5kIHRvIHRoZSBEQy4N
Cj4gPiArICoNCj4gPiArICogUmV0dXJuOiBUaGUgYWRkcmVzcyBmYW1pbHkgb2YgdGhlIHNvdXJj
ZSBhZGRyZXNzIGFzc29jaWF0ZWQgd2l0aA0KPiA+ICt0aGUNCj4gPiArICogc29ja2V0IGNvbm5l
Y3RlZCB0byB0aGUgREMuDQoNCg0KSW50ZXJuYWwgVXNlIC0gQ29uZmlkZW50aWFsDQo=

