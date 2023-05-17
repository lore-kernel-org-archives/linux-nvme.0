Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14FFC77B7A
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 21:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8tyFD1Sb2A3f4Xj3xFcvZv4cu4ShTX71wO8onJeXqPk=; b=jj6o+biLDxNQNO6lFTmT3d7kUV
	0nRoVtKR/0iaklBiLtz9o59NQVxrvjmZU3wqIuw1E9fK4sQNhHuTpHnf5xrLofnfioNRrjSAf+xDu
	xWx8HRIwVqfuNTB64ZNb9Xbm7hW8x3VVhMK3XwIh0NFYr5i4Aeant6b5ReTtikjN+UPLgUti1Z/RL
	+fNbKjt0WBPmu9IhCBhsV7JnBrHpLBQrNIlgjiW5LQhaY1Iflg8d7YzfyGoHLrErUn5Ca5lPwCBWI
	hFwAhla7F7PLjgSwjvBh6cVGl/rtaPOpx/UIwxnYgwHPVUbUJLcX+PgWl3Z23aTnw2mv88TBvx7nv
	iEfEyXzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzOeg-00B6Ua-2q;
	Wed, 17 May 2023 21:25:54 +0000
Received: from mail-co1nam11on20604.outbound.protection.outlook.com ([2a01:111:f400:7eab::604] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzOee-00B6Sn-0R
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 21:25:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dC5iv6RzZ7IaxtoAg50ueNRy/2TbvHCx8U7wSuXQWltCR7+A1sZhE5LnLaY87crCQeN9iJJUP86EVsGGqsFayTxVOO7THn7opQEZtW2t5NaS47FZmjnIEnPdGsP8agt8fvIy9HlhpyU+83UkpXJOPs1+859Um+eBtWS2+wn4XJgcIXcSN3QJVnOgYwaEtyzY6fX3zOvY7SEOkYK21MVhFwenHi6aPif5Np2PZUQPbFw9giJTv6Vf0j1JcLhxnvM7ynGeFHa23kcl4/V7hth1YqNPMZKOiIaU2r78GvXQMEiRgYlcuNKECwFq7ZJUicJhoQ/Kat0Y/bJkca+6c4aPYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tyFD1Sb2A3f4Xj3xFcvZv4cu4ShTX71wO8onJeXqPk=;
 b=OB90BSFjJncC0LCTp9wrYVdpoFxoIyoQlF/pi6sntWUZ5/sZgVSz6wshpIG4+QpSQY3IscDzXkh2YQQGrsS8MROcCNPvpjsOH+NqJFO3MFdrG94KCxHeEBH2To1/L1vq8byuyyBsYJ9Fpkgf1h0HWCD+uN+wfhzxyzJX41iiUmYykiyiHlD9njszpi4V7lt7MGKqu9V89C0Se/vdyyUZEgkDlQVUQHFbbIDhGrqS8UsdISP3PY24gKkN+jX3+JosOiU8l2q2ljE+bUhz0VVHfEw4zQlanzcnBu7shs7Wa/BbDfHtSFq+tibRwLEqYzEyWLPgTlOmfSzcCBSqk+8Q6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tyFD1Sb2A3f4Xj3xFcvZv4cu4ShTX71wO8onJeXqPk=;
 b=rV0kEsuWozr4UeG8pl1WevYafzWS9ZSexJwVs9uxSffsXzXcQXBLa0lWYok88piG1dFRPt8xPBixUWE1i2kuF2QooUf9m64FZRlkbXujTzefd5dO7c8GvmjWdnU4sHnRHxb8oqn43NmBkD0tUNfBNjgPpZEcffSRt9DzIxqfy/DxfZ2hk/2Am+VksTaDRWcmwlffWDmeSEjV089SPVh+g+Qi3CZSuV2YqnhC2pN721YQ2tXxpJfjec0axrzq7P37Cz1H99W6fVZeIBjk0LC6BAkarHLadidr6MpM2GzBDZyJtMxQjn4AgFB+5ec+SJvI+nPVEj1PV5a5+MNsC9j9mg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA1PR12MB8886.namprd12.prod.outlook.com (2603:10b6:806:375::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 21:25:48 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 21:25:48 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-pci: Add quirk for Teamgroup MP33 SSD
Thread-Topic: [PATCH] nvme-pci: Add quirk for Teamgroup MP33 SSD
Thread-Index: AQHZiQWQI1cf5C1+OkGGE4PkTfhu669e+j+A
Date: Wed, 17 May 2023 21:25:47 +0000
Message-ID: <a0948704-9929-03a9-3a4c-39a8d193b846@nvidia.com>
References: <20230517212113.18470-1-kch@nvidia.com>
In-Reply-To: <20230517212113.18470-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SA1PR12MB8886:EE_
x-ms-office365-filtering-correlation-id: d8f452d2-21f7-4572-1972-08db571d4829
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  G8MHQIFjviH7oi0WuMtIaksArcbDMMYsXTUORldv0Tbqt39ovgF+QCmC+ucVmhUWh0xJVHRqFGy6W430nHno0im1g9p1XKdP39LbEsUw+8A37ginh+nYHJ1DEPBbk2qvfYx3mEh7HeFhbOc3g7ldH7Kw1kJndqxpP7ptkex3oKRkuXPYVp92QUEAMRYO0fe3iuBB2BDmiEVGEXA3g1NF0dYLrnjDH7wWsxLF3RAR9xeLKP39SHt/6V75smxRRq95+gGW/ozEmWk5/QcodZGBz/j4ZFn0v5wqddprjNz3iNI5g4VUyzwrmaoeRDab4K9O3+/zWZ9tXm4DsT6RACG4fRLIOcq2/Osf7axxTX289q1+4IfGg6DQ8Gl5AaRjkcox8sTdmnYVn9w75WJAWaFCKcG2ye4/03hfXPe1hILte+vqyLmSRd7EzmeCMeYKxHMwMjtpnpKW2NuDnlxqAIAT2TQaORetlgzmJR87bf+5iTHheVH1v9jjFJNReOoelxYsu/zvQ690r4NgedHH33TFEq+91ClsxCIuphzJfsSPIAixYXQbPcfskZ8amuBGoiyRklQgGNUX+kyph+pr9xJmyF2aOjSSqLoHKWeMWBLIA8S1NmqBZQkPkcA2yO39zOM9yPQlzd3QX54QGXuQpcKFXvCIyAc0nBGngzSMdLd8PqIaYEbdW3WVxfOzByFKlVD4
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199021)(66446008)(66556008)(66476007)(64756008)(31686004)(66946007)(478600001)(53546011)(91956017)(54906003)(110136005)(316002)(4326008)(76116006)(6486002)(41300700001)(71200400001)(5660300002)(186003)(8676002)(8936002)(6506007)(6512007)(2616005)(36756003)(2906002)(558084003)(38070700005)(38100700002)(122000001)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?MTY1RlZTRGpkRDNubzBYR3ZyejFtYkZ4OC9jOGlYeG5vK1VpWXl6bTQxeWNU?=
 =?utf-8?B?dmVOMzMxK2NYZGhsRGJBdWI2NXhxbUMvVllyMUpFc0NFaVY4NWJEOHdtTFc2?=
 =?utf-8?B?cHZwY3g1L1dudTVpamV1b3NNUVRtdllCc0E2S1lGUk1lQzVnNmJ0emIrOFcz?=
 =?utf-8?B?NWJFVG1tTElZU2VpVGxQRFNjdk1tTkExVENxWFlDUXcra2JLTnNwOTFuQVp6?=
 =?utf-8?B?eEw5N2JhcUJhSUludHJxcjNYU3RBV0Mxak9zTkhZMmRnRG1qendCTkIrUmFl?=
 =?utf-8?B?cmQrSm55Y0QvNHlRZHEzK3dqMDl5QmpCZDRScGYzQWlMQ2ZHci92Q1VFSEVw?=
 =?utf-8?B?N1Y0ei9TRjN3aHFPcnZaZ3BYaitXQ0tVVGxPcG10SEpvL3YyQys4RVJDTTN1?=
 =?utf-8?B?VFNpV0ZUQ0FnVDYvWHZMOURuL21UWEVwbWdHTDFDVDJMa1pGOFlQTUIzeGo1?=
 =?utf-8?B?VEpRZHBiSCtSb1FXRDlndDRJbVBRcUY1c2hIVzIwWE1jRm10UFViUzJxdHBN?=
 =?utf-8?B?WWJjT1djT0pldVJRNmlsNFkweVJvcVd2RFdIRlE3Mk8veTg0STg1NmlXclcz?=
 =?utf-8?B?ajZBS1ZxNkR2SHhjU2RrT2dEaFlBekhzVGRDRGNWWGhxNVozWHNYUGVKOE1I?=
 =?utf-8?B?S2dVWUFKWlh0aURvYUpVUHhoVU9YY0Y2TDJTUlB4UmY1TUEyZnZPbXlZd1Vl?=
 =?utf-8?B?ZzJYMDlEeDFLT1Q2aDB0VmwzS1JJOUh6Zmh0UlBIL01QTFFUQlBSL0lORjh1?=
 =?utf-8?B?cFZ1MlVkaC9xQ3N6aDAxSjloaHJRU3NqaUJHWHVrdXVMdDNhUGs1OHZCdkxW?=
 =?utf-8?B?alI1ZUxBWVc3eEU1N29ZOW42bTVNNjF3bHQyaitGclloSjEwZmJKdWJQSWlT?=
 =?utf-8?B?ZGpLa2RWNHhvOXBiZVN5ZU9MTU9rbm0zaU9WcXd5YXg3RmVubzlkVi8rczhi?=
 =?utf-8?B?cTZhSDg4U3NtQVdvK1gwd2RrRnFkcm1hdlByUzAvN3hlVHZ5ME9PdGRocHQw?=
 =?utf-8?B?Vm5XM2pxM2ZkdnZ6Smp3cUkxWWZWZEZ3OXZsS3NzZURtTXR4SGJPWWk3UHd4?=
 =?utf-8?B?T1l2Yiszc2REaW5nckdLVjhLU2NiNVNZSkpmcFJjMVltTnVwc1p3L1NWU1NY?=
 =?utf-8?B?STlnbmowNDhaY0NNbEcyYlNHeVRsLyt2a3FYKzdnSTFZSEwrRjRTZVFSVCtp?=
 =?utf-8?B?YWpOMFVNbG12Um9XVlloYWEzYXpLUWsyeHpzR1JxdWwwZXVLR3AyZmZIN1ZY?=
 =?utf-8?B?eWZWN0Z2c21FdjBEMnYyMzBFMHFZYjhJUTZVbEhybndMWUdrQnNIVXNZWERM?=
 =?utf-8?B?QUdOMHJRWi9aSVMzY3RnSmc0RXFlamgydG9iVHc1Unl6WmRYMCt3WmZjaDZU?=
 =?utf-8?B?TzZWdWRidnZTbWlJVzhSS1lnZklsZ2tzeHkyZXcrd0orMVQ2aks4UGJZY08y?=
 =?utf-8?B?bFZ1WjVmMVpmTGo2NjhsSTFxWXR4NnE0ZWVpTCtGSG9HZU45UUVzU3VJeEp1?=
 =?utf-8?B?dmF0Q1JFL3ZlRUtua0RsSGs0WnhhektzNFA2ZkYvTExjRWRSQnZLTkxrQUt2?=
 =?utf-8?B?aEc5UkpjV1RNVkRHSllmNGtETFRUNUNDcEtpeFZDeHhKVzZpMHpkT25ucWI3?=
 =?utf-8?B?WWNHKzY2eGFQVTJ5emVjQ3YrejhROWIyUm94THE2dHVjZVNZdnRhTElaSlFp?=
 =?utf-8?B?aFRtSVFqK1dxYkNKMitZMjJCOEdmZWVmQVBWNFFMZGpnYXo4WmlDNnljRXhO?=
 =?utf-8?B?SDdzMVg4NHJJRVVuVVdrNWUzdmVGOVVmVFJwMEtDMTdQY2NocFpHdVdzR3c3?=
 =?utf-8?B?bndORHJHNFlPdHorWGlvTXc1Vm95Z20zeHBNNFR6cG96dkNqT291Szg1ZUhP?=
 =?utf-8?B?VndKeUg0RGZscUo0bXBkMW41dnEyK0p6a2ZwQ0krMXVMU1VGYnVOUlMxR0M5?=
 =?utf-8?B?QkpkVm4wL2VNNHZEL01zUW84ZS9mTXFMajhncHJ4V2U0c3hEdENEVnVFN3Mw?=
 =?utf-8?B?NXg4S0tpdWZlZnlxZUVhTjdLeUo1SHhMUlgzenRVMnd1REJ6eTdKK2RkV0wr?=
 =?utf-8?B?cW5FcGxkbnJSVVVwaVpmZGRyVFdSQXlZSGYvek0zV0tBaVFvUWFJdytKd0Zw?=
 =?utf-8?B?VDZMMTF1S0xDRTNpM3pxamx2UVRxV1k5OVN2SmJBOUFDTW5WaS9RZTZkQlda?=
 =?utf-8?Q?GgFd0FsBcH0xTZsKPh1x/Ax8kbRYOpNCIH6QkqQ4/ybG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FE2FF5262292645836A515E103BA734@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f452d2-21f7-4572-1972-08db571d4829
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 21:25:47.8964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ouvtwn8AXtykfhXz7arNz1erCPJXTCAwNMyl5QBFvyjLjm+p6Nich2LONZepxY4LeWiBGGsVijeg87BO/GBa2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8886
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_142552_176138_420897C5 
X-CRM114-Status: UNSURE (   8.22  )
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

T24gNS8xNy8yMyAxNDoyMSwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBBZGQgYSBxdWly
ayBmb3IgVGVhbWdyb3VwIE1QMzMgdGhhdCByZXBvcnRzIGR1cGxpY2F0ZSBpZHMgZm9yIGRpc2su
DQo+DQo+IFNpZ25lZC1vZmYtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+
DQo+IC0tLQ0KPg0KDQplcnJyIGZvcmdldCB0byBhZGQgcmVwb3J0ZXIgYXMgYW4gb3JpZ2luYWwg
YXV0aG9yLCB3aWxsIHNlbmQgVjIuDQoNCg0KLWNrDQoNCg0K

