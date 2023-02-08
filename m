Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 042D4C05027
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Feb 2023 17:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	In-Reply-To:References:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5q2dDFe2wfAskzoFj49XrPN36fXAxh1Akdd6Zc0hsU4=; b=1Bi1PFBfpTOUFWWvvowuq3sP0G
	+UUPglRW1GN7uv6AYYsUM6iL1yzlNdM6tl2/l0VqU7rGqxnmqgkAWQIARWfm5sKeE9KNQQAEM4zDd
	OcBY1lwSQQJLQVr+69EusoBJ4NBX7pZwKKCbyNwSCvzFfGm6pYrk9mObHo0IUdPELp+JBorHpqfVp
	yJg0YNWgKyqc1W536UDsrSOYma7kh9OqTk+fx6B1xLuEPNMpi1dBlcmvNU/glOcAZHE6UyvQFLKr3
	xnuhzm2h6TFnoA858QbY4zYPYNKAW8rx3r2qrOEo1dR36WBykIQ6pkhz/bI05uZ3YKJq0SbPXItpm
	t34UFl/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPoEK-00GRkU-8t; Wed, 08 Feb 2023 17:27:36 +0000
Received: from mx07-001d1705.pphosted.com ([185.132.183.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPoEG-00GRg9-Ha
	for linux-nvme@lists.infradead.org; Wed, 08 Feb 2023 17:27:34 +0000
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318GPTtN003992;
	Wed, 8 Feb 2023 17:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 mime-version; s=S1; bh=5q2dDFe2wfAskzoFj49XrPN36fXAxh1Akdd6Zc0hsU4=;
 b=oY0zCREOX3W+tNuqjC5GqvgMp+xX+jxa/FFZYyMbb/bVt1J2Tve/Acw5gE2h4A8TgkRI
 6vUFscxduwRTK/xfbs9SFkcFmPf9Z67TwJDiHj04kp0Ktc5d0e7jFjids/o2KhtBrpPf
 wnKwQSVkUW1fbEgK5H9dqidGOb9Gz6AV3H1eQlmdOXE5qVyi1deo2lr6eivW3VKv+QGk
 6HD49LzFyWPHBKJh4kQDOD2Z5QfCoNmCkS8h9xCm5AYzVNiLCABgICS/kCN57zfsSR+P
 pV3Dfyqs+9JnvAYYHvS4RpfqWQ4cM8rjVQ8CRsYoFKTEZPVs/nprndkH2hjf/yAS3oTq Gw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3nhch74pu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Feb 2023 17:26:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHVZg2jwSR+XnGtor1oPt7NONtorM6B8lYu23y5vvrixMkDwOsDIxYbSgzQCaOGSLtZftXg3BNoXNJMM+mzb+NYoEByyK9OQFv41+BUPCjGIe3NmZ98XD5Dk+u8l58p+Y+n2ycEXrJz5Im/X4ZqE/M3mxc+TA+97AtwContvYiEjkfyVnGNrk/Wb6rqEOKw+4uP/0OjScr7RZG4hB1+hAM9wR9oAH6nb+eNNsAAX8HAjTBbB5oai29LhfSG09nTV+YZSs+P4DR9qfYYJVuVq8k/xiNSi57LSgZc4HNw/wzj9+MmQIRpV25mH5zKISdGL5HzcBWsNAzqWvOYxgzibJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5q2dDFe2wfAskzoFj49XrPN36fXAxh1Akdd6Zc0hsU4=;
 b=f9ri/kww96GKUPbTlaGLbBAEmBWv+nqJxvcHz79gr9XnAo88Y023L4P8X101KHbZsexVV3NwzKmf2u9jJJ0io5UKjX+vkJq6+WS0mY8XdH5UQxB4i2wr7hm+gYTEvz/WJ0gRVHSEhfGWpNFnbFZpOGTzMI/v659lNhO66d6CZSvi3T034BEkshjrj/SGkdLGvJ8Vb/2zLH3UMN0rV2rg7a2+xpzp0s1NgK3yAsa/tGyNqOytnkHHGOCSm6nq1LRVDxdvGof7+iavKyV7YW9c3LTCH/nVCElFn2brTfaWvLtVx38owsZw+LbdObQiY6CgGfQjFwcouhYQ6tB6O0hhng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from BYAPR13MB2486.namprd13.prod.outlook.com (2603:10b6:a02:c6::14)
 by DS0PR13MB6174.namprd13.prod.outlook.com (2603:10b6:8:123::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Wed, 8 Feb
 2023 17:26:43 +0000
Received: from BYAPR13MB2486.namprd13.prod.outlook.com
 ([fe80::6785:c6cd:c4e3:d0af]) by BYAPR13MB2486.namprd13.prod.outlook.com
 ([fe80::6785:c6cd:c4e3:d0af%6]) with mapi id 15.20.6064.034; Wed, 8 Feb 2023
 17:26:43 +0000
From: "Grochowski, Maciej" <Maciej.Grochowski@sony.com>
To: Klaus Jensen <its@irrelevant.dk>
CC: "Javier.gonz@samsung.com" <Javier.gonz@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        "sagi@grimberg.me"
	<sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>,
        "Lewis, Nathaniel"
	<Nathaniel.Lewis@sony.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Klaus Jensen
	<k.jensen@samsung.com>
Subject: RE: [PATCH] nvme-pci: fix resume after AER recovery
Thread-Topic: [PATCH] nvme-pci: fix resume after AER recovery
Thread-Index:  AQHZNJO7eIWmvXplpUaRY+6lb5hHeK63SiEAgAACMwCAAO7iAIAAazaAgAIPGOCAAMCqAIAAjSBwgAAQ4gCAAF+mkIAAAwkAgAEdYVCABGnaAIAAG+4AgAALJ4CAABkAAIAAgJNAgAB0rgCAACN/AIAAigeAgADHFoCAALIxAA==
Date: Wed, 8 Feb 2023 17:26:42 +0000
Message-ID:  <BYAPR13MB248670C9FD77D33422E4368681D89@BYAPR13MB2486.namprd13.prod.outlook.com>
References:  <CGME20230203184632eucas1p2d76fa9532b4b505e9bf077b00506ff3a@eucas1p2.samsung.com>
 <BYAPR13MB2486C2ABA6E7097A86C14D2A81D79@BYAPR13MB2486.namprd13.prod.outlook.com>
 <20230206140220.6af2b6k7belue2nh@ArmHalley.local>
 <20230206154218.GA12556@lst.de> <Y+EpNeyY/Rc6+Zej@kbusch-mbp>
 <20230206175142.pbs47xamj6gskr7u@ArmHalley.local>
 <BYAPR13MB24863A2B706601D88704181A81DB9@BYAPR13MB2486.namprd13.prod.outlook.com>
 <20230207082930.i5mz2y5bsabnj2ud@ArmHalley.localdomain>
 <Y+IpsEd8kMoljOAa@cormorant.local>
 <BYAPR13MB248697EB976CDAFEB3FCEC2E81DB9@BYAPR13MB2486.namprd13.prod.outlook.com>
 <Y+NEe3OWshJeHsNB@cormorant.local>
In-Reply-To: <Y+NEe3OWshJeHsNB@cormorant.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR13MB2486:EE_|DS0PR13MB6174:EE_
x-ms-office365-filtering-correlation-id: 2fba83bc-8bcb-46f2-44ab-08db09f9a566
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  a7t/iajk+BzMiLCIgOeqE9EsXDeDhl1Rd3w2U0cAuTZ6SQLIPOldp10nvjhO/ofE+xrFGJUWaKJI0GNWuY+XrYnTyfWmv1ImUxIpNWN48kZNENk0JeGRqVDyUhVEd2LU9J502C5msOIdz6wGsRVCvaB9/OCK03I1Qfq4loGm/TNPLCWnZyWibhEnlLTyHLneL7fX2DdB7TUbuJXzIeTfbyI1O+labFC7Kjl7v0yzOdQrdNiSZpJvxCOyZdvU3N9CZq2hiPSExPKI5K9OUCxkr9R1GdlgHShIidbkJfahyleh1+7CY4rU1GVxl9iWz0kH2muiCtBy5OA3074tm8OLi/eKSXd4gbEuUcFJVHRob9NnhWs2fDCI5pLIwwFlMT+2ABbF0zDThx0ZM7U8e7EWZLV27TcvN6nG1TdQ6Dxi+W7VOsX3SV54ThwR/Ru28AMAugI/Usp5ERJbhKfoSs6og+XNO18agg5oWgotI4sHa2c5Ipc8xg9JdRGV5hwHi/JIKJS4+db8q4+4WqLu9WPAWqlhmUxx3vWIrje3APUHWLF7o7hCFeNllT0tFgiRIMGnHVJyknImTsfyJ0tBv5CkVki/02z/d8f6cPIgrjkuQhY0eli3tTdO+7+JDn45iwao0X0s4RqTq7mGKIhlDkl/Szxap/JTbzU6aPi99Y30p6n2J/XlDAEjsYxR2FUVeZmR7/25cbuDKp8YYxHFA/+y4wyN0+48BkUsTllPINPv3iJZTBtrVy3T5BM5rN4P8+Ok
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR13MB2486.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199018)(66446008)(2906002)(38070700005)(4744005)(5660300002)(122000001)(38100700002)(82960400001)(99936003)(71200400001)(478600001)(7696005)(86362001)(33656002)(6506007)(26005)(9686003)(55016003)(66476007)(64756008)(6916009)(8676002)(66556008)(76116006)(66946007)(52536014)(8936002)(41300700001)(4326008)(186003)(54906003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?anErbDMrZXJ0eHFOMnM5RjZNdUdPbDZSSERmVFNiRVplNjhwZ01EdFpNbU5s?=
 =?utf-8?B?c2VYTFJ3TWFwREs5UmpCOU91SVVVVTA1WjJEKzQwODlVaEFQSTlXOEg2OUIy?=
 =?utf-8?B?aEJoRlZMZXovNzZrRjFleG1PM2JYWlpZRWVBTmVycVZhRWlaamJuUHJGSUVJ?=
 =?utf-8?B?VzZaaisrUXRVWnYxOGdoVjl2S0JsdFBCWWIvZXVFd3BvNGY4ckp5cnNVczV0?=
 =?utf-8?B?R2piY1JtUEZINERtTHhBUmJmbzF5S1NoSStBZW9sZ2FsRXRhajQyM05ZQ0hr?=
 =?utf-8?B?YnVtZ1NmK2hoY3JzVzd5NTBIZnBNYXk0dWhJOGFHbjZ6bGJNTUhWOFc2UmlM?=
 =?utf-8?B?aGdQK21palgxbjRtUVNNS1RlTHAzRVRFSWs2MnZld1o5NVBaTUlmeEJXeXRh?=
 =?utf-8?B?TGxhOExiVGV4Vk0wZEk1M2wwK3pmUlRyb3VEUHBwMXVzblIwanpEU0puRkpN?=
 =?utf-8?B?QWVGR2hpNzVCYlRUOUE0STRRNXFLdHRZSmFZYW9SQ1h1TmRnbU82T3hLUlZz?=
 =?utf-8?B?WkNZUU9MVWFoKzlkWGpQM1BxdDVjWEVVWDNYUzVBbW9GUTRLanNlbGMyaHJs?=
 =?utf-8?B?OG9hWXM0a1NVKzMvZy9TQVB4Wk9YM0szVTZYMmhqQnB1a1hpTVBPUDVoZWNV?=
 =?utf-8?B?YzRKaFJ5QUM0eXY3YmxKZVBINEJ0dXgyTTFkdGxudW5YcjIvM3o5ODNxek8r?=
 =?utf-8?B?SFVFL050RmhDc0pvV05uUThLakVNQlMvZE5LQ1BVL0t1R1Y3ZWlHcnkwMWho?=
 =?utf-8?B?cjFvRWUwYU1FbWozVGNDYUZLOTdNNDYzMHpIaUFJQ09QMEJvNkEwRFRFR3lw?=
 =?utf-8?B?djQ5RXNaL0ZtWW1BZlJkR3A4VTRwT0ZpSk5LanZVN1hnK1FJOVU0SGpESUlW?=
 =?utf-8?B?ZEt5YWo0cndaR1VIdWZPZWJvYktSMkxLUUVEQlBHSVdPRyt3VUxiSkJRZkZZ?=
 =?utf-8?B?MG1Tb0tGN0Q1dHRwQU9UWkVXcWJyZnNiMmxLZXNFa0pOQWROVkx4ZHNZSk9G?=
 =?utf-8?B?a0F2RDFvaEN5Mk9DaXB5a25VRlFLNVQ5eDVIOUpzOG83VFdMMGhDQ1ZRYVQv?=
 =?utf-8?B?RlVxVU4vcHNPWjJyanJiQ1FZUTU3N0dnWm5hMWFrTVZORFdlVE8wYlg2YjQr?=
 =?utf-8?B?NVZnTTF3NFJkY1B4bkh1UnYvaTJSTjhVL3ZNRHBRWTRaSVdRNlFocFU5Vi9j?=
 =?utf-8?B?UEJoWURKeU5pWWtzejlEZDU5NFQvekdWejZvUFlCbjUxc3dBS1R0aVRPQi9w?=
 =?utf-8?B?VjI3Mkx4UVZsK3JxSHM3L1lacVhaRTF1dGh2VC9IUk9KMUhEUkVMSDh4ZEtz?=
 =?utf-8?B?ME5lTmU2SmlsdGJFcjM4d015cytCbjluWTNHemNmWlhmWkRoNGhWd0RabUtQ?=
 =?utf-8?B?eXMyRVc0cVd2YmhtMUcwcE5UYVRsby8yVlc3R2EycG9aOXdMYzBQMTVkTGdy?=
 =?utf-8?B?ZEZFaS9SU3ROT3JwQ3liUGg0enA3MXoyQktHUkIzTnByZm1OQnlkdzUxM1pE?=
 =?utf-8?B?SklNdjhTak5zdllDSXB3NEZFL3BRTlZwZDlNZzZjQ1pyMEtLQUt2bC9qUUJJ?=
 =?utf-8?B?OXVXVDVybU0wbVRaU0VwbEFkZ3lkVGpFKzJaQk9LbWhYdEZtUmJFU1FEZzVo?=
 =?utf-8?B?THhsMjdwa2hHZnBOcHhUZGk2dmFKcmxBdVdmN0VwRC96Y0VUeWwzSmpCMVRL?=
 =?utf-8?B?SkI1ZG5LYjZrZUFpa0JMZ3JnVnFqSUhXcXFYYlE0aERTdFlLNUxOcm5DWEpw?=
 =?utf-8?B?KzJIVTJ4aW5NVWpDalIvNEZHZUZvNDFpSWoxRFlBVll3QXFadWhaMzd6eFpz?=
 =?utf-8?B?Qk9FeTA4dEFpeU5RdkY2TnZOYzk2YS9WV2UxcVpQS040Wnl6L3FDMUF0N3Yv?=
 =?utf-8?B?SCtDZnROOHpIa0dlNk5WVkN6UnVyUjV1TWIzamVBTFdSbmVJOThaRXJHaFky?=
 =?utf-8?B?cU9nS3RuejhTVXdDTUpyUVRPdDRIZVJYejIxMDMxUVB3Sjc5eGZsTmdwWjRE?=
 =?utf-8?B?amNmN1ZGMFFEUTRlaTRudzhXMXl0c0JuN21GNlRQb3lXYXdrTmNPamFHVWs1?=
 =?utf-8?B?bW1LT2o3MERSSVRvVC93Wk1FcnB5Wjgwa0M5dnB3MmJseCtTSGRvK1RFWHVa?=
 =?utf-8?Q?ZnGZmDUs31Xo2p2BWYmtvLVLW?=
Content-Type: multipart/mixed;
	boundary="_003_BYAPR13MB248670C9FD77D33422E4368681D89BYAPR13MB2486namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?utf-8?B?djl0MzR5VVRacDVPS1JRRjdqbmlVU3JVNVBkbFQ1bFlDMFc2c0dTY3dMM2s0?=
 =?utf-8?B?VEp3RFIrbkhFY09sR0Jyc3RlQUVWVjZVTzE2NThlM2VCL3BDMk9uSXQ5SEY5?=
 =?utf-8?B?Y2pXQXN6QUdrckdJRURDNnhKQTc3M1pLR2QvL0VJYlFzWDh4dWtvOXBQU1Ju?=
 =?utf-8?B?Uyt1MUxKUHFIMFhkT2VDUVorTHBtY1lhbktGcHVLOFZZY2tNTVB4d2J0OG53?=
 =?utf-8?B?ZERQQmpXcXh6M29zc2NFOE1POVJYS0JObFFxRkFQWU1zUEhPcitIdDdEa1Fw?=
 =?utf-8?B?U1hnVndHMFFyVGQ5c29MYWZQUFhESFV3NWJubmJPMmMvYnZBMSszbnp4RjJq?=
 =?utf-8?B?UHRKYXNPY1M3NDBvNEJFTEVndHBDWC9uaEtFKy9jdVZNWFZKMnVJSG1HSlJy?=
 =?utf-8?B?c0pwUWE3VVMxbE9aRitJSGQzVWxnZEhTVTlLcG4zVWM1SXBDN2kwQU00SDBn?=
 =?utf-8?B?SHJEbUVuSEtHUUE5bDZ1bGNMVm9SQlk0SE40NTlaV3pqZ3pHaWZXUDNnTjFQ?=
 =?utf-8?B?elJGT0xKd0NLemJDVEd1Mk1ucXA1SG5MUjc1L2U4ZTZjcXJDYzQ0SGNoOHBB?=
 =?utf-8?B?VUd1YWgvVkVVRGxLWFRhR0h4SnNaUEcxUUZhVFdSaHFTZWZlSWNIbGI0b3JS?=
 =?utf-8?B?ZXo5TjNlQ0djRTl5L1czWEJNOGVuZ2o2bFg3NG1wYUYrczQ4YlQwSzNjY0Ju?=
 =?utf-8?B?dUtYTlhjbmhWTE5GT0Z6Ui9FZlBaZ0cyYW9JSXVLOFR4QVArUVg2SmVaYlI2?=
 =?utf-8?B?UUdvM29uWE9mZ0VqOTNFRFpBWjB2UWtmQVVaYWNSaDNGa0x3WGVPODdyRGZw?=
 =?utf-8?B?M3JLd2Z2WHhsd1h6L2ljclJ0NE1kajRBRjIwM3VSWDZBbHdDVnBmOFBWc0hn?=
 =?utf-8?B?MW5RQXhiNERZNG4zcVM0aWRXaWtHcXdxZitaanpNUGJQOVpqMGRrZzZRUTlq?=
 =?utf-8?B?Y2h3TTR6ajZzbTUvakNMY0paM2FFdUM0aXlBRjBrNzBJUjVLbERoQWFOeTV0?=
 =?utf-8?B?UndRdU1lMWVXT1JOcno0V3VoRTRBSm1Za0FZc2tBbkg3aTZVa2VUOFJoc3Ey?=
 =?utf-8?B?dUFOUThYK0N2RVY5WVpvS1NBOHRwT2M1Q3JXV3FGSEZjaThNNTFiMktSTEc5?=
 =?utf-8?B?Q1VJb2NKMXpYZC96cTZnNXdyZFlMTE9UTVE4RlRRSkdwTjdFY1hOMVVDT0k0?=
 =?utf-8?B?Rk9oMmpydlNqZkxvRGhWZzk0b01kZVZyR0pjblNxaE1GNmNlSGc0bXViQklH?=
 =?utf-8?Q?noQPQGatD2jI3Np?=
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR13MB2486.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fba83bc-8bcb-46f2-44ab-08db09f9a566
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 17:26:42.9038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oxhUjz+mpA9uJdk9SzMWnhGie+U0QAdY/HmwO57s+8jIz2BhF9zNHEYqqD3IFLKwcMBku0/ZeaDwJ/Zt9K+ZB0rTZNxG5neYIXETXg6HKAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR13MB6174
X-Proofpoint-ORIG-GUID: yEab-KamsATeq6zqQGNivWvhfNpPBAjn
X-Proofpoint-GUID: yEab-KamsATeq6zqQGNivWvhfNpPBAjn
X-Sony-Outbound-GUID: yEab-KamsATeq6zqQGNivWvhfNpPBAjn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_08,2023-02-08_02,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_092732_952151_9EE40012 
X-CRM114-Status: GOOD (  13.48  )
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

--_003_BYAPR13MB248670C9FD77D33422E4368681D89BYAPR13MB2486namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiBgbnZtZS1jbGkgaWQtY3RybCAvZGV2L252bWVYYCBzaG91bGQgZG8gbmljZWx5IDopDQoNClRo
YW5rcyBJIGF0dGFjaCB5b3Ugb3V0cHV0IG9mIGlkLWN0cmwgZm9yIGJvdGggUE0xNzMzIGFuZCBQ
TTlBMy4NCg0KQWxzbyBJIGFtIG5vdCBzdXJlIGlmIHlvdSB1c2UgRFBDIGJ1dCBpbiBvdXIgc2V0
dXAgd2UgaGF2ZSBOVk1lIGluIFBDSWUgc2xvdHMgd2l0aCBEUEMgY29uZmlndXJlZCBpbiB0aGUg
QklPUyBhbmQgYWxzbyBpbnNpZGUga2VybmVsIHdlIGVuYWJsZSBpdCB2aWEgInBjaWVfcG9ydHM9
ZHBjLW5hdGl2ZSIgcGFyYW1ldGVyLiANCkkgcG90ZW50aWFsbHkgY2FuIGNoZWNrIGJlaGF2aW9y
IHdpdGhvdXQgRFBDIGJ1dCBub3Qgc3VyZSBob3cgbXVjaCB2YWx1ZSBpcyB3aXRoIHRlc3Rpbmcg
RXJyb3IgUmVjb3ZlcnkvSG90UGx1ZyB3aXRob3V0IERQQyBlbmFibGVkLg0K

--_003_BYAPR13MB248670C9FD77D33422E4368681D89BYAPR13MB2486namp_
Content-Type: text/plain; name="PM1733_nvme_cli.txt"
Content-Description: PM1733_nvme_cli.txt
Content-Disposition: attachment; filename="PM1733_nvme_cli.txt"; size=1439;
	creation-date="Wed, 08 Feb 2023 17:21:00 GMT";
	modification-date="Wed, 08 Feb 2023 17:26:42 GMT"
Content-Transfer-Encoding: base64

UE0xNzMzOg0KDQpyb290QGNyb25vcy13czAwOi9ob21lL3Rlc3RlciMgbnZtZSBpZC1jdHJsIC9k
ZXYvbnZtZTUNCk5WTUUgSWRlbnRpZnkgQ29udHJvbGxlcjoNCnZpZCAgICAgICA6IDB4MTQ0ZA0K
c3N2aWQgICAgIDogMHgxNDRkDQpzbiAgICAgICAgOiBTNFlOTkUwTkEwMDg1OQ0KbW4gICAgICAg
IDogU0FNU1VORyBNWldMSjFUOUhCSlItMDAwMDcNCmZyICAgICAgICA6IEVQSzk4QjVRDQpyYWIg
ICAgICAgOiA4DQppZWVlICAgICAgOiAwMDI1MzgNCmNtaWMgICAgICA6IDB4Mw0KbWR0cyAgICAg
IDogNQ0KY250bGlkICAgIDogNDENCnZlciAgICAgICA6IDEwMzAwDQpydGQzciAgICAgOiBlNGUx
YzANCnJ0ZDNlICAgICA6IDk4OTY4MA0Kb2FlcyAgICAgIDogMHgzMDANCmN0cmF0dCAgICA6IDAN
CnJybHMgICAgICA6IDANCm9hY3MgICAgICA6IDB4ZGYNCmFjbCAgICAgICA6IDEyNw0KYWVybCAg
ICAgIDogMTUNCmZybXcgICAgICA6IDB4MTcNCmxwYSAgICAgICA6IDB4ZQ0KZWxwZSAgICAgIDog
MjU1DQpucHNzICAgICAgOiAwDQphdnNjYyAgICAgOiAweDENCmFwc3RhICAgICA6IDANCndjdGVt
cCAgICA6IDM0NQ0KY2N0ZW1wICAgIDogMzU4DQptdGZhICAgICAgOiAxMzANCmhtcHJlICAgICA6
IDANCmhtbWluICAgICA6IDANCnRudm1jYXAgICA6IDE5MjAzODM0MTAxNzYNCnVudm1jYXAgICA6
IDANCnJwbWJzICAgICA6IDANCmVkc3R0ICAgICA6IDINCmRzdG8gICAgICA6IDENCmZ3dWcgICAg
ICA6IDI1NQ0Ka2FzICAgICAgIDogMA0KaGN0bWEgICAgIDogMA0KbW50bXQgICAgIDogMA0KbXh0
bXQgICAgIDogMA0Kc2FuaWNhcCAgIDogMHgzDQpobW1pbmRzICAgOiAwDQpobW1heGQgICAgOiAw
DQpuc2V0aWRtYXggOiAwDQphbmF0dCAgICAgOiAwDQphbmFjYXAgICAgOiAwDQphbmFncnBtYXgg
OiAwDQpuYW5hZ3JwaWQgOiAwDQpzcWVzICAgICAgOiAweDY2DQpjcWVzICAgICAgOiAweDQ0DQpt
YXhjbWQgICAgOiAwDQpubiAgICAgICAgOiAzMg0Kb25jcyAgICAgIDogMHg3Zg0KZnVzZXMgICAg
IDogMA0KZm5hICAgICAgIDogMHg0DQp2d2MgICAgICAgOiAwDQphd3VuICAgICAgOiA2NTUzNQ0K
YXd1cGYgICAgIDogMA0KbnZzY2MgICAgIDogMQ0KbndwYyAgICAgIDogMA0KYWN3dSAgICAgIDog
MA0Kc2dscyAgICAgIDogZjAwMDINCm1uYW4gICAgICA6IDANCnN1Ym5xbiAgICA6IG5xbi4xOTk0
LTExLmNvbS5zYW1zdW5nOm52bWU6UE0xNzMzOjIuNS1pbmNoOlM0WU5ORTBOQTAwODU5DQppb2Nj
c3ogICAgOiAwDQppb3Jjc3ogICAgOiAwDQppY2RvZmYgICAgOiAwDQpjdHJhdHRyICAgOiAwDQpt
c2RiZCAgICAgOiAwDQpwcyAgICAwIDogbXA6MjUuMDBXIG9wZXJhdGlvbmFsIGVubGF0OjEwMCBl
eGxhdDoxMDAgcnJ0OjAgcnJsOjANCiAgICAgICAgICByd3Q6MCByd2w6MCBpZGxlX3Bvd2VyOi0g
YWN0aXZlX3Bvd2VyOi0=

--_003_BYAPR13MB248670C9FD77D33422E4368681D89BYAPR13MB2486namp_
Content-Type: text/plain; name="PM9A3_nvme_cli.txt"
Content-Description: PM9A3_nvme_cli.txt
Content-Disposition: attachment; filename="PM9A3_nvme_cli.txt"; size=1933;
	creation-date="Wed, 08 Feb 2023 17:21:00 GMT";
	modification-date="Wed, 08 Feb 2023 17:26:42 GMT"
Content-Transfer-Encoding: base64

UE05QTMNCg0KL2hvbWUvbWdyb2Nob3dza2kgIyBudm1lIGlkLWN0cmwgL2Rldi9udm1lMQ0KTlZN
RSBJZGVudGlmeSBDb250cm9sbGVyOg0KdmlkICAgICAgIDogMHgxNDRkDQpzc3ZpZCAgICAgOiAw
eDE0NGQNCnNuICAgICAgICA6IFM2NEdORTBUNTAzMjI4DQptbiAgICAgICAgOiBTQU1TVU5HIE1a
UUwyMVQ5SENKUi0wMEEwNw0KZnIgICAgICAgIDogR0RDNTYwMlENCnJhYiAgICAgICA6IDINCmll
ZWUgICAgICA6IDAwMjUzOA0KY21pYyAgICAgIDogMA0KbWR0cyAgICAgIDogOQ0KY250bGlkICAg
IDogMHg2DQp2ZXIgICAgICAgOiAweDEwNDAwDQpydGQzciAgICAgOiAweDdhMTIwMA0KcnRkM2Ug
ICAgIDogMHg3YTEyMDANCm9hZXMgICAgICA6IDB4MzAwDQpjdHJhdHQgICAgOiAweDgwDQpycmxz
ICAgICAgOiAwDQpjbnRybHR5cGUgOiAxDQpmZ3VpZCAgICAgOiAwMDAwMDAwMC0wMDAwLTAwMDAt
MDAwMC0wMDAwMDAwMDAwMDANCmNyZHQxICAgICA6IDANCmNyZHQyICAgICA6IDANCmNyZHQzICAg
ICA6IDANCm52bXNyICAgICA6IDENCnZ3Y2kgICAgICA6IDANCm1lYyAgICAgICA6IDENCm9hY3Mg
ICAgICA6IDB4NWYNCmFjbCAgICAgICA6IDcNCmFlcmwgICAgICA6IDMNCmZybXcgICAgICA6IDB4
MTcNCmxwYSAgICAgICA6IDB4ZQ0KZWxwZSAgICAgIDogNjMNCm5wc3MgICAgICA6IDENCmF2c2Nj
ICAgICA6IDB4MQ0KYXBzdGEgICAgIDogMA0Kd2N0ZW1wICAgIDogMzUzDQpjY3RlbXAgICAgOiAz
NTYNCm10ZmEgICAgICA6IDANCmhtcHJlICAgICA6IDANCmhtbWluICAgICA6IDANCnRudm1jYXAg
ICA6IDE5MjAzODM0MTAxNzYNCnVudm1jYXAgICA6IDANCnJwbWJzICAgICA6IDANCmVkc3R0ICAg
ICA6IDM1DQpkc3RvICAgICAgOiAxDQpmd3VnICAgICAgOiAwDQprYXMgICAgICAgOiAwDQpoY3Rt
YSAgICAgOiAwDQptbnRtdCAgICAgOiAwDQpteHRtdCAgICAgOiAwDQpzYW5pY2FwICAgOiAweDMN
CmhtbWluZHMgICA6IDANCmhtbWF4ZCAgICA6IDANCm5zZXRpZG1heCA6IDANCmVuZGdpZG1heCA6
IDANCmFuYXR0ICAgICA6IDANCmFuYWNhcCAgICA6IDANCmFuYWdycG1heCA6IDANCm5hbmFncnBp
ZCA6IDANCnBlbHMgICAgICA6IDANCmRvbWFpbmlkICA6IDANCm1lZ2NhcCAgICA6IDANCnNxZXMg
ICAgICA6IDB4NjYNCmNxZXMgICAgICA6IDB4NDQNCm1heGNtZCAgICA6IDI1Ng0Kbm4gICAgICAg
IDogMzINCm9uY3MgICAgICA6IDB4NWYNCmZ1c2VzICAgICA6IDANCmZuYSAgICAgICA6IDB4NA0K
dndjICAgICAgIDogMHg2DQphd3VuICAgICAgOiAxMjcNCmF3dXBmICAgICA6IDANCmljc3ZzY2Mg
ICA6IDENCm53cGMgICAgICA6IDANCmFjd3UgICAgICA6IDANCm9jZnMgICAgICA6IDANCnNnbHMg
ICAgICA6IDANCm1uYW4gICAgICA6IDANCm1heGRuYSAgICA6IDANCm1heGNuYSAgICA6IDANCnN1
Ym5xbiAgICA6IG5xbi4xOTk0LTExLmNvbS5zYW1zdW5nOm52bWU6UE05QTM6Mi41LWluY2g6UzY0
R05FMFQ1MDMyMjgNCmlvY2NzeiAgICA6IDANCmlvcmNzeiAgICA6IDANCmljZG9mZiAgICA6IDAN
CmZjYXR0ICAgICA6IDANCm1zZGJkICAgICA6IDANCm9mY3MgICAgICA6IDANCnBzICAgICAgMCA6
IG1wOjI1LjAwVyBvcGVyYXRpb25hbCBlbmxhdDo3MCBleGxhdDo3MCBycnQ6MCBycmw6MA0KICAg
ICAgICAgICAgcnd0OjAgcndsOjAgaWRsZV9wb3dlcjo0LjAwVyBhY3RpdmVfcG93ZXI6MTQuMDBX
DQogICAgICAgICAgICBhY3RpdmVfcG93ZXJfd29ya2xvYWQ6ODBLIDEyOEtpQiBTVw0KcHMgICAg
ICAxIDogbXA6OC4wMFcgb3BlcmF0aW9uYWwgZW5sYXQ6NzAgZXhsYXQ6NzAgcnJ0OjEgcnJsOjEN
CiAgICAgICAgICAgIHJ3dDoxIHJ3bDoxIGlkbGVfcG93ZXI6NC4wMFcgYWN0aXZlX3Bvd2VyOjgu
MDBXDQogICAgICAgICAgICBhY3RpdmVfcG93ZXJfd29ya2xvYWQ6ODBLIDEyOEtpQiBTVw==

--_003_BYAPR13MB248670C9FD77D33422E4368681D89BYAPR13MB2486namp_--

