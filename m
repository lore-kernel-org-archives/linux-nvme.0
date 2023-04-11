Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF85C7619A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 05:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2T4xtzpACPjp21TTQsstF/2MmVt/no25q03oSDfg11M=; b=DlBcqXVQ883LjNq7cMAbhVbhA6
	WMVDLfcvYEFWjS0W+BWUGA2cVt0sxdYmB2OplLeqaDzjY78rUqG2Aj+nVphLk9He67kq7ou2FPYDi
	0h2/C2tUQQmMk8dEF97zr0HKC4hhAZtxtkSos/xJEG6+NbjPyF5MYaIWBXnO62FYz47JsMpuHGvEo
	HmtNMb2xVJgB7bV2aWYS4AKIdYIUwDTD4ecdHz9Wv4l8s2RJJvrHgwmgljBQo25K7IG/j0zcx+eU6
	9PnVm5s5xc3ROO0MgF/UFlMJVUUalX4YG0mEi3vfnU9dsWI8K8XL7XfEmQuo5T+tfNsBKxoP0ouM5
	/erI/HZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pm6Tg-00GS15-0w;
	Tue, 11 Apr 2023 05:23:36 +0000
Received: from mail-sn1nam02on20624.outbound.protection.outlook.com ([2a01:111:f400:7ea9::624] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pm6Td-00GS0P-2j
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 05:23:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/fGTSybpXElpDhDhfWTsD+aObryx+L8mfHHSQJiAV/p4hv2UXk7CEJFiRiumTJAgJ8qQOyXLuiMHZa/TGMSlrGa9cNTsv3sbUzsJy1Ty3X0iPCDeffzymC/xx7H/eRQU8iJWmupiFmM4Pm4BQuTC32APC43hExdCu2Xoey9ByDd+JlBDiJoKJk4K/3ms13nVpoQyCvPat7e9W1ut0mxka8VJqp71uhp946xtobM0/hBhWrANeBlYF1uNE0Ho2awmFPhbTDCkLKyrSXURSM3mpHVvQ8/ua/lximG9LXwOR0DnoHqHXoOP0qQCq3HNuBukn/A+m0iIUDkTWcJKF7H9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T4xtzpACPjp21TTQsstF/2MmVt/no25q03oSDfg11M=;
 b=Q+P1KYaYGSC0XCLJPPJTeloB+0Ku3cFyE8tmbqRXIPZU8X9FkrilNhB08r4K64R8RULEOJGnbq1ZXpREpj25wzBKzDgIvCSmXpr7ytlq7W5RjSCFCv+LRIYDoQOifTxccvDxtNjZOsRzWuIRq8fi8z4495eg+LP/yJLQ1qFmziPaY5RR219iQheJcxMzLMRBrprD4DqzNeJgoZuwvecj3M/MRkSc2wObo67fVZcADsRAIlqvh1BWIHjDsIE2ym4Y2El+ZBMh9X7CCGUB0YAboY+XMOPm1capE87H+W1YCkk0gvxXt/0a0Z5l5XywM8F9kQYxKA07Irosc08jfc6clg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T4xtzpACPjp21TTQsstF/2MmVt/no25q03oSDfg11M=;
 b=pGehtldPgN5d7EX45gZfrVvGBGsrEqwUNA2SPLjFUpE/E3XKoCHThM5ukIpYdk4n6LSR5mLWfGlnuHuQa57BfWKrrWxYBdF1oN6MMa8zXxs2gocE+HHVOVuQmKUCim/TDLEKv6d6L7TpEGc2numKv+bLtHoppcVqyxpUb+MvSBOuny0JOiioBSOOHmkKMLPgQYAkM6dXVU6uUziUH3hD/PKTJEqqBizc/mWQQGvtJJ9FW4SuYPBVdiJF9Q2lY8l7jis9PB1EP6uCWpwDrduIrp2JqFK7sK5NX0WF63waq7sXQGfz80q2x+mrufnoC7m0+igENpY55o1IiCsj7j+Qow==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB4135.namprd12.prod.outlook.com (2603:10b6:610:7c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Tue, 11 Apr
 2023 05:23:27 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3%4]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 05:23:27 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "alan.adamson@oracle.com" <alan.adamson@oracle.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V5 0/1] nvme: allow passthru cmd error logging
Thread-Topic: [PATCH V5 0/1] nvme: allow passthru cmd error logging
Thread-Index: AQHZaynj0FvmtPMRR0m2hZrgt4zZb68lPEoAgABY3gA=
Date: Tue, 11 Apr 2023 05:23:26 +0000
Message-ID: <8a811508-f53c-bae5-fe32-da65101bdec2@nvidia.com>
References: <20230409212538.18647-1-kch@nvidia.com>
 <0c50fbf6-4bc3-7289-2a39-072191c81dbe@oracle.com>
In-Reply-To: <0c50fbf6-4bc3-7289-2a39-072191c81dbe@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH2PR12MB4135:EE_
x-ms-office365-filtering-correlation-id: 9c88fce5-bd6f-4b1b-20e6-08db3a4ce0e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  fPBb28GU/do/v0t8NLL5yHYrI1SYI41x1ugSiu/BEUNFdIicVvZ3je1S/glhsIXel5vqPW/uYobhDTuqaFtl+twsY1WKcb98kkEI802LujYxrfFjMEbqKd6DMOyMI8mQGXb14sQvWfiSw07C5R0ypahPl6KuQNZALls5HJSmdG/cK6F0WbPyQV2SqaPaEt1JGoKxjqVyY+qolcQLnmEDSc+GAhSgkJ2OmIRJLLx7IsnoeyBCHiQ2BdJ7W/KHaIA5Y1pkvnXwZC+9UuBHVHneULjCQibfGvLGVB+7/5kScI+WLiMFNnb0BkweuCL4eMX50ib/SW4DYqu5TZmp6xEnrDpIWS/6cre5xDHiy/uTr5BeUaWtY9fH0+AccIOJX0ExaCQu5TiJD4kkJgPSpDAR9srder0ujmYnKNIL49prKLXcgMiFOJh2wGcYBE8Pqmso2Fq84ckMgMZHqT4GtsfFwU7BMyGWTYFrdMVXWfGiFdAbKpTzuYk7sl9j1WE5Y6y0bvSJDXDPu2A5wL/11tc2rcyHT8CRcQuXClHXh5DbanOfqZrmlXsM8MOErBEtcXVzUedLyZq25Oripo829yjFEkxm6Dv41y0fuE1U4wnV8ULnS64OCuS2jSqa1Z4BoDXpVT4RB0bdl8F50CluNoyYckheomRfQqIGc4Ic2VDo1F58eZTkTxgI2yjSsAd5NR04
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(366004)(451199021)(8676002)(86362001)(66946007)(2616005)(91956017)(6512007)(478600001)(6486002)(71200400001)(6506007)(316002)(53546011)(186003)(110136005)(2906002)(5660300002)(4744005)(122000001)(31696002)(38100700002)(64756008)(4326008)(66446008)(41300700001)(76116006)(66476007)(66556008)(8936002)(38070700005)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?N29HUUNwL2lmNmpPV2xOVTR2TnI4M1ZiKzZPazQydHZQZm1sait1L2FKbG82?=
 =?utf-8?B?OXF0azJKbEV6WVRkQXAyeEZjUWNkYjJEQ3Z1R3NxRmtWTXQ5ekR6STBmbURz?=
 =?utf-8?B?aWZYQ1lINGtpK0ZuWnozUEdoaXJQekZ3Rk5ReldpL0F1NU85STkwUVFYYVFv?=
 =?utf-8?B?RTcrK1Z0Zm9RTWc0RjNTTHR5aVdHdlR5NC9oSVYxVFlOZ0F3RGdQWk9HOC8v?=
 =?utf-8?B?WXZSUFR2blI4N3VHUE50MjZiVFY5QUcwc0JxRXVUQ3l6RXIyMjg0RFREYjY0?=
 =?utf-8?B?c0ZCM3NVeGpJL25jZElZczJBV0h1RlNxcEVtRTdjSmx2eWNodkxNN0pCcGdq?=
 =?utf-8?B?RUFnbWtubVFyb3E5V3VBRE83OWtwY2RtNGxuZDBMOS9YbHd3Q1NJaW5kLzFj?=
 =?utf-8?B?K1NkNjRhMFVjaEFPRmVZSHdJL0RsTjdYSDZiRHY4UXpOL3g4TjFiWXd0dEp6?=
 =?utf-8?B?UlZldVRSNmFnTml3aHkvRUF4RHZkbHc3RnVpVEZEdXFSNHlpR3JHaXJqOC8r?=
 =?utf-8?B?QUppdmVBY1lyVXI3QlhNRFpIRU5HTGl6OEdSNUEzSm9MTmZrcHFJb1cwMmE3?=
 =?utf-8?B?KzdPVkluOHExOHdIclFSTUhON3lBUHZ0MEpNVHpZU2dsYkJDTmpvYW9SaUQv?=
 =?utf-8?B?ODcxUG1SdVluT0JZNEtCWFRxbE9iU1hmbHluS2EyY0pCVzhSQVY4a01SSXpD?=
 =?utf-8?B?M0IwWk85WGIwdkxmTGZ6Ry83OUR3SndydEpYNG4rNjlaQy9pVlc4a0VHbm9J?=
 =?utf-8?B?TWNVMVZUaFNpY2F5YW5zeHlQbVByWXhEVW5JRGl1bi9tcE56Y0ZTMVRaMFNJ?=
 =?utf-8?B?YWZQd0VOT0dYdTBuOEE0VkI5UEdCemxIbXlXNFBnRTdWRVR4S0QvdkRvNWEv?=
 =?utf-8?B?MXpHc2tSL3QvVThCRVBvRVhlcGppUHpFUm9CZ1BoNWF6amNzVjAyWldCQnFL?=
 =?utf-8?B?U0lSYTZkaFZzL2hxV3BuY1NSb095QVRON1VicEZwaDJ1bGYyZDMxSi9wZnZj?=
 =?utf-8?B?ZEhJTXF0UEFUbGZjZVVZdUt1cXFLeXJyTlRCY0pDcHJLR0gzZkhSQnNiZ0lR?=
 =?utf-8?B?TXR2VStjYXZvVkdVeC9heVYvWmdjRHdVb3J4eUZvelYzbzZHOXNUdEpwaVlv?=
 =?utf-8?B?OFVBKzN4M080RjR3U1dyVHBscEY1eFZYM0VnMUQvd0FodlUvZGU1WTdQSHF5?=
 =?utf-8?B?bFg2Wnk4d0xEMlY4K1NFOTE0R29IbENwUlBLby8zRDNESGFIVE82aVd5N1J1?=
 =?utf-8?B?Smt4NTZmRUdxVWIyNjRwb1FrWFNrSjdXdVM5K0llWFZRazZmRkIvWTY2ZW1B?=
 =?utf-8?B?dUlaT1NJWElIWW0vZGYrYUxmRDNaSmdIWGR6dVkrQ3d6c1RDK3BxdlJWYzAx?=
 =?utf-8?B?V29KcGc5emJ1TVZlcTdLdE5SY0txbFl1MFZyZk5wVThXbTVNWVYxc29LYW93?=
 =?utf-8?B?Qy9kQ09PdW1TbUxmTHZaTElBV2dVclVZRUN5KzNqVXJGVUNIRXpoNytQUGsr?=
 =?utf-8?B?am8wWW1BSnVpZ2R6MWUySG15bnozbGdKY2QzVFlWQVh3angwcGo5OExpRmE3?=
 =?utf-8?B?T3JuZWxhQVNTT3dOWmxQUUtHTjRaK21ndmRPSGhabVNYaEZNZ3Z3MUM4dXhI?=
 =?utf-8?B?c0JhcUtqT0tKRjBuYlhIVFZPNEJCWUJXR2RnQTlha3RiTU5KektTT1ZtbWJj?=
 =?utf-8?B?bjhMSXI3RVpFRUxUdGtPL0hPT1gvbXM3UitraUk4SUlGVmRNNk55RHNNQVhw?=
 =?utf-8?B?T2lMbFhQUHh1UmllM0d6b2VUaW5nNXFIOW8xR0dYdDc4UUVoVFNsTUZJY3I4?=
 =?utf-8?B?UFQyb0pObi9RU1pXQW94RksvMy8xZHVsR0JVYjhCaWVYZ2FuUFQ1UnZCTG94?=
 =?utf-8?B?YzVQaWt2cGNOOHJzaXFFbm9Jc2lGWlZHZ25xSWZtYTl1RllaU2tXRFpSeWhn?=
 =?utf-8?B?bittdWF6alJWSnZKTmQ5d1NoVDRpYndvaDc5ZUltS1RwMFRCV1VLeWJZbFho?=
 =?utf-8?B?cmhqaGFjbmI3NWU2cmJsNUhsZGx4b090Qk5ZRy9CclZPZ29hazIzT1BZMytw?=
 =?utf-8?B?ZHdvbmQxeUk3MFlyNEw1dWtDaUVSOEJwek9xQkxFQVAwN09UbmlCczF2aFdz?=
 =?utf-8?B?QWNPYTJKMTRSR1JXZEUxQmJTemlkSkdPMzRNQmxYSmVTaURhWTFPZFpkMDBL?=
 =?utf-8?Q?3hAeWpI2Lwvodx6F+s0If2O2NHk0A0gHJAq3uIdPbs+Y?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <348EFC52536F8946933B20A4E09535C0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c88fce5-bd6f-4b1b-20e6-08db3a4ce0e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2023 05:23:26.8162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L374R3dBMJW4ul6x/oPj2O5ul1FZpvAtXLFkhD+JERDrwYdXFxx5d7DyfTx5R3A6HQwstDr8uHGH5ms4+1tejA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230410_222334_101577_DFD17BEE 
X-CRM114-Status: GOOD (  14.37  )
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

T24gNC8xMC8yMyAxNzowNSwgYWxhbi5hZGFtc29uQG9yYWNsZS5jb20gd3JvdGU6DQo+DQo+IE9u
IDQvOS8yMyAyOjI1IFBNLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBIaSBBbGFuLA0K
Pj4NCj4+IEkgc3BuZXQgc29tZSB0aW1lIG9uIHRoZSBWNCB0byBmaXggc2V2ZXJhbCBuaXRzIGFu
ZCB0ZXN0aW5nIHdpdGgga2VlcGluZw0KPj4geW91ciBhdXRob3JzaGlwLCBwbGVhc2UgaGF2ZSBh
IGxvb2ssIGZlZWwgZnJlZSB0byBzZW5kIGEgbmV4dCB2ZXJzaW9uDQo+PiBpZiB5b3UgZmluZCBz
b21ldGhpbmcgbm90IHJpZ2h0Lg0KPj4NCj4+IEluIG52bWVfZW5kX3JlcSgpXyB3ZSBvbmx5IGxv
ZyBlcnJvcnMgd2hpY2ggYXJlIGZvciBub24tcGFzc3RocnUNCj4+IGNvbW1hbmRzLiBBZGQgYSBo
ZWxwZXIgZnVuY3Rpb24gbnZtZV9sb2dfZXJyX3Bhc3N0aHJ1KCkgd2hpY2ggYWxsb3dzIHVzDQo+
PiB0byBsb2cgZXJyb3IgZm9yIHBhc3N0aHJ1IGNvbW1hbmRzIGJ5IGRlY29kaW5nIGNkdzEwLWNk
dzE1IHZhbHVlcyBvZg0KPj4gbnZtZSBjb21tYW5kLg0KPg0KPiBDSywNCj4NCj4gVGhhbmtzIGZv
ciBkb2luZyB0aGlzLiBMb29rcyBnb29kLsKgIEkndmUgdGVzdGVkIGl0IGluIG15IGVudmlyb25t
ZW50Lg0KPg0KPiBBbGFuDQo+DQo+DQoNClRoYW5rcyBmb3IgaGF2aW5nIGEgbG9vaywgbGV0J3Mg
d2FpdCBmb3Igb3RoZXJzIHRvIGhhdmUgY29tbWVudHMuDQoNCi1jaw0KDQoNCg==

