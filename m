Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FF2C77B6E
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Apr 2023 21:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c53XNN+L4LHb2UJ6oKikJ0VfwyhfHnP0kcZofHcEqmM=; b=2MeadV+ipAvh7FIhNBCto/ZLQj
	4Wjl3QOMOsibMM5wJbglnmgpVuaX6ceeeDpnyrHURPLdZ7PCerRxLkGKM+ohTU0HpJ+xtZ4iv9tzD
	foElzuUREmccnVEaKoTD+sYxFSafIMYRHayLpVTEDA4WCcRwqa8UJe5R2N1o8YQBRrEuS8E52ALAY
	FVnP5mZ10iWiirHBDex1ssU52N+kSrFKJM6h24Qi1PUlihm1D6jA+VZSPWlDxHqCZLnenTHKJYIbO
	YxhuRQXgJFHRqyRsdXfxtdx1juEJ6aRW9yt6tRI75pCKYvMTDZkYBnd+is4tzyBCIjO2KejJbOtxd
	d3Iaejvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1plce7-00EHoB-1m;
	Sun, 09 Apr 2023 21:32:23 +0000
Received: from mail-bn8nam12on2061a.outbound.protection.outlook.com ([2a01:111:f400:fe5b::61a] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1plce5-00EHnT-2O
	for linux-nvme@lists.infradead.org;
	Sun, 09 Apr 2023 21:32:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsXvsMi4EU0DoZ82yTsg9RChahqgx1e7wfzkrdYL+QRtVIBnzcUJMBiUyBv8T8YMONIQ8q7g+FbPTspd76tOCyY12CDTThJhthDhJyn3PVSbQieDIkNhIjz2NYRguN4krG0O8v/Y4FUxHWthxIZjPQF05QkV4DUX+HtDFUxBBWaUb1BHlTbcKlQqt9enFH1NjvCOVaXRVHZhFvk5sBQFzSQhII6MOKsZNmQjVSTiv+fJW1lKWmha4c8W2x9n7J/CtU/DZ4pQ+qjbiw3+2E2u3jyDKh3F2Po/Aa6RtC+sarSwnrbKeJr2x6xxf9JDK77E/d0K37NE4Xgy/UoH//1cGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c53XNN+L4LHb2UJ6oKikJ0VfwyhfHnP0kcZofHcEqmM=;
 b=jrDezNYcrjxbTjG/lmMoL+05nU+cfq9XTf0hRf0aZr89Uhsd+AZOcdUxFSj7onprAcOL3KOVwb19QN8CHr/EkwrZi+6+Fk6soMyzBWaJs+Vk0fd3z8FwJ/342CclUJWitGP7SyeD9XIN0L5Ye2R1cLtsI3HH8f3s1BqjJdiDaU1wOREYazXRD0XGsVXim+r73mX7SQLxFvtIGzATH2/u3AOpPBtCm23Y4FkEgmWJZQsNjqfMayaWQXXoSBG8RCPF+VMSTbekDnSNxscTSAsrB6syYTXPKCnHvf1nVwq6igNCVZruqx18A/uJxADHGwQamYfF+1qT3BRIvj4mxGULug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c53XNN+L4LHb2UJ6oKikJ0VfwyhfHnP0kcZofHcEqmM=;
 b=O4PYCJZOiTb6lC58xx6Sll7kRLR0JJdhui2jsZ8FObKfOB1JTUCiglHd8b/wPwsegZdVqncVBM+jXJyaJKoh77YYMHzr+Gf67zhB4dC92JUjM3LhfkS/cQsXn8+Jcy27w6MzNt213q6q9hjeT1tLdaH8lO/VeN1OABxtM1RAkSj1uVmD5fiT9MwUO8UfcDXiS6S9Zbjpn8NetOTuFO2iNiwwMVO5PDPcqX1rGVbM8UTzZSl7eUfA8GkakltBckhdQq/Rh7rz6IU28dh4dO9MFylSEXFJhaFC+aM5k2ftGOJxYzP1KXwCw4ipDMgf/mZgm9+j+Lx2LDAgEau0JFy7Bg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Sun, 9 Apr
 2023 21:32:11 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6b01:9498:e881:8fb3%4]) with mapi id 15.20.6277.036; Sun, 9 Apr 2023
 21:32:10 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "hch@lst.de" <hch@lst.de>
CC: Alan Adamson <alan.adamson@oracle.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [RFC v4 1/1] nvme: add passthrough admin error logging opt-in
Thread-Topic: [RFC v4 1/1] nvme: add passthrough admin error logging opt-in
Thread-Index: AQHZaNKx6zIAHFQZF0W8oLoBQ6xu968fRgsAgAAy8QCABAraAA==
Date: Sun, 9 Apr 2023 21:32:10 +0000
Message-ID: <4508951d-9bb9-a25a-c6f1-e5ee91e6ef79@nvidia.com>
References: <20230406215544.113127-1-alan.adamson@oracle.com>
 <20230406215544.113127-2-alan.adamson@oracle.com>
 <4ad89897-f4a7-59a4-e7d0-e0f79f4cb1f6@nvidia.com>
 <20230407074818.GA9335@lst.de>
In-Reply-To: <20230407074818.GA9335@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB7541:EE_
x-ms-office365-filtering-correlation-id: 7c22afeb-44d0-4ad9-417b-08db3941e060
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  +lcdDzyIHpZqvHInxtri5kZ+oRR1hs4dHZoeAMG/C8XRjh2d3xl+AvOzZDQFWv6vPCmLC2/MLK5pRJdYtCGWmexestdaa97LCseVD5VEG3TekQieerV/UuqY4tiCoQat7/Svzd4d72jIVgYW5V62xBj3Ke9FlpeHVDfzIW3AdMcnAAzEHRx/s0nA3hhX3jV+yVTv4lhCT903mhk0kaorjvBxDrSVPwVapVYXUJXwI7bEAS9TiIS4AIXn3z1JUTpQctW9ue1mtgakuLgQ8V7GjxYjadlCD2xbGXYsITeSL8fhEoTsA/0PXwLvSnq14bhXrOzcR6h44vT5jaPwj/mZNU+J/dU3clhzIa7EbJvB35YAP0WHc98g6J0yfF5tW2koea2kH8AOKXkQI0TIBda9Yk5Qhapa7Z9moIZVft9MemRrnCS0lvGnXaGMCiSI1bdfbhn7g3XDOdAzkLXD2aHd7wTTjYZ0Kf2Y7JMfxXi5V8z3GxGq6TkHcf74SSTlpc5u6wH03OND65xqD1AU+e8pGgB5Tlupg+GgMpewtdwD/72hgkppdOp3BXXmIiOSY80i4CU5ilT7w3R8N+3wu/V5z4SPRJksxZoyuU6slFrsrYGIIl74jjrXuXhFNJxNbhppEs5WEg2wyTNl7Vs1A0STOMiMu9YFq6Tc5S/I8DjhpTg6jy3TEoL+uoDgYJt9Kfsl
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199021)(2616005)(36756003)(91956017)(86362001)(186003)(31696002)(122000001)(478600001)(6512007)(6506007)(53546011)(71200400001)(316002)(6486002)(38100700002)(54906003)(38070700005)(66476007)(6916009)(31686004)(5660300002)(64756008)(4326008)(8676002)(4744005)(41300700001)(83380400001)(2906002)(66556008)(66946007)(66446008)(76116006)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?MDhva3JDcHZXV3N5L3U4YWhEd3lacWhsWERJQWIvUjB6dDZpOFpMZWVwczBH?=
 =?utf-8?B?K3ZKVzl1V2k0MDhNa0twYjdoQUZZQVJSeFBmVUg1K0dGay81OFhwV1JnTzBU?=
 =?utf-8?B?eFNteTNQblFwcnRBV2hyQUFqZDdERFJKRzljVHlmZzhBa3V5aG9RQUpRRldE?=
 =?utf-8?B?a3JvRHZwd2JndWFzV0t0UCtrM3IwQTNLSStmbzNTcStvcWlEMHo5VzdHSS9V?=
 =?utf-8?B?VFBSVzhLenkwRmxKVEI1cHdUVHIzOUJQMjhjVm1wSWJzeHg5L1VEandERmMr?=
 =?utf-8?B?ZFlUb0tFNkt2ejZjdlQ1d0l5ZHNPZGJySW5MdHIzVVpoQlBwQ0VJRmxCODI2?=
 =?utf-8?B?SVNKOFJhamlsSnFHN1R3MElOTXN5MmFGU1RiUFJhd3lIS1ZPVllhNTkrYVRC?=
 =?utf-8?B?L3FjZ3B4MUI1bGxHdHJuRGtlM1JTMThHMFNOUTlJVXd3L0kyc1VkTjdwY1BT?=
 =?utf-8?B?TkJHdG9tQmdCMCtzdjlLaTdjZ3RiNGdsT1ZmYnAwR0VOUlZybVdDM0lrUEpS?=
 =?utf-8?B?bkNzVGhzYkJBclNZTUxRSTlnV2duU082ZkZYWGFET1BnQm1xUDl3YVZjZDRz?=
 =?utf-8?B?MTRnRnVoanFxTVdBQ2pMVTZsVGlpTXBQUE9nVDUzRTg5TTgzL0Q4ZzBVZmF4?=
 =?utf-8?B?V0xPN1A0RkROYXJrNUszVHNOd3FUV3VGS2krN3BrbnlYQ3pCREpIV2kzbHVJ?=
 =?utf-8?B?cWh2Mlcvdzk3UEQ4bDc2QVF3aE1FVGVwWlRHbldUUXhQR1I2SDAxRDl5SWZR?=
 =?utf-8?B?ZU94Tk5sd0ZMSlNOWndDTjVPdmdkTXEvcUlGellVSTViRjNrR04zUmpud1Fv?=
 =?utf-8?B?SWUvZ2t3di81NVNKd2x6QkJIRkxOaE9OM0pGRFBJTVV0d284V1c4aHZCZjgv?=
 =?utf-8?B?eHU1VS81TlhrN3ZoUzgxSWdKSk9uT1BaU0tMWkRyS2NFc3JWcjZ5TVF4UUZS?=
 =?utf-8?B?UTRXeHpyZEQyWGlzL2N1MWxzM0dCVjNqK3JTTEVISXFqZDcyNkJGZ3ZrNGxC?=
 =?utf-8?B?WFFYRzc4WUdDWXJBMkZ5WXprb21xOTk0RW45SXZWYVA4RE1xZU9IZ0RSUHRH?=
 =?utf-8?B?RG9qUDNEdFlNYnhpM0MwZ1ptT2kxaW5vMkl3VGV1TlR3bkNOWDQzNlk4MmZm?=
 =?utf-8?B?dnZYR3cwMWNheGRLb0gyTkg2bHJKUzNHYmpHOVVvZUt4aUVoSU5ESTJWS0Qv?=
 =?utf-8?B?OTdUdXF0Smw0bFhQT3AydTcybmlJcm5Bazl3RnVyc1EvK0c0RW9CTndaQ2kr?=
 =?utf-8?B?R3B3dWppNHpWQmo3eTUzMVdQNGVXNlNiNzV1V2c4Ynl3R0lJQ05TTFllRW5G?=
 =?utf-8?B?NlMwRUs2RVRCbDE1M1pLVm1rdDFJaEVaMHhPUjBDZHdpNnVVWXk1Y2ZyemMy?=
 =?utf-8?B?RmloNjFNeEhQRFNCcmxPWUZ2S1pNS1NtS0tkZEZYeW81WFJQZkVlaDhUS0xk?=
 =?utf-8?B?UWVNdVRnYzQ1WU5tUG5ZYURtT3E4VjN6M0VMd3J5elV5K2xvR3NPZ3ZrVlZv?=
 =?utf-8?B?dTRZWEpsbzlBU3VlK29Tb2xQK0lGL1ZUaStOYWNvdlh0VkFHdDUyOXE5MmFB?=
 =?utf-8?B?QmFTbmNzWEJWME5jMktieGFuWVI0L0lES2NhQkdaeXhHMkZ2SHpDZStKM3Mw?=
 =?utf-8?B?ODJOdTd2aWhnc052TlViYkJ0MHdyaEZzdVo3cWtoLzZxbFAvaTFzdjByUkt3?=
 =?utf-8?B?WFhHTFU3RnlldHd5UllBc2F3bUpwcndER2VmV2xaT3dkbHRFUVI5STBDbG4z?=
 =?utf-8?B?UWVQVEh2UjRpYzZYMUZ0ald6VUoxUnhVZXNkaXlqWTFPS1pucHdMdHloRldn?=
 =?utf-8?B?YVhsRVM5TjlaN0FtVFBwVkRTendPNUtSTThHRWRrNTRDcHNLTjlLb0FGN3JU?=
 =?utf-8?B?Mktqc1FVU3AyTGxYbUNVUmh5aWtJQU1YRlp2OGpZNldwcTdiT3lQS0pYZ3dX?=
 =?utf-8?B?RDVXSS9GNEV3OWZVcDlMa1diY1dOUzVDcmcxQm9HRFpvYitDdDBBbldnSHZM?=
 =?utf-8?B?aHNQbDFyZjJjY1pOZlJtall0MTB1YjJPUnppaTZXV0pPV3pmNFhyN2dMK1Vq?=
 =?utf-8?B?c3I0K2FBVmtueERUOXdweXRRWm9KdDdaYW8rajV3Y0trNTN2eGdJMmY0WXBw?=
 =?utf-8?B?RWlCTWdkNG5hZm5IdFJSM0c0M1IyNnNOYzNicUJCR1IreWNCZmk4L3NXbFV5?=
 =?utf-8?Q?s2piSR3m4UgZw5qkJuYRa+MFOI3uVCa2QZg0YlrpONQ0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6E75644382CBC478D63F360D6FD3520@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c22afeb-44d0-4ad9-417b-08db3941e060
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2023 21:32:10.2521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v90wjKWq5/rje2ZOex2qUAKZHzpcXFADRj3NZaejo+yxPb6PzpiXMEwo3Ic8CvBWSln4LEeBNf4Oohjk1Oo/3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230409_143221_801883_50DAB4B0 
X-CRM114-Status: GOOD (  12.78  )
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

T24gNC83LzIzIDAwOjQ4LCBoY2hAbHN0LmRlIHdyb3RlOg0KPiBPbiBGcmksIEFwciAwNywgMjAy
MyBhdCAwNDo0NTo1OUFNICswMDAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiArwqDC
oMKgwqDCoMKgIGNvbnN0IGNoYXIgKmRldmljZV9uYW1lID0gZGV2X25hbWUobnItPmN0cmwtPmRl
dmljZSk7DQo+Pg0KPj4gK8KgwqDCoMKgwqDCoCBpZiAobnMpDQo+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBkZXZpY2VfbmFtZSA9IG5zLT5kaXNrID8gbnMtPmRpc2stPmRpc2tfbmFt
ZSA6ICI/IjsNCj4gSSBkb24ndCBzZWUgaG93IG5zLT5kaXNrIGNvdWxkIGV2ZXIgYmUgTlVMTCBo
ZXJlLiAgU28gdGhpcyBjb3VsZA0KPiBiZSBhIHNpbXBsZQ0KPg0KPiAJbnMgPyBucy0+ZGlzay0+
ZGlzay0+bmFtZSA6IGRldl9uYW1lKG5yLT5jdHJsLT5kZXZpY2UpDQo+DQo+IGluIHRoZSBwYXJh
bWV0ZXIgbGlzdC4gIFdlJ2Qgc3RpbGwgbmVlZCB0byBhbHNvIGNhbGwNCj4gbnZtZV9nZXRfYWRt
aW5fb3Bjb2RlX3N0ciB0byBnZXQgdGhlIGFjdHVhbCBjb21tYW5kIG5hbWUgYXMgd2VsbC4NCj4N
Cg0Kc2VudCBvdXQgYSB0ZXN0ZWQgVjUgd2l0aCBhbGwgdGhlIGZpeGVzIEkgbWVudGlvbmVkIGFu
ZCB5b3VyDQpzdWdnZXN0aW9uLi4uDQoNCi1jaw0KDQoNCg==

