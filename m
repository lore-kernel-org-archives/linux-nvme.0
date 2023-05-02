Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF28FC77B7E
	for <linux-nvme@archiver.kernel.org>; Tue,  2 May 2023 14:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vEFNRYOum5gkqgLIS7DDerU7xCMYeoBQDSzyv0+OTog=; b=JKYww8Ks8Y68Qznvu4EfRZywRn
	YQyNkZdIOHBbwHcL86xCcMFFkidtcdT2JBES6lQg6BVoNz1JYFnDvVBtKHiMN/cLBmEtN56SbCW5B
	U/g9tXfHWCChm5a3rSUUXeNDk0z8se6dMqB3yCexSX4UUubfyUK2HjT90sncFzy1vF+wvg6cT6RpP
	j3zU6EQ/q8xwNhEVWcAsbsFgY6DlvOj5qZ+SVbMaWn9jL8hiqeDVaLn3zlISWMS47ERB8CYxRw9R4
	XPjCHrp1c2vMgev2nrtXMJXJGWZL+wRGPS8jVG/MHh+jdQoSdlD7T2tSiY2Ffx1mOor6Znn1+Zhk1
	NUd/48xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptqpH-001nTB-0b;
	Tue, 02 May 2023 14:17:55 +0000
Received: from mail-mw2nam10on2061a.outbound.protection.outlook.com ([2a01:111:f400:7e89::61a] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptqpE-001nQP-2c
	for linux-nvme@lists.infradead.org;
	Tue, 02 May 2023 14:17:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfOsF7Z2HoKrFSYvPwiT9tVy4sEdVbTtir41msB3ybR8LIvMCChJ/TcylZuNZXUFNGJQCUQi1pSRZFt2kNRosi34SNe03zUkxmC0hegbHTYBecPqi4mkjZKOFIgo9iyujzx+T+Umit0ueO0zlx8g8IsF6cvLqAX8BVwx3QCqhEzrAdiHMnNHdfZjnVC360H6sxooEyCpfPGgEo/mPWO16sT9WrUAYkyS2E+jtVqCUu5Z+RR5QUKaGYNV3aCyES8gcUwouSaCoXNGiSjT/jaVSxxjQK1Lr/JmhRYM4RHnbBYnN5+TZhyIpnWfucNjYkpuENSoCATJHf866+BNeT3eAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEFNRYOum5gkqgLIS7DDerU7xCMYeoBQDSzyv0+OTog=;
 b=Kge7Qr+yXPahr2l6xC0Ia1A2diRRByzRodPs5krw8Pl2SBefNzWJa9TZ/V9xpNIGtTi1Fi9tvh67C2OctxqnUBJE5D5FTamBfztQx0jR5C9c0im8MRz/VP1uSc+TOdNmecQg0DEKhbrkrCyIuGHUr3iSj4Jcnvgv2K9wcpTEpTpynQmHwj+/8jvn7Bl5/RYPM7tw6X79D2XuaGnQqVJSzue4gAwz4GusQNCY6Id6S0ABn4qLZL+gFhkmnN+VX2zftzLvkvlsmmrHbi24kgYWHdoyGNjSTtuZXKwI1V8+fNdjr7gwE2grQzpTwvx+Ex9HvnCdN27KBexsuUkCmvfibA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEFNRYOum5gkqgLIS7DDerU7xCMYeoBQDSzyv0+OTog=;
 b=idI7MRC6BeusVz0I8m3vrsq2VPPe7tHdSrYwvZ8nc3cSjy9L8tlj3QCoLIkhuG/C6NklRMX4rQ/MH4aZo6oTqBoSqeIiTKLEo2dI8e1PMbvAr7E7/DzT+D3Ybr0Q5Z4RS756nn3oWBBmbUl6+EXSAOD1oUOuKlQEEZj/o3PccxxkaqybeZp1HtdzUcX+KedlmFjKqrsDX5sPDLlpw8RgrVhSz+rjxquwPErzNQFUyzk53NGkzkCmoiNwKzR9kXqXeso2+GIjLSjhf75MAsaxVp7ftdJT3qgrqBFZoxAINmV7MUx3Hvqp9I3SQucgLNKvB8GBqEQDcfWaju7VH9p3Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 14:17:33 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::fada:70ac:b58a:12f6]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::fada:70ac:b58a:12f6%9]) with mapi id 15.20.6340.030; Tue, 2 May 2023
 14:17:32 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 01/17] nvme-keyring: register '.nvme' keyring
In-Reply-To: <20230419065714.52076-2-hare@suse.de>
References: <20230419065714.52076-1-hare@suse.de>
 <20230419065714.52076-2-hare@suse.de>
Date: Tue, 02 May 2023 17:17:25 +0300
Message-ID: <2538re6rf62.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0067.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::14) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DM4PR12MB5039:EE_
X-MS-Office365-Filtering-Correlation-Id: d763ee31-815a-4bcb-de5c-08db4b17f822
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	FiKeERP/SKqONDJcH2JGKHxEW+B4LFWdwqxQpcnur+Vq4VKguxLLlzir6CZrUfSCChxFsSRWP4bfVKI+0n9++BIfzAltTInAlB2gSXMmODxIUyxbBPbkAdbjsXVi2/466MKDn4sJvdemfYttQem/kRwxwvpzYEI2o5KtLuXb58EZ0gt762oPX1N6hug6RD8Lxq5fROi43pRILZY8j9uhTIT27ITk4uw2k9vkZiV1EqmY4tESWU40tHqpaBrsTigVytwbyQB0at2gS2qwpdKPhMqOG9u6Nid1MmvLUxf5ATfGflKmG3LTzPIooJlEoLTRZYKo7PRUthOC5wO6CuIuhlLs1O7+1119uR1Aj0Bwis89Hm6qwQYLaPj+RNfg6dU3hqp+H2wSxG/f1EYoXS2F5pNnrdxIqMBM+Rm+wB1ZCLNECUhM+3zb+FCkNpVZ1ge825Bb/hCzcnXX34gIkyo3eNA7ZN4EHNUmGTtud/NjZdZmLnH1c27J8bA4Hz1lRH6Mo68XwzABodPO+qlkf809U4jqlZ32NMJYT1W7mnjGsGi9iOLkfsATpQ/MWIHdzyV+
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(110136005)(4326008)(41300700001)(316002)(54906003)(8936002)(66476007)(66556008)(66946007)(4744005)(2906002)(478600001)(8676002)(5660300002)(6666004)(6486002)(186003)(26005)(9686003)(6512007)(6506007)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?RElelv90Ua1XH03hUUxB4JS5qVpgQEonJlo38y0VWcw6CddXmTKrQ1iiD7AY?=
 =?us-ascii?Q?Y2Vic2q8tHqlMOT4E0yZSL86hQczRsayu5qK8RoqqVflpKZ1kXChLMkrSFti?=
 =?us-ascii?Q?TS61sBlz0/iRZ0+MabLTsMJoacTSuR+BpEOf9JIQm0UpFj8QYWL9LumQwJIS?=
 =?us-ascii?Q?/TBYDAkEPro7PND2fFRC1wbrwGm1tQhcDFVFD9ZB++DcdjRBIhnTEVBbVbHy?=
 =?us-ascii?Q?EnHsulb1J9jFRxGDKldRVFMLWSGTa3wi/+kYSyfKJL0C0PNaTYbiUvZlS/4j?=
 =?us-ascii?Q?03hiGcGKTuN8lGRf53bCORseHqrvSOtIP1zj6BOGWrfarYzpPqXovyXAn2uN?=
 =?us-ascii?Q?QjhQv02k/00RJ7gGIXzC31n8iNw5E0oUo6Va9ZgWtLAAlVQDQrgBT+TJrOEY?=
 =?us-ascii?Q?taq/D0BH1gQ+/vp7UllZKtcU7c20ID6sgZq8DI4x7a+1Nqbcb/GKHxNn3MdB?=
 =?us-ascii?Q?0Uqu5Y64UarLefZsh+QqKeSZ5ID0nPysvUBSAfGfUJiyyCZgOd59j6HjtuuC?=
 =?us-ascii?Q?Qm3CMnqzpWZjsqI2pRijnX58ap/yOsP8PDwtvSwTsKK27Y3KU00vR72Q1FxF?=
 =?us-ascii?Q?QmFiHdVRMvKJszfO2MdpWaOlnPoV6zqlDWwjZvuruIebk8RuxsmqEZo1FQxm?=
 =?us-ascii?Q?2MXhpKcSr7ARtKBscnCVP2Ey1cNi2PJrlsG0lWC4120SkW1cziGsfuRxXF66?=
 =?us-ascii?Q?1z+3l+RvPTZs7PBYzQeLyOcf79gMj0vKqTmo5wbqDpdkE+1fAN+SN5rgKse8?=
 =?us-ascii?Q?rDaKaUMlDAkrRn0siLOwPazyCHSfcrb/ToU/cEVoUQH+/54Mb6jT6NMuyBsX?=
 =?us-ascii?Q?56LrSQMmW6CbpFd61CHIGtYqkKHI5xmOdsVdkCzYvb4W6Gfo0lhLutLbYbuy?=
 =?us-ascii?Q?3pcMCo+8Pl7lSebBo11+TyYhnWFVeTOHS1gIDxWfEesMaBjwAANh5QIe3UGb?=
 =?us-ascii?Q?50FUJXGsCJVmXknj3tq5/muFuSWum1nBlEWgtc15efn38IkrtHs69P1XFVZQ?=
 =?us-ascii?Q?b1xEinxBshhqb/2T9l5WNL1Zl+K4/0mlH7DQlQtifz7WZUr2kOlksXHdxSLG?=
 =?us-ascii?Q?o1b45L6Nb0mwTA0NwEA3hE16U1ZxmVvWnCH56b7exPDP5jNm+HB6+/wXP136?=
 =?us-ascii?Q?7x2bvz7oskuC84ZD3uZxKU8Kt+41MKz+C/s0zJVgfKZ3Kl8XL0sc+KEegPAm?=
 =?us-ascii?Q?g9kqb1Dd4Fz4ineFStJHlrJSp8Av5UkEekt/5s3zT3UAFELTta55ZuBTNx7B?=
 =?us-ascii?Q?EEqdK82J5gaPMz97yNRx5M1YEeZc8xUswFQp4crb8JVaKdE3zKirSjua5ZNZ?=
 =?us-ascii?Q?hbx2MlDAyE8eA/QPUbZ8z6qE70tIOV+y/6hFAX7JKk5Q0Bqyfe3ybBl16Q+0?=
 =?us-ascii?Q?zNaDaFrHLECcGNekVYWPAEIX6Cj0NeLzQgXOGlLks5L7k/72Zwe4JPgFXW6M?=
 =?us-ascii?Q?l6oZ52d4X6NjZfYk5ACd4237GrH0W7YXKi+GidR0Yu2I6Pa6AnMVNamnUPS2?=
 =?us-ascii?Q?maH+tS4k+YC5hEL2aL6B9cRuXQDT2GrwRLP0U5YfvGTUl/qPjjA5aPByCq68?=
 =?us-ascii?Q?B5GlT9P7rVP30zb1mDMNbyw6U0YGkZhCcP4pa9qi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d763ee31-815a-4bcb-de5c-08db4b17f822
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2023 14:17:32.5153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBu+A5UMd6UmlmDjG4FLdckLw+eP40VDPgR+fhnS/LbkQVsYTOqrOUWXHmAomrk/0lOWKd/9N8E7N63QX+ZKDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5039
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230502_071752_871147_8EC40C0C 
X-CRM114-Status: UNSURE (   6.93  )
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

Hi Hannes,

Just a heads up for anyone looking at this:

Hannes Reinecke <hare@suse.de> writes:
> Register a '.nvme' keyring to hold keys for TLS and DH-HMAC-CHAP and
> add a new config option NVME_KEYRING.

I'm not sure what the config deps should be but this series fails to
build if CONFIG_NVME_AUTH is not set:

ERROR: modpost: missing MODULE_LICENSE() in drivers/nvme/common/nvme-common.o

Cheers,

