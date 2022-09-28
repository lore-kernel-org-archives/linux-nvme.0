Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE261C04A95
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 12:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/p7eBnSuwbOU0Jxdx0h32rFspMbeSIeNS/ewF4Pc/KA=; b=RXXc7SerUsFkzNufzV8UlJSkd5
	pEmvzO4s7FtToDYYG/10IUy0zTgx2DaS7RYEtMaJlSkP5vPKVT/MQnEZ1YQnYPXMsnWVs6nb0YPFL
	Zby/yNu08Vp09qS+thtehsV2tHbPoI38X9/jHQM9tsm+v+WFbcAE0Nw8eyMFOxukadJPqaXwlN8UU
	tT78cH6VNClgHV1BJdDe2POOdTDZRdkfokzrhj29ISvPs6qxnfTfuPw8gZ0cW+dFXwzsYjVOmJb6I
	XHseF0odyBRalB5M3ZqbBni+fb7CCSe0DEg08Mibf1EcuXP9TXpfb+pvqAGaz5x+qZ3nwssw/NTQt
	DjeszI8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odWLx-00GIMe-PP; Wed, 28 Sep 2022 12:39:53 +0000
Received: from mail-bn7nam10on2050.outbound.protection.outlook.com ([40.107.92.50] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odWLu-00GILy-JP
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 12:39:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8w6dw3O33AQKFI/99CTxm8nQY9jUY92PgJT3GGL7e8sXvifVBehdLV4dEA+T9jr36HqOU1HeNeSaVbik586UcuoGecxltxeJuuyVOqrcWaLREAiybjaxQVdbigD4IYTzUvkd/FdcnMHFAnAimmwEzTsDkEK5ewy95lZcvAlhhJb5Gi3ebPsfBk1X/vuzBVrV1sjUmyL7jO3vYk5lafpYYG1NK3iF3+1soMc44CmV4T90Z8zUbK5iUqTGEf+MxXcAW+hgPnLl9usXgfP5OHwcchgKP4TbIGUIDjcNHks7sKwT3jlEdidxQFY9x8IQG4nLvDTuW3etCHgkxAj/cFE7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/p7eBnSuwbOU0Jxdx0h32rFspMbeSIeNS/ewF4Pc/KA=;
 b=m9ACd9qLgBvF3R+GVYxYlfB9RTH7uvFZCTjUgm49Y/dvahPLcQh7U6EMZ8vDFGBtNCNyiyn7WbM0PSSrctKjUeXMlyw24WVBHmfsmgT+dlrBKBPsr1IOVHAOa2/exSHD4lq4TH9U3KqZN6pDuLII/usyMyak1S+AkRQSmoha6TZgggfi/frwVT2bwkVKAYDieowq8nofgxIULfIO0+hmyKY0duoGfTQ5d+n/gqLErlQaVprB1h52yx7Xr8N2/HuDwiswN1nDTQDA2TaL0D7FPTB893g65F92ai5DYSDLSb2C3QZXjkcrGOkPJeFca+nJI+UT0SURnkH0kdygHToEtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/p7eBnSuwbOU0Jxdx0h32rFspMbeSIeNS/ewF4Pc/KA=;
 b=fO7WXtKlPFoSV9qAUvIkwpkLqD+c6b0pocGAmfs01MqNJlycf1I5vQGP/HqskiyNbu4ZM3OXBPPu657qclAKkPPh2Ib/0OOuhlePV2o0ofEjDXBbW6YQbo1KRHpFnoXzRTfrI1wPWACGz7sx9e3mITLkpjp/SU4OPTIYGQJ3dmBzReSnyNPphIqCaN+cHLYGeJy1c2NaSctwQeiqIYSeuqF8IiNU0/H0AQpE7CxI1eaH6UHq2juUPOTelQe5ZfS0ymRI3y5nWvZmbzSmxdNY0U5ANVcIAN7f+KV/MsIFkXzzuPZbokQmxvpKw0n3DNIehbQcglKGGLnlVk7Fn5L4VQ==
Received: from DM8PR06MB7704.namprd06.prod.outlook.com (2603:10b6:8:32::16) by
 MN2PR06MB6527.namprd06.prod.outlook.com (2603:10b6:208:203::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.26; Wed, 28 Sep 2022 12:39:44 +0000
Received: from DM8PR06MB7704.namprd06.prod.outlook.com
 ([fe80::29cf:1ad7:d52b:6f9f]) by DM8PR06MB7704.namprd06.prod.outlook.com
 ([fe80::29cf:1ad7:d52b:6f9f%3]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 12:39:44 +0000
From: "Knight, Frederick" <Frederick.Knight@netapp.com>
To: Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, "hare@suse.de"
	<hare@suse.de>
Subject: RE: [PATCH v2] nvmet: force reconnect when number of queue changes
Thread-Topic: [PATCH v2] nvmet: force reconnect when number of queue changes
Thread-Index: AQHY0xkW0CvFgvGYC0OqpzqIUZQ+Z630t3Bw
Date: Wed, 28 Sep 2022 12:39:44 +0000
Message-ID:  <DM8PR06MB7704C17B1DF832A432024BE2F1549@DM8PR06MB7704.namprd06.prod.outlook.com>
References: <20220927143157.3659-1-dwagner@suse.de>
 <d151b0c1-d28e-faeb-03d4-ed28b9768ee2@grimberg.me>
 <20220928074850.h6rwvwgz2oje3ebg@carbon.lan>
 <f1909450-1435-9661-056f-b955d6089ca7@grimberg.me>
 <20220928090243.c4ctbj2frydwsfav@carbon.lan>
In-Reply-To: <20220928090243.c4ctbj2frydwsfav@carbon.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.600.2
dlp-product: dlpe-windows
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netapp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR06MB7704:EE_|MN2PR06MB6527:EE_
x-ms-office365-filtering-correlation-id: 1e0c7341-0c2d-4df7-3cea-08daa14e8595
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  sQcptDjXOT33w9yZONJWRYMw0WvPhnjOsolqYD7cs1ikaEJnwgSYeBm3gXo0GBLqnTatfb/HaQXpI8Q/0MRca2A4mmn1952QjtAgVhMObgg9bUWVklX+ABFfhksYnH5Y5j3s2YLy7LEdseVfBJyOPXV7lAsa/uHr7WSAPsKZcnBfyCQwsY0mLSNBTEYpVn8TZTkjj1gXxc0Sgin6aAbuoN+WLqEtAch5DKp2V0fZr9krtDM4GUIpipmyXadqZR+yJIcrVl0LhKIcWv7rer2L//Hp3wjbvyNTQYkBiucNX/AsU9FapD/BZnyu+/zRfgA1Z5s0n9Pr6vG+ewl13rcKwNIdO7TAXtmIcORG63mC+nx3GlcIjp999hp5Jha+a9tQ2VYHITz50UbCZqDnfV+Sa4iDJKLw0Wcd0FZriJM214KVS7gkBkvQ4w20jF6EGdSvwFC+pgjWbPtfhL0sdktweXFwAvS38MxwZw9/fWUc2bxvKYGfOBfFJkestBijBReu4tXGHYbxSUKm2KTW/iv6YKFQDEIMDypViZSCXHJtOisyX752PYL0H5FmpcX16ohyf1wxf5Sm445tD88+49c9lMNc9/wsDJL1NjrhY0WOddoi26qenMRisJIy4oGoO9DElrtDxrMOfRyjtn0OyRS2za9go+y+7syqdG0BJbHWvRnucp/aSjHgGplQ1cd4de1VW321kL87yD4CfGSwTKHxGWPFNu3nhRe8+5SthZ7Wkcgs4lWV8MLVQAOGZjELCpf0IPM1pkG09+cQmQtYyQpfzg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR06MB7704.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199015)(8936002)(38100700002)(52536014)(2906002)(4326008)(5660300002)(86362001)(71200400001)(478600001)(41300700001)(66556008)(55016003)(66946007)(9686003)(8676002)(66476007)(66446008)(76116006)(6506007)(33656002)(53546011)(26005)(64756008)(7696005)(38070700005)(186003)(54906003)(110136005)(122000001)(316002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?bjE1Q0RVaHRxL3kxVzh5MHlVeDFGK0xySnVIa21BbG1oRUttZEt0Qi9FUnBP?=
 =?utf-8?B?Z0hSeWZLMDl2K01FWEtHWVorUnkxS0tkaXFjRDUyczlIOU5DbEZxNGxRTmt2?=
 =?utf-8?B?UDZWcThyYnRFUlpDUnRKdmJwdHh3MkNycHhMOU9BeFdFbUsvd0NkRER5NWt5?=
 =?utf-8?B?cGFEOXMyOUM4K0FuajloVHo4TEF0RkJrN2ZZT0xNSGZEVWFzYU8yYXNGVVFz?=
 =?utf-8?B?REUxWDAxb2dnZGtBQmRDSFVQOVNvQVZFZU1kaWZObXJqa2JZeDhvYzMrVDYr?=
 =?utf-8?B?MER3aFJESFVPS1V1YUl4L2FzdXZvL1h6RS9QZ0dtemZtRHVETUtBZjBsR1o0?=
 =?utf-8?B?b0R1bjBLQlZVRE9semJMU3hiSm54MzFocG9raGVZQ1REdzFuVjRxWE12SW9m?=
 =?utf-8?B?NVloUFNIemU2ZTR3OEVIc3BlYzduSUxXbnJ3MWJ4VklXZElsQkVZWDVac1RW?=
 =?utf-8?B?SXlPeDFCV291QTFKQ0xEM1A4cldpbFB5TDJTSmpsVDRuR1lCcUtiMWY3UHU4?=
 =?utf-8?B?aC94ZHNSamdOUFNodHg4emxzTFN1OGpKWnpMWG11Z25Ba0hUQ2ZEbnVLekhp?=
 =?utf-8?B?U0U3M2J6S2tZYmNERkZrYjNyQkU0NG9zTzZURmorZkJkUW1QaEJiNlhjeFFJ?=
 =?utf-8?B?dWh2eTltc3E4ZWkxZFlVTDdhcG5yRkNYZEVIOVVSQkJRV25ITkZYWWVDbE83?=
 =?utf-8?B?eGRHR1JsTzNJY0gyVFZJWGo2NFhzWmRUQzJkdVEweWpBYU45aFNoNTNubXBn?=
 =?utf-8?B?cTFlbGJ0dFUrWkRCWnJWbERVSUg2Szg0Qm5Zdm5pcHFxemFQNkUrU3M4d1BO?=
 =?utf-8?B?K3JwODlFeFE3WVBhUjFYc3VjQ3VFWUF4aTN6WlY5OWJkamIxNnA2VjQ5Qm8z?=
 =?utf-8?B?U0R0TDBmam00bndZSmg0MXB4b2NmSklkWGxYY2JxL2hRM2Fndm0ySmh1Sk1o?=
 =?utf-8?B?QWlJTVN1YmtwQWRiL1lsMWczVXVYQ01KTnQ4aW5PaFlFb3FOY2FUSTdTOWYw?=
 =?utf-8?B?TTJQZjlBbGZZZ3FFM2NaeFc0Njk2YWNwNFNGbEMzelo3Mm5IbXlXL21NZU5z?=
 =?utf-8?B?enBUanpob2x5aXVKRG4zMHE2UmNCUkpKaytVcUFqazdyYzN1OVEvUm0venpr?=
 =?utf-8?B?Nng0eTVjc1Y4VTQ0QWlDWDlPZGZKTkRKeUE5aXluSHhGRlNMUlE4WU9uazQ0?=
 =?utf-8?B?b2p4T2dSV2VOQU1XTjJnTzg4bnRFZHlJUUt2ZGwya0dBay9ubTh2a2lxOHZI?=
 =?utf-8?B?MWtNWWZuMlBiWDh0ZnVJai9PZVFPTXVZLzlsMVZxQSs4THdRSGU2NmhNdGxJ?=
 =?utf-8?B?NTczd3hmVDZ3OEZ3TkNvSzlXditMdkdSSHdBREJaY0xjSlpRWGVKdGRkNjVi?=
 =?utf-8?B?VldpYkI5VUxaQUM1dG9LWjVKem1FNGFpUStPSkZnSFdDMSs1ak41cTB5eGRs?=
 =?utf-8?B?TG9MOUpXeERwRy90bzBYekRzcDRMTG5XVTZ1TzlvYkwxcFVuNUhDallKRGt0?=
 =?utf-8?B?bGNWMmJOU2w2ekY2Wk5RNDBTYXVSRExNemh4OWRJN0JJNUxuRnVvcEV1RWZP?=
 =?utf-8?B?c1FUNkttVWNyUTdzTXZaMmJ4b2NJT2FtMElFdUlVdUlGYWdKUG5aZWtFS01E?=
 =?utf-8?B?MVZwWUNadjl1ckhNSTZ1SWNrK0Z4ZWliRlpET0d4U3E0Z2o2SzVNQ2lGSXRI?=
 =?utf-8?B?dkVSYzlPR1pTMlUrbW5RSG1yTVNtMkJWMWlqZHFJbEZiMXlaSEJlMkhWS2Yx?=
 =?utf-8?B?WG1zdU1mUkM4dTBsVS9TUTRBNzBBckVtQjZSL2FVOTN3OGJRWURvV2tRZzVG?=
 =?utf-8?B?YVo4UzJibjdpZG80ZTQ5NXBzd21qa3JZRGNSblQ4WVN2VmJoVVIyd1ZWSWM0?=
 =?utf-8?B?RmtJVHZNR3c0Um91YUhzZ0N1cjNGU0hFVVhMVThVQ3lFL0doWXQwZFVSNDFC?=
 =?utf-8?B?RlhYbCtIM0syQVlaTkJoMjNsNXVwNFYxME9mWVlxMEduVHRKVWlPSy9wM253?=
 =?utf-8?B?Nm5hbHFMamFBVlZYbzZDdGd4M2YxZ1pmcG5PcGRzby9tOTlCUUZlcG5lS21o?=
 =?utf-8?B?Qk01UURkTUE1MkVpTkwzTWZYSzJIV2daenN1Z0FOZlgxSlZ3V3k4RjBROTk2?=
 =?utf-8?Q?dU+A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR06MB7704.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0c7341-0c2d-4df7-3cea-08daa14e8595
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 12:39:44.6392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C1bXdXILS5dCRuGSv4/GhTFbnBRH/Sx8/31V+HRgCzpEXopwqEbeIjqZfrqRPwFQUAP/hJIIBq08QOVDXK9ngQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR06MB6527
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_053950_962038_7A763A5B 
X-CRM114-Status: GOOD (  49.41  )
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

V291bGQgdGhpcyBiZSBhIGNhc2UgZm9yIGEgbmV3IEFFTiAtIGNvbnRyb2xsZXIgY29uZmlndXJh
dGlvbiBjaGFuZ2VkPyAgSSdtIGFsc28gd29uZGVyaW5nIGV4YWN0bHkgd2hhdCBjaGFuZ2VkIGlu
IHRoZSBjb250cm9sbGVyPyAgSXQgY2FuJ3QgYmUgdGhlICJOdW1iZXIgb2YgUXVldWVzIiBmZWF0
dXJlICh0aGF0IGNhbid0IGNoYW5nZSAtIFRoZSBjb250cm9sbGVyIHNoYWxsIG5vdCBjaGFuZ2Ug
dGhlIHZhbHVlIGFsbG9jYXRlZCBiZXR3ZWVuIHJlc2V0cy4pLiAgSXMgaXQgdGhlIE1RRVMgZmll
bGQgaW4gdGhlIENBUCBwcm9wZXJ0eSB0aGF0IGNoYW5nZXMgKHF1ZXVlIHNpemUpPw0KDQpXZSBh
bHJlYWR5IGhhdmUgY2hhbmdlIHJlcG9ydGluZyBmb3I6IE5hbWVzcGFjZSBhdHRyaWJ1dGUsIFBy
ZWRpY3RhYmxlIExhdGVuY3ksIExCQSBzdGF0dXMsIEVHIGFnZ3JlZ2F0ZSwgWm9uZSBkZXNjcmlw
dG9yLCBEaXNjb3ZlcnkgTG9nLCBSZXNlcnZhdGlvbnMuIFdlJ3ZlIHF1ZXN0aW9uZWQgd2hldGhl
ciB3ZSBuZWVkIGEgQ29udHJvbGxlciBBdHRyaWJ1dGUgQ2hhbmdlZC4NCg0KV291bGQgdGhpcyBi
ZSBhIGNhc2UgZm9yIGFuIGV4Y2VwdGlvbj8gIERvZXMgdGhlIEROUiBiaXQgYXBwbHkgb25seSB0
byBjb21tYW5kcyBzZW50IG9uIHF1ZXVlcyB0aGF0IGFscmVhZHkgZXhpc3QgKGkuZS4sIE5PVCB0
aGUgY29ubmVjdCBjb21tYW5kIHNpbmNlIHRoYXQgY29tbWFuZCBpcyBhY3R1YWxseSBjcmVhdGlu
ZyB0aGUgcXVldWUpPyAgRldJVyAtIEkgZG9uJ3QgbGlrZSBleGNlcHRpb25zLg0KDQpDYW4geW91
IGVsYWJvcmF0ZSBvbiBleGFjdGx5IHdoYXQgaXMgY2hhbmdpbmc/DQoNCglGcmVkDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIFdhZ25lciA8ZHdhZ25lckBz
dXNlLmRlPg0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyOCwgMjAyMiA1OjAzIEFNDQo+
IFRvOiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KPiBDYzogbGludXgtbnZtZUBs
aXN0cy5pbmZyYWRlYWQub3JnOyBTaGluaWNoaXJvIEthd2FzYWtpDQo+IDxzaGluaWNoaXJvLmth
d2FzYWtpQHdkYy5jb20+OyBoYXJlQHN1c2UuZGU7IEtuaWdodCwgRnJlZGVyaWNrDQo+IDxGcmVk
ZXJpY2suS25pZ2h0QG5ldGFwcC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIG52bWV0
OiBmb3JjZSByZWNvbm5lY3Qgd2hlbiBudW1iZXIgb2YgcXVldWUNCj4gY2hhbmdlcw0KPiANCj4g
TmV0QXBwIFNlY3VyaXR5IFdBUk5JTkc6IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIERvIG5v
dCBjbGljayBsaW5rcyBvcg0KPiBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXpl
IHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMNCj4gc2FmZS4NCj4gDQo+IA0KPiAN
Cj4gDQo+IE9uIFdlZCwgU2VwIDI4LCAyMDIyIGF0IDExOjMxOjQzQU0gKzAzMDAsIFNhZ2kgR3Jp
bWJlcmcgd3JvdGU6DQo+ID4NCj4gPiA+ID4gPiBJbiBvcmRlciB0byBiZSBhYmxlIHRvIHRlc3Qg
cXVldWUgbnVtYmVyIGNoYW5nZXMgd2UgbmVlZCB0byBtYWtlDQo+ID4gPiA+ID4gc3VyZSB0aGF0
IHRoZSBob3N0IHJlY29ubmVjdHMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGUgaW5pdGlhbCBp
ZGVhIHdhcyB0byBkaXNhYmxlIGFuZCByZS1lbmFibGUgdGhlIHBvcnRzIGFuZCBoYXZlDQo+ID4g
PiA+ID4gdGhlIGhvc3QgdG8gd2FpdCB1bnRpbCB0aGUgS0FUTyB0aW1lciBleHBpcmVzIGFuZCBl
bnRlciBlcnJvcg0KPiA+ID4gPiA+IHJlY292ZXJ5LiBCdXQgaW4gdGhpcyBzY2VuYXJpbyB0aGUg
aG9zdCBjb3VsZCBzZWUgRE5SIGZvciBhDQo+ID4gPiA+ID4gY29ubmVjdGlvbiBhdHRlbXB0IHdo
aWNoIHJlc3VsdHMgaW4gdGhlIGhvc3QgZHJvcHBpbmcgdGhlIGNvbm5lY3Rpb24NCj4gY29tcGxl
dGVseS4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFdlIGNhbiBmb3JjZSB0byByZWNvbm5lY3QgdGhl
IGhvc3QgYnkgZGVsZXRpbmcgYWxsIGNvbnRyb2xsZXJzDQo+ID4gPiA+ID4gY29ubmVjdGVkIHRv
IHN1YnN5c3RlbSwgd2hpY2ggcmVzdWx0cyB0aGUgaG9zdCBvYnNlcnZpbmcgYQ0KPiA+ID4gPiA+
IGZhaWxpbmcgY29tbWFuZCBhbmQgdHJpZXMgdG8gcmVjb25uZWN0Lg0KPiA+ID4gPg0KPiA+ID4g
PiBUaGlzIGxvb2tzIGxpa2UgYSBjaGFuZ2UgdGhhdCBhdHRlbXB0cyB0byBmaXggYSBob3N0IGlz
c3VlIGZyb20NCj4gPiA+ID4gdGhlIHRhcmdldCBzaWRlLi4uIFdoeSBkbyB3ZSB3YW50IHRvIGRv
IHRoYXQ/DQo+ID4gPg0KPiA+ID4gSXQncyBub3QgYSBob3N0IGlzc3VlIGF0IGFsbC4gVGhlIHNj
ZW5hcmlvIEknZCBsaWtlIHRvIHRlc3QgYSB3aGVuDQo+ID4gPiB0YXJnZXQgY2hhbmdlcyB0aGlz
IHByb3BlcnR5IHdoaWxlIHRoZSBob3N0IGlzIGNvbm5lY3RlZCAoZS5nLg0KPiA+ID4gc29mdHdh
cmUgdXBkYXRlZCAtPiBuZXcgY29uZmlndXJhdGlvbikuIEkgaGF2ZW4ndCBmb3VuZCBhIHdheSB0
bw0KPiA+ID4gc2lnbmFsIHRoZSBob3N0IHRvIHJlc2V0L3JlY29ubmVjdCBmcm9tIHRoZSB0YXJn
ZXQuIEhhbm5lcyBzdWdnZXN0ZWQNCj4gPiA+IHRvIGRlbGV0ZSBhbGwgY29udHJvbGxlcnMgZnJv
bSB0aGUgZ2l2ZW4gc3Vic3lzdGVtIHdoaWNoIHdpbGwNCj4gPiA+IHRyaWdnZXIgdGhlIHJlY292
ZXJ5IHByb2Nlc3Mgb24gdGhlIGhvc3Qgb24gdGhlIG5leHQgcmVxdWVzdC4gVGhpcyBtYWtlcw0K
PiB0aGlzIHRlc3Qgd29yay4NCj4gPg0KPiA+IEJ1dCB0aGF0IGlzIGV4YWN0bHkgbGlrZSBkb2lu
ZzoNCj4gPiAtIHJlbW92ZSBzdWJzeXN0ZW0gZnJvbSBwb3J0DQo+ID4gLSBhcHBseSBxIGNvdW50
IGNoYW5nZQ0KPiA+IC0gbGluayBzdWJzeXN0ZW0gdG8gcG9ydA0KPiA+DQo+ID4gWW91ciBwcm9i
bGVtIGlzIHRoYXQgdGhlIHRhcmdldCByZXR1cm5zIGFuIGVycm9yIGNvZGUgdGhhdCBtYWtlcyB0
aGUNCj4gPiBob3N0IHRvIG5ldmVyIHJlY29ubmVjdC4gVGhhdCBpcyBhIGhvc3QgYmVoYXZpb3Is
IGFuZCB0aGF0IGJlaGF2aW9yIGlzDQo+ID4gZGlmZmVyZW50IGZyb20gZWFjaCB0cmFuc3BvcnQg
dXNlZC4NCj4gDQo+IFllcywgSSB0cnkgdG8gYXZvaWQgdG8gdHJpZ2dlciB0aGUgRE5SLg0KPiAN
Cj4gPiBUaGlzIGlzIHdoeSBJJ20gbm90IGNsZWFyIG9uIHdlYXRoZXIgdGhpcyBpcyB0aGUgcmln
aHQgcGxhY2UgdG8NCj4gPiBhZGRyZXNzIHRoaXMgaXNzdWUuDQo+ID4NCj4gPiBJIHBlcnNvbmFs
bHkgZG8gbm90IHVuZGVyc3RhbmQgd2h5IGEgRE5SIGNvbXBsZXRpb24gbWFrZXMgdGhlIGhvc3QN
Cj4gPiBjaG9vc2UgdG8gbm90IHJlY29ubmVjdC4gRE5SIG1lYW5zICJkbyBub3QgcmV0cnkiIGZv
ciB0aGUgY29tbWFuZA0KPiA+IGl0c2VsZiAod2hpY2ggdGhlIGhvc3QgYWRoZXJlcyB0byksIGFu
ZCBpdCBkb2VzIG5vdCBoYXZlIGFueSBtZWFuaW5nDQo+ID4gdG8gYSByZXNldC9yZWNvbm5lY3Qg
bG9naWMuDQo+IA0KPiBJIGFtIGp1c3QgdGhlIG1lc3NlbmdlcjogQmVzaWRlcyBIYW5uZXMnIG9i
amVjdGlvbiBpbiB0aGUgbGFzdCBtYWlsIHRocmVhZCwgSQ0KPiBnb3QgdGhpcyBwcml2YXRlIHJl
cGx5IGZyb20gRnJlZCBLbmlnaHQ6DQo+IA0KPiAgICBEbyBOb3QgUmV0cnkgKEROUik6IElmIHNl
dCB0byDigJgx4oCZLCBpbmRpY2F0ZXMgdGhhdCBpZiB0aGUgc2FtZSBjb21tYW5kIGlzDQo+ICAg
IHJlLXN1Ym1pdHRlZCB0byBhbnkgY29udHJvbGxlciBpbiB0aGUgTlZNIHN1YnN5c3RlbSwgdGhl
biB0aGF0DQo+ICAgIHJlLXN1Ym1pdHRlZCBjb21tYW5kIGlzIGV4cGVjdGVkIHRvIGZhaWwuIElm
IGNsZWFyZWQgdG8g4oCYMOKAmSwgaW5kaWNhdGVzDQo+ICAgIHRoYXQgdGhlIHNhbWUgY29tbWFu
ZCBtYXkgc3VjY2VlZCBpZiByZXRyaWVkLiBJZiBhIGNvbW1hbmQgaXMgYWJvcnRlZA0KPiAgICBk
dWUgdG8gdGltZSBsaW1pdGVkIGVycm9yIHJlY292ZXJ5IChyZWZlciB0byB0aGUgRXJyb3IgUmVj
b3Zlcnkgc2VjdGlvbg0KPiAgICBpbiB0aGUgTlZNIENvbW1hbmQgU2V0IFNwZWNpZmljYXRpb24p
LCB0aGlzIGJpdCBzaG91bGQgYmUgY2xlYXJlZCB0bw0KPiAgICDigJgw4oCZLiBJZiB0aGUgU0NU
IGFuZCBTQyBmaWVsZHMgYXJlIGNsZWFyZWQgdG8gMGgsIHRoZW4gdGhpcyBiaXQgc2hvdWxkIGJl
DQo+ICAgIGNsZWFyZWQgdG8g4oCYMOKAmS5hDQo+IA0KPiAgICBJdCBzaW1wbHkgbWFrZXMgTk8g
U0VOU0UgdG8gcmV0cnkgdGhhdCBjb21tYW5kLiBJZiB0aGUgZGV2aWNlIHdhbnRzIHRoZQ0KPiAg
ICBob3N0IHRvIHJldHJ5LCB0aGVuIGl0IHdpbGwgY2xlYXIgRE5SPTAuDQo+IA0KPiA+IEluIG15
IG1pbmQsIGEgcG9zc2libGUgdXNlLWNhc2UgaXMgdGhhdCBhIHN1YnN5c3RlbSBjYW4gYmUgdW4t
ZXhwb3J0ZWQNCj4gPiBmcm9tIGEgcG9ydCBmb3IgbWFpbnRlbmFuY2UgcmVhc29ucywgYW5kIHJl
bHkgb24gdGhlIGhvc3QgdG8NCj4gPiBwZXJpb2RpY2FsbHkgYXR0ZW1wdCB0byByZWNvbm5lY3Qs
IGFuZCB0aGlzIGlzIGV4YWN0bHkgd2hhdCB5b3VyIHRlc3QNCj4gPiBpcyBkb2luZy4NCj4gDQo+
IFllcyBhbmQgdGhhdCdzIHRoZSBpbmRlbnRlZCB0ZXN0IGNhc2UuIFRoZSBudW1iZXIgb2YgcXVl
dWUgY2hhbmdlIGlzIG9uIHRvcA0KPiBvZiB0aGlzIHNjZW5hcmlvLiBJdCdzIGEgY29tYmluZWQg
dGVzdCBjYXNlLg0KPiANCj4gPiA+IFRob3VnaCBpZiB5b3UgaGF2ZSBhIGJldHRlciBpZGVhIGhv
dyB0byBzaWduYWwgdGhlIGhvc3QgdG8NCj4gPiA+IHJlY29uZmlndXJlIGl0c2VsZiwgSSBhbSBn
bGFkIHRvIHdvcmsgb24gaXQuDQo+ID4NCj4gPiBJIHRoaW5rIHdlIHNob3VsZCBmaXJzdCBhZ3Jl
ZSBvbiB3aGF0IHRoZSBob3N0IHNob3VsZC9zaG91ZG4ndCBkbyBhbmQNCj4gPiBtYWtlIHRoZSBs
b2dpYyBjb25zaXN0ZW50IGJldHdlZW4gYWxsIHRyYW5zcG9ydHMuIFRoZW4gd2UgY2FuIHRhbGsN
Cj4gPiBhYm91dCBob3cgdG8gd3JpdGUgYSB0ZXN0IGZvciB5b3VyIHRlc3QgY2FzZS4NCj4gDQo+
IEZhaXIgZW5vdWdoLiBUaGlzIGhlcmUgd2FzIGp1c3QgbXkgY2hlZXN5IGF0dGVtcHQgdG8gZ2V0
IHRoaW5ncyBtb3ZpbmcuDQo=

