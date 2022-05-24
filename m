Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E37C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 20:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k9t5NokYiKrUqxzgT+G8fnJSCKOZf5H2qo8Fw+y588w=; b=LN09k7WpNnKsi5R0vwA/X6/EDB
	pRgf6kNaAV89gbsQI2eMsXGM9bahSs0uGJ0sBCg/eQ6Lu71pymo1F/evf9C4i5K9rz649nmwssiej
	CjZRIIfpfOHKEfYy7F8SBzV8SDd/oPyp5jKM7DRLlCJ1qucpTfGIavvpnuV+22s1q5Gv/kaWSTxM+
	/a1e2+zJRzXoiGS0YPAqGwZprZ72EyS97YVdfjLF36najLGfZ6tgxTnoZx4HNWOoRkPaFSEweAKUz
	HKQktTNqh0ESryJzQaQcbBdi9aBbdYAz/MkEsMSLgjmlr/tuA+WjeYjNUgZFagyKPH9A0edvnRS9r
	AJEaCmnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntbXt-009B4g-99; Tue, 24 May 2022 20:54:25 +0000
Received: from mail-dm6nam10on20628.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::628]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntbXp-009B45-H7
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 20:54:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4NKeAFpNJ8N9fWvIBu+h0UTPL6u+fhKU+mxPqdGmE+xc//T7G1l7n7Dpw8DTxownDbAGzoPma/ljwJVF9ifANvfOLuEW9Ebn8chMIZ2uEzt00cg0kePTkJa0yus0mOKFF3a/qGKNwxexozm0uFBEfied2boWzYK4O6+Kxyozrhc48zgbaK/YxqPVIuUdVzmRO5FIAHJqjh/DzMuRoh7i/hKopEncYaXquXQg0CAb1XsmQelCikNAPJGenOAN4LhQmYpKtqaAORHOXwdFFHSxiaATgSSVJ1fVxMi7qVIl2dyknbyM2olMOZ2/c78wx0/WqXeUNgnMrvbtGciCC9xdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9t5NokYiKrUqxzgT+G8fnJSCKOZf5H2qo8Fw+y588w=;
 b=I61SQHX9sHVvPI2uN/9qQXwRdACSduHs4ZgtLE04Nfy44I5tvPyT+HrXWZKpgT1RVu1teFV5wlO9G5eivUv5xrJQGZPxQFXDoNSWN1fqBA3yZC7ZyPTBwhW02tXNsFlnsNA4X/JLlhFDugpBJZNw8/Q/KxWio1fkaQszJF80dilM102cumaqAj/qCXdkfHIKcKA23XWfudlXoqVQvgh7pJJ2X9/s8mmijCAt09C6gwQWmI1amRInQy7lFYsxY22ZfgZdPgw75lcvXFtFiQUsN39pb+PCKPPl5802K02o3Vu+QWQ0KFTSY6WMSbQgmtyFHgsI3+x9Mx7gjSW3yW38ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9t5NokYiKrUqxzgT+G8fnJSCKOZf5H2qo8Fw+y588w=;
 b=YPpylFUrTOy6nFosv65exDvHoU8T8tpgGgzSTl6UNWQ5aquZ6ivKI91DxEBLZeIF4pFQBMK/16pXwEMmAkex49utNcWE+jnb0Szd72FI/cr/x6UilUHjJetVdi3+seshXkOVDd5H/8N1xMr1TEClRgvWp1Neo+Lilk+3K6S681Nt4iKPi4fHJPFXZ8Tq63hljXvUydOqRS4R1aEyHR9V3hvq/rBrk9Bltc9K08bkLo7FIx5XfX8xa4U1IxAJ5Ggn16vrzVpBrnIt6g2Urk2gTfncwdULX/egwF1zR6cdnVK+YZiE22x85SjR9B4Z7WDWSVXGvP5Yhc8++lrwdUOaOQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Tue, 24 May
 2022 20:54:16 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d9a5:f1df:5975:a0d6]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d9a5:f1df:5975:a0d6%7]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 20:54:15 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "hch@lst.de" <hch@lst.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "kingtous@qq.com"
 <kingtous@qq.com>, "sagi@grimberg.me" <sagi@grimberg.me>, "me@kingtous.cn"
 <me@kingtous.cn>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "axboe@fb.com" <axboe@fb.com>, Arman
 Hajishafieha <arman.hajishafieha@hotmail.com>
Subject: Re: [PATCH] fix: nvme_update_ns_info method should be called even if
 nvme_ms_ids_equal return false
Thread-Topic: [PATCH] fix: nvme_update_ns_info method should be called even if
 nvme_ms_ids_equal return false
Thread-Index: AQHYSvSIWnwAnv1IvkSNjN2lPaUqXKzleneAgAAR9TaAABoRgIAAAvKAgAB4aYCAAAzgAIAAlTaAgAA++oCAAEragIAC7DmAgAAB5oCAAAMjAIAAiZeAgAD3HoCAQU09gIABR7gAgAAykYCAAEOzgA==
Date: Tue, 24 May 2022 20:54:15 +0000
Message-ID: <1ad109c5-2701-ba82-223c-a94e74168d73@nvidia.com>
References: <20220408160424.GB27746@lst.de>
 <21ac620f-d234-13a1-0de7-e3ec1b3272db@kingtous.cn>
 <20220409044351.GA17212@lst.de>
 <33f34253-4418-e16a-89fb-92257749cf3f@kingtous.cn>
 <20220411054945.GA14311@lst.de>
 <dc6e8c8c-7eaf-f502-207c-4907ce58a474@kingtous.cn>
 <20220411060746.GA14519@lst.de>
 <2c504d2e-5c64-72fb-c26b-e086588ecd8d@kingtous.cn>
 <20220412050441.GA5311@lst.de>
 <741c80abb8a443c4745f213e9ecd413f6a6a7467.camel@hotmail.com>
 <20220524135058.GA31121@lst.de>
 <ec28f450c70d368999df3221ef7c01500fd5fd21.camel@hotmail.com>
In-Reply-To: <ec28f450c70d368999df3221ef7c01500fd5fd21.camel@hotmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f8a19c6-70ec-4925-25a9-08da3dc79077
x-ms-traffictypediagnostic: PH0PR12MB5647:EE_
x-microsoft-antispam-prvs: <PH0PR12MB56479CBD1BE5568D691A9F95A3D79@PH0PR12MB5647.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DpHR75zOU14kW61VSl9dnL45Rj4RW/6yM0+R+rRZ1XonzKh6sXP+gv8z8vAu8eqZczeTphJlFB4AFtzXqL3M+MAeN5vPiTiHpi3/ZwchtXAuR/xty+li46Z0YJXA2eYDjmqHH9eE820KJ+XAaVZtUFNnhh8EOhkuAyziBNcSWRiQRGI3bOOp7zP2u/k3fbPjW24r58Qht6ujhTfTjo5vuHRiXAcR6LJ+eXKsHZMAtVqOXzmJiyMWuQlH9bvFL1ykdJWqlOKYW6y61LbIx3ooafFYsrF9SXSd5hk5gn5E7aRpfdnNZCqFfTngx4/loBDCJ69t7QBe28QyDfzVmyEo6Zq26H0l6CQ9ZLEaP2U1uXX1Di20HIHDV9OHRatadgT5RlsR8mvzhCG6WoIjyOpvPMaWaiRYxFFsI7FKrbzem2daAwxZtprkcExXaBDPnspmdyx8kOshbKRqFgrLx4IyCijkxhwOjTydKvF3KUer2+J8hYc5/+p+mNChVugiAMeeFSTeerWd3afpMYBQ9ws2VcJPGjksDjC9oxcwqdBk2lyRkhTf6xpsc0pB0gWyEW5YlLWq/cQxHNAVI7dv1AG8jKyDNUKY4TudIMZH3ACfPJAqnRQVfK5FDp812BkH4zOjpEVRVKhdMvpGkOboaKYrKmmwf8Wyc1JB9Y7nOifU7FbOHzOWdZC99Z5CjlA6gcYzGXUB/nRbhLPsEArDn7b3npvNFRDjbH0WKo4g9qjCkWo+8akIDuGARMbM250+1oLxyDnNQXEdU4hQ0WZ7BMcjnQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(36756003)(71200400001)(508600001)(6486002)(2906002)(6512007)(5660300002)(31686004)(6506007)(6916009)(186003)(38070700005)(66556008)(54906003)(8936002)(66476007)(31696002)(316002)(91956017)(83380400001)(66446008)(38100700002)(64756008)(4326008)(76116006)(8676002)(122000001)(86362001)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alN2WlJ3dGk0aHY4Ym83ZGJHSUU5YXBHN2FBaGR2NTRBKy9nZmZqV0VDRXlj?=
 =?utf-8?B?OEUvNzllOE5OeDRxMHZxZnl3MFVBbW9sWHFQU254dFI3UE1rLzJtb2V2ZFZa?=
 =?utf-8?B?L1hlYnczVThoeVdRSWdwNitmUndqeUQrc2JKakhwWDAxVmtJaDVxdzFMNXlv?=
 =?utf-8?B?OGp4T3VtMXpEd09nN3pra0hKR2JiTlZ5b2VVd3JhMEcvVU93WFZkZTBndUZr?=
 =?utf-8?B?aEhQZUs2WlFBNUM3aUx4M2JVeWJDdnhvdEY0bzlxMXozN1V2UzJQNEFRaFQ0?=
 =?utf-8?B?ZkJ2UzY2cXpKRndNeHlybGttY09wdjU5VHFOVE52aFJhcExHSWtic3dCTWYr?=
 =?utf-8?B?dkFiRjBIMlBjazYwOXZBZE56TFd4d2xTcnhPRzVwTU9KTEhDY3VSYTIvUTA2?=
 =?utf-8?B?REtyblJCNXJkMHBMWFRSeStMaEk5c01uWEYyU3hnb05UeGZIc1VOUHJnY1RG?=
 =?utf-8?B?SGJVSktVSzJBNjluZ0NEQ0FpN3Y5NnpqWCtTYldGUHVoZzl5a0xaZU00THpH?=
 =?utf-8?B?YXBtdEpWVEl1MDhiaHJTbHpOUGtrRExGa3gweUZrNm53S1ZoLzNvSzB5djh3?=
 =?utf-8?B?eGhZL2VaN2FPZVduTXpFREQvSy9JRjgwL3QzZDlvelNNd2tKS3N0UUpwNXhh?=
 =?utf-8?B?a3hOSW8vaVEzc2RyTmVldktZM3ZGaWRZVUJud25xb2tVVjNhTlBOSzlYeXFZ?=
 =?utf-8?B?R24vd3VVenhmUEFTbUc5bFhnaHRMbytNM1h3VEc2am5uYkxMdzVWL2gyRlNh?=
 =?utf-8?B?a2FtZGpIUG9FZXhkRXRYa2dsc3JCVDNHWTN3OVZSWmxFYjQ4SDZ1enpqTm52?=
 =?utf-8?B?aU5Kb1ZOZ3ZaeGdieExQOWdYS0VQVHVtQ1F6SHJxQlVzcTVEUVcwZ3lnL21u?=
 =?utf-8?B?R3A3U1FTZmU4YzFvZ3AwUUVDaHFESGZ3T0djaWx2WWx4SXp1YVpmeERpa29Y?=
 =?utf-8?B?aUxhMi9qRXArREttSDNwQ3U3REhJcWtMb0xFaEVLRVdHSGZ5K2NDMEtHb1Jy?=
 =?utf-8?B?bTNFY1JpRHdONGRwOHRMU0R3aFZTd1FYVDB2bFNPaGp6akFMMnVmUWZ0ak9F?=
 =?utf-8?B?VnBwOGFIa1pFNmtPQmY3dm16UHNNWFQva1pjblJQaFBVa25MS2ZVNDJTZmh5?=
 =?utf-8?B?U2h6ZUtYRWVEdTdvTnNXN1R6V00vbnVWK3NBQWxvQ1RIYkhnZG5KajJuSFRB?=
 =?utf-8?B?ZmcxZDRQN3VCQnZlSGpDcUhZT2o0VXV2TXAySFU5VHNaZG1lYWszTzVEMkZ2?=
 =?utf-8?B?TDNabWt4ckZIU0JicHJ6azlGRS9oQ2RpVUxyekFiWFlLRmlLV2thQkFtNWFz?=
 =?utf-8?B?OVpVbWtVd21iY2ZiYWVaZnFQZGJydFhiRzM2WFpSRU15S05ZUHhITUlyQnF2?=
 =?utf-8?B?ZVJJQXk2VmFOTlpZZGpiYjZRaVhXcnd1TWRVU251N1cwajlUdkpOVU5tdHgy?=
 =?utf-8?B?emJSdzI4UWpnSGFVVE9FSUtzbDN3T2JMZmlTNWI1Tll3aWtydllTUmV5ZS95?=
 =?utf-8?B?VjlybzI3WHdxdkJoZUVkbHJyQS9Md1FhZWM0d3RwWWh3ZTRaL3BTc1ZlUmNR?=
 =?utf-8?B?QU00SlVvQVFDeS92NTlGb3k5MFRTUUdldGtER1lyazhxUFh1eFgzZzBuRWVm?=
 =?utf-8?B?cVBpaElnSWVsOTBDMXNGaVRRNzU4RVVaZG5CSzBhTGxXNWZxelNSWnZTK3FT?=
 =?utf-8?B?N0lDOFZ0R2g4b042SVVNZnRqT01sODViYXhNbSsxQ29ENlo2dUVydGY1Um5Q?=
 =?utf-8?B?ektpSHBNcUtDcTVsaVB1cjRxaXRveEk2UXFLZEJWUWIxa1RaTWM0dnlSUG9x?=
 =?utf-8?B?V1BHUU0rTmhlTW1xczF2QXZnRFpxQ0VsRHpqNXlFQzRsdFU5UlpOcnZpUVJz?=
 =?utf-8?B?dS9nbXRmaGN6Z2N1MUdzRFBOVkhRZ3ZLRmpMMlpYK2JodXl2NXE1NUNEbDB2?=
 =?utf-8?B?cHFzTklJYVIyd1Z4Z2pNa0Z2RHB2blJ2VGRDTkQ4NitpTDZteWRMT1hjVGM1?=
 =?utf-8?B?cU1ZN0VyS1NpVEN4U0ZrTDdpMjcxbE9ONjltZ3RwbVJ1MFVQYnJXL1BIdENm?=
 =?utf-8?B?MlRVTlV1SUMwb2JBVWYwSE5XbVVuUlQwWmxKbkdhTWxmRjA3TEdIUVVkckl6?=
 =?utf-8?B?TDhUVmludmY2YVI5VEt6ZGNVY01RaTRidDF4UmprTUNRMVMvblRNR3pPc1Iy?=
 =?utf-8?B?SlBTMzIwbkdSbHM4bUVVRkNZN3pXcnhBb3dXVjlUU0VxbTcrajRlT1ZHMm5B?=
 =?utf-8?B?c3JGR1ZjNlhUeG9iVHlDMU9BUVZURng2Z04vNWx4WTk2Sm5WRUt6VGZ4RUVC?=
 =?utf-8?B?WkdmQUhaQ1psVk1hUGFtY2tRa1dSRGdvS1ZNZjZpUVdsdEErWXl2ZEpFNDlP?=
 =?utf-8?Q?9piseXo+zVDmZW2Q1yqgC+DwU0/UFGdjDXCPc1CqYN0BJ?=
x-ms-exchange-antispam-messagedata-1: jVa7FYOCDtnRIQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <34BD93C029CE1B4186992962800F699E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8a19c6-70ec-4925-25a9-08da3dc79077
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 20:54:15.7391 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e+btGZBRvIdNv5XVUfjk+QtAJpp9BTgUNVE+d5NXPD3lmaiALbWepqC5MxAfD9JKCCFLMlBXbrxWTqy5gsr2Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_135422_045272_35E26343 
X-CRM114-Status: GOOD (  12.97  )
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

DQo+PiBQbGVhc2UgdHJ5IHRoaXM6DQo+Pg0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252
bWUvaG9zdC9wY2kuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jDQo+PiBpbmRleCA1YTk4YTdk
ZTA5NjQyLi5jYjRhZGMwYzIyODQzIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3Qv
cGNpLmMNCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jDQo+PiBAQCAtMzQ1Myw2ICsz
NDUzLDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkDQo+PiBudm1lX2lkX3Rh
YmxlW10gPSB7DQo+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuZHJpdmVyX2Rh
dGEgPSBOVk1FX1FVSVJLX05PX0RFRVBFU1RfUFMsIH0sDQo+PiAgwqDCoMKgwqDCoMKgwqDCoHsg
UENJX0RFVklDRSgweDI2NDYsIDB4MjI2MykswqDCoCAvKiBLSU5HU1RPTiBBMjAwMCBOVk1lIFNT
RA0KPj4gKi8NCj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5kcml2ZXJfZGF0
YSA9IE5WTUVfUVVJUktfTk9fREVFUEVTVF9QUywgfSwNCj4+ICvCoMKgwqDCoMKgwqDCoHsgUENJ
X0RFVklDRSgweDFlNEIsIDB4MTAwMSkswqDCoCAvKiBNQVhJTyBNQVAxMDAxICovDQo+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmRyaXZlcl9kYXRhID0gTlZNRV9RVUlSS19CT0dV
U19OSUQsIH0sDQo+PiAgwqDCoMKgwqDCoMKgwqDCoHsgUENJX0RFVklDRSgweDFlNEIsIDB4MTAw
MikswqDCoCAvKiBNQVhJTyBNQVAxMDAyICovDQo+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAuZHJpdmVyX2RhdGEgPSBOVk1FX1FVSVJLX0JPR1VTX05JRCwgfSwNCj4+ICDCoMKg
wqDCoMKgwqDCoMKgeyBQQ0lfREVWSUNFKDB4MWU0QiwgMHgxMjAyKSzCoMKgIC8qIE1BWElPIE1B
UDEyMDIgKi8NCj4+DQo+Pg0KPiBJIGFwcGxpZWQgdGhlIHBhdGNoIGFnYWluc3Qga2VybmVsIDUu
MTguMA0KPiBBcyBkbWVzZyBsb2cgYmVsb3cgc2hvd3MsIHRoZSBxdWlyayBpcyBhcHBsaWVkIGNv
cnJlY3RseSBhbmQgcmVzdW1lDQo+IGZyb20gc3VzcGVuZCBpcyB3b3JraW5nIGFzIGV4cGVjdGVk
Lg0KPiBUaGFuayB5b3UNCj4gDQo+IFsgICAgMS42ODQwNjRdIG52bWUgMDAwMDowNDowMC4wOiBw
bGF0Zm9ybSBxdWlyazogc2V0dGluZyBzaW1wbGUNCj4gc3VzcGVuZA0KPiBbICAgIDEuNjg0MTE5
XSBudm1lIG52bWUwOiBwY2kgZnVuY3Rpb24gMDAwMDowNDowMC4wDQo+IFsgICAgMS42OTYwNzNd
IG52bWUgbnZtZTA6IG1pc3Npbmcgb3IgaW52YWxpZCBTVUJOUU4gZmllbGQuDQo+IFsgICAgMS42
OTkzMzJdIG52bWUgbnZtZTA6IGFsbG9jYXRlZCAxNiBNaUIgaG9zdCBtZW1vcnkgYnVmZmVyLg0K
PiBbICAgIDEuNzAxNzg5XSBudm1lIG52bWUwOiA4LzAvMCBkZWZhdWx0L3JlYWQvcG9sbCBxdWV1
ZXMNCj4gWyAgICAxLjcwNzk5OV0gbnZtZSBudm1lMDogSWdub3JpbmcgYm9ndXMgTmFtZXNwYWNl
IElkZW50aWZpZXJzDQo+IFsgICAgMS43MTAzNjhdICBudm1lMG4xOiBwMSBwMiBwMyBwNCBwNSBw
NiBwNw0KPiBbICAgMzYuNTYwMDE4XSBYRlMgKG52bWUwbjFwNSk6IE1vdW50aW5nIFY1IEZpbGVz
eXN0ZW0NCj4gWyAgIDM2Ljk4MjAwMl0gWEZTIChudm1lMG4xcDUpOiBFbmRpbmcgY2xlYW4gbW91
bnQNCj4gWyAgIDkxLjAyNzc5OV0gbnZtZSBudm1lMDogOC8wLzAgZGVmYXVsdC9yZWFkL3BvbGwg
cXVldWVzDQo+IFsgICA5MS4wMzQyMDddIG52bWUgbnZtZTA6IElnbm9yaW5nIGJvZ3VzIE5hbWVz
cGFjZSBJZGVudGlmaWVycw0KDQoNCkZlZWwgZnJlZSB0byBhZGQgdGhpcyBpZiB5b3UgYXJlIHBs
YW5uaW5nIHRvIHNlbmQgYXMgYSBmb3JtYWwNCnBhdGNoLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRh
bnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

