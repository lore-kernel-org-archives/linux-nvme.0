Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E03D3A698
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 19:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OZ8RwjC2CEbMfS4ag7HbMsZAJ/0doe9DT08HRv3c+4Y=; b=FAzAQdUTUZxszxS+rJXxtYSuSr
	rA4oDnvKY886VlFbaMZ4Q+p2KMlJxIGpjrYPJvabRalFJ/4QM2YzAgeglUBZ5q76nv7JwtMouY0NJ
	aESoQpqoKCbBWDJ5yp1IcSINUBeOPAm4GxC5XqsrU5oBq2JWGqqM2oT+OjTmRsvCgm2KwF//taS1S
	n83eInSutJsplWlufEDJ9idA6d3hStS60miLFldG9o/X+KRerQHtUN8CaeUYnmtKWchqwRKbtJPHh
	acaen6TLiGzvBdxIRB8rquY5fo5CidxczWw+oEcdJx8eMjHY4XUIIRI9iLWXot45cI8xuYlISMB27
	skzN9PjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5sGZ-0000000Fhh6-37TE;
	Tue, 29 Oct 2024 19:52:35 +0000
Received: from mail-dm6nam10on20611.outbound.protection.outlook.com ([2a01:111:f403:2413::611] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5sGW-0000000FhgP-31QZ
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 19:52:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0d1ecKUkiUnHIk8hScPeYBbMA0opF8cryWUkKzY7QWFYE+ITeZcot0g7I8brXR2J1bxFL1wRFl7r8vlpUF6VzL5Vip9hhj2JfCh6qXi8FEUxF3hvIryCAVQVyBbic24+Vr5EZoSd60JcZf6YVjYi+FskLzR5schNoFqfmjl6rNYzsCd3TYewJbu4iwwPG/vIXOTbR2GyOgjJ8YDeZigfHCRHRUynwxzn3AmZuS0UzNbh1E8aGQwp+tvehvRvJGcq9vrVxY97FrznuzMdZjCevLjC5Nl1Yp0rA/dcpqs9UJgw0ifyGBdHRXQS0v7n20euIQjIEMDUzsA6xi321x6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZ8RwjC2CEbMfS4ag7HbMsZAJ/0doe9DT08HRv3c+4Y=;
 b=OwmP0RGf7Pv/kwSgxk2ioDqo7Zmn9V7CdAc62rqPXGtMzCGtJvr76CupxBVUuK7tryWikxc8mrS8VrrvNOuk3rDfFEiR8QlM3J/7e2UUl83I74rPDKtwFn68BrF8LSLAlACtucB21NdNWcB3zlxzNmkzy4TuvgBuuYTpOyuw6PpLuDfQCKS+bl30BElO5BhQLhRnq+2SSiCjuXdsfXTEeETiny2GCbcA66GV1BohehV4TU+9zz3wbx6kZsLlZDm0+uUGNPjvBVek3EmvkrMgCLcIg659mCBuS8kJEQbK0L67A8FObED2KqA9GJfJWVFAPbWq7vcpTR+SfNWa1ZwAKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZ8RwjC2CEbMfS4ag7HbMsZAJ/0doe9DT08HRv3c+4Y=;
 b=LqQVC9l6ysg3od1dpho0Fcqob2/lIDrcho6fVj2BxWhSSW7w1jrjnhjGtPIyJKxTftl4hwxrxYH9F+BV82niylZXYAxKhlkYAk3yrQT3fk1pXZLfTM2BVXZM+TYKzXIQIdvn9NYZJPFZOQUsKezGTJD1qS4XDbCJBEjC8oOeBPoXr0j9OlcmyJTkHXD3tb5Gj8t4G9YNhJqkMXoxgSulsH5IkRffCzZtNPjGrMoq9HPxDqFVi/hvjNFz41KfGk2F3f7IcuQuSXD6t1t1mGyjYB8Zav+KjacxWD7W5+ageMkFIaoONoXOArheg/dqhJuS7wgRu6cDokfHKIWwHs2JCw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB6954.namprd12.prod.outlook.com (2603:10b6:510:1b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 19:52:24 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 19:52:24 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvmet: make nvmet_wq visible in sysfs
Thread-Topic: [PATCH] nvmet: make nvmet_wq visible in sysfs
Thread-Index: AQHbKaTLTwHNqlYqyUSj9qyQvVBFD7KdLMyAgAAcXoCAANuwgA==
Date: Tue, 29 Oct 2024 19:52:24 +0000
Message-ID: <1c6e0bfe-f476-4c07-a67c-b526b325b405@nvidia.com>
References: <20241029014915.16646-1-kanie@linux.alibaba.com>
 <8b4591d7-f0bd-4e4c-b1b3-1b375f25bda0@nvidia.com>
 <0e90730a-74c0-401a-82bd-92fdbcd2cbe0@linux.alibaba.com>
In-Reply-To: <0e90730a-74c0-401a-82bd-92fdbcd2cbe0@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB6954:EE_
x-ms-office365-filtering-correlation-id: 7289894c-164f-4f59-b77b-08dcf8533552
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SnMrYmVwK0dZcmM5eWowOEdTV0tnMXZwVUg1VUgyTjRYS3pXbEpOZ1JwNE55?=
 =?utf-8?B?U00rc2g4RHl5OExmbTk3SjVyeHBQVjBSbDg3L3plRjNzdHg0dmwxOENnVkdv?=
 =?utf-8?B?dURBeWVHNWdod0daSEpOaE9OZkNmeVRVN2dNNXpwTG1kckJNMmZaMXRMUC9n?=
 =?utf-8?B?dHNPYmdDUFViS0RQZ1hTRVg0SjI2eStNMFVDS3B0bkxOdTQyMUl5aVUyZjRY?=
 =?utf-8?B?em5tZHg3d2F1SzIyNFh0bU1hbm5tZmtuZmduUFpTRlFXZDJ4LzFUVDh3S3hu?=
 =?utf-8?B?TDJjekNGZGpLYVhLZmdlcTdKcFpaK1F1RHBkeDBhbzc3MDZPaE10QWh2MWxn?=
 =?utf-8?B?VVhGOW53QXFIc1RieHFCSFQrMlBYcTVKMXlsSk4rdnNyMnFNcWdibTg0Yzgz?=
 =?utf-8?B?NHcvbE9zTEVITlFnSmVqMkNsUkl1RFlsMUE5MVQvRlZaRGFqTnBzUFVZWHND?=
 =?utf-8?B?UzVtbGRmdzQyWnRyUUxXK3hvTGhUZlVBRDZ6UWNCV2RNbHlhZVVDWFVoOVBr?=
 =?utf-8?B?MnJVNlRnR3VpL1NucGNuMDFyYXdIYWJMOEovZlNUTkRkSDZWdjBLeW1zV0Rq?=
 =?utf-8?B?dTJUMEE4cHlaRXhoUVVFd0xiN1J1YW1NV3ptLy9JbE8zSmZUQ0E2aGF3LzAx?=
 =?utf-8?B?L1FhVnFxZHJwQVROOVFPTVcxQ0lFRzhRNnVHeHM0V0hHZzlPYkx3SUVMSnRJ?=
 =?utf-8?B?cHRGdEtYbmFrZDZKQVdHYjlqMDRRSEQ2eWc3eFBLTVFQK3VWOGpjcFVjN3JD?=
 =?utf-8?B?N1VjeUUxV1FVd01saHlDaURGK0lodi9lcyt6UGNDaVpTdXIrbDBUUGpCV2xW?=
 =?utf-8?B?NDYyL241WHZlcG02QVV4R0tXclRlN0l0Yi8rUGlzMkFGUlRpc2MxelloajQ2?=
 =?utf-8?B?Ylpsald5U1FwMTFnemFNYmhVQjdDUGhkYUZudGhWcTNUVlhRVUtBYzVlQ21U?=
 =?utf-8?B?eDJYd2dRaFZSa3JtQmljdi9lcWxycnZoZVppSXVyOWRIRi9qeTcwNXNmMnpI?=
 =?utf-8?B?Z2JKcmJKWFRpTkZ4NjUxVHVFT3czNUxZWXd0V09SREJFSGVhcnJRckt1ZThh?=
 =?utf-8?B?a0diOEdVbW43NkxyZXZ5bkpESUxTYWpaNUxuNDJFQzJIdSswb3g2WEIxNlJZ?=
 =?utf-8?B?a1IyYkNrdnpPRlBlTFZrWXZtc2NEcEc5M01aWHU3aEZVV0lFdDBGMW96Z2dL?=
 =?utf-8?B?dk1wZEJtNFRjUGl6a0Q1RUp6Sk9IKzdXZlZ1UVFGRS93SjJYUklHUnFzUzdZ?=
 =?utf-8?B?RnEwVnZ0c1JpQ0M5SzBQMDcvS0hiaGFJR3lEOEk4ZmNOL0p4Nzl3YkVsUFF6?=
 =?utf-8?B?WnJvQjJiN2k3ZDM1TERxekc1V0VOYzRHMmZxa1RvTnVZb3NpOXJnZ3dZamN0?=
 =?utf-8?B?ZkZXWHk1U0FVc0N5ZTJOSFpEZG1tYyt4dEhDZlBMRExvcjZ3S1JkRnlLNnRE?=
 =?utf-8?B?akxvK2ZmcHVSSDRGYTVRTVVoTVNxVnFJSDhWKzA1NzIrT0toUVhzcGI1Tzkv?=
 =?utf-8?B?bkVHR3hmNmNTa0pPbk9pTnZ3VDJsQ2hXR243eW1qcnF6R1BLZ0xEaGU1VVk4?=
 =?utf-8?B?MFpVSmNVRStZNFdZT05NU2JPZUNrSWR0R1lSZnY2YjlHL2pSNXdBN0lUOFZx?=
 =?utf-8?B?Ry9UdHJYclVvUm1LMmNmaGFJMytxblFLU20zRVE2SEYzbURHSm13dmZDRmQv?=
 =?utf-8?B?emY0QTdTRDBUR1hrMUZjNmVnbVRNQ2p1b3dUc0p0Wi9rc3BjMk9jaEFaNGdV?=
 =?utf-8?B?NVpXWmpTQzZCQ1RMK1czSE8rNkhNSGYxQ3ZkWFJlQWNEdFFvMG0zTk9oR1FP?=
 =?utf-8?Q?m2YQkSR1u6YKZNEbOvPyI0APbZ3rNlHs+YcFE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTZ1eU5GNlN1YW44M2hobVZmdmtNN2hvVnM1NG9mZkZVWm9zZEpZYkdnblpC?=
 =?utf-8?B?Nm50US9kSXZjYk5xVTh5YWNPempSVjZHekxPOGZiQm9CKzh4MFY0RWdLWW1S?=
 =?utf-8?B?SlRBVlJkV1pEN2o5bC93Q3prMW1HbUM2UGxLSU0za3c2OXo1ck5GSWFMaEZK?=
 =?utf-8?B?djdrK0hGRFhSeXJwMmkwMTdQU0s0RWw1YU4rYWpIdnU3TnBGRklXekZNUzJM?=
 =?utf-8?B?dFloQ2h4ckdZQjJ4REltekNERHc4aVR6bS94aHBnRk9PQks2VFU2a0pOZXVC?=
 =?utf-8?B?YUt0cVdiaW41aEtPT2RMN0RxdDVCYSt3SnZHb3BEWjNwSjNWbGNLc1ZZL1B0?=
 =?utf-8?B?NHFZS0xYdjNhOTBHWGhsOXZkeHJwVjhkOTVrZkJrV3pnaGpWVWp3SWtLdUNy?=
 =?utf-8?B?SGhPQVBvV3FwNnREclFHdHpUZ3dWM0dyL1RJU1Z2ZGM0VklGV3dMUEVHV0dy?=
 =?utf-8?B?dCs1K3lQSnlvUUV0cFFST2lUQ2l5MkhOaWNQclJMdWpmV1ZJcnN6b2lQaE1z?=
 =?utf-8?B?SWZRSkNnNVpkTXZieUtuTnQ0YkxOa1RBRk9mdk1Ta0t0Y0RMc2hkYklEaHJH?=
 =?utf-8?B?NGtqWDlDYlZQeGw3ZFE3VFNYUG5RZ1VDSjB4cEphamFKZHJzck5sb21LU0Qr?=
 =?utf-8?B?d05aYmdlN1dkUWU3UXRxdmRGa1R5Z1JhLzh5Z0FrZzRIemQyVTFZVFdDKzFC?=
 =?utf-8?B?SGRTd1FFbm9YWmc1NVduRG1TaUp6NWlHTS9RU2xsODNlaFNER0VRTlc0RVd3?=
 =?utf-8?B?Vmh0amU3VXBPVm0vRXFJa2FxTExFNkhMSHl3VDYwWmM0cDR1c1lzbVBkclBV?=
 =?utf-8?B?THZNWlZ6TXZRSDBrd21Zc2lRZmlKSlozWHYzV0o0Y0pkZUZVd29PWS9BOFN0?=
 =?utf-8?B?OE10eE1RQUlaVU9jL2NsRHorQkR2bnVZSU5rRkhJbGVQWmhOWm80ZUFQdnVS?=
 =?utf-8?B?aDVXRlhYYUIwRU1qYzJGYkxHTUZ6RkV5OTVzbzBOK2UyTTB5NWNmUjlmQTUz?=
 =?utf-8?B?ZytJb0psQlFOSzVLeU90bFQzZEdkVUw2cktGZjA2Z0JTSmh4cnBldldCc0t6?=
 =?utf-8?B?TEJzTDNYTSs2ZU93RG5SOWU2NnBLVnBNV3hWODBkcTIzR29oVzVEaG9JR2JB?=
 =?utf-8?B?TllvaWNQc0JtWWlURTRsdEpJK3hkTURVdUZsZXlKczVKWGJwTWs4S1A0OS81?=
 =?utf-8?B?VitRQWhnTy9ZRDNacGNXY0hybmFyNzBWcEhoM0RKVVFKZTM0M2dFLytqVmZq?=
 =?utf-8?B?M3RpZUFoenBZTHVXZlJRc3RqbktkYjVOWW1GQ1dqd3FmT08wTGJ3c3Z4VEhJ?=
 =?utf-8?B?NkFvdksrdEU2OFBTTUFaUCs5MU5MQWVudUpqRHJNSXlnOU9idUhTTy8vLzVh?=
 =?utf-8?B?bkVkUFFOY0hLbWdEK2xERE41OWZNcjFsWWZYcWU5MHNxNXJ5MTZlWjVJTStz?=
 =?utf-8?B?RklTYkF0YkV4TzNRWS85ZDlacm9uMGhGbnN2czgzS1kzanVxdWFpSHVxU2pv?=
 =?utf-8?B?VDBMSlhzbktpS3krcTZvRi9KQWRXUG5yL3lGRy9Oa1pjaTA1bmpIcmhYVTRv?=
 =?utf-8?B?VnZXcGI0TlNhMGFTbmp2WlNERzZzK3Bqc2hxV2VUZVZsbC9ndFZLWC9nallO?=
 =?utf-8?B?K0xBdnhtcXdwMTNVL2trL1g3ZlppZU5nY2s1YVJHeGNLMjIyYUIzMis5Y2Nl?=
 =?utf-8?B?ME9XZUs5cXRmTytyN2tLcnJxNU1aTGt3eW16bFhlSlBHYXJoaE1yU2RKaUxH?=
 =?utf-8?B?eEZsQmxnSm5RZEVUMWxNNmxBYTNDN21qSGFBam50NUI1cExnQkEzUnVTNGpS?=
 =?utf-8?B?NDFYczRHa0ZnSVltSmFkcVZmeFlkTStYL1N2YzNRSzYvZEtPeEFrK3IzdjBl?=
 =?utf-8?B?TitKVXk0UFB5bVZUSTRKOXBjMDAxMmxSNUVMVStnYzQzeWFSVEREQTFxbkR5?=
 =?utf-8?B?bG13YzViSDJPQ2dPdHpjcHRrNlRhdUFsM1NPN0FnQUpZd0dSa1NIVjIvRU8x?=
 =?utf-8?B?T0JGWjFlUlFmdHR0WXVpeHNUdzR6aGpmNUNYeVhQL0FONEUvNnVkYmNGSWx6?=
 =?utf-8?B?Vjc5U1dWbDRIbVl1dkVwZzZKMmgvbWUyeXFxQWEremhYTGpiNXBEUTdwVHU1?=
 =?utf-8?Q?R6glQE/oYBPCl6QmIpfesnykL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6D44CDB663C1340949695B62E24F384@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7289894c-164f-4f59-b77b-08dcf8533552
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 19:52:24.0201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qDCg5FenN0mhnsrYr5tCLUvZNqcTDG5Fnyd0H5CwI7f9OtX340wRizrj4ld/S9xcs/Jwtn60QVUu5UY6hcZng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6954
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_125232_793765_441AA60B 
X-CRM114-Status: GOOD (  14.94  )
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

T24gMTAvMjgvMjQgMjM6NDYsIEd1aXhpbiBMaXUgd3JvdGU6DQo+DQo+IOWcqCAyMDI0LzEwLzI5
IDEzOjA0LCBDaGFpdGFueWEgS3Vsa2Fybmkg5YaZ6YGTOg0KPj4gT24gMTAvMjgvMjQgMTg6NDks
IEd1aXhpbiBMaXUgd3JvdGU6DQo+Pj4gTWFrZSBudm1ldF93cSB2aXNpYmxlIGluIHN5c2ZzLCBh
bGxvd2luZyBmb3IgdHVuaW5nIHRoZSBpdCdzIGF0dHINCj4+PiB0aHJvdWdoIHN5c2ZzLg0KPj4+
DQo+Pj4gU2lnbmVkLW9mZi1ieTogR3VpeGluIExpdTxrYW5pZUBsaW51eC5hbGliYWJhLmNvbT4N
Cj4+PiAtLS0NCj4+IGRvIHlvdSBoYXBwZW5lZCBoYXZlIGEgdXNlY2FzZSBmb3IgdGhpcz8NCj4+
DQo+PiAtY2sNCj4NCj4gU29tZXRpbWVzLCBpbiBvcmRlciB0byByZXNwb25kIHByb21wdGx5IHRv
IGNlcnRhaW4gZXZlbnRzIG9yDQo+DQo+IG1hbmFnZSBjb21tYW5kcywgd2UgbmVlZCB0byByZXNl
cnZlIHJlc291cmNlcyBhbmQgcGFydGl0aW9uDQo+DQo+IHRoZSBDUFUgY29yZXMuIEZvciBleGFt
cGxlLCBpZiB0aGVyZSBhcmUgNCBjb3JlcyBhdmFpbGFibGUsDQo+DQo+IHdlIGNhbiBpbml0aWFs
bHkgYWxsb2NhdGUgdGhlbSBieSBkZWRpY2F0aW5nIG9uZSBjb3JlIGZvcg0KPg0KPiBtYW5hZ2Vt
ZW50IHdoaWxlIHRoZSByZW1haW5pbmcgMyBjb3JlcyBhcmUgc3BlY2lmaWNhbGx5IGZvciBoYW5k
bGluZyBJTy4NCj4NCj4gQmVzdCBSZWdhcmRzLA0KPg0KPiBHdWl4aW4gTGl1DQo+DQoNCkknbSBh
d2FyZSBvZiBleHBvc2luZyB0dW5hYmxlcyB0aHJvdWdoIHN5c2ZzIGFuZCBpdCdzIGJlbmVmaXRz
LCBteSBxdWVzdGlvbg0Kd2FzIGRvIHlvdSBoYXZlIGEgc2V0dXAgd2hlcmUgdGhpcyBzZXR0aW5n
IGlzIG5lZWRlZCBjdXJyZW50bHkgPw0KDQpJJ3ZlIGFsd2F5cyBiZWVuIGFza2VkIHRvIGZvciB0
aGUgdXNlY2FzZSBvbiBhIHBhdGNoIHdoZW4gd2UgZXhwb3NlIA0Kc29tZXRoaW5nDQpvdXQgb2Yg
a2VybmVsIHRoYXQgaXMgc29sdmluZyB0aGUgcHJvYmxlbSBpbiB0aGUgZGVwbG95bWVudCAuLi4N
Cg0KLWNrDQoNCg0K

