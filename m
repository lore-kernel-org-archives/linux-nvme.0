Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA40CC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 07:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qIQQ5fzrKAB25h3lb7u6bYDeBBlYn3xgrA5TByJX4kU=; b=fgRedKUNLKBNfVi+M+OpPZoEGu
	ilHpIEvvlDDWMpgzVSihQMOxTmCy0gDZZtSPkZolLb1OhYSnqSDowX5Zwldd+RnTYy+TjIN0o7VJt
	Wnt55r9GZxkJEA9dr3bQX4xFBgYl4ICGl/PfG9Cpwod4k3UAQNzVSzp99ziTzJpH3s6B6WuUZdLn+
	aQC4H8kfu2r05N0i1X+Obb6E6D1EuUIeUCWG01fFZYeRQSKdG/mDhld5eOOVsmwAbnnwRUmMlbQ74
	8CDH6E5+92tZjogq9BdMu2nnkc7AGDHcQ9MkSRPrbSb0rbMBbF53kZt2doLNFMU4vx+1IJ0vEKDD8
	CYrEYEug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCzUC-00EfGw-NW; Thu, 27 Jan 2022 07:46:28 +0000
Received: from mail-dm6nam11on2047.outbound.protection.outlook.com
 ([40.107.223.47] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCzU9-00EfGW-08
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 07:46:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDn3RP54bWSp1N4Ik1yVrl7d0PFalu+aKtAZOzGhSXehEbb3mGiumRmC0PqOCutEXdr3GRfFQ7lVHh4nY5bW22hYkN0DvQMZj6fbd3Hn/ktM976o5qgfC0AS4CnygCW4qeY9uL5cvcksSYlDu1sYCzGg0aX2yAenwRRdZD1/EWPqM/CLW9mZVbAxQ0JT2q3EHWOPUNC4aSZU4TSyLXGct3CnHPUSOW2WheTkZjv228uNSAnlcECP5sB1ESwu/FHU8IaGhYzSlCEJO6etpeIupUCnVRO45MyAPOl81DQd5LKeOqnSg0M13QCKaTzvyUPu+Za1wpHSdP4gQTBOiJJAzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIQQ5fzrKAB25h3lb7u6bYDeBBlYn3xgrA5TByJX4kU=;
 b=cnoa4Z2osNQI+h7IA52Mqmvo0UjbeNX8/YyovcUP5kB1pv1cagH7+0axv6HCw730W4IQoS5xbbEP00LBPOMYZN0Dow+VfBb/nQuvd6PzcW4xu4zIVT914+rYlrQtkb36+XM+6kxriQ6ZJD4+QZUmq8CSL4g6pnKMWMyJ5S6GSdxac7Wgz3qrxkA6/AQMmo9z83Nyyt3i9KgeMgdWZX7X3W0Mhtp/Hr1oH4VXXym4kVkZYvYsn8/4pCNmEixw1otbmka3A62zTAm9jwN8XFp5/55ZzRKc6fn1wxmqxo4NrfRRGq4vVB1VlVvVYw5HkeQqxDEnYTMIDaFfiEuwQMmsbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIQQ5fzrKAB25h3lb7u6bYDeBBlYn3xgrA5TByJX4kU=;
 b=bj01OfwMdVK8rYzva/ZxXXGTzjdODG+iq3wk/rK3wZpsQSJSYaD3iZtaUwfJ105oJ3BZtEZBxQH5eVgpOKo9i4g0QjFVpMp9FRonBOxQOr+C5oo5SWaLiM2bIV9noLEZqDbu7an5f3XqrnalhcvGxZRr2jgypCmFphpnw0fkbQzSL6hvtBl2/HoIrFx08sHkZmA9IfgqUzqE7TdFzzET2pthzyCUSq3FhUzp2Wp1eBbbkXkx1oPmjEKTnCOUEjxIwSiCVL1JK8O6nJBEoCi/ve5Yk4O4A3C6nMkZu2C/dRUHyzC44FUoVT2ku/AqfAzkwYdlZI+8gKsN7+a9o82Ajg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN9PR12MB5116.namprd12.prod.outlook.com (2603:10b6:408:119::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 07:46:22 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%4]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 07:46:22 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 0/3] nvmet: add buffered_io support for bdev-ns
Thread-Topic: [PATCH 0/3] nvmet: add buffered_io support for bdev-ns
Thread-Index: AQHYDQUddRisECpbZEqYGsT/RGt2Wax1iUSAgAEApgA=
Date: Thu, 27 Jan 2022 07:46:22 +0000
Message-ID: <47264e99-cb1a-8eef-b49b-140b4de51150@nvidia.com>
References: <20220119072038.3942-1-chaitanyak@nvidia.com>
 <20220126162747.GB31431@lst.de>
In-Reply-To: <20220126162747.GB31431@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 005053fe-64f9-46ec-76e5-08d9e1691d1a
x-ms-traffictypediagnostic: BN9PR12MB5116:EE_
x-microsoft-antispam-prvs: <BN9PR12MB511643D23D15AE0B6407BFE9A3219@BN9PR12MB5116.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FDeztvXBPfOtMNN3fa679oi3WfK58RAFW5u2kMNmE+aat7k21H0ePSEhM90oFYZmwQFQkPrQ7cFvSdQO/gWFVNUYULbDrdE0VTf0eGzh1IRcUKQygGLZHXDnVIGjOowbHZUVsgJgtoEusf4GJpOdDiaYXzbc//meQUQ0zcB6UvhehGmoaknHYf6O/9S+NxFo9ZL2d+qrmFJGlzN6tSSqMnDWahscD9jnXqLOHYDWRz56L/x1wED82dKDa/YKb0g3ck6LxPs+fEwp71mZTI0dZ7oreHq2t8jW+2rzjmnos2EvPOxMSOVjwx0B28UKr603MWLfYOc2zazO6S4x2YAL++9aJkQCkrz5Hkihx6o/WWIZFpO6H6PZ46ytGyoyr52fhce09Apt4VLYeJ1sVMeCdI6PoYDBw5Sgtmpe+bLgaC42jPui76OrRqjU/1AzPWS7V6is23VjWzIgrHT1/+WYc+5sJ4rrBAm8oqdkHEGYAnDFeyJZA0eXqZLr4O+IzOl+fw/C3qLHceaJRtdNCp71An6GpNZeFIEAIbSRQgWrlL4F1k6eBdk9CBKNWs9jLP61bxPyFv/9fovYqag/qZDJK1722g7+CvapliGGW4Xq6qB7utSAejB2r0kKalqUGGPvkCQLGe9verN0Z8SxXVKjyqELRC7Ee6IL8kf+UO/JFfaGSTsWaFzCTEmg2X6tHOElq4JaF9uo1CZV5aADCb/1d5HzpSEhtFwX5lIf9RYgASSRMnYu7IZgBRFGOn8JtPJdUUee/IysQj/d5YvPexMYaw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(91956017)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(4326008)(8936002)(8676002)(5660300002)(53546011)(83380400001)(2906002)(6506007)(122000001)(71200400001)(107886003)(2616005)(6486002)(31686004)(36756003)(54906003)(86362001)(6916009)(186003)(508600001)(6512007)(316002)(31696002)(38070700005)(38100700002)(45980500001)(43740500002)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXZ3OHNoRWpyY3JueTYzRVVyVmgxczlzakVsZGdLLzBTQW5laEVuZlBFSHVT?=
 =?utf-8?B?Y0ZtZDYzcHRaNXMxV1M1Q2pZOUdBREZ0V0hzY3FINjJFSHVjMnpzQzZaaHkw?=
 =?utf-8?B?NTZKaFlVUDhxMzlCSUhlREpMNXlCTXhDWFZHQzAyOFpzSGhXT0ZrUWgxeEZB?=
 =?utf-8?B?dkIzYmh5OWwvK245Z3dwMFE5MHNpVTZnVDJVZi9WZW8xQkszRk5Zcm1GZ3pq?=
 =?utf-8?B?VzZ1NTRud2tEUUxZRTdSaFdLemNCc3pXU0lRVHZjbXNlWDkyRnRsZmRaYXVp?=
 =?utf-8?B?ZERwY3REWlIweENrTTUrY3ZsbG0zVkluSVpuZEl4aFcxWkpyTzZySWNJQ2tj?=
 =?utf-8?B?b0xDUmRWNmZGanhzRmRBRUVhTE5uTDJuRFM1M3Y1LzZoQ3lXa1o0L3ZibUJx?=
 =?utf-8?B?VTlvbS9DWCt0emk1S21kVUNsUDhOSkhnZnUwVUFRNHpZb1pONGhHekczeDhu?=
 =?utf-8?B?Um9VN2lSSGRvOGhoWTRWL0lmWERIZHdDbzJUcnVYQVlZbkxTWXhWMUxhdE5a?=
 =?utf-8?B?cGdKaXNXTGt3V0w3bmFPbUwvaW83Zkt5TTU1VDBPZ0tNMUF3Zy9QQ2ZJRTFr?=
 =?utf-8?B?aFBqckhEQXlvRWdwQnlIRDhyNmFwb3pOVUVCTzhYeXJlWWhiNUtSTjZ0LzdH?=
 =?utf-8?B?WDV1c2pCOUZkVHFyY0hCTUlORVNGL1pVbXdjUFJoQllYSG9BeUtrRlY5cjcy?=
 =?utf-8?B?cGk1TElmUWd6QWRYSkZYL1ROOUxlcmFZV2FDRGRnR1kwVkhMV08zNk5Ld3dQ?=
 =?utf-8?B?ZUlCR0FXVTBIV0VHanYvS0RubUh0cEJ2ZEZwTUlDSERwZFN4OW41OVVVUWs3?=
 =?utf-8?B?Q29WUG5aR2k0VmR1K3hnSU5wU3J2TmM3MTY1eFl6Z0Jxa0MzaUcyU1dnU3RN?=
 =?utf-8?B?amU3K0t0bCt5a2JtcWcvK3JyaGhyMXRRbHNRZVo2eXZ6dXF2ckpiVHdmai9K?=
 =?utf-8?B?c3FvS1MxZm44RWg0MFpvb1dsR3lOTDhsbGJmR085TXNwazN1eU1OeE9yYldT?=
 =?utf-8?B?ajAxZC9oMHFhcEtSbmRobkNxdmV0TUwzRDc0WnUzZDU3aGhwdDRhZ3pEdkZL?=
 =?utf-8?B?YU5tVVdZckRzdTdqb3ViZjlrR0JNUU9YVzFQM3gvUjlPTGNOM0djcy9zVVlt?=
 =?utf-8?B?V0dqNGgyQlpUOEVmeWtQOWlJL2dWb2plcXQ2bUl1YXU3THRvd1BqWDFEZFhX?=
 =?utf-8?B?T1hDNDlrZ21hUXVmY25kbmFIcU9xRkdYVlpkb2hFTTZNWWNEb1FWZFd6ZC9l?=
 =?utf-8?B?Rlc3L1ZpbGlwVnBUV25zNDFQQkg1eVEvUTdhNTRJSGNrVVpIWkdyMkRqRldY?=
 =?utf-8?B?bDYzbnVqV05laVNIamFtdFpMc1A3TUJUWnJWZGpXQTNaeXpmb3c1bDRrZXVQ?=
 =?utf-8?B?ckt4QS93OHBNR0JuaEs1andRb2RhazFmYW0zQkwvZXpGNHZyMm5YelJCaUFO?=
 =?utf-8?B?czc1bm1vSHZwK0s1aVVJS3RiYmxpekxnSlpxenY4MTdXcHNwUnZPUWZlNEp1?=
 =?utf-8?B?WG0vemQwNEllYkc5YnRZSFdkRE5QNnVINWYwWldSeXk5U0xlVy9rSExpVFlq?=
 =?utf-8?B?Sis3ekQybUx0elc0QTByVDBSL294ZWUvdFl5dlcyVHEwSHlsSkJCSzMrM1Rp?=
 =?utf-8?B?c01QNEFJZGpoTWhBMlg5d1FCVC9hUDZYREYzUzZKT2FXMnIzWDh6Tzl5eEVT?=
 =?utf-8?B?ZTBETG10Z0pnRXY3N2NIY1M5L0xPSmtKUUhLZ2pTN2JJcHVYVHpFMlR5ZWtO?=
 =?utf-8?B?NkQxS0ZMak00WVZMZGp6RFY3WFdxQjhXVDJDMTVpcVhqSEdnRWJIOXpKa3hu?=
 =?utf-8?B?WDVrNCtyVmxlamZXU3JtMS9ML2hPQ3dVcVh2VjMwQ1BoTFFOY3ZRVWw0a1pC?=
 =?utf-8?B?UGNObzd2LzJ6TCtodUlhaTBSNm81N3dzUms0d3RuRUlPdGZjT0FiVjc3c3pT?=
 =?utf-8?B?V0tGVG1kM3ovRUxvZE9KemtLSEswVUx4aDJMN2lIZ1hCL1NrZi9VaGs0Wkta?=
 =?utf-8?B?ME05eFdrdzNHcTFOejRSZGpiNzlGRlpjazRiS3JUVVl5UGV4eU1McC9LdWNP?=
 =?utf-8?B?Z0tudTdWT0Y0eGd3R1lDWXFyQUxlRUlDcGRBa1J6K1Z6dnozYW42ckFDQVVM?=
 =?utf-8?B?M0RnaklwN2pIbmoxU3BUU3hjenpuWDYvdEcvUUV5eG9hS0hianJqVW4wYXF3?=
 =?utf-8?Q?Do0MwJccX7387Y9EgRV7jMEh7DY9MFt6yEAauW24BvmW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9DB36F3775AC946BF40195BE7BE7651@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 005053fe-64f9-46ec-76e5-08d9e1691d1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 07:46:22.4318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zje9cVb8HqOAyhMPOvnJky6sB1HBOEL5AkKM//NH0pYt0bwNZVkNzdsSwWh37pcvUoSE9plRfuobEgC29PfOng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5116
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220126_234625_073296_156BBD10 
X-CRM114-Status: GOOD (  24.06  )
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

Q2hyaXN0b3BoLA0KDQpPbiAxLzI2LzIyIDg6MjcgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3Rl
Og0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2ht
ZW50cw0KPiANCj4gDQo+IFNob3VsZG4ndCBzb21ldGhpbmcgbGlrZSB0aGUgcGF0Y2ggYmVsb3cg
YmUgYWxsIHdlIG5lZWQgdG8gdXNlDQo+IGJ1ZmZlcmVkIEkvTyBvbiBhIGJsb2NrIGRldmljZT8N
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L2lvLWNtZC1iZGV2LmMgYi9k
cml2ZXJzL252bWUvdGFyZ2V0L2lvLWNtZC1iZGV2LmMNCj4gaW5kZXggNzBjYTlkZmMxNzcxYS4u
N2Q5ZGEyZjc3YjgzYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9pby1jbWQt
YmRldi5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvaW8tY21kLWJkZXYuYw0KPiBAQCAt
NzYsNiArNzYsMTAgQEAgaW50IG52bWV0X2JkZXZfbnNfZW5hYmxlKHN0cnVjdCBudm1ldF9ucyAq
bnMpDQo+ICAgew0KPiAgICAgICAgICBpbnQgcmV0Ow0KPiANCj4gKyAgICAgICAvKiBmb3JjZSBm
YWxsYmFjayB0byB0aGUgZmlsZSBiYWNrZW5kIGZvciBidWZmZXJlZCBJL08gbW9kZSAqLw0KPiAr
ICAgICAgIGlmIChucy0+YnVmZmVyZWRfaW8pDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVO
T1RCTEs7DQo+ICsNCj4gICAgICAgICAgbnMtPmJkZXYgPSBibGtkZXZfZ2V0X2J5X3BhdGgobnMt
PmRldmljZV9wYXRoLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgRk1PREVfUkVBRCB8IEZN
T0RFX1dSSVRFLCBOVUxMKTsNCj4gICAgICAgICAgaWYgKElTX0VSUihucy0+YmRldikpIHsNCj4g
DQoNClRoaXMgaXMgZXhhY3RseSBob3cgSSBzdGFyZWQgdGhpcyBwYXRjaC1zZXJpZXMsIGJ1dCBh
Ym92ZSBkb2Vzbid0DQp3b3JrIHNpbmNlIGl0IGVycm9ycyBvdXQgaW4gdGhlIG52bWVfaWRlbnRp
ZnlfbnMoKSBkdWUgdG8gbmNhcCB2YWx1ZQ0Kc2V0IHRvIDAgKHNldCBmcm9tIG5zLT5zaXplIGlu
IGlkLW5zIGFkbWluIG9uIHRhcmdldCBzaWRlKSBzZWUgWzFdLA0Kc2luY2UgbnMtPnNpemUgdmFs
dWUgd2UgZ2V0IGlzIDAsIHRoYXQgaXMgc2V0IHVzaW5nIGNhbGwgdG8NCnZmc19nZXRhdHRyKFNU
QVRYX1NJWkUpIGluIHRoZSBudm1ldF9maWxlX25zX3JldmFsaWRhdGUoKQ0KZm9yIGZpbGUgYmFj
a2VuZC4NCg0KDQpbMV0NClsgIDU3OS40NDQ0NzhdIG52bWUgbnZtZTA6IDQ4LzAvMCBkZWZhdWx0
L3JlYWQvcG9sbCBxdWV1ZXMNClsgIDU4MS40MzA4MDVdIG52bWV0OiBhZGRpbmcgbnNpZCAxIHRv
IHN1YnN5c3RlbSB0ZXN0bnFuDQpbICA1ODIuNDM5Mjk2XSBudm1ldDogY3JlYXRpbmcgbnZtIGNv
bnRyb2xsZXIgMSBmb3Igc3Vic3lzdGVtIHRlc3RucW4gDQpmb3IgTlFOIA0KbnFuLjIwMTQtMDgu
b3JnLm52bWV4cHJlc3M6dXVpZDoyM2YwOTkyYy03ZWY3LTRmYmQtODBmNy0yMDljZGE2ZDg3MmEu
DQpbICA1ODIuNDM5NDI5XSBudm1lIG52bWUxOiBjcmVhdGluZyA0OCBJL08gcXVldWVzLg0KWyAg
NTgyLjQ0NDAzNl0gbnZtZSBudm1lMTogbmV3IGN0cmw6ICJ0ZXN0bnFuIg0KKipbICA1ODIuNDQ0
MDk1XSBudm1ldDogbnZtZXRfZXhlY3V0ZV9pZGVudGlmeV9ucyA1MjAgcmVxLT5ucy0+c2l6ZSAw
ID4+IA0KcmVxLT5ucy0+Ymxrc2l6ZV9zaGlmdCAxMiA9IDAqKg0KKipbICA1ODIuNDQ0MTAzXSAg
RVJST1IgbnZtZV9pZGVudGlmeV9ucyAxNDczKioNCisrIHNsZWVwIDUNCg0KRGVidWcgZGlmZiA6
LQ0KDQpyb290QGRldiBudm1lIChudm1lLTUuMTcpICMgZ2l0IGRpZmYNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCmluZGV4
IGRkMTg4NjFmNzdjMC4uNWEzM2IzZjczYjNiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9udm1lL2hv
c3QvY29yZS5jDQorKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCkBAIC0xNDY5LDggKzE0
NjksMTAgQEAgc3RhdGljIGludCBudm1lX2lkZW50aWZ5X25zKHN0cnVjdCBudm1lX2N0cmwgDQoq
Y3RybCwgdW5zaWduZWQgbnNpZCwNCiAgICAgICAgIH0NCg0KICAgICAgICAgZXJyb3IgPSBOVk1F
X1NDX0lOVkFMSURfTlMgfCBOVk1FX1NDX0ROUjsNCi0gICAgICAgaWYgKCgqaWQpLT5uY2FwID09
IDApIC8qIG5hbWVzcGFjZSBub3QgYWxsb2NhdGVkIG9yIGF0dGFjaGVkICovDQorICAgICAgIGlm
ICgoKmlkKS0+bmNhcCA9PSAwKSB7IC8qIG5hbWVzcGFjZSBub3QgYWxsb2NhdGVkIG9yIGF0dGFj
aGVkICovDQorICAgICAgICAgICAgICAgcHJfaW5mbygiIEVSUk9SICVzICVkXG4iLCBfX2Z1bmNf
XywgX19MSU5FX18pOw0KICAgICAgICAgICAgICAgICBnb3RvIG91dF9mcmVlX2lkOw0KKyAgICAg
ICB9DQoNCiAgICAgICAgIGlmIChjdHJsLT52cyA+PSBOVk1FX1ZTKDEsIDEsIDApICYmDQogICAg
ICAgICAgICAgIW1lbWNocl9pbnYoaWRzLT5ldWk2NCwgMCwgc2l6ZW9mKGlkcy0+ZXVpNjQpKSkN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5jIA0KYi9kcml2ZXJz
L252bWUvdGFyZ2V0L2FkbWluLWNtZC5jDQppbmRleCA2ZmIyNDc0NmRlMDYuLjk0ZjE1OGFhN2Jm
YSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMNCisrKyBiL2Ry
aXZlcnMvbnZtZS90YXJnZXQvYWRtaW4tY21kLmMNCkBAIC01MTcsNiArNTE3LDkgQEAgc3RhdGlj
IHZvaWQgbnZtZXRfZXhlY3V0ZV9pZGVudGlmeV9ucyhzdHJ1Y3QgDQpudm1ldF9yZXEgKnJlcSkN
CiAgICAgICAgICAqIG51c2UgPSBuY2FwID0gbnN6ZSBpc24ndCBhbHdheXMgdHJ1ZSwgYnV0IHdl
IGhhdmUgbm8gd2F5IHRvIGZpbmQNCiAgICAgICAgICAqIHRoYXQgb3V0IGZyb20gdGhlIHVuZGVy
bHlpbmcgZGV2aWNlLg0KICAgICAgICAgICovDQorICAgICAgIHByX2luZm8oIiVzICVkIHJlcS0+
bnMtPnNpemUgJXUgPj4gcmVxLT5ucy0+Ymxrc2l6ZV9zaGlmdCAldSA9IA0KJXVcbiIsDQorICAg
ICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgX19MSU5FX18sIHJlcS0+bnMtPnNpemUsIA0K
cmVxLT5ucy0+Ymxrc2l6ZV9zaGlmdCwNCisgICAgICAgICAgICAgICAgICAgICAgIHJlcS0+bnMt
PnNpemUgPj4gcmVxLT5ucy0+Ymxrc2l6ZV9zaGlmdCk7DQogICAgICAgICBpZC0+bmNhcCA9IGlk
LT5uc3plID0NCiAgICAgICAgICAgICAgICAgY3B1X3RvX2xlNjQocmVxLT5ucy0+c2l6ZSA+PiBy
ZXEtPm5zLT5ibGtzaXplX3NoaWZ0KTsNCiAgICAgICAgIHN3aXRjaCAocmVxLT5wb3J0LT5hbmFf
c3RhdGVbcmVxLT5ucy0+YW5hZ3JwaWRdKSB7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3Rh
cmdldC9pby1jbWQtYmRldi5jIA0KYi9kcml2ZXJzL252bWUvdGFyZ2V0L2lvLWNtZC1iZGV2LmMN
CmluZGV4IDcwY2E5ZGZjMTc3MS4uN2Q5ZGEyZjc3YjgzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9u
dm1lL3RhcmdldC9pby1jbWQtYmRldi5jDQorKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2lvLWNt
ZC1iZGV2LmMNCkBAIC03Niw2ICs3NiwxMCBAQCBpbnQgbnZtZXRfYmRldl9uc19lbmFibGUoc3Ry
dWN0IG52bWV0X25zICpucykNCiAgew0KICAgICAgICAgaW50IHJldDsNCg0KKyAgICAgICAvKiBm
b3JjZSBmYWxsYmFjayB0byB0aGUgZmlsZSBiYWNrZW5kIGZvciBidWZmZXJlZCBJL08gbW9kZSAq
Lw0KKyAgICAgICBpZiAobnMtPmJ1ZmZlcmVkX2lvKQ0KKyAgICAgICAgICAgICAgIHJldHVybiAt
RU5PVEJMSzsNCisNCiAgICAgICAgIG5zLT5iZGV2ID0gYmxrZGV2X2dldF9ieV9wYXRoKG5zLT5k
ZXZpY2VfcGF0aCwNCiAgICAgICAgICAgICAgICAgICAgICAgICBGTU9ERV9SRUFEIHwgRk1PREVf
V1JJVEUsIE5VTEwpOw0KICAgICAgICAgaWYgKElTX0VSUihucy0+YmRldikpIHsNCnJvb3RAZGV2
IG52bWUgKG52bWUtNS4xNykgIw0K

