Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A95C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 01:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PeSq/WGXrpEMRGsJY5ihFC/QufaSUrbLOMtsmY7Hocs=; b=b9uyZe2LgUYvmo72WrKobrakK9
	9rK7zEeTJ8xNKHJvN6XG06XgUUTfZRmlAz5pcXG9v+dpAxJuqv4STI2d22qFVgV729NJD5QKfy0HI
	n1g7C+a2FGUjvIsrzjrhHsCOLsQCumOr0oi0TfzcahXNiaaZ60WE5ri/nPCoRsBGPHgZOL2bLMZlC
	hTI52XiktIsEis3gNzXl8X+c10e7g8v+5ozJxtNUwEjMkoLUygE36jO38CrI639xf+7k2SGAG8tXo
	/XvriA24Uz6x+RnRSsRwz8k62DgZvZs8L1VaHd7vZKbu1G1awPUCrZnoipWOqzMIHMB0DNjemBKjg
	eqpcK5pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nS7wm-00B0wz-7l; Thu, 10 Mar 2022 01:50:32 +0000
Received: from mail-dm6nam10on2060f.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::60f]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nS7wj-00B0wP-1P
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 01:50:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+vVHFI+CU4SucmSAeAWWpdXTFGhJmgDpalUaYsW/QUYtmgFTUlMWVOsfWYNQMa+tRS1q9U11F3I2RXrv1MMJXCGhISDoZb89rZd/V3sVjcUA2UI98DSWPbRvOHh+pBcM3inD1ju82cr8/pEbMgD70/omayshdF/HH9CbqSLz8M5uw5Qy8zPgsA+mAHjWtgC9RzOutK+y4f8jzTQ+B31/EjZhKd48LCjLJJFNWGrp+r+JT9zY4vv84L7Cp+o9Qzrh0XTm96rFs34GFRFTKYCMnYItfqCMFTwBSJ3v18eJhI/k9Fnx5+aEWIzDWBIljmuCRqyeNvXshGpY7niOsmnOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeSq/WGXrpEMRGsJY5ihFC/QufaSUrbLOMtsmY7Hocs=;
 b=hPuot7Pfr0TeCrgLagsXrEmcns0A+njaK1a+nkfBvQc1X27Dvtk+/FIjlCdJAZbFgHgt4P7LItiHvBW+L8YM7N3hrK3pxnQk6COXnc5Xdus2WRE6bv2EL+aVLsyPoHbSIjDPtMzCRa6S6sG4dLvgDZT4IYCt2lISXInnJuGyAHpYvv1zJEoBpKHrTjm4/+5bQUvFPmHTRHIt/BtdGJR1FJi0Glm2tzz8Vai99Ys4tbz/f6jo4UYlrK0coPG5EBXTsrN/cRISthkgIKn88whLrX29zcwd4sbNAGLE5rYHVqbVAaCLX3ByVYKufCKh97TRIhNLU6uLXIAdgh2OQr6T8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeSq/WGXrpEMRGsJY5ihFC/QufaSUrbLOMtsmY7Hocs=;
 b=EEau91mj6VPMs/8CEltOy4NAdSDBkreDdkz8SRfVBbGbeV//j7SlW+5c4KPYiI1VeUWhtvrV1NcMjuIe8h73iKHd7ncvWAInozd7h3wsRRkyB78FDcmJHAxPl5WfTb9lZ7tX5/X1xCESXDroy1DdW8bWHNGoC3+KDjdQFPcioMziAQTLHBH20G6NztwqEVj3W+ttANCgWMmS7UL/NgrGap0n54INpf6g9f6l42fptC7xwgUnaEPpxFLUksXprrnU58iddQlFXK0T8bIgdUGTuDQ+ZcJHq3Cw7ceF5CwuQx5C1qhT5wJnMjrt1UYzBcVmR1G+2bYvuRuyt9Yx0+8C/A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM8PR12MB5415.namprd12.prod.outlook.com (2603:10b6:8:25::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.17; Thu, 10 Mar 2022 01:50:24 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5061.021; Thu, 10 Mar 2022
 01:50:24 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Niels Dossche <dossche.niels@gmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Bart Van Assche
 <bvanassche@acm.org>
Subject: Re: [PATCH v2] nvmet: add missing locks around nvmet_ns_revalidate
Thread-Topic: [PATCH v2] nvmet: add missing locks around nvmet_ns_revalidate
Thread-Index: AQHYNB23TMD+jp7p10mYx1gLRsAvIay32i8A
Date: Thu, 10 Mar 2022 01:50:24 +0000
Message-ID: <645919de-7878-55e6-aeaf-abe67cbd58dc@nvidia.com>
References: <20220310012511.82536-1-dossche.niels@gmail.com>
In-Reply-To: <20220310012511.82536-1-dossche.niels@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f286966e-6d2a-4fe4-ea68-08da0238581a
x-ms-traffictypediagnostic: DM8PR12MB5415:EE_
x-microsoft-antispam-prvs: <DM8PR12MB541592160804BF8DD33F9E3BA30B9@DM8PR12MB5415.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FdWuiTszX8Le+hIbF2KCQDCYEBncAmwEi+JTDC6NicnFrTFMf06x3YlcUMqByaWyVLAFLORP/WX3dtpCJ3Hx7ZcfLiDwsyTYd0RURkuJZElLlLHoV7YWb6jIqqp2YPZ8Ra1aDbBBiT9Y1lB919d5Zyf1uQzs736DnrHrbIoe7K8fSRUfHsjRLMRBSMnBGiuB8JRapToc+QcVQgttvToGDe8MXr5TsXKNXQT/HXI8lLCfdWQyL45Ybh4TID2JxT/ZSv2HFeXdCIMO1aMhc3OjGIjX0ZsMbfdIDWqAOvGMDJNcmNA2Ew64JThsjDm7b1QShP21sBnEHjKCHZgMVRinsi/H99Kku41fpRIeWoI3v5VQMTQnd6r9tc3YfcH6rXWvG+Jv1o4rjgFpEf08QjrgWK87EvP1jb5zcfvQ/9Sq9dFLkoQ3gPNzrZkEL8qopFniUthGWlX/PSCJhYr+W/dET7h3FMJO3UK6DVK31mxdntogCblM43i7hECP+W5PHg7Tuo05oKnr9KaRRjlQRY1YJOg3P6H40qz3obVXAcn5q2Z36Ncjy+LwKgCYe7NOgtWryqGSk+jWljvWmjffcpRSfGYaFKcex3GwTmJvG6LRoRY+olqgQR/tB0f/esdMoIZA9stM3MJFQT7ZR+2Zovs+kezMRltHR/4U+pXSVIphWiWl48IRFl1C6AuwjzP6umftH1HvRkSc1S18C4sR3yeYD2pg90liVeCxdm10HTSr+W+55pANoBw45lDIfNYO/uRjfQoG0O7w+mLZFyJADL0R4Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(66946007)(6512007)(6486002)(38100700002)(122000001)(2616005)(186003)(53546011)(4744005)(6506007)(5660300002)(2906002)(71200400001)(8936002)(508600001)(66476007)(66556008)(66446008)(31686004)(76116006)(64756008)(91956017)(38070700005)(54906003)(36756003)(4326008)(110136005)(86362001)(31696002)(316002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUFHa2tJYlhjYnhnWC9GM0pEbHhVM3BhSjJsbUgvYnF3WjAra2J4YlB6TE5F?=
 =?utf-8?B?WUJ5WjUzaEZLV2V4eVZWNmcyOWNycDBmdk1WdER6OVdnRXBJMGt0dmw3WmxS?=
 =?utf-8?B?MUw5VlJQc3hDRyttVmVDcTlHTlFMZFNYRk96K0NGekp2NlBOc01xblZHdjdN?=
 =?utf-8?B?S0xrUFA4UlFncEk5R3J5NHFLRWJGQzhOd3FVZDFJdDBGZTN2aEZpUlNoUUNo?=
 =?utf-8?B?NzZLbnAybHFZc3RuOFE4K2hTTzBGYTVOVVI0NjJzL2IrNnMzQ3F6d2tabjBm?=
 =?utf-8?B?dmVtcGEwSzlCOUdPVTRKNWY3NW5icjB4N3NkT0FVYVVzb0dKU3dWNHY2RUM5?=
 =?utf-8?B?QmNZZWNISDdJaE5mdXZqcHBia3VWL2ZNeHFQaDRlaHJlTzVleHozVmtzNFZJ?=
 =?utf-8?B?dHlnSHBwZGVEdG1PK1NicHRmbE9wL1U1QTlzWWR6VWV2S1ZrREtlQkVYMktG?=
 =?utf-8?B?bGVwUnB4Z2RFOXJOR2piNXZNTkoyeU1FVXVTZys1ZGtkMEl0V05kaHF2S0do?=
 =?utf-8?B?Ukg2QUFBR0VhWHYveWJabk9tOGN6Y21sNXFCeVNqNlB2RTRqU2hlTTRnQjlG?=
 =?utf-8?B?STRRZURVbGJaSW55cVJGb1l0L1Z3RW9nU3dKSGE0L09IZTZqSnhBeGFkS1ZX?=
 =?utf-8?B?MUVqOWFvV3hZWjVpa2ExcFVZRm41dXZOVERnYTlHUFNRRXZ4VzlqYlpZTGdG?=
 =?utf-8?B?dVpFbk1pUDBDbnFHbDNGVWkwL1MvNzM1blBneHl0SWhTOFRpbUNzNmw2a3VO?=
 =?utf-8?B?dXhRR1BZNmtYWTluSW9WN0p3YWIrTFRnVnNQS0U4Q2d0d0tiaVZkcFY5QkxG?=
 =?utf-8?B?SlhRSEJrNUlveEI3T0JndXRIUjRGeXVqMlBkZ0liUnZvUCtyaytuQzV5eDdN?=
 =?utf-8?B?MDQ2YnJhSEFGemkrZno1UElxWStOK0dWdUJWZnBIQTNpVkNUZ1hyZ3JUN3p3?=
 =?utf-8?B?OGVwMHRybndHbTlQVE5hb09QVjdRNUhteDNMWGNnOWF3TEFzTDYyVkRoTGlI?=
 =?utf-8?B?YjhtaCtPbG1DNll4K29NL1pjUFUwM25OY3RuVTMzVFRBcVBzQU82Z1dqSHN5?=
 =?utf-8?B?YUpnZ00xTldCL1oza0l3Z2pqWUd1K3ZXNmpNcnNJaEhSa1RWVVpwZUlIb29O?=
 =?utf-8?B?T09OWVhCKzBsNmNKc3RLdUFPWExsa1VubGJwN2kyN3pNZ1V1V2hhR2dzb2NO?=
 =?utf-8?B?L0EwdGV6ZkpUVjBiRk8yaVZXd1V4VGZ2aDdycy9rcUVqbUxjT1YxYUIrUHVI?=
 =?utf-8?B?anE4dUg0ZDFsQVVsZnNvQXNGSVdqY05xN1VmU0lIK1p4bjQwaEM4QVZjVnN5?=
 =?utf-8?B?Y3NuOE8yM0N3c0g0aGRFL1RZV2JsNXZEL1JudVc4cXpZNEZPR3RRUThnSkJ4?=
 =?utf-8?B?TytvVWZuODRROW5vY21vUjgrYmIzckd2ZHRMMFV3ZDBGV3pOMGJ6UTNNVUpO?=
 =?utf-8?B?UDJYSmg5emFJdVZydFc5TmFSMjJLUFo3QmFCR2xSTjR5T3dpYnFSU05SaFQ5?=
 =?utf-8?B?TUhQelJ6RzBzRUlaaXZuRGhzaVp3Y2U5amg0MGFlNWNUbUJLYmo3UEN3ZThJ?=
 =?utf-8?B?QVdDWHErWU1IRkNNR0pEbFZVMTBvZHU4SERuMGw4SFhZbDBIdmRUS2FEUW8y?=
 =?utf-8?B?aHNXdzJwVDk4THRoa3lKWXJKVktYaEdOYWZuSEE0YUVpc0M4YjBGRlVpV1FB?=
 =?utf-8?B?LzhJS0xsQUd6SnpxYTJmMi95Q0NHcGljZFJUU0w5ajVuRE9KUlRHK28wUUxM?=
 =?utf-8?B?anpYZHptT3ZrZkVwRXY3aDNMUjhNQ2Z0cEtTMi8yT1Q1SzZ1M25mTjlkOVVB?=
 =?utf-8?B?aUNBbmpEdDY2bUZ6dTBWUStOWGxhWHJwWW9Nb3QrN3FRQUZKdSs2R2xIRmtX?=
 =?utf-8?B?ZWplZEIvN3FQVjV3a0tUdjVLOVVVbjRMNzljYnVwWmdvc2NDRnBHZHBXL2dv?=
 =?utf-8?B?WGpWNGk5VzlTNUVjSmFOV1VyTDdyU2VLVExLK0ZkSVUzVTE4aHVNaVo5K2VC?=
 =?utf-8?B?eDM1NWFQVnVTNEsvVG9NUGJRUHZDRXN3V0dYMkFpMWpjSTZ1eWYzZjNiL0t0?=
 =?utf-8?B?RENxS0pyR1F6SnRxcGpqM2ZRTkcyTDIvMjA4T1A0VDBrS1BZODBpQWs5M2Zx?=
 =?utf-8?B?dVdpeVhJSzVQZTZlUG9OTWJVWGNsTDEwMUZ5QWs0NU5Za2dOZlBJRWo3UEFy?=
 =?utf-8?B?UWhsMWhnOHpZcWQzZTE0bmdlbklWcFc2TDdBYy82SytwemFCSkZ4bUlqR2I1?=
 =?utf-8?B?R0pwdVplY2NFUTVZNUdiZE5rUG13PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A65C7050850A0439DF16F4A50DA803E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f286966e-6d2a-4fe4-ea68-08da0238581a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 01:50:24.4992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rh8jSkaeA9CaXZi03V6JhbptaZYZMmiZ27o6THBE/ZVVyiBkaJx5mKFq7eW/EWWCa6VdvBwsfAbC7+5cP2CHww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5415
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_175029_196505_2A28D234 
X-CRM114-Status: GOOD (  15.57  )
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

T24gMy85LzIyIDE3OjI1LCBOaWVscyBEb3NzY2hlIHdyb3RlOg0KPiBudm1ldF9uc19jaGFuZ2Vk
IHN0YXRlcyB2aWEgbG9ja2RlcCB0aGF0IHRoZSBucy0+c3Vic3lzLT5sb2NrIG11c3QgYmUNCj4g
aGVsZC4gVGhlIG9ubHkgY2FsbGVyIG9mIG52bWV0X25zX2NoYW5nZWQgd2hpY2ggZG9lcyBub3Qg
YWNxdWlyZSB0aGF0DQo+IGxvY2sgaXMgbnZtZXRfbnNfcmV2YWxpZGF0ZS4gVGhlIG9ubHkgMiBj
YWxsZXJzIG9mIG52bWV0X25zX3JldmFsaWRhdGUNCj4gd2hpY2ggZG8gbm90IGFjcXVpcmUgdGhh
dCBsb2NrIGFyZSBudm1ldF9leGVjdXRlX2lkZW50aWZ5X2Nuc19jc19ucyBhbmQNCj4gbnZtZXRf
ZXhlY3V0ZV9pZGVudGlmeV9ucy4gQWRkIGEgbG9jayBmb3IgYXJvdW5kIHRoZSBjYWxsIHRvDQo+
IG52bWV0X25zX3JldmFsaWRhdGUgaW4gdGhvc2UgMiBmdW5jdGlvbnMuDQo+IA0KPiBCb3RoIG9m
IHRob3NlIGlkZW50aWZ5IGZ1bmN0aW9ucyBhcmUgY2FsbGVkIGZyb20gYSBjb21tb24gZnVuY3Rp
b24NCj4gbnZtZXRfZXhlY3V0ZV9pZGVudGlmeSwgd2hpY2ggaXRzZWxmIGlzIGNhbGxlZCBpbmRp
cmVjdGx5IHZpYSB0aGUNCj4gcmVxLT5leGVjdXRlIGZ1bmN0aW9uIHBvaW50ZXIuDQo+IA0KPiBU
aGlzIGlzc3VlIHdhcyBmb3VuZCB1c2luZyBhIHN0YXRpYyB0eXBlLWJhc2VkIGFuYWx5c2VyIGFu
ZCBtYW51YWxseQ0KPiB2ZXJpZmllZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE5pZWxzIERvc3Nj
aGUgPGRvc3NjaGUubmllbHNAZ21haWwuY29tPg0KPiAtLS0NCj4gDQo+IENoYW5nZXMgaW4gdjI6
DQo+ICAgLSBhZGRlZCBzZW50ZW5jZSBhYm91dCBob3cgdGhlIGlzc3VlIHdhcyBmb3VuZC4NCj4g
ICAtIGFkZGVkIG1pc3NpbmcgJg0KPiANCg0KDQpUaGFua3MsIGxvb2tzIGdvb2QuDQoNClJldmll
d2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

