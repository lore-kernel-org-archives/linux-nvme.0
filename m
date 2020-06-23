Return-Path: <SRS0=DDko=AE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CC6C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 15:23:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEEE92070E
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2020 15:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qf+kMNVj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bt17IWgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEEE92070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7IkS8XaFIgC8Sk8j85DHvpEa9vIataVMEW/eje36+QQ=; b=Qf+kMNVjJ1fRUdat1lKYL3Jzx
	OZ5f5B4kA/n0f2gWOJC3Jv74v9Al9oSYjSfeYeKGeeCP99ZErzj7aqdBPFxuQqdtiISwZS+CZGBoT
	GfZnWkkyQTlXUkiIcMFuqSHMSnve93bv7MXYHLMKN6c6GJwT+J/kFjuw7/6FIs0gPFG5LisHAtzr9
	sMLJH/wIvmVg8MjXarToDb1wZxvMUsKKkzTxeaKytLxkQHEGiSDnMmYCFYTolB1B+6Ym41snlKo38
	rmJvlB34zDLGKYvR/K28qQpAwKHX3FHx49HnDmv1fG7Mz5tuC2M466K/XiJuYeOJAXQT/QJfghuab
	4coQjAQDw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnklI-00030H-U0; Tue, 23 Jun 2020 15:23:00 +0000
Received: from hqnvemgate26.nvidia.com ([216.228.121.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnklD-0002z3-OH
 for linux-nvme@lists.infradead.org; Tue, 23 Jun 2020 15:22:57 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5ef21e400000>; Tue, 23 Jun 2020 08:22:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Tue, 23 Jun 2020 08:22:53 -0700
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Tue, 23 Jun 2020 08:22:53 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 23 Jun
 2020 15:22:42 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 23 Jun 2020 15:22:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5/a0XicTRFDheo/K8TSTm0TFZDPeQOI0OmXRduZJ4ds/se4a6MklIIoWZf+v3lX5PeU0v6GjZK2NwRLDrks4azyfzZEATyWbRUMcUFP2d5trrEZLi3JVbOhz2oYPwO/n6nSeIWNZjAloAANgBjqm02CPTWcMLAOFO/oCFXuDPK9v69MKx5JczMCx5hDRn5Hd7VpybYChlgfPJNDD+3EYn42j+X0FrJEmgmSpUIQwSSDgRtbxPaAd52v7Pm/+459I+mkRt5UUkRwkMgj7xM392xPJXQYWqlOCDXg+teMd4EoHsbyIhxtIuJIyTq8IyfqNXUOgGWN/upC6iicgX/+nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lttfty8ENd8sCE2rqqMDf0g3Jod8o0E95UunPq9syyE=;
 b=DEt3+reMeu9EuujjwD2H/zrn+OtI7i8swi26eX4KxqBrBNskfX1mLdCShHm497ioPlknV/+1b8swZScoNNvfFUt1gGDI34OTIyFDSlXV0MeOz6fTs7WRAbByc4f/lA2MbD7CexiAovLo0upyFfELqfauiFgyQpz6f+o3LN+vYyQ+38xE39HJcFtNTxS9uPv5trFpYGYKvsouEidfdDElUT33A46RBS+fn54payHuIPyK/vq1YpiIACnXxF52rt2R1Crc9dHVZPEJ2iWcfnWhRh0aFhh8IdwEwbJkNl2HrIJZ848X75AND2Jq1x2nz3GVpvr7xnMBf2WJIOViP59HSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3738.namprd12.prod.outlook.com (2603:10b6:5:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Tue, 23 Jun
 2020 15:22:41 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 15:22:41 +0000
Date: Tue, 23 Jun 2020 12:22:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 3/3] nvme-rdma: assign completion vector correctly
Message-ID: <20200623152236.GA3072004@mellanox.com>
References: <20200623145525.1586-1-maxg@mellanox.com>
 <20200623145525.1586-4-maxg@mellanox.com>
Content-Disposition: inline
In-Reply-To: <20200623145525.1586-4-maxg@mellanox.com>
X-NVConfidentiality: public
X-ClientProxiedBy: MN2PR11CA0026.namprd11.prod.outlook.com
 (2603:10b6:208:23b::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by
 MN2PR11CA0026.namprd11.prod.outlook.com (2603:10b6:208:23b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend
 Transport; Tue, 23 Jun 2020 15:22:41 +0000
Received: from jgg by mlx with local (Exim 4.93)	(envelope-from
 <jgg@nvidia.com>)	id 1jnkku-00CvE5-AA; Tue, 23 Jun 2020 12:22:36 -0300
X-NVConfidentiality: public
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1680cd65-325a-4b8b-b72c-08d817894541
X-MS-TrafficTypeDiagnostic: DM6PR12MB3738:
X-Microsoft-Antispam-PRVS: <DM6PR12MB373861F16C76C1F3519E1B39C2940@DM6PR12MB3738.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPSpoY4Gd2HrP7aFzKmSYhVOC5VUxKzWf+ulOBiSR5Z43Zq3Wyej/IvZNdZ9OLPexAOyZ0bhIM1cpOC6I+2Y+pBtZGJNkpHauHM2SWAZRVwOQ+dHfmnXsPuXMqUtcWlKluxOuVCY9vzF/E/OQUjWGKNUx1xifPI1tBvQGb+NHJeuWrqLiflR6T3VydQOtwqPIb9WRQoqeSGtiUvCwT/TmXMX7nrtHa9UVmpOaSDWlVwJHnt9y3oeY1+OmHQsiAmS1a1wl1xiV351m6E5dFSvV1UUNRPxKd8QnDvvFD5+siIl3Q8/AofEetcpYC2BGux3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3834.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(346002)(396003)(376002)(136003)(366004)(39860400002)(6916009)(2906002)(9686003)(426003)(5660300002)(9786002)(66556008)(9746002)(4744005)(36756003)(66946007)(66476007)(478600001)(1076003)(4326008)(86362001)(33656002)(316002)(83380400001)(186003)(8676002)(26005)(37006003)(7416002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: zN/o/1q5p2K3ZR6al9MX2bOWIGWycbuZs6FVogqI646A5wZN8sg2LA6T/X4NEy0+0wMzWEvcp9ToiEmZOixMP4FwSy4svfZ3+Ivbo9VlSdj4xUjIvKoete2xtFBBrMkLWmSosleJdWXiIxt7DZKjGiDMrKr6WNAxCa/mxBkJkHNAatX937GXLWG7mbmKljVIsc5vpx5Lj8KvizTQ7TM+kqTf+W1bkyoocRcLrM6buAVuqLjfzUbg3r+qu2oiLUngSs+5zzmjzuTUelJ2yIfE7Z8C2XppsGlgP+o7qkDHV5PeHbV9PakYcEGqsaIlmmAerRw2mf4OA3Xpc2RGe5pS/rAj/EbCrdQsl9NH0RVo6CdiyTak9B16FHp7A/o1CPox85Xmgy+lySSIq8CMyNO9m/FrwZgNKgsBpiKhxm/EIBYfzE0qDKmjlUtAu28Z0b3oEa+wfia9QpvmDs9QAQ+QmUBP/fzRuqnaGzmLn1Wh6WM=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1680cd65-325a-4b8b-b72c-08d817894541
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 15:22:41.4957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /X+IeWPgqPr3wE2UNhSb4SeEVrYKE09E+IJf93BfhuhQUatE4xR2s1DWeon4SvYo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3738
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1592925760; bh=lttfty8ENd8sCE2rqqMDf0g3Jod8o0E95UunPq9syyE=;
 h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
 ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
 Subject:Message-ID:References:Content-Type:Content-Disposition:
 In-Reply-To:X-NVConfidentiality:X-ClientProxiedBy:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType:X-NVConfidentiality:
 X-Originating-IP:X-MS-PublicTrafficType:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
 X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
 X-Forefront-PRVS:X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
 b=bt17IWgNpkCiucnPRliKM+rTF8KxMeJBYMVoBZ13lOy4AA7VJwBrExw/yoofr7tWJ
 MgMZpt69PbrjdOHX4CY70uQdTUjLBM9vDbQZNtRFf56PxApcDelSLkoRDqj36D33Be
 T2z2Ki6+TWu2Nm2uPU5zmCWEDwq0Wk1xeZdFY0IaKdHwbFi3vKLiiUqGSUgAoILszy
 sY/9Xa3Ae/iJ6nFFhAw35xw9yPk+St89tFfP8vil+1Bmr3O5MiZrSp5e05tAGvR18E
 1E2BVwauEp6r+KMVhlGbnMeg1c3a67KOGGK3vWqQqPrsc+QEkkxa1ZAbvzDi4ULSE5
 kvHPbjmabRd9A==
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: yaminf@mellanox.com, sagi@grimberg.me, shlomin@mellanox.com,
 israelr@mellanox.com, linux-nvme@lists.infradead.org, idanb@mellanox.com,
 kbusch@kernel.org, ogerlitz@mellanox.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 23, 2020 at 05:55:25PM +0300, Max Gurtovoy wrote:
> The completion vector index that is given during CQ creation can't
> exceed the number of support vectors by the underlying RDMA device. This
> violation currently can accure, for example, in case one will try to
> connect with N regular read/write queues and M poll queues and the sum
> of N + M > num_supported_vectors. This will lead to failure in establish
> a connection to remote target. Instead, in that case, share a completion
> vector between queues.

That sounds like a RC patch? Where is the fixes line? Why is it in
this series?

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
