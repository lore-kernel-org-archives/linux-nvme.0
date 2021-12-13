Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E181C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 23:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=25ZY4VADShq6XH/Ks/gbHLzA81F3HaLLWYXYmiT67aY=; b=CSvgOPh02lzx8dODB+xAwp6hyX
	w8osKdBu5etI6icNLppN0TwAVvuiypHx+GdtkEjTPTnWagck89a+bUFYqM5NQH0KjCO+vKV7MNkt4
	4mOlbFn/CNSC55s1p6jU0Vtb40TTK2BuHkYAmhjhbCcPvehUyEaaSnt+s+z12y/BMSykG5RJucAFG
	zObDS98pCiKHe6C59BPnXQpbgRVyfdgJQvBrwLFsZB3hTWxMr/tePjP2bgqSf0wqKF9G+4j4QldN6
	Gvdw0CyNqpmdCsJHoo+4ZHF5Ci7CRnv2opTMLDQGuw+mPJGDHqvJNk2mkxN4S63bom/mqo5x/c+Hm
	qPR7bJxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwuLA-00BuWG-7u; Mon, 13 Dec 2021 23:02:40 +0000
Received: from mail-mw2nam12on2074.outbound.protection.outlook.com
 ([40.107.244.74] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwuKW-00BuNK-9U
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 23:02:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBPXnZGJbAk5qcVxmgmPajAUQOta+Li2SK/kdZIQO2ZaXFhWrfhHYU132NbOcIVOP1a+tZ6RiDA29Hnk9aMm82zQ8CjhAnnYHbD3uXks9HuzTnqFTRRI7D7ZP0PdjRGttBcgTzbrPVTR/jt0Ip2kgJaqldfV55/YDKjq9M/hguo9y5fPW3KJvjze5LQXTD5xdBAgD6ibmbOgrErXf+43hMf5fANglNs2MUJb6wKUpDiHzt8gCFaq+zQr/zQDRSI8N0mdHyoOobfosTXvU7Rx9dWstCYvh5URUT3xKnR+8Md9EslcENiDjSVpNATJMJNhJtbyh6q+C0LRiKrTPtBYDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25ZY4VADShq6XH/Ks/gbHLzA81F3HaLLWYXYmiT67aY=;
 b=GvhikjkPaAIk+qaNBxegPDd4YLGSKYZMpDHOu6PMwbqbavPs1tURH36K/cjQcraf8On8+2bBvGO/GoFBmzkuRuLIaag8yqrG5qu4x4aiIMeB4BePD1pElTpxyla4c2CiUMnHBtuunmxGLBFpGQgRnJtECRzoshwYXf6IT2EJobk4BpBWrDkQg25ep4Ng9XGmMFdhbDc+XhteRbN7vh0+lvlqHmTwphkN8rdkTCYuI6CeA/yHuiDShhbOxdzUO6rqNHSN47gH6/MjVBxytsO0tqhABBMmyXLxDZbbYBiKWJB9bBSbAiFRDuBB6zQfD+QTyOmB6vwgCcAxbpeSIVAgSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25ZY4VADShq6XH/Ks/gbHLzA81F3HaLLWYXYmiT67aY=;
 b=hB6FqHEmRzvwUds2dutti+eM7VmM7ZYJWPWSkZL0a7tJxuy16XOMeJGMj55azfE3Cs5J76yvU34ex1UYQTKfEbmJD9t7gltUgPwLZpXcFHu7qi82HNHLdB1Q+Qq8AidOEbf1wYxvW4RbfBgw/zBkExpIsHsTZxcVm9cG+/uj44hCh9NjvFl2MdKaQkjWkZK+J8uQZSTQ1q+x1let+7VvbDct+z77NnXNbffrzi9icormCvgInYceFiN1zSSaotTgMEIyqds0oF3W4vK1JYgCxB4Ab8tCSZHZYMphEeHrkdit4lYUM8dzh2PBjazIAwC0w2aAkl5XXmJ4SR/3vxui5g==
Received: from DM5PR12MB4663.namprd12.prod.outlook.com (2603:10b6:4:a9::26) by
 DM6PR12MB4894.namprd12.prod.outlook.com (2603:10b6:5:209::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Mon, 13 Dec 2021 23:01:57 +0000
Received: from DM5PR12MB4663.namprd12.prod.outlook.com
 ([fe80::6c76:41c3:39fa:6931]) by DM5PR12MB4663.namprd12.prod.outlook.com
 ([fe80::6c76:41c3:39fa:6931%4]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 23:01:57 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>, Omar
 Sandoval <osandov@fb.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 06/10] nvme/039: create authenticated connections
Thread-Topic: [PATCH 06/10] nvme/039: create authenticated connections
Thread-Index: AQHX4D/0FW4m5OORG0GJLZetJzuU7KwxKk4A
Date: Mon, 13 Dec 2021 23:01:57 +0000
Message-ID: <d3556c79-d105-b4cb-a84d-a1b7aff8c4b0@nvidia.com>
References: <20211123074940.113390-1-hare@suse.de>
 <20211123074940.113390-7-hare@suse.de>
In-Reply-To: <20211123074940.113390-7-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f63f66cb-32a9-4174-8164-08d9be8c901a
x-ms-traffictypediagnostic: DM6PR12MB4894:EE_
x-microsoft-antispam-prvs: <DM6PR12MB489414D7831871CAFB29823AA3749@DM6PR12MB4894.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lhhhn0vOF3c4ViAaTd8zX4NTJxZpaCBMmllv8dRkLOeAtH8YCWgLGMhYIIBlgh6IMhLAF0raVlgfZpk81RKukrG3iF485cVChKm986CwFC7GT7Tj6iJ7fMawoSyPNnU54HmP0Rq2vmc1XRnJv45U0upZIgJHgVH1QCmfMCZIn/SQEwm4OTkn7/ymQDJwhdGoinGB2BAseqGixvmSrKwi0U5vZKwJsqfszB5jKxUyUV/piXuhdYumlmbKnH6FotLZg/lueVPWoGhEhNsJIprFjMLjq2EnZU7O3t2OTk6wvraRn8NDNMLOr7Jwi/0dg8XQR4MBr1c2ZWFPk1o2xBZkNomHB10UlI39NiJUUnx1bgH2XT/4oOyNfKW90Is4SguPGh7NOD8I6aI5jj9SyiTGrlmFJcukofqeDCf5s45vaE8icxhISl4540yyqyRg0LDowS1Ny7qa3oFAmej+6I/3zPc26rEcWDebUu+3fQD+R949Abj8p24WQrUDaCcZgf6+AyjdH4bJxNNj01CJlNWdADh77BG02QljeC7DOlAl0sN50Lff4iBe80CnbAtWVydl89uIL/rxkJYwWlW4miajTtw5rV3KER/GsjntY/xKbOXKMSsBZBU+xTMdJzAThzTzwFHGACn7eZsfqpxDphhBCxhkBYgPuCqCkFRPBdn7rXSXNSdHJLhouDjk3AyjtCuEHirGVXLRZF9z9qn/XDcjxNYHw472ausHs/t5T9JSNTU71GgsQubX3NDvoHgWoo+2OgqAF4afTqsniSA8gVu6qA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4663.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6486002)(38070700005)(66476007)(91956017)(2616005)(2906002)(6506007)(64756008)(4326008)(66556008)(66946007)(38100700002)(83380400001)(76116006)(6512007)(53546011)(5660300002)(66446008)(86362001)(122000001)(8936002)(71200400001)(31686004)(31696002)(508600001)(110136005)(36756003)(186003)(316002)(8676002)(54906003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXlhWmw1WVBqQnRoUUNyQlBYYkphWXd0cmdCOHRlV2tyc3kzR2tBVWNFNVc5?=
 =?utf-8?B?bVlOemdXZHhMbUFzUmRUSHJjc1M2SWZtakpGZG5EckNGY2xnS1kwdjhCL3M3?=
 =?utf-8?B?L0dEZCtjSnNzMFdPMEpVNUt2aWNWQU1EL2plMk5QeW5GV3Jqc1lYSUJiR28w?=
 =?utf-8?B?QzB4QWRoN1RZTVd5UmN1MTBWQ1Y2Z2kxRFlvY3JsTFYwS3lvZHh0clRxdGxU?=
 =?utf-8?B?M1hEY1pZMTRvL08rZkozNUp4eHhoRkVsYTJ5encra3FJU3doaVZOcEFtOG1a?=
 =?utf-8?B?VmNSUHNuZ0d6YWd0eHFsUCtnSkhYaFNVamVrOWFZVnpNYkQ5Rnl2RlYyZGE3?=
 =?utf-8?B?dVVDK1UwcnRQSHF6UzRqK1d4U0JYaTR0VVc3MGg2QUdCY1dqYTZKdHo3aWdL?=
 =?utf-8?B?NktsZ2QyWTljeVFUNTRHd0UvUm1BbHJwUGRCZEphNlh1MkduUDZqdjVoeDJ6?=
 =?utf-8?B?Q0VHTGxQN0txOUJqTVpKK2lkcFIyZUlYV0NFTW1IRmdqdDhmZVliYVhBell0?=
 =?utf-8?B?bkx3QVBub1FpYTcrYWsrUmQ4aVA5Rm1VRm94WEdOYlk0K1FVcWltc21CclFF?=
 =?utf-8?B?dWlmWDM5N3h6VUJYamhEeFlJa2lZZVljaDI5Q0NlNk1JSnZDdUdOcG9Cd1hp?=
 =?utf-8?B?bXAvQnhwSXlJSlhMMmM2R2Z4UVJ5MnFXdFNWT0k5QWUvZkVXMTNoNVRHbWxU?=
 =?utf-8?B?MkhLUnV2a1IyTExmbnl5YTIreGZZOWFnZlNpbU9xT21nd1R1bncxZGNJTW5s?=
 =?utf-8?B?RFZNZnZRbHBFR1J0bHJIdDE5azdrMFp4U1l4K0ZQQXg3ZXdjbEpwQWVlS3cv?=
 =?utf-8?B?RzVLQ0FIZitPempGU0pZZXdHMTNwK2tHQ0ZhRFZsQkErT3lqQjVLQzJPWjB0?=
 =?utf-8?B?RHlzTDdEVUl4VFNrSTl3VW13cnRFbmxvVlhxMFdMWWZGQUVCbFkyeUNQMDZC?=
 =?utf-8?B?bFNpRzAyK0pQVUJDeFArUmZRUTBLenJmTTVxc1o4K2x1c2RjVUpUSWI2V1VU?=
 =?utf-8?B?RXBVb2xySjNiVG5mZWRwc3dEUTZxS25rWDY4Z3lIcFY4WDdVcTU0R1pubmJh?=
 =?utf-8?B?bWFIWjBvZTcwcUlvQ1E4WkZBYTFQazU0U2MyMldwSWVoNDd1eFZPRndGQ09G?=
 =?utf-8?B?REhuTlU1dzNRLy9Ed2tiYklNTTdCdS9vUzZhNThIaDhZNUJkU0tQa2tyNWdV?=
 =?utf-8?B?eDdBZFozcjRYMHFML3pTV29jbWwzRWNVMk1nOFl0WU40WnpTUXNNZk42blBw?=
 =?utf-8?B?UTBlVDZMQXY4SjUzVW93dXhIdmxML2VGekpLdVcvRzJoUmQyendiMW1IRVIx?=
 =?utf-8?B?OFMxNHV2ang0SitocjBVWUdzUVltdVJvZXRiMmZSSEl3TEQ2WEh5eHR3VzZm?=
 =?utf-8?B?U2Rtb0VpV1YzRDlVZ1F0S2cyVFZJQUpVTzdybVhGTkhRMUMyOEppZlJWY2ZW?=
 =?utf-8?B?QlRycGJHaXRKRk53QU9ZaXljVHRML0xlKzV3bnhKK0UwaTU5di9HbEN3Mzhj?=
 =?utf-8?B?Y2MrbGRSUmtvUGtrbEJzWjl3cnFLUCtCNUNnQnRoRjkyajl5dWkrQWp5L0pO?=
 =?utf-8?B?TVhqYy8vUW0rOXByT25YbGVKYXNBSTcyK09sWE1qM0tDRGhFSGpYOXlFanFE?=
 =?utf-8?B?OVQ2cEpuR0phb1B2WFlpRWZwVmUzVDgwL2QzdEVHQkIxT20yeXR0RTVBZGxx?=
 =?utf-8?B?TGRSWTJBZVMvRkFOTG1tTURKSmVyaUY4cDZiSzNETWttS0xsZjh3L3VpUGFD?=
 =?utf-8?B?UnlZa1pySGwrZ3A0Y3I4cU1lVWU4a1R0Vk52QWJmcFlwZ2NtbTZZMmxFWVpw?=
 =?utf-8?B?Sk1FU0hwYThZQ1ViWXh1ZCs3cytuMm9MOWhaZU1YTWFaaCtkR1F1Y2JTSlM0?=
 =?utf-8?B?VENlQjlqTUpnWEM0cC9oc0liZ05JRzRGZ2RCUkp3NGVpeDh5NklnNnpSc3JJ?=
 =?utf-8?B?NkhaRVV6OWt4Tm5iMkFPRCtnQmxWUUlGVE9mcVBTVWpTUUp5YU91TW9nYXpB?=
 =?utf-8?B?WTVHb0RlVENxZ294UFFLM3JYYkRhV29yaUxaWWhsM1JCVlViNy9NdUorZ1FK?=
 =?utf-8?B?b0habHNISTNTb1Z1dmhSSVdQeFIwSkxEUk82UG9Bc3pqNXo1c01uSTJYbll0?=
 =?utf-8?B?WHhNRk9xU1l0cXh4eUZ1YjZkWUh2L0RzcHdYbTVlRkVlYXloaTVwS3lBL1Na?=
 =?utf-8?Q?qBm59EQdndWivGQiSfdW8ney+ktWJNKTfHZeOJYQOMS4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1B2B7EF067428D478302F3F3D92B2D7E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63f66cb-32a9-4174-8164-08d9be8c901a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 23:01:57.1341 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k9AtlEMU46ElKAVVv3RQ9gsM9Azgu+RDupBrardAVVVt8bx4/mn0QSzpiEmR3MYPQz56Yo1ZZ3pifm55smt10w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4894
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_150200_387731_EB93714F 
X-CRM114-Status: GOOD (  16.38  )
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

T24gMTEvMjIvMjEgMTE6NDkgUE0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToNCj4gU2lnbmVkLW9m
Zi1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+IC0tLQ0KPiAgIHRlc3RzL252
bWUvMDM5ICAgICB8IDgzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gICB0ZXN0cy9udm1lLzAzOS5vdXQgfCAgNyArKysrDQo+ICAgMiBmaWxlcyBjaGFu
Z2VkLCA5MCBpbnNlcnRpb25zKCspDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL252bWUv
MDM5DQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RzL252bWUvMDM5Lm91dA0KPiANCj4gZGlm
ZiAtLWdpdCBhL3Rlc3RzL252bWUvMDM5IGIvdGVzdHMvbnZtZS8wMzkNCj4gbmV3IGZpbGUgbW9k
ZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMC4uNGZiZTdkZQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsr
KyBiL3Rlc3RzL252bWUvMDM5DQo+IEBAIC0wLDAgKzEsODMgQEANCj4gKyMhL2Jpbi9iYXNoDQo+
ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMy4wKw0KPiArIyBDb3B5cmlnaHQgKEMp
IDIwMjEgSGFubmVzIFJlaW5lY2tlLCBTVVNFIExhYnMNCj4gKyMNCj4gKyMgQ3JlYXRlIGF1dGhl
bnRpY2F0ZWQgY29ubmVjdGlvbnMNCj4gKw0KPiArLiB0ZXN0cy9udm1lL3JjDQo+ICsNCj4gK0RF
U0NSSVBUSU9OPSJDcmVhdGUgYXV0aGVudGljYXRlZCBjb25uZWN0aW9ucyINCj4gK1FVSUNLPTEN
Cj4gKw0KPiArcmVxdWlyZXMoKSB7DQo+ICsJX252bWVfcmVxdWlyZXMNCj4gKwlfaGF2ZV9tb2R1
bGVzIGxvb3ANCj4gKwlfcmVxdWlyZV9udm1lX3RydHlwZV9pc19mYWJyaWNzDQo+ICsJX3JlcXVp
cmVfbnZtZV9jbGlfYXV0aA0KPiArfQ0KPiArDQo+ICsNCj4gK3Rlc3QoKSB7DQo+ICsJbG9jYWwg
cG9ydA0KPiArCWxvY2FsIHN1YnN5cz0iYmxrdGVzdHMtc3Vic3lzdGVtLTEiDQo+ICsJbG9jYWwg
aG9zdGlkPSIkKHV1aWRnZW4pIg0KPiArCWxvY2FsIGhvc3RucW49Im5xbi4yMDE0LTA4Lm9yZy5u
dm1leHByZXNzOnV1aWQ6JHtob3N0aWR9Ig0KPiArCWxvY2FsIHNjcmF0Y2g9Ii90bXAvYmxrdGVz
dC1uczEuaW1nIg0KPiArCWxvY2FsIGhvc3RrZXkNCj4gKwlsb2NhbCBjdHJsZGV2DQo+ICsNCj4g
KwllY2hvICJSdW5uaW5nICR7VEVTVF9OQU1FfSINCj4gKw0KPiArCWhvc3RrZXk9IiQobnZtZSBn
ZW4tZGhjaGFwLWtleSAtbiAke3N1YnN5c30gMj4gL2Rldi9udWxsKSINCj4gKwlpZiBbICQ/IC1u
ZSAwIF0gOyB0aGVuDQo+ICsJCWVjaG8gIm52bWUgZ2VuLWRoY2hhcC1rZXkgY29tbWFuZCBtaXNz
aW5nIg0KPiArCQlyZXR1cm4gMQ0KPiArCWZpDQo+ICsNCj4gKwlfc2V0dXBfbnZtZXQNCj4gKw0K
PiArCXRydW5jYXRlIC1zIDUxMk0gIiR7c2NyYXRjaH0iDQo+ICsNCj4gKwlwb3J0PSIkKF9jcmVh
dGVfbnZtZXRfcG9ydCAiJHtudm1lX3RydHlwZX0iKSINCj4gKw0KPiArCV9jcmVhdGVfbnZtZXRf
c3Vic3lzdGVtICIke3N1YnN5c30iICIke3NjcmF0Y2h9Ig0KPiArCV9hZGRfbnZtZXRfc3Vic3lz
X3RvX3BvcnQgIiR7cG9ydH0iICIke3N1YnN5c30iDQo+ICsJX2NyZWF0ZV9udm1ldF9ob3N0ICIk
e3N1YnN5c30iICIke2hvc3RucW59IiAiJHtob3N0a2V5fSINCj4gKw0KDQpTdGFydGluZyBmcm9t
IF9zZXR1cF9udm1ldCgpIHRvIF9jcmVhdGVfbnZtZXRfaG9zdCgpIHNlZW1zIHRvIGJlIA0KZHVw
bGljYXRlZCBpbiBtb3N0IG9mIHRoZSBjYXNlcyAoMzkvNDAvNDEvNDIvNDMpLg0KDQpMZXQncyBh
dm9pZCB0aGUgY29kZSBkdXBsaWNhdGlvbiBieSBjcmVhdGluZyBhIGhlbHBlciBpbiBudm1lL3Jj
ID8NCg0K

