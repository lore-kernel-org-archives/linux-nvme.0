Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122F5C6FA82
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 21:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PZH/3OL4qY166A5GSogZ9Ru1qhn/Wq/gmeAYu2JDe3M=; b=xLwwzTtcJjDH5VzhSLWzui0875
	fP0defdGVD/04LOCtmhUjZpqyosToBn/wXDwaqLaR26X/VhnapbJ9ZiCazukdDYqxsfYNC2oJ/lR+
	ba5J0OHrdGog6sM893USpBy96mW0VFPvGs0JvtCDyjCrSXucp5ZKuizglKbzxowAq5DdQongnWCNb
	jWEsd7BA8rZe4MMofbMMGNRgW709LPYCG0csWZqsdC/yAXIzBkCHZh7u+vP94Ltkdtl/8G2ugBeHh
	KZIn0ds0gJAPdOw33VtGZDmarsjVhquCCNQARqoMHg4lynMehWYfshBWNLuMVA0O0MPrk/ZDs+byq
	Pk8FEgZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oal3u-007C8b-EG; Tue, 20 Sep 2022 21:45:50 +0000
Received: from mail-dm6nam10on2047.outbound.protection.outlook.com ([40.107.93.47] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oal3q-007C5f-8z
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 21:45:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggIxwI3/yiS2aQ34HzZ4Ppghai4FXfC83PgxtXRN7Srh/QLGreqCQWBmfz57SpRd/tNV7jbTRPpqDiQgE2YF7mkCqHyW6zcMPrhsyNL66nJZEaXdh+1wSaeVgSAWbXtBmGWzFXkeH1pkKt/3K0PU9SF1dFm1pehHqh6LrxAH/g4VAE0tLvMax/WdvS3X/7RDxZbD2SLKYDIkpG7Gu6UaheQLbwbH/HvMRJ/ZDml3KdI284e5HXwndyP8QcFJxM3ORhFBd0xauxJaVAe3VnSUdUXwy0536FR5XCiV4G2rAxZsMDm+9PAcyhaGKzbruBeRA9vQjiS0xlfYkYB3LNb/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZH/3OL4qY166A5GSogZ9Ru1qhn/Wq/gmeAYu2JDe3M=;
 b=QZAuChpZlFB4dKFiqRhzK06zUJVl2Eha7SuxoZxQpChjcvL9ts7EnaVXvD4nCv3ZzdfJE2F/OcNmN8bDh5p+vATnGhbosB+qTdr7ZB+TNRgznAJYfyMaGvqH0aS7cva7Nt70ismXG3RyZf4tHdPRAqnLFuNW+8JKnp16MNuY/vCDrycI2hvj/dADOpZRQOlIrLgE9izICEuEFJQPj6VzRn92f6uPP+KHJikZqmTQhnjmbeaLWKdq6APBx4a9O+ONiIhO5/KY0BRx5d5AF6m+hWS6VlU5Tu+qby05xAj68MbI/CeG/gW0B0kOHpAVcgJgR2lN8LPEP6mqALelCkbCUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZH/3OL4qY166A5GSogZ9Ru1qhn/Wq/gmeAYu2JDe3M=;
 b=izAk5a6Rkzxmm2RVPrm3y2Cp/ecfpdJVMpuU75E2sSS504FRUryTFga8LMrYXAr595x3f794/ExWZzcpBUVyTC6FoYwtbF3SUKvXWEbLUcLRvNwsL5Dlgo9h+LOyYCiRggrW4W/PuQ7BQh9dw2nnBAXvzzPKsT8MZObzWKHQ7K6Y3dZQrDnJQprBqL65/QWN2tD1/siB0+jJOr+ryNoVUU2eJ/RBntOroFJfaydWnxRz6pE5/9S3LVM4Xnc8mdWnT5zt6dznBYrP9aRN+1V7qirQP7fo1Vx+1k5gZXgSifG6rM/whmDoUgH7NPdprwP/Ss7cP7ZWHgPiMbi/KSKgqQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 21:45:42 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3d10:f869:d83:c266%4]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 21:45:42 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, James
 Smart <james.smart@broadcom.com>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [PATCH 10/13] nvme-loop: initialize sqsize later
Thread-Topic: [PATCH 10/13] nvme-loop: initialize sqsize later
Thread-Index: AQHYzRT6bQffsTSrWkCZ21S0cCFs1a3o2n8A
Date: Tue, 20 Sep 2022 21:45:42 +0000
Message-ID: <8fb9f66e-44a1-3b86-00a4-cfe43dbd7a31@nvidia.com>
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-11-hch@lst.de>
In-Reply-To: <20220920171611.1289361-11-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BN9PR12MB5052:EE_
x-ms-office365-filtering-correlation-id: 98fbef2d-e649-4ce7-d7b9-08da9b5177aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  Araq6pdcAS9TQ5mywMteNPbkkD7R8VtQ65lStSxlUo7vkEgWuP83k/YCpGnLDedpqqHxcLvIvi1J568zD4ixyqNnNChqjR1o9RtvoRZFux9gdhIpICsRmAMWQ3jSA4e76QMx+Vnzbr6c0sN1Tkcsc0a5d8GE7pU9tS5m54zhZstSrSMwbgl9yJtrurJK7am4AmxQVxkPPDKZA2oocId+uFyddAqdC/Uc+33CimYWJvhF3h37oYOQgKIkz5dUO+A5WDbGjWc+69hqRXvbrK9AjYNj+cvadewbGNXB+YRTIHqdeD2jURCjqx+1n3f2GEB0gTm17ZqN9vk6GW26fbdZr67n5aTJ8XD5QVKFae2jdheMXU9UAQ8BLQjZjKZ89O3O/ghNdgwfqZ/WLw3XUoTolHHNL95yA6UD4KOYLvGfgu/6LBeg5u0rNyXZb0jdDIskGAIt55TVh0em3yRC1Rl+bnYy8eavBUVbr8DcVdDDshBEPJS0onH7XUjrHP8yQeVcOCijyQNtwgd1i/uP+0pF3xHbnyHLdTfNjNplTt1/64u7ri6vcg3s0lLywKQNyteJsMnwCBnQq5AcKeHQ7Ac+e+BH5IYcRb+KQvtzW9VMhPqnJ1gMWncVmgYi6NJWLUlGYojpRtunmvVDRs3gHxl/bfUe40rz+C6RbGI0ZGgmLSYs6MVKr10c0M1L2Mv0Rr8XzWSKp1qokHGa3TCusLaDDPRD7A9P9C4WVQoxt1WMRtCG8KUYIkdEgz6lvgOk7HGcgd1/k3uNT1kifCHxf/Syjo+s4AO9i3oRVGcLpjK9PX0mumkFgw+BRoXTsfWuY4srlo9UBBEAMDF5OORemoYqmg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(451199015)(5660300002)(31686004)(122000001)(71200400001)(54906003)(6512007)(2906002)(316002)(6916009)(478600001)(558084003)(6486002)(38070700005)(38100700002)(2616005)(8936002)(186003)(86362001)(31696002)(36756003)(41300700001)(76116006)(66476007)(66556008)(66446008)(66946007)(64756008)(8676002)(91956017)(4326008)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?dy9tMjBhb1IwLzArUWdMUmlyRFRMbHlERk1FT296L0p6Sk1NUStGQkNEd0xv?=
 =?utf-8?B?cS9FZDNHNDVudVo2QXU1MGFUT2tvVklRWDdSTDRwY0hHRWczMUdMaHRsOHpo?=
 =?utf-8?B?V0FUWnIxbFR6aUJLTC9pZ3B3bzVMd3htTmlEblhkQlZ0YlVpSVAreVFDVGc4?=
 =?utf-8?B?OU8wVkFSWFBkU0ZWMkVCdXdzL0NNQ3cyMGhaVUt6TEIya3I3UlRydG11YXRZ?=
 =?utf-8?B?QkxFSjJEbGVBUTdiYU9DVEVMbmZLRmJSdlJNeHI0emkxUHJ1eDRTWUplbVdo?=
 =?utf-8?B?TFdOcnRBVUlPRm4vampVdWM5Z0dIS1hyL2MrTDhyTFY5MHhyZG50a1E0RU93?=
 =?utf-8?B?dDVwaEdaSXhxWklZaWZ5M1VtNHVIWW1FQTRCbXZOQXVHOVo2eHZEU1QyMXZk?=
 =?utf-8?B?Rk5JMjdidkZVb3ptcUZ1eEZLQ3RQeGNsejB0RnFuNkl6MU5oNGRFL3ZkRHNv?=
 =?utf-8?B?OXRFMjB6bjJnSnpMR3JtV3RvZkJiNElTeHVrUmpsRFUxZFdIVFVCYksrOHNl?=
 =?utf-8?B?QXJXZGZCZ2kxRG9YNUx6azFVcXpQdytacm9rT0FyejAxb3djelBOQUhwRWta?=
 =?utf-8?B?Wng5ZkZoajZVSXNSY2szU0phbmJUVzBFTWN1RVlIOU1HcU1jZjkyc0pxalBn?=
 =?utf-8?B?bGFjQVpsdXFTNkhuWWY3cUZrUW1kRy9HSGVhWlRidHVQRE5pcXZOazZkM3JM?=
 =?utf-8?B?WVdiQVc1MVlBMHVBZ0xxNmREOUUrVjNpeStocWl6ejBRMk8yUGkrL01tTUhP?=
 =?utf-8?B?VjNqNllaZlhDQ0lWOEtvenhFTFphVlE3UlBZbVV4SHprbXBqeTRiZ3FKY2RF?=
 =?utf-8?B?MXdhQ3RKcjhhWTZqeEZaVzJrVFp6Y0Z1MDJqUG1nSkN5MTdKdGswbkJqWHU4?=
 =?utf-8?B?dXBKUkRwMnBySi9aSWp5SFZnUy9qNVllbGY5aWp3Uy9KQW9nVVNFS3JUU1JF?=
 =?utf-8?B?eG1DcWJvYStEcG5PSkFVejV2V2VrUW13ZHp4OHFNTXk4eVpWZ0NQVmdHcTRL?=
 =?utf-8?B?Z2tGNGgrQ29UU2J5eVdQQkQvTk1TQzU2bjFRRWttdVBJb3hHNkcvbDhUK0h6?=
 =?utf-8?B?dFovSUl6Nm9wSlEyVCsyVnV3RnIzUDlOQUc4MG5rSlQ3S242MFRlMGNCMnpz?=
 =?utf-8?B?RFZWNnlzU1gycThKVWlLMkkzOGRxUzRhdTd4SDRZU0Q3QnRaZzVNbHZ3UGpn?=
 =?utf-8?B?dU9EMkUwcTI1OFBnQXFqbmJ5Q1g5M1FZczU2OXRsKzFJZENVb2FQcWdkbTRi?=
 =?utf-8?B?RHROaVB1RjlCS3hjbEd5Y0ZSRXA2REc4RVlvTElOMmlXMk9aZGlST08wbVVm?=
 =?utf-8?B?K2Z3U25UU2h0V3hLbklZdmdtak9rQjRrM1BjbnU0UTcyNVc4ZW1EaUNHR1Yv?=
 =?utf-8?B?MU1MWGlZYU1oU1A5azFmeGZvRmJBbXl2Y1JaSzVnZkVmemlXSVhwVVhmb1By?=
 =?utf-8?B?bzIveXVaR3p2eW9zTW02QlZnY0xtbXRnVmREbzI2RWtiZ0tpWEdCblpnMHlV?=
 =?utf-8?B?T0crWk5QTm1IQ2xuNUNmbDZmdGtkTmJLUkJkVU43ZGJQVitVck1yOHJmSm1V?=
 =?utf-8?B?Qk9sMTVYTXBJanVMNWNPTCtrYW8vRWY4SVdHM2M5T1pjZW5pa2pxdXJnSzF6?=
 =?utf-8?B?T1hvOGgyZDFFZmh3STh6Z2ZDNUZZbDNEcm9hSXU2SHdzc3BISVdxVDE3ZmN3?=
 =?utf-8?B?V2NtRUlqZVJjNjFldmZ6L0Z4eCtqM3BxSEJjZUhHN3FwbHJDZU1NbENFVGlO?=
 =?utf-8?B?aURQRE1YUjZENjNWWk9GaGx6U1RPbmJlc3U4UnA2eVRXY2M1ejZQL3ZLZzYx?=
 =?utf-8?B?V3ZwN0loSVBib3lvUE5TZ2tIcEg0VGs5a09zYk05RzVoYXMxTm1ISS96Skl6?=
 =?utf-8?B?WWRqZlZLajhYU2R4dlpIcWFpT2d6RFd4cEdaU2N6cVZKZHpmTVQ2VjJGeW1O?=
 =?utf-8?B?N2paSHJINlc5RGQ5UHQvS3VLbkNKOVVERnZ5dlR1Rm9EeXpUYnc3OTFEdDZR?=
 =?utf-8?B?OVhsQ3ZCaUpJc0dLYTl6S3dRelBua2Y3dVRSbUhNVFd6dlhoN2FPdXM4TzhP?=
 =?utf-8?B?MEZ6aVBJRlo0SFVFa0FSbTZ2UmtYNnNQNldUYytoRkFsQlhBQzhXUkJsNzhQ?=
 =?utf-8?B?V1BNZDRqZW9UeVZUQklJZlZnbE9COUJGdTBsSlUvRTdwc29DS3gzaXlDcFRt?=
 =?utf-8?B?NHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1A84674424E8549B7835CC3C1A16264@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98fbef2d-e649-4ce7-d7b9-08da9b5177aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 21:45:42.8375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QANXjoI7JZdC5H1df97p+4U3RrWjTeX7H6UwKuXt/NF9HHzYMNBvCe7PvGKskXvUh0Z7qykMaTDKjwsP1w8rwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_144546_340994_DD2EB590 
X-CRM114-Status: GOOD (  10.52  )
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

T24gOS8yMC8yMiAxMDoxNiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IERlZmVyIGluaXRp
YWxpemluZyB0aGUgc3FzaXplIGZpZWxkIGZyb20gdGhlIG9wdGlvbnMgdW50aWwgaXQgaGFzIGJl
ZW4NCj4gY2FwcGVkIGJ5IE1BWENNRC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBI
ZWxsd2lnIDxoY2hAbHN0LmRlPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRh
bnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0K

