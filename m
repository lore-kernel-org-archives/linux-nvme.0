Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3420C6FD1D
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 22:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BnSn3XD7ilduU1+KPA+nLIAdZ58mn7Qd5td7Vkd4c+E=; b=rNrboMLEn9qCvYAXFTXpOK/lN1
	XtCqU7YcIFTjuL2Ha/45pxEMtHmsOAQCe4Rg8tDJVekoNmggY6+11TFDQq9DIPoJrRp6DB95du3FX
	YoH9U/RaWtA7UHAElx6i2pfdmY/Q5hEelZqCJB/MxOEo7COTSvyc/eXXgbw0YCVhHTaU5HuJWR/VB
	Q4r0dkZg7WHRdBdZ1ZsozH+ofydvCEsDAtz9eOJMu6RJqmh0/8iL5LRH+gMhS35WSeUB8vXVlTfZe
	/zVTtm6aQ/sRHZrK/TzIxbrvGnQd68afBhvtvom5hVZgYkv/53CMpVCjSj4zydeT3fZ4N1xyj3oYP
	EK3VSmLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcZx7-00Ee9c-1L;
	Wed, 15 Mar 2023 22:50:37 +0000
Received: from mail-mw2nam10on20611.outbound.protection.outlook.com ([2a01:111:f400:7e89::611] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcZx4-00Ee8k-1z
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 22:50:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FopPYNKgLl5eqCUSSKkUAN72Y8oyAO/hjmLA/C+8AbtjdsmSlXX9CPUuj5OwZfH0kWu9DDYSscyuZoUtzwlardYXSfQIdKtKX+ldFSf6XHxem6sOe0jEAmn9h+lp0z8HPz3oLFfWBdUb7r45pS7AhHvMZ1dHl7i+NxMYDCkD5+jyI6dPUxc1P01VVBKXnMAHR7lmzD9DNQJO1ciHZNM++vdjugiyJ9Of0nWto6ftlj+QchuHXykTbWSceCvVjs8SQQEW0oCSrileElalFeOdJjiDe8M4fEOHA1t/8sRpudb1LXMmn0HMXykbalToe+ghGE80sGiWxpsV1NdT+815xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnSn3XD7ilduU1+KPA+nLIAdZ58mn7Qd5td7Vkd4c+E=;
 b=lJry9s5xaYxXUv4xn+A93kvKmWTqyVeNHDq56MR13Rg8HyGRwruthKcCpvDFA607WbgaDf54PYBW9rmrm0RHMuRkLD9swLZ7MNsLkjWFvIyXRUPmaW4Qx6ZQRzKjoaOf1X5NiCzl2dFAkbIiquwbuEFqQr5deg7idQuUIcdbD0pduNiyw+cwrsQEAm1siO7MYAQUdvI9Iftrm7ZeB2925nrMhWATRq8jg0xVAqKW9FT7kF8Bpgzau/BZj22xwGtF7ZCjklEHzpQpgnMcOHBsgUfc9PlijyOOfwE0f/cAFXwlJxNR4ten/pZc3p3YUwjKvcsgfBedDnnEGBvqevvMnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnSn3XD7ilduU1+KPA+nLIAdZ58mn7Qd5td7Vkd4c+E=;
 b=UxoIhHbQAi+O83ziwsE1uoXIxmThQz1CtZHDDJ591/gnKMRii8s6F/XDmg75RVam385UCZrDoyLsFj5FW4LOdbI2+CsJU1/clKreiR3i/1p+MTNdF0CSygaNK1fZYzRsGT6dKoV6Umfxxgc+uyKXelB/04OZwr3+QnVNbJbqJp2HYYRmol7+U9SzOHCsAKsHNUiW7MNgUnGRTBmwlmpdMrHCt0ezch6kp5SJOsqDPWiGUofAy5S6VEjZ4MZ7D3tMxRDOGsJCFgLHQmxsBR5powOYeCNzHDA2s+kefLMFPAptr1FygQjQlgsh8g7DGhcydBzpNBytcDha1ryShWZfkw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4579.namprd12.prod.outlook.com (2603:10b6:5:2ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 22:50:30 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 22:50:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
Subject: Re: [PATCH 0/5] Fix nvme target identify command handling
Thread-Topic: [PATCH 0/5] Fix nvme target identify command handling
Thread-Index: AQHZVy1BbKMPhYEEtkKSl5cjeJZQrK78crsA
Date: Wed, 15 Mar 2023 22:50:30 +0000
Message-ID: <59cb0bc9-71b8-e74a-f0f2-5bc868e78f3f@nvidia.com>
References: <20230315105939.305825-1-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20230315105939.305825-1-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM6PR12MB4579:EE_
x-ms-office365-filtering-correlation-id: a4563a24-189c-4e39-59f3-08db25a7ad91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  GgthiUaj0EC7tffI5aJyx0D/mLRj3ZKArv5yijcOeYIiNlWIvT6MF+ktAjSvSISWP+hMwKCKSUOr21ZwEpHhqkayv74MUHBJ7D7eawUUSpIiKK3Rziblw4HHbMgYqYoqWmwNQRTXYkjTOAKKhaw42vgKYRKfhpr8R0JOLBwPclWMiAdKKtmonoyaSftSzS3ouEJYfAWbmaXaJNggl087RKYTzVMJvapg8Fz1qadad/GHwxGVpKGd7rdFucxFvzpPGeU7ESmqR7PvyoCqlkwEfnrY2YWCiN2Bkf8+N6xH8mCcVlPcwXkrEhn/st8qxRQxwD0h1/u1ib1WVMyEmzZ8hjgQqlWcjkmBrJy3hI1GEjcU0KGcKaev5sapM9rd0B5nixnxQtGgQ7n1DjqfcpV3FXDbcDQcqw0el6SCOkK8xdXlVykds6iPEYQoVa5xem/f+6AlCp6jzYu6qcODbtt89fg4UpPWI0IS7iQxYjqmmtHYir/fT/3ZWQxCENPax15Fk3Ts4SBPrMyQrlM3luYFPXM0OItf2LpeU+wg0xoub7XnWgRuPCa0eS9LDWcp+Fb81H4bI4VotdgGnV3H0SGZwMjY+76x4dvKNzMJp6QmgyTtelbQqGIU7U9mJmnoXMAcnkMvhC82aa/UNsCFJzsihMac2shjpWgmtZUBiilI202uonTBa5qc0rRh7Slf8s6Ff4LhQOZtQt1jJUk0Z9sbK7n7ngK/TogRCTOOFTGX8/UP2BJRTU9hg1HiafONP6pv6qCSV4i0zH8+HwY22JmN/w==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199018)(38100700002)(31696002)(86362001)(38070700005)(122000001)(41300700001)(36756003)(2906002)(8936002)(5660300002)(6506007)(64756008)(66476007)(6512007)(2616005)(186003)(83380400001)(53546011)(110136005)(316002)(66446008)(66556008)(91956017)(66946007)(6486002)(8676002)(71200400001)(76116006)(478600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?V1h1YSs5V3A4aEZxQkx2NmtvSCtacHpaeERLc2VMMExkcjNPUnl6ZTNBRnhF?=
 =?utf-8?B?Z1VhaTBJZWk2WEp1RkgxaStTQTZkWUdPTWVjaGowcCtpSkdxMGp2WEowQ1Yr?=
 =?utf-8?B?ckhDMHJwN1pIR21Pd205TUtSNDhBZFJjNVVkRVJ2VTZsSlFrN1h2ZGhkZk93?=
 =?utf-8?B?SGI4cy96Z01EbjhXQVBnbVhaZkgzNy9hUnEwbjYwOFpqS0dDM290aVRUWEYx?=
 =?utf-8?B?K0lBNlJHV0ZKRHdFVTRVdDVKMTZTWW1oYmFmb3VIQ2I3cTZUemJHSVR1TkNx?=
 =?utf-8?B?WlZkQVVQZmpaS0J0bnRycDlBcUdnK3BOSVB6QWhiMTVPNHhGRldsaUZLUkJO?=
 =?utf-8?B?YitZTUxidXRhL1c4WlB0YXdZVE9pZGdOdlVFR2NPY09CVm1MSjFoc3hiL1hZ?=
 =?utf-8?B?emVyNFIwTDl5eTk0TlNVaUhVb3l3N08wdWh4MHhSaDlaVUtmV0FLbVczMU9v?=
 =?utf-8?B?U0h5UkNST2dVNytTR1F3Y2h2Q2I5bGQzbS9IZ1NFR2Zrc0VPMXFUVStOSXE4?=
 =?utf-8?B?MDlBKzlTNE0wRVl3K2J6R3dPSGJqYnN3bFpFRHVXN2h4SW1qcDBQQzAzVmx4?=
 =?utf-8?B?TS9GQlYrVjJpVXo3YS9GUU52RDF3dUtUYXh4R3h1cFFMOVI1c3ovNS9VYzN3?=
 =?utf-8?B?NWtVQldTbXZnZDh2b3VBOWxXeVdlQ3BNRXRLaCtFeWp0NWJrNkRrQXpnK0hD?=
 =?utf-8?B?TzNTRlFsTVoxTWhxQlU2L0luc0hmVXdmajZzLzFMWVc0ZW5MMis0WUk3WHVo?=
 =?utf-8?B?d2RiMk0xSzZCTUJ1dytUZlFyUGZ1ejFRVjladStRTVgxeGlvQU93cXpQRGpF?=
 =?utf-8?B?OGIrdHJsNFA2c3BkWnlGTmZ4TllvRERGdlR6UlUraFRkb1JHbzVNN25YOFlP?=
 =?utf-8?B?SWg0V3gzbDBZZ2pIcEdvRUVqTzFiWE9LK1d2SHcwTWhHZGVjZHc1YjdzMGhY?=
 =?utf-8?B?SkUzdUg5UXphSEFmWUNvRU1tRkxYK2YwUnpEc3hBaHFrUlR6R0tZTVJzYWxz?=
 =?utf-8?B?R3R0a3JmQVRjTmxOb3N1OXA5a2JXbUErN2NlQjB4NUdCL3djVU5McFJ2bkt6?=
 =?utf-8?B?SmN5TVRPWDRUcE9sSmxkR0tZWmxEcUlmSnBUZWpKVmdzZTZDeVFldllveElR?=
 =?utf-8?B?WVNhTE56bmttRXFLSGlBdEIvSW15VEVreFZlSWlZTEJJbC96TWFZNWl1ckpo?=
 =?utf-8?B?d2dxTGtzd1l2OFA1TUJ5ekNRcXBnR3lpYlFWdzVZVnlOWTdRaEEyTkZOQ0ZW?=
 =?utf-8?B?ZFlSZjRJdHB3STZFQ3c4dXY1U0xvYm5Lc3pnUTlTR0hMaXdxcXJlUTM0OS9D?=
 =?utf-8?B?S2VUL3RzZUdNWlE2ZHFxVit1cjZRZGpZQXk3amdyQjZ0NExyOGdDY29PRnEx?=
 =?utf-8?B?Sjc3cnRiYUdZejUwVFZPdlVqZ25hU3ZRdmFERmlnKzRYQ2F2K0JUUXNneXMy?=
 =?utf-8?B?cW1KcGJsYk41QnNJMWphakpGOEdzMmpaQW9tTjI1NUpsUDZTcFVpRW5qVENq?=
 =?utf-8?B?TXduNi81TVBkNU5ZN04yM3lyOVZZRlQ0c3RDWGVRRjJ0dGxUYksyZnFra0di?=
 =?utf-8?B?YXByc2xNbi8zVXNTTnpLODVrKzh1K3oveHhJYTc1dERLWkV5Zk5OSC9kQ2FY?=
 =?utf-8?B?ZmJudnpHSGhTTU51LzlTbG12eENhZzBqRVNvcVVHOGVFKzFEbWwwV3Q4NVBz?=
 =?utf-8?B?VUdPNTBJYjVQR25yV1VLelFLV3I3MkZZeHJkUzhPT2R6TUI5RGd5bFlxeGp5?=
 =?utf-8?B?bXl2bnJMREZWTU55aDJYazJ2S2owOXBRUkg3anJHdFgzQ3lONlRITkd0OGd4?=
 =?utf-8?B?dFlsbFBqaHNQb0RqdGd5d3lKcW9PVmxYZHJCanJDTDc2OUlVNHhMLzFMUFB0?=
 =?utf-8?B?RmdyZm9sVy8wREZBWFYrdncrQzlqMnBSaENKQWtwek9HbEpFZlgwTVMzVHZ3?=
 =?utf-8?B?dUJ1M01TTnlBREpNSG9xZ3R1VEVZMTU2QzNlUjU5Njh6OEpwUUt1T1BtWmE4?=
 =?utf-8?B?Q2oyUUU3ai9sMW9GUFl3OEUyUGYybzVHeEFyWGZObWoyNTcwZ056dGtIc2JR?=
 =?utf-8?B?dnVYS2N1Tk9DR2x5R1drc1paVC9sWXNqcnRpR1JzaDFyVlp5Ly8veUIrQWts?=
 =?utf-8?B?akFPTnhOdHJSc2ltdHYzZk1YRlUxUjhqK0VZeHRaK25ZRWVDZkE3aFl1S2Nr?=
 =?utf-8?Q?5+syZqxl5SFrbRC0BiX/c3BMbHX+0AanbEdmh08xbPPp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F44C86A96AB7EB4D87C39CBDB5C6481C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4563a24-189c-4e39-59f3-08db25a7ad91
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2023 22:50:30.4182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rmBw8SFZpWTWgwFg/UdiXjJaGxcVsqeLRFjzSjwud5GTByjQw187HXAph7ajQA+RuJ727RlKDpkQI7c1YpEG+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4579
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_155034_684489_B8AFF5AC 
X-CRM114-Status: GOOD (  10.07  )
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

T24gMy8xNS8yMyAwMzo1OSwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IFRoZXNlIHBhdGNoZXMg
Zml4IGNvbXBsaWFuY2Ugb2YgdGhlIHRhcmdldCBpZGVudGlmeSBjb21tYW5kcy4gVGhlIGxhc3QN
Cj4gcGF0Y2ggaXMgb25seSBhIGNsZWFudXAgYW5kIGRvZXMgbm90IGludHJvZHVjZSBhbnkgZnVu
Y3Rpb25hbCBjaGFuZ2UuDQo+DQo+DQoNCkxvb2tzIGdvb2QsIEkndmUgdGVzdGVkIHdpdGggYmxr
dGVzdHMgbnZtZS1sb29wDQpzZWUgWzFdLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGth
cm5pIDxrY2hAbnZpZGlhLmNvbT4NClRlc3RlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hA
bnZpZGlhLmNvbT4NCg0KLWNrDQoNClsxXQ0KYmxrdGVzdHMgKG1hc3RlcikgIyAuL2NoZWNrIG52
bWUNCm52bWUvMDAyIChjcmVhdGUgbWFueSBzdWJzeXN0ZW1zIGFuZCB0ZXN0IGRpc2NvdmVyeSkg
W3Bhc3NlZF0NCiDCoMKgwqAgcnVudGltZcKgIDE5LjUxNHPCoCAuLi7CoCAxOS4wOTNzDQpudm1l
LzAwMyAodGVzdCBpZiB3ZSdyZSBzZW5kaW5nIGtlZXAtYWxpdmVzIHRvIGEgZGlzY292ZXJ5IGNv
bnRyb2xsZXIpIA0KW3Bhc3NlZF0NCiDCoMKgwqAgcnVudGltZcKgIDEwLjA5OHPCoCAuLi7CoCAx
MC4wODdzDQpudm1lLzAwNCAodGVzdCBudm1lIGFuZCBudm1ldCBVVUlEIE5TIGRlc2NyaXB0b3Jz
KSBbcGFzc2VkXQ0KIMKgwqDCoCBydW50aW1lwqAgMS40MzlzwqAgLi4uwqAgMS40NTdzDQpudm1l
LzAwNSAocmVzZXQgbG9jYWwgbG9vcGJhY2sgdGFyZ2V0KSBbcGFzc2VkXQ0KIMKgwqDCoCBydW50
aW1lwqAgMS44MDRzwqAgLi4uwqAgMS44MTJzDQpudm1lLzAwNiAoY3JlYXRlIGFuIE5WTWVPRiB0
YXJnZXQgd2l0aCBhIGJsb2NrIGRldmljZS1iYWNrZWQgbnMpIFtwYXNzZWRdDQogwqDCoMKgIHJ1
bnRpbWXCoCAwLjA2MXPCoCAuLi7CoCAwLjA1OXMNCm52bWUvMDA3IChjcmVhdGUgYW4gTlZNZU9G
IHRhcmdldCB3aXRoIGEgZmlsZS1iYWNrZWQgbnMpIFtwYXNzZWRdDQogwqDCoMKgIHJ1bnRpbWXC
oCAwLjAzMXPCoCAuLi7CoCAwLjAzNHMNCm52bWUvMDA4IChjcmVhdGUgYW4gTlZNZU9GIGhvc3Qg
d2l0aCBhIGJsb2NrIGRldmljZS1iYWNrZWQgbnMpIFtwYXNzZWRdDQogwqDCoMKgIHJ1bnRpbWXC
oCAxLjQ4N3PCoCAuLi7CoCAxLjQ4NXMNCm52bWUvMDA5IChjcmVhdGUgYW4gTlZNZU9GIGhvc3Qg
d2l0aCBhIGZpbGUtYmFja2VkIG5zKSBbcGFzc2VkXQ0KIMKgwqDCoCBydW50aW1lwqAgMS40MzNz
wqAgLi4uwqAgMS40MjFzDQpudm1lLzAxMCAocnVuIGRhdGEgdmVyaWZpY2F0aW9uIGZpbyBqb2Ig
b24gTlZNZU9GIGJsb2NrIGRldmljZS1iYWNrZWQgDQpucykgW3Bhc3NlZF0NCiDCoMKgwqAgcnVu
dGltZcKgIDgyLjQyMXPCoCAuLi7CoCA4Ny4zMzJzDQpudm1lLzAxMSAocnVuIGRhdGEgdmVyaWZp
Y2F0aW9uIGZpbyBqb2Igb24gTlZNZU9GIGZpbGUtYmFja2VkIG5zKSBbcGFzc2VkXQ0KIMKgwqDC
oCBydW50aW1lwqAgODEuMTkxc8KgIC4uLsKgIDgwLjI0M3MNCm52bWUvMDEyIChydW4gbWtmcyBh
bmQgZGF0YSB2ZXJpZmljYXRpb24gZmlvIGpvYiBvbiBOVk1lT0YgYmxvY2sgDQpkZXZpY2UtYmFj
a2VkIG5zKSBbcGFzc2VkXQ0KIMKgwqDCoCBydW50aW1lwqAgNzkuNTMwc8KgIC4uLsKgIDc1Ljg5
NXMNCm52bWUvMDEzIChydW4gbWtmcyBhbmQgZGF0YSB2ZXJpZmljYXRpb24gZmlvIGpvYiBvbiBO
Vk1lT0YgZmlsZS1iYWNrZWQgDQpucykgW3Bhc3NlZF0NCiDCoMKgwqAgcnVudGltZcKgIDc3Ljcx
NHPCoCAuLi7CoCA2OC4yMzhzDQpudm1lLzAxNCAoZmx1c2ggYSBOVk1lT0YgYmxvY2sgZGV2aWNl
LWJhY2tlZCBucykgW3Bhc3NlZF0NCiDCoMKgwqAgcnVudGltZcKgIDQuNDc2c8KgIC4uLsKgIDQu
Mzc2cw0KbnZtZS8wMTUgKHVuaXQgdGVzdCBmb3IgTlZNZSBmbHVzaCBmb3IgZmlsZSBiYWNrZWQg
bnMpIFtwYXNzZWRdDQogwqDCoMKgIHJ1bnRpbWXCoCAzLjczNXPCoCAuLi7CoCAzLjgwN3MNCm52
bWUvMDE2IChjcmVhdGUvZGVsZXRlIG1hbnkgTlZNZU9GIGJsb2NrIGRldmljZS1iYWNrZWQgbnMg
YW5kIHRlc3QgDQpkaXNjb3ZlcnkpIFtwYXNzZWRdDQogwqDCoMKgIHJ1bnRpbWXCoCAxMi43NjVz
wqAgLi4uwqAgMTMuMDY4cw0KbnZtZS8wMTcgKGNyZWF0ZS9kZWxldGUgbWFueSBmaWxlLW5zIGFu
ZCB0ZXN0IGRpc2NvdmVyeSkgW3Bhc3NlZF0NCiDCoMKgwqAgcnVudGltZcKgIDEyLjk2MXPCoCAu
Li7CoCAxMy4xOTRzDQpudm1lLzAxOCAodW5pdCB0ZXN0IE5WTWUtb0Ygb3V0IG9mIHJhbmdlIGFj
Y2VzcyBvbiBhIGZpbGUgYmFja2VuZCkgW3Bhc3NlZF0NCiDCoMKgwqAgcnVudGltZcKgIDEuNDQ4
c8KgIC4uLsKgIDEuNDMxcw0KbnZtZS8wMTkgKHRlc3QgTlZNZSBEU00gRGlzY2FyZCBjb21tYW5k
IG9uIE5WTWVPRiBibG9jay1kZXZpY2UgbnMpIFtwYXNzZWRdDQogwqDCoMKgIHJ1bnRpbWXCoCAx
LjQ3MnPCoCAuLi7CoCAxLjQ2MHMNCm52bWUvMDIwICh0ZXN0IE5WTWUgRFNNIERpc2NhcmQgY29t
bWFuZCBvbiBOVk1lT0YgZmlsZS1iYWNrZWQgbnMpIFtwYXNzZWRdDQogwqDCoMKgIHJ1bnRpbWXC
oCAxLjQyMnPCoCAuLi7CoCAxLjQxMHMNCm52bWUvMDIxICh0ZXN0IE5WTWUgbGlzdCBjb21tYW5k
IG9uIE5WTWVPRiBmaWxlLWJhY2tlZCBucykgW3Bhc3NlZF0NCiDCoMKgwqAgcnVudGltZcKgIDEu
NDMwc8KgIC4uLsKgIDEuNDE5cw0KbnZtZS8wMjIgKHRlc3QgTlZNZSByZXNldCBjb21tYW5kIG9u
IE5WTWVPRiBmaWxlLWJhY2tlZCBucykgW3Bhc3NlZF0NCiDCoMKgwqAgcnVudGltZcKgIDEuNzY0
c8KgIC4uLsKgIDEuNzQ2cw0KbnZtZS8wMjMgKHRlc3QgTlZNZSBzbWFydC1sb2cgY29tbWFuZCBv
biBOVk1lT0YgYmxvY2stZGV2aWNlIG5zKSBbcGFzc2VkXQ0KIMKgwqDCoCBydW50aW1lwqAgMS40
NDlzwqAgLi4uwqAgMS40NTdzDQpudm1lLzAyNCAodGVzdCBOVk1lIHNtYXJ0LWxvZyBjb21tYW5k
IG9uIE5WTWVPRiBmaWxlLWJhY2tlZCBucykgW3Bhc3NlZF0NCiDCoMKgwqAgcnVudGltZcKgIDEu
NDIyc8KgIC4uLsKgIDEuNDIwcw0KbnZtZS8wMjUgKHRlc3QgTlZNZSBlZmZlY3RzLWxvZyBjb21t
YW5kIG9uIE5WTWVPRiBmaWxlLWJhY2tlZCBucykgW3Bhc3NlZF0NCiDCoMKgwqAgcnVudGltZcKg
IDEuNDMxc8KgIC4uLsKgIDEuNDE0cw0KbnZtZS8wMjYgKHRlc3QgTlZNZSBucy1kZXNjcyBjb21t
YW5kIG9uIE5WTWVPRiBmaWxlLWJhY2tlZCBucykgW3Bhc3NlZF0NCiDCoMKgwqAgcnVudGltZcKg
IDEuNDE2c8KgIC4uLsKgIDEuNDE3cw0KbnZtZS8wMjcgKHRlc3QgTlZNZSBucy1yZXNjYW4gY29t
bWFuZCBvbiBOVk1lT0YgZmlsZS1iYWNrZWQgbnMpIFtwYXNzZWRdDQogwqDCoMKgIHJ1bnRpbWXC
oCAxLjQyNnPCoCAuLi7CoCAxLjQ1NnMNCm52bWUvMDI4ICh0ZXN0IE5WTWUgbGlzdC1zdWJzeXMg
Y29tbWFuZCBvbiBOVk1lT0YgZmlsZS1iYWNrZWQgbnMpIFtwYXNzZWRdDQogwqDCoMKgIHJ1bnRp
bWXCoCAxLjQzOHPCoCAuLi7CoCAxLjQyNHMNCm52bWUvMDI5ICh0ZXN0IHVzZXJzcGFjZSBJTyB2
aWEgbnZtZS1jbGkgcmVhZC93cml0ZSBpbnRlcmZhY2UpIFtwYXNzZWRdDQogwqDCoMKgIHJ1bnRp
bWXCoCAxLjU2NHPCoCAuLi7CoCAxLjU1OHMNCm52bWUvMDMwIChlbnN1cmUgdGhlIGRpc2NvdmVy
eSBnZW5lcmF0aW9uIGNvdW50ZXIgaXMgdXBkYXRlZCANCmFwcHJvcHJpYXRlbHkpIFtwYXNzZWRd
DQogwqDCoMKgIHJ1bnRpbWXCoCAwLjIyMXPCoCAuLi7CoCAwLjIwM3MNCm52bWUvMDMxICh0ZXN0
IGRlbGV0aW9uIG9mIE5WTWVPRiBjb250cm9sbGVycyBpbW1lZGlhdGVseSBhZnRlciBzZXR1cCkg
DQpbcGFzc2VkXQ0KIMKgwqDCoCBydW50aW1lwqAgMy45MzlzwqAgLi4uwqAgMy44OTBzDQpudm1l
LzAzOCAodGVzdCBkZWxldGlvbiBvZiBOVk1lT0Ygc3Vic3lzdGVtIHdpdGhvdXQgZW5hYmxpbmcp
IFtwYXNzZWRdDQogwqDCoMKgIHJ1bnRpbWXCoCAwLjAxM3PCoCAuLi7CoCAwLjAxM3MNCm52bWUv
MDQwICh0ZXN0IG52bWUgZmFicmljcyBjb250cm9sbGVyIHJlc2V0L2Rpc2Nvbm5lY3Qgb3BlcmF0
aW9uIGR1cmluZyANCkkvTykgW3Bhc3NlZF0NCiDCoMKgwqAgcnVudGltZcKgIDcuOTg5c8KgIC4u
LsKgIDcuOTYxcw0KbnZtZS8wNDEgKENyZWF0ZSBhdXRoZW50aWNhdGVkIGNvbm5lY3Rpb25zKSBb
cGFzc2VkXQ0KIMKgwqDCoCBydW50aW1lwqAgMC43MzRzwqAgLi4uwqAgMC43MzBzDQpudm1lLzA0
MiAoVGVzdCBkaGNoYXAga2V5IHR5cGVzIGZvciBhdXRoZW50aWNhdGVkIGNvbm5lY3Rpb25zKSBb
cGFzc2VkXQ0KIMKgwqDCoCBydW50aW1lwqAgNC43MjNzwqAgLi4uwqAgNC42OTRzDQpudm1lLzA0
MyAoVGVzdCBoYXNoIGFuZCBESCBncm91cCB2YXJpYXRpb25zIGZvciBhdXRoZW50aWNhdGVkIA0K
Y29ubmVjdGlvbnMpIFtwYXNzZWRdDQogwqDCoMKgIHJ1bnRpbWXCoCA2LjkyMXPCoCAuLi7CoCA2
LjkzN3MNCm52bWUvMDQ0IChUZXN0IGJpLWRpcmVjdGlvbmFsIGF1dGhlbnRpY2F0aW9uKSBbcGFz
c2VkXQ0KIMKgwqDCoCBydW50aW1lwqAgMS43MTBzwqAgLi4uwqAgMS43MDdzDQpudm1lLzA0NSAo
VGVzdCByZS1hdXRoZW50aWNhdGlvbikgW3Bhc3NlZF0NCiDCoMKgwqAgcnVudGltZcKgIDMuOTYz
c8KgIC4uLsKgIDMuOTk3cw0KDQo=

