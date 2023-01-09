Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E4CC54EBD
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jan 2023 07:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=shmw7v6OpEOznRI9qR8fZ47ufqWKJZqHLk43gijjPGs=; b=Y5uq/+u5uthO+xlbNWbDr9YNL5
	Dj7C/iXWL1l0AChk+IgI8O97emlR+dgNrDsDRC4GOuRyhKoD097OoNeluMImQXIS7cxqg9Qljv1i6
	89OJyjXwhbidhbbsCVpQfGFljL5uOalN4sRhmteHta4kpo9fXk4fUaaQvn1qEJ5BIYDcz9G+crNMV
	RrN1q1vmVHAA3jSmw0/hfRrJuNIIooAPd05jN5LOtglxrKTG5Or2Hc6s3oqxXDdNScQ3MD2MT07h/
	MnQp7eL3jlQb90c2PPxhMN7aXEYDW1pvs1TS9ktTfCHhz/CX8rXygTePKFU/VMCVjt5n8TKWr177U
	+7iZe1rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEmAK-0005VX-4x; Mon, 09 Jan 2023 07:01:52 +0000
Received: from mail-mw2nam04on2061.outbound.protection.outlook.com ([40.107.101.61] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEmAH-0005UO-2I
	for linux-nvme@lists.infradead.org; Mon, 09 Jan 2023 07:01:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvGKVT7wOw4BtVBd3EMEMRyJ45QTCJOwb2YEQbPT/iL1W32jAhQvo+o512sJzoVQwNUVSaQre45p6Cam6T5XvEt4+u4Ke9P0e5YQ8pezihIGul88w9CQGOLrKAIbNRwfD/ttUFg93dLsqGn6Z1DU+s0FRu2Q4Yckg0dj+4wiB2vONTuCShCWfGqVvS7hPcTh46MUxPy+/errpHYgzMWWP5WiTBHNB+2T1SwPKsMKqS8wfefeXNfJiDOxdM/az/6FDIcpuXOILQ5+RtWetxrB415f8RVntN8QN5Ac4gTKfwgvlotlU60N5h7fzsKDZx4o5t1+wPfqu7d+X+b4cIBzXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shmw7v6OpEOznRI9qR8fZ47ufqWKJZqHLk43gijjPGs=;
 b=hqw3dp+oaL8s/E0eng9gwhv76E/L91JydCtpU6X8Yzk2EeucdiwHHqOVrr17AqCuhH1OOahBX/XwqgMuerjIDSeVLnELbA1FWNkTdlyNBPx/A15VIcHdjzyiC5NNI7pwmwcL/vjuoV85bHXkqQFcTIY++DxY6rZ9ObZsERMYjWzYCob1VRtXmDQH2amFIFERnFe7N6VbTNA49WR1XTnVb0bWK9AcbTMX/LLfz9NsV/hbsYuPaxxpew9gWjIFsq0yB3NfOsC2Zf03pESHXfGyRxTWCLVFFk8X3FdI4KUUJzWXTzVbWjztuvq/a1b2QRIwnEXGCDIM8rjTDhokknmrCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shmw7v6OpEOznRI9qR8fZ47ufqWKJZqHLk43gijjPGs=;
 b=AtH0apx08OBDMkrFVTeI82pnAUMEKmvEHW/24RK9MFggr/BTxKbLIgr+EqpQ96MK3FqminoniuKDV0gsoaaO7nENIx/bjd4fCnxYNGLVb5CM8xh2p8Xc2zBsxQvBtCM0f2yi4dAIWSuC2bPZHQFyiVnXtdD9gWFvfQmaQ1SXsq3jZYHNBgisDazhsN0dpQIFStDXjQsX2i6tfNB49uD+CKhp8XCxCn/7UEe+4qqA3gcTREXMS/U4eVG4rALJ/S+A4cS+Wbxw9UTgiXgk6U8dJBZ4Y3lwrfHmngn0u/6H7jNpXEGry6xtbbLBmF88ke23z7tUtfFoIMBw7cHX5enN2A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW4PR12MB7216.namprd12.prod.outlook.com (2603:10b6:303:226::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 07:01:42 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 07:01:42 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "hare@suse.de" <hare@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-common: simplify nvme_auth_generate_key
Thread-Topic: [PATCH] nvme-common: simplify nvme_auth_generate_key
Thread-Index: AQHZI5DqMgCFQ1EDN0iJb+AgOd6PuK6VqVGA
Date: Mon, 9 Jan 2023 07:01:41 +0000
Message-ID: <ebb946b0-9662-696f-c3e1-8cae2166b372@nvidia.com>
References: <20230108184123.393727-1-hch@lst.de>
In-Reply-To: <20230108184123.393727-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MW4PR12MB7216:EE_
x-ms-office365-filtering-correlation-id: 2afafbfd-9646-4a37-d502-08daf20f5cb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  awqqfLeVSzbhylUH0iy81uLlRsgQGsB/RE+mYX6X/XHj9JRrFwxPROFkgtbpcNPkwIW8/f/Ymoi85SCOaL7NjLJwEze8grcATHWl8Z3dOLyiji+gFomy4LcZFgiZG3NehS+AKu731Vup7btpkP30UUuEQPgygThXrJl4ZZpS6ViA9dMR69IOOxLnquVJV1kF0PqDQCpGaDcqkpb5TsoXsbkJSjTeXjKdpzRyOnSgOs4IS/IlY186UwkPNIlsAYDm8n81TDHn7yvtD5zNgwaOGsmuQC2mwDzIOTgs7VYrb0J76ONNMgCS7460GJDoQ/rzfLkhN1JOiVms4dR0ufPTsA2iiE0+RtR+9J2wAHQug+5PN71wImhLTmWTX9zIFiIqm+l4hqvwf8n71Q0Fi6a+1glvRErAgFvitabWS4ee0H9GWPF2zDslZDEkfKG70if0FGlWFxzUDefVUFeGxZCjrtXYYos5rxvOxRmrgUrpfyAwYX8GeqnCvdfD+kvn1Wloq7Xy5chshsTUaWFZ0wWjDVQK/3Ax64BfLB1KEtx0gbPjGCP7VCt1RBsLpvfqdsyBg2/bI+m2s8+vPgIfQ0/zXODKZkRiQgl5I9XbmUE7We/J7eVVyVp3DJFd59Gb1J6TdtDYSaQ1s/he6nG3j9R8eqv4jt7D9LXhYbTZQ/m8gP6rp5rpMvOPnvpnNYj++tTQJiSzZ+xxT+yx6GcwwtpwWaGXsa9ZHJgaEAufCkaoE2A647N1yQIj7rK7y8PBV7tPu2bNPVeINZBmqmFFXRL5VA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199015)(53546011)(2906002)(558084003)(71200400001)(6506007)(6486002)(478600001)(186003)(6512007)(31686004)(110136005)(316002)(2616005)(36756003)(66446008)(76116006)(66476007)(66556008)(8676002)(66946007)(64756008)(4326008)(41300700001)(83380400001)(5660300002)(122000001)(38100700002)(8936002)(38070700005)(91956017)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?ZjZPdnNrUnp3bmY3WVA4REw5ZCtOdUVuWXJiU1lpN2JoRmZYMjhPYmxFMTY4?=
 =?utf-8?B?WEw2a25kNXVQci9IS2tRdXhNaUdiTkkxbDlGbm1TbGdTUTd0dkVZR2Q3QjVx?=
 =?utf-8?B?ZXhLWWdnK1JLN0wzWVNnMm9YV0FIbitleWxZeWpyZnhwNnlSS01GR25EUzYz?=
 =?utf-8?B?cFR4WU5xWlUxQjFTdGI0Tlh1T3drbEdLeUJheHo2aTRpTE5WVWl2ZEJUcEwy?=
 =?utf-8?B?OC9iSzcrWjV4VFNERzhzL2c1YkVUM242VkVZZVh6V0ZyK092WC9ZQnRoNXJD?=
 =?utf-8?B?bFFqWkV6OGVUZnp0RFh3MXdNdzdKOHh0ZVBjM0N0aTRVMFVQQVdFMHpMTkg4?=
 =?utf-8?B?NDFtNUV5Sys4R3QvaCtJUXZac2ZJR3pjY29GWW4wOWUwOXk2dm0rYm0rS0Qz?=
 =?utf-8?B?OTdxM3lBTm5YTEJqeFJlYWxFdkpRdlA4UEwwcVhRbjFocEV0TnhHRk5GL1Ey?=
 =?utf-8?B?TWFHYkNBbDRFbllpT0xLNHd0TFIrWCt3dXlobThjTms5eFR5ZjVUQ2dDdmlZ?=
 =?utf-8?B?TnRPSWtxVkZERk91WkZndDRqYXByRE43N3d2TFRGeXZGNlVmcmdrNzljUWFq?=
 =?utf-8?B?dzg0ZVR4b21YZEN1MmNnK2FmMVpWQU9rZlpYcFE5NlM1OGlDNkpsQXFjZlE1?=
 =?utf-8?B?bmFrZllRd1ZDS0VKS2pXTUNLRXByRDB5bmJkTC8rSDZMQUZra0JFWTFzRDVi?=
 =?utf-8?B?RjQveEZrTjV6OVFPUjV4MHJ3ajVOOG9MNEpRMnh6ZTNSUExkY21naFppTnFh?=
 =?utf-8?B?dkJTTFMzenVtdkdxelRIYzJvREtsT2VMMldyUU1UbHN1ZW1JTkVIdkFVbUxQ?=
 =?utf-8?B?N3FXcmMvYWJ1dEE0L2pZOW94MzVYYUpDZkJqNEl4TU9NbFhqanRUL0kySVU4?=
 =?utf-8?B?ZHZXejFiaU1nTmFMSXhuNUtRSExocS9adHpRZ21vNjlyTjQ1ZWJVaGJ5RnNX?=
 =?utf-8?B?SDlxU0VUU0Z5UldLckF4WHF6dmJITGxpZjZWNnNmRlVYYmlJMUFsTXBHMDh5?=
 =?utf-8?B?RWQwMmtmMTdSSm9xTzRvT1h2TllOclNjck1TbmZPdStjUFRvNDBsbWlUbGVD?=
 =?utf-8?B?eVgxdHJQRUk5dm0zRjRhcEVEbSt1MUdUZDAxVUdvRkRwanRQelVPZUNvNjA2?=
 =?utf-8?B?Ykd1bklzZklKWVYzZ3Y5NzlpRVV6OFZUS0YxZzBYQkV4WGVqZE40UU1zWWJR?=
 =?utf-8?B?eEYzd3p0cWZkem1rS1JVNFY4aVB1OGh3VDNqSXJYYTJEMllKTHZKQkVMM2Zs?=
 =?utf-8?B?dWRsUWhVblduZTZBangwWUFkOHMwa3E2UVNFTTBZbGJTV1NpdDRIMHkzT0Vr?=
 =?utf-8?B?d1dTeVgyVWJxZE9mMUY1T0FaRS9pc3BTU1Rma2V4a2FITDQ1cW8vQmt0SVc1?=
 =?utf-8?B?YUNkYTB6Q3NuSkd0S1hjbjZXRnZXTzFTTi9zM3lKZHh4Si9LYmVzR0o3c29G?=
 =?utf-8?B?L0czeGlSVlFnY29OSk1UTEREVVloWUhFQ1BsTWtMYWFaci9VYkQySnBzd0tS?=
 =?utf-8?B?bTdSTXhJcXZYak9lYkM5RUQydVQ5elVxM3NETXE3NXEvZmZwQktENDdRanp0?=
 =?utf-8?B?QUJqSmxLYmJjMmtyL1JEdGxRQWlJbnhvcXhTQnFSK2U0eFYvWkRVUlZVRDZO?=
 =?utf-8?B?TWloSzdkdmVIc3NJeFpRMkxGNTR0WklhOEJEZFROanVnbElpR3JETWUyN3du?=
 =?utf-8?B?aUlIc2VLQTVIaEFvc3B2M0cvWGJZbHJtc01CQUZFU3FNNjdidE1waVR6d29Z?=
 =?utf-8?B?MkRSbnZiS2RJRnBsQmZOTEdoK0x3RkwyOWhOdnUweGFYdWVHRks5L01MWjlY?=
 =?utf-8?B?bVZHZUFDWDJSejQ3SWZLcDFSNkV6WUp5M2FZSXFjVDNUbWVwTGlaMzZsMVg4?=
 =?utf-8?B?UGxDNytrb0lLTm53M0FYNi9OcTRaZXR2Um5CMXJwcThqYzJTTk1MYXRvYkpT?=
 =?utf-8?B?QXczQjRxSEpnYTNNaFkwVGdrSVNTNkNlY1BJWGpNTnQvR1VpQjRGUlIvWklu?=
 =?utf-8?B?ODZURnMvSENxYTBaOG85OWVsZExRVG5PeUswUkJ4blRMQjVQMDR2Z0c0MW5B?=
 =?utf-8?B?Q1c3U0lCVkV5aDRDeVJkNjlER3dlMGdZZ3pNK3NJeWRNMTVkaUJMbHpkMDE0?=
 =?utf-8?B?eE1LbWJoV0YzNTJ2ZVZTWkF0T21ZUGZEZUt5YzQ1SFdPZTd2TG9JRDZSRzJY?=
 =?utf-8?B?WHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <379453CAFE1D8C41A7EBC4A3796F0E5A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afafbfd-9646-4a37-d502-08daf20f5cb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 07:01:41.9598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GNGpFrwkZyv9OiwJuzh0GfkHxlgWrP2Etf1yFbmGFZJ+CgoTjfT8QkfCa3Rolx1jjaC99tjbkM6I77l50xak6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230108_230149_338974_D2BE28A6 
X-CRM114-Status: GOOD (  10.58  )
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

T24gMS84LzIzIDEwOjQxLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gUmV0dXJuIHRoZSBr
ZXkgb3IgTlVMTCBvbiBzdWNjZXNzLCBhbmQgYW4gRVJSX1BUUiBvbiBmYWlsdXJlDQo+IGluc3Rl
YWQgb2YgcGFzc2luZyBhIHNlcGFyYXRlIHJldF9rZXkgYXJndW1lbnQgdG8gcmV0dXJuIHRoZSBr
ZXkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4N
Cj4gLS0tDQoNCkxvb2tzIGdvb2QsDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fybmkg
PGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K

