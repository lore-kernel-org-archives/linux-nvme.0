Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435EEC4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Apr 2022 06:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dCIGjbEh/1bSaUIv5EwLYv7gTeOyhiQdvD61eFohIJ4=; b=ERCpHHUBjkJqsqj0nMqwgbng2i
	MHe0mI6tc8kSrtHgHSP2t/B+gcnZzl67pzxi+WVPKWJh1WfnSzDntW317rn66K42Xw5+MW7EMpbWw
	MEu2bwy8JDe/jsag4hlYf/pvuXPSPsnrtdq5eQVEG9gjtZzlTKNoFwTDD8l+eE8qKa3M+NYQ7pE0F
	7aVofP96xRlv/nwYvi8sUrVF9bo1ITEnqKkiTXU6jRxKb82bWX8w3ElgjYxIuekEks/K+DmYSr/8V
	SafAXA1ZSFjJiWCHZOOEqSflJLuJsELePUMc/I598eWLheF34LIdnvHptAZyEUkN8B727LYtkllXU
	qBNXGBqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nfF3v-008qnR-3n; Fri, 15 Apr 2022 06:04:07 +0000
Received: from mail-bn8nam11on20626.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::626]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nfEzb-008o0i-QU
 for linux-nvme@lists.infradead.org; Fri, 15 Apr 2022 05:59:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LybNhFvNNygyAvG+fHpnj/TUzPG/TvGc1IeFGmOqST9vw8WmtwMJbuSTIeff/KNjBmhDTMOvDjgwtJAk+CAjZ4v7OuLcUD4XH7BHQb7uAQ0v05NYbBFK7hd5R09M3FwvltY9P17z8e/B9SWCcSMdQZZ0cqjXs0QXpZ1b6+g7UgkCj9VY1v7EaFLnXq+xIS8Zz8UX+lLhjupUGtRZEeT1yeJlaGUg5rmEfH4rtLxaDjX8xnH/+Fq2vWxV8kPbeVlsY1wgwW24v+oj0xFi157VnwdsjcUcr5PkLIdW8elwRclq7XwuZ08EES144c85qoJXml5L36+vNEfr5eb0W7VQXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCIGjbEh/1bSaUIv5EwLYv7gTeOyhiQdvD61eFohIJ4=;
 b=iOZASvTlzoRQ/yLZQVlbWca5Ffx+Fasg9Hb0ILVDuzZGN2JSqiFqSRfzaHjvpXYpFvvOTsi4EEypqr2fh194hHxQp5HsevZqgM9ydUW43MFhDdMpBj+m+XPEWWPwQsGD7eWG1RV2ch4H1fGnnh54g7Yl5T/TE8+UDZN70ZeZsefOAO5yaRmm2rQb/BVnxhgaPZfaFpRnjSCn6hk//Dnx4C3sVO8CYynv9LeQNouZpJkCPJI585CAo5n+6n7cXEr0WDjJ4hSSEvNxeKiy2c2ESOIF5P9//5t5g7k5p5urpO4pN2a5ODBhImwuGeW31027KphtF8ir1pJ4XeaYRTNCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCIGjbEh/1bSaUIv5EwLYv7gTeOyhiQdvD61eFohIJ4=;
 b=V4gHYgLRfmv2AJbiGE9EtDkit03Tv43GRhFbsFCWjZIw9Y5/bq+4HH1QCKrLqRgs8Yq/5doLiU8bP/e2XnDZ+1ThEeLQZjMw5yyStPPnxsCrTw43uqdWh6b3ypifvGE1c1pTytfyOr/xd7E/aPptXWLwGYVoCGk3BP33R9vym5n4/V4Ss1rkdxplPiot5xr4wWDbpL7HUiMVI/CR1IcLcAnkFgXHrMRiazmaJnbr+QgHNH2xT2hD3ou3pUsKQkbM87SLcs8F8Gzk0448dFonvrJ1mZjXC0MbSpkRBownQbZzi3bDOL9IY/0JBjszewtqQpHVayQphEe4aTKmWEaEBQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR12MB1513.namprd12.prod.outlook.com (2603:10b6:4:d::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Fri, 15 Apr 2022 05:59:35 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.030; Fri, 15 Apr 2022
 05:59:35 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Yi Zhang <yi.zhang@redhat.com>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch
 <kbusch@kernel.org>
Subject: Re: [PATCH 3/3] nvme-core: mark internal passthru req REQ_QUIET
Thread-Topic: [PATCH 3/3] nvme-core: mark internal passthru req REQ_QUIET
Thread-Index: AQHYTVIguewqbSTMiE+3bgRKWDMtlKztw3sAgAK92IA=
Date: Fri, 15 Apr 2022 05:59:35 +0000
Message-ID: <4c5a1020-1229-0e9a-3c59-fa4002e34cbf@nvidia.com>
References: <20220411031249.5158-1-kch@nvidia.com>
 <20220411031249.5158-4-kch@nvidia.com>
 <CAHj4cs8Teng17XnDc8t5bjZzL1Gv=9+hnvghvkQBqUHKWYWvUA@mail.gmail.com>
In-Reply-To: <CAHj4cs8Teng17XnDc8t5bjZzL1Gv=9+hnvghvkQBqUHKWYWvUA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c25e7ce-ed90-4950-4e17-08da1ea51e7f
x-ms-traffictypediagnostic: DM5PR12MB1513:EE_
x-microsoft-antispam-prvs: <DM5PR12MB15137118AB3D79B167FA3ADFA3EE9@DM5PR12MB1513.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 406muhqkS6sozVWCSwW4pcBGJCAkx61y2hnmqjNeNLdW5n23ZwFYQ2v5jGKZDqe9sIUzWoI1dgvdLTEa1XyraJAdjJw1BAq6AMqAO9Bf2LRSo2sq1EYGsN4QQ1LE/QST8dxJSaujN/oRq9JjtKsmmp0naVMWa4XsT8xPkL1CEhnp8ct+Klc7kf/k2FZUNFKNjDR2evtEWjrGf+ZJTwfB+ooFtj40wDrnPj2fYa1PxJ4Qfw9eVI0V1YWUZVKcEB5xvTvk+zcNWNuVvsG2yvrcGiAwYMvXFGoV7xGbB25eDU7nRwhNGz9Xho/DWZIQlGprVINFF6uMWB0NEvRXoo0UeoWbcyuuxQh2rZ18X4FFcomRD2mLa+c/Syuuj+1MxhRI4ZjLhLfjzPrGHZQb9MHNE4nZ30w5eNv6WSpU3h6waZDmolAVxY7jZ1wGBhpXylb0i+b+tesDIiG5PhpXGF52+uj1D3IBstrkTg6gJw4Y9tLeg9UCLUNpAWjviR09GlHtGcxwUxl1SycPLTnUfp0sW1UBziqSH1pZTcy8VYzAavp9D9eU1kLCnQn0ADER9GTJtsKQ1KB1fvAsWrwcBMH5rRiONuESBXXjLMaqq9DTl4bfG6JHRgCSM2C9f8oeBuYnqEjG44RClFdizLgCt6E9qJztxT9gsn3QlqZ3/a9UidP0W9X8xub6OTZrSORexVTQAFMMQos4Wo3h+0hdROj3U5EjEGM93xBS8T5+Nc24r3/kF0gGmOhQqjPhRZXW9+qmACcZ4Hah90yG1Y+TUb5pyXR1AXNL2ZXutBdrnbKzp1YNp+BlpfX6ww9K4uXQAWw1pJOvPzxnG6kCR4zBR2NPYkkFpWmHW5eFYm3H8Jc8M64=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(966005)(31686004)(6512007)(6486002)(316002)(5660300002)(71200400001)(54906003)(110136005)(2616005)(91956017)(83380400001)(186003)(66446008)(64756008)(66476007)(66556008)(66946007)(4326008)(8676002)(31696002)(508600001)(76116006)(86362001)(38100700002)(38070700005)(2906002)(36756003)(53546011)(122000001)(558084003)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aG1KQzlucWI5OUdobnFMSEZqbk5SY0NaY1JBaDRpNkwwU0Mybmg5MzFCQ2VZ?=
 =?utf-8?B?OVRDaGhQYmpTak5DVWRYdUhHSW9ZNlBRRlhJUEhKektJVjVoR0V0Y1Z0NTJZ?=
 =?utf-8?B?T0M3Qk5idVhxMlRueGZwVDRZUEJ0YWpIbzZsYlpuemtYMHlWdFQvNklLdVJQ?=
 =?utf-8?B?ZXRVOXNHWExwQ3ZrNG9weWU1c1UzSW1vai92OVNaay9NQ3Q5dGR2N3o5a21j?=
 =?utf-8?B?dVNmbXdrUXZjV21xQ1YySWNqbmJRL1IxdkluTlVqdU1WVFlhTUVtdEhzcWk2?=
 =?utf-8?B?eFkxNkJNeFFrZldrRnNvVGtwTnBTNEJvRUp6RHpJSW1yd1B0TXNoNXhURXNF?=
 =?utf-8?B?TytIbXpwRk9PRmRWS2wvRkVnM1RUUUh6aTdyWW80WnNySUxmSlFpdW45dTd1?=
 =?utf-8?B?ZWlZWnNDbU1SOG42US9UY1o1WHJDbC9admY0V2FzYy9Eb3Q4UjNlMFU5ZFFL?=
 =?utf-8?B?b05XRTdZTUVOYjhWcXNaSVBteW40aWlKOGVVcy9ac2JUeEdwMkZnUDI0eDRp?=
 =?utf-8?B?a1hSZnAvZ0d0SlhtVFpGZ2pwcGk0ellBVzgvVUpGdjZPYWNDd1U2THU4NndF?=
 =?utf-8?B?S0hxcWJOZ2pCZVc3dzBpYkhDV0h6SEpHaXJtT0RGZHVmUEhNemU1R1l5c0JV?=
 =?utf-8?B?WFJKNnMyanh5bFpZZjFPdWJnQ0ViZFJGWmdUbldwZVhIN0FIWW41dzlicmZM?=
 =?utf-8?B?b096SzBpOTZZcWtwbXF1d0l4RFNEdG5kTjF5RWtkQlhTd3greXJpSXJ6dHh1?=
 =?utf-8?B?R1lyQm1EbWlHQ08vc05Tc0NsbzJ6UWUzZzYxZUxYN0JiYnMxUnpLU0dQMExR?=
 =?utf-8?B?SDh2OW83VGZqcFRqWkt2NFhNWEEzMmJvTnJ5Q2RQTTBRZHdvVStLUzVrWjBv?=
 =?utf-8?B?TG02Z09BMlFuTWlBTXlQOHJsbFY5VmdjT2R5YVZqakZQMjZPMGorWFVSS0di?=
 =?utf-8?B?WGhoa0JRZU5jSEw4THpab0pHV3dEUk1UZUpNV2Q2WkF3L3h5U3A5c1FEazhM?=
 =?utf-8?B?QUtwUXlQenRBR1lFRzB2R2swdVlkVWRxNzJTN0NybHIrdy9VaGd4R3RVUlRY?=
 =?utf-8?B?ZUhjaGpNTkczNXpoWWdKeUFjVTEwUDRXTVA2TzlRZEpUOWRZbS8vaG8vRDc0?=
 =?utf-8?B?N2c4Zjcydk9xTnk0UCtBUG8wUERWMVNkTkE0SWRBcVQ3VHRpVkdvZjhWaTdv?=
 =?utf-8?B?L3BhenZZa0VUWkw2WG96RzlvVWJnbnhweXZiVVZ3cG96ZkplVExCVmpZTERE?=
 =?utf-8?B?MlBPS09OdTdlaElZckg2SXpLVnZoZEJWRFZWK2RFT1FzR1NEdkt3dG92ZS9I?=
 =?utf-8?B?VDhHQ1JwdUw0Uk5tbWRGRW95Q0VMR0VvbEJvWTNIQ2M4VmE5NWNmVXBrZjNn?=
 =?utf-8?B?d0pOaHpURnJSTlNFb1BNSVN2UjF1d20vRHJEMzZtTzcrOVlEZHZEWDVNQWRE?=
 =?utf-8?B?bmVCRy93cyt2ZTBSbFZRNFpIdjdnSnFCYXR3eG9ZK1RpNzFMUjB0OTd4SHFL?=
 =?utf-8?B?Y3c3Q3pJd2tHKzBjUE5iWVV3SEV1cjBnek5QNDc1aTVJRC9HSEJoZSs5akNs?=
 =?utf-8?B?YXFvMWlNS2dZWHpYQnJuWSsyNkpCUHc3dDFuVmpYb2ZFQnZ5SEFJNFNuZ3FU?=
 =?utf-8?B?elBVbTJ6bnIwNC9mS0xYNkRxblpqdkNnMW5uMnkvdmlUa2pzcFNsRlpYT29s?=
 =?utf-8?B?WnFjM2lkTnFUVllMeFJJYk1OYVNVanpXUkhXY0lHT3c3aVd5cytLczBodmRS?=
 =?utf-8?B?MzZkcEl1OEtuZVptNWN3RmF4dkwvams2ZG5lRDNYdzZkaUZzQ0J4R01Yc0RI?=
 =?utf-8?B?NW5uR1lzWDVSUkJrYjVUYi93S25QZndzNklja3VtYURUUzl0bi9nT2FET3NF?=
 =?utf-8?B?aDgwVzdiTDRZWW1QNzhpSVhzTS9jZ0dhbVdNNHhTK0FSaTI2NU1IWDFjQmN0?=
 =?utf-8?B?SFYrc1ErUkk4QmEzSnRGMG9Xb3V1UnViOWQzOFgvbkNpWklpY3BScy95KzR2?=
 =?utf-8?B?MkFtL3ptQ0VDbXNHWlloWThMK29leXdqWGMvZnA1bC9USk8wV2FWNkhObzVO?=
 =?utf-8?B?UUhLY2JQNndjZGEwdDBwKzJzcFRHNXhlY1FlZ0xhZnpEdk91c0pONmFwYkVG?=
 =?utf-8?B?QUV6NlBpbndma0RpR0wrY2crV0x1K2xBNU5FR3NHWnFMNjFyVENRTzNjODBG?=
 =?utf-8?B?eDlzMEVtM1ZkN1JOaFpISEV1NEdLRGg4YjBQMzNLSHE2OU5tYnR3YjhWbjNV?=
 =?utf-8?B?QmVFN2ZhK0tJd0xpOTJGRTIyT1NSNWNzNEtyTkVqZ0ZscTNQbTNMcytnRTcv?=
 =?utf-8?B?VmJPVGxwL0lxUExYVFVXblBuQ1llZFRKczRkSEtWZ1h4amVEZ0FyWk9hdUlB?=
 =?utf-8?Q?VvjlR9TxxfMEwY2I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEE5644D2A8B2A479CF562D9FB958FAF@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c25e7ce-ed90-4950-4e17-08da1ea51e7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 05:59:35.5349 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2/hG6dfoiA19Jlr2+jYMvwiGqJIOeFKIcMGAzB3KewQCy1d7gyWoPkGJ9o7+up+PNHCtZR/6ej04M5DY61HgSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1513
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220414_225939_943879_6273505C 
X-CRM114-Status: UNSURE (   8.78  )
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

T24gNC8xMy8yMiAwNTowNywgWWkgWmhhbmcgd3JvdGU6DQo+IFZlcmlmaWVkIHRoZSBpc3N1ZSB3
aXRoIHRoaXMgcGF0Y2ggSSByZXBvcnRlZCBoZXJlOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1udm1lL0NBSGo0Y3NfaUMrRkU4WkFYWFpQZWlhMVYzWlg3elJiZUFTZE9QXzhjN0RM
aUZvek5mQUBtYWlsLmdtYWlsLmNvbS8NCj4gDQo+IFRlc3RlZC1ieTogWWkgWmhhbmcgPHlpLnpo
YW5nQHJlZGhhdC5jb20+DQo+IA0KDQpUaGFua3MgYSBsb3QgZm9yIHRlc3RpbmcgaXQuDQoNCi1j
aw0KDQoNCg0K

