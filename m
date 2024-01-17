Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DFDC47258
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 10:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lwSlx1gO+dfxHT8r2vsg1Tn5bAgWgamKaYcLSOSyE2A=; b=IMWfOBCc2EkxX4J9DDfjl1U6ei
	M4x2zEYmb3YItQWYVlScN5+eQ/2g0PtMSnDO/ESGMRbcrRUMqNPfmqrqXRYo7RQZap1ub0e2/UHFu
	tY0PQDecq/vfdurjxjUg5wOlbWQBj+CsLKVhcovFioYfqukBFun1M3a92HR4aSDI0WWsCQY69oC+x
	xIn0xo99SNniITxaPH8g7S/Jah1IJj3k63izZryoKrpblaw0Na/oZn3OZbreRJSPXJKHfRaEjTaPw
	Z2UOBhgEDZb6FdqPhc0BSRA5dyiL39NRy3abhG3DOhgjfJV+yOyyLge4xUdfcsYH8eDVIv7v+D4vz
	OWn8TYzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ2ne-00FD1T-2s;
	Wed, 17 Jan 2024 10:05:34 +0000
Received: from mail-bn8nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:2418::600] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ2nb-00FCzn-0p
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 10:05:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiwySiWizSRDLbzuTezQAYNMp65NHjGOTP1RvGOgzUxVetbMdmcF4GY8xShxGx7EoLm+ooNXxjPJJn083jX/rrIDEZh2RynzOBoEYl0DT+1svACFZ94xX5By3vecWGPVq7Z9DoVx/xvfTI2AsKRt7vmd9x2yVJlfyJawldjPIv9HzYWL78GIEUojz7wWdYBg9jcTxikQAseFrxqu168k+ORzTrzMctO3n5WXIv9kG+E09PqTp3eIcatIJXuNF2vdtb3qr7SDDojXdWTFtougocVVLGgyf+BfE4IYYcFQV9P4iPP93FkAtMf3TuZPtnjMvVUNo0ZnFUUs/E1uj8EhwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwSlx1gO+dfxHT8r2vsg1Tn5bAgWgamKaYcLSOSyE2A=;
 b=gxsUoUhUXy6krv81/WAxVyDBx76wapa07jvJWD/HRLfB485VDg5I6yZRQc0YoCYCQK2OggpnASJ0T8VvO/jfKP2nJwUJ0tlfuREhMEzHtezId5RljvYI3pRgAABPpfjIb8KXwNadqCqtycWLgceA803GRVJPky3Z6fJ+SyFhUS9XA04DUHsparulGF5ex+gl5PCAtMJ8kDKx9zsRZJ8nTsVYpEvrDqOImZTe2b9I3mZNAbDFYxBLAezb818RXTix9y0pVDb2NG2DvJ+USSoncm3F73B2KjsTreHQoauh1DwEbtOdyib+I/3U2Fy2OEWX0b5lUAOKqfIPRppgSw/ZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwSlx1gO+dfxHT8r2vsg1Tn5bAgWgamKaYcLSOSyE2A=;
 b=D5rzezOP84sRb25QDpFmno+qSlW/z/qbBNMdEikxVFjpl1/zmFBDYL30id26J0geEMZIZn0+3KfSGc7sqsRfM36VmqzR9zseWmNM5pmXW4FyZy3B/pnPlP7oIr7RyKAlCYY0pU3S+AJH+g8Y/3bn7ngAO4216eyfFUXwNTAu7bVJ1aIeRDrwSI8LqxXh1a+F0HRxZuW6eD8a0EAvmk8BxukR7bp0Uum4ocEqntJvZ3I500HvsmjnS413GTHZ7U+Hz8ngQY5JLtNzWYL5Tb9xEEx7dBQc6GI/WqW1Cv8fl+1N+ZsTAVUIpWNTq3bKATnBNYhsgHyQDRVW+lzhVMApwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 10:05:22 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::9fbe:fc95:e341:78aa]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::9fbe:fc95:e341:78aa%6]) with mapi id 15.20.7181.026; Wed, 17 Jan 2024
 10:05:22 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Or Gerlitz <ogerlitz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, yorayz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
Subject: Re: [PATCH v22 08/20] nvme-tcp: Deal with netdevice DOWN events
In-Reply-To: <f9e315d1-5876-49da-870b-a073c911df28@grimberg.me>
References: <20231221213358.105704-1-aaptel@nvidia.com>
 <20231221213358.105704-9-aaptel@nvidia.com>
 <f9e315d1-5876-49da-870b-a073c911df28@grimberg.me>
Date: Wed, 17 Jan 2024 12:05:18 +0200
Message-ID: <253jzo8uvfl.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0216.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::23) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM6PR12MB4356:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e00bf5-6639-4c41-1986-08dc1743d192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cHn4f0UpCTYg+gTH/6QBDA06VkE00jm7gXB+wohqE+6byCeXOHDIA0Wr36e6hDJZSGNLd9Q4FMgzPQO/zy8ddJt8qdotsTNHkSKONrB0NUw3CeMQzWKN5Vp+oYktyqSALAbKJJwGXpJfdHhh10EgkidF20u9qaV/EMlR8c06SkxQG4bxmLf0mFUKos6dqDQhaIDibIiZzpx0H9eI1ZrQguovpH4yEUX7Mim57iWhN5Pc6WaYNPmJf6a0hJs3PBZ8IneEXJwhd6uBYqVXQuC8Fh7cOfFki8GtexwlwH0zegSgAYDuPxv6QAB1GMdshYGf8UKitpj1ISR1Ab1qY/wBoYIZVaDsUTouya9ACQMfvXQa52/wb09RcVwrlvzqnNhFRGxqszZjOiM+zgYmROcen7wlw5eDgDYlR3oUHRCOYMFnn1Xumh6neX2Bltd2JFjtZe9ARHiLqzTkIssUhBuczQNVCli7XW20dtFPPnLl/fNpHKhysuWMaPO3aoBjT5FXUAk7E4DsD3fW0hbtswUJLaPWjnAONB1zZ/f7/ARHjWpMmWNvS6WiI4j63HDKaJBE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(376002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(107886003)(6666004)(6506007)(6512007)(2616005)(38100700002)(5660300002)(7416002)(4326008)(8676002)(4744005)(41300700001)(2906002)(8936002)(6486002)(478600001)(316002)(66476007)(66556008)(66946007)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0ZxavVNqBTS4thyKLZ16DFB1RHAu3MIrKmFPG6cUZg4rSI7t0g2S4VORvQ0O?=
 =?us-ascii?Q?knDBVj4zV4O8pwKHy7zVrEWYGBjhcJX40lPurXfaO6lAIb60qaLBn8UoPE2x?=
 =?us-ascii?Q?VLTHLD80Exv2gCcz2apnDQThB3KyxeruAKYomrc4DO7g/piwssefOYwShy+f?=
 =?us-ascii?Q?1rgB/hdvPQ3j0SA+CtOO+8az1p70tPkG8csA7Lagj+gnHtQnqBba+ZVM2uI1?=
 =?us-ascii?Q?yWqDHUX/JFZWaeNUXrt7HLE2YM7gf0xEFi1Uh3Ztbs+ewJemuD4Ht6Y/CW0c?=
 =?us-ascii?Q?AWeCmvkxvphu7ZEfBH0dSN+k9Fo6TkVCs7OdlpYFn4euZSaT70XWztt+iEep?=
 =?us-ascii?Q?qcSRpnzD/zwuafnLz1yPOg5dpt5yLLwoewzLKjatNNTKOEaXUZF84Yp9Fn2q?=
 =?us-ascii?Q?gu3+BPIbCq6FrXM2QVSzA27sjH9iULRYyFBVPfwPL2jMmEBS+uMki5lLlv1l?=
 =?us-ascii?Q?tsHyhJileMazo9/IaazSIeBnFfErH0wpneGuDMNwptW0WYDWIh5Vg8AKyn1l?=
 =?us-ascii?Q?9wDH1sh6C/AsSzc8/J5krZHPjni8oyUqvXwe6YL6f3hKP0PkLciW08laBmep?=
 =?us-ascii?Q?N/81E4EHgPsV8OtIzy4hF4csbrIm8D0TQ8SkzT2hvYmXz6w3Fxfq9cIUfQZN?=
 =?us-ascii?Q?1gnk0dPgizRi1f58tktj6N5df9euqZg2Fa0YKFIwCZfzOz7PppvhDEkV1cvz?=
 =?us-ascii?Q?4X8Vrp37H406KSPqAxu+AwPhpYtIVLIKikEwek/jNTihdZHcXpJvEnNeFlYZ?=
 =?us-ascii?Q?oobaPzzCw69IiWOWb1F5jp9UesDKZsnMd503DX5c3oTYc3qwg48w/m0GG3oa?=
 =?us-ascii?Q?pcQWutYsx8mpxMabu6L075QvqiTkltZmwBwf/vk8IxPtK24dKLUCXF8U+qLW?=
 =?us-ascii?Q?BnFNLEYXqwqfsKjwooo26lkFXXGx/cAGxORBZrbTT39XcCthUyllsI738hzE?=
 =?us-ascii?Q?EeA+8nFYSqBmQdEAJeoZnNIWqmzAMb+FFBUR3f+L2k/zfU3XJd/21X75UrC6?=
 =?us-ascii?Q?wOzGgFsKXhXyNXRWnxSE/slQbPN+7xNs7PioECZHosvmmqQ1KufyoOXuFLAe?=
 =?us-ascii?Q?5DCmq0Et6RCk0qv8VzYw8x9cek+v1KDKgLx3GF2KuMn+VaeQSelb7xpfmEWZ?=
 =?us-ascii?Q?3+OKkQzRYKvljUKDMIC1jxf/FMtvKQrFbdvuTaXVSBZ927fJ6gSF/RbpmrS6?=
 =?us-ascii?Q?jXF2UgmmqSEFhU68DgfKgPdyQ29D8h4EUkVAJterAeWEJzuxLpOEk0imBvxR?=
 =?us-ascii?Q?cTW4WYmUABPnjPtiwagYasBpp83/PVa9pmyX1W4tGp5NaYCNFifNZ0ThtWJg?=
 =?us-ascii?Q?BCvlaKtGYMB/lCg3KZBcF4XXGbjed7oNQBt+JOMEYsMGw7yiIHjsHjdTHzSr?=
 =?us-ascii?Q?XYaoNugPa8VlTvWq4FQKA53Zt4m3/PibyxlA0OkkQyOs/9m7vGfk9xEPCpqi?=
 =?us-ascii?Q?1QnXMMIl9DXZGEOi+SV/ofCmqiXSCHmOmnT5qq02qxsCsyQJWuiqf4FZ03WQ?=
 =?us-ascii?Q?VfxT2qktaVmzn9xrtVOobRcCrg9EIZtRpvCrE3ZwxWlqWZTV0wQ3q0UteiYc?=
 =?us-ascii?Q?OO5mWlZBtWs/goghfvJ9Q12+rJNGD+f4NNkZUQV5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e00bf5-6639-4c41-1986-08dc1743d192
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 10:05:22.7144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y7pHCIAIzCR/vsUUHDtzmr6Bkj6gf1m+dnnc7G8xUpW1EK6jonb5bXRvdaJvn8jhXBF6FkhHl76TGGsg/aiQqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_020531_377283_E7E03A62 
X-CRM114-Status: UNSURE (   7.45  )
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

Sagi Grimberg <sagi@grimberg.me> writes:
>
> Will this handler ever react to another type of event? because
> if not, maybe its better to just have:
>
>         if (event != NETDEV_GOING_DOWN)
>                 return NOTIFY_DONE;
>
>         ...

Hi Sagi,

This patch was already reviewed-by you. If you wish we can change the
switch to an if. Any other comments on other patches?

Thanks

