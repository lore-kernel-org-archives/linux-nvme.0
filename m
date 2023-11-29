Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122A0C07CB1
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Nov 2023 13:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s6vcvQpPXQW6uwFiMK3iQh7I8oPZqjE0JmOMjgZZwJw=; b=iXaRQYgAKFfUCynTR0xNZsxIbT
	RdoUOu3xYFwg376qUGSEZmpYxlTXllru0omyarUGvY8dTUUZRTgS8uPQxdSq6edrnfTuFtYquRRXq
	E4t19i57sGNmvMOIvJoE7jGvO0lYGCn6OYnX8UjYQswTBwQzVQxE3iqeIUY4pOTou3NMo3aFRfveu
	ovPx90iyO0Rn+lN1dyCHuX42L1RwKpnT93ZYQffu0eHPE1XoyIDYv3FTCCDax1sWnVtPCzTIxyK0k
	YraCQl9XFMOYi08BUHrSYdy6jEd8E/1OTfzwEnLrPhJaFUzXDqda3SCM5J1GFdwhC8FOrikJsBxjW
	JLjJ1MTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8Kzd-008X3X-2V;
	Wed, 29 Nov 2023 13:52:45 +0000
Received: from mail-dm6nam11on2061c.outbound.protection.outlook.com ([2a01:111:f400:7eaa::61c] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8Kza-008X2K-1x
	for linux-nvme@lists.infradead.org;
	Wed, 29 Nov 2023 13:52:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrGrYF2h2jl+39l39eL6xR2T9Q2d2LDkL8P/D5vJs7ZYiek5Q0K2c1IFPTLANx0CsN1qj4O15wNYZIrkuYzxYglGXo3GJIREfK4ykcfjgWi+I91A/U7JyB29TOk/RvvxyoEYhDrHTu5Dlu1bnbx6dcOg78jIJB5SeHDD/UV+EiJNtech3O1iLl7BcN4SW5mOpu3Sn2qLR9NJDhAoY2pt1GBuAlUM04cVmkyNXc/+UVad0qFRut12YjNL4YNvEcRLzfr7+21O/DNmNb139JRZkqxYhXczjECcwou0w0d4Y9PB/WuHbVlj3NVUanwUVUfinq2iGeKhH4rdPv+nHs2AZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6vcvQpPXQW6uwFiMK3iQh7I8oPZqjE0JmOMjgZZwJw=;
 b=oFrgQgUYG6HDmI1HHjxTzYJQrwrBiPJXDkTsX6GMoTbj3mhnarXEg1FiU/vNhGwgC3wxSNthkqaVzNcxAXZK77A+2l9bGTBuAHz83IM0+L4i7j+Fbg6eCU9alTbG6ocIgXK/lvqY86yQsthn+Inev7j5fRsSvRzw9PuprNVn7NNYV+BCEERzRZ5lPr1eacIsu72oqqMZyPayrJWQSdrjaSFeNbKlgAaX2EyxlOZqPad5kl30WPVE7gxWWPVaV388jMYAuO6rRfBlqYXU/7U9JiLsFjnddrYkoEfb0TFhR/9Y+qigOcDQOuq4BjuUiZFet0MWOaDT2D8afRpPToTCjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6vcvQpPXQW6uwFiMK3iQh7I8oPZqjE0JmOMjgZZwJw=;
 b=lBWYAmBtBpd3m1hr2ReG5pU5JGReP5Fxdjm9HY4SRsWl0F+ERCwiiemFOyFPLG0eQtL3Wd0kgOVoFWAJTEa4mTli2Snd82k8didUWQF7YlxNnQhyOUwJAlnUHFkX0ImPCM6+rzN4bVzawspWLfWMWhhBQ94eepSCbB/AizqxIHzI7sCD+4Q/WLgKVm+JZ6mPQHH+MWNUH5o3JxDBC1Ao1vewaPIsPd9F6+0ENSsfjf7giBpnUvgDjtBV5w0k6RzNJjjbzb/1N7eWFmyC8lJV23QFb443bgC43wZI6g1k3V9hWKfCtDVvCINcslI1LR56kbBwWn75bLXB33LEfcxPlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by DS0PR12MB6558.namprd12.prod.outlook.com (2603:10b6:8:d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 13:52:35 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7046.023; Wed, 29 Nov 2023
 13:52:35 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 brauner@kernel.org
Subject: Re: [PATCH v20 05/20] nvme-tcp: Add DDP offload control path
In-Reply-To: <debbb5ef-0e80-45e1-b9cc-1231a1c0f46a@grimberg.me>
References: <20231122134833.20825-1-aaptel@nvidia.com>
 <20231122134833.20825-6-aaptel@nvidia.com>
 <debbb5ef-0e80-45e1-b9cc-1231a1c0f46a@grimberg.me>
Date: Wed, 29 Nov 2023 15:52:30 +0200
Message-ID: <253plzsis4h.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0178.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::21) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|DS0PR12MB6558:EE_
X-MS-Office365-Filtering-Correlation-Id: e1ffd6f2-ca81-4c68-df7e-08dbf0e270d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P6wKZbASfa8Iowd98TQd7dlPC52GYpR+Y4qdRza5a+oWXM7n9GaqTg4xTwvtwmuZbEPXPSzZI437zjV7oen6HbSb+XQHA75SEH6s1ABTeepwlDcxlX3SUWZVXiOZtqobysuginYEZJARHG6415v0Q9fB6g/LUx932nCKIw3k4CgTVPnr/dFUkXadaQQa0mtNYld0y6SrE8In/mub6TqxqNuWO2wrpzm53Ls35Ni3GchHB6rTkJh9hU2zgIL/lk2jehY72gG4Kw3oZe7F43IngGeT3Myj5j4BxBnD7Yb3RKuEjenoLrAjU/2+HL/efgX7t0KUKIdDQW+oFGXv05dqzbnxndUof1B258yRRnBtZ5krmKWiXpA1BszDj6Kl0K+G0RiV6wzJom8C8aJGMcZ4ZN8O/2w3t6kv4G26ZSrf/BBAaLzmjm8ITniLhO2SBiOAtgzG339uBtvdUC5Uqb9KJ0W5tU2xR6oRMxi7Z0VE9sTzOvsVq7CSg0+aGmAOTcEGO/9t6CmKkRcUj7uIQmNXJm6fz4pScrUlJnKwcMW8Y4oIhVLQTBRtIpRfHwykiBSxbYfog/RbVCTyZe3aq8aFn5sdjVah6hLuP00rW1ly6XQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(39860400002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(41300700001)(2616005)(86362001)(38100700002)(8676002)(6666004)(8936002)(5660300002)(4326008)(7416002)(2906002)(26005)(6506007)(478600001)(316002)(66946007)(66556008)(66476007)(6486002)(966005)(83380400001)(36756003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3YrZr5iNTQesq/Wf8FYGiYaMmuycCmtWdMoAg3oQ6y6s3bU5Q0SbdyiS3xAw?=
 =?us-ascii?Q?EtD2F/KIcAVDDP1ehu/58Bb+5Jcm/ArjZvWDKUgTnaqk/QtijiWfn1jVrN7r?=
 =?us-ascii?Q?Cb06vmGduCDU9tVnNMR3jtZtDhjjVYdOLdkXLn4JC/iZPKUySwFIdqBu5Pnv?=
 =?us-ascii?Q?/UoNEVtSiYli8LijbkwkNJdTMKGhzpJDXljJNSyefef7VZnEIZq15/ajBMeC?=
 =?us-ascii?Q?+jaZZzL+v4TK0CjT4j1255l80o1DkkijvEDXYsnwkeV4htpHg7gevnBtNXJO?=
 =?us-ascii?Q?Fxq7AcO2/kD/a/LiYEwtVeHZHDGk9QHIJv9gR5WzAkiCz3XFxCyJWiZItnuf?=
 =?us-ascii?Q?IUZcgAIjxM+l81HeBrRznBY+aVzTEv5/PhpoWmH7tbV+GqT8vrfLgDBkSz1W?=
 =?us-ascii?Q?8WoP23fCcSwaYbZs/3c6ciCD9lskJG0HKOR8nadfIqkpiTk0Orx++A2YIDQY?=
 =?us-ascii?Q?e3znfbewtOhEzBMWEQbcZ6Z+kTkBXCWTSyctNnvokJwyW9TWVOvtYwrbrwnC?=
 =?us-ascii?Q?RLy3nMT68seEqtiqz3K6/WFh2beGerz+eoubId3EY64oiv4d9+vdI4YGBEOe?=
 =?us-ascii?Q?jKz6g+sLzqJQQORcx2Ybe9dZcD59RCi7qDOjh9pMlDQT5ZnWcMT573YTrmWL?=
 =?us-ascii?Q?GhxI7TnjEwUV+CNlgJQ1MFH/uUWa3TPgiHWLiVg59IFfMsMcYWxLxQLyGs0/?=
 =?us-ascii?Q?h+7TYbSF4KLdR8+3+W10xLLdB+1BsWUFoWGV9ztIFkfuUmGhRyybhQ9HKEGM?=
 =?us-ascii?Q?P3+w91hPwjFq+1/RFwbwUDZy/N7gaJQydWekIhGJ+wVpULGD7mhDxGRLJfYG?=
 =?us-ascii?Q?MdtBBMJGTKC0v3TP18o4tGGkYAD8ZkMQV8I0BsMRci5cfmx7pn6kITklBqJg?=
 =?us-ascii?Q?xi+K+pO/BjZdAIMB1cpnAUvqKOriVImLQgq9AUuT9QXmskzwTYjEVic/ZBTJ?=
 =?us-ascii?Q?Y03xOevTJYTen6kNS7CjiTD7cdv9qpWJBiNaGXQQrC5Mps1fzobmZvqq9G6c?=
 =?us-ascii?Q?cC6UoLLO4eRVeQ+F2/pR9QycHTB6Pe+UPTd0YRzfYuHwzyzh5JZf2PyC12Yc?=
 =?us-ascii?Q?NZSbNE2VtQnfSGOdkXgXFmIPLXO6Mywk2xzjDO6mW4dsHTZTmDctkDBeCmfA?=
 =?us-ascii?Q?JrAchpIOoENVAi8CQXBqFgPRQtcfiGdB8Ic23LkFeVjbKtKXqqCfcyq8fq5i?=
 =?us-ascii?Q?IPVtWpjg21CncG7VHOgxFFR7IXIqv3RQZaFN3zwaqoR3v2iHpuz1s5Otw5u5?=
 =?us-ascii?Q?wTf7OWgoTNsNK+h41t5ChoggM8+eUVnsgTGuclQFNIC4YeafWYHYswLenik8?=
 =?us-ascii?Q?pBA1CrP9tAztIcA7tdIlySpKb2rml2borhqGe3St1MJN7/2fOQ6U5d36OT/S?=
 =?us-ascii?Q?xmgXhE/IfEOKzFvhGjAQELPuC5iSzLdfDoLkyyU9m86lVH+67Z1bh/9hEIF/?=
 =?us-ascii?Q?uZMDROp4py/b9LKGkOMT9sRNKgtwdYCQ+Zp3Z0Cj0RlBwHk0LtD/jsv1tTaG?=
 =?us-ascii?Q?1qGF/IUICaVheKlFy8kErw20dKeJnAdw0iaISbQj1OkjNzzwhuP8Z32L9Hd5?=
 =?us-ascii?Q?TmIw5HzV+tyWXd9+DaAW4LBXZqQfu0blNC0RwUB8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ffd6f2-ca81-4c68-df7e-08dbf0e270d9
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 13:52:35.0962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDUCyES+co2G2jcILd4/dAyUGgKI5xzHExVhwxR2OtVYNxh3IpWiD2lDxH5SDbbOPYiU0y/JUKLpN0Og7zTDMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6558
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_055242_783941_30F8C246 
X-CRM114-Status: GOOD (  11.62  )
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

Hi Sagi,

Sagi Grimberg <sagi@grimberg.me> writes:
>> +     ok = ulp_ddp_query_limits(netdev, &ctrl->ddp_limits,
>> +                               ULP_DDP_NVME, ULP_DDP_CAP_NVME_TCP,
>> +                               ctrl->ctrl.opts->tls);
>> +     if (!ok) {
>
> please use a normal name (ret).

Ok, we will rename to ret and make ulp_ddp_query_limits() return int 0
on success to be consistent with the name.

> Plus, its strange that a query function receives a feature and returns
> true/false based on this. The query should return the limits, and the
> caller should look at the limits and see if it is appropriately
> supported.

We are not sure how to proceed as this seems to conflict with what you
suggested in v12 [1] about hiding the details of checking supports in
the API. Limits just dictate some constants the nvme-layer should use
once we know it is supported.

We can rename ulp_ddp_query_limits() to ulp_ddp_check_support(). This
function checks the support of the specified offload capability and also
returns the limitations of it.

Alternatively, we can split it in 2 API functions (check_support
and query_limits).

Let us know what you prefer.

Thanks

1: https://lkml.kernel.org/netdev/bc5cd2a7-efc4-e4df-cae5-5c527dd704a6@grimberg.me/

