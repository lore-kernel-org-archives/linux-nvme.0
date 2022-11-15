Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F888C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 22:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p7WtC4oe7WoKJCXacfj7vxKb9lZgm7NqWBo2c9uzQys=; b=BeraQ/vQnVMQwlN80ikz5X9uqc
	M4oH/iEC91UdyZKsCVpq1VIB+Rt0QRIFrS+u139wEQ3WW+Dt9nS009T/3zDp81BOC9wps+E96ewSX
	n87Msk8AmL9IIuLCbnYmJkPGD+rzFXmRYFZQEJ1i6bzMgjrjDI+Fc3pyyd++CrN9T3joIGBxGR5pw
	7RWSQEPmmIDLOUERMFqvyR0YMuB8k9Z6tNk9QxJK2P4yAZiV5sYDVSHBcDKPSwBm8Sg9GaATiIl/3
	CybYOD3Tl29eH4bhVCCX+PzHg9FzCYku5CW44lOSBcyDzwycrLQ8INZzZHSzr4uTzUfQSPX4iKL3a
	Uzmq9oqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ov4BJ-00FN1D-Rj; Tue, 15 Nov 2022 22:13:25 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ov4BE-00FMzw-7K
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 22:13:22 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFM3fCP031860;
	Tue, 15 Nov 2022 22:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=p7WtC4oe7WoKJCXacfj7vxKb9lZgm7NqWBo2c9uzQys=;
 b=zu9r9QjlGGzJgiwNr/Fjh5oeN6RX3C/UeH2pXBQHQ0cRKFmfofnn42WJlqDELoWBEHZi
 9W1ar0xlpNJOY1Q4U8AfIpJt/0zqflwDiIcuYITVlwaEdWSqqnwPZgC8UevgpyDxl3+3
 UwNAHycz9pe8moeWlDcrUNSGcNvR3IOAqDWvTM+gCUrNSHV1hKOLGfn9jwMf+PjuxdLF
 vo8UpTld30jJKPsAMQ5rLYQEsrZ8zU7YY9lqbZ0rch81fQqkZTEpISja0ciUbkLrnehn
 BQhSZJ45GVZJSV3tEXAtyIeRd7dUCtYteGNLSKMDL/E6oE9uo0fEoMkVo8YNGfvJP3ou Rw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3hdtwaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Nov 2022 22:13:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AFKww7T034850;
	Tue, 15 Nov 2022 22:13:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x6fpy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Nov 2022 22:13:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwHCrTIUPGtM0WNNmEPD6DcdqtBBbwD/5DaR9bLDmdBhMvThF7mTNjaBSxMAM8BGB57O6nJEVouMzUKTZh81BOfnJgomdtM+BkRBYHiBoUWfZgnHlTiekp5DXfNU7rKbGR6pqVbPfjoY2XHfx024jZ7GTy0tLlTqNJaJIhiM+HCs618N9zMVXsGp5k9sCPr7RZ0MaMvE6t8ph7lv3jI7GJ6FvHwkYkD4RedBFYnfQeMtceVZ+3lu32t5tGIt+0/nOg0tVnF/6PZwUXyhksIl5BkucJ8a8uOMsqYU0gYAJuSjYpHmiMUr6CuF94Kr+x1/S50VheDeOCLJFg6nGLMHkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7WtC4oe7WoKJCXacfj7vxKb9lZgm7NqWBo2c9uzQys=;
 b=NELEp8y3c6tn727gjcMLCbj/e6/gAzVKQLq7gfBUGJOT5OQm59yRBqiKCyapnJOkz+JIemmrPkj55vPV1hYhm1Y3iYZx0CtXiE9mmMpB0pTjR2O9vqk4zRPyVlpC29YvWgTPXJ5CxcfDQPFxCMan8VxnY+OzNA8W2hDC7E8TBynC5NixANFrMxo5XNcHFlQSj15CToPNgnlXVsadWGAR13HIK1avi9BSOnqcEVA61ZRHJUswQpDmWcqV3YouYkbbViOnvKq069wSF9pR50gv+UpCRaoSeYU62qC4rPg69oeFjhODgdAT1vW3K4+Ame+DYuPPBdhpvYTfDXuQzgzM6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7WtC4oe7WoKJCXacfj7vxKb9lZgm7NqWBo2c9uzQys=;
 b=e92ub8FlXn4ommsGXO5OgB5/HQ/M+mkuEG6S75+Szemaeattxn3CJQyzxv/TWtglyXmCP1dBK7uZyBtpcZiAbf43oKOiaWFYCV+ueogYKHiThYdNymYtugDj4IHJmTl1AiNePgkTAjwsTpzzovkFu0GeGn5ZVUUTtSrTNyGCFnM=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by CH2PR10MB4392.namprd10.prod.outlook.com (2603:10b6:610:79::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 22:13:12 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::7f62:c8b3:46e4:ed1d]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::7f62:c8b3:46e4:ed1d%9]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 22:13:12 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
Subject: Re: blktests nvme/039 failure with kernel v6.1-rc5
Thread-Topic: blktests nvme/039 failure with kernel v6.1-rc5
Thread-Index: AQHY+Joo+0qmAtlReEOjnYEBNEp0Tq5AOFIAgAApjACAACvRAA==
Date: Tue, 15 Nov 2022 22:13:11 +0000
Message-ID: <C5546348-7207-4CB3-825B-87A13FC15016@oracle.com>
References: <20221115022958.ycu7i46vler2n6xc@shindev>
 <3F179083-A3B2-47C4-A1BC-5880237F1CE5@oracle.com>
 <92a953f0-0d8c-90d5-1afa-27215fe31f4c@nvidia.com>
In-Reply-To: <92a953f0-0d8c-90d5-1afa-27215fe31f4c@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB5550:EE_|CH2PR10MB4392:EE_
x-ms-office365-filtering-correlation-id: b48380c9-5aaf-4ecd-73ed-08dac75695cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  QMvQMOSppBuhShUPZfK6sDzl/QWZ8GQIpD2JuRaBld66TU+r7FsVbj5tVRSBslkDr/9pbGRmJ7k0ytwOqywT0pd6827AsGTAZBeON3C0DTyfeUZJo3UkgZxIpYSDsu+zzeJGmjry8gFoLDas/IcpSddbH/Q/jVRTUEfC65fHBRp8jD2RZ1ErLTySUo8DQDg4UEmTa4/abMdk1WtZWA4X/9VK0Hy+8njw7106iG0yjvtYKdo5OTRUw/eZ74tdUUt4iNMn27Ne+6VEJNiOMPFGbY+EOoo/0Oe2m/8CEINCy0WfcRulLIhbuFOpIcKtV/iDDLI0DQy4pGHHWSQ7NeC5z/E2HhL8/PkovHqdL5/FJc5DypmmtB6xD11e2L4SWPH6BREadvT6933m4xAijIb+AaE3g+Vq1jc8V5zqqxly+TcwPHNTMabGR2MPUmRhNClW1/BmPoJ1nFUrxh75lA8BKlV3A2+q/QMYTtaWH4FXIXinehFI+HSFaOKX2+GzWv8VMTj3kob82jTF7GVGAfPb2cnDnOo8DD4dskgpwBOGsCrhlrWlPLpBOnNmD09XPekq6qkfpJPMkqLJ3uJyF8661++oSpAdjsWBpFeQOjTUTlU/2I48++xBw4FJIdyuYkghflEqwTkLHgSEXNfQF/uzu06aJrpCNo29W1qQ29C8ZYblJ0cNeYkhM87/7mbKCQ9ef1izZ43kLJTGBxd5t8f8mY/X0PesL49LsjB+zaevsXIFdxUBlu0WV52qBvYqQQiwWH0PKKLXrF4JwiNdMwdci9wL6GJbknILMOJ/VXKojyA=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199015)(4744005)(2616005)(38070700005)(8936002)(478600001)(6486002)(33656002)(316002)(6506007)(2906002)(6916009)(54906003)(36756003)(83380400001)(71200400001)(122000001)(41300700001)(86362001)(91956017)(38100700002)(66476007)(4326008)(186003)(6512007)(5660300002)(66556008)(66946007)(64756008)(8676002)(66446008)(76116006)(44832011)(53546011)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?aDZKZVpRUU5ReW1HcnUvVVNXUTVPMjBPTmdsZjBBdDFUdE9Ld2NGUmdHc3la?=
 =?utf-8?B?eWRYNlgrRnlCS3Fka2Z5N3M4UlBZSjc3dlBtMElCQndOYkpFYVlDbWhtZkdo?=
 =?utf-8?B?YWw5Z1lodmJGVmZMS1RORU80Z2hLR2lZNVJ2OW5hbFloRjdVdnFqWFJPMnpE?=
 =?utf-8?B?bU5KVXFhbFVCVEx0MkcydXFVM0N5VWk0RXdWYmpoNWJmaWM1YW5DbTNuOHh0?=
 =?utf-8?B?RGVhaEcyWm9oOHp1bkhFMmhzdFpKYVRzRVcvMlFLLzE5bHNIc3RNTUZhQ2RG?=
 =?utf-8?B?ZHFEcE9UdjRMM0FCODQvSWxEdWRTbmE5VkdGREprYXljcXdRRDcrdVNOL3ZV?=
 =?utf-8?B?VFg5cm9pekEyU3dEOGIyQXhDMVoyUU96Um5MUk8vbzRxRWczbVpFdjB0M1dH?=
 =?utf-8?B?UVYzUDBsZ3ZqNWozdHNpaEJPVlR2NTVxM0pSUW0wK2JtQlBZOXZDWGIvbVZN?=
 =?utf-8?B?UUZmK3lmRmZzc0NEcDNvUXNnTnBLWFFZRTBtWHVvdjRYYzhMc2o1NVdDMDRS?=
 =?utf-8?B?R0JsVlBBMVN4QmJ0UmVqR3lsVE83N2o2c2VuYkNDK3NpYlhTOWw2ZWcxVkpX?=
 =?utf-8?B?U2ZjbnJLbis4L1RTNEhuZk5BTlhjSkxNaWsxdG9pVFlnMTBPREE5cGplQXJP?=
 =?utf-8?B?WjV6K0dOcnlZemhSZjU0bGdtS0lIUktxRG5nU3d4N1Vja1dBVzQ4NFNBV0Vs?=
 =?utf-8?B?Y1AwRHFhSUQ3d2hkZ3lHT0w2eWVkeHFCOXp4b2ltK2V2azBLanJPbzB0b1dO?=
 =?utf-8?B?NVJWMUNBTmUwSVR4NW41VVQxUVBpQnk4WVR0dFlvdmxzU21kZ3B2ZmtUTlpF?=
 =?utf-8?B?a25qc2wvSytITnB2WTRLZVJpVC9XYXUyOHVkK3pTSG0xaGx2bnE2SHJtSUs5?=
 =?utf-8?B?ZzJ2ME9KWEE2cVNPelNmUldWbkNGNnBOQy82a1A5K2g2NXpBSzUzYVBZMVcw?=
 =?utf-8?B?S0x3a3VhUGtsSld1NzhGQVM3WjYxalg5b1BwL3ZOY01PaTJEVVlNWVRseEo0?=
 =?utf-8?B?TmZEZko1dFdyNklZNG42cEc3OXkyaDhQczF2WmJSWDAxcW85UlJhalJOcVNT?=
 =?utf-8?B?M1dIMENVQThMNm9wUVFod3h6TlVNdzhwVlNCeTR3bXFra25yS2hxdjlDV0lj?=
 =?utf-8?B?QzRlNEFGQktoWlhXSEVJZktpZktoM0U0VlZ5RGhQQUZ3bFF1azFNVXU4UnJQ?=
 =?utf-8?B?dzNpSm83WU1qd3dNN0dBanhwbUQ5aE12R0FqandUb0RGYXdPZzFrTEtYUlo5?=
 =?utf-8?B?eTNDVllIYzBRMk5JcHJZeko4MDdPYjBXdjY1L0hNV2V1Mi9TR2N3QTUxUUYw?=
 =?utf-8?B?LzlPTENUNHJ0M1prck8vUGRLVFJDcnVNNG5OLzdXZzlXOFllL21iY29kZnJB?=
 =?utf-8?B?d1ExdFRyTlFmSnBOaCtWL3p5TC9XY1VvQmZwa083c2VuSEduaVE2T0hYb1NT?=
 =?utf-8?B?NURrT251QUFOcGhTODh6aDhBT1M4L1JVZkkwdjlKeDY1QmJWdWg2NXB1NE5M?=
 =?utf-8?B?N2dodlhKWHp5S3QxZUNGZkE3RjBwYnNpNk93ekFpbmtub1o5RHJheGlrb1FI?=
 =?utf-8?B?TEMwRkNEQjVNSk13QUVwZVVaNFFmVXY4clZsd2lybWxCTmVHMHJJbzg3SGVH?=
 =?utf-8?B?bmxiZTRHak9QdlNUbVpIbStFOStYd0J0eE5VWWFQbVNUU20zMzNNZ2RvbVYv?=
 =?utf-8?B?ZEF2TzJwQ2Z5czVBMzMwTFdnZ1JZd2JyUEliQjZob3B3cVBlV2VLTkJmZ2hG?=
 =?utf-8?B?ZWEzcGZCY2FDWkYrMzdGUmFBK0tscTlneldRSDRPYUU5VzJOYkNYKzQ5Qm1t?=
 =?utf-8?B?STlKR2l3TDRxdlVrWGFGcDh0eWRnZ3lYaGFPOXY3T0hEcHczeW96ZzZnQjlI?=
 =?utf-8?B?SXFYSlhaQVFHdUhBOUhjNFlCT1kyK1VrUm1sMHJyUE43WkRoSk9GeURvcGln?=
 =?utf-8?B?NEpVNnhXMjVnVjBiOUx5ODdZVHhhSkQ1S21iRzNnTW9FMXR0ejduOGZFRU0w?=
 =?utf-8?B?SG00NTlVeTAzZWtLOG5ZV3VyUVpVbUlmVlZPY3huWU9OY0pMYmpYOTFvNjdr?=
 =?utf-8?B?bi9EanVQVEdwUk53dmEybG1Md05mNE9Qdkpzc1R3V0NaRGpJU2daY0RBYTM5?=
 =?utf-8?B?RFN4TUo3VGJSRUVDcEpXbFBTNFl0UWI3a2NRRlJzY3hHNEVwZTN4bUkrUFho?=
 =?utf-8?Q?7e/wCOpBv7XSdScCjb5qxeUYLWEyqwkAaYIn+r39L9fQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C63425F8ABF7284DA5FADEEFF5B49DF1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	5Rh84Dh1NEuHV5PIxEIIW5Czg8w+591RxRUlIv/gq9+Ay3IyLmqMTsrMeN8XrFW02z63sYZF2rhAsIzd5wkge00WXbzEt+TnkM5ZXkVjJ65Fr2gh6zJHZzENMvHBaOBqQiXPX1G9HIpPZTLlGH5Cl8W6YStZP3rNCV4V3HX+V5D4GFGmCTas5GExheSlvAIAaNwSAS9bLo6hD3D5l7FPbT3AjB5/s1rf6YtoKTSmjcQ59pnpgoRTAb9hq/jlOwnZLxvvwyEaaOt9h3NGV6qn/qUESppArBnAVrzgLQhK2haU1GlJlgXfokdFsAQ4BDnPgA6RDLTZ/84TvDTXNLhpyegRyDOmv0NLehBaNn/fxvR8W9p0vzp5nQ7brbPb8Qc7x4GuJPTPZmDA57lwBLp+8tPjxEHaQQi2XV9txPovJVc7Zxt3UfNfTWn3poIQRGcCwRynaiL9uXowRSiez6lFGIycMgQsBySbk/2L7I4EBg7xIQ4FZH9yWfIpH3BydVgVF2XdsXmRubAaVen9lpjdysT6yDmcK9zQz2NM6ZTHbnz6Es5q7vp0uZ1j10u1Y3ozD4fiu/Y6Q/G9GUE4lcChsLHh/vnBQH+QiWDCIyAfpw71Om1Pq8LRA0a5voI6x0Rdon3YgkfDrJPPrzAbfcdC3O5O0ooz+l5/mG7o9IT1zM+b8oV1xjB4p1/S9cYRlKO/0/cXsncj6x8jnNTfJywaMoGEk1Ui1ZlCIlujWwLmy2d4I7ir7ZWcrkkyny6G9dCDVjr2+vYU73bTTbNzuoBMT4/N7hPZ+zWKrUlZHtQweGJ0u9qoKtXO/15gSKnxLjXQTAhr3H4XQ6p4ZcxrgVP2srywSmEeYxQrlWE3B1CM2qE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48380c9-5aaf-4ecd-73ed-08dac75695cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 22:13:12.0196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eyZyqP+jM+jh3SWuNETphh0JNHuk65RL+IAwr1SIXd3FzrPH3C36Ai3z7Ed0OJeLHM+IoVfE4ksUKkn6Mi1k+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4392
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211150153
X-Proofpoint-ORIG-GUID: iqj1I7ukvK60N-Y64r7JSXB8LHETr2ix
X-Proofpoint-GUID: iqj1I7ukvK60N-Y64r7JSXB8LHETr2ix
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_141321_630652_84073FEB 
X-CRM114-Status: GOOD (  21.17  )
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

DQoNCj4gT24gTm92IDE1LCAyMDIyLCBhdCAxMTozNiBBTSwgQ2hhaXRhbnlhIEt1bGthcm5pIDxj
aGFpdGFueWFrQG52aWRpYS5jb20+IHdyb3RlOg0KPiANCj4gSSBjaGVja2VkIGNoYW5nZXMgaW4g
cmM1IGFuZCBmb3VuZCB0aGF0IHRoZSBjb21taXQgZDdhYzhkY2E5MzhjICgibnZtZTogDQo+IHF1
aWV0DQo+Pj4gdXNlciBwYXNzdGhyb3VnaCBjb21tYW5kIGVycm9ycyIpIHRyaWdnZXJzIHRoZSBm
YWlsdXJlLiBCeSByZXZlcnRpbmcgdGhlIGNvbW1pdCwNCj4+PiB0aGUgZmFpbHVyZSBkaXNhcHBl
YXJlZC4gSSBndWVzcyB0aGUgdGVzdCBjYXNlIG5lZWRzIG1vZGlmaWNhdGlvbiB0byBtYXRjaCB3
aXRoDQo+Pj4gdGhlIHRyaWdnZXIgY29tbWl0Lg0KPj4+IA0KPj4+IEFsYW4sIEtlaXRoLCBjb3Vs
ZCB5b3UgdGFrZSBhIGxvb2sgaW4gdGhpcz8NCj4+IA0KPj4gDQo+PiBUaGUgcGF0Y2ggdGhhdCBx
dWlldHMgbG9nZ2luZyBmb3IgcGFzc3Rocm91Z2ggY29tbWFuZHMgY2F1c2VkIHRoaXMuICBXZSBq
dXN0IG5lZWQgdG8gcmVtb3ZlIHRoZSBsYXN0IDMgb3V0cHV0IGxpbmVzIGZyb20gMDM5Lm91dCBh
bmQgdGhhdCB3aWxsIHJlc29sdmUgaXQgdW50aWwgd2UgYWRkIGEgbG9nZ2luZyBvcHQtaW4gZmVh
dHVyZSBmb3IgdXNlcmxhbmQvcGFzc3Rocm91Z2ggY29tbWFuZHMuDQo+PiANCj4+IENhbiBjYW4g
c3VibWl0IGEgcGF0Y2ggdG8gY2hhbmdlIDAzOS5vdXQuDQo+PiANCj4gDQo+IEl0IHdpbGwgYmUg
Z3JlYXQgaWYgd2UgY2FuIGZpeCB0aGlzIGFzIGVhcmx5IGFzIHdlIGNhbiBiZWZvcmUgd2Ugc3Rh
cnQgDQo+IGdldHRpbmcgZmxvb2Qgb2Ygc2ltaWxhciByZXBvcnRzIG9uIGxrbWwuDQoNCknigJls
bCB3b3JrIG9uIGEgcGF0Y2guDQoNCkFsYW4=

