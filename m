Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97BFC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 19:18:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA3DA60F94
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 19:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AA3DA60F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qSKqVEE13CktYQk1NevZwoGpcB3BQokmbEzbkdcHLAE=; b=uVASDGKfAzG0rr
	d2e5DQpCJJrg9Soq03WnpZYKFVlN1KYRkyUuzMjDaNx9yLmRxQS2quX056wEW89NRAwTiH1Ux0c/k
	NPUXrt+pkkNljKGiNwiGI+aV3vS417jbMxIDUJhDsZr16TYRmqrfshEmGrvQjzeLqQGs4I+QwNwmq
	fjygQVmMBEuiBXcXQN1S7Q1VCwORSF7u/MSmodwQoDDOMAeB3ZjRVle+/sCv83H82zA0rSkl1AzRt
	lB0VnhrfC/se2wWbSXHHas2FB5Gouy+4dD1HqMfGBhKfkhFGCqgNDMkQT+s7SW2fBwhEj6sGr3DZ5
	EeOG+wSARvfSDFFFpyOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUw7M-003xXY-Nq; Mon, 27 Sep 2021 19:16:48 +0000
Received: from mail-bn7nam10on2051.outbound.protection.outlook.com
 ([40.107.92.51] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUw7J-003xWV-JY
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 19:16:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqS0FVhN0b8kw539GkfWUttuDxcwhqiLa6jXzK7QGg514LeFe5diRXsbYZ0S9Dsq5l0enr+VeziTE8VrZgMaBhnig7QGHVlABexuVhdC6MsUlGGBgJsi44gvJ1sRSCltXYxDzTcWcJcnIiSor/g7Mw8pEiEPJkGGSLSCFgvBCbC2kUuz/tBQIe2WqWuZ/H5gypH7+1U1z1HB2BRjcN/cvN4K6ZPKLDjjESDgnEbPZOp5qfJ9KDBHT6EedRZIpdOpbd7cY0swhN+LeTXSwYbXKENk8OemzNf6/7WShZEqsAboxisOEj0AEuGkpvqaWfFW1BAvLpR20N4UWRwDK4E+nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=fELjKdSaYaexhOMPB+l1aUWxbyKeoLlfaIUYk3UvT90=;
 b=TWL+y3xhsZqYXELEQ1xW/JAjjmYbewZI4LOWuJ99HoiMKcsdIELLK6IeiZjsaTGhRipixZSVL+BRYMuhkLQN4ScUOvcfbqCf2ue5ORevrquGtODVx+0tughosFEz41DFmiW4x4UX2hu1PwfO4UQOq5UZ+hyP0YDEyH8qhZ5HIskrKjPzWDr3Mup3PrjRtACuo5Qse0qpI3MFbyHgU5SMKKvweA6090QhqyKaDBEpC/56dSOsgvzv9NBIT7TllfTR3TyB2DfE1k0U438f41ncBU5t3taP5kO+FF44YYgeJBV34NdKZ6SxTAHEuUg7OpI2DDNxbo5bXN1eyHcAEaqd7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fELjKdSaYaexhOMPB+l1aUWxbyKeoLlfaIUYk3UvT90=;
 b=sE1GILsLf/pyAgDhWrL1b71DhQQYed6peE9QRpPDW5KhdsToc2T2BaycvRL+CNB/ik6zIifOz4NU16MXZTTOwbTuhnaTGPGcso4qp7SM4g9QK8HJ5tEZSunzdpORbDSx4nQKyS1574jO4c/HAD+PUiOduT1ax3VWV7LXRCXjGxwaKI8MSj0c2pQC6YT5PUNrPkgLI2x3dTew0V/cUgPSri0M3oGxNg2aUJZv43GMmvpUjL05Dwf141j/uPYtbRptz3G4iua9cWcGC3m5ydclGIxCpMsqBhCiyJCgcA05AxhsZ8uWbm+xPI/Dg3mYYnUy4IfiHNQhGD+D8cvIeJUEyA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4539.namprd12.prod.outlook.com (2603:10b6:303:59::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Mon, 27 Sep
 2021 19:16:42 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::498a:4620:df52:2e9f%5]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 19:16:42 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@kernel.org>
CC: Max Gurtovoy <mgurtovoy@nvidia.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvmet: use macro definitions for setting cmic value
Thread-Topic: [PATCH 2/2] nvmet: use macro definitions for setting cmic value
Thread-Index: AQHXsGRFz0+97tHOfU+EfUYbUNHLmqux3ckAgAAoxgCABkEPgA==
Date: Mon, 27 Sep 2021 19:16:42 +0000
Message-ID: <136afa6d-2e0b-a973-19b5-c28667712309@nvidia.com>
References: <20210923101744.4204-1-mgurtovoy@nvidia.com>
 <20210923101744.4204-2-mgurtovoy@nvidia.com>
 <a6381c90-4eef-a9e1-2156-9f7539f169ea@nvidia.com>
 <20210923194616.GA114816@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20210923194616.GA114816@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bc4ca6c-7c0b-4d49-ad1e-08d981eb570d
x-ms-traffictypediagnostic: MW3PR12MB4539:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR12MB4539B964C929578DA593DCADA3A79@MW3PR12MB4539.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i0httw1NJwQuDcUVNVjPp7ViPnaqHJT1eiLlL3v4KbQx3Sdxi/3PymADaeHCm414qnzXW33Vxp+NwTtZfsiW8vgxmhtqSlui7WitWI59DmXGTiS7Z8FJoedCr+jWeQddOpAERrYVuSIwMAJUNZadH+zmOKDLxgXpAjHwrP/1sPhdpyL5ZNWbSXrjC1g0/DgofkrhoLQqVBoIPmPeGOiSM2O/IZrSfdgcSxG+OgZbRMyebjhjyBKqzRFsJFppn7ZQ6KSPn7rxOntV6szimNTuEsEne50KqNzpgjzmpHHNTtBOIx+GUUDVoLXprEPK+92lXEoJnjK5R3JPlXTboFsuCnuxh08l1Hj3PePgUhqnJ8LpXHjWwsQj0S1l80HUW7+2J6mx0z1Sw9iMB8D4pEnEj1u3/OLcprpCFl6/HCbF0HJHjx5sOZfMR41mKGcC/p2B/5Spxvov5ncnZ8nn1XixznKV8T+VnTH9DamOlrsRC9OfE1lA+TN25MQdnGgAXqV+rnKaJMjinmf3NLsU366yLl09cxIbqhKo9XE6TjMclPR6PY1QOE3nAk2nnEDeS58Aapkjihy+eriOCBI0Q9ExkD73kPCzT0O8kBMudR2DpCg/emTcRvKm2Hv7B1kRzCBjQnHaP72qzqf7QlmuVnFoZZVYyEUgs6rySaGgcW1BuEbuL4dniTrbvNSzI0t6Yl1VXxUK5wTsRD97js7qXDZPmM/XR2oGdKncwJZF0WzXu1lGzf2LU67nMhUJPIyPIseEYwo7RXpWRWe0ciBZxLYJvw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66476007)(38070700005)(66556008)(2616005)(4744005)(5660300002)(508600001)(66946007)(8936002)(71200400001)(66446008)(26005)(86362001)(2906002)(64756008)(91956017)(6506007)(36756003)(6916009)(76116006)(8676002)(316002)(6512007)(31696002)(186003)(4326008)(6486002)(38100700002)(31686004)(122000001)(54906003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTRuMGZEall5c3Q3ZHhpZHE3ZGFlRStNeDcvcy9zSWF2MmJwTzB0blI3c1Ev?=
 =?utf-8?B?d0t2UXBvcklIZzl3NlB5TFZFU08xSk1nRkxUUlkxME9Zejh1MWpsZEJBTUxG?=
 =?utf-8?B?cWhERlBhbFM4RnpEbjdkRHpaY1VOcWkzMU5KbXB4TVRGd1V5bG9oaiszc2tj?=
 =?utf-8?B?OSsvczh6RGZCR3hRWDUwLzV3emZRL2pHMkJYdVhEaGdicUhHQldZaHRTVHlJ?=
 =?utf-8?B?bklobW9DZmRENGF0eVNUeWx0SW54VTZmR1dNR1RoYmg2UUJwOERrOXlqdFVn?=
 =?utf-8?B?VTJKT00xM2I2czhEclZEZ1BuU0FMRlRvS2dtdENyWk85UHRzUkMxbmZtTGcx?=
 =?utf-8?B?NVFTeHBNaDRKY1JsdWNvb3RhQkRlR3BlN1kvemhZa3pzK2ZZOWFtcytkbDNq?=
 =?utf-8?B?VmVDQVNyZVMveXM4bk1TS3FEdGxQYURmT3d6R1NCaC9JOUJ0dkFGSTQ2Skt5?=
 =?utf-8?B?VS92U2NuazM1RDA1aUhpVHJFVU83bFZIYmc5akxGcWNldFRuVzV5WXlFVm9I?=
 =?utf-8?B?eGVmelZHQmhRQ2FadU1ZcXI2SkhNWkJIN3VoQ1RkU1BNOCtuTHdQZzdRRzEx?=
 =?utf-8?B?TXpGbXBmY0djYVM5ZEtmZ29ZQ1o5R3J4Nm9vSm12QXBiMHpMYk9JYm5FUWlr?=
 =?utf-8?B?dmdXTDdmN1lzbm0zYTdyMXRXdDNTVmRKVjF6MU1MN3pQd1Q1OW5HWGlGZEQx?=
 =?utf-8?B?cDVybDZFWmxMS2FXa2Y5UG9MeXBhVktlaDJzSE02b1ZRK2E4a3JpV3dxaFcv?=
 =?utf-8?B?VHNWdlB6R3M2VnpLMmoxK0VNVGdEVHZ6NU9uZTYwQ0swV3p6VmhxRitvV0pa?=
 =?utf-8?B?ZTRrSEc3N1ZzT1VnNEgzV0JKOUF3aUhNclhXeTZ2QlZiOEx4YXg0VlNzbTFE?=
 =?utf-8?B?anlzRmFmWnJDSmFyN01XVmRLZEV3bFJFR0x5ZEpjSERpMUFPYjRDUXRtb0kw?=
 =?utf-8?B?N2ZyTC9iYm1wWGpOdDZ1V2daZEtWU3ljR1M2OXdLd2hjZGhVNTJncnVmMlhi?=
 =?utf-8?B?QUpydjJzdENjV2QrSVNvQkdOWDhYVXBoU3JmL3lGU0dWSStnZTZlZjNHZTVp?=
 =?utf-8?B?TUMxZWlVU01nZUJjSmw5eW5sZ29uZDBMTldWYk9rOGl0a2llcWlNQjZLaEtu?=
 =?utf-8?B?RlU1RlZzbGtFVU5tZFExMDRkL1h4ZURqbUYxUCsxbG5waVZtbVEvREMrWUFi?=
 =?utf-8?B?Z2JoR0ZsWStWazFkQnNoOFNGVmtZeWRObXVYOWNzWkl6K29URlcxdC9pRTg0?=
 =?utf-8?B?YzN2TGlqWVpMeE1DRXl0a1pVSFV2ajFubjVZYm9ITHhhQkx0K2pJdkZhdXpo?=
 =?utf-8?B?N25TRGNiZ3d6cVZBWW51MjZBcWVER28wdVJHV0NQaFlkd1JPQ01LSm9yU1Nz?=
 =?utf-8?B?MUZ6eWNOdGZkU3ZyQW4rd2g2K3NreW9jaUIwa3duaGs3NTlHWnRUODVORWho?=
 =?utf-8?B?S0hFVUt0OENlQUx0a2UxNUxUb2dYSE1tazhvcHYrVTZKbCsxRmUxTUlaVmxS?=
 =?utf-8?B?cEh0aDJiQzg0MDUrakpGbUpkNFMwVXFaK0xLVURPZVF5eEVMSWwrNGltOUlG?=
 =?utf-8?B?VFczM25aSThZZWU2T280WHZpUFJxSS91WFhGM0FqcWMzL25HY3Q3SWdNU0VP?=
 =?utf-8?B?cHBzVFptdzlldHVFQ2IyaXBoeXloOUt4MzcyL0dUNDJJSHo2bldQdm5qM1Qy?=
 =?utf-8?B?ajlsT1g4M25FVXdEamhEYnRFMUlSaXIzYUpvMHYyVjB6QzlCbzZ2RDdRWnJy?=
 =?utf-8?Q?1LisaagMW9hpVAgeSdQuOzqwWFtSgM57s1DoUp1?=
Content-ID: <D14543D7C5BEBD448D7ACECBF30DE16D@namprd12.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc4ca6c-7c0b-4d49-ad1e-08d981eb570d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 19:16:42.6108 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IQgV6rSqfCJcUdOOT/2+c11a0XiOsD0E3Zv/V6yg2DIj9S0CD+xWanhCg0yT2nHgDHzwoZ7DRw95kEYDv1T+SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4539
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_121645_688103_65286425 
X-CRM114-Status: GOOD (  12.66  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>
>> So we actually had this discussion before to keep it open coded.
>>
>> If I remember Keith had already sent out patch for this one...
> 
> The similiar patch I'd sent went in as 92decf118f1da. I argued symbolic
> names helps browsing the code since we can tag/cscope them, so I think
> this is a fine change.
> 

thanks for the clarification, I think I've missed the final decision..


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
