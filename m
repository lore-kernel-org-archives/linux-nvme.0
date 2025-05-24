Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D202C54ED1
	for <linux-nvme@archiver.kernel.org>; Sat, 24 May 2025 04:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1He28vVWvg16y6gG8NEbzLlPOzj9jqkbNYXEVwAvik4=; b=JT1Z6ucGA8Uyd+0gDZ3ISCjy9v
	uC0wBLJanseymO4yld1DSSBTfBZFQrez9lxc2O9zQgNBiCADX7wzUHJIMPgrOcLX+hbch/hp1YwsJ
	Mj9UsIVaeXwwFzpMUjxIjd+6kUKoiT2GD4/r6N7l99YMj6qVUF7S1L6DSPP4V84k5Faagox7zGG11
	8kM3W4wISMTTTXenBg5E24mRMja+p3/PtbcqATLzaS0onK3NcvfDRB9xjj7/IQo5ARY4l0BD9UcY/
	UaMWlL2vSZREoJdlBY9PGT1AmQPrf250hpB7DhVcSPYEtb4A5WvBqdUIy/tHQhx7yPH2QvVvYUbBE
	HObpbCBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIgOr-00000005HqP-02RL;
	Sat, 24 May 2025 04:22:21 +0000
Received: from esa.hc6817-7.iphmx.com ([216.71.152.95])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIgOo-00000005Hpa-1C18
	for linux-nvme@lists.infradead.org;
	Sat, 24 May 2025 04:22:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=sandisk.com; i=@sandisk.com; q=dns/txt;
  s=dkimnew.sandisk.com; t=1748060538; x=1779596538;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1He28vVWvg16y6gG8NEbzLlPOzj9jqkbNYXEVwAvik4=;
  b=vYcduk5jrbS+M2XD3SIOvsMEvLeilMADmacJsosyfodOyaow2k+3hR8l
   0jou0VVfNjBWL3OB2cAQV1lhpcOyw0nLOYolAojSHwOs3WRljOxj0QZ7r
   YOj3d4U11lkRRD3eMDmdAF5lEBjvqWWS2gdOsImTi9CVlVtuaktFXnrCr
   WyYFxqx82V+gUHDme5hWi2om/2le6YkCcnOwCTFw0FmhBjJXhRRr0DFjV
   DnBAA2x1UDEb4p+7VAQfKfnyGKfdJoBY45NW1o7CPo6T2mbA9ApIBcYaC
   ZhhNVsMo9oNXqqJMpBMvN4d3FbF1t9HbbmUhcsg4rkTcqsjX/3lwNfLjA
   A==;
X-CSE-ConnectionGUID: 3z+SUyaOT+C6gx1FIgVtgA==
X-CSE-MsgGUID: C0+AFDJLQtenc+YfA1KfsA==
Received: from mail-bn7nam10lp2040.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.40])
  by ob1.hc6817-7.iphmx.com with ESMTP; 23 May 2025 21:22:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbRejKJKy03pm1n+AzTXUGKAfSk2A2VbMeR4p07y/HtTh5Kemd8jvwGAX7xeGzVwM3wJ6Wd6+CO6uiQfoJn78wMiHPHkVmMtvLgTvqvNTrjGb08NcWZzHo81CZPxw1gwTxYMyEgfX9cFUt4NCbLPwfl/QXRmz0g1P0+z2oD0JLtjZfzy1liUfBUHw5ttcRPqKduS+Jj0i/iQMtgmhZCyQpv8IgFlxAt0wWDigAKD7YLfmDbxwYfA0tDloMZz1CKKZbplDepqGX7obKki7kbDk/nEK01HtkLslDc951EWMFUS7JdSkRum5LZYhBu9wREEhtGlJhkRb8g6e0jXWN5iww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1He28vVWvg16y6gG8NEbzLlPOzj9jqkbNYXEVwAvik4=;
 b=wt9E28/3CtsMvg/rO5Y1tZaoJMh2j8yvDmwRYqusdRdls+PXBORuHYpTI/Z0p+sFdJkoeR9AW3zdoUFgu8r1LUT7nXkBccc0Ll++xhAFMy8JdJ360fZ2x5Kcw7N9PUVwcgaqGVgvC68d5kBqy9j47YxuwW4E+b6sy0FxyVJooFXktpJTcWyoZFFT7niZjL1m03qcnQjPL5dFTyXFX0pjugiRmNrWXntb6bf7A8RSS4BjbbqswhcZni7FMIA/E/oerL4X1618X4vtnFX7UotBRd7uyBBXPBxOTH+y5iZWHqef7aVKhurvd1qaP2QF33zYctYEw+hntpY11UNpScwJqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sandisk.com; dmarc=pass action=none header.from=sandisk.com;
 dkim=pass header.d=sandisk.com; arc=none
Received: from LV3PR16MB6067.namprd16.prod.outlook.com (2603:10b6:408:1b6::18)
 by BLAPR16MB3794.namprd16.prod.outlook.com (2603:10b6:208:254::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Sat, 24 May
 2025 04:22:12 +0000
Received: from LV3PR16MB6067.namprd16.prod.outlook.com
 ([fe80::e76d:7e62:d38d:e645]) by LV3PR16MB6067.namprd16.prod.outlook.com
 ([fe80::e76d:7e62:d38d:e645%4]) with mapi id 15.20.8769.019; Sat, 24 May 2025
 04:22:11 +0000
From: Avinash M N <Avinash.M.N@sandisk.com>
To: Keith Busch <kbusch@kernel.org>
CC: Jeffrey Lien <Jeff.Lien@sandisk.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Rahul Jain <Rahul.Jain@sandisk.com>
Subject: Re: NVMe CLI Invalid PRP Entry Status Failures
Thread-Topic: NVMe CLI Invalid PRP Entry Status Failures
Thread-Index: AdvE7w6q52drpo4qQN+ACRAqTC1lTwAstiFQAACR74AAAkovXwAsWykAAAB88b4AA/0bgAGINfYA
Date: Sat, 24 May 2025 04:22:11 +0000
Message-ID: <F3C3A106-E0AF-4598-9E80-6F10A457F202@sandisk.com>
References: <MW3PR16MB3897F0E659B34877C4D5197CF391A@MW3PR16MB3897.namprd16.prod.outlook.com>
 <MW3PR16MB38975C2057D1EF440FBD60B0F390A@MW3PR16MB3897.namprd16.prod.outlook.com>
 <aCX3offAfe1k0_KE@kbusch-mbp>
 <LV3PR16MB606775F391112B2DADF64463B590A@LV3PR16MB6067.namprd16.prod.outlook.com>
 <aCcwqhakl4JhrI2o@kbusch-mbp>
 <LV3PR16MB6067E928D739DCB65F31FE46B593A@LV3PR16MB6067.namprd16.prod.outlook.com>
 <aCdOtYYT8f3lL8zJ@kbusch-mbp>
In-Reply-To: <aCdOtYYT8f3lL8zJ@kbusch-mbp>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.97.25051816
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sandisk.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR16MB6067:EE_|BLAPR16MB3794:EE_
x-ms-office365-filtering-correlation-id: 93cedd2a-68ea-44ef-0481-08dd9a7a8e2c
x-ms-exchange-atpmessageproperties: SA
sndkipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TGpTNm9vckhhcnMzWm9GUkRVV0tuT0JOeFEyZ3FqZjM0WnpIMUNxbk5qc3Ey?=
 =?utf-8?B?ZnZHNkVrTTh4WnAxQ3kvZTlwRmh3RStGRlhXSEdMT3lhTVNNRHNEZWIzc1dv?=
 =?utf-8?B?MHNjMTYxYzdoNThIVFBRT201eDRqMmVpdktvUkgyeGJORU5XZEhzQnFOc1BT?=
 =?utf-8?B?d2xmd2lYYVgvai9uQXpTaTNqN2pwVVBSRlFubXZ5Zml6NHUwYlJZSngyMjNI?=
 =?utf-8?B?ZTdTeTNDUzc3N1h1TWR2bkxWWWplSzR2T2dFd3dZQ2VkOVVJQzNFaTVKTWZ5?=
 =?utf-8?B?NlN4SlgweVJRZ1ZJMHQ3dmdBUkNzdmNNbXJ6aEtvVDdNcFo5ZDdXTjhCZjVz?=
 =?utf-8?B?LzMxODlSNTZzWVpqWkpheFZKd0ZKSUQ2a3hyeFBKd3lJUjNldkRGS29Ec3pr?=
 =?utf-8?B?Vlg3c2Q3ekdmY2Y5VHl6SHVmRm1Vb2RoMXV1ZWNtVzRKVlBFMHpPeENIN0JB?=
 =?utf-8?B?dlp3VWQwZ3FwaWhGOVRVWktHZk05NmhsZzdXeFhXWlh0UUprSWo4R0FWU1lr?=
 =?utf-8?B?U2VuSm1OcVFRZlJiZTNhRXV0WndHbmMzbHJGVjM4Tm1RL3N2NnhzZVd1UWtW?=
 =?utf-8?B?ZmlSOTJac3M1OE5ONkovTXlSajNRV3BtSUtDTkJNTUNFcmE3RUpMUkE1YlNI?=
 =?utf-8?B?RDlDcGxNQ3hQUTdTSEg3Zkx1Y1dtNDI1SEphbENWcmFHNXZvd0tGOVpQWWN0?=
 =?utf-8?B?cVBBNWg4ZnpvczRnZUd4eUxwOGFZR1NNZC9WN3hDMEc5cm1NdnlUNXU1Skd5?=
 =?utf-8?B?M2M2OXYrL0g4WkRLSFJOTWtrSmdYLzl0Z2NySGpOSG9WVjVCcUVPZFIrNkhZ?=
 =?utf-8?B?aTVJcnFTZWxTWm96aVM0ZXl1MTlWSHcwTlRJQVA3N0xmSkh2NUlnK1NIYnhu?=
 =?utf-8?B?MTdBR2NTdGNiMnlxVk5DTDRxbGpuM1NNMzJpKzR0R0dMRUJuNEIyckFUYlhC?=
 =?utf-8?B?WUtuZEkrWURWT1N4aTZESG50S1ZBeTlaSmtwREg5QjZTVzBxQURJS21Cdnp1?=
 =?utf-8?B?cm9BNkZzcUlRQzVRVE5kbjl0cnk0NkVxV1ZFTXVxLzdkaHdycGlXRUxXTWZ0?=
 =?utf-8?B?eU8wM1VtV0hML2ZaR1lvZEozbVYyTlVIOWVFQmI5aDhUVk1pOC9TcEFZbFJm?=
 =?utf-8?B?OG5pMUxnbENrMTBrcncvVWtpOGxTbVJvMnE1TXhvWEVXbW02SzhHOXpZQkFJ?=
 =?utf-8?B?bll5bUc0Q01QWUdNbE5Qc0t4UXlWMFl5a0VDM0hmYm1rOVFSUUhsUjRPaXRz?=
 =?utf-8?B?SWZmbzdLL3Y2WU8vQlVkQ2hUTEpmYy92bFN2VlBZSExYTUFxVCs4NVBiTkN2?=
 =?utf-8?B?L3pNZHlpYWNoZll6dDZFdDZzeXdCZHk0YlhQRUJXbk5MZEJ2ekkwUlZoYjdC?=
 =?utf-8?B?K3NWcUdaZjVhZ3VGOFFJQnJiM0tHaEg0YjNBemx0QVQxam9uU0FYYkc0eUUv?=
 =?utf-8?B?UmZVNmYyZlYrWU9lQng4dVJBSTF4am5rY05idjE4Z3JmZXlHcmFtY2tNRytr?=
 =?utf-8?B?dktONTRLV01XL0hNNGVMYzlwQ1MwL1J6MW5HUjJHUkUzZzBBNTF6ZTNkSFRl?=
 =?utf-8?B?RytpUkhlWDlWcUVQYmRNdHkyOWw2NHZPZzMwcXQwdzdFQXlGNU1vZWNPOGUw?=
 =?utf-8?B?czBzbE01RlJCRldHODV5ek1Ya29iajVrOXUrWW50b3hhTWRnYjh5QU5FeWNQ?=
 =?utf-8?B?UGpwUkxhMW5iT0FIMGp6WStueDVob1ZIcXdBUHhhUlFaQk41YW5xQ3pQTUE2?=
 =?utf-8?B?RWpQa3M4eG41Ky9Eb3k3ejhlNlN3U0tUK24xS1ZVZzlWTHJIMUV0V3FDZW8x?=
 =?utf-8?B?ZWdkTXp0cEZib0Z3QnNSSEZIdDRrblA1V1VWV0VJTkRpL3hyT09mQUdvcDBP?=
 =?utf-8?B?ZDlzUUVLS0s1OUlwL3pZREZtYmZ1QXZRR2xqNHJhdGtrOU1kMUYzT0t2bTBE?=
 =?utf-8?B?REs5MHNuK1h4ak43b3V4a1R0RWpQSVRrZjhLNVV5SjVkcUZGa2p3SlhoNkNy?=
 =?utf-8?Q?aPGeRe74KMzFWuMwwx3HJb5d9+VGE4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR16MB6067.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDA3eEFzOHpsQ0hXQXIvU2JoRlpjZEppL3RHUmpTNE9uc1ZobjhuNGx3bElI?=
 =?utf-8?B?eWFxQ3pzS3N0clhLMGw5UWQxbTRoTTVJVkxMbHljL3l1bSsrUFVwYjA5dUJz?=
 =?utf-8?B?aWFvN0M3QlpzU29PcXh5bUcwS1JtR1lXV0dTeTNlSG80MkQ2N2hSTEJsQmJW?=
 =?utf-8?B?MlN6OURuN3RQQWJzdWc3TjdxaVZ4TnFmdDg1bFYxbDBFek5oZGVyMUJkZFRz?=
 =?utf-8?B?Z3AveEhreHBESWNMVEswcUxlK1ZoWUxZM1d2U3Y2NGNSQmVLT0hkaDVuZ0U1?=
 =?utf-8?B?VlkyenJWeVROUFRuNGRyTCt1YWViS01xRktxalluOG0wazVPV2Z4RG5Ma0ZX?=
 =?utf-8?B?WWVXUHZUZTdPQkp6RXg5YVlYcmJRSUV0cmtkZXNZWHJjUUZHUlBuSmFrYnI0?=
 =?utf-8?B?N2liZ3BMKzJVN0xLeENwSXU2K1ZUY2VLbmVQc2ZieEY5b1VoaWFPY2RkMCsz?=
 =?utf-8?B?eWkyemhYcU1HYS9XWjdpU3BmeEZTQVdjSm5MMTA3ejhNUlY4NTFHWEE1ZjBr?=
 =?utf-8?B?VW9qdHpwYUJPVWl5UEdjNTJKVGE5UitOYklTNGxuc3Facm1CdTZOcmY5c1h2?=
 =?utf-8?B?YTdpd1NJMWlscWppbkk2Vm43V2lFSmtVY3o1Q1cwZTJxa1NmSzhCMkxnbjMx?=
 =?utf-8?B?Z3hjSHBqYnY0S1lnck84cWVWWHNmcGMyaEZFMml3a3lJdlp2Q2I2eUtJV0pp?=
 =?utf-8?B?ZDU0cVFwVXdQNTVUM2FZM3d3MzNnRUJqRjRhTUdrcnRhT0pDcU5NTDNLZXUv?=
 =?utf-8?B?aTF0VFFIVFlDQ0JubE5McS9zcTJRcy91bW50WndSUk9hZWZoS3Zha0hnVlhK?=
 =?utf-8?B?UjdMbGpiajdaWmhWbFZOK1NMOFJYL3dzd1lLQnNtZWh1V29vTnd1dmo2Rzlw?=
 =?utf-8?B?cmpjWnU4T2N2cXNWYUlEeXNuaE8xc2hzRUtpWFZnaFB0Z2huRlBuVG1FbERE?=
 =?utf-8?B?eUV6Z0tjZFdNNGozUmp6eEI4ZHcyczRJUWo0dzhMQzdIdGlsL0N5SktkZjQ0?=
 =?utf-8?B?Ym5scDBOSEVTbERkOEdDcmFEMmFLd3FlY25yVFQzeUZaY09wcGZTZ3hSMjRM?=
 =?utf-8?B?NkJoM2ExNmJ2enZqcUZHUnA2TzN4NUc5NndmTHM2cERyVEhEYTVGMkQrZzFD?=
 =?utf-8?B?dnRGQThYbGRNS0l3SFQrT2lxbnQwZ2xnekZZcjRtSS9od2JHUHpBcU9xTXhu?=
 =?utf-8?B?YnNhZHdDOVgxbHFSVzNST0RIdm5kdG14dHlkTXZEWDJMaFE2MjNsQVpvU3Bi?=
 =?utf-8?B?Yk5MTTZHODRNVGp3aVV4bFJYTWdzNlU4eXRiSEJIS3VTMDlSWGgvWkRKVFRZ?=
 =?utf-8?B?S3ZDeFRMTkxaVnVGQzZUdkdIQU9lVENSL2ZxalZsdDNvNHJRazBiZnExYytG?=
 =?utf-8?B?QTk5YlppU1FNVEhJMEg1MW0yKzVpa1B3ZUlxNk9lUkNrbUtGS0NXYno0azhm?=
 =?utf-8?B?QzFOU1ZhS20ybFJ3UmM0d2hIUzFaV25hWnBGUXRybDJoRnZsbE5RMnZ0L1Za?=
 =?utf-8?B?NGdXVkVxVXQ1MnBYenJ4NWdYbG9xeVBBQXpVaFQyejdGRVEwbnNIOVlPUFJM?=
 =?utf-8?B?ZXRxSFJGdmNSYnlINjJRZ0h3aG5oN1JyVFJVL1FBKy84YXRPZ1M0V25KNU1r?=
 =?utf-8?B?eHEwYkx3MFNhWFJUYnFuc0haQUlnNG82WTZURHY1UUxtSEFPbDlwVHpvajJu?=
 =?utf-8?B?bytQU2h5ZXJoOXBmc3F0elAvOHpiUTRrOUFPZVNWaUhsSVAvWUVHQ3VTMHlU?=
 =?utf-8?B?Y1hpbDNlTmZSMTEwN1FaVUJhbGZTeE1HNzQ4LzlidUhDbTlBZXFCbzFnWitY?=
 =?utf-8?B?dDU1TVhIUUFIWVRNTFN6TXk0amQzWVlJRk1WTVZRS3VKbUNoemRQZm44aWxG?=
 =?utf-8?B?cHZhM3hhSVlKdWpGYlVqcTRXVDBmM3ZHSm5MSEtmcTk5MWFSZGNZdzk1dGZV?=
 =?utf-8?B?VjdRWUNLeWdqYlYzT3UraDVwNllrMkZucWJNcXpwTmFGQlNoUm5lNjlSdWxT?=
 =?utf-8?B?a1RPWXRZbjMxRWV4WWtSQjBXRDY0cGJ0SktIbjZXRGVpcE9nWFZSa3RmRjhD?=
 =?utf-8?B?ZGowNUtzOFIvd0VBd2tCZXhoay9YL0RyOFRBTG0rMnBMazJrazBJbVZ2ZXdB?=
 =?utf-8?B?TkYyZHBqMzMrR2pGK01aMGhvbU5qNTZRVVUreThQNWxRbjB0TzYwWm82Tk5D?=
 =?utf-8?B?NFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32A02AD138C91C4EAD2EE379BC39891D@namprd16.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 46ZPsulKlgHzGcbOa9OqqR1NFdj/+P6z4/Zpf16Ig1uPiTcIWfcuMQsSaKdI1JjFGozwfztuAU78EzIxuWbVmb7/S4cT7zB5VVTOAEoxS/E4J0otZ/zPD73pyizFU4N3A6FqWEhkHjgAi26iDrhdO6MDoA5qnOj+Lrzlm0HA8tgjPNLAhyMn1K5e5cO5NCrEvU9Hw/Mklgn0AoXFR12x8P6oiKZuFOFkLtinUg+6NKLujUiGHOYlXHz0i5SUaTk9I5ODLoLqc31pv/kEgBpmXqTrjWsgldRZCymODOkDO0oT4NMCOymC/fvpe5cYkz7BWjvd/av2+MDLX8BEqdPHzlw+MVR7DAYOl29SE3UxlUJePwnDI9zoEILWg0CT42sum/tXI3Gq3sUJCYkt+KIedkgc3lkW8eyla+Hmdgr7pN+cy6V7541tWBi6wgMV8OL2zmUqyzKMlxXPXko1rtI/0itI1u20LK9sKlOICf+FmDCbunLNycM7jIDc0HJ++xTiB/oeB1d8AiDfPNTZk4C+3cXquRJPbaIdzvwp/QrLaU8VmpX6wxYaGN9HMBhNIwAL5a9y58z3v9bw9LiElfpOu5MIWjIkPRUkVJopWnTzrrDkldZnPoqT/MrLFWxXeydLTzEQv8pxoX5A2z04xUKZdA==
X-OriginatorOrg: sandisk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR16MB6067.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93cedd2a-68ea-44ef-0481-08dd9a7a8e2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2025 04:22:11.8201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ffe0ff2-35d0-407e-a107-79fc32e84ec4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sEcgxv6+g6X2ty1yFvYdy5PlGJqsL5VW9RCrax76P8kJ1dXcOglQkh635dERYwa2OY9NM4Jnhw/lzmXeQ6wQ0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR16MB3794
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250523_212218_350263_006166B8 
X-CRM114-Status: GOOD (  15.63  )
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

VGhlIGJlbG93IGZ1bmN0aW9uIGlzIGNhdXNpbmcgdGhlIEVJTlZBTCB0byBiZSByZXR1cm5lZCB0
byB0aGUgdXNlcnNwYWNlLg0KDQppbnQgYmxrX3JxX2FwcGVuZF9iaW8oc3RydWN0IHJlcXVlc3Qg
KnJxLCBzdHJ1Y3QgYmlvICpiaW8pDQp7DQogICAgICAgIGNvbnN0IHN0cnVjdCBxdWV1ZV9saW1p
dHMgKmxpbSA9ICZycS0+cS0+bGltaXRzOw0KICAgICAgICB1bnNpZ25lZCBpbnQgbWF4X2J5dGVz
ID0gbGltLT5tYXhfaHdfc2VjdG9ycyA8PCBTRUNUT1JfU0hJRlQ7DQogICAgICAgIHVuc2lnbmVk
IGludCBucl9zZWdzID0gMDsNCiAgICAgICAgaW50IHJldDsNCg0KICAgICAgICAvKiBjaGVjayB0
aGF0IHRoZSBkYXRhIGxheW91dCBtYXRjaGVzIHRoZSBoYXJkd2FyZSByZXN0cmljdGlvbnMgKi8N
CiAgICAgICAgcmV0ID0gYmlvX3NwbGl0X3J3X2F0KGJpbywgbGltLCAmbnJfc2VncywgbWF4X2J5
dGVzKTsNCiAgICAgICAgaWYgKHJldCkgew0KICAgICAgICAgICAgICAgIC8qIGlmIHdlIHdvdWxk
IGhhdmUgdG8gc3BsaXQgdGhlIGJpbywgY29weSBpbnN0ZWFkICovDQogICAgICAgICAgICAgICAg
aWYgKHJldCA+IDApIHsNCiAgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IC1FUkVNT1RFSU87
DQogICAgICAgICAgICAgICAgfQ0KICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQogICAgICAg
IH0NCg0KVGhlcmUgaXMgbm8gaXNzdWUgaWYgbnZtZS1jbGkgc2VuZHMgYSB0cmFuc2ZlciBsZW5n
dGggb2YgdXAgdG8gMTI4Sy4gQW55dGhpbmcgbW9yZSB0aGFuIDEyOEsgaXMgZmFpbGVkIGFzIEVO
SU5WQUwuIEkgZ3Vlc3MgdGhpcyBpcyBjb21pbmcgZnJvbSB0aGUgbGltaXRhdGlvbiBvZiBCSU9f
TUFYX1ZFQ1MgYXMgMjU2LiBTaW5jZSB0aGlzIHdhcyB3b3JraW5nIG9uIG9sZGVyIGtlcm5lbHMs
IGRpZCBhbnl0aGluZyBjaGFuZ2UgaW4gdGhpcyByZWdhcmQ/DQoNClRoZSBmYWlsaW5nIGNvbW1h
bmQgd2FzIGF0dGVtcHRpbmcgdG8gdHJhbnNmZXIgYSBsZW5ndGggb2YgfjMyMEsuIEl0IHNlZW1z
IHRoYXQgbnZtZS1jbGkgZG9lcyBub3Qgc3BsaXQgdGhlIHRyYW5zZmVycyBhbmQgc2VuZHMgdGhl
IGZ1bGwgdHJhbnNmZXIgbGVuZ3RoIHRvIHRoZSBrZXJuZWwuDQoNClRoYW5rcywNCkF2aW5hc2gg
DQoNCu+7v09uIDE2LzA1LzI1LCA4OjEyIFBNLCAiS2VpdGggQnVzY2giIDxrYnVzY2hAa2VybmVs
Lm9yZyA8bWFpbHRvOmtidXNjaEBrZXJuZWwub3JnPj4gd3JvdGU6DQoNCg0KT24gRnJpLCBNYXkg
MTYsIDIwMjUgYXQgMTI6NDk6MDdQTSArMDAwMCwgQXZpbmFzaCBNIE4gd3JvdGU6DQo+IFRoZSBk
ZXZpY2UgTURUUyB2YWx1ZSBpcyAyIE1CLiBUaGUgc2FtZSBjb21tYW5kcyBhbmQgZGV2aWNlIHdv
cmtzIGZpbmUgb24gb2xkZXIga2VybmVscy4gVGhlIHRlc3Rpbmcgd2FzIG9uIDUuMTQuDQoNCg0K
Tm90IHN1cmUgdGhlbi4gWW91IG1heSBoYXZlIHRvIHRyYWNlIGludG8gdGhlIGtlcm5lbCB0byBz
ZWUgd2hlcmUgaXQncw0KZ2V0dGluZyB0aGUgRUlOVkFMIGVycm9yIGZyb20uDQoNCg0KQW5kIGlm
IHlvdSByZXNwb25kLCBwbGVhc2UgdXNlIHBsYWluIHRleHQgc28gdGhhdCB0aGUgbWFpbGluZyBs
aXN0DQp0aHJlYWQgZG9lc24ndCBoYXZlIGdhcHMuDQoNCg0KDQo=

