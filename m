Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769B6C6FD1D
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Apr 2023 04:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Qz6zFmPKuwpRr0NFQxzwCtIIplxCvRNOXnLjXpFFY0=; b=qQVaPRdBki8iUcHw1ytAe7cNfY
	im6Ij+3OVyjV0lCCp42CL+t4Ua4m/3EwT/lDyovAaWqBCMzOsP8IqNp7nw7jE7OeXeF0HqMDGySbt
	TL3zemw5Id8j+imef58GNU5VuFtnwSpd+aIi5gwUpt90IVupWAfvZ/pz1JjS8LLwoparQW/Rytd3N
	9OTKbeZj1IhH43l1m94wkDv9QDlnkuhgQUL0f9ybI66ksaXi7/7zmXPtwJojbnZDoFenek/KVTVcu
	Qx2pPm4UWEgUEjcymWmTT21mYqmo10kmkGMN+0xkktoYz9m542WODPRBusdoQOk9UO/JMuK2j5dot
	ah+hYeDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkdzc-0099yB-2t;
	Fri, 07 Apr 2023 04:46:32 +0000
Received: from mail-bn7nam10on20628.outbound.protection.outlook.com ([2a01:111:f400:7e8a::628] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkdza-0099xh-0r
	for linux-nvme@lists.infradead.org;
	Fri, 07 Apr 2023 04:46:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYB56t+V3nkGTTbzKGaN0ippNxEpwANqcNolc3BJT3Bpb0TcOMigLIjVcvzITJ7UDRpxpgG8ate+2ldcYSZpVhBiZtl+4McOQY3XHdc+IpWMdpO9JrItm/A0e5OQoDnmUP8vTe88QU6U2hF0vtLGGETbb8MdTi4csoTcCJn2j++ApHzZRbNFmsJ3nxxROoByOm949e6g5wBo2XJovGoHnPLLK4JZ3z3ZMklhO6bq1jXhvWe8798XtfLFQDifjzztmPJ0oHuTO4CT3y3l4DRPMMfBDQKp9l1sG8IKxuHOYzPiRZviRAKfz7iPT9BUutKOT434j79oit4Evp+hFtA6wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Qz6zFmPKuwpRr0NFQxzwCtIIplxCvRNOXnLjXpFFY0=;
 b=PQYVFpPQ7aG6jUS0uyE/vN4896AJvk3gWQ28L3NMKA7OuOBboiNUdystVOaqPcTnDCBWF0Yej/UUPy7NMV8Hn0TR7piv7QY66pUSwIr6gXgjL608Mk/QRdZCJK7vHhfIubCMRNUMGm2k4Me+Gsq+hvH5y2Y/qqUT5LAU1GRzLd2ZVDrJsUqhtEIIAOxnR8RSN1+Fx8t03c/ylDFKRMxLKlWrNnnMOKVXAlXOZ45vi9yEjjwEnlH5Ow/7ToWcnJfAV34mO/3GwFFiPRyuNJq/iHTYKo/VC6KjZiFAxJ+QeNud+CYSlEN2tief6E3V+nOpsJrUm0dDZ9lIS+tbrNIinw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Qz6zFmPKuwpRr0NFQxzwCtIIplxCvRNOXnLjXpFFY0=;
 b=Z0y/6zb93AfLN7695Uf5VRj/9wyuEF+NLUb4i6kwWOKNnk39ioSrSKLMGC4nEply1IA63MT761fUJ4T5o+v+7Dqe/JFao5UnQYhInD1llMhavJt9RNmoL4pvGXX+6edwHl4vWrFBMFuHDA4WXQKgxsZu0mRvywJUTl/q4K6r30Jjk6HHgxVbe/z5EIwl+CjSHMU+dNCXb7w3jIOgJIhQw89iHqZZia0GdWfURpvJxIyv6SHgvBMjshhty5aMiqsjuvwm5MI2hoxH77L0ZcARMUOpDpkH7Tb5OyQjUlljBsT+7xxb9ESxV9285rw6DD62mQAZepzfYvCnKYfzV8l45g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB6768.namprd12.prod.outlook.com (2603:10b6:806:268::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Fri, 7 Apr
 2023 04:46:26 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6254.035; Fri, 7 Apr 2023
 04:46:26 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alan Adamson <alan.adamson@oracle.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [RFC v4 0/1] nvme: add passthrough admin error logging opt-in
Thread-Topic: [RFC v4 0/1] nvme: add passthrough admin error logging opt-in
Thread-Index: AQHZaNKwtUwwCkLyBkS3uVYgYn0sjq8fRiwA
Date: Fri, 7 Apr 2023 04:46:26 +0000
Message-ID: <d82c9419-9899-0814-2542-8fda858340af@nvidia.com>
References: <20230406215544.113127-1-alan.adamson@oracle.com>
In-Reply-To: <20230406215544.113127-1-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB6768:EE_
x-ms-office365-filtering-correlation-id: ae356fd6-4c77-4321-1a3d-08db37230bfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  s8poFT1PabJ7Fpk6Obm2hZJrdP98vBr+NWVZgmq05MgSPjg7A1h7K92l0/FXJPIgvQMOFftA2PA7o0+wIvuHWG34Gor3UiyhmC492ox5g2p97gx54Pq2aI1LbY5mpVRO+wN8MSdMOml9PCDYMXjzeyQqUpZglZzb/HFnvm1T0jyEEMe3FHa6qSo9YGshwns8MyK+t36yW9O3/w6LumhoYp3fNHwCOp0S+FLaMYviVUvb9Q5G8Lf1W0c1Ynj18G5TmT40/v5lv9DZNflck/bclACR0PSni49vTTXqJZ38mcn9V7vR4fr2gVG4jqDx3f8TzRybtvA8RJZqEu2erI0e3KKuvnf6GEdqmOIDjqWthfBLhAE84+W2gxo2Azi7weV+HjOEEgmFCE57EBQCrBK/OOKEGSyG/IQMDLBeGNC3aa//ofsPyjRcEv9F8h4CY+MyHxujBnAEWJxl2/jwr4Wikhj9elG/qnCWNlVjaO2uvpqjWS87PF79Lm1mwYCYjz174d686FvOGs9nyeCYXxAX4nXMD5BDLnoYf30pm9RE/C+w5V1FjUFLPWuxPj3j6F7SRhPzahMz3Vy+IEZlPFBFeqGQZ24IN+iWKt+gPC+saGFPzkVHWFkrtok8T50HhGGYxBW2hhGpMiPCDITouB1+J36F30e9arKgKRwxmxLqgWyzoHkHxLGKB0w+F5GdTN8f
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(186003)(6512007)(53546011)(6506007)(31686004)(110136005)(54906003)(478600001)(91956017)(71200400001)(36756003)(76116006)(86362001)(122000001)(66476007)(66446008)(83380400001)(8676002)(31696002)(66556008)(41300700001)(316002)(66946007)(2906002)(4326008)(5660300002)(6486002)(38100700002)(8936002)(64756008)(38070700005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?c0VBV2RVQjJFRlZPYlJLdkF5UEM2dFJQL2Y1RmgwUkpQZE44N1ZXZUxpSkdU?=
 =?utf-8?B?UkxlQUR0SzdzdEdIYjlSRWN5SzdsZUdGWkFwSmpqK2VPdFRtaGVOcVRhRE1Z?=
 =?utf-8?B?SklwNTcvK1NjWjlTN2I2b1dBd1I0MDR1ZDZEUWlKTW5yZ09HZGlIR1h2anc1?=
 =?utf-8?B?cW1KT2R0MjkzRkt4QWwzZkNDaE1DS25sK0JBSkYyS1d2S1BaRVgrSnhzd0lH?=
 =?utf-8?B?SG4yY1grV2tnZDF0OTRTbkNNOVFBS3JSNGpYYXRtdzV0c1ZDREc5aFBJei9M?=
 =?utf-8?B?UVg5cm01cDlGaU5hV0h1M0o2QmM3OWdUOWx5OXFTWWtWZFFOMWFla0hMUEor?=
 =?utf-8?B?VmN1elpJdEpUTDgxaDJTTDI2cVpMWTNGalVYa3pIT0pPSkh1ejJMVzVLN2Iz?=
 =?utf-8?B?dCtDdW9VYjA5SkxyRHZtTzVJYlh4NjNucnJNUjd0ZCtGRExlcHFjVTJ0eGtl?=
 =?utf-8?B?cE5aQTdycjJjTTFtWWUvaEFpOUdrK2k5L0dOM1ZZL0FJWXo4alNuckxwODMw?=
 =?utf-8?B?Z0wxUXRXTkt5ZEJhVzhWSVN5RDJsN25PbWZQVFk5YytYeW5nRUpuQWFPWWlt?=
 =?utf-8?B?ZDFub1RFbE11eWo5ZnFuR01DcVJmS01rYzlsQm5xbk1aNzRNWHdtQ0ZUZmdW?=
 =?utf-8?B?aHdGV2loamFCeXRNaDhpSXNTNlhQQzdydDRxOCt1SGlUOE5XVWJaSzJaSjI5?=
 =?utf-8?B?OFhoT3BxRW11UVk2SXNWM0dqREtEQUlvclhtZHIxekNoSHc1aUlGT0swWUJv?=
 =?utf-8?B?SzU5cnNSeVJkS1dUOXNOWVM1ejhZVTNtWGNXWTMrUXBkTXlZUm5FbWlUbXBo?=
 =?utf-8?B?QXczL1lEVHBkalowamlDT1NkQzdCQk1IenJpbVY2Vysyd01vRk9wbHI4aWl4?=
 =?utf-8?B?czBIcWUrd0lTNHVQVVRFVDkyL05adExKWU4rQzJMN3pYc1NFdUNta1FTR0hS?=
 =?utf-8?B?eUJCc2o3eDFRQzA5WmFrNHdJWW9nS2NvN1NNVzk4TEF1WnpYcW9kcnY5Yy81?=
 =?utf-8?B?Y0FyWVRncklPUHBHL01TT0xoNXg3dG9LTkVKeGhCYy85eDFQVXVtN2RiU01m?=
 =?utf-8?B?R3piL3BiYUhKeGlJa2hPSnV1MjBTQjZDQlN2UHp1YTNiL0c5UTlSM3ZBbEdQ?=
 =?utf-8?B?c0VuN3J2M3NibmdLUnl6dGw3WTF4S0xrSjRzS2RUeTZ5T1MvOEl4KzdCc2dR?=
 =?utf-8?B?QkxqSHhGYlU1cFMvWGpaaGpEbktRc0ptR3BsMnRHVE5zd3N5R2gxSHEwR2dC?=
 =?utf-8?B?QndEa0syNmRiK2tzakRGMkVCWGdBVDRCUU9PeE9jdnJiZGNRbi82enF0bTRy?=
 =?utf-8?B?akNEN2NveWRkVzdqdW85QXRsZlRrQmN6K1dHRTRDY2NKeUxsK2UxakJMYzZz?=
 =?utf-8?B?aFAzbk1kRWZNRnF0NDFHdWx0NlpoYjVRb0RXSGRZZ2NMQ2dIckIyYWRoOXo0?=
 =?utf-8?B?dGR0WUR0VjdSMmE1NDJKaTljNXZ3TkdEZGlTNHlZSVg3ai84V21LZlZQSkhW?=
 =?utf-8?B?VENJTm9qWEp2VFYvc1h0WFpqL0F2OWU0VjRZdW9HZGh1TjZISEVLSmtMQmVo?=
 =?utf-8?B?UzEzYjZLVWpnbTRyRlVFUFFGcXpRRDk1dmF0V3IrRFhuWnZwOWJJbXJXUDA1?=
 =?utf-8?B?Titwc0Zubmt5RUZsMWtYaXEzOG1OV0w3TG9HQWVzUjltL2JyalZQSGlJNzdQ?=
 =?utf-8?B?Nms5MHBUMjVxcFFWdGNscmhHSmVXOGU5MC9oeDhvZEdSNnBiMGxBRG1HVlVY?=
 =?utf-8?B?bTZVVGM4MmFJaldEVytpRjgwK0tPUW5PVHVFTTQ5Z1VGL2ZmREEwYnh4dVVI?=
 =?utf-8?B?VDBsZXlqQTlkL3JENlZjUHYxQXRQRVBQY1pvZkxZODRyaXRzMWpWaldZL3Jm?=
 =?utf-8?B?NW0vRVYxVUxqNnRVOUhyOHpHYkFoTmNrRGF3RHFMVC9yWjdPelBoN01rRTZz?=
 =?utf-8?B?SVFTVHdxeE12dGhqdUFZZTBOdXUyMC9VbmpQbFh0RHhWc2lTTUxQNlB2bjl2?=
 =?utf-8?B?RkxJNnFRYytOTXFIaUNqbVRmOFIxWHpvcnJhaWxsR0FxZjMvdEVTVVJ4dVNm?=
 =?utf-8?B?d3dwRlRnNEtnNG5nZTNuMlVuancvMlhEVmttZ0RPVDFCektwbUpFd0I3U1dD?=
 =?utf-8?B?Zjl3bFBzbVNpWUcxZE1qenRQSzc2OGlZelNDNW14UWl1TUdkeG5sYVBIOUtk?=
 =?utf-8?Q?/fCc7wUYwmxrh7Swc/nTbKjnpk1stCXevDoi9ieScFPp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68241FC267D11C438B77D8FEDB2C2C7F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae356fd6-4c77-4321-1a3d-08db37230bfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 04:46:26.7235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wMvzSWCIhZz/yp58opi+3sw8XLTk1pzotiV2xyJmjOac57e5MR80NJ783ntciw6+EfX2b8HVPFAAW2iTpt5SHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6768
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230406_214630_309045_4492991C 
X-CRM114-Status: GOOD (  13.69  )
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

T24gNC82LzIzIDE0OjU1LCBBbGFuIEFkYW1zb24gd3JvdGU6DQo+IHY0Og0KPiAtIENoYW5nZSBz
eXNmcyBhdHRyaWJ1dGUgdG8gcGFzc3RocnVfYWRtaW5fZXJyX2xvZ2dpbmcNCj4gLSBPbmx5IGxv
ZyBwYXNzdGhyb3VnaCBhZG1pbiBjb21tYW5kcy4gIElPIHBhc3N0aHJvdWdoIGNvbW1hbmRzIHdp
bGwgYWx3YXlzIGJlIGxvZ2dlZC4NCj4NCj4gdjM6DQo+IC0gTG9nIGEgcGFzc3Rocm91Z2ggc3Bl
Y2lmaWMgbWVzc2FnZSB0aGF0IGR1bXBzIENEVyogY29udGVudHMuDQo+IC0gRW5hYmxlL2Rpc2Fi
bGUgdmlzIHN5c2ZzIHJhdGhlciB0aGFuIGRlYnVnZnMuDQo+DQo+IHYyOg0KPiAtIEluY2x1ZGVk
IFBhbmthaiBSYWdoYXYncyBwYXRjaCAnbnZtZTogaWdub3JlIHN0YXJ0aW5nIHNlY3RvciB3aGls
ZSBlcnJvciBsb2dnaW5nIGZvciBwYXNzdGhyb3VnaCByZXF1ZXN0cycNCj4gICAgd2l0aCBhIGNv
dXBsZSBjaGFuZ2VzLg0KPiAtIE1vdmVkIGVycm9yX2xvZ2dpbmcgZmxhZyB0byBudm1lX2N0cmwg
c3RydWN0dXJlDQo+IC0gVGhlIGVudGlyZSBudm1lLWRlYnVnZnMuYyBkb2VzIG5vdCBuZWVkIHRv
IGJlIGd1YXJkZWQgYnkgI2lmZGVmIENPTkZJR19GQVVMVF9JTkpFQ1RJT05fREVCVUdfRlMuDQo+
IC0gVXNlIElTX0VOQUJMRUQoKENPTkZJR19OVk1FX0VSUk9SX0xPR0dJTkdfREVCVUdfRlMpKSB0
byBkZXRlcm1pbmUgaWYgZXJyb3IgbG9nZ2luZyBzaG91bGQgYmUNCj4gICAgaW5pdGlhbGl6ZWQu
DQo+IC0gVmFyaW91cyBvdGhlciBuaXRzLg0KPg0KPiBBbGFuIEFkYW1zb24gKDEpOg0KPiAgICBu
dm1lOiBhZGQgcGFzc3Rocm91Z2ggYWRtaW4gZXJyb3IgbG9nZ2luZyBvcHQtaW4NCj4NCj4gICBk
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMgfCA5NyArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tDQo+ICAgZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oIHwgIDEgKw0KPiAgIDIg
ZmlsZXMgY2hhbmdlZCwgOTMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4NCg0KSSB0
aGluayBpdCBpcyBzYWZlIHRvIGRyb3AgUkZDIGZvciBWNSA6KS4NCg0KLWNrDQoNCg0K

