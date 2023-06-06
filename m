Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD1FC77B7A
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 09:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J5PcqmNFzRaoVJ42UIr1rb3OHXTHAheZKq7poYpv0BA=; b=Z+xWs+3cMj/1ljg7OGO8vwBaob
	mMZjz+2Qy9OmX7pE1n/Vb9r/WIUZmQJivg8A4FW6rw+xEVYmJ3hFPWMS1ACZ4NDcKarKDg/aI3M+1
	qy2UFel+47iymyXE7V/fWOBtCN2P+wx+4ArMXx8Q3g6XPm58nQROfF7zEETiCOM2yF6GktkSjB9GL
	Vw/JIJQaQzr+AZCmAXHFssbywYqLCfPo1hHFrvPrXGJJd9pAyJZtVseKmhnfS6A8cmIdKzxd7tke4
	YICbQbymHKwaGbPJUH2o50rEDGqWd55sXmOH27zCu9Ekj186X3GwRbfhb5uUkasDSW5bDYMZXLtdb
	FBoqxSTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6T77-0011md-0z;
	Tue, 06 Jun 2023 09:36:29 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6T74-0011kF-1u
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jun 2023 09:36:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686044186; x=1717580186;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J5PcqmNFzRaoVJ42UIr1rb3OHXTHAheZKq7poYpv0BA=;
  b=JE4uuHH6JesXNl8rTo+ShLI5CSQaCTH9ElFv61AFIzPOWuadrSjz1xC6
   F/TRXwW4usPnmuL8rhSuifsfoNRMDmhcpVMrWUBMF0rBLfjNrVALe0URX
   d2COjXL5+8wddl7rQY4ljFJfT5QoRkFdCBKXSOA4I0lH772b9oK0FznCK
   hMGHcFkzHj11RyiRWI3OsAB8dHYfcZXHEIF5YoP4nRbDWigOu80WXBkY4
   v5Y6L0rZVZeKfB03ZhzPjQkEZN9lPmYfipCTwrQDigSwBmC+lMi7T4gxI
   3qrLHQGsXGJo7GYN0SR5WJg/+MlpqHv+zCDOFVFnKB73SkH2/GgPybhY5
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,219,1681142400"; 
   d="scan'208";a="344777169"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2023 17:36:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWKuLX19Fv71cCknzrxI9bp/afe3NfcyWbdBYyxtoS91SzGGY5ohC/icm3g+FSTN2fKe4ae8KkaNKTy3RzY0x/ZzBxvqXpkdEMZiaZtzaQkz5ozLQBYGKPvjU/Qkd8B4hEoqz+MVNyPWXM3ytDZ0a79BOWJgkykUt/Ty4Ll1Gl8C+j2xfCF0CmOjXaBD4iPIUwvl6iw9vJri78jyVWXIDpeQ7rYpwGkYPd6mqMUSEQXnK8z6yT+ehBaXC0Esy2w88d1zc2rBKG4pKBUhmwB8HPfT5eIwTtVhHyNMuQzVW/amfgYLsvDKVZmDX0UYgEh7UM23hlKWjnoX0tXGEgkdVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5PcqmNFzRaoVJ42UIr1rb3OHXTHAheZKq7poYpv0BA=;
 b=BrLWfTaJ6B+01DEq65JZxGMErnEulydlllmVJoINxPnLNWJz07HB4icfqmu4eVRrhFgtTgS/9k6o6XqrHzBvImrvl5CDwyw8ogafLOTnghCRUSFQiSK0ZbEkkqFOsWp/mOGKcgac8vrNOctmPj/MG/f97pcdQ8nyYqrQOR2ibSCl8QQXhaiHR3i4lp5tJMgG9cvrx6kNB6X3RWieaiB+msvmoRd658lobEgNgMqtDAIyZ8o37k+83pFE5cJmgEf4BO63vW60W4dzU/DxlS7fw37s4MfJuBh3Gdv5s1s3jW10RNrMHG1cejkU1EHkKb+Xn8Uji5mlazVW8KKVvfdiVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5PcqmNFzRaoVJ42UIr1rb3OHXTHAheZKq7poYpv0BA=;
 b=yOajHbh10utvevUynQrZ0QoFoUb4jxaiXK8ourVu35IfswBoNVBnKBvRzzTDQChbnrnQ4+YYGUw2P//zMqlpqy/4c7KxCp/gkksH25k+RUAEvw05llkDfkw7Rxp/JWP9wof4UGLzSWVXyRdzZ7lEeVs8zIHKe/WoIPlwnIc3xc4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL0PR04MB6515.namprd04.prod.outlook.com (2603:10b6:208:1cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 09:36:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 09:36:20 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Daniel Wagner <dwagner@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Chaitanya
 Kulkarni <kch@nvidia.com>, Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Hannes Reinecke <hare@suse.de>, John Meneghini <jmeneghi@redhat.com>
Subject: Re: [PATCH blktests v1] nvmeof-mp: Remove nvmeof-mp tests
Thread-Topic: [PATCH blktests v1] nvmeof-mp: Remove nvmeof-mp tests
Thread-Index: AQHZmEy4ij2LPkGoWEi3kz/KoxMS7699hBiA
Date: Tue, 6 Jun 2023 09:36:19 +0000
Message-ID: <a54dd474-5897-7f8e-a977-883cbddb5981@wdc.com>
References: <20230606075443.17437-1-dwagner@suse.de>
In-Reply-To: <20230606075443.17437-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL0PR04MB6515:EE_
x-ms-office365-filtering-correlation-id: 1bb6dd75-f2b3-4d82-1cdb-08db66717bf6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j0U3ajv4QoUWSyxTuX6kDg/m85AXI5KcOwMnRUmdwkTfeJ65+p6mjjk9Arl/0Y7SXyM3EhKhnEAQf7aPBSZopAbdZVm9J/Lqb4kICOeywV+IlQaR1xrVBOTjEJ9So+ih6iF1F5P0L05jWVt2w3BSYUOQDwz4L7KBVBEhv0GtK30yWx1VTP1L5eOR0o4sYkoI+04dvClmt613XlYLDnDR3nOP3DP51i18qFqEaEkm3Z0IIcUpjWlh7cVyqjgobUZoNRE/2ymFqqm/8dkP3x+hdA7/ci3laOm5N6UIlE/OHJKv/UVSy0xtB8wRvmV25F5w2MF3nrfvhEw90I32TIT+B6SAMr31xN9eAEmaXDvLBDFPmvf+DCbqGO20zwEs8sbk0bgu4owXfZz6Z+glpVhNMLZo2roj+xD1kT7i8f2OpZXyaRp94zlW3MyaMGk4c+3SCW1AMZgHxfI4GX+UuFqtO0MIsMPRg0oH8f9H7M2cUDoCAUD75EWknqShBrEKlD1Lw7Yvgl3RpFkGZmRjYtgmrqBjMN4+Y4Sv8iEqtvp8gbYjsKj1Ka3BsikG3CrZG1CB7I7umNsO0LvC/W3N4pg2d15iToxGLwmOA6Tg23IRWLo+/cLOZNKOlspOHxBU5gxszTWqgeVvGMPd4I6Ax30aRT5/6j/rCNPNoo7Hv+Y5yLswDI3TPjD2r+T3jiBbnJF1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(6506007)(186003)(4270600006)(6512007)(2616005)(31686004)(6486002)(36756003)(2906002)(71200400001)(558084003)(8936002)(8676002)(82960400001)(54906003)(110136005)(478600001)(122000001)(31696002)(38100700002)(5660300002)(91956017)(86362001)(38070700005)(64756008)(41300700001)(66476007)(66556008)(66946007)(66446008)(316002)(76116006)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmJoK0lIRVpTaG1KbGRwN3BjZjhiOEtWOGg2eTFWVzVhdGczUkRuV3NvZ05M?=
 =?utf-8?B?WjFtRkJBM21nQUdiZ2lOd3JnTHY2c05nS0VUZUt3dHBOZEI2TDNuZlpYWm1k?=
 =?utf-8?B?eW1TZFMzRU5XcUtWZHhPTHZlM2k2NDRoVVdyL0h3WDJxRkZNU3JrZG52QkYy?=
 =?utf-8?B?MFlSYXdLYjlZOVYzMkUzZFZLZU9ZQ1AyRXp6VmJEcW55d3dpYjVNMmFOZDFw?=
 =?utf-8?B?Z3VRbUpjaUdtVURYYjVFVk40ck1qbklXNWZXREwzdTVDVFdEUXN6bDRTN3M3?=
 =?utf-8?B?U1lnZXRpbFpMZDdJdnNLQVFCNElwbGVwNDl2TElEQVVqSURvdXBxRDlVNjBx?=
 =?utf-8?B?d2JpT2ZGMDN0ZjNHTjlGem1wcExnMWhaamIzNFBVY3AvdlhROWlSbFVSQTV3?=
 =?utf-8?B?MnI4cG0wSGV6RCtGTjBOYTNHMUI0aWgzRlQ1WEhmVDdzTVR5MTFqNE1UTkxz?=
 =?utf-8?B?STVldW9Dc1FNU2ZJZHUwZG8zNXV4TEdlRFpnSC9iMXN3YUpWYS8zd29JdFA3?=
 =?utf-8?B?bERJdWVZcFdjN1ZPMzZScHppZlloWkZyd3JrV1ZCcXU4bUJBL3VTc2NQTmVk?=
 =?utf-8?B?OW9UMXZnb25rUW83YnRyanl0MThOS01HK0VnR01VbVFWM1J3RGhXVzROLyt1?=
 =?utf-8?B?VmV2RkcyeTVBUWdCY3VxZDVpcmRhamRYWHRtQXN3aE5JV09kZnpkek5udnVz?=
 =?utf-8?B?S3lIbVNCRDN5UXRmTkVXb3V1YmFrUDNLanBvLzY4aWZaUTVETTRwVEdJWXE1?=
 =?utf-8?B?MXhZVGJMOG1WM0Z4ekoxY2ZjNkZSK1g1RGt5MWlsSG9wYmhyZFFKNDBpYXdh?=
 =?utf-8?B?eCtRWmQ4SjhvNWJFL3pBZytHOEZEdW8zd2lOOG1UK1lMOEVydXB3QXIwU3hz?=
 =?utf-8?B?N0J3Y25ET1ZKUkhNMFZSc0o3KzhzR3NLQzNOMWtyb2ljQy9ONE9tajI0VkVw?=
 =?utf-8?B?WHFVQytqWXN6ZkhEVzV6Z0hZUnRvb3JVSU02cmtuQ3JRMW1lcGVzNEdwcWha?=
 =?utf-8?B?QzRiUW50U0M4M2lOeFhGbkJnT0xjak1YM3RvUW5CdEdUMlIrRWRYdVpqTVFJ?=
 =?utf-8?B?by9nT25ycGo2RWg2QStkRnVmUU5GOWI2MFFMdmFrWG1sclJEQitzcUUySlUz?=
 =?utf-8?B?ZHhqMDU1ZUQvVkJua3NZL0VQRFd1T2lYWjNwRzJXNHVaQy9ZRUNsNUpHOTh4?=
 =?utf-8?B?TXBVMk1NQnlPNjFGelRnbHY0OHNiRE5mWlFwYldZaHdpUXQyZVdFc0xxU1I2?=
 =?utf-8?B?UGxtTW9tTWYrU0ZpdWRzZFlvZjNpMzZ0M0dsSElrWHRYQkRQUnlQNi9HdEJO?=
 =?utf-8?B?MDB4Y29ZZC8vQXprWGJFdzV3dWVNS2RYZ2loMU5wRXpXbUJzTHV5MENoVEF2?=
 =?utf-8?B?TDQvMnJnZUlZc08zTVlzRjNNLzJhSU9pWkFKd29vbmo5bHI1NHl3RWc3UkR5?=
 =?utf-8?B?OUNKRVBWelVRK2xKNDhZaDY3WGYrT25aRkhtZEhxTnZ6SmJvSzBoOFIvRUhL?=
 =?utf-8?B?eDZVbytKcDY1aFp2TDRNMEExaGxtVFordldPbzErbG85SGZzdWU2V0F0SHNG?=
 =?utf-8?B?bWdiNFpOekRrNlhQdmhOS3luSWRlYXd2ejlGdGI3YVhvQ2dZWFg3enhvMlk2?=
 =?utf-8?B?MXRCckJkQ0tKYnhvM0VUN3dWMjlWR202VnlYZ2FSVHI5ems0Tm5wN2VJd0lu?=
 =?utf-8?B?WmdVRGlRNXZEb2IvcDI5bHg2Mm0wMmljdEwyQUZlNk1nYVhRZWs0OENLVC9F?=
 =?utf-8?B?Q1BmcGlWVEIxQXpHa0VrWjdwS3VXcklnV3Zwa2hYMTRzaGhkeXV2eEdNVDIr?=
 =?utf-8?B?b29vKzV6bWVxaFNGWmx0cE94anExckJOUFBpZnRXTEhhamVIMVpxMjFOV0VU?=
 =?utf-8?B?MTZieElSSDdJUDA3T0EwRi81MWpzM0hzcFhLSDZNaFJGRGdJYWhYczFTNEhH?=
 =?utf-8?B?cnpsR3NGVUhidjNYdU1OUW1ycThXakdTeEYxVGszQjFWSEFFRTBtZVpLV0lI?=
 =?utf-8?B?TmFqQllBTDFEek9UU2szZWJQVUIrSTNuTGpUZjVROGlKQkhCS2ZLYzEyMW1T?=
 =?utf-8?B?NWlmNHh3SEMxbkxMQUZEcDh3SURXYk9yMVBxY3VOVXVpaVo0Rk1LMHpaUkxD?=
 =?utf-8?B?YUNYbkdyRTFxYjV3SWdOaG9pTEJtWFBST2Y0Mk5wQnJPMndWZnZQQVEydUZV?=
 =?utf-8?B?b2xSNVlPT2lxS1ZPM3Q1ZFRaTG52eENhODYwZC9qcWtGZk9QMDRQSjUxV2g0?=
 =?utf-8?Q?mf0fBswUNk5ctMrxdzdK4s3VD8nC6ZJsSNcdv9ptHU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <851228F87C68444BBEFED5F6AA9886A9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?d2FvbWJ4QzhXNlZxSndXSG5TdG5PYjBvSHo1cmVSa1duVHkydzFwV2QzR28w?=
 =?utf-8?B?Zi9laFpFVWpyblBUZmhrd2EvL3dsS29jMUl2eFlvZ3BUZlcrNDFObHJCQUR2?=
 =?utf-8?B?UjdHaWNjNlQyN0VaWmdZWHBZTGFrR3ExS0hselZuSlV4ZFpSc0Q4SktBTWRX?=
 =?utf-8?B?RjU3a25Jc3RGeXZUK3IrSE9XUXp5QkwwM2lQa0NoZDdSUFc4K1dHZDRtb2gr?=
 =?utf-8?B?NkpKOUczKzhBQWczVkxmeGs2d0R1cS9tWmdyRzY1NncwbkloalVJaGVsTk1T?=
 =?utf-8?B?VHZpS2swY3dKdzAxOWpCU0lOSk9nbHRXbk9oOUxCdEJ1cW9pTlB1UWhzbmt2?=
 =?utf-8?B?L1lpUjkxbWxZUWhIQnlRa2s1NkxlY0t3R3BDaUh1NUNFMHk5VFFOeXU1SFgx?=
 =?utf-8?B?VTQzOE5rL25JRU42c295RnBLYXJJYzRzYm5Sa0t4SThmc2dOODByd1Fjd2Ex?=
 =?utf-8?B?a3lqOVFvV1pKekdsa0toa2RvWFJUV3JJQWx5cFZ3SWMxVjZRWlFCQ0dERTNW?=
 =?utf-8?B?dmQ4UGd6MVpvQXNDNE1OR1RSekxLREZRSUNLMTAyWEMwenpPRm44d2UzMW5P?=
 =?utf-8?B?eTd1NzJ2Rm9CbmtRZ0VJWUttN09mSE9OSGdiMkl2eXpCQ2theU42d0tJajI2?=
 =?utf-8?B?WGZUTXJmVkRhU2ZSeW00d0loRXkrTS9BVHhvSmcyODJjYXBTUmRKRm9McWFF?=
 =?utf-8?B?Rm8xMHRUM0xheWdaTU9nbWFVWGVDMXJkRnY1WXdRZTVUSmVFTnV6NUlUeEx0?=
 =?utf-8?B?TkVpVDdGb1JBMHlqTVFjNVVCRXY3S2g2MlBKc0w0amVnY1RMeldFYUJCeUs3?=
 =?utf-8?B?eEVqdENWWjFDdEZ5OUwvMmdDank5MU9idER3eE5rYWtZYnFaSnRJbjVPSHJU?=
 =?utf-8?B?bXNIWUt1cTdzdW13MmhYWlVUQWFMcGV4bUhZQmJTaVRLYjhHZUdYQnBjZDIv?=
 =?utf-8?B?akFoWExjRGVkUGpWU01KaTBkUjE4cHpBdnY2RzN6cXVNMk02Qm4ydWpMSlVS?=
 =?utf-8?B?Nk9vOVNMYWNtZXozRjJjSEQ3ZjlFeU54djNUdXpZUDFkRXNRUExOMVRacndy?=
 =?utf-8?B?cmpOVWNTVWR5N1haU0JQZytOdU9EbmdxQ1NEVVJIc3pjNWhVUUhxcklUNUwv?=
 =?utf-8?B?NWZmdHVPN0oza2E0dWt1SldWSTh5WENYSGlnU3VJaldoRmpTTENWMU9XUTNx?=
 =?utf-8?B?aURsdVkrQzllMDJ5MTBBS2ZuSm40b1IwblYvMGlncDk3bWJHbkhFZTNhdFVK?=
 =?utf-8?Q?cFhmEdCQ7ja2Wmg?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb6dd75-f2b3-4d82-1cdb-08db66717bf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 09:36:20.0014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UdlUzYH0fR/A9g7OChfDN8T4C7NpBBAk0HnezaKccdcZs32ypDIN4NpGtPO+G4sXHphRgm1DeQfuE4hZs+UqNHPeY99vOp9scrx+YqGM7dU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6515
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230606_023626_693764_8AEA30B9 
X-CRM114-Status: UNSURE (   9.31  )
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

U28gbG9uZyBhbmQgdGhhbmtzIGZvciBhbGwgdGhlIGZpc2gsDQpSZXZpZXdlZC1ieTogSm9oYW5u
ZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==

