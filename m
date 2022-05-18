Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5FCC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 15:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=722D0ZOCzKtvHcZdysMS5KrDzg71AB0fmnPiomDgjOM=; b=I4cebjPYM5vMQfOM6oyd1r7IC5
	yG+OlAHQqlHCIThI/5rBMQawNDUveep+ZMbUtJ1CyxN2BUKbuvX5RKjLc1tYaroHZxJTl/1rq4D97
	Efafr5fBCJcix2vElrDtd5A0FR/vckfu9s7gGWiHTh6u/tsT7UFeiv35LZahsfkUhDI7+xp2IBej7
	kOPmdaJMp5KXdI/TBXy189UNhaabz6VpXbrWylIxNiUdLXrKvU3XcSlgTCoujUD9M54GmDNB6celJ
	m3nZn/jgRcsofzHMpg58iA8gyGEML+Bzr7ISWp6Qqcokxsu3J89kivbmrDi17Idt1+BF+bDtBnmR9
	dBYghmUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrLyN-002vED-ED; Wed, 18 May 2022 15:52:27 +0000
Received: from mail-mw2nam12on20626.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::626]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrLyK-002vDX-8i
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 15:52:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Km8798XXMPURxwm3LSFR4n9rIfMbvLf7d4jOhCLEg8c9VqAEYYivu3w0QFgQ4Q0T6CNNB/aPksOEcCCjb45lJ3nfcNRRNmfHmKfC+chBcyvL/IL1OtAGJY2ocRe/dulklEVHLFGKfAQNF5V/U0ITkrTkut2Wsee/d5Igld5H8XwrnMybmVg6fEgSzpMjw6F5RBVZqar9AuwfNpNAy2Yz03pQ/15HRlIOWjuRJkblPHFvZxOCfnWtDldYxZogFDlOIQTRv7lFZV/EQ3fByuRO/sta4EQCNKtZYqd+l3ATZFDbqMMXeGySYGRI139yPW4obBEFd4/fr5phNfTXHpBO1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=722D0ZOCzKtvHcZdysMS5KrDzg71AB0fmnPiomDgjOM=;
 b=QRpWYxXGEU1kv1RjGQHU5qEBfq2nRl4iIWbrhFSYpuIOBzMTxpZncsBP7v0ZisxMQHU5q2J0VrgZqrIaTgWqnt+gVczQH4EOFjsohWcJAT0uR/5K0iJQzlQlHELaDju1M/WzdGJ6VgJ8vRD4PIJn+N/91Hn8uxHbHtRgF3oLeNJjRRgbql97S0jbCPt9JJFE08aMZzUjmTRJPrGtY3JnGh9dlzMwmtFjEwFYbxPBnEt9zL+mDZQDYkfFNY2e0tAB6t/P495j8QmjhkaFyZ6pq9IOGH+vN/GcMC/AckRW2queSkuqssox8rlkfgmp/4u2NMc4z0OiK+m3bnLPLs0tYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=722D0ZOCzKtvHcZdysMS5KrDzg71AB0fmnPiomDgjOM=;
 b=OhOs+z9snsUzomIYP5rok062JSR0RPv2pb7tGZgsEq5iWIzFsg5csTsmF5p0J2PBOOvAnND5cTQHTtnspRSn+p7NYSFxmFSF34wBeEXRRcibYRKo6165zFCx4ikfZp7kaDGPsh21nzgAD3WUyCQ/7fpMB/cOf480Ad9aEqoDoj8Ho5YqEyze5/c2GtLqRi5Hjn06YFSr6/lbIdY5OxJ6dTzmoTQgIfpBVAHQ5nGB1VTAdUwREI/3R+F5iVUm4VMh75Tx+Y5Wa1Thd5KdVw+DGEJ4Qf4lvHbzeLETURCcSHg9J17VPH7DN2+UcaxfXY3j7IF4B1rEJol2RRwqdRAjtA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL0PR12MB4724.namprd12.prod.outlook.com (2603:10b6:208:87::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 15:52:18 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393%3]) with mapi id 15.20.5250.019; Wed, 18 May 2022
 15:52:18 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "james.smart@broadcom.com" <james.smart@broadcom.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V2] nvme: set non-mdts limits in nvme_scan_work
Thread-Topic: [PATCH V2] nvme: set non-mdts limits in nvme_scan_work
Thread-Index: AQHYaoN7Tl8q8c5RCUqcBhcoV4dq/K0kVSwAgABgrACAAAKTgIAAEQ4A
Date: Wed, 18 May 2022 15:52:18 +0000
Message-ID: <0eb017f1-9753-5248-d424-6286e324770f@nvidia.com>
References: <20220518064944.4228-1-kch@nvidia.com>
 <20220518085602.GA8066@lst.de>
 <YoUFurG9sH1Qhfue@kbusch-mbp.dhcp.thefacebook.com>
 <20220518145115.GA486@lst.de>
In-Reply-To: <20220518145115.GA486@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0eefa4c7-4a96-4473-0d72-08da38e66354
x-ms-traffictypediagnostic: BL0PR12MB4724:EE_
x-microsoft-antispam-prvs: <BL0PR12MB47249EC3572CAFDA114C2786A3D19@BL0PR12MB4724.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CSlcESFXQR/3c3t0ZYusJRmR2o11/DVw9UT2l/aWDQkmW9ugtJpo0gIkgEjPrxyMLhwr/VKRFnxHjZl5KuJrD2Ehujx27r0rZpgTxUnXl44BdcvsWNE3lZjkeSR/ychGpxXNGQa/sI5zAdeJxjMMhtqOKbhiH549eO/VAZXDvVJXlv9ERuVkobLKNdj5v/QRL4PCm1E3uWCy/3tzFh3I/oM3ViMRU2GEKL+SI/RUwVPGE8IWbMQ2Zr5G2IHGMyAhzGL0O1sNXKTZfn+ogOr4fCZfliZ6/kRT156FGtjXQ3ny06cE6C/eP57qEm+rCoeUO1mNaQ/fa2TLlCU5lI9mdOZKoUHF/va4wo91fVKLJhZbPbOS+/V3Zwkc5/ZHnwUDWnCLCPpv5uaRCAJVtr5ckKtX5N/ceb4HDkQAK9TwPMA3MCZlbhmFwkPdiqneX6fFTE0BGm9b+BzrHQx3RT2Pt3wGOOOM5gDE8QhsyajwIGzY5WY+femT8S9q9QnuiegPPrqm19ZSGhKYKwwTCK8ySBZzHDZxxd6tkWZRCIhXWPp2viUdaVfBvqpd4GFYc7cXJfN9ND1jwT1LQ41pzr4ViXgVxr0EwWdC3qoyxKbkfuKxHznztln6Q4LsR3dE6QDGAxsY1LzQ3TGOVYBh/jADidiLmwXWMTsI57i9karFHWn+DvR+bmauEXSE3WZWh/c3xfjhAiqNDIpNmhwW5RTIEDVpx9Z3IpD98x3bGMltFd332L092wpwjVPEFEziNQEOgGrTRTXMCFGtR7DT99aJXg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(110136005)(54906003)(6512007)(66946007)(66556008)(53546011)(66476007)(83380400001)(71200400001)(186003)(6506007)(66446008)(31696002)(64756008)(76116006)(8936002)(508600001)(38070700005)(122000001)(31686004)(316002)(36756003)(5660300002)(2616005)(6486002)(91956017)(86362001)(2906002)(4326008)(8676002)(38100700002)(4744005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHl3QlVlUWZZK3pSSmcrOGxVUXZnZENBbFcyS3JyeXcyMlRBS3MxTlJJSnhO?=
 =?utf-8?B?ek1zMXcwMXNWQkdUby9xczlkTCs2WFk2N2FOQVBGZ0JwYzBzeVByQi9ISHFF?=
 =?utf-8?B?b1ovaGVQaVhkUitIUCtKbXB3dWpCYnNTT2JZMFhIN0drMDNORjZqTzVaUm1S?=
 =?utf-8?B?TmQwYlhocXNOanNrKzdYQ2hSYnhjUWYzZkg3SG9NaldqUWZGRVcyRTdnV2dh?=
 =?utf-8?B?bFRuZ1BmWDJwUmFPV3lySE16ZTRTbjFKOElpcXhVSUN2ZDd4Tk5rVFdDU3o5?=
 =?utf-8?B?ZDVRODhPL3VRVGl3Qk9hTlpaaTNlOXVNZTl3c1ZuTEUzdzlKcElKRkdsMi9V?=
 =?utf-8?B?TitMNElzbk5XL2ZEVEpBZFpsZzJIWTBpUXkvUnllYmxXQnh4ZkdUWmtNRjQ2?=
 =?utf-8?B?VEhva3hXMWZOajJWYTNWNkIxQlZKQVJ3WHUwYUFvdzZYdEtCaTZNRFVPa0x5?=
 =?utf-8?B?YU55WklaaHZIaGZ3TStUdUxQNzZ2aWFzTmkxU0xwL3R0R1U5Zm5va2N4ZGUy?=
 =?utf-8?B?QmRxT2dsWXhGTkY2ZXkvZHJINU1HMzhSRjBnNEVHYkNtSTFJU3BEUVFmNHFT?=
 =?utf-8?B?VXJKelU0aThhbVFDcUU5Rk5xK0wrL1dJNkZDK0hwVkcrWUhNaktmZG02NjB0?=
 =?utf-8?B?enEvR0F4ZVlFbG1NTUtHdDVhUEk4MTdaMGxYcDg5ZXg5RmJCdENTR0NEdkdQ?=
 =?utf-8?B?NHFwWWJ0M0NPWjcveUxTLzh4aVZoc083NENzMEpOVEsxVndzcGsrZzUwcVVj?=
 =?utf-8?B?QngwclRBSmtTMWZERDRNNFFPdUVmbDAraTd3dXR4dXBXTHZMMnpaRno4eGJm?=
 =?utf-8?B?VWovR094MXdCOXhuR25zNEFvNjc4WE5qdHFocjIxZFQ0ZVVtNDFORWFvZjF3?=
 =?utf-8?B?Y0haUUpSZTZ1UDNabCsza0JlN1YzR1VSRjcxRmt3azRyK2tZTjZIUGdYQWpI?=
 =?utf-8?B?eEdJL2lva3lQUVhXM1A0SWV5ZEJFUzcvSHptYnJHNWZPcFlac2Q0UFplZnRh?=
 =?utf-8?B?aFMwYVh4aTlHZkUxSHVyRWZZS2ZScFYrMXFWSml3SFNzUFAzVmF5aHVWTnUz?=
 =?utf-8?B?bjgwTGZ3YUlrbFFUeUNCekNkb09Pb0hqdENoTnlYNDhEQVR2UXBJM1lwaHV3?=
 =?utf-8?B?V1lLc29MUHhuZDdoa1NaYVpYZXE0ZGUxcmlqWWpmWFhURldKVlMyNXBRM1kv?=
 =?utf-8?B?OGI3ZmpIdXE3K08xUnRjNmtMV0YvZVcwQ3hnckh2UFB5QWNhMms5Y25hME12?=
 =?utf-8?B?TVRTTWwvUnppUHhaKytCWEdIcWlSdE84dWxnNCs0R1JnTDhTbTQ5K1d5VUVF?=
 =?utf-8?B?Q0s0OUdPTjdyT2hFYjU0cFN0ZlozNmgyRSttb3FLMSs2UHphdUhBeFQ0MmpZ?=
 =?utf-8?B?eStSLy9LQVhMZ2ZYNHFIZlpVeG1JeFptQVcvNnBXQ3piWEtJTUVUeXRKWURH?=
 =?utf-8?B?Q1poNzJCS1c5QThHR3oveVVpUWVjaVFRTVJQQ20zb3crSHpjdDY2NUlHS3d0?=
 =?utf-8?B?eGRiTkk4RjBYdXBGMVlTK2dnaFpyN0F2dkhqZVl2RzJkK2I5eldMODdad1NX?=
 =?utf-8?B?TzNWVEV0dlpqU09RWW5BK29DdHNUVUJkTElrenF3ZG9obEhoQjlDVUVETnFj?=
 =?utf-8?B?STNsQjNFZW9ydVBJeWdiV1RoVUVlaUZaa2EzODBNU0Z6RjM2b09peHFuYWFN?=
 =?utf-8?B?bWY2bjc3QTFQb3FoRzFiR0t4Z29SYTV5WFBzWUlJaWlKSjVWVmJjV25HaFJj?=
 =?utf-8?B?K0p0dGVjNWMxekdTRU80bXp2NlE5ZVdUcVBaaEl2S1g4Z1BXRDFVOXhBTnlq?=
 =?utf-8?B?TXF6SFdKbHB5cE1uYnh3bzhKT0R4bDNjK3pObkYrNTdTUk5rYlZjekdmeUx0?=
 =?utf-8?B?eVN3dnpJZ2N1dWx4NWlMRXVWREd1WEt0bXo4Z3FZeWE0TVY4amkvRllJMEpT?=
 =?utf-8?B?dXpjYmVlQmJhc2Fmc3I1RkNObmpOalcybWF1cEQrdlBYT2orVlpqWG1ROWZm?=
 =?utf-8?B?OCsxVnJDSDBFK1VtV0UzTGt4aTBVOUpFdDRDRUNiTUtIWW1KREQyR2FUczR5?=
 =?utf-8?B?VUVYZGRtM2NRNFRQYU1LT1JNNHk3OHM3R1dlMWg2UEFyK0JTMjlkSVRpL3c0?=
 =?utf-8?B?dnFOK3Jvc0R1RU91Q2tRQnh1cTdkMVpGbGRFL1dELzZWYVZDS0ZLdGtGdFJU?=
 =?utf-8?B?cXpxYmZGQVpvRW1LQWw1MUNMaEJUdllDM0V3eFEyd2hkSnJUOTlFVmtOMXR5?=
 =?utf-8?B?bnpTR2ErVTg2djIyL0dPdmtVeXVUaXJydTBUaGFuckp5Ni9HRWdza2VEVEU5?=
 =?utf-8?B?SW5pMUVZbkp1ZkZoTzFmVU9jdWozMEJLbmhHMFJ1Tk0vUkVhUGJ6QUhHVUt1?=
 =?utf-8?Q?22GA6XlkwqeSsQPQlohSpkbLdLiLC/fjUZtq05YTbXYgg?=
x-ms-exchange-antispam-messagedata-1: vf2PxIqzwCHBig==
Content-Type: text/plain; charset="utf-8"
Content-ID: <902C20464A2E5C46934F8B8C9CC2E48E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eefa4c7-4a96-4473-0d72-08da38e66354
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 15:52:18.6276 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2vwMcsQRcLWf47M+pd26p7LJ6j5EAZ2NScjPNPVvHao+EGnZ6T9wE5q2pi88Svv6RxtbAZ6DXuFM8lHX4KonTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4724
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_085224_353459_ACDAB2F8 
X-CRM114-Status: GOOD (  14.82  )
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

T24gNS8xOC8yMiAwNzo1MSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE9uIFdlZCwgTWF5
IDE4LCAyMDIyIGF0IDA4OjQyOjAyQU0gLTA2MDAsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPj4gT24g
V2VkLCBNYXkgMTgsIDIwMjIgYXQgMTA6NTY6MDJBTSArMDIwMCwgQ2hyaXN0b3BoIEhlbGx3aWcg
d3JvdGU6DQo+Pj4gVGhpcyByZS1yZWFkcyB0aGUgbGltaXRzIGV2ZXJ5dGltZSBhIG5hbWVzcGFj
ZSBpcyBhZGRlZCBvciBkZWxldGVkLA0KPj4+IGlzIHRoYXQgcmVhbGx5IHN1Y2ggYSBnb29kIGlk
ZWE/DQo+Pg0KPj4gVGhlIGxpbWl0cyBhcmUgcmVwb3J0ZWQgaW4gbG9naWNhbCBibG9ja3MsIHdo
aWNoIGlzIGRlcGVuZGVudCBvbiB0aGUgZm9ybWF0cw0KPj4gdGhhdCBhdHRhY2hlZCBuYW1lc3Bh
Y2VzIGhhdmUuDQo+IA0KPiBXZWxsLCB0aGUgSWRlbnRpZnkgY29udHJvbGxlciBsaW1pdHMgYXJl
bid0IHJlYWxseSBzdXBwb3NlZCB0bw0KPiBjaGFuZ2UgcmFuZG9tbHkuICBCdXQgb2ssIG1heWJl
IHRoYXQgaXMgYSByZWFzb24gdG8gZnJlcXVlbnRseQ0KPiByZXNjYW4gZHVlIHdvcmsgYXJvdW5k
IHRoaXMgYnJva2VuIGRlc2lnbi4gIENhbiB3ZSBhZGQgYSBjb21tZW50DQo+IHRvIGV4cGxhaW4g
dGhhdD8NCg0Kc2VudCBvdXQgVjMgd2l0aCBhZGRlZCBjb21tZW50Lg0KDQotY2sNCg0KDQo=

