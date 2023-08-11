Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA03C001DE
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 01:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UUTgh3sSFhLdcAcWOEs61u2f39O7LspUHPovmM/CO6I=; b=HC/mYUNpiHMu0buNvUIEoKO6OD
	KPTpYAW1QXXf54A5ZpClk5hGeyfIeLDXSrPPeklBXjbRGn8zZ3ZTobvZ1X6GeI4+vGGgEmhP5xx+a
	xkLuj8JbajaxbAPK4qGFWEEVvBkzRvpCTGgFZbzAIww0k/ag2heL9XwYqAdLjmlvS0xeXn+knwIuY
	V1aZGT7yoMZrzbx1qI7zXKpSxm7dq4rWJRORM08UF+lRZWMyrjQGjIop5lUzFk6Jdho0MgY6yjQRq
	JjZ0nepDfUraKwX8Bq9w/RwjEY2J/pKCO9Gd67nhmwXyKThOhG7VpsODpgm8OJfc3CABfPaWqsFxC
	3A5naCzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUGv5-0093vQ-0z;
	Fri, 11 Aug 2023 01:26:27 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUGv2-0093tz-0x
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 01:26:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691717184; x=1723253184;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UUTgh3sSFhLdcAcWOEs61u2f39O7LspUHPovmM/CO6I=;
  b=eoeRYxvWmbdxUQ7uG8/dsfWunFVEv/zOuSs6d0qSjz5k8GeBqq++vYSk
   UB3w0GekcuQW/3QUqhyDwXYQoS5YuV5MVCkYyURRvczm+NQbl1N9ujTcS
   KnhC5PRpYvIlmTq0f3ELVQW1qPVHK4Gdw1ipkNXPvbWUGfo9ebyMCWnNH
   3YRj1lAY6Re8oGlaCqTt6hIQLLxA5YqhdS+SSiy2H0uZjO+NDZHUGCIkd
   G6FlJNJvs2DbmZrHU0SztXzHW8sS5a4w7vms8BgNxjXdknOBvRgDZPkwh
   MjDKSQ3JEs8WqcpoRebL1RwtkqhWPCWl0Y+I6A++0t+uqmK4M4KlxV5Lq
   A==;
X-IronPort-AV: E=Sophos;i="6.01,164,1684771200"; 
   d="scan'208";a="241082302"
Received: from mail-mw2nam04lp2173.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.173])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2023 09:26:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=II4yMJx96dWv7tZKe0dVyKt9LlaNcB5MTnTqQ2PX76PnaCiYAaRkDsss8Gx++EYzTP/qbwUgSvP1FIryQWl4T9XH8tEb6XSEZn5VpaAHJtcwWZ6qq0nuWJ0gDpWU6BjPiXB9KFAg4w9exUc2WNbKPmHUEogmLzpBmNoCfCNFB5YnkU26Cw5t8jL2dgxWI/XMi+b6fqxtQlLyAZfJHW7nbsJCCXzQRMQESvclE85kflekTiAuJLZKiJzR80lSBcn9OS6E3M4ZNX/sbIbTiCjkkNMav46t0tCTwRLhlBDd3mvJlPsjyqhDYN1hLN055eVoDHrkyxdDwLMoc7x/aQ9I9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUTgh3sSFhLdcAcWOEs61u2f39O7LspUHPovmM/CO6I=;
 b=GF3zWekXpO74Uy+I+oKZCrzjrCgwFaHtffjSwaXgXhyk6uV/0mo2+ZxmgO1fXdbYnYMFAW5wuZsb3cJa2LXBLg1wZNPop1TWEl3xTyRw0rc2DdAYMC1r9ZhpciDv4jlGfUW2fMWgGN53o/fX5zgwWk/9KwpH6azCQSoKjS4wZdQ7cuhU3MEBNIns9xxutAi6/3Zku0Zh+NYuUoUM5lEvi1UDDwqwOMnivGKL1jBJdSXNexEVIozHmmxsDspq3QGKaZIjAvWwUuk9OJ5YEIvcSJsS0A8kUba6rY2pY7MDb30iecYXuAn1zXV/nIoveyYRe0UA7zK4xZqmPrexO8IYwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUTgh3sSFhLdcAcWOEs61u2f39O7LspUHPovmM/CO6I=;
 b=QKav+Oc6/5EZ+279807WSd4zRfviqzWIcHJxr28RNKRKkM25rWVyZIHtILt2jqaurA17Ch2IwhbmdBelNO2d4aKjVQR6S3SgAU5wZc7CRzdoRRyQ0A/7zFYoabV7PLaWugNLYRvsq8ePmfJ05L1f0ujpuT27n+EtF2iNUGeZLwc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7726.namprd04.prod.outlook.com (2603:10b6:a03:31b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Fri, 11 Aug 2023 01:26:19 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 01:26:19 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yi Zhang <yi.zhang@redhat.com>
CC: Daniel Wagner <dwagner@suse.de>, linux-block
	<linux-block@vger.kernel.org>, "open list:NVM EXPRESS DRIVER"
	<linux-nvme@lists.infradead.org>
Subject: Re: [bug report] blktests nvme/047 failed due to /dev/nvme0n1 not
 created in time
Thread-Topic: [bug report] blktests nvme/047 failed due to /dev/nvme0n1 not
 created in time
Thread-Index: AQHZydThaLSaElB1oUmqvdDBPohT9a/iL3yAgAB9eICAAJaLAIAAEZeAgAAqFQCAAB3GAIAAtPaA
Date: Fri, 11 Aug 2023 01:26:19 +0000
Message-ID: <mp5pg6kd7aygqws7o62msugnyvdalof6ihdz254n5dfognybl7@hc4job43ak3m>
References: <CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com>
 <CAHj4cs9J7w_QSWMrj0ncufKwT9viS-o7pxmS2Y4FeaWEyPD34Q@mail.gmail.com>
 <vxeo2ucxhvdcm2z673keqerkpxay6dgfluuvxawukkbunddzm2@jdkdk7y3a5nu>
 <xrqutkdhz7v6axohfxipv4or7k4jhoa57semwcxde7gletk76z@5kcashfdezhk>
 <adgkdt52d6qvcbxq4aof7ggun3t77znndpvzq5k7aww3jrx2tk@6ispx7zimxhy>
 <o2443ezmpny7dyvhiteajzgt3j7wcxo2fv7dik3h7hkjpc2h74@xeetbva55fx2>
 <CAHj4cs8TBsEct9P6iiYwsiRhgCkPbdVL0-8KkXuKZbYhVsQV0Q@mail.gmail.com>
 <git5brh4yq7ij65oskwd7m4pwnhfcqbvwdn7pzsbrmzv3wgsk4@xvb43h5dbo4g>
 <CAHj4cs-RqFEWFxdCGfZA7+qHLA+JJYs6qynCvKqTDdfW+V66ug@mail.gmail.com>
In-Reply-To: <CAHj4cs-RqFEWFxdCGfZA7+qHLA+JJYs6qynCvKqTDdfW+V66ug@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7726:EE_
x-ms-office365-filtering-correlation-id: 77ff9e78-366c-499f-92ba-08db9a09f6f7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hQp9pb4L5ILvktXzIeL2UxrmHLSwWmxTokZ8PVd4HRRx2IR8oc6zAbpJu9Oe40Nb1/Yo8r65hbblV9Q0Tstz0BJSj54vOdf6oKqEG5YSymlK/l8OQy3OhUmkY1L8HQ2wuZyvo0+pWj8ns9L/2gKxuZIwgds8MwxBT+GH+Lhz3YQKtaltWfUrxCW7+TcUan2ghD/7/5lLwyw1hQ6BUDVbr8qyV8msw1wZYwGdklNR8rO/pzEP13x2W4Rn6kyAwQs3Qh968hsEFsopOMd4YvcCPipLAyQu07j6CSMpsN0IvdOiMY1N6f1LnZ811HhEC0VhpO+hIUYnPQF/msJ1j5tviakJmnwdq03rUpM3f2TxNi7iw3NHLK7NJhA5aiwzyA8aAH9TYjwLF9q7b1EKwEinuREizsxYxuA+uzlBCfodOvzbO/ztQYJKHHMsXdaRJai308c5EWpRocR90dtyDJ/eUxcNuipE7mlU82y0Py0nUAASU+zCn7MuYBJ4Jd5f5h1JGWf3/zICr8O0vpLzNbJ++ksjq361gmwVqm1oQIuFUfCRh6KLxQv4UTWCY6Mxn2R3Uu/5YorfGjlG1RYzFNHWdcl8uBfZ/r0PmTqnGy9m60/ey/5FQFj3JHLG9kvdX4fa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(366004)(346002)(376002)(136003)(39860400002)(451199021)(186006)(1800799006)(6486002)(9686003)(6512007)(71200400001)(83380400001)(86362001)(38070700005)(122000001)(38100700002)(82960400001)(33716001)(6506007)(26005)(91956017)(66556008)(66946007)(76116006)(2906002)(64756008)(4744005)(316002)(4326008)(66446008)(6916009)(66476007)(8936002)(8676002)(41300700001)(44832011)(5660300002)(478600001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDgwVitFdVh2VTF3Q3I5SWxIN2txQkdWTU5uMHQ4bVNabmhvMklYNDdvcUFR?=
 =?utf-8?B?OEpNZmYzcllEb0o0TVpHRXQ5ZktPeWJwZnlsbXVBVm5nTG8vVHJiby9ieGhj?=
 =?utf-8?B?TW9WTDRXaXFWc1ZjWkhPTG9OdDNSUXdUcjVBVTl3a0JVNHpSUGlmR3M2NlR4?=
 =?utf-8?B?cklVS2JucG1PcHp4VVRRYVJHaUpXdzd3R0lmbFBLUGJCV1ZMb3pPQTBqQXJN?=
 =?utf-8?B?c0pFM2NSdmdjWmJ6aGgraGphNjhXK0lvcXdnY2NFVFN0TklBTXYrSWxWWGNW?=
 =?utf-8?B?VkZZTWRMcWVieGMyeUNCaS84MmJ3VFEvL2RMbGl0V1c3SnNhUTRjbkRtbmJy?=
 =?utf-8?B?aU1kdE5xd2RjVG9NSmtuNmRiaXhtZy9qK21HbWpaSStGcWhBcGpqVTdmaW9w?=
 =?utf-8?B?QWpvSDZQeWt6dTEycHg3VEVQVWRZUm5iSlg4OXkrRi81LzlacmlQaGFPdlhh?=
 =?utf-8?B?TlU2QnRtQktXdVM2emxKNU1BZjBIUUlzSUhJcW9VdFlWSVpkUlZXN1ZyVVVh?=
 =?utf-8?B?RG1qTDg3dGZZNmxpM2p5ZjJoOWlrSDJOREZPUDRRUHNack1ac3h2cmdvMmFp?=
 =?utf-8?B?dWJOVlpibkVVQXNOM3kzZmwvZFIreTIwWENCcmRXK3Z4MjBSd3FBUDFSc0h5?=
 =?utf-8?B?NVZTL0tJUWhJVE1lZVU5Tnp3d3RRNkZCN2NLNTA5cENTYkFOME1IaEJDQUQ0?=
 =?utf-8?B?SmtuY3hlQWZjZndYRGV4cTN5bHhzQ0UyZWxXMDVzcDlYVFFXTEpGQk45UkE2?=
 =?utf-8?B?aTVnZ01xem9NdlV5dGphbTlxaW1mRCs5UjNxT0NjQ2ZyakI5OGRRNHZQMEo5?=
 =?utf-8?B?MnNDVnVXaHVoZ3NCRXA1K2pPRUVqRDZRYm4wdFJUMmU1SDhGc0N2TkpvRDFN?=
 =?utf-8?B?Nnh4ZC81YlcwMVNaRUdmcndLMkFuMnFJTVRNZjdBQXh5dG8walI4M2pRcURx?=
 =?utf-8?B?R1BtVWYvN0tUaUhPQi9CREs5Z1NaUTJIM3dVaHc5ZTVhUXVWV3FFZUNtUEY0?=
 =?utf-8?B?alRDeHVRcTdKSFVacTFuT2UvSHV4ZThHUmZ2dGRSMzVsWXlHdkhEbnR6eXcw?=
 =?utf-8?B?OFFmTkdkMWpqc01NWXgrL1A5cHVLMm1CaDVxank2YWxXQ0xZZC9LekZSR0N3?=
 =?utf-8?B?c0VnaWV4bTJNYVZGVnhkczZsQnR3TmpCdk1MQi92dVZSUUV6NUY4WWFLSURG?=
 =?utf-8?B?Q29JajNUREVjWm1CUXc3MEROMEdjbkU5VTBKUWM5WmpvMTdRalg1NHRmbis4?=
 =?utf-8?B?M3VGMzJWVkl5eVgyTXBxaWx2RmxpUUJuMlhsWDdnTEtMSWNObjB3eFhqdzJK?=
 =?utf-8?B?bjB2YWtkWVo1amlVVDlMOUZFcFF5NDlsRWZmUk1NTjNVa1dWUlBMZEVYOGlM?=
 =?utf-8?B?SE5XMlVIY0lPR0VPenJZMUdxeTFjM2g0UVhOQi83OTJWZC91ZHJtN1pydTFx?=
 =?utf-8?B?ZVZ0MGZEQ3RabEM1K3BPWUZlOFRxMHViS0xNL25LUkJsWDZuQ29CWVZGTGZI?=
 =?utf-8?B?Q3BMeGZhVEN6cnFjd0djTlVCT0dTN2RuamEvbFlvU2hhcGlyTGozek1GZkVu?=
 =?utf-8?B?bVJURTFoT2pnamNWQk5xWEpLM0JZK3hJRXFYZWlIZm9RNWJJU2xGczZYRTlj?=
 =?utf-8?B?Slh3KzdYb0x2dWRyRHZZUE5RRXprZXFkYVB0WkhvdEpQRzRzYW5TWVZadlZo?=
 =?utf-8?B?RC81cVZjL1FKbDVYcTZneVBWOStudEg5a0Vnb0MvcjNGcjIyQ200K1dVUDBx?=
 =?utf-8?B?OGUzQTBSMkxxajlHcHYyQUx6SUpqZzNUcXR4NXExK0VFMlg3OHZJck5UWGpu?=
 =?utf-8?B?TGtBNURoaTlpVzVrSndOQ2dmc3lWZWlHSTJLVzJKeko4ZWN5UkxFN3YrSDRt?=
 =?utf-8?B?K2Z6cnVmTG5RQ29GYjNqU2kwSjlwRWdoWDdvbXp0ZnFWeW9BMHZGeFlLWlJQ?=
 =?utf-8?B?ZVE3Q3ovZTlvQUxEZlpYMDBCWUpEdjZ1T3NmOWpCdCtocDlER2dHTHNJb05r?=
 =?utf-8?B?eHd0dUp5cVhML2Z1bmhER0xjTjlBVGM5TXIwM29OUnFIT3J3emJWMzNQVG8x?=
 =?utf-8?B?bllSQVFzWGV6QStQQmhzMkh2S0lmcHE4YVFBOW5aZFowVnEvVVlqUVZGeDRy?=
 =?utf-8?B?ZHViK2N1c3hKVUl2eTZFNkpiYVlWcWdKUEdDV2Q4WFR5L2M0TzZoS1hkRVR3?=
 =?utf-8?Q?udTdSYTUrHTWMhrnJoClQuc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6BF45FAC5DC23449A7AC2321441E6AB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AQ2advRn7trOFumW6Zs2RIXXaqWckIY1zn6ggNJNbhCtcPJEzTDQcIQhOORDrworucYNe7XGKoFliomNB2UTqaM58wx+q6j3jxxkITD/rLKijmxISV98wAuoq0qTYlMXfoNaBTkib/JizwTR7jAE68qHTBvzmbV5mXYGK5kzzEOUEJVlMKSFJ9KZ/xA30N54zz+Z8hdL/QhLwMUZzLT6BDYfw9LseHtN+FbOauUpQ1ptf5CafMexqNUqX2U4FuefKxECR2xUTuu/swkW9IRm6E++SAt/S3+cr50faNiGD21cjwNy0QSjihUKUT8KcGDrCdsj57Ro2g9209LraK5r8z9VKfo6XNZGZ0MbIXqTPzAHvzAvxoPRQFN9AxyZUF6YVbWRPRoR0hhCn73NQgGHmgOklsyy76QJOsLOYA5i3W+FArei620Ev9u+bTFBQhaiUyv0UteGiugtyd5BDKiHiyi9ldWamsypSvNxJ9+LCf4VJYHh/B1XBRrKUpMtinGsoMB/PH2/em6JRWiA0lxPZQ/tcr6XRG6l8u8eMZasNMjS8L25dIMWbK0aFZOJsEJTt0+4Hr3672n6z+Z7n4xkDNCTn5bNg9u7HCCYkEdifryB/kcgO8p2Z1XCc3y6ejJm18TavQRdNTXMCMXie530luMjqwdWxpNvS5jgllo8/BIfwGXdgncW79ucYgosTd9xsIZOw4adX4V0O1jxFtpxIIpyDjp9F7rNIx6lgaI0kJAN1Uph7bVxuw71Z1ut+0NnjrcQDWRp6QWxCt9ooI/r1R7oOgCwHNDD5BXnZzaoizQvB/3WVPKGzk/yQhqL5Qq/TR1bS/E6fKcKcmQCVCVxqg+Yb1wI/1r+vrvTm0NUBx92aiC/E6wxU4rOT9Albr7Q
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ff9e78-366c-499f-92ba-08db9a09f6f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 01:26:19.1562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aT8G5WTkros3DpsYMnoQXz2B3ALtF21xOQHfBCudTP46SBaY6JchYPUwXuI41D6OaDQCcc5wLrKQIJq6JdpVxffyZ7DPlQSNQnGI5qmDsxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7726
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_182624_460669_6EDB965E 
X-CRM114-Status: GOOD (  17.10  )
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

T24gQXVnIDEwLCAyMDIzIC8gMjI6MzgsIFlpIFpoYW5nIHdyb3RlOg0KPiBPbiBUaHUsIEF1ZyAx
MCwgMjAyMyBhdCA4OjUx4oCvUE0gU2hpbmljaGlybyBLYXdhc2FraQ0KWy4uLl0NCj4gPiBIYXZp
bmcgc2FpZCB0aGF0LCB0aGUgZml4IGFib3ZlIGRvZXMgbm90IGxvb2sgdGhlIGJlc3QuIEFzIGRp
c2N1c3NlZCBpbiBhbm90aGVyDQo+ID4gZS1tYWlsLCBfZmluZF9udm1lX2RldigpIGp1c3QgZG9l
cyAxIHNlY29uZCB3YWl0LCBhbmQgaXQgYWN0dWFsbHkgZG9lcyBub3QgY2hlY2sNCj4gPiByZWFk
aW5lc3Mgb2YgdGhlIGRldmljZS4gVGhpcyBuZWVkcyBmaXguIEFsc28gSSB0aGluayB0aGUgY2hl
Y2sgYW5kIHdhaXQgc2hvdWxkDQo+ID4gbW92ZSBmcm9tIF9maW5kX252bWVfZGV2KCl0byBfbnZt
ZV9jb25uZWN0X3N1YnN5cygpLiBDb3VsZCB5b3UgdHJ5IHRoZSBwYXRjaA0KPiANCj4gWWVhaCwg
bW92ZSB0byBfbnZtZV9jb25uZWN0X3N1YnN5cyBsb29rcyBtb3JlIHJlYXNvbmFibGUuDQo+IA0K
PiA+IGJlbG93IGFuZCBzZWUgaWYgaXQgYXZvaWQgdGhlIGZhaWx1cmU/DQo+IA0KPiBUaGlzIGNo
YW5nZSB3b3JrcyB3ZWxsIDopDQoNClRoYW5rcyBmb3IgdGhlIGNvbmZpcm1hdGlvbi4gSSd2ZSBw
b3N0ZWQgaXQgYXMgYSBmb3JtYWwgcGF0Y2guDQo=

