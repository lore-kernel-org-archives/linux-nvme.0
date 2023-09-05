Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CE1CA101C
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Sep 2023 22:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JMieINGmKcY8Y6MtZSsOvgEMKQ+EWWaBC/gfzE0ny6Q=; b=VaUekoJxFmzBPBocb+Ip02RXWV
	WsIy6zoe+b4RntpbAM4vJxfa8WXlG20MXc+G95MGp3iHFL5I25y5onyXc6OLvaoGE+uBzpCcVWwTJ
	X7xqHl6F7cgC1jq5pWhwficEA5egf96Z+/PjfWjV9fshgxveHIjTHr+gX626/Kg9ZYj55ZwsB4zP6
	eDnp0ZvFcWClwV1t/t1n5kDkv3jsFIFJivSfRZjq8mQyrZXxLTKOBQCZEvp6OYjJWrzIuqGnIoPN4
	+zT5ojr5nlAEo7tiHBk0DA5/aodncdMHrUvvaWNJbtlediil2O6XNYui5Uw5nTWCSg3M+Rqn6ppjm
	b+YHrnbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdeKn-006pHK-2R;
	Tue, 05 Sep 2023 22:15:45 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdeKk-006pGm-2F
	for linux-nvme@lists.infradead.org;
	Tue, 05 Sep 2023 22:15:43 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385M4owC020987;
	Tue, 5 Sep 2023 22:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=JMieINGmKcY8Y6MtZSsOvgEMKQ+EWWaBC/gfzE0ny6Q=;
 b=s+lhPEkYzzp6ynH8EMgR21zsVm/YNYAFwvqyLCGdV7dmnCPdcPmgUVrMfbXwNMMHU9oj
 2GXdWa08lsy3QQfJmefKHjJJROy+ghjySn7xpx4kP26zP5DqVkYK+/wSJD7sl+MqH8dy
 VFdqtC5ApeeEx5lqXcquJiZo3bgZ8Dub/sF/qaR0X1TCcn9hIX5rUlzKlTUOH0jd+VtY
 mAcd/mwGLR+PgA8/aS5E7p6GXHH2yC5hDLYuJfuYOGwOocNv26A6tFAhHpIZgngi75c/
 q44z8aUQEQwFJWRCxAqkDF6wB976c0WLWzkKUlyevgDqUFLlqmjAc+VAC+zss+S4hMal 1g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sxctfr0s1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Sep 2023 22:15:38 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 385MDxcv037114;
	Tue, 5 Sep 2023 22:15:36 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugbmf7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Sep 2023 22:15:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9kckTyrrEIXViZ2BmJCWg4jdW6FTo/qndX+ZiVsVvJtHzSgX55OnTpkS0gbm39PKD3QkFPEAoytWua5ggCoslVa7rKO4asC8nfAOY/ZqRoAic7Xub3c06Xu8H35j/HMujvQ5xqVP4MmxONMr1kPZJQI3k6C4MAcTg149IMR/I6O9VYaY7lMMU6CQcfeYgYeWtf6Af4+QMzWv9xCWcnZPbg7S2dnowZsCBpu+hqR/Ta1FVoIpoUr1F8LcpNRjEtWwVb1/3Xr7s9qddBq3QsbQW3MJEUDuQeYMoaOvTo+9JVRT0KqxXbaKg6Pt/0Uyk4fcHZ/b2blkV+xTsT+oh0DNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMieINGmKcY8Y6MtZSsOvgEMKQ+EWWaBC/gfzE0ny6Q=;
 b=g0DsqnzRnEhoc9wWe1pAK5iJ/l7DHx+x+/lsfTifr+wWa+ZEpCiib121ARhc2+9meqcHJ/6LYneNUPYwWCJ+08q0MTdR5cAHFlkM2QCsnRYJmXOzS/AxvXhoF2S/paV8HzMy5WeMCGwQgUXYYX3fxwglWq7EXu5ypl0dOe8f2hHF0KXiAqHBci8bAAtQWdK0LHCA1jMGO34vv6sF36I9tUJDxCyYIPRvh69Es6p3c1pytPEibp/e2/zoV1RXprGSn/omGlcOnT1NUwolu5eyfHBZUf3IX1l5r/H7Gyd5vZtUYpUmdJZUvcd5YjXiz08KG0hGett2ZQf7O4AC5KhEhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMieINGmKcY8Y6MtZSsOvgEMKQ+EWWaBC/gfzE0ny6Q=;
 b=Whq/3dGy1AZqsBWr2WLvGm2ObsEdKWjV+aCkK7PViqctryXVsHmckqmmFF/7M5agCdBj6toDcSVAO3ZT8hEJqrtAac9dQrWWzD2H4JEHY+/yHNVqlKx/RowlUJblfbPMtP+zv4j/VcRA+v9G/8iIOlO4xxQh8fFKnUhNnT6QjX4=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by PH0PR10MB6436.namprd10.prod.outlook.com (2603:10b6:510:21c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 22:15:34 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::621e:6687:d842:5c64]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::621e:6687:d842:5c64%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 22:15:34 +0000
Message-ID: <9d199a50-9f0b-a69d-4061-d443e6286dba@oracle.com>
Date: Tue, 5 Sep 2023 15:15:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH V7 1/1] nvme: allow passthru cmd error logging
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kch@nvidia.com, kbusch@kernel.org,
        sagi@grimberg.me
References: <20230831231827.3896883-1-alan.adamson@oracle.com>
 <20230831231827.3896883-2-alan.adamson@oracle.com>
 <20230905065348.GB19754@lst.de>
From: alan.adamson@oracle.com
In-Reply-To: <20230905065348.GB19754@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::17) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|PH0PR10MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: 91106ba5-8259-496d-5c20-08dbae5d9fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hS0iYOBbHqYPqpOrqKxS71dFoDQO5I9oXSghCgD739Mj7ZzxoIYemRE6rBPgUiJfimPSXK3HqQoHw9Zr4G1JjtpqUCd7+ZhG8RStO3uJU7eIVXdMcW6SOViE7rsMIHztO1YgOQHuCeGv7g3zww6Q82w78JrSXuZPVIWf2CBwMwFxsMeNjxQSIr6TEYgIK7XoM9LYifBrmbtTiloFlErriJPFcCfbupvhEP7mqcv4ArTycvg1pu4eLEXKt3L92Uf0BlIH1VXgxELxH4QjNfFJYvm8iwXcyIQ0efiB3uTN+RxMDvHKu3d/oRHvY/V1dLDNYHVn/fA8GWObI/KiQ7KQUiMIyX6OST7XrtiM7/tJ5AnZ3sIJ8MQ309w9nyN4PbaIyipChjr7yomsL++CM16tNTGMZTXo2dAaqpXvHRGZfrYYRNoA9wjHJkXIPaiig97n2lSWbdw6WknEFWHj+d2wkgJLq214mqWzXbdcL7CJOeEtVD6zdOHbQOQGZLPMF2II2+TXtiSznz7vDz1YdMKSV6ivg7lucfWePkim4VDoF97hsfddQBTnm5k3hMboHZzAWiFu7mouoNZvn+0QWz2kfWu8+ZV2gcaflW06x3jaKcvElnAHGkPpXCgYScwt+pUF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199024)(186009)(1800799009)(41300700001)(83380400001)(8936002)(478600001)(6666004)(2906002)(66946007)(5660300002)(8676002)(31686004)(66556008)(316002)(66476007)(4326008)(6916009)(9686003)(6512007)(53546011)(26005)(6506007)(6486002)(2616005)(86362001)(31696002)(36756003)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGVPZzE3OE0rT0N3Zlh2QkxiK082MEw4Yi9ZRFpmeEE2TERkTGdGaEo0N3NR?=
 =?utf-8?B?TUtENVduTEFGYzhBc0FIYjlaQXVYVk5wNjJ1dmJQUXpLdEFzanFTR1RBNTBa?=
 =?utf-8?B?RmJ6U1ZrOXJJWFc1OW1VMFBxK1kvcUtvRFMzeGJ5MC9aN0IyY1g4NG1BSUdr?=
 =?utf-8?B?Y1Iwc2xOc1dyVW85Yk1TUlhOallTWHlaQldHK3hCQ0k0OTFkTkVRc3NaOWpL?=
 =?utf-8?B?QTJPd2FiZHBjcWZia0Jma2Zzc1ZiMFo2U0ZiYTBpS1QrdWlmZ2x2Vm5uUkNP?=
 =?utf-8?B?OHp1ZVNQQVg0MmpndWdOWksvRTc1TmdydW51TWhHUVJFUlVHcFh6enJDOGxp?=
 =?utf-8?B?QjcvUVF5cW03eFdiZDU4bVBGQmEzNlpWR2lkbUFPblJkcWRYRXdBVUJQSXVK?=
 =?utf-8?B?bnEzV3U4cEsxVlJKcERQTVUzWFZCSWF4RDVRWWt2ZW9XRTBWblZWc0pGcmdZ?=
 =?utf-8?B?TFJlcEc4dnVEazNCVmg4NHFVTnExdkI2VnVXSWV0WW8xdldxV1I1S0JBdEc0?=
 =?utf-8?B?QzVraXpvem9oVTRKWnR4aXgvNzRHYXBoTGw0MXNrKy9JMVlZZHdIcG1aVGY1?=
 =?utf-8?B?bTRhRjZwblNNeDNwN2tGTi9NVXFHYVFsZjZ2TGVTV2F6M3ZTbTYvb0ZRSHlH?=
 =?utf-8?B?S013WW9LcXQ4c3liTFNkQWZkR0RlOG9JclhtaWpiWkc5MGVDZW1CRy9RY1B1?=
 =?utf-8?B?WVBlYzRLbHVUMGZvaHJQa0w1Z0RqalVqdEpOSzZ1MWNmZUFTNnNYc3crK3Zz?=
 =?utf-8?B?dUw2WGdvZ1lycm4wYXFJYjN3MjJHT3V0eldnT2pEeTFReXo1QzQzYXAyZHNv?=
 =?utf-8?B?Z2gyVnFETlpIY2ZMVlVFSllYR2NnSjVMTkdWSTZ2eklDT3ptcmtiUHRETVox?=
 =?utf-8?B?cGFpN0p4dXo5SnUzKy96ZHdPSXU2SVpHekZIbGEzZkUwUHB4S0RTMHhTcW1N?=
 =?utf-8?B?Sm1wS1p5a1o1WW10Y00wU0UvcFhxUU1CdEFKQm1lWUJKNW4xSVFuNU9HZG1K?=
 =?utf-8?B?YjRPYjFEcjZSWTRSQ2lXdVVLMTNKbmtuMHpSclVWNDhZMXlWd0lXc2JIWHVi?=
 =?utf-8?B?L1lSdkJrOGJIaHp0UkNPNlpmOFRWWjRTMDAxUlgwQzBvc0JNUzNCa2ZmS05V?=
 =?utf-8?B?TGNzRC9NN2s0RW9EdndnR2pSclM4WWtwdEMxV2R3VlpnQjZmOGNyYjlDZmZD?=
 =?utf-8?B?VmFWUm1TRkZ3RkxqNzdQUjJHOExvd1BGSWpOTVdjNkt6UW1nTk5LVU5yUlBj?=
 =?utf-8?B?eEtTbVE2bzNiTFJJeUNEY05mVTVrbjlGcmdWYytjNUN3aWZBdWhLVWdyVmwy?=
 =?utf-8?B?U0IzdE5lQ2JGUWdTTm9WclQ5S3N4S2F4WWxtRGUwT0I5dkRlOXlsRDg2bWtQ?=
 =?utf-8?B?WWJSUjI3T3l6T2xpeVoyTU1Va1U0QkhEd2Jvd056VGsra21UUG5oenZYUCt1?=
 =?utf-8?B?b21NSnM4dFZFOHY5dC8xWEs0MjZGVUkzWWtiazZRbml1dzQrRm9uM2p3dGFv?=
 =?utf-8?B?UThwdjA0WGVXOWZoSDdwVXBVSjRRMk14NHRjaElrZ055VTB5TU9hb2xsTWlH?=
 =?utf-8?B?bHd2c0JHMDlmZFhhNEFURFhlVk1peTZHd2NQcWlEejRaa2FaY2s0eWIwVzRp?=
 =?utf-8?B?UmlUMVF5MW40VTZ2OSsyeE9SM1VnWnJSNUhQdnkzUUltS3AxK3JxWDUrQnBB?=
 =?utf-8?B?YTJTMGl2NmdmZDdOSm9LbWR4Um5iOGVleTVMdUFzNWxrTlpuQmR4S0xLYnFH?=
 =?utf-8?B?bmFJZHhUYlFURjBWZkJvWFVML2w4RlhScWtOUmR4akVGRUdLdWlkZXk5SDlR?=
 =?utf-8?B?bnFLTTN4NDdUbVBUNU5PK2pKWk5lL1c1WGVoSU15N2RkTVFLNmVBa1pLQUZM?=
 =?utf-8?B?aGlZelJPSGptODVoTVd0U1hhNTRkRUtjc3IySlZGUlZINGw2UnlDMFJwYTdy?=
 =?utf-8?B?QUhzR3ErU2dBaGRoeFNmbVZiby94YWVSdUhJR2YzT3RzREluTEM0Z3ozaDFX?=
 =?utf-8?B?SGI1RHlZNTFSN1VZYTA5aUhGNFJZRUZPYlFoOG5FckZydkxyZXRyVDRLblhl?=
 =?utf-8?B?enN6Tkh1dmdKVFdvN1VsMTdQVytiZnBHdTRKR2hBbW9NNlhINE12Zk5jT0Rl?=
 =?utf-8?B?Q1VRNjV1Z0RKbUNBTjNvb1dHT29qV2wyODRwcGcxSmE2cTZmUEtuR3VBVUhr?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fwV3NWYfxgoBHxwX5ON//3sJbTTy0/zszrbqNuc5jc2/Bj4nK2lZ34M/nE1oOIsMLcHOJj7WgGlzji9+pP8V8PsrL9YJjvJBjjTYj6lPIMdE2pn2Yxr0/fSgJIzOK5FWzRq07XiWk3L4dXzOvQ1mkuQrjhYcxk4jAUW5+USW8gGs6cLsFsf/WKyDQW49A5uKBYFXiIgEDUjA1UkvEnluZMFYDNzV6EvFO2BHJFpM8CAdkjlZGPpt+S1xoWYLjAxl320Sxi9/qSfvIJNwx37GU4yo5xcncnpuTZBBB2edPxUHVEaZYNhbmi5Ts0eltB7Ah0PSNJk2AUSnFasDGt6tSYBezy3huFTskQM2349/JJBgFOx4iPb2mCU4SF01JyvVqO+nbg1r06UwMZqMVRglMqbiDLdV39SzRSRJMdBJ3e7K8RotK40JqqHmYFl923wGEk0VqvLsfpxbWiUOgVk+dNfAUv0vozZlz2hHPa8zyX+0CXJEnbOIRpSFRLfs4XJG144RpKcdqD6cuHd36ZR7TgczxfRsW1perwigVXDU72cz4YYYqX8qMHnnjRNbJWr79ShNMUdI4JiM1IEXpqSmL8zLFxNt+T6Nz7K/ewjODKXUqA4vxSYs7fgTSjVINNPbA65QM8tZ7xLiripjlWQ+me6I1wRXLLtP62v3NPWE9NQe3FhMQWWspnn+p8zPCYNMYjJSwh+UneLhafdXmSnTRbbqs4s8d5VTWgP43qbdbAJVOQ1A0PsYwifHe3OeiPNuqLElm6RVV6R3Ub+hfuQbUMflyC/Sac9Ono6oEZA4xKcTw682tCGO38u8SSiGmIOe8Jfjuhad/zqfx4PcN5riSYdNyvcvIZbFn4MF8K7Pt5BjzNrHwVza1EX6ikotrOAr
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91106ba5-8259-496d-5c20-08dbae5d9fbf
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 22:15:34.2364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVvZsozZb0OGg/9Jdxa8cYXOXYMiqSSm2dErj+96jSiwcXgDQa8HnX1aeXMnswfBjmH0IeWdzD2Vl6CzG8BW9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6436
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050193
X-Proofpoint-GUID: podtap7YvFX9HtmCox9ZQ6QXM5SNxWCg
X-Proofpoint-ORIG-GUID: podtap7YvFX9HtmCox9ZQ6QXM5SNxWCg
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230905_151542_748977_B22B995B 
X-CRM114-Status: GOOD (  16.34  )
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


On 9/4/23 11:53 PM, Christoph Hellwig wrote:
>>   	if (req->q->queuedata)
>>   		req->timeout = NVME_IO_TIMEOUT;
>> -	else /* no queuedata implies admin queue */
>> +	else { /* no queuedata implies admin queue */
>>   		req->timeout = NVME_ADMIN_TIMEOUT;
>> +		if (!nr->ctrl->passthru_err_log_enabled)
>> +			req->rq_flags |= RQF_QUIET;
>> +	}
>>   
>>   	/* passthru commands should let the driver set the SGL flags */
>>   	cmd->common.flags &= ~NVME_CMD_SGL_ALL;
>> @@ -687,8 +720,7 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
>>   	if (req->mq_hctx->type == HCTX_TYPE_POLL)
>>   		req->cmd_flags |= REQ_POLLED;
>>   	nvme_clear_nvme_request(req);
>> -	req->rq_flags |= RQF_QUIET;
> Isn't thisw now dropping the RQF_QUIET flag I/O commands that we
> previously set?  While we're at it, why do we only allow passthrough
> error logging for admin commands anyway?

While working through this, we decided that for IO commands (passthrough 
or not) error logging would always be enabled. For passthrough admin 
commands, error logging could be enabled or disabled.

Alan



