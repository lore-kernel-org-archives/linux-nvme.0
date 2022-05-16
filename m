Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB21C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 16 May 2022 19:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rdAA8brJ0MxWrwoBVQO2FXUvPhFR/vbHUResCs5EAAI=; b=r4X5lan/mFT+6Y1RmBR0SCCdsZ
	oEkXcMOB95aLUYVLg9FusAvJyXPFHnoBgbrX7TB9tFHA/gG+eQsWoEwCbH9+MUCUTAH0fqC1DodSs
	2TshumKIOIL7ANTVt7U+EABo+g5GCfei8ndttUUe7jKU30Q8DG/PcYPwG4hFOB0Lu5JjpeRbnt/ri
	HrFqjN5AONI8TWuYGb69gmlSoH7fcqS94pCnbQ9yphP0EaR9I49nVn3LUlZs5S60xDDgXHN9XS2s1
	c+BmFd4F7nPUUyJ9hsIiUBa4Zu2D2FG1VRV8BpYYBfpjYt+lMghS3m68hMXiHXEudO0ulJl3/HfnZ
	oA0w0EgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqgfe-009tIa-Uv; Mon, 16 May 2022 19:46:22 +0000
Received: from mail-mw2nam12on2061e.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::61e]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqgfb-009tHN-D1
 for linux-nvme@lists.infradead.org; Mon, 16 May 2022 19:46:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YY9rwZvGaisDd35EWrBoKypRNbfYF3Kr8tCp0MLTAYAa+dYERtDjbSuxQ/rxob2E44mne2eD/jeNsWup3uIApG8asD+5w9SVrkbjnKLYdbNdwFXl9XK7y3AWopn/+K6ODT1LCTsAVtMx9gTPhtAQhDfrMcT1cl9OlBq05zhigFxOWmLTLbYWl0eKptFzzbk5br/Dbhc6zzfXRFYZGz1Gexrqb1YDfoZedU+wZxGCmrofqLJofvOWCqu6LyBJksKTTMvwiC186aPYNwfbNLjyEWuuFmQkw3TPSt/fFzO+2Q63DsStmpIy4ktYHVrX2DSLYgJH2RTqLelHCgg+6ab5xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdAA8brJ0MxWrwoBVQO2FXUvPhFR/vbHUResCs5EAAI=;
 b=VlbZ3ddvv6sOaZjfMWnuxqyqpIqVsjU2joqvWRRXqL5VZA2ccuyqNVIjBw+UnleThw+ynZG3DxPgeAD1y8hjiUojx4DbVIlBHWrnzLzU5QmPAN4xWODB/9qPJJ5qRwT2Hbg981UNjF7EbiF/RTtUJ8KFePvCLPY0sKZu75THE1LVjJH+Dnm4RL1J48movUX+O2CMoNrc0pzmkfEiN9Y/foBNAw+6PXZa9xbGzp+0xya+XMzZo5TDO5cinEtDYcu6EwFoTNzTJw00Z1y1cBtW8xOI5ba97Dnl+CmDfB5Aothjw/pzOYKsan7AsZvHsBUtl7JnBGWIaaCcooIjF4OGkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdAA8brJ0MxWrwoBVQO2FXUvPhFR/vbHUResCs5EAAI=;
 b=FiaCIi00bXNpPZE2Q/aq/cTr5sD2y+iswMw/Zf6nFJHIIeq7S5WbHySal4mm9bxC/oYamZ5DInVE+U1xAp8CJlBvTY00eSnGtnbAYYW7QpMo3d+0i7RxVgLdqMNyJrqy6mmd0qo/nDfJIxYLiaNcJeHUvQTWRPmtcptTgVQnogjbbHAlGDevyLIO5TkqYFwotxqrrcYkhvstxlH+o1xqOYaxDd3/zkS5G3UsahchatHQVdTgQys9vZ12BSVSay2vgDldl1je8GWT9QnAh4FjRMSH0WIcJDujK1/A+S6n1Yq+TRPzBt/2Ik6vRpDDsSp9sBQ2OPK9sdI9+DFPG4bWEg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN0PR12MB6317.namprd12.prod.outlook.com (2603:10b6:208:3c2::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Mon, 16 May
 2022 19:46:13 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393%3]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 19:46:13 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "kbusch@kernel.org" <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: split the enum used for various register constants
Thread-Topic: [PATCH] nvme: split the enum used for various register constants
Thread-Index: AQHYaSSy33VnEvSBXkSdFPhIeSrHKa0h6OcA
Date: Mon, 16 May 2022 19:46:13 +0000
Message-ID: <a6acb0f0-4d55-5902-d0cb-05fdd3749359@nvidia.com>
References: <20220516125258.2800718-1-hch@lst.de>
In-Reply-To: <20220516125258.2800718-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31d1775b-9543-489a-a472-08da3774bbd2
x-ms-traffictypediagnostic: MN0PR12MB6317:EE_
x-microsoft-antispam-prvs: <MN0PR12MB6317719316F7607CBD705F99A3CF9@MN0PR12MB6317.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K8k27Jqfh36P1juJ5N61PyX+K8jha79ixCsDN2Si9amgNcvfijKm2zYuLs88ia2QMaW60jkEl4ROpI5qL4DlLHh1NghkHEX/8s0aeuhh+YQCbFFB3pYfM8KhQimEI9Hy/MXyXIfe/oKTmeGHakyrnUHLmZ5PcbstGGLN9XSzvKiM0syqWrgqWez0l0pFPbrx4IN/jiDy7IAB70tgb6B0AJelBp/jHD9axuzcqqsCIyAO4NaK+or0UsOHcMl0QtoPqLNRtXLVvbJQeOCYwlkBAX+lclDwdGDMNi39rFFxU6wenXibYvzH5NKWerl91HWcWsIZ5S4141wiphJCX/VQ8tPpfXz5d+hZnZtosZwimI8BsABCEDJxmMwrXoVfVBVDgGuc0qV6hAjH/ynik83hM8TIIM4CUcwrk2Gg0nQI5AyLWh4eOcpYr7uo1G9xvfTnNsuL9jGSDcg8otM1j65GOT6l/HRhk4UGtrtr5n96FYy/q753nK+RpsLMx1vkYYRL3AsANw3jAG3ieEl2qke5UO1tfwQQ8eoqHixeh+DZ3d/ZL7rPOxfkuXBMu2E6/Ti0j6CRVMnr2Rd9AnXlpQmnwxfwslps1oOYnNWJEfS4LupKF4un5rvLDrhL6Yczd7vwW8TCZj0yrTYmsQClkRP+mjh49nXOdJenfvWRkXmPILK94xlruEnExRbIc9HPepGd+tRSHP3SgYTK1X9ARCWDBkPQwD+pWDRIESdPDL2SsiD8KTOWq499Lpss7ILZjpTBDgiRvqQkB4A6Z9EDyUil2w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(76116006)(86362001)(66946007)(4326008)(64756008)(66476007)(122000001)(66556008)(66446008)(8676002)(38100700002)(71200400001)(8936002)(6486002)(316002)(186003)(508600001)(38070700005)(31686004)(2906002)(6512007)(2616005)(6506007)(53546011)(91956017)(5660300002)(110136005)(36756003)(558084003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTVmTDhrVVQzRnBWU1ZScWpsOGp0K0Z2WWJVaGF4YWU2R2EydzREWDRLSTFi?=
 =?utf-8?B?UTYxa2ZrMXNLNEFJcWRVd2M0S2JCQ1pFd2s1TnBXRmczSm5JV2hVTmZCazZZ?=
 =?utf-8?B?dTFrWEQ5bkw1ZUlnTHpacHRVczljQzJRdGd0SGJxVHpYRVVHMk5lNUNTUGha?=
 =?utf-8?B?Q0NkMFRkZnZLN1BiMkNEZThpYUhIcUROYytoWnFSMktaUXJYZk5FUGZvejBx?=
 =?utf-8?B?MU5yQ2E2UUxCeGNRR0ZiTXZDMW1MQVhBYXZiNHNqajROWTZWZmk1dHVaU2RU?=
 =?utf-8?B?SHN2UDRObmhwSFRuTFhpMVdLNmd1elJHaThOdFdlbFhFYi9JcXhxMm9pTkpm?=
 =?utf-8?B?ZUZ3THQ0R1RyUWxCbFR4TGNqQWkvT1MzTEpWQk81b0YvTmgvUUcwaDRFSEZ0?=
 =?utf-8?B?QnVheElNamREVzBuVHJqM1V2OTVkQ3BNd0RHSEwwTnF5MW1jWFBxM3NscExN?=
 =?utf-8?B?em5UV2ljaUlyZ2FsK2tzbXZpUTFWenl6ajlKUDNRL3NRbHZEbVViQUpRRXZt?=
 =?utf-8?B?RkxJV0V4M0p1dUVJRkxpTGYxRzZHcnVabWdnWXZWTnUrVWZTbFB5cGJFN0xo?=
 =?utf-8?B?V3g0N3Q1d2ZLYk8wM2M2dkJtUlZWRUFHTWZ1aVpWc1J1cTZmZHE1NDl0Q093?=
 =?utf-8?B?RHJFcmVnb3lmNDliWTBFY0laQWt0cWlNa3VxM1ZUYlM4TzV0ZXN5NFRMcmxk?=
 =?utf-8?B?ZmFKVUovNnJzZ0xwYllWMjVsT010VHFLdXhJdGZqUk5kMGVDd3pCdjFWTHNJ?=
 =?utf-8?B?OVBRbm53OHlmRlhSQWsvU1M5K0ZtdGtydWl0K25rZExRaFJRaGlkMzRzOFBJ?=
 =?utf-8?B?Znc5ZHpLakFncTJVQ0hjL25KNnZlcFBQc0VGUkZraFFqZjVNYXdCRFhLNWI0?=
 =?utf-8?B?YzZXVDdLTlFWc1A2Ky84R00vQ1R4S2FURk9UMUVMN0dIa1lnOVcyQjVpSGlY?=
 =?utf-8?B?QUhXRGNqaDhXMFJDdFZCejBZeXhDUGxlalJVazJQdzd1RFJiYWhiMnVMdS9E?=
 =?utf-8?B?Y0VScWlRQ1FUUy9DaFNDU09ILzNwcEVSREQ0Qm1aOXZ5VzFmNTBWTlFDWG81?=
 =?utf-8?B?TDJNeXR5WXA3eWV1dUV3endGTmR2U1RLM05HdFNHRFV4TjUxUlJMdDZSTWxF?=
 =?utf-8?B?WWw4V0EwKzkyd2lMcmFPTXM2b011blhnSDdEOEo5bFl2SXZuQm41S2txak9Q?=
 =?utf-8?B?MmtMYjBwaitST2JwdFFCKzM2R0FJR2hkS1F5OVBaNTJCWFpRU0o2ZHNYSFox?=
 =?utf-8?B?ZldKVnVvRlRJNDhGbnVRcmt5bWRRaDY5SDFlWDhWZGoyd2RrOVZlZFRnNHl2?=
 =?utf-8?B?eityZDBSbHE3RDZCVzE3c3k1MGRSb1NCR1BUeEM4WjRUbnFha1BFcGRPUU4r?=
 =?utf-8?B?SDV4dkl3MjRXV0xqVmowNXBPNUFLalZwb3dkVGhTbHJUWTV0NmN2Y1NISTZo?=
 =?utf-8?B?NXMxSVhhRUEzUlhIUkU4MGZESzV3MGZ3STBoVk5VeUh2RTd4VVVrRk5VMHp6?=
 =?utf-8?B?eVhtdG1KYmxla2Zud09GNnM0NmhEdjIrSHdERGQrVENlTFNWU0VmYStHMXMz?=
 =?utf-8?B?clZQTHFVYzdMaDlOZ255S01ibVY1ZGViMmk5NzNRaDNpRjV6Z3NIcEZPRGRm?=
 =?utf-8?B?Q2ZFeU9udTJrdzNhNm9kd2g3THdmbG1hbnRHMnlGWEdUUHFtSWdqUHd2SGgr?=
 =?utf-8?B?VHdFd2lkZFlueEhjcXVJb2ZqSzk3aXE3SjR1QnpqK2xYU0JWTmNGQ2F1SlBN?=
 =?utf-8?B?UXJrS2tXQlpIV2pEWk00MjN4VjB0ZUhrZENXNXRiR0dqSWhYRG5qOHBTNmZ3?=
 =?utf-8?B?NkgyMENxaDNZcVdMSmlUZU1sYzlvZTlhVHZxdkdFYm9JQ3hxeXBJYjBXSmwr?=
 =?utf-8?B?SmJMMlgrQzZvbnIvSG5NK2I5RU50SzVwZFNmQXpSR003Z1VpZ2d4WW4wVDhW?=
 =?utf-8?B?dTBnMmdNSTk1UTZWa0RIVHZwVHUzaEVCRStrTjRHRnB5aHRBdEYyWXg4UlJi?=
 =?utf-8?B?cmZRRFB3VnREQTlISXpQNzA4YjVNbGxoVXFzUkF4djUvb2tmcGIyTWRNVzEv?=
 =?utf-8?B?alFETHNFRElBYlBSWUVXQ0NUYUo4UTYvc1dydjV5V0hGVmVOVDd2VktGVGRs?=
 =?utf-8?B?MDRBTU5MRFlzbVZYZzZVeDFndEdKMnRuYVJCZ3RnMWJHaXQ4L2JsNTkyc1FL?=
 =?utf-8?B?VGlLb3NRSi93a2ZOZjF4Vmt0U1hIc0FFcDhHNmNrVE1OVTNDc1prUGpvTlRX?=
 =?utf-8?B?bGJ1YjJLcFRocG5leUJoUVZ2TUlyMTIydU5LeFp1QXpWbFBkNEJVZ0tuTzkr?=
 =?utf-8?B?dndNWEFhSVBJalBMUXkybnQ3UnpRd3g3UnNyOHZscEpJdENoOG5UYTBNTDlk?=
 =?utf-8?Q?rMzCW5oJ4dYYMiz8ugJbgrc+PpXWw2nDUsK8g9NAWC28Q?=
x-ms-exchange-antispam-messagedata-1: eI+jWIglSUR3cA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <50271E636B1D6D4D85BE74F6CC94432A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d1775b-9543-489a-a472-08da3774bbd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 19:46:13.3068 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: il18Vz2kopLrsrYdmc6AHREobXJt1wuhmMMvXj/BEboWiJSo+okkkDlyRx9MNEeZvzvACxB/h686gpw3T0GUDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6317
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_124619_649207_A827C66E 
X-CRM114-Status: GOOD (  10.05  )
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

T24gNS8xNi8yMiAwNTo1MiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEluc3RlYWQgb2Yg
aGF2aW5nIG9uZSBiaWcgZW51bSBhZGQgb25lIGZvciBlYWNoIHJlZ2lzdGVyIG9yIGZpZWxkLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0t
LQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hA
bnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

