Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218B0EB64D9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jun 2023 21:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fAy4MowT8RNtDikR8QLqmmJctRU2i1cCBne/KRcR5tU=; b=E4hjORaG/OUityFb5vBOPma8DZ
	po+ky+bkoRgN7/qzh3Qkml0yjbwDbwYI7mjSVfigelgdNIXYSQTpMY2Ff4IHqXya4DKEM/Oum/QUa
	3qdJ6ltEfPPKCMiKGqcxb97ZBabO/xkriqnVNDSeZfMkjN4c7Sb8GSx+BstjNciJCgzTxrEG/1TO2
	/XQKczyDIPw+9v/BCPBX9pAekOIzxukRzLX4Qs9i5/rXnlNyBb3AMlO72fGlKY/UgHMNhYBFBNK4D
	IE7SV7/ZiBL3CrICI8u39/kVpKIXIlRO5vI3r7mYaVl3VHpssjxUxxH2qshFVKG/CXIn03no5niMh
	QPNv/bXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEGgr-00EGI7-1e;
	Tue, 27 Jun 2023 21:57:37 +0000
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eae::600] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEGgn-00EGGx-2i
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jun 2023 21:57:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPaKnZUBSNoIv852byhQ1Ia66p7FpRxNvt9EzY+W/LPzkS4fb4opMh2Aysg/JCy62OwxXK4lSs63n40iKgD35NLtm7OvjTkjoHmedtS0dMEQeCAjOFzejgRvVVnlbgP5mCutyolTY0fghuwq7NEXE/SCd1/+ZTUsK13FmPkqK3JEpgGZOd46o4Qv10pwvihe8VQfYrl0ldyoQ/tMXnk/h4XgUSx3+v17iH3HxwRZ+aMc1+uD34FP9zGxIfv+vfWG1QhKSy8+dlauxBzsIAMcbJgQdU5hLZmjWhEvKChGpT+6SgqJ2oo66i7kHtyUL/dLed4bCy0ZLEmJGtwaXMzhJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAy4MowT8RNtDikR8QLqmmJctRU2i1cCBne/KRcR5tU=;
 b=di/7qvdzPXdAjkBbXjCWPmjlc7op4gPp26BDeOQbuZqTk8YnPOiIWkZPxebeN1O/Z8N+0GFEQYTDmMlPgwb9UC8yDH2n7KanSZ5lCcgEu+1T122tnFUHMMrPIwMb+HgJboNC/QGWoys5Z+ESS6Hf/GJHFDLpXLu2k52ecy4B4WFQU6l6jpIgn9HB2JeSrsQJgic9CFCbdKrLbOO9/fpwTZeUgLr9veI9Na/O8YwHwh2Jykmg4yvc9V8JbFW6hSZUxPnZYxd9yWbATiyil3qVAGl6RASReICb5cjsV6WbjIIY/WelTbBJaXZ2Dbepf96eiskDMgCQ91H5GCq0MF6LNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAy4MowT8RNtDikR8QLqmmJctRU2i1cCBne/KRcR5tU=;
 b=GK7iey9AgWSGxYllfLDB64MOr792fLWy2KYk+ryB5Sisg299Gu7YlQkK06vKaEV/PvBHZNHTY0gI9hTMlC9JsCh97gdccw9xqlSDtt2nDUolbsO4NkhoNKHtmdlddNGge+hpbfGNTTTzRte4/cTFCqxXtQHQGwNO8djt1scXgo2wkyxFGh5ABOLLovmLgdDfJ3si3ZnGiySx8c9sX2EUWLAqsyNKPUhaXvk1ganh2bE3l1/MHGwx2Obn+hzf28iV1t7VwG5bSO1zqtUjlznm0gceljIIHnOC1OXn2cGKclkw09LrYDzZ8P2cLji4bZwnzoke5mftg7prB3qLegSjUw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB7235.namprd12.prod.outlook.com (2603:10b6:510:206::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 21:57:23 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 21:57:23 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>
CC: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>, Clemens S. <cspringsguth@gmail.com>, Martin
 Belanger <martin.belanger@dell.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, John Meneghini <jmeneghi@redhat.com>, Hannes
 Reinecke <hare@suse.de>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Linux Regressions
	<regressions@lists.linux.dev>, Linux NVMe <linux-nvme@lists.infradead.org>,
	Pankaj Raghav <p.raghav@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
Thread-Topic: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
Thread-Index: AQHZp8vEXCf0HN4D+UCKyqX/NpmNlK+e1EQAgABg2IA=
Date: Tue, 27 Jun 2023 21:57:23 +0000
Message-ID: <9998fadc-181d-d475-9248-549750bbdf1c@nvidia.com>
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
 <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB7235:EE_
x-ms-office365-filtering-correlation-id: 0d81c4a9-6ec3-4397-34d1-08db77597d11
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U8Aj+gS6gkwRM0Gz3cHityNlCm2q4THIY9EQXFLP9pmrRGNBjyFoGPGovKXVENOkkIhJ+60Hk6JBolE/Dn4QcORB5B3/r/m0WYFVXwTnFNMa/AwuotEl0Opf1LXN4Bfabuo9TgCCKFhc/RB7oIiLZzBMBrlbKdLvr0hufMBk5LBvurDMOT/qndvK/5rs1JlCk5qlxhW4PzDSIB45mXKdjpvtBNH9Ljfal8EEsTJBmnTHcgmQlmHyajKwfhMJk1M8IeV6p5WIw0CCPPTVhqjb2QtpIw8OPpvjT2SvKXbs/UdEZP97/CsG9thmx+16ORDwgwp8EsQwJmaWoV1sMS84gxCPYE6HdxBGWG9b1cgD4CaSg3AgBH5gWGE6iJqbxiUXU4L5xaMAUGt3yRXPHApxiXUjNAr3CNEs5GBBKWse2pYkVGc9QVZmHBoVCcEZMHwLHUm2qy9VmPO2IcPyplYZf4HzaXv/xuZLoxrnitV2w1AcYHTcqjZwjUKRf8Zpf19dW8h1wP/V9O6WBhuIbN4+pbPNL6Vd7/PeY5Q0DoAnj71PpaqhSnJQWWRMY+hoGHEW0HijTveMYxSWPQoxCMLprEPYqeqhv6Z1LqLT/ZD7Ts1mTI5JqFbcqWATIkIYEYBv8abvDInLRWcW8kklqX1qcjt5xsPBSSLHYeeyK+V9REyiNJDlctUdqt5SynHcUAtg0kNLPTirjUFovQijV/zJur/Bvnx2qNPqpfBR4SwlXDc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199021)(5660300002)(7416002)(316002)(64756008)(66556008)(66476007)(66446008)(66946007)(41300700001)(8936002)(8676002)(4744005)(2906002)(66899021)(31686004)(38070700005)(36756003)(38100700002)(122000001)(86362001)(31696002)(6486002)(966005)(71200400001)(186003)(6506007)(53546011)(76116006)(91956017)(4326008)(478600001)(110136005)(6512007)(54906003)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TCs0L0d4a01SZnpjeXFvV2paR2dvQ25EOHU4VmNSTTFKblhJa2hRb0VqdkNo?=
 =?utf-8?B?czFtNUt2d1phbjg5T3FMWmJXcXBLbCtvcUw3YXV4M1JDcXRONUNvNk1WMTc0?=
 =?utf-8?B?OWtINzFyMXd3cnJxVitsT0lPNlhKQWI1N2R1L25HK1hpTzJsVjBNZGpLc2hk?=
 =?utf-8?B?aTVTZmdvZHlHRTJFQ05yd0dmNFJvMTdiTXhGdFNZWUhuY24yOEhacTV0NS9I?=
 =?utf-8?B?V0pOZTluZWRvMDg2N3JURjk0K0pudlgveXVJU1dTU1RaOGljSGhuT0VPTldU?=
 =?utf-8?B?WnJLYUV0ZEl1a1BVMVdlN3hHMU9ySFRhWWxxbWxudWRYQXBTdzJEK0J3SEJr?=
 =?utf-8?B?ME5ZZk53MjNDbHpPd2RRME11NFpKdkptU0dadU9LQ3p0R2o0YW1OeUxiOVU2?=
 =?utf-8?B?TFBQQzMrTFRibGtObmVhSEdnM0lsNFdHN0pSdHljL1RZNTN5VkhnVHo4UnQ5?=
 =?utf-8?B?MCtKNG9PTjkxK2ZCMlhEUGM4S2NDNlF4YmlQR0pVL1B0VHVUUnlxOFdnR00z?=
 =?utf-8?B?K2FiZXhOd2w4WTZqd05vSDZMNDlsSGNEL1NzTmh4b2FXWXIyMHJsdEpINkRF?=
 =?utf-8?B?ZFNoYTQzZDQyd2I1ampEZGQ2d3psRkZtZndnWllhN29hS1pnLzVadFdGTGFE?=
 =?utf-8?B?T29VWHplcG9Yd3M0Yzg1NjdHWnV6QitBVXNPLzJiWDhOVzFkUjVlcEtGNTgz?=
 =?utf-8?B?WjArTTFPbFJCZDk2TU5jb2Y5UCtRV05wcTRVTDVveDZmMWxBcDN0VHlNNis5?=
 =?utf-8?B?WjhGVUcva3BGVENXak5vRWRsMExqcmRHeDdQWURVNlUrSytuWEFwZGVPOGxo?=
 =?utf-8?B?cEJDNXRyeU9SamdnUFEzVUxnZURaMElBaTUwS0dYNVBGU3AyMTZETE8yazkw?=
 =?utf-8?B?SnhZZ3lUQURnM2NBMDdLbVU3dFJ5YmZQa25FNktpbFUvTHVBUStxYVlxWXVt?=
 =?utf-8?B?Z09LblFLbUpXdFVzYlBWTENLUlM5TjhnbXoyVG5YZHlJY0FhTktGUzA0MWUz?=
 =?utf-8?B?SEorSXdkVTVVYk1rL2NlNWtZcUlOdEJPUHZ5SHdRd2xOYmtmdjUzVzVVYzM3?=
 =?utf-8?B?dGhFVnM5dXhzT0JoL0tLbjhxekRHOHovbVlWbzZ4SlMybEp3bmxLM1Avb3hD?=
 =?utf-8?B?NjBNOTUyTTJreWdqUnFkTHArM1hTKzB2YVlJMnI5dDA0WjY5Nks4Y0RGdTB3?=
 =?utf-8?B?eTViaGJlNGZGVmkrWkRjT3NJYjU5cHRIc015dnFqT0FZMDB3dGFwNXFicXEz?=
 =?utf-8?B?ZWFuV0h2cDdDZWp5Mk9aUGFYSloySmYzd1NnbDgwQzU1SEx5cWdzWEswSERP?=
 =?utf-8?B?ZXBYazhFbGgwakFwUzU0QkpuUGZIV0VKTm5ia1JqVVJubisxR3BhUDZZMk55?=
 =?utf-8?B?RHl4NytUN2NoVkVXUUkyanFQdnlyWUdWMVRLWG5pVEswdTJveEdvQnAwRzB1?=
 =?utf-8?B?NEN3cFpvbEY0aExmZTZzdHAxa3EwTEd2YUxYWDhTYzhlSlR1WEZRM1JzTTdv?=
 =?utf-8?B?VGgwdkVFZ094YWhRMjBXdVE2VXNPbElTMTlyM0ZjSDBZelpHQVUrdW9IQWJN?=
 =?utf-8?B?aUx3NVU1VVFXMzc1WDMzV0JVTDBCOWtVMWJaR1NvYXZyZHp0WjQ0R3pISWk0?=
 =?utf-8?B?a251RENYUzJTMUhLS1NnZmRvUU55Z3ZGNW1UT1lNQ3ZBWXY2WmdEQzFLVFJJ?=
 =?utf-8?B?Y3lvcWh2T21adWFtZjlzaTJydExtWnBoSDZpSDZoV2tJdmFPVEU5aWpDMlZW?=
 =?utf-8?B?WTlFYmJId2lvTGVSc2xqZDBLS1h2VWpTZ0xla0ltUVNMNW1PVEx0UFFhbHkv?=
 =?utf-8?B?Yy9OajVZejJXdmJ6L1VLeFMvaVVkSzZ1c0RJZWtNY2tZb0JhcnBEeUtLSWc1?=
 =?utf-8?B?Y05nK2xmMXZta3dKOUpMV2QvczdVOXZvM1B3TjhnNDRobmhoZGRkRXphLzFO?=
 =?utf-8?B?QmtKV0lNSzRPMXBQK2RJVzRFRlE2OWR5WXhlbEhZa0dCZTBDdlVPWTNjcVhW?=
 =?utf-8?B?WmFKSXZUNldpQWEwRi8rUy9OeE5jM3BzdGFvUGtiUTcvRmZWcFdwSEJwdEp2?=
 =?utf-8?B?U3M0R2dPU2Q4NnZZQ2xwUFZUMkt2cEFaTmorUFJQWk9PZ0ZWUUNiZ1Q2bUw1?=
 =?utf-8?B?cFAxWGZKRWg5c3lkQU9EUlozV2FTS2xMbnNLTFBqdUMvb09BVWZBcGY4T1hP?=
 =?utf-8?Q?9/yS2p+RylU2T1xXrK/rs8xIMXwAX63dbJUWCHQ0ZwdC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5D09B90BE15534CAF2C485FBB772099@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d81c4a9-6ec3-4397-34d1-08db77597d11
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 21:57:23.6668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BWo35xvkRLnpqhmyRtNMLzmG9IW24Y87rMOOhCvt+SjJM/ykgs9Hzssw2amXWSVNh6Xl1+yv1hWJY5loFapHBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7235
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_145733_905286_0ADF28F7 
X-CRM114-Status: GOOD (  16.28  )
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

T24gNi8yNy8yMyAwOToxMCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9uIE1vbiwgSnVuIDI2LCAy
MDIzIGF0IDA4OjE1OjQ5QU0gKzA3MDAsIEJhZ2FzIFNhbmpheWEgd3JvdGU6DQo+PiBTZWUgQnVn
emlsbGEgZm9yIHRoZSBmdWxsIHRocmVhZC4NCj4+DQo+PiBUaGUgcmVwb3J0ZXIgaGFkIGEgcXVp
cmsgKHNlZSBhYm92ZSkgdGhhdCBmaXhlZCB0aGlzIHJlZ3Jlc3Npb24sDQo+PiBuZXZlcnRoZWxl
c3MgSSdtIGFkZGluZyBpdCB0byByZWd6Ym90IHRvIG1ha2Ugc3VyZSBpdCBkb2Vzbid0IGZhbGwN
Cj4+IHRocm91Z2ggY3JhY2tzIHVubm90aWNlZDoNCj4+DQo+PiAjcmVnemJvdCBpbnRyb2R1Y2Vk
OiA4NmMyNDU3YThlODExMmYgaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNn
aT9pZD0yMTc1OTMNCj4+ICNyZWd6Ym90IHRpdGxlOiBOVk1FX1FVSVJLX0JPR1VTX05JRCBpcyBu
ZWVkZWQgZm9yIFNBTVNVTkcgTVoxV1Y0ODBIQ0dMLTAwME1WDQo+IFRoZXNlIGJ1ZyByZXBvcnRz
IHJlYWxseSBzaG91bGQgZ28gdG8gdGhlIHZlbmRvcnMgdGhhdCBjcmVhdGVkIHRoZQ0KPiBicm9r
ZW4gZGV2aWNlIHdpdGggbm9uLXVuaXF1ZSAidW5pcXVlIiBmaWVsZHMuIEl0J3MgZWFzeSBlbm91
Z2ggZm9yIG1lDQo+IHRvIHdyaXRlIHRoZSBxdWlyayBwYXRjaCwgYnV0IGl0J3Mgbm90IHRoZSBp
ZGVhbCBzb2x1dGlvbiBhbmQgbWF5IGhhcm0NCj4gZGV2aWNlcy9maXJtd2FyZXMgd2l0aCB0aGUg
c2FtZSBWSUQ6RElEIHRoYXQgZG9uJ3QgaGF2ZSB0aGlzIHByb2JsZW0uDQo+IE5vdCBiZWluZyB0
aGUgdmVuZG9yLCBJJ20gbm90IGluIGEgcG9zdGl0aW9uIHRvIGtub3cgdGhhdCwgc28gQ0MnaW5n
DQo+IHNvbWUgU2Ftc3VuZyBmb2xrcy4NCg0KSXQgaXMgZWFzeSBlbm91Z2ggdG8gc2VuZCBhIHBh
dGNoIGFsc28gYnV0IEkgZG9uJ3QgaGF2ZSB0aGUgZGV2aWNlLi4NCmhvcGVmdWxseSBTYW1zdW5n
IGZvbGtzIGNhbiBoZWxwIHJlc29sdmUgdGhpcyAuLg0KDQotY2sNCg0KDQo=

