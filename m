Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370CBFED9E9
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2026 00:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hopxcOxxqQ9dg1Eh1ugYaGvFQnzTA3elqXhKm8Me2ro=; b=ZkSalbPWS6xo7lu+wuKW+jcbEX
	pqfZpxq9oe6sFbTITTSMpue6a+EOWxx6EkctnSiaBIsYxllq37lS3urUFLXHYS07bhSP/fKYHwru/
	Dws+ijA7MTGLWSaTlRTGcrXgx6snxGR2jz1xVD4jbjynbE8pAQB1b4QhP6DJtT6vUnDEP3wDcZ+CZ
	TeAeccXh0kA6bzceSz8ZMT4hu/oCeA6xvg4fU5gKzXBOQlmQuI/Ax9TcmWOdDo0MkKpa5yXyElMZK
	6Py2gyq62w/P9bOEnVVQE3r3LgXS89Uk3l9KobZfnm64G/HbDTDDA/+B0Aetyjyfb3oxo7z978pFH
	mrEnklxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2een-00000007Up6-49Ip;
	Wed, 18 Mar 2026 00:21:05 +0000
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2eek-00000007Uog-1kyT
	for linux-nvme@lists.infradead.org;
	Wed, 18 Mar 2026 00:21:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vvlc9K4Pzfhbke32qMIhoOfyDB42V78zgn00PjsiLKzSRoQyYLA5RYkYk0q8exJvI46uAZHUjr3aCV9g2wLAXQ4NPNw+yPuRTObPKl6/Gg5AmvpaVfwPcsdeD4EFfm/b1FYztOZhEzLyHR6YyqB0ja9OeHVvytj7X6vWePEC1TpapGxsR1GVs7zJdxGhJsZY8dWyzkss1ftVAyiXjP1Picb7tODyZnehePeLvKGIot/hG2zzFPNuNJwtEolVgH4TR+attR/BQpD0DFdtBaRYbAjWPoXwn05mgGTKlics8Y79YmzUDb2DlcShtVsekf4Q3G9gyLuwkQpOfbqewJ6nWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hopxcOxxqQ9dg1Eh1ugYaGvFQnzTA3elqXhKm8Me2ro=;
 b=adz5o7rZhWyJ2ZRv3PSk9QRfCOXqagdyb6fgAEtxbqPSS9PeQ6D7fm7mQk8zjc4zDuQNjU5YY82/FUNulTHMIKFeTnpQEaU2mUhu7yihK8qL0neol7JvWstGqVYCdJkjRo68JV5XG3YnHH8w6iCKiLOkNefKKUhiTi3gmbOyGRHbW/+GLXenukyScaZcD8ZC5oOyo/AG8pSnIINyIxHz7JnASvEUyyyp8GrHOA76nvzXy6/gJ0HwZk1l6f4i+u7raoM8KHbk+iKw13rYA8vYmnUaFdjtkmIj4lQnV5AZmY8UWLZ0QfHC3z4PeMaMEoWlZQfIjTYdXOfJpWYPF8BFZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hopxcOxxqQ9dg1Eh1ugYaGvFQnzTA3elqXhKm8Me2ro=;
 b=odH2i0sI+powt/RyQM3atxS78swWapRf48cYltQnwQQFdJJQtMQRQSnyjb53aQxL/Oy695s+BbrbfGG4dIOj+V8EGeMH5owQYh0XPKbsSFU2T7A4lqhBKSXoHsSgVcoKQsUVu4Cv+X5MpPTFPNkzCI4jSl24Lxp418U3Um8LXf7mOr/zT+fb299RTODXaKbPOzq68eFKYp7b8mGSnoxaRWp/kFf8a3QFP0TqiKmhBLb7D0WpbGNbrKhGpDvySNaHMppbG/sG4sUxp+KzvfIpq/SluHb5PgQA/75VoLPj3xnnuXTLhIxiXFqF1dqP5k+zKzhuCoZJE/FyL71w34r+2Q==
Received: from CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 by DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 00:20:55 +0000
Received: from CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::edab:eb80:ee7e:e9b7]) by CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::edab:eb80:ee7e:e9b7%3]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 00:20:55 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Hannes
 Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: libnvme API review
Thread-Topic: libnvme API review
Thread-Index: AQHctS968RvzN5F/7EehG5FhJJkQz7WxazgAgAEXFgCAAO19AA==
Date: Wed, 18 Mar 2026 00:20:55 +0000
Message-ID: <b13a6910-07c8-407e-8267-13c9a60f2898@nvidia.com>
References: <d5b9ca7f-8fd1-48ea-a883-79e92d92ec7e@flourine.local>
 <2e26ab34-5568-4b5e-bfbb-7466eb515f13@nvidia.com>
 <f469ac91-a55a-4b19-b251-31081537d403@flourine.local>
In-Reply-To: <f469ac91-a55a-4b19-b251-31081537d403@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR12MB9386:EE_|DM4PR12MB7622:EE_
x-ms-office365-filtering-correlation-id: 7fbc9d61-565c-448d-4320-08de8484387a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: RCy6ZXghzisgL/xIImUJUAKcD7vXJrnvq97BMuAGOXYYVyPGDiPsVunR2tdXz/N42oMKohaFbKinf9Xta0l5SLbzAPR0a5ajuCmzfbEjBU+uFPoJ48bCE/t3paVCoW5mFIUNpLB0m66VInFnfHP/D/0uJCWjciVSu433jWOdTIBUiYwpxok3XOgHi/RORw3cUL1SjGkP002CjNEpF44L0nffL7weexBnPlAP/FTvarxsz5CpP3gLFtzu+cKnxy4ikNMuUfz9PcimHleFXLRQZqeMqSp+iH3HOn7sFh5SvtHJNJnF70P+IAVuArmlOJWoLqkLucq+FWqSSRPzNBSoSv1GHxMq9QOiyIyDLVhDSEw5P9ag3/6lbfSFop02REQJX1NJmwTcmh4IWwWUjheA4w84rb3PmG3sZ/58/w96mHT3m0NKioIB3e94q9X7uC53FGbeWW5GVFkmnXy5Hd46NBXTEBgEXDoGdw8TDr0zPOlC7o4bq4hbJAPB66OAHyQd3nhNqcWpJGOo8Caz5ctTq5u6mY4R4y4YMqLaXvgw6/fvytXturlcOwbd/aFhrn7m2bquoPl5QZpkCET7LawyskUAS3Kp/mk4uTGpnWTTs6heeDkDlsW+OOZ4IAlF0/xvMPztT61IAyfR9Rg7fNbckQxNO5jpeh51BhzsIma6UEg7lSs/mSNDjVgkuVAEpcGKEw6y0Ho5vV8k6NgdG3HyaZycoIZLrc7Xbt4DLqjQj2Mzedg5STPhPC46NXSdnDw+T31kRT6HRa1lWR77IiIQ+7cOtiLSI1TKlcDN9xMrhv0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9386.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDI5ZjdZdk9xM3M5QmlTMkV5a1ovZk03OUNSUG5VKyt6bDBRdCtodmgvMXN0?=
 =?utf-8?B?S2tHRkVmM3lnUElURitJaWZpeklnRzJzTEhodGpHQjU3QmRFaFpxY2Z4OUdZ?=
 =?utf-8?B?dGV2djA3em9lSktUcW5JdURPM1FvSlpteVZZRm5EaEFuMVlnRGpyajVVNWtU?=
 =?utf-8?B?NkNqYjJRVFRobGZhQTlRbEhwVUV1dmpQb1FicTU2QXE3WnNnRlZ3bWpCeUQw?=
 =?utf-8?B?K2xwS3c0QURGeC9pS1dwSXN0UUxKU1c2bXk3bmdCZFB5RTNiRHR1WUlOVVg4?=
 =?utf-8?B?eUMxd1hFODNVYnVQUkludnNySlJLMnkrN2NTd25BbWhCSGFvbkRZRjJub3V0?=
 =?utf-8?B?QmpCMnl0aGFoOEFtdjhURnpsTktGZ3BPMnl5bHFoa3lEaWwwalArdG1nQkhi?=
 =?utf-8?B?M05TMzZiVU1Nem40NnVqZ21CcnIvYitQRCt5M0l6ZnB5VVB0SGQ0alJwZGVL?=
 =?utf-8?B?WXBXWi9tN3N4QXBCRXVmNHhrYTd6ZmFzaFhkeGZVaEJPLy82QkY5MkMzd2R4?=
 =?utf-8?B?WndvRmIvK2JPa0xhU1dFOEV1cUZjeVdUOURKZFJRWWNVWjVKR1Q0d05EV2U0?=
 =?utf-8?B?U3ZSaXZxbnNDd0ViTUJldE1sR0RBWVEwOHIwTUdSQzYyZm96cVpwY2kyTnBG?=
 =?utf-8?B?YitsM1NrMGN1U0RYRnh4SVREVXo0RC83dFF2SUcva3Fta2VrV3JkODVtYlUv?=
 =?utf-8?B?Qi9qSzdxeEhtQlJIRGdlQnRHbVNXZi9vOFQ4NEpvZ0pMa3lSWk1SK29rMTRK?=
 =?utf-8?B?OWpZVXJuK29EMkJvc0grWUFaTjdGTis4aG50YjZWcFlhbE5TUEZzUlkybmlF?=
 =?utf-8?B?V3dId2ZhQ3BzbXI3WlV1d0hEaHBKNlhQNFNLaGdiNUNReUN4dVN2azc1aW9z?=
 =?utf-8?B?SXdYcFdmMXAyMWtTUjdYSzJ4WUFhaDJJUHJRRkhtUWxJUjcxWlRWQ1YxRnpT?=
 =?utf-8?B?UWNlOG0rTjQ0SFNZWEdFalZmNVpxa016YTU1QnBXN01sOVNWTVhZQ3JKemVJ?=
 =?utf-8?B?LzlCMERGM01BdTFBalZZZlhobldLaGFoaWw0NjRzTTlhOEJpd1JiYUh4OHVC?=
 =?utf-8?B?U09iRDhRb084Tk40emIrSTJRMC9JNmlENnpPZXFwcjl5a2hERlRkK0N6MUhE?=
 =?utf-8?B?UGtudm9rUG1uTU9keHdjb29wOElXUnZCWng0TmhEaGVwSTBmdE1uV2EvK3J0?=
 =?utf-8?B?N3NFRjMxaGdiWHFSNldGMWJSQzRiWXcyb3VrendMcC9oa1pMQkhFZCswZFM3?=
 =?utf-8?B?dVVpeEVkYTVhQTM2eVBTcXpvOUtVdmxUMDdGZHNLelJYK1pIaER1ME1ZTVRR?=
 =?utf-8?B?VmYyT3VkZHJvdWh2UmhJQ2JDMlVkWlNPSlBaTnEweTJUZVVSV0N6L2dNMHp4?=
 =?utf-8?B?dlorUVJkdzZSZUJXdG8xVm8yNldPVGkzdDE0T2hjclZueFM3MDF5anNadTdr?=
 =?utf-8?B?ZVJvaUhsbHpaSE1RZWVtOHJ4enlKdVVwT0ZRQ1FmVUxYc0ozSXAxRWRhaC8r?=
 =?utf-8?B?SytlS2tyUUdwa3Mzdkt4Z2Nyd2M2NFlhQ0tvUExLU1M4QWxPRVlPNC8wa01Z?=
 =?utf-8?B?OUpNejNBdXpVeVdvZXFETWNINGU2RTJzMUlLSk1GeWxLRlBienl3WnZnakZp?=
 =?utf-8?B?R3FWdnJSeVdxVmdaazFxQm9TbytzazVaRG5CNmUwVkdNRXZLRmxqKzFubWp3?=
 =?utf-8?B?UFg1VXRLdU9Ub0tnYTVNbEpBRmFGWHREMEQ4OHpJMEcyZjRjdCtOQlh4cUlJ?=
 =?utf-8?B?cldJdWpYbVQ2UjNodFpHcFJCU0IxdFFWZ3RwK05oWnVzTHhSZmQ1SWE0MDgz?=
 =?utf-8?B?c3Jwazh2OWFlZGVjRTRNZGFqeW15N3RMeHY1bGFjamRzYzhNS0M2cVVPaHpx?=
 =?utf-8?B?amFmZHhKQWY4aUZOMEZHZWZZVXJmYXJNa2hLLzMyaDdGZ1lHZGNzSjVGdk9K?=
 =?utf-8?B?bGd3THMrWDB4dVZMUzFHU0VUMmNldkdYQ29pWVpHV25iK1dKUFRmTTBDK3hO?=
 =?utf-8?B?YTZxRHQrWHFCR0NJTVJvaVB1bWovV21BUk50a0N4dzhGUnowdll5Q1M4Mitp?=
 =?utf-8?B?c1UzZWllMExRMHFFb3BEMkF1T0VwVmR0VHl2cWc2ZSt0cTJyNFkzdzJRUXFa?=
 =?utf-8?B?ZTRjUzBiMVZHN2Q0OUhCU20zelNvQmhleUlGRzM2RjJsR0thd3RSayt4TEJx?=
 =?utf-8?B?RUtCdXQ5WkpPN2c0M0RjQ3NQRWdETnIrWVhkbmFJSElkdk90aXo2aW1Gc1Ur?=
 =?utf-8?B?R3pJT3lEbjlESTlqT3JMM0M3VFJsVmdkVnRuMG41Ri9wZ2ZhMll1SC8xRjI5?=
 =?utf-8?B?eU1vUlMweVIvWXNyY1N6dHpQNzdwY0kxY01sdUhGTFRheGxPNnVxTUVDU3hn?=
 =?utf-8?Q?7JkEsI/ktGrl9Nm5lnEUQ4ZErPRypWI7EnvboUWDMDrP+?=
x-ms-exchange-antispam-messagedata-1: jrLYifBZpyaT4A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <55137B09C6F8F245AF721C39C12F294F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9386.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fbc9d61-565c-448d-4320-08de8484387a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 00:20:55.0767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZKs0zFN+POfjNn1zoitLIGXRedzosrD8zvM5ewl08dXIXm9yjwUoe3z9zo8BAZYHwb4QDUKlU3LlJdJF6F0dhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_172102_460111_E520F215 
X-CRM114-Status: GOOD (  13.08  )
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

T24gMy8xNy8yNiAwMzoxMCwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4+IEtlZXBpbmcgdGhlIG5h
bWluZyBjb252ZW50aW9uIHNlcGFyYXRlIGZyb20gdGhlIHNwZWMgYW5kIGZvbGxvd2luZw0KPj4g
YWJvdmUgZXhhbXBsZSBmb3JtYXQgaXMgbXVjaCBlYXNpZXIgZm9yIGxvbmcgdGVybSBudm1lLWNs
aSBmdXR1cmUgYW5kDQo+PiBtYWludGVuYW5jZS4NCj4gSW4gdGhlIG90aGVyIG1haWwgeW91IGFy
Z3VlZCBpdCdzIGdvb2QgdG8gc3RpY2sgdG8gdGhlIHNhbWUgbmFtZXMuIERpZA0KPiB5b3UgbWVh
biB0aGlzIGZvciB0aGUgbnZtZSBjb21tYW5kcyBhbmQgdGhlICdwYXlsb2FkJz8NCj4NCj4gQ2hl
ZXJzLA0KPiBEYW5pZWwNCg0KWWVzIEkgZGlkIGFuZCB0aGVuIEkgbG9va2VkIGludG8gdGhlIHNw
ZWMsIHRoZW4gSSBmb3VuZCB0aGF0IHNwZWMgbWF5IG5vdA0KYmUgdGhhdCBjb25zaXN0ZW50IGFz
IHdlIGtlZXAgdGhlIGNvZGUgY29uc2lzdGVudCBhbmQgZm9yY2luZyB0aGF0DQpjb25zaXN0ZW5j
eSBvbiBzcGVjIGZvciB0aGUgY29kZSBpcyBub3QgYSBnb29kIGlkZWEgaW4gbG9uZyB0ZXJtLg0K
DQpIZW5jZSBJJ2QgbGlrZSB0byB3aXRoZHJhdyBteSBlYXJsaWVyIGFyZ3VtZW50IG9mIHN0aWNr
aW5nIHRvIHRoZSBzcGVjLg0KDQotY2sNCg0KDQo=

