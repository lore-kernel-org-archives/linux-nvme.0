Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE2DEB64D7
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jun 2023 15:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d20Rtd4mV4IYDhmxPoVg5yOPxH7R+wDGogjE7InLXr4=; b=PtKYiMjtaMxyIrpqYP7R+9hffp
	BGcBprptdm8D3NqUeyLt5Y4NjP4X3cty1orJ4JnGLqAMOHX+3jU5w440j6CvcjT49gtRP02tkoe1b
	PvqJPpePBL/5Xe2L+0WZtI5d9zE2VdLRV94mL0gLFzXJZsFlR3IBnGHfr8JjaNQrIsF2o7KU//nVm
	VExAKL5yZYdprwVGfPz1HDl3MVuO7pLI3FOkKbJbBamt55UkRNmtFPHZYWviWtxUkpUf6ynP0F3hi
	PmuG5sVrHWyHlySfUK1XTSeuTcWqEMucwdwgzZHt+XVEOw4PVkL4WAZsum6VEybklRw82KG5SYV3Q
	F3zmDPVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qDoJY-00AWZJ-2w;
	Mon, 26 Jun 2023 15:39:40 +0000
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com ([2a01:111:f400:7eae::601] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qDoJV-00AWYK-2y
	for linux-nvme@lists.infradead.org;
	Mon, 26 Jun 2023 15:39:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6XwKXwc+lIdz7dH/ali+tSKIU9Osgnz0QetL/nE9/gdAToJldkCV6O+OTfprUNLu4AqaAwrwpMq5ZYW8hmBN2f+WsI8XlL/M9LZTWN2hTeVyJWwGKwqEwWgD4ZQyMZCDWGrpe/EKbT6a+fGGyIkVCzm5/sN1gIjvyTIB0Vh5gZzDL7JcR0KrVhOWWdC1LZANhMb5cX5Mj472c3vBzRzAF41K85Dr5b/2LV4qjvX88KOK3vyHxDWwbKPYbeZ+TuE1Vpb2e17S95HSdl6xION87IAPTULmcE5/VApH7lw4XQ0Xz7Ex0MIhuVux4T0VbDvWldlKfskTY0Ykf9nT5N4Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d20Rtd4mV4IYDhmxPoVg5yOPxH7R+wDGogjE7InLXr4=;
 b=PG934PoXGqDWTkiC2jiyTEXnqE2nzKbbSmYvojm3cRU74uc431I15J7UzGz8Bt541CSAJ1U+8VeRCPZYf1PWHo0Ohd36D+RE4wg68YOE1/ugwvI1RZWH6feVqYyltNL1Y+Gq2kYan7RFXjbDr9LCYTnnWnhocS6FhR6LoZU3RSzpeX/7OQ/1sNWg17iTcJRdrOSEZffXffjLOHkEncFkARgREVXOHXKYmwAq0J6vm7gCFbyks131L3pCKU/Xp/nRuOaSswoNkJ64VHJ9DPgl5YTT5nNBk/86qa6Vj9Sk8l0X0Yz+ZshsrZx74tDsw0HFnQjRrA5+C/0/0u3VIGvY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d20Rtd4mV4IYDhmxPoVg5yOPxH7R+wDGogjE7InLXr4=;
 b=EqTtjVGg6fp8hx79tP+7HVcPT9pPfj17qcwdDVmnYAJBxfVOfB7wmKYyYU9s0VKJQ48dIJUTqlc81Ij1Pa3uU4WwLgYMFgUnzqBFLnfKUZFLDnmlETrHoF6NoZEhBSJjKFOm5LsE/F8EPRf9842xt+7TD0jtzCEf1+HXhBVSEk8DzZktaaIF+OTBLwsJ/XrU+1J4Wj5cjCmglbhfD8oDJ6uXPpTo0B5kxH/kuMn2Lf1QZ5N0oxvIO8cihk3sKy2/QbDJ5EcmafzrBu2JtjMz1lAQ/gcCisJmP/IlMRpUoXyiV7j3ZiDPbrdfZ92MOqR3lu1zThpJXRsu0Xiz0v40Yg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 15:39:31 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 15:39:31 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Clemens S. <cspringsguth@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux
 Regressions <regressions@lists.linux.dev>, Linux NVMe
	<linux-nvme@lists.infradead.org>, John Meneghini <jmeneghi@redhat.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Hannes
 Reinecke <hare@suse.de>, Martin Belanger <martin.belanger@dell.com>
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
Thread-Topic: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
Thread-Index: AQHZp8vEXCf0HN4D+UCKyqX/NpmNlK+dOTYA
Date: Mon, 26 Jun 2023 15:39:30 +0000
Message-ID: <8f4e6d32-55b3-9df5-de91-1afbcb30ce13@nvidia.com>
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
In-Reply-To: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB6111:EE_
x-ms-office365-filtering-correlation-id: 5df7761f-64d4-4de3-76c7-08db765b88a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vG1ehDKGLqG3DZk6raIAnASoA/SCMux0J+kb6FSrS6coNEfAbQ50ZmjHM/W89rdpD0BTW/JGtS+VxDlfJmitqiIDeqOMLuOdhUHKuHZDZYfsfWm9eCcyVErY+hwWCEs3txY8aDGQAqUyhGC/24xDLfO6UsZHMW6aVovXJhV9HzZ+SaLC0wL0hjZcMe30mEkOJaciu6tb2hCaENaANaK2wMv+J4Ll9XZuoszAG9Q3usGk+Cyi6ICoqAh0Kf9pYGC3YexlgOAUOqiKTtzRGRFbcZCUcH++WQZHTAIWLU3sXJt+2/MmYyn+0wupJD6icEHRKnD7cUdvsOKWTCBHT+acLLenH+gAv8CQRaoOC1guCNWcydygVy67cH4O5bOj/ZcyGarALC41Sg7UYONMIg4ePGVCZn/EogjvIYjfErqyrob6B77Oh1yF8sPsBzTAgmotY/ze+xMI0frYmlv7UnBdQFrPrhelIr7Z6jenlcXB4O8k4bCUpZsFmwO9LAFXe9ss2w+j8BkplmcylM6WfqwjGvHsNY3YFiMYqtbm1NC9KuqDuwF+psXb3pERYMuua16acfisC0Pra5Fw5p2Vtrn5NGIVhp646knFEvcV6YH3VgzqWPFa8z2CtBIPxe/SuNc2nD4WXC94ruNXO6+5X7e/otvfL9qZda6lgM3L8uL5hHdrJb02Hw2RL9kOdD0DSzpjx+8N8uEycgqUunm8PNB8KbuwtZzl/m67Es91+lQEPxg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(6512007)(31686004)(36756003)(5660300002)(7416002)(86362001)(8936002)(8676002)(41300700001)(64756008)(66556008)(66476007)(38070700005)(76116006)(91956017)(4326008)(38100700002)(122000001)(316002)(31696002)(66946007)(6506007)(53546011)(26005)(186003)(66446008)(2906002)(4744005)(71200400001)(2616005)(478600001)(45080400002)(6486002)(54906003)(110136005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWtUaVB3S1luVHdkWUFVazc0UlVkV29oUnJrd0NsdWpZZ2tYSzdCTWNMWG1u?=
 =?utf-8?B?VW90K1JyS0djRGVpUnZmRlA0ZTNxcTZ5U3Rra0hvL2hWaElqZXdEZnlaTUtI?=
 =?utf-8?B?VVlieFVTOTdkUVBHSTdJa3JoekhiQlUybHBKWlFZWkxqN1ZNdUJIODJpaVd1?=
 =?utf-8?B?T2VJd1pPYi96SXo2cUhOeE9vUVhQaVA2NEtXNDRLUlJPNVpOdHhYaDVvdFJm?=
 =?utf-8?B?VklHa2ZUbDlIVlZlNUtEd05JbWM0VzU5YXZFR0IxandkWm1Fd1I0WXA5elVq?=
 =?utf-8?B?VFJESDNsc0ZMN003T2xSUTUzejdxWjJ3NE9UYUVoY29ZMEljUkwrWmp3OGxr?=
 =?utf-8?B?dnViUGwwZUxOVHNLdTVDalJQVFRMUnUzZGhNY3VuNkplcnR1T2NxNC9ZTU5n?=
 =?utf-8?B?Nkk1UG5idFRmWkx5Q2NBaDFnM1hCSGdqeWVVR1AzditFTzkwaWxKU2FqYXVx?=
 =?utf-8?B?a3E3dVpWemxDQ1pvdi9NRjFTZDc1dVo2a084R0k5Z1AyK2VtaldicGtlWk9Q?=
 =?utf-8?B?RHZka3h2cDZYYTNYTnRQL2NML2FXV3dJWjZxU3dyNlZRV0hiaHlxNS96ejM2?=
 =?utf-8?B?UGJpNkgwUW90MVZtdUU4QXJzenk5TW83VGpLVzJ3ZTNmZmVwbDZMU0twNlBZ?=
 =?utf-8?B?dDI1cTk0RTVjZERIdDEvSVlxTHJSYzdPS1QwRTBvOGpheTgyaWNhU3pyZ01B?=
 =?utf-8?B?eDB0U091aVViZURFdU52MjV2cjR4bncrWlVmL1hpTlZINmRWUkFRbEpLT0Vx?=
 =?utf-8?B?WUdpRTR3RUZQZ05Ic1g4ZzFuY2I3eFhIY1doN0dWM0dkMUNJZHdSNEtWVFdp?=
 =?utf-8?B?dXg2WFNwU3c0N1NVMkhmYWprTDdSUjVJOElYckc1U1FGZVl1UnZibkxVbjlu?=
 =?utf-8?B?MWpqQWNvOVJEN3hULzZ2bXF1Ung0a1Q0OWd0eDQ3TWl2a2loUTIzZEp2OFAz?=
 =?utf-8?B?TVptMGQ1bmRrSGhrMFhndk45cElLSTNOZWhHNlBWVjdFQ1haeE9VdW1CWm9h?=
 =?utf-8?B?U1JpQXF0YU54cmI5VnZaMk9LNmpmOCs5WllrNWFiSU9RaGhqVngybXFIVmpJ?=
 =?utf-8?B?LzNRU1M5YllnUmltOHJrZk80UndoTGc4NkJHeElBSkN0Z05VazEvaHVNWms0?=
 =?utf-8?B?ZjU2aVBHRGxCWmNmN0RGK1pnZVJUQ3FqbFk2czF4cmd2WG1xNkZNZEs1SEFZ?=
 =?utf-8?B?QmkxZVRnbzVPSmxnVVFuZVZ2TGJuRWxhbTdUeTg5SnVGckhuV2toYzNFUzBH?=
 =?utf-8?B?bEZaaS9CdXlPeHJxbDg0N3haSVcrM1RsK05BSTJ2S0JsSkhWckdEc1ozY0pv?=
 =?utf-8?B?ZFFkbWx1TEx3TDdsZXoza2QyVjN5YnhKSmFHYjgxL0lPTGZCQlhJbDBlVG9J?=
 =?utf-8?B?YmdGY3h4TVZpbmhobDhYUThMR0ZEcStaTmRhakhET2ZEWkt5am00Mm84VTlL?=
 =?utf-8?B?S2RlNm1vMEd1U3lueFI5U3NOQmw5UTNzU3N5bHg5Q2FTWXVXVnI0Z1ordkVE?=
 =?utf-8?B?NkVCWDNieWd3ZlhRY2ZNS1gwdVVDdWd3L0M4eXdTenFSM25EWDh2OEtoQjJu?=
 =?utf-8?B?dTR0OXR5U1dMSzM3N1dQWkg3WldUTUo2Y0htelo0UG9rSk52NHBPT2RLZzYr?=
 =?utf-8?B?cnJVSE1OVlBFMzBYTUJxY3lzNkExdWFLakNTVEd2YitGR0ZzN2lTVkp5VFVK?=
 =?utf-8?B?RUREN1JVc1Q4b0hzR1FPejRjOEJoN3NwcEVhVytxbXNORDVsQ3pFMDg5bGps?=
 =?utf-8?B?Zk1RT295aE5ySlNGZWJ3bEVVMTMrd2l5Ni8vaGJNVW1xSWI1SFF1ZmgxOEp2?=
 =?utf-8?B?THl2TnhWOXdkbDIxT21CcEJqMWx5dnFKN0djY3ZMZUpxMXlBcVFyNnVzS3Bl?=
 =?utf-8?B?d09FUDNqSWZwbGgwdDVMUlMvRldjV05ZYm1PaWxOejBsUTMwYzBnb0ZDZXl1?=
 =?utf-8?B?MElpZDd5TUlFODRpNGpFOUg3eStHNG1VR1dRaVNsVEpkSW4xWkRCVEV4cnN4?=
 =?utf-8?B?eEhrK0o3TjZsWERndkU2WDF4NGRKMGF5amlDU3hwb3lpdVNUMXJTUDZkQ0RF?=
 =?utf-8?B?M3N5TWlRUlkrSFE3V2FRTStSVXF1OUdGdFRQSW5OeWhaM1NvbXB5OW1uWndx?=
 =?utf-8?Q?faTlpNddUjLEWQshn94hbxIA0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A6520D008628743BC41E28F2327FD96@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df7761f-64d4-4de3-76c7-08db765b88a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 15:39:30.9201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lc0a/+whK7dKB46As2fcqwnEULf6heMCtXLxhFlldkz3OG90pzGfdjCqqCEFOgRtoOcg3Ns4kWe2OrzqFHEZ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230626_083938_021861_1F708873 
X-CRM114-Status: GOOD (  10.03  )
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

T24gNi8yNS8yMDIzIDY6MTUgUE0sIEJhZ2FzIFNhbmpheWEgd3JvdGU6DQo+IEhpLA0KPiANCj4g
SSBub3RpY2UgYSByZWdyZXNzaW9uIHJlcG9ydCBvbiBCdWd6aWxsYSBbMV0uIFF1b3RpbmcgZnJv
bSBpdDoNCg0KWy4uLl0NCg0KPj4gT25seSBvbmUgZHJpdmUsIG91dCBvZiA2IGlzIHVzYWJsZS4N
Cj4+DQo+PiBUaGVzZSBkcml2ZXMgYXJlIHJhdGhlciBjb21tb24gZGF0YWNlbnRlciBkcml2ZXMg
KFNhbXN1bmcgU00tOTUzKS4NCj4+DQo+PiAgRnJvbSBhbm90aGVyIEJ1Zy1SZXBvcnQgKGh0dHBz
Oi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjE3Mzg0KToNCj4+DQo+PiBU
byBmaXggaXQsIHBsZWFzZSBhZGQgdHdvIHN0cmluZ3MgaW4gcGNpLmMNCj4+DQo+PiB7IFBDSV9E
RVZJQ0UoMHgxNDRkLCAweGE4MDIpLCAvKiBTQU1TVU5HIE1aMVdWNDgwSENHTC0wMDBNViAgKi8N
Cj4+IC5kcml2ZXJfZGF0YSA9IE5WTUVfUVVJUktfQk9HVVNfTklELCB9LA0KPj4NCg0KUGxlYXNl
IHNlbmQgYSBmb3JtYWwgcGF0Y2ggSSdsbCBiZSBoYXBweSB0byByZXZpZXcgaXQgLi4NCg0KLWNr
DQoNCg0K

