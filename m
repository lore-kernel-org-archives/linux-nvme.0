Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CCAC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 04:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FlRs6P1fH3UJ19Ef/yhjGPeb6PXCLBepw2ziUq0HTrY=; b=1n7ErdI12AtRlLSGpD0vOH+rYp
	9cXLBXDzqnIN9O6jagkvr6bIm+pCekha0LeceQXd55aMp1pH55CgiD3thfrZ+/1Z2DN284tzFqKuB
	xh1loRqrZq1jIWElYYJawe5sgpQZIkBStp4IHxLCbPgpH3wLFdAGpcRn39SfmZr9g1TZF9/WRSurK
	IUSMEFspqrEnoJQGPKdtDA7gM52jqqdTb0aca5pWO08YQZ7yGgFOkeKe2+833h7sTTqmyxtgX7zP5
	AbxXDEu9NGV5keRm0EmQz4Jt2GCnXCQhXjiOVN5sdGGdWGfgBKyAr1k86QL22k3e5Rz+3cKRbhRAU
	s3HPpVrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ounKi-007YRJ-59; Tue, 15 Nov 2022 04:14:00 +0000
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eae::600] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ounKf-007YQT-VZ
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 04:13:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKXx7FTBoFvUn8qSGVdyGXrsBcNbUnGnlm67thbUAxTtj9TLTiwMS2N9Os7reNDWio0ta6HTfx/ZjDNQHs1pBYd2NDPafPl5iPxUOaDBStaV03FFD9TkcIi/WOm7dLL0F1JerNpy4xiHhdnWhxgr1d3itNDoZjb7LRb3fgqqW7Pj4e4tQnj4kSw9LGP6vFNtY98A8R1BHOfwcEt/uAS6DTmHwyxJZ78zGAoD+cQxWIFX6iksbsQCRO9cSdW37D1ckT4AxdfCwuOpk2fDgWJto7ydBK+AzCfv42HlxfrnlBAAL5DJ6/rNextaLJHticjNnB1I6xERqOKjRRzUHkPvtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlRs6P1fH3UJ19Ef/yhjGPeb6PXCLBepw2ziUq0HTrY=;
 b=dpFpF7cQx2TIO+OJOcQLmfQP6QDJwBY8bgXpeMMfs+9/wjHvPdbAsi/64vc6B87zPWx4DrjSDsktJDGhhIcBdBskxKFcW1LYpwCkhcUlwKd+ADI5DMERjrG58GN5GLad0MiqyJ85AugzrexKgzfGSss5OBCYbJnCZiKGtuY0MURiNoOgwf4bsTmhivqFYnp1q2focSQixau2VT4RulwFJvTA01YUsKG9GtS6fzT2pPY4c4brdxotO5mMAHPUXQJP06QipaidctrCfrZfXkmLhW4Sp3RDT+xyNyuaprBU3TVyYLfFREurIW62ulhsOKu9SK4PRB6quYIDWbYcQfenHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlRs6P1fH3UJ19Ef/yhjGPeb6PXCLBepw2ziUq0HTrY=;
 b=dD0Nhtmkg/I9dopT7dvt9ILc0xQazt0Bm+Qw/lJuyR3im9KTIk5TQNaks89ipKEwJSfHdhU1XpHsJQm1WHzOvdT6fOGgWifsztk8b0gwIOolHINIQ5d+iwqCK2xlKUFLETwda3+ro4Ooa8NMXU5nTLC9Ga+QbqQvdgGNtacjjUfZkp8LMQQOwoaJOiwSWQ3lxjNnj6SyJIS8MLhufO0NFp7xxjHbavjxcJ01Wb8GaBqQyhqjJ75xzTZVPPwTsQOEsG2yiC4rlldjqnZhF0R2pNkCNHuEZ1bgltBAsN8CpXmYGN6CXC6qJVeVtRn3LBg5vdjiAVgIpHFyQodzLevnjg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 04:13:56 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 04:13:56 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 14/20] nvme-auth: check chap ctrl_key once constructed
Thread-Topic: [PATCH v2 14/20] nvme-auth: check chap ctrl_key once constructed
Thread-Index: AQHY91NgBR8AU9uY20eZH7y0lFSO7q4/YrOA
Date: Tue, 15 Nov 2022 04:13:56 +0000
Message-ID: <60e300ae-7810-ff97-33aa-c53700d295d6@nvidia.com>
References: <20221113112424.1049834-1-sagi@grimberg.me>
 <20221113112424.1049834-15-sagi@grimberg.me>
In-Reply-To: <20221113112424.1049834-15-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB5997:EE_
x-ms-office365-filtering-correlation-id: 9192739d-aa18-44cc-ef27-08dac6bfd053
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  D0rtPP0KeQeFDzAk0uG9yyn/s+e8CoCW9GBFgm9ShExl68tKch9cP8WybIm7eGs2owVdVDlVaGVpk8nQVzp0Ejktiwo548vqLCOSr+FdBo3smzDXrArd2jovSy52K/rYZ/yCKWT+uJFkF0PgORXJ/vAQMdjT/tzp3UXY9ox/338pD+gZtU8ZQOIXnolz6XobqZQ1DR22XVb3JTRkpp6kWMaJ2yiLZutFBJKaUOncfh1/9/QxkvOJqtIumUaHAD4ZqBVq3IMXnYmq+0/iDcmoDotqxVhrqNZTlB+v0ZoDLfSt2NwNpCFrYPXzotJjDZ/kqjUKIPSHpCjBMM4U/f3m6u+greadNINrHjpC/MfTG+E5BCBtQ91Nb/0mzI+m2FPQCByOtZ9LS0+NnvvzlazrujCFp28FJOuRwn60XGuqnlCgV/jvKnRhXoYt5rxWYCfKfdE5s2Qlo/+aIg2QLnZvonYNke3UVINGtgJJIHs5R6OQ/WlGY5nQy8sfLGf7uF88uFmVGCATWoYsHUDOuzX82LfKsxSIDjqQDmSsKUq6rG765Sj6wap/dMYrrbteMLNuyiR6FJ90dzDnth2+xF9GMTgpzi/kR1+jDr7o7cgXtIds0wf/5giRwcdWSkAgNw1Dqrd+O1QWjDAh5WDlcWkiVB+leg2Fks/BLM6ir7hL0SzbXQ9/1Xo+0FzC5VG+YE11SGFQPDjPU7OF1crOS57OctNc220OtlMRSc25K17cB7QH8LOa6iN3+20fjhNNWefFhRYRiEtcid3UwkQGpb+fKBh/3pWxrma5TmTij2xywAHptfvP+MKEQDx9Z/ybkdCidoyw6HLUwdUxzwnVq3mZUw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199015)(36756003)(186003)(2906002)(38100700002)(2616005)(5660300002)(31696002)(122000001)(8936002)(4744005)(6512007)(41300700001)(86362001)(71200400001)(478600001)(53546011)(38070700005)(31686004)(6486002)(91956017)(110136005)(76116006)(4326008)(316002)(66476007)(6506007)(64756008)(66556008)(66946007)(66446008)(8676002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?MWhpVGJZakpqUU1LUWdVV1ZsMG9xdHVYUjZrbThmMzFWVTdxUGVVQTN3Tm1r?=
 =?utf-8?B?TWVxTWRBaHI0WDRqblRnSDhYNEZUcytUeFZuSFgwZHZ2VWpyejZXZHRrUG53?=
 =?utf-8?B?VnpqUE1LQllNTFVaZ2VidEdXNms4bmNvRG5EN3B6Mnc5elRvaDBnOE1sZllX?=
 =?utf-8?B?WGJUaWtkR2NzRmc3dnVTejQvY3ZCZDl3YVBpWGVKM2doM3ljSWcwbVRRUkYx?=
 =?utf-8?B?bFpvL3RRRnZrYVN1emFrbzRTSU9aZkY1WHhOVEZFT1NHM0MzRzhsQ3haMzhn?=
 =?utf-8?B?SG42c2Nzc3RReXNuT2ZMOVZPN2ZkT01KMHpOM0ZnZDNUMVdKWmN2TmczNkdF?=
 =?utf-8?B?RGEwUzdyT3BhSWxTNEtxUE9ncFREL2xJNzM5V2MyWElocnYvY0o4Y3NPblI2?=
 =?utf-8?B?MUVadDJSUFFyQkRsNkZISVZEb1VIQ2I5RFg0WG8yVTBjT1JOWi9iOUczeGhN?=
 =?utf-8?B?NjQxWm1zWGxZOGhFYnBXVTUzMnIvT3phVnN3ZzhoenFFbmhqeGVQVU5vemtv?=
 =?utf-8?B?czY3ZnhPR0Fhb0JXall5RVVhR0QyMHIxSzQxWnhubVQzSXFVYXhKUTVCaTAy?=
 =?utf-8?B?ajIzOWd4c0ZBT2dzM2hiT2U3UTlYbVlJNzJMWmtmbFBBd1dNZTd3WWw2dUkw?=
 =?utf-8?B?cnpDYUtnUDdnVmtveW1DTnFzV1ZnYkl1SWh6cEhhanBHUGtrT012ZGw4cHF3?=
 =?utf-8?B?eVRkV2VJcjBxWHN1ZXpGSENjV3o2NXZzSzNMOCt4MDRnd25HNnJDRG91V3By?=
 =?utf-8?B?UVh0Zm0rUWxXUGRlS3dKNWxUSncrbjFDczJpaHNRVnEzMXJ2ZFVmczlUYmpR?=
 =?utf-8?B?M2h2cnNJN3oySFdqTEt4MEVsckQxSjFkUkdhUEEwRE14TzRsY0xPY1M3c0J1?=
 =?utf-8?B?MjhlVkZtY3BMRmpkYmlUNHZyYTNTd0Q4bkZUeTVra2VEamhOWGVZV3VKbFFh?=
 =?utf-8?B?c1g2eXF5VGs2VU9LQU5IOXArbHJXSGR0VkRlS05PN1U2b0pxZ3Avc29sNVN4?=
 =?utf-8?B?RysyVTNjbkVGcnpPOUt5d3pMN3BXQzVmSXNSSnFHWFdnK3hqZmovVXVSQ0tC?=
 =?utf-8?B?cGFZeDJNaFpIeGlNQVhGUkdIQ3oySElaWDlFMnNPSERlWCs3UUJxLzI0ZXZM?=
 =?utf-8?B?c3A1eS9UN21KVnlDbTJTT1lQdUlvYkdkcm5pcWpPZmxGcUJiYWpHYjJWUXJi?=
 =?utf-8?B?MWd6Tld4Vm0raW1nZG1qQkJ3MnhzTGNuL3pIR09VanNKa2VTTEs4ZzVrQTJQ?=
 =?utf-8?B?YjFGdXZaT2FQYjZkV29HRk5teHArWFdWSlVrQmRNVlJ6Vm01aGNJSFdsWmxn?=
 =?utf-8?B?WlhiNU1YeHhTSEtYT2Y2M2tZZ0VxUEE3SlFHMHdUSTV5dGpia3NWSWR2b2Vs?=
 =?utf-8?B?UDNRbnl1bGZWYkN3bjhXejRuckcwQmV3dkpWVnVxVFRWVEs5Q1ZaNGJHck80?=
 =?utf-8?B?S1JydGU1aGNDZFUvdG96Nys2dGNtRis3M0NoamtYMkdzNVJYeDMzd2ZkSDVG?=
 =?utf-8?B?b1ZnK1drRm5aMVpYcUx3NWR6anZpWE9hL0s3QXVWSDJaeDNoMXA5dUdWclFz?=
 =?utf-8?B?RjdZQXpOa2h2UDgrMEx3NCsvdHFWNytrck5oODVtVm1YR2NNczdhdjI4amJE?=
 =?utf-8?B?emEwUHhXUlJkL25VVlFBUnArWlhGU2xxY1FNSnBMT0VPajUwZXpiWXRuU1lx?=
 =?utf-8?B?cGRMZEYxeVpwOXlIUzRkK3JCb0VpeUsvRjZRZ25IOXFCOC9CUFhTYTFnS3l3?=
 =?utf-8?B?RjhFY1Q4eVd1WTBqb2RISHc1SXBvNUJmZ0hqVm0yQTArbWZLcXlrWFhzQys0?=
 =?utf-8?B?UURPSVZYMVU2dDRJZ3NKUDdZM2V5Z0xYYXRaSWN0WXJaUnRSNHE5SUdoNkVN?=
 =?utf-8?B?eTdXM3N6WTFCSmt3a2VlOXQwZlE0WFd2WXZPUDk0eUpFL3lja3hYWVJOdElz?=
 =?utf-8?B?eTRzTW5TVitqRXl1eUVXaExhZmJOVmxzU2UvdnhyZ2dmUGwzTFlvMGRMdDUw?=
 =?utf-8?B?b3h1L0tGc3RqaExnRnYrLzRPdzR3b0xNQ3ROeTROdjZaYTAwU2I1cDdCQi8x?=
 =?utf-8?B?Ym5XN3FaMktHRnBvZXl2RGZsaFA3S250a2hPam5SemJ0by9JL3RZTk9Icktn?=
 =?utf-8?B?WEx3TWRYVUNPdkthN0FiYnd4U0JVRzdtS0YweVVPSDlBZ2RleFU3UTkvQnIy?=
 =?utf-8?Q?hB7s/Rmzf6npS4WVzwjrD4GzI6t/EqjhmfQenmyRI0r4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB45D36472841246A10FA25C27EFF90A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9192739d-aa18-44cc-ef27-08dac6bfd053
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 04:13:56.2092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YxyoFC3G0NCl+yUDJb43zIXlzd5JmyfJyzUUQ4YCHDOIVuOvBdtbL4Z1eV8VJigszx6e/B2iR1U60CFwU8X/ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5997
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_201358_038291_3CE4B741 
X-CRM114-Status: GOOD (  10.15  )
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

T24gMTEvMTMvMjIgMDM6MjQsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IGN0cmwgY3RybF9rZXkg
bWVtYmVyIG1heSBiZSBvdmVyd3JpdHRlbiBmcm9tIGEgc3lzZnMgY29udGV4dCBkcml2ZW4NCj4g
YnkgdGhlIHVzZXIuIE9uY2UgYSBxdWV1ZSBsb2NhbCBjb3B5IHdhcyBjcmVhdGVkLCB1c2UgdGhh
dCBpbnN0ZWFkDQo+IHRvIG1pbmltaXplIGNoZWNrcyBvbiBhIHNoYXJlZCByZXNvdXJjZS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+DQo+IC0t
LQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hA
bnZpZGlhLmNvbT4NCg0KLWNrDQoNCg==

