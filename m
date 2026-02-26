Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3B4FC5927
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 10:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8SCtpWJs2SAmpxpHSmlntDak3kCf68+Q5944CqsIc0M=; b=luxaCcf+ybHMKBaPeNoKkfOngz
	33nKuK1zQkI+RcgC5DFv+M0mnSpYURoegnQGqWGc3anhMBNGTjeFOG1t+0JZ9rxF048S+7GMbdbzm
	0GZPlYbipa6JUMqA/KWubwy3zPZE7ubT4wk3tFheTP0c/R48/Vz6FR1tjD23i/XMFMuQDFwoBqgg/
	FZ18HZkhhJK2muN0fX8Ml1YoPBHwCa4i2KG9upDfVtktuiSmzvzRGyyKNA/cz5Ou9aysFpMudOlJ4
	MrGV6WIDziB6TWpdnqPrwzcRLw+l0dC130IwmozmHgIrNb8i6LkWnlhTRdAJGv9aMPEmmuMnfEK1p
	C27XukEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvYpU-00000005wYO-1FaS;
	Thu, 26 Feb 2026 10:42:48 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvYpR-00000005wXW-2X4N
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 10:42:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772102563; x=1803638563;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8SCtpWJs2SAmpxpHSmlntDak3kCf68+Q5944CqsIc0M=;
  b=br91g1fVH2rq+Wir61isK0AVTD9eHq3SXnHh9N46CJl0R018pyCy8zXJ
   wQTOsvOTTIcsCizk2whPrKSbQE8re6RhwUVqA4aQynfH+eUUQJja+D3XD
   ljTb1cE1FrQBka128Qubs/QQLYPZEkGN2bp1Qp/8wLV/ogS4Inko9hxUy
   QQVez2RSbEdjInM5Xhv82pykjw7gJNjxv6m+v2il9EwgewchsL1ySw+Q9
   0Bgx9BS2lK4Le++ZKsx/n6+7cOz67WSXouga6ODPzVukai9fjVR7brew9
   CWvuXHd1yf4GoNxE/FolVeGYksqWZTt39+OD3dwHd/li0K80v4RUM5w+V
   Q==;
X-CSE-ConnectionGUID: WSxeE35MSUa2RMY+jaUuVQ==
X-CSE-MsgGUID: IMmVKjiCSyetT6tcQkbuVQ==
X-IronPort-AV: E=Sophos;i="6.21,312,1763395200"; 
   d="scan'208";a="142635037"
Received: from mail-southcentralusazon11012010.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.10])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Feb 2026 18:42:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsmHD1b7n382ASVXzrQZRKCPG8l5rvLwDPzmX0oNlaLbEqyXtiVdVVVGGXkleDmh5i/VFWEDR5O2DSOdTzMif6JGm/cjpz2OH8xJMxEa5/fh/orSidcxJY9cZmK8x3wWEe4YOzUOQePnfREsa0E8Z29ZIFpXHd8fR20T98ybn1vkblsjzvkzLDAfe4waddpb+sBolU47xBo21F+Fg7NFv+egk+hH80+XWzH0gt7OLZ3c/ov0gIelyd5X7fmleIqTelRLbTAZ7FRQWpXB8caEhCGX37lVMU/QTsi4UzoAcE7nrgQR8JyqYJoMCdxLVafww20LEwnjx/8hyvpV3A3Vaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SCtpWJs2SAmpxpHSmlntDak3kCf68+Q5944CqsIc0M=;
 b=Z6tNsHAb2PBAQ1Vqv4aOYMVYPgdfoujz6Az5C62pUr+S6jXJZn2ERcMVIfxV+/a9CpcrZUBjhqEot4QlhtJfYdNqqwiLs5XMtQarhXW7edJH7OTqLTC+d0v1nhMtKGSB9mVUrwpwdtFm3WkEajt9cmBh6ftCb/Zqw4QLORB9azpzKSU1jvbI8Ba7yR2MnBRh2MTQGMq9r2UeWzdz+hUPxhNKwk+xWKZGKUaMWbZHhEkyI67lQnROeCQ22bslJKhcj0lLDQ/786ePPGGhi95Q4AxV053XJldML5FRv0MO+jbMuNUhC4/zMsz8sM/kaBYW9h4tCHcFtbZguRMD1yimKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SCtpWJs2SAmpxpHSmlntDak3kCf68+Q5944CqsIc0M=;
 b=J1Nx5enDl0VQjU6jIgyo0Iq8BtpYzt7w+lQ1q4/e1H198yZc1sjw6N+ZBRBy/rIZTcR3FiGUsZdea0fNDFiF/U6kovS/m9UhcKyNEwwBhbBadgW7oACESuN9ZjNlKE0UW4guFvC918/Zdfy2dzpDELMOOaGe2u/NHuF+0sosxjo=
Received: from SA1PR04MB9849.namprd04.prod.outlook.com (2603:10b6:806:4a3::15)
 by SA3PR04MB8692.namprd04.prod.outlook.com (2603:10b6:806:2f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 10:42:38 +0000
Received: from SA1PR04MB9849.namprd04.prod.outlook.com
 ([fe80::705f:2ac8:b2ff:f845]) by SA1PR04MB9849.namprd04.prod.outlook.com
 ([fe80::705f:2ac8:b2ff:f845%7]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 10:42:38 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: hch <hch@lst.de>, "hare@kernel.org" <hare@kernel.org>, "hare@suse.de"
	<hare@suse.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH RFC] nvme-tcp: Implement recvmsg() receive flow
Thread-Topic: [PATCH RFC] nvme-tcp: Implement recvmsg() receive flow
Thread-Index: AQHcI9yXM3tTa6DDl0+KwEFYCNGDybWUQy4AgAAMagCAABo5gIAAHhMAgACPrICAAJfGAIAAIi4A
Date: Thu, 26 Feb 2026 10:42:38 +0000
Message-ID: <d6ad45de9912f608e08058dc7168ec19b5d064a3.camel@wdc.com>
References: <20250912115829.58669-1-hare@kernel.org>
	 <99c9b1f7d8bbeca3681bb2f8502fe6af1374df8d.camel@wdc.com>
	 <b778bc2f-5911-431c-9b65-1fbaea68fd4d@suse.de>
	 <8c3fd4f7f9c0074ec35fb15d1573ad2e3155cbe1.camel@wdc.com>
	 <d21a9ad8-24d6-4210-8779-0cc91175f57c@suse.de>
	 <3739383d428d75ca1eda44ae61716057e20488d0.camel@wdc.com>
	 <141f8748-9f31-4bb1-93f4-7709f68c3eea@suse.de>
In-Reply-To: <141f8748-9f31-4bb1-93f4-7709f68c3eea@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.58.3 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR04MB9849:EE_|SA3PR04MB8692:EE_
x-ms-office365-filtering-correlation-id: 28a475b5-ca02-4a8b-24ec-08de7523c300
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|19092799006|376014|38070700021;
x-microsoft-antispam-message-info: I/C57aOvcgDeyU8vPEXjyYbjuZHxhBWZJ8HU/wvdh6oPM26uhSVgr3T++sWZ6VaqcndI84Ll+ve0UPZMOv346mC7W4qFAOiipok7FIoHc+5Zcq7n1JbfwgMzi1IBt49CY4erOUy/CIjqvg3U9hbBQDYEiq/okKmVhs6iKGfYATYJeNeYRBsqvxUHAbs0w6m+bxpXZ3PReWs3nFNnDljiiZdoW1+vJ4VFLxr32uGXUn0hRzGac+SKVJAtWqq90pH7Qmebqg3GdnVzof/mZshaaPr04hk5U4TTtst2m1QUstpc0/hVuraY+fMCZGQfbsC8qa6uQHUP12nU6+Q2cOKyRKc7LUIv+x12z6UKNO2KdrTlXdTAUXUzmGJmJ58UqtKX8cB5+JeDCdpi0LJV7wBaiyDRl+71YNc54d2YHUbTWOOidvlOa3gbfbeVnHt+2b620X3zn4BnBxHwd55B8HqUBNDd5GinwQQS0l9Ex9LTej3epJMtH5RF0Wy4KArBLyBHNSiJK42jT2BmqqhDN55ejCrDHCiVpsboVbERfq8YWia7H+kgR8jwhZD6fMra1aHr6v1TKc39Jp0HQt5gM+FRdNCsnSjfrxttdZPG/PF3TTTb9lBcbqc+friRnj+Q1VAIcuqCQ/ESY5HKoTGINxGAjB11ZGEVGPudH5r2NTVCV+Dt/VJbWiM7GeAwLEySWS+ep2gzic84UmWbfGH98VTioerVVUmuySo3ZF9zMTHGQI6hoI8q3X8NPGPlFPqHRT++qCEesvUY6tGPTZ5C8AXtrL0Jg7aSzHKNvMTc2VVCrL0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB9849.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlRMU2RvbENhYW5SL3lGcVgvRXd1Vm9ZekhVL0JmcXpja3JZRSswUlIwK2lU?=
 =?utf-8?B?MlhIenRHeis3UFpYRUZJOE1Jc2Y5YmtIREdFTHN2Z3k0WENJTWM1VU5MR3du?=
 =?utf-8?B?UG1LelNQZmJuQ3M1ZUdLS0lFdTVXMTlDY2JyVXluNHJyMTYxVzdkenkwY0lJ?=
 =?utf-8?B?RU40KzNQOWFIU3ozelgrMkpmWEwvUjY5ODZqejIxbVFzM1R6RjNhYXB5SU1R?=
 =?utf-8?B?ZkFrNUlES0xWdnpzSFpob1Buam55M1lubno1WWZhVHRFNFMrblh6NlNMMVZo?=
 =?utf-8?B?bVBzdit0NTArYklOV2dpdVZGVFRYVkNuU3ZXeXh3akU2YUVoWFpqRlR5QXJI?=
 =?utf-8?B?WStuTFdWdjBmOUhIVzVhS21EeXVzTUNtSitXZ2R4eGVSdkIvUjFYMS9TckJN?=
 =?utf-8?B?Sy9lbXFseVJNc1pRbSt4SzdZZDIwOWx2UHBrWEFQVVhqQ0hKZUxyQXE2aita?=
 =?utf-8?B?dlJHWk80WlRpeHdIWGtoWUkxOVZ3eXJGb0x6YlBsMVY0RUk1RzdoR1VjQmZp?=
 =?utf-8?B?dVJjWlR0U0YxSG9jaGRsNEUxZ2EwTkpUMG93YWhUczZrVWRVanBsTnQ1RVFJ?=
 =?utf-8?B?cEdndjZYc0xMVlMwamNTcHBJbE00ZGRPQkc2UXBXVnIrT2J3N3IvUFpCZVdD?=
 =?utf-8?B?YXZOYlFQaHorRFRTa29wdXc4QldRVFFpdURXT1F5YnNITDdHR0hSOW9mSHJW?=
 =?utf-8?B?S2lubjRBSjB3dVo0WDBoUk91WHQxTFZ5VHZLend1b1ErUDEyWDVCWnNxREha?=
 =?utf-8?B?SnZBVGtDQm9hNStXSk9vVzl4VkRnTXA3b1BjRXdwVzhmZzhiWTErMitCVFNW?=
 =?utf-8?B?Q3FqTFZmT2p5ZytUOXhDTDlYVFBEeWEwZGUvQkpKMVJkckJCN2pUWjNQa0tt?=
 =?utf-8?B?Y1d5MWgramNhNGFRaEc0NFpYOXdRd3loTkt3aEZnMHZZRTNvWm1aeWNTaVRM?=
 =?utf-8?B?UzhrN051ek5XYnVHMlN6NDh1VUxnVWVrWTQ0TE5YSVhxbkEyQVRZaTlXZlNu?=
 =?utf-8?B?S29zRW1TQW9zMXhkZWxJYkVsd1l6T0JzcDhFcVJPZU1aSTRoU2p5Ky9lMWo5?=
 =?utf-8?B?c08xenZRcFkwWnhtcE1TSUZnWWhxZzN1N2xqcGYvaHp5dmJFR21pUFZOSVlu?=
 =?utf-8?B?VmdPdDBBUEdwelpaYXk1Y2MvV3hxZ3hVNWZFWi9nK3NKZ001TTB3ek1kOHk1?=
 =?utf-8?B?N0xlb2o3TFpwUi9oUE41bTBER1BNRlY4VytyWGNWbFN2dkM5alJ5LzFoMFFa?=
 =?utf-8?B?QXBTdzZBWkNNVjdwNWtlTHVhVDRydzNTM2MzVmpVMk9saUE4TEJxeXhxcDhs?=
 =?utf-8?B?MjE4Ym5nYSs2NlVpR1Y2TlZrcUxKU0kvNDBZSU9hcUo0Q3d4bVpQOGhmeC9W?=
 =?utf-8?B?L0lvUi9ORG51ZCtBaWFHbFZLdktTTGFrekx6MDR3WkRDQlMvQnl1MTlTVzZa?=
 =?utf-8?B?amJ6REhxVWlRTE12OXExUGdqclQvMUNXcmw0cHdSRUlLMm4wKysxaXZNbHk3?=
 =?utf-8?B?V1NRSERhM3ErVi9HQTNTQXNEWHcyNEdibnVDOXlIRHZiTlgwa040czVObk5B?=
 =?utf-8?B?VnMvZURKVTBac2MyOVFwblpVbWRlQXdxa00vM1gxejkyempTMkVwcTh1SHZk?=
 =?utf-8?B?bitUVzcrbFF6TjVSSEg3dzF5TXpaVnhLaW1tMkdzeGVVVXJnK2hjZldOcWZu?=
 =?utf-8?B?Slh6RmF0R0ZRTmxCU1J5ZEJyVWZMcGlaMEk0U2cxQkVsNU1tZFU1V0FCV21V?=
 =?utf-8?B?bzNzTUQzNVp3M1MyNGpnWWJJU1grUWNHUU9XcUt0bTVMNDZjOVFnUnZWQlU2?=
 =?utf-8?B?TjdNVG8wYmlVTXhnUGV0ZTdwNWYzN2x1N3lEWjczdnZIWDJOOUhDZmZCTWhl?=
 =?utf-8?B?Qm9DMlpSMXZNOEJUYURBVnZJdGxGbmNOL2w5R2lsYWxpWi9uMEc2OS9ERG0z?=
 =?utf-8?B?Snl6eTh3UG9YTmdueVN0dDQ0Y0syOEdxOEZpSXFlMjlxTEZTQllMQ3UrQUdm?=
 =?utf-8?B?R1ExT2FNQ0FBZ2N0MkoxQkFSM2RWeHBRaGFvT0V6Q2tFN2pCdGJtOGxzSmVR?=
 =?utf-8?B?UExSdCt3aHpSb1pmaVE2VCt0VVlZT0MwYWN6WncrOVVwWjZHSzAyRkxTTDl3?=
 =?utf-8?B?azgxWld5d2RJZVFEd25yc3p5ZUcyRWRnVDJ2bXdOMUlwQVdyOHBUckVQellx?=
 =?utf-8?B?MkM5MDVpREVGUll5ZVJzMlJtem0wN2Vtc3F0WTVCWmR2dUpiZWdybkYrRWVq?=
 =?utf-8?B?UlZTK3EyWFZVQkVJeTQybFJIWUYwNElqL0FQZ0FvdHFMNW9yZ3VXWUtFKzV6?=
 =?utf-8?B?S3hvRVlIZzVrdGJ5YWJaUTFuQjRKTlRUdjJjT3JrL3ByNFY3cmorMGNOZTJM?=
 =?utf-8?Q?fM5t9PgM+AbjC4SjYL09opzgbkPoIpvLhRKSmvAoPOp4s?=
x-ms-exchange-antispam-messagedata-1: zob8rAcQohwQvWdFYWN/fJuZHoHoKEOKeBA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC3B239E1CE5834098A83EAABE323368@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nDL+8ZeR8ek8Afe5VPT+kKe9Z6Dpmpi9lOaSeUExbGONMXM8+RPCCWeVunplWEMl1wtyPZls3y9rI3J+PQGGu49GWS+CbSn3GChcouZqMroYvO9743MrIMXhcuL8dEe7V8PQlsQeLUKZ5L8NIp9TFhefE5xYA69ZLz0gSBWRAbmfAQb1njdW+xY+sGlv8VLGj/xcg6ww51sUtzCg/Ey7ihld6chHpSNo2gxX6P17gcUmCLh3Xt1tTLEtBZH04i1cxuZyI/EcJp4ZjH5M8KpvpH49oJVaemqeNgtg1dU6q7oLjurlHzSqGyNQKIK95S1JXevzf6mIOu3TIdoxgzXkyLZy830bqByy0uHaBqP/PlYL8nIHSzj8sTOtppQcEMHG8/yDVIRKIYn6uYxGUiG0Ko6Gb2WAYx9W5bTbUn0zP9KVEO6Xfh9gtHKNJK57MZ/gD8PS8YfaRkOBzlhs65TYzurpjcHX8r7wQyKmg3O1Hv7GJ7klc3v1yExmVUkVbbWInIRZrDg2Yos5mzqPC+j4NGruFjnQxgxHKB3X0XBZbj7F1yRNS0JRLXlhshMcLdQlihrE02vOxTmLbIRh5prXNV+TXIt8yycFF8tUZWUPCZ4wZ/VHoBbIkX0bPkEb3yFm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB9849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a475b5-ca02-4a8b-24ec-08de7523c300
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 10:42:38.8660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cxhmcBKax4IZIwphHZHsgkmqDBId1WO9TeJAbIrledlHsb+M3+IzbLKMmrqav2XxIrmer2AEiVj4ly/Y03HTnAF/x3cStgLBtOESv87qC90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8692
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_024245_763880_CBCC6A94 
X-CRM114-Status: GOOD (  44.53  )
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

T24gVGh1LCAyMDI2LTAyLTI2IGF0IDA5OjQwICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6
DQo+IE9uIDIvMjYvMjYgMDA6MzcsIEFsaXN0YWlyIEZyYW5jaXMgd3JvdGU6DQo+ID4gT24gV2Vk
LCAyMDI2LTAyLTI1IGF0IDE2OjAyICswMTAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6DQo+ID4g
PiBPbiAyLzI1LzI2IDE0OjE1LCBBbGlzdGFpciBGcmFuY2lzIHdyb3RlOg0KPiA+ID4gPiBPbiBX
ZWQsIDIwMjYtMDItMjUgYXQgMTI6NDEgKzAxMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToNCj4g
PiA+ID4gPiBPbiAyLzI1LzI2IDExOjU2LCBBbGlzdGFpciBGcmFuY2lzIHdyb3RlOg0KPiA+ID4g
WyAuLiBdDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFRoaXMgZG9lc24ndCB3b3JrIHVuZm9y
dHVuYXRlbHkuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFRoZSBwcm9ibGVtIGlzIHdoYXQg
aGFwcGVucyBpZiBxdWV1ZS0+ZGF0YV9yZW1haW5pbmcgaXMNCj4gPiA+ID4gPiA+IHNtYWxsZXIN
Cj4gPiA+ID4gPiA+IHRoZW4gaW92X2l0ZXJfY291bnQoJnJlcS0+aXRlcik/DQo+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+IHF1ZXVlLT5kYXRhX3JlbWFpbmluZyBpcyBzZXQgYnkgdGhlIGRhdGEg
bGVuZ3RoIGluIHRoZSBjMmgsDQo+ID4gPiA+ID4gPiB3aGlsZQ0KPiA+ID4gPiA+ID4gdGhlIGxl
bmd0aCBvZiB0aGUgcmVxdWVzdCBpb3ZfaXRlcl9jb3VudCgmcmVxLT5pdGVyKSBpcyBzZXQNCj4g
PiA+ID4gPiA+IHdoZW4gdGhlDQo+ID4gPiA+ID4gPiByZXF1ZXN0IGlzIHN1Ym1pdHRlZC4NCj4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gSWYgcXVldWUtPmRhdGFfcmVtYWluaW5nIGVuZHMgdXAg
YmVpbmcgc21hbGxlciB0aGVuDQo+ID4gPiA+ID4gPiBpb3ZfaXRlcl9jb3VudCgmcmVxLT5pdGVy
KSB0aGVuIHdlIG5lZWQgdG8gcmVhZCBsZXNzIGRhdGENCj4gPiA+ID4gPiA+IHRoZW4NCj4gPiA+
ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gYWN0dWFsIGNvdW50IG9mIHJlcS0+aXRlci4NCj4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gU28gd2UgbmVlZCBhIGlvdl9pdGVyX3RydW5jYXRlKCksIGJ1
dCB0aGVuIHdlIGVuZCB1cA0KPiA+ID4gPiA+ID4gb3ZlcndyaXRpbmcNCj4gPiA+ID4gPiA+IHRo
ZSBkYXRhIG9uIHRoZSBuZXh0IGl0ZXJhdGlvbiBhcyB3ZSBoYXZlIG5vIHdheSB0byBrZWVwLi4u
DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiBRdWVzdGlvbiBpcywgdGhvdWdoOiB3aGF0IF9pc18g
aW4gdGhlIHJlbWFpbmluZyBpb3Y/DQo+ID4gPiA+IA0KPiA+ID4gPiBXaGljaCByZW1haW5pbmcg
aW92Pw0KPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4gV2VsbCwgaWYgcXVldWUtPg0KPiA+ID4gPiA+
IFRoZSBtb3N0IHJlYXNvbmFibGUgZXhwbGFuYXRpb24gd291bGQgYmUgdGhhdCBpdCdzIHRoZSBz
dGFydA0KPiA+ID4gPiA+IG9mDQo+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gbmV4dCBQRFUgKHdo
aWNoIHdlIGhhdmVuJ3QgYWNjb3VudGVkIGZvciwgYW5kIGhlbmNlIGhhdmVuJ3QNCj4gPiA+ID4g
PiBzZXQNCj4gPiA+ID4gPiB1cCBwb2ludGVycyBjb3JyZWN0bHkpLg0KPiA+ID4gPiANCj4gPiA+
ID4gVGhlIG5leHQgUERVIHNlZW1zIGZpbmUsIGl0J3MganVzdCB0aGUgbmV4dCBkYXRhIHRoYXQg
Z29lcyBvbg0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gY3VycmVudCAoYW5kIGNvcnJlY3QpIElPViwg
anVzdCBvdmVyd3JpdGluZyB0aGUgcHJldmlvdXMgZGF0YQ0KPiA+ID4gPiBhcw0KPiA+ID4gPiB0
aGVyZQ0KPiA+ID4gPiBpcyBubyBvZmZzZXQuDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBUaGUg
b2Zmc2V0IGlzIGluIHRoZSBpb3YgKGllIHlvdSBhZHZhbmNlIHRoZSBpb3YgaXRlciB0byBjYXB0
dXJlDQo+ID4gPiB0aGUNCj4gPiA+IG9mZnNldCkNCj4gPiA+IA0KPiA+ID4gPiA+IEkgY2FuIHNl
ZSB0aGlzIGhhcHBlbmluZyBmb3IgVExTIHdoZW4gdGhlIHNlbmRlciBkb2Vzbid0DQo+ID4gPiA+
ID4gc3BhY2UNCj4gPiA+ID4gPiB0aGUgcmVjb3JkcyBjb3JyZWN0bHkgKGllIGlmIHRoZSBQRFUg
ZW5kIGlzIG5vdCBmYWxsaW5nIG9uIGENCj4gPiA+ID4gPiBUTFMgcmVjb3JkIGJvdW5kYXJ5KS4N
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBCdXQgeWVhaCwgSSBjYW4gc2VlIHRoZSBpc3N1ZS4gV2hp
bGUgd2UgY2FuIChhbmQgZG8pDQo+ID4gPiA+ID4gYWR2YW5jZSB0aGUgaXRlcmF0b3IgdG8gY29t
cGxldGUgdGhlIHJlcXVlc3QsIHdlIHN0aWxsDQo+ID4gPiA+ID4gaGF2ZSB0aGUgcmVtYWluaW5n
IGRhdGEgaW4gdGhlIGl0ZXJhdG9yLg0KPiA+ID4gPiANCj4gPiA+ID4gPiBXaGF0IHdlIGNhbiBk
bywgdGhvdWdoLCBpcyB0byBjb3B5IHRoZSByZW1haW5pbmcgZGF0YSBvdmVyDQo+ID4gPiA+ID4g
dG8gJ3F1ZXVlLT5wZHUnIChhcyB3ZSBhc3N1bWUgaXQncyB0aGUgc3RhcnQgb2YgdGhlIG5leHQN
Cj4gPiA+ID4gPiBQRFUpLA0KPiA+ID4gPiA+IHNldCB1cCBwb2ludGVycywgYW5kIGxldCBpdCBy
aXAuDQo+ID4gDQo+ID4gSSB0aGluayBJIHVuZGVyc3RhbmQgdGhpcyBwYXJ0IGEgYml0IG1vcmUg
bm93LiBJJ20gY3VycmVudGx5IHVzaW5nDQo+ID4gaW92X2l0ZXJfdHJ1bmNhdGUoKSB0byByZWR1
Y2UgdGhlIGNvdW50IG9mIHJlcS0+aXRlciB0byBtYXRjaA0KPiA+IHF1ZXVlLQ0KPiA+ID4gZGF0
YV9yZW1haW5pbmcsIHNvIEkgZG9uJ3Qgc2VlIHRoaXMuDQo+ID4gDQo+ID4gSWYgdGhlcmUgd2Fz
IG5vIHRydW5jYXRpb24gdGhlbiB0aGUgcmVxLT5pdGVyIHdvdWxkIGZpbGwgdXAgd2l0aA0KPiA+
IHRoZQ0KPiA+IGN1cnJlbnQgZGF0YSBhbmQgdGhlIG5leHQgUERVLiBUaGlzIGlzIHdoZXJlIHdl
IGNvdWxkIGNvcHkgdGhhdA0KPiA+IGRhdGENCj4gPiBvdmVyIGFuZCBsZXQgaXQgcmlwLg0KPiA+
IA0KPiA+IEJ1dCBpdCBzdGlsbCBoYXMgdGhlIHNhbWUgaXNzdWUgaW4gdGhhdCB3ZSBjYW4ndCBh
ZGQgZnV0dXJlIGRhdGEgdG8NCj4gPiBhbg0KPiA+IG9mZnNldCBpbiB0aGUgcmVxLT5pdGVyLiBB
dCBsZWFzdCBub3QgdGhhdCBJIGNhbiBmaWd1cmUgb3V0Lg0KPiA+IA0KPiANCj4gQWgsIEkgdGhp
bmsgSSBzZWUgaXQgbm93Lg0KPiBUaGUgaW92ZWMgbWlnaHQgaW5kZWVkIGJlIGxhcmdlciB0aGFu
IHF1ZXVlLT5yZW1haW5pbmcNCj4gKGRhdGEgdW5kZXJmbG93cyBhcmUgbm90IHRoYXQgdW5jb21t
b24pLCBhbmQgdGhlbiByZWN2bXNnDQo+IG1pZ2h0IGluZGVlZCBmaWxsIHRoZSBpb3ZlYyB3aXRo
IG1vcmUgZGF0YSB0aGFuIHRoZSBQRFUNCj4gcmVxdWlyZXMuDQo+IA0KPiBUaGUgb2xkIGNvZGUg
aGFkIHRoYXQgYml0Og0KPiDCoMKgCQkvKiB3ZSBjYW4gcmVhZCBvbmx5IGZyb20gd2hhdCBpcyBs
ZWZ0IGluIHRoaXMgYmlvICovDQo+IAkJcmVjdl9sZW4gPSBtaW5fdChzaXplX3QsIHJlY3ZfbGVu
LA0KPiAJCQkJaW92X2l0ZXJfY291bnQoJnJlcS0+aXRlcikpOw0KDQpUaGF0J3MgcGFydCBvZiB0
aGUgcHJvYmxlbS4gQnV0IHRoZSBvbGQgY29kZSBhbHNvIGhhZCBhbiBvZmZzZXQgaW50bw0KdGhl
IHNrYl9jb3B5X2RhdGFncmFtX2l0ZXIoKSBmdW5jdGlvbiwgd2hpY2ggdGhlIG5ldyBjb2RlIGRv
ZXNuJ3QgaGF2ZS4NClRoYXQncyB0aGUgaXNzdWUuDQoNCj4gKHdpdGggcmVjdl9sZW4gYmVpbmcg
c2V0IHRvIHF1ZXVlLT5kYXRhX3JlbWFpbmluZykgdG8gcHJldmVudCB0aGF0DQo+IGZyb20gaGFw
cGVuaW5nLg0KPiBTbyB3ZSBzaG91bGQgZG8gYQ0KPiANCj4gaWYgKGlvdl9pdGVyX2NvdW50KCZy
ZXEtPml0ZXIpID4gcXVldWUtPnJlbWFpbmluZykNCg0KWW91IGRvbid0IG5lZWQgdGhlIGlmKCks
IGlvdl9pdGVyX3RydW5jYXRlKCkgaGFuZGxlcyB0aGF0IGZvciB5b3UuDQoNCj4gwqDCoMKgIGlv
dl9pdGVyX3RydW5jYXRlKCZyZXEtPml0ZXIsIHF1ZXVlLT5yZW1haW5pbmcpDQoNCkkgaGF2ZSB0
aGlzIGFscmVhZHkgbG9jYWxseS4gSXQgYXZvaWRzIHRoZSByZXEtPml0ZXIgcmVhZGluZyB0b28g
bXVjaA0KZGF0YSwgYnV0IGl0IGRvZXNuJ3QgZml4IHRoZSBpc3N1ZSB0aGF0IHRoZSBuZXh0IHJl
Y2VpdmUgd2lsbCBvdmVyd3JpdGUNCnRoZSBkYXRhIGluIHJlcS0+aXRlciBhcyB0aGVyZSBpcyBu
byBvZmZzZXQNCg0KQWxpc3RhaXINCg0KPiANCj4gYmVmb3JlIGlzc3VpbmcgcmVjdm1zZy4gVGhh
dCBzaG91bGQgdGFrZSBjYXJlIG9mIHRoaW5ncy4NCj4gDQo+IENoZWVycywNCj4gDQo+IEhhbm5l
cw0K

