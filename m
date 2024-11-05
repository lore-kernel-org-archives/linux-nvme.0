Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F4BD2C13E
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 15:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AMGotsqNeTx/ubHImRGkrUNQ7VIPAp05xnXyHmBTtPI=; b=3hLfSHxUhjh7JU61LCJHVdZEdr
	2sJdbB/gBo7up9U7IH3k4+tFPbxufGHCxGYnrycomCiZWZ2bd6dH+H2X7FlBD6N85efQ/NGPTh4tm
	w0YuNv/2cAQR43jFX5GTD0b6do2YBBQkDZYGifUUKlW/Zzodj/P013d/6MP8WAbdT1+TWu2lLj9s3
	h5IOW1qqzNsGeXxDAxnWpi/uLuarLaYw8KXcMhRjrbp0UYeO0HuOFMfCrvhS30p7Ar1jib1JgvNkT
	/ViIWew+90H0i6Nq0HQDinKXYdB4lENYxxfZaLnZIfYCRf9Co7rXP9LTAjrpX0As7OIHerWVtdcPa
	4S/V26zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8LqP-0000000HUyZ-1wLe;
	Tue, 05 Nov 2024 15:51:49 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8LqM-0000000HUxT-1yph
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 15:51:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730821906; x=1762357906;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AMGotsqNeTx/ubHImRGkrUNQ7VIPAp05xnXyHmBTtPI=;
  b=p0pORg+EV56nmz3ET7Z6Dz31uW7DvhZeQ1ktei6hoM6s2sMzFo1VLeMU
   D/hbjnUAgt5+w8KR36Xijk12G2PuMbxdSQG/FGCkXa/wd/6BYRMYnswb4
   YeyfF76+V9/PVHOBhwVfcBgoW1icIdXeBh946ZYSrc3s7U0lsx+OZ8W4R
   Y0pdmMTJyu88flEXIByNqqWEVbk2+4jWVB7UpgHN4hYfR/w8J6TUpcHKU
   iEdwTlmHYtCHLAx+9Pb/X/U5wuIOK/Hqht3X4O7+gxLW8q8UpMD99p63v
   asVFz2M5PBoPEY5odoeXzQOfs1G8kFAswRKpyVR1Qo26URWFiTrFUiStR
   w==;
X-CSE-ConnectionGUID: LltQJaeKSL2NwT54vP4Ocw==
X-CSE-MsgGUID: 0/CtYQ3oSf2fIDUTsyZCYA==
X-IronPort-AV: E=Sophos;i="6.11,260,1725292800"; 
   d="scan'208";a="31706642"
Received: from mail-southcentralusazlp17012014.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.14.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2024 23:51:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSmdjbiS7E3NvFVUGwQkoBX5OSj9lVfwC9Kz4EChlSbMjQqG6Q5dST+KNE5z7vIsCZlUbt/Dntov+akSGb5fJ8pAmFO9r1upHySVMdNNKh5nbFG+TcaNQfvCZLgdr1sceE9naPq/p2sGuSFhE+XTxjDs0NGj9wLgAb3Z/STMA1EoPy2jaA3UJ0ytRB2zeR/72Xw/IdqLuRCgvEWacsDL6gfE+dO7tYq/YTEvtXUlYXNFzPZh5vYGuq9v6/0gJA4UCXfgWq0NW6Q8WtlSMoyhTpSb5AX854I2mRhlhGfndJ0ZuVE7bX9b46rCXcNhvsMzQlfe0YQ5L0GfelzNLdbmhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMGotsqNeTx/ubHImRGkrUNQ7VIPAp05xnXyHmBTtPI=;
 b=Wgpfnkil3BLmYMlqFp6ARPdnKzJAQ1ohteOHszspbxNh18UKIPAneln3UNMX6qtnlmVrvt89TZVA1eqVeicSIidMWywPnkMIsfGwIgJquN98TQqk5LL47yTXAJz4nUeQ/91zPdvtBKc+uYLxqLNda2u6pIoU9HGOUtSYAoybmMucijRrIBl2eQuTRI7WjZwifnvKbpDSxe6tsZHcCY9D0IG6/bS2n6gexpDdxWFXcA0U2EfNEhgXMnLPyOzHUhUrIRhMqGM9IxrLp4LwDrbI84hOBeyrWo7k5A6RtFbQ2TsMh5ymDFpqM+gMQix1Xi6BPPZhMXpo/j/n5fx/bQ1drg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMGotsqNeTx/ubHImRGkrUNQ7VIPAp05xnXyHmBTtPI=;
 b=SLPaVI0Jikh8SrIkZ4TjAu/MOa/+Q0ByI2+yPv+MqmYjdKa1oNEXKZG+aQwmqrf0vmbXRbffwZVgAs0vKtl6biSmKbzfhnv+RCxyV2BsWgJlTVSzKPybhexTIZKw3ft8LgNgkucXYFM1yP8MOB6RsVOTz5XEUbamOyxHbsLgA+8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH3PR04MB8864.namprd04.prod.outlook.com (2603:10b6:610:177::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 15:51:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 15:51:41 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Yi
 Zhang <yi.zhang@redhat.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: max_hw_zone_append_sectos fixes
Thread-Topic: max_hw_zone_append_sectos fixes
Thread-Index: AQHbL5otJSEE3a/5UEGqICCX/lmIKbKo1gAA
Date: Tue, 5 Nov 2024 15:51:40 +0000
Message-ID: <4eeeed25-88f1-4b29-9d17-65d44fe37a75@wdc.com>
References: <20241105154817.459638-1-hch@lst.de>
In-Reply-To: <20241105154817.459638-1-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH3PR04MB8864:EE_
x-ms-office365-filtering-correlation-id: 61dc2d54-b5ff-430f-da38-08dcfdb1bd83
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WUpjV0szVnhVUFhjTGhVTEJ5WExDTFhSNzVqNXNSaWJkUVJ5bERYVGRNbTVx?=
 =?utf-8?B?U0lTZElWOTh4blpvN2NWaU12ZlVxNzU0RFRJTkxhZE9MdGtRTG9USWVQWHhP?=
 =?utf-8?B?OXMyN09Nayt1NE1vNnpNek9RU095a1dLWENHMmFTKy9nc1hEWkFSR2ZCdmR6?=
 =?utf-8?B?NHlIMGl6ZnNLb1d4MDJTVEhrckdHR0hSb2NNVTZ5aThpL2ZVUFpFMENGbjRx?=
 =?utf-8?B?MXBYRnJEakVQYVEvNkpEcHFYb2ZmTkdFODFzUVYwYXhDbWJjNFFNaWY3WUd4?=
 =?utf-8?B?S0xoZlNzVVlLTU9VdUIzNitEQlNhL09lUGJad0lIcEZ0QjdQaExkdGZoakxG?=
 =?utf-8?B?R3F0R2Z2RXJERjVRZ3BDZjRnaHB4TldPQnhxMXJtSHlYQVpFQmx1VUtCSlJP?=
 =?utf-8?B?dllBdUgvVW1wUmswb05aODkrWWNCUkJzODhHR2Y5V0tEaklLaXo1Uk54Vi9s?=
 =?utf-8?B?azdlL3FER3pKV1F3WEZ3MGdsbys0OEJFZDNqTWNKT3AvcUF4eXowa1MxbzNI?=
 =?utf-8?B?elgzSGZLVDZnc3BFMnQvR292OG5lbit2dHF3Zk5tYnBNR0hhZU9PUCtITzhE?=
 =?utf-8?B?VElVcGE4cDZaenU0dHhoekh0TWdYWnRPSnVJSHc4aklDbFFIU3JicGtEc1Nr?=
 =?utf-8?B?S09zV1NUVHZqZXVLVjJ5ZnJqSkZwbkN1WFBQTG5rdGxRbTlTcFo1bkppZ29B?=
 =?utf-8?B?ZkZRUGQ5NWs4Q1EzaUdJbFR3SVVLejNzTGJYaDVVbWpyWDFVYmp0dmg5T2F3?=
 =?utf-8?B?UWxYQ2Z1U0xDQ2R0NHE0bVhaSHFFQlltSnhOVXBjc0lnSGVrS3VtQTh4Y3h2?=
 =?utf-8?B?bFAvNFh3YTBwZm12ZDNuZmlFRWprZzNPMi9iVEZHZTFxeS82azQxRW80WUhv?=
 =?utf-8?B?UlVaYWVGSFlDZG95MGQxVU1COHc5QWdsd0N6bmREWCtMYkprNjdMN2hDMThO?=
 =?utf-8?B?SWxFaWFidlpKaFpnR1VOQit5Vzh0WVlLK1FYL05SK0oraFZ5TDZiUDRRVUpU?=
 =?utf-8?B?TjFncm4vcXpQTzEvVnFEUXhzWWpyanJxRnRYNzlYbEYxZ3ByQ1lOTzFVNDN1?=
 =?utf-8?B?Z251MWdkaFJ1c1NMblFmanVNdU04eUpPS2MwSnFJd1Fjc0RlRXVsUjJ0SEJP?=
 =?utf-8?B?OWN4SDRkZlNIejUyTElWa3BLNU9UNHluQWFIdjUwU2FVKzhzdDNHTHYxRGpQ?=
 =?utf-8?B?TzlFZy9hR2Z3bkNvU3k1QWpPTXQ3bjJsR3ZYSEdYMmwvMG42N2srWndlenRW?=
 =?utf-8?B?NXYxWGN0UUZnNkgyVnB1OTNRZmNreGNPcDNnV3ZCL1l1cG5rSlpjaHFPWmwr?=
 =?utf-8?B?bi9LdklhMFRYWjluRzBYZksxNGc4QWdqTURiUEdOdWdBOWd2YThWRTZkNXhP?=
 =?utf-8?B?em1yV0x3NFNwV0NoeWRGRXd4OTFhd0xuNTRFSkh0aW9RaVBqZFQrMjQzbWNL?=
 =?utf-8?B?cG55Q0pMN2NGeGlLUVpYUHlLekJkOUdTTUl1Nkh5K1h0a2NKUEUwaTlxUm1z?=
 =?utf-8?B?d0ZFNlB0R2hGcCtlNlpmT0hhRkhpZlVQTUtYbkJtdDc5UUxKbHk5RE9MbGpn?=
 =?utf-8?B?L2NvMENjcjdoT0dmV29GV2lOT0drVlZzdzU5NERvUGhjc01vTHBNSWRxSk9C?=
 =?utf-8?B?UFN5MWR1WE0yRG12Y3Y0RFVkekhZaEpTMzNsc2cyY3ZUenkyNHFvUUJ5YWww?=
 =?utf-8?B?SVRmS0lERWxKaTU3dnVQeDZHWmRBNnhpVVV2Z1pZbUgrcFY0M09nTzVtT3pn?=
 =?utf-8?B?cGNFMmZHdHl2aDd3OUdQbVYyeGdDYWFkZEZ5UVlGV1JiMVZRVHZsQkgrRUJz?=
 =?utf-8?Q?/AdGirLIvjrUWufvJeb8StTzY7XNGQyi57LhE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NU9pZG9wRUxYVjd4TUpYTzljV3ozQU9ObzhDUW51K0syOG1uM0FkMlJrSHJm?=
 =?utf-8?B?eG1MUS9jLytReExQMDVodmdlcm1QNndhUFJmSnlMMDFEVytOSGxyQnpaTHNF?=
 =?utf-8?B?cmdlVHduanFaWVhxdkhnOTZQalQ1NS95eHdCQWFocndSaUF5WHV5QjE5WWhI?=
 =?utf-8?B?NFp1ODMwY0pneVIxc3YrSlBWNUJrSHpERTV4bE4xWnMxMlgzbStIS0YzMmRt?=
 =?utf-8?B?eThPaVh0RFIxaVIrcXlvcVhRUE05VzgxZWlVYWNJei9ndlRwSzNlRWZvcXRC?=
 =?utf-8?B?c2l4YXR1RFFTdmcvamxHL2ZmdVpNYXUzejhKTjhsZ0tyK3hlNjlnWWx5ZDdv?=
 =?utf-8?B?ZGVRTkpzL2VtZEc5blBSenVXbWpicTEwWHU1TGpBY2gwSWRNcU1KQ1dBNnN2?=
 =?utf-8?B?MC9VclgyU3VOdW5yMWRmaitUUlpWbmNSTTV2UkVlYlQxb0h4U3k4eFplTEs1?=
 =?utf-8?B?SiszMkpobTJTMGtYd1UxcjhEVElBYTl2YStjdFRhUWVBSExJempybFpHZ0g0?=
 =?utf-8?B?S2hWKzdheFdCMW1oeE44WnE0ZEQ1RVlBZ0pyUk04NFZlQ0NxM1BYdlhseTBr?=
 =?utf-8?B?bkhrcVJlWDNhM1NXSWxQdUNkUXRIQ0FYdlZOTkltaDRVaXh2eE1ON05HM1Qw?=
 =?utf-8?B?eG8yZUNlVVY4b1QrdDIyc1JFQmQ1LzAyOVFHQ3VMMDVYV3k1OExCNWNkSzZp?=
 =?utf-8?B?SWtoMVUrUis2VGhGamI1d0phSmxsdDR0ZU5tNUlmcEZsMVJTMk45WGFuY1lt?=
 =?utf-8?B?Uy93NHVOdHlmV0taSDlIUkJUL21DaytsMUpkNk9idWI5a3ZxdFpIVFRHQ0U0?=
 =?utf-8?B?b1l6Uzh2UHZHRzBIVm1MR1NhOVQ0cWxKRmFnSmx0OEkzYUpaOU9mVG1ldUxW?=
 =?utf-8?B?R0lZVDI4dGtZeko4K01CTnNKZDBKK0M5bnJBYWd5Yk9iekYvSWZpMDdLcUxX?=
 =?utf-8?B?bnBnckNGSTdwcWZPdlpEbDJ5L2Z3ZWFJbXpGbnRNV01QdjhPK0ZUUXJqNGla?=
 =?utf-8?B?RFU1VVRsa2xFS0hSYlJDMHJIdjZZOTJNWGFXUUdLM1NZMnVWMTN0NFY5QnZH?=
 =?utf-8?B?c1hrejdMY2kySUxCd3ZpMW44eXk3VGEwd28vTzc0dkg1bVk5SXR1OU9COEpk?=
 =?utf-8?B?Z3hQN3RaayszY1pHTmZ0UzFwSjFqU3dwSkVwM3FXdnhvUWorQ0x5cXV2YmI4?=
 =?utf-8?B?eFU2QXFCQ1RkRmN4aDFkcEhEV3lFY1VDR2xlZGRKOWQ3OEp6MEtkQmpkblFT?=
 =?utf-8?B?U1AwbXZ1amRWelQvTmFHb2JIOEJnZVRJMDh2WE03U1hycE9ZM1dhNVcrclNZ?=
 =?utf-8?B?QS9oZllIajh4WFJDUVVGREFLNzZsc3RTaXQyZEM1RGtQVEFpN0FkRzd6TUpt?=
 =?utf-8?B?UURCOWdLR3Z1dS9DM25PYk56ZXdJY1ZaMHl3cEVWSk1WNTFKd0RZdlV4VU9M?=
 =?utf-8?B?NStjdXI2eUFqbmFVRjFwbXdFVkNzK3JFaW84MUFKNG5pSzA1cDdPcDEvTzZM?=
 =?utf-8?B?UGVEZzQ5dHdWblc1bmx3K2VaT0F3SlJhTW9xVTRyYUt3UUdzcmhCQllVNE5m?=
 =?utf-8?B?OG0zL09VZ0E4T0pPWi9TYTREVnpzd0NqcVlWWURwd2ZoUzUwMmQ1RWRRb0JR?=
 =?utf-8?B?UWRlanRQZ1BqcVdjY2F5LzhpVkNpR1pSckpzUGprZnVnZHpMa2cxMFpOWW1I?=
 =?utf-8?B?eHpDYTRHbzJxRmlWVFJNVFExc2NQcm5lN1ZMWDZWRlNMQ2FKNVhqNXpWKzhN?=
 =?utf-8?B?Lzk1cTZuMUgrUkdZaS9wSU9VRkhjRWFZeG53S3l5WjhsUHRURGVQUTRDcVRj?=
 =?utf-8?B?elBlWkZoT1NXVWNmTjlKNzRONWhMK05wbm9BUDVFaUQxUnRYZDBFK1ppMEtW?=
 =?utf-8?B?ZkNsS0J1amxFUWYxZ1orcCtBTmJoMkFEd1NPVjZEZVA2MFg0blBNay9UWjRs?=
 =?utf-8?B?OVloTFJUS3RXTnl2eURzRk5jOUFKZnVvcWMweVluaXVFcHo5V3dhYXF2Tk9l?=
 =?utf-8?B?QmlxM1IrZmlzbEphS05DbkpBNUI5ZjRkUU5Kby9QZEhKYW1uU2FWVlZPejNv?=
 =?utf-8?B?a3dpRWVRZEczTCtGWjF2V0dWcEdrN3FTR0w2QmZhSmFNYzE3WjhNcFJicm1G?=
 =?utf-8?B?QUs1dXBGS1BvOHRhbG5naHNsODNrbEZzbEF3VU5kNGw1R1NvbWwyK0ZtU2wz?=
 =?utf-8?B?ZlU3SjRHSkdFMi9vRDJ3aG9KRUFENUJVeEFZSkpsNzJRZnBDTWhNT2FDUllZ?=
 =?utf-8?B?OUtmbENpaForUGtJWmlTTnN1TVZnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B76B818216C7164189B65DC08C5D0267@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zn1Ga3xCIo+Vd11d0Kj1dz4pshUK65QX/oVoDlbd0E3ghVZ1dKgBOQSfFxSarkSRspLHqjpZAA1V6FOtGrwKhHb5OQx2ftXnJQNhxWci07W4TCfMBJjUd796ezx4AFr/VxZ+o6aRepo0YqWTEM8RKlRPd/NuO2YUoCydly+cf9ysMEnu+O6duL/nAZRG2aWYeqWMJemWN9ZvO3mXAdgZ6oUKpprZ80gAKeNrbdUEigMcCpiTAYH4ljFUTGwd8E7HRWGWXqTfi071mYAl2WtFvWw3BLqWDek/Ab7MkknvjEC5NcSVTaoWoOOtv4NFPtwia8nkNrBCGpi+gnhlFgbe1npI4OG44H0mtxB8F2qt9FB8H8pWynF0TECP1dzEnFaH2HgVu0Vj28C06CTRaIYnCuXb2rglZZikJ+9o5e1tdHYrbTq12ww5nim2kQRm0vkJ9f3AFXL+QE6ySaZ79aqwmEABxoG4kfxRtO/ZVZweKqCn+hiH2WikOoLztswrm0vPdX8mN4iZVuqxZl7rZRObVhKHt5cHbh/+sSSP9FqenMnvJzSsFVf0CDUk5vurS9ornzsVT/ESxLJtX2Ybp3pCffc1qS52E9xA8kfyrZpG1igkXmzzSyHNJj5E6WKqXZMP
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61dc2d54-b5ff-430f-da38-08dcfdb1bd83
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 15:51:40.9933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FaTpmk8w6AP9xbHUr+/MLnTmDO48Uh9Dvxj/FFtoJ0CATQe0uBr/4mern2cgWiWUV7NzD46lXrRsvHqYM3hyy/zLpywnxZ5gSEUMSu4umHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB8864
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_075146_566598_FF039185 
X-CRM114-Status: UNSURE (   8.15  )
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

Rm9yIHRoZSBzZXJpZXMsDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5l
cy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==

