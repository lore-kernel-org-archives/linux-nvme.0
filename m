Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE836C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 02:16:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96FB861206
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 02:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 96FB861206
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QzL87BBiApLxSZLTef/cEKzH1Wyw90Qwt6oxRccfjr8=; b=zzgtR9e8O0bxMrnwbbLAVEJGPi
	yIYOzZ8LD/NiCPW6iwjV9cjXzsmfKx6TVL3zq0abHh044eNaKxk791Y0g/qKbWmJ5C++BXzfQmnGv
	ZAyOgfjF4keKuCW/awC5z3aXDeGm/l3sLQIqE4usgUrzif6IpKUWPSlEKEZPMt/va7ouEWWyuO5pD
	AnqmFTwQ6r516+qDHfRCYL4ZYrjVrjOT+E+tMhU1G32OENCZFVh3Du/6SE/cOUlh15QZX4uRyFE+S
	8GnQ0McPOCZxhJWQYgldO8IxUz06GA8bTHE+DDMze3UIO9PhmwrwEwsiGXP/p5hYRfgmb+bU2j1SK
	G4PlHU4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnWya-006jlG-Ls; Thu, 18 Nov 2021 02:16:36 +0000
Received: from mail-dm6nam10on2054.outbound.protection.outlook.com
 ([40.107.93.54] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnWyY-006jks-Aa
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 02:16:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZSo0ea6tdNImsR39KNVp1zaauGPvH211RNqVj/vZYlc6k59r+AK8kBZX+GQy5nIppSFuvTgMwyDE0Hs8/+pwE+RMwMrYgnPVS52PPuav0Cbzo78m/2kG/dUT7RXEIlywT/kdvMvVN69Nc3+tTV6e0WYd6MXbifbi9ChzW5faugsEc0REJ5i4i338aV7TNouJ1BN+RQBk37zs9LO1N4wFJ9YeevQI8C1eZyf5yjHrR9KDCXPv7HOqoyo94rQKO3RN2eF6LPjJTHefu1H5a4vgRFmLI1C8sh1G6BQRsDY3SUq3EJhkK8dE0ZyDvqvcu/y5IVzTSckcZ2jxn2CpDO4NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzL87BBiApLxSZLTef/cEKzH1Wyw90Qwt6oxRccfjr8=;
 b=cJVQom3yRLNbQFTUr4562Vw4ETEAb4IEVzm/NY+WsLKD9+B8neDF1fTg522oi9mtCHXEdTt29gBjWalMj+NWtNbmnQB7tMBl5YV/Yvc57sTa9aXK6GpGDvPZ/qOrQhLy31fpAFDfJq9Y97Od0XecgElONWhDo1xU4+raxFuxPtveML8aqs7pFq8jwxSvo7L3vLa6iaFCrrMZUwhO0T/YPKLZXYn+Df6hGRIDJHrIGHkfI1xpQZnPkIJGHikmUv4di8hEylFAEdqk2uyuPncZZ7dNjXvH/HiHA1ztt1u0Wzb/WfB4w2V3/esYt22DCYgqc+sGQuAZvDO8Qg9AtMCvjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzL87BBiApLxSZLTef/cEKzH1Wyw90Qwt6oxRccfjr8=;
 b=l3uf/rcR1qM5ysZY4kjg8vHkeTgO4jEZg84sy3LYTbIfu5uCEXDgNEVdzOxvG1TGtLQKb5YezdXiWhWXP7sq9kNWAjD1Yn5yCHYCkcTi1ZvShVN/qtwqElICLH0h1KONbTrE1hknm4ijvhO5vDHXNu/4OAuh0X80RKRfqb+dxI8uRgLUmjv0kM4RZYS08zW3CErqZUDDdp4TBeOW9K2XOTVS4zACO/dlEOO0gux8NY1Z471/tTPn/suIT9Iw1hPgCGuNd5ADA9hi50c5ez42Kxn/Rki5xNSu8HlGxiAjGQ65slaD+qwcGoCqoQJDBDFfjLF3+WlP2/SZCG+PV4q9VQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Thu, 18 Nov
 2021 02:16:22 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798%4]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 02:16:22 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: Please rebase nvme-5.16
Thread-Topic: Please rebase nvme-5.16
Thread-Index: AQHX1vcLATeOC9yGcEyM7rb3Gzg1m6wIlqEA
Date: Thu, 18 Nov 2021 02:16:22 +0000
Message-ID: <2945e6bf-11e4-938c-9743-ee6690f7f1a2@nvidia.com>
References: <0614137b-7ae3-48b1-d60b-57d1fcdae6ff@suse.de>
In-Reply-To: <0614137b-7ae3-48b1-d60b-57d1fcdae6ff@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8758c87-f05a-4e85-4995-08d9aa396a69
x-ms-traffictypediagnostic: MW3PR12MB4396:
x-microsoft-antispam-prvs: <MW3PR12MB4396137F00B562E69380C0FCA39B9@MW3PR12MB4396.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WoJLE5mGQ/qodvLn09NpTcSbYpuppurNeSt/4GmPDCtbktsGQqeFAe6BmmuiWALvybnCK5Hw6LfGJPwTc+x3uDKffbMte3WgbjAv1EueA1ne3aJJ8EdVAoGDxWU8UNMyurAG/NI0CIBrjSvt8ACHBMQLC3y0XIqh3zpFgHdNTAKhKNJymGsmrx/TfiQ4GMAlb2VbhLbXQozi8cnVYFcI42UhOL8T/UZKiaczp/a6JT+dDtPsL6m6nfmNcXxoG+OYseKuXzOGI1PBSmZzZ2uPjKAYgroTPbESdkYEsQYDDMUl09vq9SVCHJqEGqlOMYcyGZOJnMNO64n8iUnZrj9zTvk9ScG38lFyjTcy4wbfIrTwCHP6UeuhYFmmZ4tc7XUSKTUvFkdDIB2kxEaY1TB+rkxEsesX2BnT1J4JWHaP6D0Jiht46anGVLhsVZ7IOnz5+2pkGEmUlda/UL7zoiT4X9m9oo/iu14tRMJsE78tNvNUm1e+7q47GCXpirmgCZM5h8AK3mxVOr+fS4h+USOIsAiEdrAPUgp/mbgCA0gcyyTjW10GW5XjwGlWjCGPzwOBJuAxtUmgHUDxk3Tc5hAGor7/amST1/PQ/RrTGhIzdpfByxaxRuV1gDZv6ev9g/BAg1RjRjLXr5fhbD1c10YdACqgsZO1VNl4a1WbTECMJHF/DhZ1ywg1BwSM5+tqbq/VozW0KTGKmC0fV0/2frIcbrpXA6H8hMuRwbqlm38cwXIVFnPkbsHFiBlZ2Rh6WGwB54CUIdFq5c/AqsGR3y3uGw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(91956017)(6506007)(53546011)(6486002)(316002)(4744005)(508600001)(2616005)(71200400001)(8936002)(38100700002)(76116006)(5660300002)(66946007)(8676002)(4326008)(64756008)(83380400001)(66446008)(66476007)(66556008)(122000001)(26005)(186003)(2906002)(38070700005)(6916009)(54906003)(31696002)(31686004)(36756003)(86362001)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2duKzRVc1RybjhPRlNGVXRiWk1RRzArSWJBc1FldkFONUxWdnZkSTRvTFM3?=
 =?utf-8?B?L1FNeWJRdmppMkxielhoYmNQWExjQjQ5aWV2czc3NHRReFJtT0ZJMnNYRVJU?=
 =?utf-8?B?TUhERlVIV1NlODJRV01XUTZjQ1R2N0R0aXpvUzV6eWVRTGIwd2UrdTFSZWhQ?=
 =?utf-8?B?WXl2WW1CemJ4eTl4V2NsOUNrU3NZVmZLTDZuV0kzeml0QzJHMk9KeVJ6TDRt?=
 =?utf-8?B?N3YzVHR6MW0xdy9lc2FvU215V0M4TkphVVU3WWtiaHY4RHVFR01pc1NlSkw1?=
 =?utf-8?B?ZGVaTWE4N1hPaUZlczlRTjBLcSttcC9hTmVBVys0WmRHTThKcTBpeGpTQmNH?=
 =?utf-8?B?ZisyT0o1Z2E3K2E2K1NGRFBqRGpIQjk0OXQ2ZEdTamUzZUkybDN0QWt3TDRy?=
 =?utf-8?B?bXpPMVNNUVpxbXFLNFNCTVlGeEMzR3Q1VVQ1aEtmVnBxQnFxTmQvUWZKQTlZ?=
 =?utf-8?B?c0tHREpRS3EvM1J2eGpWQ1JickxhdDMrWVovcWkyekhkK3pPaEFqZ1VlbGtK?=
 =?utf-8?B?RTZmWTdGZk5COGY4blBOeXYvMERXbmxycFZDWmFYblBKR2g3bkFFdnEwd1ZK?=
 =?utf-8?B?UjAxNnZ1N0NaaUN6ZUt4THYxelZqNmZENXJVOWxYSFlwenl1d21nWVBmck1Q?=
 =?utf-8?B?eHNYdGFYZllReCtMUnNaQ0RPZVBIcmNLWWp6NmdiaExOM1BBaWNlaXJtcDdq?=
 =?utf-8?B?R0dwcDZuRzJnclJ6YUhWWjVzNEZJZnJ2N2ZHeHJndFpzRjN1YVIxUWVYVVdL?=
 =?utf-8?B?QjBmeVBFYUxOWXI0WTY4dVBQTjhnYkl4T0szR01KYURNNzlVclNqVWw2dEYy?=
 =?utf-8?B?OXYxWXQyQUR2OFljSEo1cDdnVUFIeGZXZHM4ejBOMzdkWmdiRzluZkF5Q1l0?=
 =?utf-8?B?T3ZmZ0pMUmpDaEw4ZHAzWWwwZXVCWXJ3WHR0RmtsQytxZnc5czdWZU1LR0pT?=
 =?utf-8?B?cHU3QkMyWkx1bXJEVmpnbzd0NGNBaDRWZmdEbU53djNGQWNhcThWQ2lMRnpG?=
 =?utf-8?B?bDBsVXBRcENNUGwvbXN1T0dQZGdjSUk2ZmhsY2F0YWM3cUpPdkZTSWdPSmQ5?=
 =?utf-8?B?azlsckxaNHpLUnBkQ1JtcHN0UG80dlFUczdBZ21JcEQrejJ1aW9tTWV1dVdv?=
 =?utf-8?B?TE55d1RObWVjbzFSUWtFUkdrT3hPMDVXdmZMbDZuYXFzbUxXaEZ6TlJpc3da?=
 =?utf-8?B?ZlJYdnR3TWdHYjJJcVJPMi9hSkJGckg2dkxOYlhSclFxVlBLaG50ejZxNFdt?=
 =?utf-8?B?SDVJc1hKNklIaHBwcElTTEt5RlEwclJxNlBBalhnVTcwam9BbmNDenpULzR4?=
 =?utf-8?B?Y1Q2cHR4Q21sY09kUXdDUkxmVENLUnZraUtEejB6cW5MYkNvb0FxNllSZ1RC?=
 =?utf-8?B?Q1FjM0M2MkpnWTZHQXppbi9ZNFRQcVNseHVSQkVrT2hXbERreXo1VTc4Sm1T?=
 =?utf-8?B?WWJVNGt3QTBLMlFZWVF4ZFIwTkIwZEpuYzkvTnJWVFVxRy9WVUFiaFVMMEpy?=
 =?utf-8?B?eGJvR2F2Q2V2SW9vamZJTkpMTDJETUVzNHdWTHk0NW1Jb1QwU1d6aDkxaFNJ?=
 =?utf-8?B?cnlnTG5KTHVCL0xtTUxCMkRKejVLS1JRUTJlaDZJOW1MWm5ycENtU2xMTGlh?=
 =?utf-8?B?cTlpVm1MRWVLU3pVUG1BanE2dE9KQlo4NlZBWUxqT0h2THh4VG96VU9BQVZD?=
 =?utf-8?B?TlRVNWU5czVsUEVpdXhGSElSZGkySlZnRDhzV0kxa0JoQXZyUjhpdmJBczZh?=
 =?utf-8?B?QlU2UklBS2ticGhMRmIraGxQWFJqcUNhZEtsMXJBZ0ZqS01yV1VHNGV1WS9N?=
 =?utf-8?B?MVl2TXBkanE3cmRUSCtPNm9DbWlmVzUyMlpMdFRKNWwzZjgyOE9lVE5ITDRs?=
 =?utf-8?B?UVN0T0tRb1JQcm5WQWx2SUdIU1QxNXo3ZW4zSHYwVHVaSFU4VW5VNkpFaDRj?=
 =?utf-8?B?cTMrRlgxbi9BeCt0UzE0RHFPRVNQRXhrTGJJREo5RE8vL0tTaUQ2OHNUUEMw?=
 =?utf-8?B?eVhsTmZ3Z1ZDODNRUkQ2Ym9CdlVoTm1vbng5MXU4SjJ5eklDZndLaE53aXNp?=
 =?utf-8?B?Q01VOFNsbFBBd2hYMXpVQlhaV3JGSURhRURBTVNILy9VQ21ZUDVHS0VvNHNo?=
 =?utf-8?B?Tm9MaEZEK2NmMEJuRUVVTTl2NXRUMHZVd1YwbWM2UzhvKzhLKy93NjBDUUQy?=
 =?utf-8?B?Wmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DCA5ABD4DDE66409DD640CF3669A9FB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8758c87-f05a-4e85-4995-08d9aa396a69
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 02:16:22.3959 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mdWCT7O5BvrehRVI92mij5S5izEz9wC6ZC4lpuDDe2eXs+zCW3B3vWbjcyv5Q9Ns3y/37/28RJv2m6wfJC83cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211117_181634_411452_63D9584E 
X-CRM114-Status: GOOD (  10.64  )
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

SGkgQ2hyaXN0b3BoLA0KDQpPbiAxMS8xMS8yMSAwNDoyMiwgSGFubmVzIFJlaW5lY2tlIHdyb3Rl
Og0KPiBIaSBDaHJpc3RvcGgsDQo+IA0KPiB5b3VyICdudm1lLTUuMTYnIGJyYW5jaCBpcyBjYXVz
aW5nIGEgYm9vdCBzdGFsbCB3aXRoIHZhcmlvdXMgc3ltcHRvbXMNCj4gKHN0YWxsaW5nIGluIGJm
cV9wdXRfcXVldWUoKSBvciBibGtfbXFfcHV0X3JlcXVlc3QoKSwgZGVwZW5kaW5nKTsNCj4gdXNp
bmcgSmVucyAnYmxvY2stNS4xNicgYnJhbmNoIGRvZXNuJ3QgZXhpaGliaXQgdGhpcyBpc3N1ZS4N
Cj4gDQo+IEFueSBjaGFuY2Ugb2YgcmViYXNpbmcgb24gdG9wIG9mIGJsb2NrLTUuMTYgdG8gbWFr
ZSBpdCB1c2FibGUgYWdhaW4/DQo+IA0KDQpBbnkgZXRhIG9uIHJlYmFzZSA/DQoNCj4gQ2hlZXJz
LA0KPiANCj4gSGFubmVzDQo+IA0K

