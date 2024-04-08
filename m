Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751E5C67861
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 18:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UOtzH8bMAY7RMFtlNkAiouA6TGoRur9+YXBR4EZyI6I=; b=eV37gTgej2VKHMdPOilGCt1DLR
	zFBGSyGB3DQHku6LV9W26PGNyRs5WdMqVCfkIQI8n1EnCgIfrw06FZtmXQE6OmrPDOkCUyqOyh37M
	I1jhm0le0uB4WxMBA1brxrqcMTJk21IewDqKu5heoO1980d7gvN0s63LQFJVxb4klZJtTqJfvr0BD
	48biArZyu2XT6I41AbN2avBXRN6FjWgWU+oC/SCHSF5qb4fJh/5Y0o138lOfKMBDM47jM7BgrORnQ
	7FqHuRQVvLogK+JrQeKTyvGLbr6kRysa/MoQXbu+Rho/hFUBDLcK2rQtcPDLICVd8KaUa6+rUOSSL
	BeWVZA/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rttk7-0000000GUbJ-2L1V;
	Mon, 08 Apr 2024 18:29:19 +0000
Received: from mail-bn8nam04on20700.outbound.protection.outlook.com ([2a01:111:f403:2408::700] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rttk5-0000000GUar-2rfY
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 18:29:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUMxiYOeLM6q+K/kizPgaDYiogiUpilS+9CgxFU5aUPleE5LpWteayIYE0UA43t94gtaDx2ziJHKduem1zWgB1aIn4dBqoDNcCLXmoUCfBtN0sIgyQb/0cEx/s9dzcxf0M4qSh+j6SiywuVSjNg48LJ3u7XuTEQzdqOAhgfNrAvVyj1GOrG1mKkefAsBV5EwMFG4dqiSCb2CK6gMhfqlV0zDkWRn+16KxJM9H0ceRiyKu0EDW0zruYqXU6MDtHcdFqW00TytyWDP8y3tlZxAW0XAQd6gJNaypktA3QOlHe7rYaPUCQoPIVYgbGpRJGypDNPE+xGyMQrx8o5NNuyqIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOtzH8bMAY7RMFtlNkAiouA6TGoRur9+YXBR4EZyI6I=;
 b=nATFgu6u7utp3PY2AHj8lkJw5zeSizMhSxaNqTFIUfqp8sK8FHMJuODEaN/GMqra25EBsrwW8EQuJ6NjqyzkqHxsNzKLn+LBYtdW49Di1iTf0zYMLNxuYl8fzQScKWO+yJ1FlQufvvfOmwf42w1DnLZDQpexDeJZ7gVu6mmvu/sakbXNPImKRB+DJ7CtauyF1cCobZK+rbVst0JfAtfWhpYDg02FkTQzJEBhhnD7/XRyiUiJa6vgw6LBvcHyvWGQmY64ovfLpTVAT+HmeF+YMF4wmMnXzdfkpQbS91s3u/5jf6q/iePzOZRfPgXSX098UYwYSngNcSwF3M1kpvRn9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOtzH8bMAY7RMFtlNkAiouA6TGoRur9+YXBR4EZyI6I=;
 b=IuojvzyT7ebZIvhBiUYRGqHlFn00GHvnfuW2szWbopMT75WhjheOe+uaaXDD0E4u9XaaHA97m1QKVz0I2XBv1DB1PF+fDrkSMMHu/WqBcApJ4MLCXErATsw61HfMxlYjfQw/RiatOL8ANWJU1XunffNH7A/RAN+ozKJ1pJ23WJ5itrvYgPRuimzJKqly7e3kIUaxwrAk2RtMIMRrnFI1xtyKaekd3IRRsJb+331sqQGgIlkbhdmrX9yKIZ2rhqNmi2CmEiGthvkfb453OMpAjVQUbnZnnOz4SoWouboj8PFgtX5z3kzuWdbBwgCOGpD2RheMDDP4/8P7xQb+PcXGHQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB6839.namprd12.prod.outlook.com (2603:10b6:806:265::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 18:29:10 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7409.053; Mon, 8 Apr 2024
 18:29:10 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@kernel.org>
CC: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCHv4 0/7] nvmet: debugfs support
Thread-Topic: [PATCHv4 0/7] nvmet: debugfs support
Thread-Index: AQHaf3W/qaPNudHP5UuSIbM61KOWLbFexl+A
Date: Mon, 8 Apr 2024 18:29:10 +0000
Message-ID: <d434d186-bfa1-4b44-a9aa-e268b2d41d75@nvidia.com>
References: <20240326120342.105740-1-hare@kernel.org>
In-Reply-To: <20240326120342.105740-1-hare@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB6839:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f6Ht525+G13zKN6BEwL2MzUgNkr+m4BOp0MKRIdmMrmltc1ZjmpjyyeTdnzdgyvD9XoCrBK2FJu9PFWDYhhAE28gRZDHaEssByjYQal6txWMxAoUak4qmQ5oklM7Uq6ju2Z4W13i81jxRdtSHhxeGKNh8qNEO5PnMi9pi8adoQYSQdUCRiVzvJ0++nn67AT0lKUG7sk553HanfZdfwlq4KxKrz0WhyQK9HWmoIHNM22OlasBWCO/9dEJrrK36GnmEJ0Tdrice4GNn9zoNKMlGqiFy3sYWg2DHOTWClt3pPR+bbfbnCswTLU5/rGdi4L8Eb9mdLPQsdOwBRTQlkmnvWvbkodDm0XqiykU6NQihzY7dhdbo/8hlh3ismNZ3HxIbmg09C49wgmi0yYUTrSTFBD8gljcy3abtI5JUvw0Wc0gfR0QJkT67r/0vo9zZlkSx6OqpUgdJrIJWHhWUACicb0zLuWGlOIJWNrRCcKIitjuz+WwhaXAl55euTKx/8zN5uyPCvngt6QitBv4E4vZjcCXBnIFT22UvmFtxU+PqbaM5mBTAddkepOw46nBYRGQ/Ah9K+FLxKnkWX2PvRyLwdSbdrKIJInu3EaWclCrBzwVrH2V2dCAPNSWh3rcSzWx1svUcEUDutgEtGUKOSscb934EEi7zkhB2wQ/F1rmVUg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEhEaytndFhGcUY1SUVpN2hZTDRhMmdNN2ZaNGxwTzNMVXk4blJKZndJTzZw?=
 =?utf-8?B?Snp0cGpIOUFWUyt2ZkRtT0IwS09PVGRNdU8xaU91U2huZFZLazMxYVdOWGc5?=
 =?utf-8?B?VHRtanJSZWVXbU9wT1VJeWdSLzdqZWNoVVhBS1gwbWFUY3FUNWI0QUlPMXN3?=
 =?utf-8?B?ZWhmdzJNUkZPQ0NHOG1NMnBqeURkaVZTUUhOb2JCdThUNmZOcHdwZUN1Qkdw?=
 =?utf-8?B?WFJvVGZXd3N3NTBhc3JZcWlmVW1aTGNINGtkbmFXUnB4RXJaZW41dEg1WVor?=
 =?utf-8?B?ZkFuaW9kN28zRmNwZkkrMkR0N096NVo4djZWNU9HNkpNQ2xkREtwYmtvYVUr?=
 =?utf-8?B?NjY2aTlSMVZOMk5qTFNvUDlpRmlrcElxZklVcXlFd0I3bGNXSHMwVzVOdzhj?=
 =?utf-8?B?KzB4NDNBTitCaDdlcGtFZWtDcVVYNDI0WWFHZXFwRFdKVVp2N0duRW1RWU5Q?=
 =?utf-8?B?Snh4MERVOGM2bEdSUDlXQTdjcktFVUFtRHFrZDh4Z1hPWno5NVhYeHN4dUdX?=
 =?utf-8?B?alQrckZ6VmRuVWN0azJLcEM1RFplVE9SRW1IdmJJR3JwSUhkakhtb1BTdWY4?=
 =?utf-8?B?MEFYNXhJaDdsMnZGeHdrbW5JN1pNc0RBUzVDazh5Q1ZLenFrMU56MzhnK0dY?=
 =?utf-8?B?N0Q0N0dWd3lhSktXRUZBdnk1bHNXalFPTDNKYUE3VmcrMERKL01JWTJRaC9F?=
 =?utf-8?B?Uk0vaDUwRDhRaFdIUXpUaHBGQWtDOG5SNy8rMEZub01kSXFoTTFEeG91SXlG?=
 =?utf-8?B?RUdUMkV3ZGpaVmw0Qk1LTXBkZTRLVFc5UHhEc2diemdjOHFxRitJUFJkeDdY?=
 =?utf-8?B?ajZxR3FEQkhDL1p0TXAvL2xobExGQ0h5dDY5dEg5WEw2bklBZDNXSlZXZzZ6?=
 =?utf-8?B?dTdsMkdURE04cEw3TE8zVkN2ZXZseVNyNTMyV3JBU25jcjNNMlc2N2VJd3I0?=
 =?utf-8?B?dnI0WHRoN3JQWFFIc1hKNkR6U25NWGNSNlZyNmR1NlNzRHQ3TTh3R0ZWNHM5?=
 =?utf-8?B?bW9CKzJDcGVPQ294N25KUGYzZnZtSEZ0ZUIxZklFbjRUdlU3RkpKRXJsdlRB?=
 =?utf-8?B?bU5FYU1VZ2ZtSmxHQ0Z1aGVWdXc3S0craW1OOEEwVUNZZXRzZUJOVGRPNSto?=
 =?utf-8?B?WGQvY2k4eEt6NlJlRUJQWXJGTU16azlBTFJNMit3dFMxYkpQVXhaLzc2MEVi?=
 =?utf-8?B?Z3VVdDRlNEhuUWNlRkZUay9mcWN6YXlQS29SMnFsWExOQ1Y5VjBPQ1c0NTZK?=
 =?utf-8?B?VzAvdjlpalVJTVF1WHRWQTluYkU2R1VjdDA2K2ZJWVlBa1FmZ0ZJUnY1Si9R?=
 =?utf-8?B?RGRSaitQNlpTeEFuK0U0ZDFZbkpQTDNrT2FreGJudGZvUm5TNVlLeXZiNzZ4?=
 =?utf-8?B?UkxqQ25QR2VmSGRHOE1uQ3RPU1B2eEhCSGE0UzdaSWcrNXdzOXpxWDBtTWNz?=
 =?utf-8?B?WG1md1FlNkZsVUFsQ1JJek5SQzZpd2dLSFE1cm1jSUl2cE9LeGRZRGZ4clpY?=
 =?utf-8?B?QWlZSTN1THlBZWVSZmRRK21GemR3UEhudU5sSUswVjA5VGZsOFBDZmVXVHY2?=
 =?utf-8?B?SjJFUWVocFJIaElZUmN6dXZaWG5YSU5FK1FvTTZ0b2RQV2xhcUpzZzZWRzBa?=
 =?utf-8?B?TDc3QUdoNmlteDZXb2VPeC9vdUpVYklRWlpMSExqeVV1UFhDSldlUXRoTHN0?=
 =?utf-8?B?L0ZlbEZsaHRramdhS3VVUVg4UlpuV0xNZlFQNkVaN2RpbkZwSTRQeHpsZHZp?=
 =?utf-8?B?Tnk2SjduZUZtUC9hL1ZRdU41Uk9iN016aW41OTU1QjA2bjNaQ2swcWM3aWht?=
 =?utf-8?B?Z1crU1NWL051WHlSZWI0b1FNOW4veWVZQ0Uya28xV1ZJT2tTK3YvN05QcWlW?=
 =?utf-8?B?alIyWmpNdjlIeHlQUmo5V3o5Z2pnQVNvdy9BYkZxb3BwaWl4WTRrS1lVMS9N?=
 =?utf-8?B?RGt4dzNiRjROWllYY0JWdTJOK21HZDRGdkMxYnQrL0ZUVkRlNUdpSng2WTFl?=
 =?utf-8?B?SnVWMGRqNFpKK2tDb3VyRGNsL1RONE9oUFg1K09JMHcwY2R1cnZLem4vSk9v?=
 =?utf-8?B?cmRPK0pzLzJiQXZhMm9nWGIrWEt2NHBvbWNreE5zUjdSdm9iUXVNUWJpQkJ3?=
 =?utf-8?B?TXZLNjMzKzJRMmk3UTdTcHQ0Q0FCWVZvN1ljYzFkbDVCWEdVK1gzb04wU3lv?=
 =?utf-8?Q?Sr6ZxSldyqr4PVYPWrdaqJnlO/DqrPbSyImR6Qxf995G?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43D9426D37290543897F19E4B276C620@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e28a59c3-150b-40fc-7908-08dc57f9c87c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 18:29:10.1652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vjX04z0bWCjJpaO5XTERyONNfQFjaDFix9m3sVoSEkZHc17I12eqgkVJhlsk3hlU9Uma1Z3qjTKrVmNOa0sMUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6839
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_112917_765400_597CCAF6 
X-CRM114-Status: GOOD (  13.22  )
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

T24gMy8yNi8yNCAwNTowMywgSGFubmVzIFJlaW5lY2tlIHdyb3RlOg0KPiBIaSBhbGwsDQo+DQo+
IHRha2luZyB1cCB0aGUgb3JpZ2luYWwgcGF0Y2hzZXQgZm9yIG52bWV0IGRlYnVnZnMNCj4gSSd2
ZSBpbXByb3ZlZCB1cG9uIHRoYXQgc3VibWlzc2lvbiBieSBtb2RpZnlpbmcNCj4gdGhlIGxheW91
dDoNCj4NCj4gL2Rldi9rZXJuZWwvZGVidWcvbnZtZXQNCj4gICAgPHN1YnN5c25xbj4NCj4gICAg
ICBjdHJsPGNudGxpZD4NCj4gICAgICAgIHBvcnQNCj4gICAgICAgIHN0YXRlDQo+ICAgICAgICBo
b3N0bnFuDQo+ICAgICAgICBrYXRvDQo+ICAgICAgICBob3N0X3RyYWRkcg0KPg0KPiBUaGUgJ3N0
YXRlJyBhdHRyaWJ1dGUgaXMgdGhlIHZhbHVlIG9mIHRoZQ0KPiBDU1RTIHJlZ2lzdGVyOyBvbmUg
Y2FuIHRyaWdnZXIgYSBjb250cm9sbGVyIHJlc2V0DQo+IGJ5IHdyaXRpbmcgJ2ZhdGFsJyBpbnRv
IGl0ICh0byBzZXQgQ1NUUy5DRlMpLg0KPg0KPiBBcyB1c3VhbCwgY29tbWVudHMgYW5kIHJldmll
d3MgYXJlIHdlbGNvbWUuDQo+DQo+DQoNCmFwYXJ0IGZyb20gZmV3IG5pdHMgY29tbWVudGVkIHBh
dGNoLXNlcmllcyBsb29rcyBnb29kIHRvIG1lLg0KDQpTaW5jZSBpdCBkb2VzIHRvdWNoIGFsbCB0
aGUgdHJhbnNwb3J0IGFuZCB3cml0ZXMgdGhlIGNvbnRyb2xsZXINCnN0YXRlIHRyYW5zcG9ydCBp
bmRlcGVuZGVudCBibGt0ZXN0IHdvdWxkIGJlIHZlcnkgdXNlZnVsIHRvIHRyaWdnZXINCm52bWV0
X2ZhdGFsX2Vycm9yX2hhbmRsZXIoKSB3aGlsZSBJL08gdHJhZmZpYyBpcyBydW5uaW5nIGZyb20g
aG9zdCA/DQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29t
Pg0KDQotY2sNCg0KDQo=

