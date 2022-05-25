Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8ABC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 25 May 2022 03:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m6A1agaisZmLKDqvCvTyab2zK7Pxp9STW9MjJW54Wb4=; b=KDGYjmK/FzIKdA2ytdi3MctblP
	l/jcfRtV6/id1oyr1mCYOWz6KW+LKEJSK6aWeBdiSMU6tNBAe0+GsRr5DNIVw7yqCc++Kfo3vHAnM
	3UC9iBtnCfN3YZgJmJv4wdC4CkaLzh4TNxH8TTRanMo0bp+BfXDrhMvMEXlQUXDT7Kr6sUmqb6q5K
	C4ViZe6as0FCyybyY9XReKkNMKGAIXMvZsV8FSVPeZzEmTudk50qNfxufRc9p+sMW8cGhmSjy3Wlo
	WjmDrm/yvBS2Vefl1fhj4i0NyOAl5EkqyVcvt07BvqBI2APfQCm4NrDAJGOxzMBaZE5Dm1r/K//rb
	2tEIvnlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntht8-009r1z-9K; Wed, 25 May 2022 03:40:46 +0000
Received: from esa6.fujitsucc.c3s2.iphmx.com ([68.232.159.83])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntht5-009r1L-PR
 for linux-nvme@lists.infradead.org; Wed, 25 May 2022 03:40:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1653450044; x=1684986044;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-id:content-transfer-encoding:mime-version;
 bh=m6A1agaisZmLKDqvCvTyab2zK7Pxp9STW9MjJW54Wb4=;
 b=G7dL6H3GsALnwskpNMqEZbadxQ1npRrNBg2SHHnUxGEWLTmyrinrp/gE
 rgxxCiARhUa9oZdQIdU5Fimel0afkUXxEBDuL1vw8xU2lIRENXMIp4z23
 W1saeionuei2th0Atewpg6ZcSqFDGDZRiKXWhZbqyJRWHXnrXuAC7CTcO
 oqxQkHm9ZW5pB9byvTn/k/L95iGQc5kbxnvJCkCqSlwPxQA0+e2PVf/Xm
 QOOxzM1vP5OsagHT/hyfUrV78kfmlVa0jU+bi+TSz8capJWMblMTv2vVR
 xYDY23QGKyZ5pAq8SUhp73anIomkZg70tSBkJSIY9jINF5LMHAM142/0a Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="56599648"
X-IronPort-AV: E=Sophos;i="5.91,250,1647270000"; d="scan'208";a="56599648"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2022 12:40:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SH5tTqA2NU1L7/JCj9YAOi+Q+h4LuQ5zRqJn6tvNq2nsQLrkY1yYAhrWiHCbnk0QguCP+/u8cx4MZf7fcMAXkS7/9f2mVL3rYuooXOpPCUi4huskB/OXgOQDkMBzEa092BsHuO7/swwLR16KsupzBbS13lJuvwZxhVA99LjDsdoHOyJIKfGMYJRUOMOlpaZgjjaLxvXxEywbx4p3kMi2ghQE2FjyFMsxuE7IlTsOcBiwVgLLHL15Ki3kzYSArDOo6YI2x1FD3+ZW8MaDOcZFaHu/sR0RhqwSHW6/4jpjP6MsJ7/M52oz9+2ikxEPPvNRsm5pav+K3Ec95ijkvaQPuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6A1agaisZmLKDqvCvTyab2zK7Pxp9STW9MjJW54Wb4=;
 b=ixYezfd2zlJGP4YdzedbXX6CDdBAwa6h5c8oowOmzM+5wRxLPvn2XO9b//SR3wfbYE8KcTpW4FCDgU+Q7I3S98Uv9WViaPtXFZEYsf1v4+KGeLY+o/dPdFADeimWMUC/4Ox5jKKJeZyM8JmceT3oGT9ksBNdBdCLsXXW68/oFJFr4e0PQI5BOk4gDX3wlx74n9IFv/BZSscvyaC35GFCAb7DrulH/oK7Y1NLy2RT7TrxLRMNZoTsy3UK1wgRyMwDEM8Yg662fpgWv71L126V2M2zWfedqW+U1B3ODQAoQ1O0xfSGt6Fu8cN0/CJ410tXPBw4mJEvlHZaQO92eke0GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6A1agaisZmLKDqvCvTyab2zK7Pxp9STW9MjJW54Wb4=;
 b=PrvozCsvZww2cu4K6/bfNHZ+iWAhim0CSt08v6yEZTwMJSIwEJI7rt01rQ56CJQum4K5PRpDLqR2sIv/TYXMNP2gUuwbF8loixRDlmIcfd2kVwxIsrCTPJUEPObC+tLo1tA0xmkP+QZj7lTTc0YVcu251+qx9AWSMPLJ8VWdVJE=
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com (2603:1096:604:1c8::5)
 by OSBPR01MB5190.jpnprd01.prod.outlook.com (2603:1096:604:7a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Wed, 25 May
 2022 03:40:33 +0000
Received: from OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::fc7d:6568:baf2:4930]) by OS3PR01MB9499.jpnprd01.prod.outlook.com
 ([fe80::fc7d:6568:baf2:4930%8]) with mapi id 15.20.5273.022; Wed, 25 May 2022
 03:40:33 +0000
From: "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>
To: Bart Van Assche <bvanassche@acm.org>, Yi Zhang <yi.zhang@redhat.com>, RDMA
 mailing list <linux-rdma@vger.kernel.org>, "open list:NVM EXPRESS DRIVER"
 <linux-nvme@lists.infradead.org>
Subject: Re: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Thread-Topic: [bug report] WARNING: possible circular locking at:
 rdma_destroy_id+0x17/0x20 [rdma_cm] triggered by blktests nvmeof-mp/002
Thread-Index: AQHX6LvFpcY61i1rak26VhnSnZTaj6yokBkAgIdwzIA=
Date: Wed, 25 May 2022 03:40:33 +0000
Message-ID: <bdf3dd84-be25-d50c-5c8f-39dc652f1140@fujitsu.com>
References: <CAHj4cs93BfTRgWF6PbuZcfq6AARHgYC2g=RQ-7Jgcf1-6h+2SQ@mail.gmail.com>
 <bc4ae9f0-3028-3f27-157a-44a00632c214@acm.org>
In-Reply-To: <bc4ae9f0-3028-3f27-157a-44a00632c214@acm.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9898d9ea-a685-4079-cfa0-08da3e00528f
x-ms-traffictypediagnostic: OSBPR01MB5190:EE_
x-microsoft-antispam-prvs: <OSBPR01MB519049D40E3D3D430D93F49783D69@OSBPR01MB5190.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3fn6kQsP74MzPO0C/xMjTfINxJmungwyMp7YVxu4g1g6XLBoywSWm6B6WA1Yi8CnRGb+hE5F4Bv8wLDOe0N4jtk5zIrS79hIFsE0q5AM3PHSsN+/cGyJanVFnqnESoObxMHWzn0ppGgDHt1NuJtYr2/sbWR98j9ImPxQYcfPL2l+W7VIGGhEuVaykN2P79nVUoG5cfqdejOC0qxUd1cMZGEb0nzw8ewR17lN2qbQ56wvRexXLLk72DjX/FYFW3/yumyZDVO1S6kwNOV308/QRRXHv/ruW2TwsvmpBV9nRcsT9NCg5bBkhdH7jp57iD/kQNSenZdo5cYuhDn2u4mWDSCy46Gm+qxmjD3yuG9ldg0/X+iT3x9oc1LM1bTAR2GCrwsdThO0PBzk7T2i4q4KeCE7VN02trl5yQbeRRVMPivRWBXRTQB2T+upDl+AUwhlvGdc0caDXGSxLXgGK6R4sAOFNHCHQWe56KlO8VEjNV3lh7pgE/+SX+4dLfXD6uf+qqrvih0EBkTwZMTde1nS6JiTL+9RkqtlaDtOCKKm9dOUjY0IMa8tCR/z3ui7vgywzvru1Bq9MFRmBQ+E+xs35LmpzT3T29z4HOSSb3mjKSpfXiNRw8MyEZ2znm1iXU3ZL7UDE1oKL4lh+eypZPfogrfWoaH6RBBvQaS9xsUT17rDHG+kGutvT8rpAufRFeVXDbMQpNhaaRmtfFxmChK3HB+eiBj0RbLlgV12VMZNe7s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB9499.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(110136005)(66946007)(66446008)(31686004)(38070700005)(66556008)(82960400001)(64756008)(36756003)(186003)(66476007)(8676002)(76116006)(2906002)(38100700002)(71200400001)(91956017)(85182001)(122000001)(316002)(6486002)(31696002)(6506007)(86362001)(53546011)(5660300002)(508600001)(8936002)(4744005)(2616005)(26005)(6512007)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2RxTzNDdWtoSENHSTA2bVBVSlUyTHVXQTl6S2hadWJYc3Zua2Q2VExHM0w1?=
 =?utf-8?B?cUl2cVpEekpBcjhucXVGWkJRU1B3Z1k3NEZxYTNqUU1adWw1Y0kyL29wN1NI?=
 =?utf-8?B?MXY3VkhRaHRyWWt4bGpXTGxyajlGQTFqM2tRbGgza0lnTGFFM1hVYzBKRVdx?=
 =?utf-8?B?VGJoenN5cVgzem9ESU5uNGZTN0s5NWVzUmhsY1FMVTd1N3YvN1NFL05PMzZq?=
 =?utf-8?B?ZS9MZTdIZGdNdkxxSVprSzNkQTh0VGUraFJCbWZCSmhwcEpFSDhhRnk2MFBr?=
 =?utf-8?B?T0RqY2UwU2lKTDZZNFdQVmpIZ3pHaHY1SnZkT2JwVWd6WkFydXRmTFNPbStB?=
 =?utf-8?B?TkZkV0xmeDdDdHo1RkxObzZBb2cwZlpHQW5oRE1DN3h6UEJPbEhjR1Y2TG54?=
 =?utf-8?B?bTF6ZTlOb0FpK1BpR3NrRTRCc0tYdWtWTUtIc0wwK05tU3NQZXdsbjVsdlNP?=
 =?utf-8?B?ZGxoV0pmdlhxVzhHbXlDVFdOUGNSUW12SkhjTlhRNkliWTV3L2FmbitZWmh3?=
 =?utf-8?B?aEZlUUVoQ0t5MDRzd2o0TjRUaUJTZ2dGeFZ0S0VtL0UrcHFwOTJBSEFFQTFn?=
 =?utf-8?B?Qm5IN2FXUlh3SitpeDdUbGZJYTdWSlhJVUdJSmxRWlJCTkZHblNuaW5DbjVo?=
 =?utf-8?B?a2VmZ3BITE1BdkdGS0MvZG40UXhrWURiN0lCbUFzQk1rK1pvcVdzUFVUbjE5?=
 =?utf-8?B?TWYrYzVwdkpMWWh5eTdhbUpBQUQxQ01oZVQzdHl6SmpJenNxR2ZreUovd1Er?=
 =?utf-8?B?V05WL1BJRG8rK0lobHZDay9KMUJFY0E4ZDUzTzFsNXZEd05Qc3krbzZlWkRt?=
 =?utf-8?B?UGZtd3lZL3gvQVJwRndlNWJLb3ZFOFBKU2Q0aVAyU2R5MHQ3K3JLYml5QnJ2?=
 =?utf-8?B?cUhTVE9hRVVoVmhLUnA0azNaU0V4MmRvdHZ1dU5YSGVQcitVMlF5WStCWkdP?=
 =?utf-8?B?K1g1UXdoL3AzTHZaRVFmUEoxUGR0YTRwWkpzQ2V0emt5Ry8yRHl6cit3Znlm?=
 =?utf-8?B?R21IR0xRcDN4bmJtZG02aTY2N1hlMk1iNFpldDlBeGdpNGJiSnVONmpRYlFk?=
 =?utf-8?B?NUhZTThEMm9PTU1PYUhXK0VJVzM2amFCbFlLTmN0Q3daNTY5Wi83UDMvZjMw?=
 =?utf-8?B?aUZ5dDhNOHc0Q2dkMHBZSW5sT2ROeHlhNDlKdnVjbGFtU1c4N2sxRDkzei9m?=
 =?utf-8?B?SFA5R0Y0WnRSTXpla3ZwM3BBYmd4aGdzV0JwUFROSkJjUG9icHQvaDVNbmJH?=
 =?utf-8?B?SmlJOW92czZnblplZmYyNjIweVpTV2pQZDVmVGdtMmZ3cEdFbW9lN09udm5B?=
 =?utf-8?B?R1dGWkE3WUttaTA3ZjMvaDN4ME5ZbGFYaGhxZHBIK1JOTUE2aHdUbit2Tk9y?=
 =?utf-8?B?UzFxZEVyTXVJVnBoQXJ4K0t6MzRLM3Z5MXBVYWFDd3dtSGtBV1I2ek53Rkxt?=
 =?utf-8?B?QkFiYmZpTG5tU1NJTk1KOHlrdnc0eGZ0M2dsWVl4TGNDOXdtZVRwWmY5Rlpk?=
 =?utf-8?B?QjBQdDJ1NzVTVTB1dnFxaXFLUGwweGtnZnpsUWdTMjlySFNaNUdOclBueGh6?=
 =?utf-8?B?dSs5dit6SDBjV204WXFjMFhjWXFDTVFPcEVLKzVlaGo5MWhaQ1lKWFNJT1BG?=
 =?utf-8?B?UFRmYzZKTUNMcUNleVhnMG1jLzcxcDBSNHg0b1NCckdxTDdxZnhVT2JiampL?=
 =?utf-8?B?VC9FRlp5ZlY2NVFYRFJhNG51SkltVW03VUFCNHVhenM1Q0ptK1lsT1J4SDY2?=
 =?utf-8?B?clBKSUJSem4rNldTckRkUmpiUEtXdmhYb0l4K3h6aWtqZGlQQUhvakFCSmJ2?=
 =?utf-8?B?NTVxeVdxN05XaS9ZZ0FPSHY0WmtHNUZhckZtMSsvamNQcjdocVRjZ2VaN0xJ?=
 =?utf-8?B?S1lBR1hVL1k4RndjY0NtdGRrSDJEeXNLWFE2dGhSdXJUYkVEbHpxN0ZXRUI2?=
 =?utf-8?B?a0R3a0FXaitqbzZVRkFLSEVhZjVKN0tldEMyTXN4UVJzV2hOZ0Rxb1R4R01z?=
 =?utf-8?B?ODEvUXFBTExQYmI3cXdlbnJLb0Y3SElBWFJnb1MyUTJIYmZQTnVGYTRLdnI1?=
 =?utf-8?B?am12L2pVdmV4em52bWtLVnRwbkhtYkJTbE1vNjJGdG5uYU5Xa1FwNkdqWlhN?=
 =?utf-8?B?Mk1WajROL01SbTVxVWVFTi9sUVhnZ1NEUjFFd3BwS0VUN1NYaGR2dGE5ZGZr?=
 =?utf-8?B?REZmRy8rREpxQ3VmOXFQTVJGTXI3QWRCbUJuUElhSGcwTEx1UnNjN2FBL3gy?=
 =?utf-8?B?NklQc283c1kzbERlVnNRUGJGc1Z4RTMrdE9WQWhEUzBveFdJNmVWSDFKbXgz?=
 =?utf-8?B?bXN5WVptQzMzajA5TTFHYVB0ckdhMTlLQmlqWFN1bmo3aWlSM3NmRkR6VWtq?=
 =?utf-8?Q?J7+dIvQvCNnE05AI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A644D92F4481D94C9AEC3821FF33BDE1@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9499.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9898d9ea-a685-4079-cfa0-08da3e00528f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 03:40:33.1956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xm/0UTIOVsS9pgXKrn5Ge+hGdrzdQE7X8LAAMuHao5feYmwMegMnr3CvqE9xLfYEfxUJPEvWp9xlYRjh99QKtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5190
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_204044_225040_3F93456A 
X-CRM114-Status: GOOD (  11.03  )
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

T24gMjAyMi8yLzI4IDc6MjEsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToNCj4gT24gMTIvMy8yMSAx
OTowNCwgWWkgWmhhbmcgd3JvdGU6DQo+PiBCZWxvdyBXQVJOSU5HIHRyaWdnZXJlZCBieSBibGt0
ZXN0cyBudm1lb2YtbXAvMDAyLCBpdCBjYW4gYmUNCj4+IHJlcHJvZHVjZWQgd2l0aCB0aGUgbGF0
ZXN0IDUuMTYuMC1yYzMgYW5kIGFsc28gZXhpc3RzIG9uIDUuMTIsIHBscw0KPj4gY2hlY2sgaXQu
DQo+Pg0KPj4gIyB1c2Vfc2l3PTEgLi9jaGVjayBudm1lb2YtbXAvMDAyDQo+IA0KPiBJIGNhbiBy
ZXByb2R1Y2UgdGhpcyBpc3N1ZSB3aXRoIGtlcm5lbCB2NS4xNy4wLXJjMi4NCj4gDQo+IEJhcnQu
DQoNCkhpIEJhcnQgYW5kIFlpDQoNCkNvdWxkIHlvdSByZXByb2R1Y2UgaXQgb24gdjUuMTguMD8g
SSBjYW5ub3QgcmVwcm9kdWNlIGl0IG9uIHY1LjE4LjAuDQpJcyB0aGVyZSBhIGZpeCBwYXRjaCBo
YXMgYmVlbiBtZXJnZWQgaW50byB2NS4xOC4wPw0KDQpCZXN0IFJlZ2FyZHMsDQpYaWFvIFlhbmc=

