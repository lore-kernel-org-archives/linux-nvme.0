Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F1EC4829A
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Feb 2024 15:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2b5CWcAhO+u6eoBsjt8BdiwHb5azW00EtkqvWtgT0E0=; b=RG5o/INuNjv8HL43zMNguQYeMT
	c4kj15zUsVyR+rmgW4yIGUrf2qtBRZ/DoWNuJHvsGZIxvHUeoQicBwBFxgOdHCv1G/FAHPJsRaUX5
	FUNkZXPiZG9CWBMYyESW4bB44wxRl83pUwE4cp0uldete5+6kj17Apb0O9DxROocTL1v8ZBNf7b+U
	CCwBTrBiAxyMarQZaU9U4/4f6y2i0eAMCh8z+JTb7HXUlqkIBBg0N1CvC4Vsul/mbTUvZ5qIDr/c7
	AMGbfFrESiIW30vW05MWD9sRtcuRI0PkjRgmznyvnvyMRczwjmcGaon+y/7lTPJIV0wO9TwC9c6UO
	6tP5T+VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZBOo-00000002sQ6-0Tkf;
	Sun, 11 Feb 2024 15:05:42 +0000
Received: from mail-vi1eur05on20700.outbound.protection.outlook.com ([2a01:111:f403:2613::700] helo=EUR05-VI1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZBOg-00000002sOr-27ps
	for linux-nvme@lists.infradead.org;
	Sun, 11 Feb 2024 15:05:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYgvjV4wnMtZ3R+JN/m+3WUcxO8Yy2tOU0xsGSLiKNcJYQNbxCI+r/AHKrXICQtqvQFB8KM+2aLA6M+yoRgMN3Rl31zUn1IqMFbObHrTse6f3PelLFAgo3bt7vGi87f2V41sXGftmHr4CFwzMplmtmlKD+q65gnQEHck1sQnrL42Y3IQB2WEUP2RiRJWALMrHXfySxddbFnV1IQB2zB3kwlxRJRhLVBJLv3W2DMaZ4gVsOOrcbfY8/bYdSMxqKy3YpTJT4oND80+YguAwJhV9t2FGUksPTIoYYbG5eVJWQIP07viUa2WJZM3W/AdGSLiY6iKYe33tXGfy4qQpUmPvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2b5CWcAhO+u6eoBsjt8BdiwHb5azW00EtkqvWtgT0E0=;
 b=KuSNyh5C3Y0CpsR1kn9goP1NDsHz1d6/2LYjrzzEORDb9qarOV+ZT2X/uiMhJc0PNaBaawnuYGAYEH6EGuuUZqggNDU3bw+TmzXqQQbBNiF7+0dsRQQPFTRreVEdxHypfr6uCMqjNcX0Qh8VLGnCkRx5i+HMzRqN1KjzBl1zLTJ40H6ic2Ja3tmI66z13Hi7Q4p7/0FVBcNJCSz+2FuigKGt+tx3GWukEBCJjvMlqGV+ZRumgpOzDEuq6u2GnBFWaLv/89ml0fuvFprz3Jk5xoIB614zaL29gdE5cwveUH4XbBvlTft/tkCDt4jxV0iYoB6KtERonmXsgsElHteG5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2b5CWcAhO+u6eoBsjt8BdiwHb5azW00EtkqvWtgT0E0=;
 b=oeCRnijMeIrNQX1KfB3LgY0+UE51An5VBD2ltGyY3DHB1J5EZafEqpyNOJh2UhxF+caW9IZRZBsPpVb2LxaUNziCKHAWT7tFUxicbAtyAI6Wl1v0aDJzEZGl96Rc5NhpS4TO9kZ0Ay0H/68zwsT1yn0XeZ/szbTjl6IUqGv6DpyoYAMfMg5zI7R0lIflEEXDeFv71n/yVRYDb+wLm4q7PeWe7eNRtMerL103o/GU9lLlzJCKmPrm6zPUIsURRYBcQC0i6/Ov4eviFF0aejxlz64hl7+MryXqm41E5BMtSXH7egWoMxzF2aZwhhjqRhFPkOEjWmxuZpDf/DZcfDy9KA==
Received: from PA4PR04MB9392.eurprd04.prod.outlook.com (2603:10a6:102:2ab::8)
 by PR3PR04MB7385.eurprd04.prod.outlook.com (2603:10a6:102:89::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.37; Sun, 11 Feb
 2024 15:05:24 +0000
Received: from PA4PR04MB9392.eurprd04.prod.outlook.com
 ([fe80::75fe:3ccb:3912:80cd]) by PA4PR04MB9392.eurprd04.prod.outlook.com
 ([fe80::75fe:3ccb:3912:80cd%4]) with mapi id 15.20.7270.028; Sun, 11 Feb 2024
 15:05:24 +0000
From: Nir Rigai <nir.rigai@volumez.com>
To: "hare@suse.com" <hare@suse.com>
CC: "hch@lst.de" <hch@lst.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: TLS over TCP connection failure
Thread-Topic: TLS over TCP connection failure
Thread-Index: AQHaXPu9NkmdQAIoeUevwng0N1SpTQ==
Date: Sun, 11 Feb 2024 15:05:24 +0000
Message-ID: <587CD834-9978-4D44-BA69-4AADE3DE2E06@volumez.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9392:EE_|PR3PR04MB7385:EE_
x-ms-office365-filtering-correlation-id: b97e1587-7d86-4535-3694-08dc2b12dfbd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eGv/EXmin7qyTmlXEIh1ZX23ylFZQY+TNBODqOxzZ3evZQapV1xtkqNouGadHfue733KHKo4JVrItIguS9M6zVarTNcjM2Fmik36K5UkfynaThYsYbJgZ19OQqZI5C5wVjIVDWDEeZW/NHNOauDWhduBcWWtJJGUc9DIZadsnC8QkmfTOjz65oPEm/08LaX8wZBX/cGxjgCEtoZtFkNC3hCgx5WASRpGmP/rd8I7WNeLpMWs00w5xKlVsygbla1upcfEpk/INzk6pEWpPQyThz2gx0TfZmIzZb55M5Ql+wECPhOUqf5ISYNTyjPkdzQSF37/BsG6nT2laIinx9Bi+vdI0t/g5sNM/3LkFf/dek9Cw3R5NIr6d+Z9XjKXawgcHLwmFrfZddH/5gy/zVo3Mgmp+TNObjl8pZ0Sv1GX+76Xv5KttIicEsRkI5d5tKCQ0WtmLGotgwww/4tqwNXbhxKj8+in9AaT5RObJLw+ypaw8/TX/Uj+RTrR2TMrQvo8HP1RV1fJCWP5msvgsNoWbJk0M0zuNHBsV5JHWG2MZYR7P5MYbH5G+WF5Nng5iCKZEmzeMd1yEAC9kLKVwIKsreVo9dC97jUehPR1t0MbFlY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9392.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39830400003)(376002)(346002)(366004)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(36756003)(33656002)(54906003)(38070700009)(41300700001)(2616005)(26005)(478600001)(83380400001)(66446008)(8676002)(66946007)(76116006)(64756008)(8936002)(66476007)(66556008)(6916009)(5660300002)(4326008)(71200400001)(55236004)(966005)(6512007)(6486002)(316002)(86362001)(122000001)(38100700002)(6506007)(2906002)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3ZtUnJYZWo1ZTBONVNGM1dMRGNkVkp0ZmZPTkNrVVNkQS91NjFGcWdaQ3Nn?=
 =?utf-8?B?T2xEeEFjWWNldWVKQmF3TTE0YlJ3T3ZsZzJ0U0hTTGVNV080WHpwT2laUVk4?=
 =?utf-8?B?SFF6d1NTOTE1TUw3dXlHUmlZTmU2dTVLRXg4TW03Y0k5Tys5Q3k4YW1iNEVC?=
 =?utf-8?B?YTJVcmdZdTZKL2p3VFpOY1UzSzRzVUg5Y05ZUWJGLzBid1hBUE1jazhweFNu?=
 =?utf-8?B?TytFRVRZMll4QWRNdFRXdmk3NWZqZXgxQ084RUh6TFdmemsvdDU5LzNvRU50?=
 =?utf-8?B?NzNqa3NHWHBzbCtYRm5YMkpVbVl0aHYrVkNYOGFxRHNCTXl1Vzc5S0lFUUt5?=
 =?utf-8?B?aXpMSmtwUVJhZnpGZkNCWXZXNktWWkRRanM0YU41K0UyaW4vc015L1luNWwr?=
 =?utf-8?B?K1c3aVVxYi94ai8vYVJlMGUrRFVFZW10dDRFRzR2UjM4cE43RVg4dHYwc1lC?=
 =?utf-8?B?WFZjNEpSbmVQT3lOd1VScjlaeVpYMDlaMVRqays4bFd1WjBnNWloQ0RGbzlx?=
 =?utf-8?B?c1JuekxTQTRNVUpGL3pscS9ieXQ1NjA5WjZsb2tFZ3IwcTB0MENKc291MEg2?=
 =?utf-8?B?THI1dlpJT25xeXhqVDRCd0t1aWlkM1VoVmdqQzJsRVYwZjVxODIycDVEa0k3?=
 =?utf-8?B?bjM2YVhCcHVmVjB1SkxtbHN6QkNnTmlLSGNuRm0xa1NTWkgrQ2VvY2FsL3hT?=
 =?utf-8?B?SHlWUWNYR1NlL2xJcXFjeEZCWkJLQ1cvZDY2MCtvRWNIV2VUM3V6T1lmcVZO?=
 =?utf-8?B?K2ttdXIyY01FZGZxdzArNTlzTzZvckhHbFlhQnE4bVQ1djF1ZHFxZUNCUzZU?=
 =?utf-8?B?TW9yM0NPWGowSjRJalpNUElqdEhTdXFWRG43TG5EVFhIV0VaYWtTSlQzNmE1?=
 =?utf-8?B?ZXF1ZCtnODA1U3lUUDdOZWZLMi81ZmJFV2VTL1l4Wm8wdlpEa0hxVzFlTlBM?=
 =?utf-8?B?aGdBdWxwMEtrc2k1eVh5VEpTeTdGQWFsUU9oMTJkaUVxODF3TEtPWVF4azhp?=
 =?utf-8?B?RGN0bjZZclRwN1ZEUDNBd3RrRG9oY0twUC9ERnQ0d2dGWWxvQnBnS1VCYklZ?=
 =?utf-8?B?RzlySDMyUTJVVDNCWStGdlJmZ2Y5Qlk0UzRKUVdISDNqUUliZmZ5YnR6UFVj?=
 =?utf-8?B?Y25sZTZTcWEzVDVFRFUrVFNxTmtTUjRsZ2ZUSlM4OEJkQkFOTE80NHFLMXRs?=
 =?utf-8?B?bDROK09zQ1QxeFdwMEtuN1hJWm4rQzNqc0I4eHVNMlMySnVXTDJtUEJaNWp3?=
 =?utf-8?B?ODVyb3hYREFTVXdZZ2JKdjRtLzNzbk4xTkNmelpwRThPRm1DU3dHMmg2V0lH?=
 =?utf-8?B?Q29USWxpbktCRXlrakwrVXVjL3c4NEFMbmRRbjFQNm1NcWovUlY1UXh1cWNv?=
 =?utf-8?B?TU1TbFFjb3hJb1RaZTF3UDVJWERTblhVemlBdndrVElQTmZadmRGUVlvTFkv?=
 =?utf-8?B?bVFwSGl1VFVIQzhQM0pMNHBIdEJxYmVnM2N3Q0lRRE9rNzBJSDBBOVRVQS9t?=
 =?utf-8?B?VmtRTVYyL0hCMGNiU3JYcmFrOHBzUnRDRjJwTXF4d2pMd3BpbjVPdU05UzV4?=
 =?utf-8?B?SlhSd1d6TUpuMFNGRWtLdlhHenRQSGNHa1V1QVV0WGRENGZUeGRiTzhSdWlZ?=
 =?utf-8?B?UHhFT0Z3QTVJS1AxOWI1RHJIWjcwbllLb096b1JMYlZ0VDExc1JBekpocUdl?=
 =?utf-8?B?MmtSZXlwUG5xOHNKc3YxbFlqMkFHN2ZrZXNRUWlsM3FoaDhFMXlCU2pnZXNW?=
 =?utf-8?B?Yi9leVJHcWxDL0UveHpsUTN6eDFqVjV2dVpnRnlxQ3Vlc0J6QktJWEdZYTZQ?=
 =?utf-8?B?YVNQbitXYXEzcjM0QTZjbjYzNnJpYWpmL1hLdmJJOVhuMTN4WFQ0WnhxT2VY?=
 =?utf-8?B?cHp2Y2tlMThCaGdvdUhBb3hEeU1JbW85SjZHYU1MVllJTUlzeVM2cEEwbWJK?=
 =?utf-8?B?TjJVN05HZkhpdCt1L2tiWnpJSnY1YnNzaC85blVOdG9NWFNCeGszY3d1THVo?=
 =?utf-8?B?Q2l5ZHBocnFVeklhaHJRbWRTMW10Mjg3Rld3S3I3NEJuRTYxcUw1TVpPbTQ3?=
 =?utf-8?B?bVlBdVhzRjMxQzR0bGJzLzlBRVI4UzJ6VXBEcmZoVkNtR0x5NnNXWUkwTUpi?=
 =?utf-8?B?S0UvQkdIay9qOTJXMGw0RVRyL3NObSs4QXZyWlIxWDZGMThUaFdOZTRPR2xS?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B98453420FCC94CAC9DF0A1DFE881AA@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9392.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97e1587-7d86-4535-3694-08dc2b12dfbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2024 15:05:24.2681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: obYVB9YJ2p4IWR8Otfcn7TkNCKq7Qd4Ym7yqwldHzCRJSNyuRoi4Nr9PJf3YQAxFecixv2EQTuRhSqXH+xcvnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7385
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240211_070534_605719_F3492AE6 
X-CRM114-Status: UNSURE (   6.15  )
X-CRM114-Notice: Please train this message.
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

SGkgYWxsLA0KDQpXZSBmYWlsZWQgdG8gZW5hYmxlIFRMUyBvdmVyIFRDUCB3aXRoIHRoZSBsYXRl
c3QgNi44LXJjMyBmcm9tIHVwc3RyZWFtLg0KV2UgaGF2ZSBmb2xsb3dlZCB0aGUgZ3VpZGVsaW5l
cyBvdXRsaW5lZCBpbiBodHRwczovL2x3bi5uZXQvQXJ0aWNsZXMvOTQxMTM5Ly4NClRoZSBOVk1l
IGNvbm5lY3Rpb24gZmFpbGVkIHBvc3QtYXV0aGVudGljYXRpb24NCg0KVGhlIHN0ZXBzIGFuZCB0
aGUgb3V0cHV0cyBmcm9tIHRoZSBwcm9jZXNzOiAgDQojIFRhcmdldCBjcmVhdGlvbg0KbW9kcHJv
YmUgbnZtZXQtdGNwDQpta2RpciAvc3lzL2tlcm5lbC9jb25maWcvbnZtZXQvcG9ydHMvMTANCmVj
aG8gLW4gIjEyNy4wLjAuMSIgPiAvc3lzL2tlcm5lbC9jb25maWcvbnZtZXQvcG9ydHMvMTAvYWRk
cl90cmFkZHINCmVjaG8gLW4gaXB2NCA+IC9zeXMva2VybmVsL2NvbmZpZy9udm1ldC9wb3J0cy8x
MC9hZGRyX2FkcmZhbQ0KZWNobyAtbiB0Y3AgPiAvc3lzL2tlcm5lbC9jb25maWcvbnZtZXQvcG9y
dHMvMTAvYWRkcl90cnR5cGUNCmVjaG8gLW4gNDQyMCA+IC9zeXMva2VybmVsL2NvbmZpZy9udm1l
dC9wb3J0cy8xMC9hZGRyX3Ryc3ZjaWQNCmVjaG8gdGxzMS4zID4gL3N5cy9rZXJuZWwvY29uZmln
L252bWV0L3BvcnRzLzEwL2FkZHJfdHNhcw0KbWtkaXIgL3N5cy9rZXJuZWwvY29uZmlnL252bWV0
L3N1YnN5c3RlbXMvbnFuLnRlc3QNCmVjaG8gMSA+IC9zeXMva2VybmVsL2NvbmZpZy9udm1ldC9z
dWJzeXN0ZW1zL25xbi50ZXN0L2F0dHJfYWxsb3dfYW55X2hvc3QNCm1rZGlyIC9zeXMva2VybmVs
L2NvbmZpZy9udm1ldC9zdWJzeXN0ZW1zL25xbi50ZXN0L25hbWVzcGFjZXMvMQ0KZWNobyAiL2Rl
di9udm1lMW4xIiA+IC9zeXMva2VybmVsL2NvbmZpZy9udm1ldC9zdWJzeXN0ZW1zL25xbi50ZXN0
L25hbWVzcGFjZXMvMS9kZXZpY2VfcGF0aA0KZWNobyAxID4gL3N5cy9rZXJuZWwvY29uZmlnL252
bWV0L3N1YnN5c3RlbXMvbnFuLnRlc3QvbmFtZXNwYWNlcy8xL2VuYWJsZQ0KbG4gLXMgL3N5cy9r
ZXJuZWwvY29uZmlnL252bWV0L3N1YnN5c3RlbXMvbnFuLnRlc3QgL3N5cy9rZXJuZWwvY29uZmln
L252bWV0L3BvcnRzLzEwL3N1YnN5c3RlbXMvDQogICMgQ3JlYXRlIGtleXMgYW5kIHN0YXJ0IHRo
ZSB0bHNoZCBzZXJ2aWNlOg0KbW9kcHJvYmUgbnZtZS10Y3ANCm52bWUgZ2VuLXRscy1rZXkgLS1z
dWJzeXNucW49bnFuLnRlc3QgLWkNCm52bWUgZ2VuLXRscy1rZXkgLS1zdWJzeXNucW49bnFuLjIw
MTQtMDgub3JnLm52bWV4cHJlc3MuZGlzY292ZXJ5IC1pDQojdGxzaGQgLWMgL2V0Yy90bHNoZC5j
b25mDQpzeXN0ZW1jdGwgc3RhcnQgdGxzaGQuc2VydmljZQ0KbnZtZSBjb25uZWN0IC10IHRjcCAt
YSAxMjcuMC4wLjEgLXMgNDQyMCAtbiBucW4udGVzdCAtLXRscw0KDQotLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCg0KIyBPdXRjb21lIG9mIGVuYWJsaW5nIFRMUyBvdmVyIFRDUCDigJMgV2hpbGUg
YXV0aGVudGljYXRpb24gc3VjY2VlZGVkIGFzIGV4cGVjdGVkLA0Kd2UgZW5jb3VudGVyZWQgYW4g
aXNzdWUgd2hlcmUgdGhlIE5WTWUgY29ubmVjdGlvbiBmYWlsZWQ6DQoNCnJvb3RAaXAtMTAtMC00
MC0xNTE6fi93b3JrIyBudm1lIGxpc3Qtc3Vic3lzDQpudm1lLXN1YnN5czIgLSBOUU49bnFuLnRl
c3QNCiAgICAgICAgICAgICAgIGhvc3RucW49bnFuLjIwMTQtMDgub3JnLm52bWV4cHJlc3M6dXVp
ZDplYzIwY2UxNS1hYzYxLWQxZDMtMGIyZS1kY2YzOTBiMDUxMzMNCiAgICAgICAgICAgICAgIGlv
cG9saWN5PW51bWENClwNCistIG52bWUyIHRjcCB0cmFkZHI9MTI3LjAuMC4xLHRyc3ZjaWQ9NDQy
MCBjb25uZWN0aW5nICBudm1lLXN1YnN5czEgLSBOUU49bnFuOjIwMDgtMDguY29tLmFtYXpvbi5h
d3M6ZWJzOnZvbDBhZGE0YWI4OWNiZWVjNmE4DQogICAgICAgICAgICAgICBob3N0bnFuPW5xbi4y
MDE0LTA4Lm9yZy5udm1leHByZXNzOnV1aWQ6ZWMyMGNlMTUtYWM2MS1kMWQzLTBiMmUtZGNmMzkw
YjA1MTMzDQogICAgICAgICAgICAgICBpb3BvbGljeT1udW1hDQpcDQorLSBudm1lMSBwY2llIDAw
MDA6MDA6MWYuMCBsaXZlDQpudm1lLXN1YnN5czAgLSBOUU49bnFuOjIwMDgtMDguY29tLmFtYXpv
bi5hd3M6ZWJzOnZvbDA4NjdlNjVjYWFhN2NiOGNhDQogICAgICAgICAgICAgICBob3N0bnFuPW5x
bi4yMDE0LTA4Lm9yZy5udm1leHByZXNzOnV1aWQ6ZWMyMGNlMTUtYWM2MS1kMWQzLTBiMmUtZGNm
MzkwYjA1MTMzDQogICAgICAgICAgICAgICBpb3BvbGljeT1udW1hDQpcDQorLSBudm1lMCBwY2ll
IDAwMDA6MDA6MDQuMCBsaXZlDQoNCiMgVGhlIGluaXRpYXRvciBzeXNsb2c6DQpGZWIgIDUgMTY6
MTc6MzYgaXAtMTAtMC00MC0xNTEga2VybmVsOiBbIDIwNjcuNDk2NzYxXSBudm1ldDogY3JlYXRp
bmcgbnZtIGNvbnRyb2xsZXIgMSBmb3Igc3Vic3lzdGVtIG5xbi50ZXN0IGZvciBOUU4gbnFuLjIw
MTQtMDgub3JnLm52bWV4cHJlc3M6dXVpZDplYzIwY2UxNS1hYzYxLWQxZDMtMGIyZS1kY2YzOTBi
MDUxMzMuDQpGZWIgIDUgMTY6MTc6MzYgaXAtMTAtMC00MC0xNTEga2VybmVsOiBbIDIwNjcuNDk3
NzUxXSBudm1lIG52bWUyOiBjcmVhdGluZyAzMiBJL08gcXVldWVzLg0KRmViICA1IDE2OjE3OjM2
IGlwLTEwLTAtNDAtMTUxIGtlcm5lbDogWyAyMDY3LjY0Njg1MV0gbnZtZSBudm1lMjogbWFwcGVk
IDMyLzAvMCBkZWZhdWx0L3JlYWQvcG9sbCBxdWV1ZXMuDQpGZWIgIDUgMTY6MTc6MzYgaXAtMTAt
MC00MC0xNTEga2VybmVsOiBbIDIwNjcuNjQ3MTA1XSBudm1lIG52bWUyOiBTdWNjZXNzZnVsbHkg
cmVjb25uZWN0ZWQgKDEgYXR0ZW1wdCkNCkZlYiAgNSAxNjoxNzo0MyBpcC0xMC0wLTQwLTE1MSBr
ZXJuZWw6IFsgMjA3NS4wNzY5MjddIG52bWUgbnZtZTI6IEkvTyB0YWcgMCAoYTAwMCkgdHlwZSA0
IG9wY29kZSAweDE4IChBZG1pbiBDbWQpIFFJRCAwIHRpbWVvdXQNCkZlYiAgNSAxNjoxNzo0MyBp
cC0xMC0wLTQwLTE1MSBrZXJuZWw6IFsgMjA3NS4wNzY5NDBdIG52bWUgbnZtZTI6IHN0YXJ0aW5n
IGVycm9yIHJlY292ZXJ5DQpGZWIgIDUgMTY6MTc6NDMgaXAtMTAtMC00MC0xNTEga2VybmVsOiBb
IDIwNzUuMDc4ODk5XSBudm1lIG52bWUyOiBmYWlsZWQgbnZtZV9rZWVwX2FsaXZlX2VuZF9pbyBl
cnJvcj0xMA0KRmViICA1IDE2OjE3OjQzIGlwLTEwLTAtNDAtMTUxIGtlcm5lbDogWyAyMDc1LjA4
MDY4Ml0gbnZtZSBudm1lMjogcmVhZGluZyBub24tbWR0cy1saW1pdHMgZmFpbGVkOiAtNA0KRmVi
ICA1IDE2OjE3OjQzIGlwLTEwLTAtNDAtMTUxIGtlcm5lbDogWyAyMDc1LjA5Mjc0OF0gbnZtZSBu
dm1lMjogUmVjb25uZWN0aW5nIGluIDEwIHNlY29uZHPigKYNCiAgIyB0bHNoZCBjb25maWd1cmF0
aW9uOg0KW2F1dGhlbnRpY2F0aW9uXQ0Ka2V5cmluZ3MgPSAubnZtZQ0KW2RlYnVnXQ0KbG9nbGV2
ZWw9MjU1DQp0bHM9MjU1DQoNCldlIHdvdWxkIGdyZWF0bHkgYXBwcmVjaWF0ZSB5b3VyIGFzc2lz
dGFuY2Ugd2l0aCB0aGlzIG1hdHRlci4gWW91ciByZXNwb25zZQ0Kd291bGQgYmUgaGlnaGx5IHZh
bHVlZC4NCg0KVGhhbmtzLA0KTmlyIFJpZ2FpICAgICA=

