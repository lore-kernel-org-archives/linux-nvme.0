Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC27C636D7
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Feb 2023 14:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wCkv8X/Ib4ey97L9KsYHQz/J7v3r0WQgeRMjQrv78QA=; b=RIhIR60RVKDn4jpFeHMpiDLmDn
	Yp/nyMfoPMe70ZboLTaSYTsPhQ+pmdODjdCMHKs9mMQMDlgNNV6TDZ4H/NNFIS6VGCAfgoimbMM4s
	OVSUFddddNqsmHrhk56HYzGll0XLf5PIT9xyh9lqbISSQF/fu3Xx94mSXcn0gVQOR98NIgJh4xrHw
	LdfLHR/SDq4Nm9gouQsrq3TJV+m8tBbRrRAqt9MwGydnT/fGz/6S/4abhxCDarv2f1iSgUYQTMv02
	UXTCf2CxDBg4WeXBzZJC7Dnqd47s6Aj4JNXVSRkeGGYgEltctaXpd0eDBtCxC0dcoS6kA/Hbp7vyT
	LWZN5Fhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUTaY-008UIN-Pd; Tue, 21 Feb 2023 14:25:50 +0000
Received: from mail-db3eur04on0710.outbound.protection.outlook.com ([2a01:111:f400:fe0c::710] helo=EUR04-DB3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUTaV-008UHW-TV
	for linux-nvme@lists.infradead.org; Tue, 21 Feb 2023 14:25:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OULDO8V6u/OP3Y97xYVEt3f+niX7IlwRmbZUzIV7SUfIO0V2tWXGQwB5t9kuS076KQKdrQBJoknTb2UTxtfRWYbJpE07LBYXkLDxIoxMdw/VcjW61asjpDNyFG2uw0f4iXrXjMEZUpsEpJgRLoW1iSrDHkJu2pqXncja8+M9vBBC8f1nlwGmsLyNMikFBwTeI7a6amHeWM8xBdRRag8TvfeLhpyRwiUmNLmrO73mUTnJX0CA+PjjUaJKjWxP2lygyy8Wu9sKHbHBquXCgYaWJuhppT96rIIvvnXfUK6/4nJuk3vu6XqC1TbIChu2O7/r0Y20uwPE3ECXPYz13IZkhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCkv8X/Ib4ey97L9KsYHQz/J7v3r0WQgeRMjQrv78QA=;
 b=dsA0wgljS+AnNx/k9okZcK3wjeBakY+tAHMQw0D5X35ZT+eM0Zsx8bsQc/TVLbzSq2Cno2sGF1AJsqM8xDgABpYcbFCBOMTQrKFVEQESy4xDdv6u4lkngLh/SIaLYqj7YI9mNMmWd9cSzNWmkStzTuBqQDC809Prpx6Nb5oSQLpE20wlYwzFT5Fy9zQgxbHx0a2VPQiq2vuzmFAuV4v/ig1U3HAUMZ+FOpgWY0PZ3aiWONQHBiQBuxBcpVqX9QNbJOGa2BPTfbofPbKx0kgT0WzsXBQ45QinrKDxUHPlxfzX4A2DpptEVoAULXElPOCLowqVmHfsFmJLGo4/kv+i6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=edgeless.systems; dmarc=pass action=none
 header.from=edgeless.systems; dkim=pass header.d=edgeless.systems; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edgelesscompute.onmicrosoft.com;
 s=selector1-edgelesscompute-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCkv8X/Ib4ey97L9KsYHQz/J7v3r0WQgeRMjQrv78QA=;
 b=SVCchxtMDkVYpO7rnaPTFKNYP/yeSSNz+gsyEd8wD5khUIlfiKsaERPLiszRL10Uqvkikhoi8TaNo+5FltHc6CybQ3PTMYtgTD/2aiB1ENPjNwLHYJwK81rr6urPiZ+5jewHhwpFbICZ2jaHF13rDc8SLVLG4lcs23kdT8Z3s9E=
Received: from AM4PR02MB3121.eurprd02.prod.outlook.com (2603:10a6:205:f::22)
 by GV2PR02MB8603.eurprd02.prod.outlook.com (2603:10a6:150:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Tue, 21 Feb
 2023 14:25:41 +0000
Received: from AM4PR02MB3121.eurprd02.prod.outlook.com
 ([fe80::ae16:1581:12f5:3bea]) by AM4PR02MB3121.eurprd02.prod.outlook.com
 ([fe80::ae16:1581:12f5:3bea%4]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 14:25:40 +0000
From: Nils Hanke <nh@edgeless.systems>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "nils.hanke@outlook.com" <nils.hanke@outlook.com>
Subject: nvme_scan_ns does not remove stale namespaces anymore since kernel
 6.0
Thread-Topic: nvme_scan_ns does not remove stale namespaces anymore since
 kernel 6.0
Thread-Index: AQHZRgBfIOaa5abw8UmhfcJbKaYowg==
Date: Tue, 21 Feb 2023 14:25:40 +0000
Message-ID: <CE04FCB1-DE80-404A-823E-5B164EDC2A50@edgeless.systems>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=edgeless.systems;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM4PR02MB3121:EE_|GV2PR02MB8603:EE_
x-ms-office365-filtering-correlation-id: d5ae7468-9683-41de-3a3c-08db14178270
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  PXzrWqQVlaBOHuxXC0utW+Tettr7RkMswXNah1gnx21dHYKgBDrG+mCBaaEzsnesVlpgqgYXdYaSkomjah5xnIAiY9QQdj3AuJ4xXKdQ4swGJbAlo+JiUMdBW7BZRXFj9tRP8UU5wBfLFR+q7AUHyIz5BQH4AuF14iW3N31ihT8TgfdMYFnhrs+qTma2t1i9u5XOZXQmSqYh/+ztXbrEbDs/s7+4onux4cM9wTWVX77kZlM2VnWkg80R3z152YEhKgu5ubP4yy3cAt9wg8M25bTUVZ5OOxUi0fKUawVvdDOzN/Xp0dxDCWItlvlSWIWO13r53X7w6qBIye63b1A2IlBTKaxKcAkAMZcUZjS54CoJxv+O3xSz5ZR+76d9l7wsPawFZYADikMKi/hnELdvJJDSjrKzawS+74mNHZ02yQIFBnO8cxzJDIFoaW2HVk9CR6rEDRHzc9dxjbyxpUKCZHVjgjlWgbbK2BOwsbNLxlMqOcXDtIR1N6TusMrRRdLHyM9WexQw55T/Md9sXpgcWXuDKEl2dSdHgO0XVgEBC4hECvgSaPVe9JuU6MTnA7yipeXJS6K8GTt0hE/ZB/UPnsci6GTUPPxLVROJx9jhDgq2+L3wP49ZK1GdhMKf/ozJ8NhQJioY8OGlSdMgLxkycXqxOx8J3FzFvtvnSzEkto2hR38oxnvC6FZ1XKHFPcmRfO1ZzSPQ3oVVLhroPcUGCj/3duZ12GXS0lNQhoaIfjKIK3KHBYUwqE1D/JgOYTwy
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR02MB3121.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39830400003)(346002)(366004)(136003)(376002)(396003)(451199018)(122000001)(38100700002)(38070700005)(2616005)(186003)(6506007)(6512007)(83380400001)(26005)(33656002)(66476007)(66556008)(91956017)(76116006)(64756008)(6916009)(66446008)(8936002)(2906002)(4326008)(66946007)(41300700001)(71200400001)(86362001)(478600001)(316002)(6486002)(5660300002)(8676002)(46492015)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?eUxZRThSWmY2YmJkWVdjTUYySldaTnRuOXdDbUZ0RGp2N0VVdi8xK1lyVTRO?=
 =?utf-8?B?aFJMdTl3cGIrU0toQzNxRjlka3VmREZKTG5JVFIwYW1mY0VwalBwSGhUWTBL?=
 =?utf-8?B?aHdVZitVbXR4RndDVk51R0lLRmRrVjlBRS9OdlAzZXE3WWR4aWlpaUk5MW4w?=
 =?utf-8?B?Z1JzVEg5amhQWnN2WGJUMFl0QXJLNGdiMjB3KzJBc0FwUlVwOTRtYWRUenFt?=
 =?utf-8?B?R29HZzJONUlpWE1tbzEzRFBJODVZRzA4VXJxellZdjErUkhwbTJjTE9xemFh?=
 =?utf-8?B?aXBpYWs5cTNrVncwR29UaTlNZ1cvUWI0MVlDUWVuQmZBNkYzem9XaFhua1pD?=
 =?utf-8?B?NlprQU1YVmprVmdYYkF0R29pMmJMQTNxWERGZkNCWm9qQ2MwQllsWmZFQzFM?=
 =?utf-8?B?clVBNmVJVlgzNGQ0cExUMUJsU29LaXljbmdDeks2LzlPSUZQYlZ6RTdIV2NZ?=
 =?utf-8?B?akNBVGpqSURIZWtwRU0yYVVPZDN0RjBtRXEwWUJBV2FjYTlsbXp3SGVlNTdI?=
 =?utf-8?B?TE1VOWxnQ1VheG9hcUpsLzFrVktEbVZHdTR1SkpjV2tHcFRtdzIxaFgrbkhx?=
 =?utf-8?B?cEdzUFYyYmk4RjkrUG5MMVFTNFFtUTF0UjNvOUErVkd3eUFjZWFoa0gxRlBs?=
 =?utf-8?B?YWQ0aGUvK0ZaZWZ4YURRNlNmSEc4OWUwaThTb2JhbVVQTHRRWjRKYUFkOFJV?=
 =?utf-8?B?NnpPV05ad0trUmtGV3IwTHk2NmxXblVPR0FkWjRaYUxCVXBLLzd0TmNaUmYw?=
 =?utf-8?B?dk1hWFdXbzFpZG8xRUthSUpyNFhPeUFzMXZwZTIyVVYxSG9IeldqR3JITlI1?=
 =?utf-8?B?bzFoRjVpVzVKeXpIMzJiZktSUkV0QUhhRnhNRDEwUERjUUtSTEdUeU4zOVlM?=
 =?utf-8?B?MWZabUdZMFltRUx2NjRqVTc1dExtV0ZCL0pMeFptakcrSXlnOUNaVGpwbmRM?=
 =?utf-8?B?OHljVkFDOXVOaE1FYk5pYWZISzBxbHAwZjZtTWpFeTlBQnlJKzBXYkNoZ09w?=
 =?utf-8?B?R1RKZkZ0UTRsdW5hWmU1UnQyeVdiSU9WSVR2TGd5QlBpd0xyd1ZzK0sraDdr?=
 =?utf-8?B?RnJWMDRsS0dlamk4TEowM21uaG9SS3NXeVhsaVBtZXU1V0sxYzE2dGVXK1do?=
 =?utf-8?B?OHYrZXJTV3d0STJCckdjS2RjS2RsbGhOejN6WSsyaFJyOWVVRXBHaGFHTVB4?=
 =?utf-8?B?Q212MzlrRS9PS2cxZTZqaEo2NGhLOU9hMmxlYTZYVUgzYnhjR21DdmxCQWVD?=
 =?utf-8?B?TTIyYTIwd0FkcFNaUTBDK3RiS0RGckhDTW9TTnFyTmhPc3lCVUpVOE1hSlRv?=
 =?utf-8?B?Q3NxdFhlamN3eFF6SWs0cHpjZXZiMEttb1I5dEFSaWlLTmlvS1M2SnEyVGwr?=
 =?utf-8?B?aHVjZFBodk1rTnpDKzJhZm9CVVROaFJhVmtFeGFJWkFWRi8zWGJXVjJtdENF?=
 =?utf-8?B?aUtMNFhEWVhaZDIvL2N4alI1UTI3Wml0MHU3L1c1OVpMRVhBUVFMZExqTTg4?=
 =?utf-8?B?Z3RLQ0ErNGpkVm9EaWcxTWNtYml3N3Z0MExINGJHYXFHY0VEbFM1RDh6b3Nr?=
 =?utf-8?B?RFRLbVdYeDVDaDNwVWlXVUZwUytVWVRsWitod2VsbjZmSEFBK2psc25lc1hp?=
 =?utf-8?B?QmU2YlV4ZzAzeWJESUIvTytncE5LTHorWGI2cUx4aXpDbmJVaTFHYXhnR0k2?=
 =?utf-8?B?MTFoZVFMekhMbHNyVEpxb3Q4Y0h6ZDlGUnJmbjl3VjF2cjFCRmVJR0JVVWZR?=
 =?utf-8?B?Z1YwMjVKdUJOL01xTzBwaW96S2lDaERvWVJ2eXF2d3JsTTVhRHVnUkRVSVpk?=
 =?utf-8?B?aU9uWno0Vk1ua25FRlQvRXBqT1hBc1UzQ0tYV1V3bXJnRUcyMXhJRXdnYno2?=
 =?utf-8?B?ZXlzb1RVYnRWZTdXYy84aDUrVXd2N2V5aDM4SGdTMDM3RW1GVHcrL0xPMU1j?=
 =?utf-8?B?bXlNejFuVEY1WTQ5dEZVemluQ09TcDdNUUZpSVNJcXZ4WGhCT0V3cnFIM2lC?=
 =?utf-8?B?VzBkVU5mYS9UbENXRUJHTTgxZllpb3VZWmpsWGtSWUJFa2h6WXhUS1ZQZll6?=
 =?utf-8?B?cFhzZTZ5RklnbXcyVWJjS0NBNEV4SDZMK1VLU200M2MvbTI0ajZpWUY4aWpH?=
 =?utf-8?B?UjlSbTNuNGFQWC90dUloNEJWbjJ4TnJNSk42Y1hlN2xTSkhjUW5MMkVveVZB?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7ECB73F3C847E842A93FC87AFD408D43@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: edgeless.systems
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR02MB3121.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ae7468-9683-41de-3a3c-08db14178270
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 14:25:40.7628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: adb650a8-5da3-4b15-b4b0-3daf65ff7626
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GrEsRURLLWVHZyQrJFlvkyz6rs95BuDrrcDwDncqc6aYyXCrvzvX2m48spJBlzYN6qtx3+14pZDlrJKWYxz+LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8603
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230221_062548_204698_86E7E44C 
X-CRM114-Status: GOOD (  24.31  )
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

SGkgZXZlcnlvbmUsDQoNCkkgd2FudGVkIHRvIHJlcG9ydCBhbiBpc3N1ZSB3aXRoIE5WTWUgbmFt
ZXNwYWNlIHNjYW5uaW5nIHRoYXQgd2UgYXJlIG9ic2VydmluZyBldmVyIHNpbmNlIGNvbW1pdCAx
YTg5M2MyYmZlZjQ2YWM0NDdlZWFkOGVhN2FmZTQxNzk0MmJlMjM3ICgibnZtZTogcmVmYWN0b3Ig
bmFtZXNwYWNlIHByb2JpbmfigJ0pLg0KDQpPbiBHb29nbGUgQ2xvdWQgUGxhdGZvcm0gKEdDUCks
IGRpc2tzIHRvIGEgVk0gYXJlIGF0dGFjaGVkIHZpYSBOVk1lIG9uIHRoZSBzYW1lIGNvbnRyb2xs
ZXIsIGJ1dCBhcyBkaWZmZXJlbnQgbmFtZXNwYWNlcy4gRm9yIGV4YW1wbGUsIGEgVk0gd2l0aCB0
aGUgT1MgZGlzayBhbmQgYSBkYXRhIGRpc2sgYXR0YWNoZWQgbG9va3MgbGlrZSB0aGlzOg0KDQpO
b2RlICAgICAgICAgICAgICAgICAgR2VuZXJpYyAgICAgICAgICAgICAgIFNOICAgICAgICAgICAg
ICAgICAgIE1vZGVsICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTmFtZXNwYWNl
IFVzYWdlICAgICAgICAgICAgICAgICAgICAgIEZvcm1hdCAgICAgICAgICAgRlcgUmV2ICANCi0t
LS0tLS0tLS0tLS0tLS0tLS0tLSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0gLS0tLS0tLS0tLS0tLS0t
LS0tLS0gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAtLS0tLS0tLS0g
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gLS0tLS0tLS0tLS0tLS0tLSAtLS0tLS0tLQ0KL2Rl
di9udm1lMG4yICAgICAgICAgIC9kZXYvbmcwbjIgICAgICAgICAgICBudm1lX2NhcmQtcGQgICAg
ICAgICBudm1lX2NhcmQtcGQgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDIgICAgICAgICAg
IDAuMDAgICBCIC8gIDEwLjc0ICBHQiAgICA1MTIgICBCICsgIDAgQiAgIDIgICAgICAgDQovZGV2
L252bWUwbjEgICAgICAgICAgL2Rldi9uZzBuMSAgICAgICAgICAgIG52bWVfY2FyZC1wZCAgICAg
ICAgIG52bWVfY2FyZC1wZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMSAgICAgICAgICAg
MC4wMCAgIEIgLyAxNjEuMDYgIEdCICAgIDUxMiAgIEIgKyAgMCBCICAgMiAgICAgICANCg0KDQpX
aGVuZXZlciBhIGRpc2sgaXMgYXR0YWNoZWQgb3IgZGV0YWNoZWQgdmlhIEdDUOKAmXMgd2ViIHBv
cnRhbCBvciBBUEksIGEgbmFtZXNwYWNlIHNjYW4gaXMgdHJpZ2dlcmVkIHdpdGggdGhlIGludGVu
dGlvbiB0byBlaXRoZXIgZGV0ZWN0IG5ldyBkaXNrcyAoPSBuZXcgbmFtZXNwYWNlcykgb3IgcmVt
b3ZlIG9sZCBkaXNrcyAoPSBleGlzdGluZyBuYW1lc3BhY2VzKToNClsgIDE1NS4xNDIxMzJdIG52
bWUgbnZtZTA6IHJlc2Nhbm5pbmcgbmFtZXNwYWNlcy4NCg0KQmVmb3JlIHRoZSByZWZhY3Rvcmlu
ZyBjb21taXQsIGV2ZXJ5dGhpbmcgd29ya2VkIGZpbmUuIE5hbWVzcGFjZXMgd2VyZSByZW1vdmVk
IHdoZW4gZGlza3MgaGF2ZSBiZWVuIGRldGFjaGVkIHZpYSBHQ1AuDQoNCkFmdGVyIHRoZSBjb21t
aXQsIHRoZSBuYW1lc3BhY2VzIGFyZSBub3QgY2xlYW5lZCB1cCBhbnltb3JlIGNvcnJlY3RseS4g
SWYgSSBub3cgcmVtb3ZlIGEgZGlzaywgYSBuYW1lc3BhY2Ugc2NhbiBpcyB0cmlnZ2VyZWQgYnV0
IHRoZSBuYW1lc3BhY2UgaXMgbGVmdCBiZWhpbmQgaW4gTGludXg6DQoNCk5vZGUgICAgICAgICAg
ICAgICAgICBHZW5lcmljICAgICAgICAgICAgICAgU04gICAgICAgICAgICAgICAgICAgTW9kZWwg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOYW1lc3BhY2UgVXNhZ2UgICAgICAg
ICAgICAgICAgICAgICAgRm9ybWF0ICAgICAgICAgICBGVyBSZXYgIA0KLS0tLS0tLS0tLS0tLS0t
LS0tLS0tIC0tLS0tLS0tLS0tLS0tLS0tLS0tLSAtLS0tLS0tLS0tLS0tLS0tLS0tLSAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIC0tLS0tLS0tLSAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLSAtLS0tLS0tLS0tLS0tLS0tIC0tLS0tLS0tDQovZGV2L252bWUwbjIgICAg
ICAgICAgL2Rldi9uZzBuMiAgICAgICAgICAgIG52bWVfY2FyZC1wZCAgICAgICAgIG52bWVfY2Fy
ZC1wZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMiAgICAgICAgICAgMC4wMCAgIEIgLyAg
IDAuMDAgICBCICAgICAgMSAgIEIgKyAgMCBCICAgMiAgICAgICANCi9kZXYvbnZtZTBuMSAgICAg
ICAgICAvZGV2L25nMG4xICAgICAgICAgICAgbnZtZV9jYXJkLXBkICAgICAgICAgbnZtZV9jYXJk
LXBkICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxICAgICAgICAgICAwLjAwICAgQiAvIDE2
MS4wNiAgR0IgICAgNTEyICAgQiArICAwIEIgICAyICAgICAgIA0KDQoNCkkgYWxyZWFkeSBhbmFs
eXplZCB0aGlzIGlzc3VlIGEgYml0Lg0KDQpCZWZvcmUgdGhlIGNvbW1pdCwgbnZtZV9zY2FuX25z
IGluIG52bWUvaG9zdC9jb3JlLmMgY2FsbGVkIG52bWVfdmFsaWRhdGVfbnMgd2l0aCBlYWNoIGFs
bG9jYXRlZCBuYW1lc3BhY2UuIEluIHRoZSBleGFtcGxlIGFib3ZlLCB3aGVuIHRoZSBkaXNrIGlz
IHJlbW92ZWQsIG52bWVfdmFsaWRhdGVfbnMgaXMgY2FsbGVkIG9uIGJvdGggbmFtZXNwYWNlcy4N
CkluIG52bWVfdmFsaWRhdGVfbnMsIG52bWVfaWRlbnRpZnlfbnMgaXMgY2FsbGVkLiBXaGVuIGEg
bmFtZXNwYWNlIGlzIG5vdCBhbGxvY2F0ZWQgYW55bW9yZSwgaXQgd2lsbCByZXR1cm4gYW4gZXJy
b3IsIHdoaWNoIHNlZW1zIHRvIGJlIGV4cGVjdGVkIGJlaGF2aW9yOg0KDQoJaWYgKCgqaWQpLT5u
Y2FwID09IDApIC8qIG5hbWVzcGFjZSBub3QgYWxsb2NhdGVkIG9yIGF0dGFjaGVkICovDQogCQln
b3RvIG91dF9mcmVlX2lkOw0KDQpTaW5jZSB3ZSBoYXZlIGFuIGVycm9yIHZhbHVlIGFzIHJldHVy
biwgYmFjayBpbiBudm1lX3ZhbGlkYXRlX25zLCBudm1lX25zX3JlbW92ZSBpcyBjYWxsZWQgb24g
dGhlIG5hbWVzcGFjZSBvZiB0aGUgZGV0YWNoZWQgZGlzayBhbmQgdGhlIG5hbWVzcGFjZSBpcyBy
ZW1vdmVkIGZyb20gTGludXguDQoNCkFmdGVyIHRoZSBjb21taXQsIG52bWVfc2Nhbl9ucyBjYWxs
cyBudm1lX2lkZW50aWZ5X25zIG92ZXIgbnZtZV9uc19pbmZvX2Zyb21faWRlbnRpZnkgLSBiZWZv
cmUgbnZtZV92YWxpZGF0ZV9ucy4gV2hlbiBudm1lX2lkZW50aWZ5X25zIHJldHVybnMgYW4gZXJy
b3Igb24gdGhlIG5hbWVzcGFjZSBvZiB0aGUgZGV0YWNoZWQgZGlzaywgc28gZG9lcyBudm1lX25z
X2luZm9fZnJvbV9pZGVudGlmeS4gQmFjayBpbiBudm1lX3NjYW5fbnMsIHRoZSBlcnJvciBmcm9t
IG52bWVfbnNfaW5mb19mcm9tX2lkZW50aWZ5IG5vdyBjYXVzZXMgYW4gZWFybHkgcmV0dXJuIGlu
IGNhc2Ugb2YgYW4gZXJyb3IgLSBhbmQgbmV2ZXIgY2FsbHMgbnZtZV92YWxpZGF0ZV9ucyBmb3Ig
YW55IHN0YWxlIG5hbWVzcGFjZXMuIEFuZCBzaW5jZSBudm1lX3ZhbGlkYXRlX25zIGlzIG5vdCBj
YWxsZWQsIHRoZSBuYW1lc3BhY2UgcmVtYWlucyBleGlzdGluZyBpbiBMaW51eCwgd2hpbGUgdGhl
IHVuZGVybHlpbmcgKHZpcnR1YWxpemVkKSBkcml2ZSBpcyBnb25lLiANCg0KQW55IGFjY2VzcyB0
byB0aGUgZGV2aWNlIHdpbGwgY2F1c2UgSS9PIGVycm9ycyB0aGVuLCB3aGljaCBjZXJ0YWlubHkg
aXMgbm90IGdyZWF0Lg0KDQpJIGFscmVhZHkgcmVwb3J0ZWQgdGhpcyB0byBHb29nbGUgYW5kIHRo
ZWlyIGVuZ2luZWVycyBjb3VsZCBjb25maXJtIHRoZSBpc3N1ZSwgYnV0IEkgY291bGRu4oCZdCBm
aW5kIGFueSBwcm9wb3NlZCBmaXggb3IgcmVwb3J0IGhlcmUgb24gdGhlIG1haWxpbmcgbGlzdCBz
byBmYXIuIA0KU28gSSB3YW50ZWQgdG8gZ28gYWhlYWQgYW5kIGZpeCB0aGlzIG9uIG15IG93biwg
Z2l2ZW4gdGhpcyBpc3N1ZSBhbHJlYWR5IGV4aXN0cyBzaW5jZSBrZXJuZWwgNi4wIGFuZCBzdGls
bCBpbiBrZXJuZWwgNi4yIG5vdy4NCg0KSG93ZXZlciwgSSBhbSBub3Qgc3VyZSB3aGF0IGV4YWN0
bHkgYSBwYXRjaCBoZXJlIHdvdWxkIGxpa2UgdG8ga2VlcCB0aGUg4oCcY2xlYW7igJ0gY29kZSBm
cm9tIHRoZSByZWZhY3RvcmluZyBpbiBwbGFjZSB5ZXQgYWxzbyByZW1vdmUgYW55IHN0YWxlIG5h
bWVzcGFjZXMuDQoNCk15IHN1Z2dlc3Rpb24gd291bGQgYmUgdG8gcmVtb3ZlIHRoZSBlYXJseSBy
ZXR1cm5zLCBjYWxsIG52bWVfdmFsaWRhdGVfbnMgb24gYW55IGFsbG9jYXRlZCBuYW1lc3BhY2Vz
IGFuZCBvbmx5IGNhbGwgbnZtZV9wdXRfbnMgKGZvciBhbiBleGlzdGluZyBhbGxvY2F0ZWQgbmFt
ZXNwYWNlKSBvciBudm1lX2FsbG9jX25zIChmb3IgYSBuZXcsIG5vdCB5ZXQgYWxsb2NhdGVkIG5h
bWVzcGFjZSkgaW4gY2FzZSBubyBlcnJvciB3YXMgZW5jb3VudGVyZWQgYmVmb3JlLg0KQnV0IGdp
dmVuIEkgYW0gbm90IHJlYWxseSB0aGF0IGZhbWlsaWFyIHdpdGggdGhlIE5WTWUgc3BlYyBvciBj
b2RlIGluIGRldGFpbCwgSSBhbSBub3Qgc3VyZSBpZiB0aGlzIGNvdWxkIGludHJvZHVjZSBvdGhl
ciBwcm9ibGVtcy4NCg0KQW55IGFkdmljZSBvciBzdWdnZXN0aW9ucyBvbiB3aGF0IGEgZ29vZCBm
aXggZm9yIHRoaXMgaXNzdWUgd291bGQgbG9vayBsaWtlPw0KDQpCZXN0IHJlZ2FyZHMsDQpOaWxz
DQoNCg0K

