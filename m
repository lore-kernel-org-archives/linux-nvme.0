Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16EAC433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 07:21:03 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D90C611BD
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 07:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D90C611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CevxrXY9HI4wGlFQ7wRuAoyZ4u72hAN5szBdX8AoPys=; b=ActjbdXA6189uSSkNl3AcovJOd
	tAa75apoCzxLXfQmsi5cZkoA3inUkC8U9c5xDBhq43jIt3RzUOQ1qXc3pVA4h3g3AX2IIu5NP+lvB
	TfB/tMx/d+R/hYX+lq+PKzzmEqnxa3Y9nTDnre/UY04VREqZz+5Hl3FpKRTpkXFWbHX+ApKYce3IR
	87+l9oQ58JH41ye/u3rDq89RyHHbJmIhD94SRqFDc92T8AcHDRbwdMGSqZ7XV3D/Wdvzk90Canyc0
	SW+bFhufaEmoVa8P09/DwbzeVKzLcy7H5iCEtCCnT8ERE/xk1jiR0fKzfk4eUpryhOJEwhMvaaVM9
	WDS38IHg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ljzSK-0049ra-5e; Fri, 21 May 2021 07:20:25 +0000
Received: from mail-bn7nam10on2048.outbound.protection.outlook.com
 ([40.107.92.48] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lTW1Z-000dOh-O5
 for linux-nvme@lists.infradead.org; Mon, 05 Apr 2021 20:40:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYOs6IGqflxW3uQigDcAjwP7B8vcadYzvv2JnqkGzZ+bJYnMIBmy7DGGhmV5M9LnxpBzk0Q2y/lbYUt9rwNQSW7yYWluDNwBP9UlF0Nwh7CYi/dD+opOcTOZ1H6e+PfAxHIKbgX8yGF0FT62OSZgMd/uQrXiG+w1wy5bzbdvHHHMoe04M3i5SEchRVEQnM4F6GU5tqDLp/HflcOVmAynYzE5ghJQxGz6WU240Kmy/bS5MFibiOnC+p520X1ivciR2ruUygUpoWpfTsuHXv15V9P7Ho68mof4SF8IkDKchSzPqTd0tyAURo3UZ9ItJXFqXzJ+LhAty8d+2ZuD9MzDkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwggBMfJRdb6PvoedbOJgy5q2y0CmtkKVqX55sP0WGE=;
 b=bV1aT6klXfToCGVFiab1lVJ+SoDMehS8s6QUY7p0EflZt/DxcZOIfTGGEe7yYCUiJ3X/vSDBUPmVYioJlCCN04MMEppOUPF5CWpyM2E2s6CZyq3VgxMEcFglP92C+GQHo6JYXPSMBeeatS9vvsC01kMfBPqEqswhr4kDlwPFecGg279rYujGOQMAPabSPwnw7eJyC3u62qZxGqP+qzpCPaad01f2uaK5ZH7Cv1cyL7ugQgonZ8GkO8RXvmwoDSG7RFgTpgQb2UVyug7GJ095fApLRLH0lvrHAS+e8ZO0XbOjtuRfAt3t59Rsh5niLY1LDkYLYc2GHMvZ+i0m5Kin5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwggBMfJRdb6PvoedbOJgy5q2y0CmtkKVqX55sP0WGE=;
 b=2a3A57uM5lP2T8mmDBo3782LTdLEaPgTYcMuYdAsbpK4OHxmO3ntJLsLEsle7PoHhPF2Ps2dwf7SktTAr4iluTqMpSfPhBzwnZ9j+faoHJki+7TSCOL6ka6E3om2CgEZDhL765LtVvj5GxFEpHlGT5F7oD18nNTDlP1L/520DSc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=vmware.com;
Received: from BY5PR05MB7155.namprd05.prod.outlook.com (2603:10b6:a03:1bf::24)
 by SJ0PR05MB7341.namprd05.prod.outlook.com (2603:10b6:a03:278::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8; Mon, 5 Apr
 2021 20:40:32 +0000
Received: from BY5PR05MB7155.namprd05.prod.outlook.com
 ([fe80::8c33:8eab:566:f63a]) by BY5PR05MB7155.namprd05.prod.outlook.com
 ([fe80::8c33:8eab:566:f63a%5]) with mapi id 15.20.4020.016; Mon, 5 Apr 2021
 20:40:32 +0000
Subject: Re: [PATCH rdma-next 02/10] RDMA/core: Enable Relaxed Ordering in
 __ib_alloc_pd()
To: Tom Talpey <tom@talpey.com>, Leon Romanovsky <leon@kernel.org>,
 Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Avihai Horon <avihaih@nvidia.com>,
 Anna Schumaker <anna.schumaker@netapp.com>, Ariel Elior
 <aelior@marvell.com>, Bart Van Assche <bvanassche@acm.org>,
 Bernard Metzler <bmt@zurich.ibm.com>, Christoph Hellwig <hch@lst.de>,
 Chuck Lever <chuck.lever@oracle.com>, "David S. Miller"
 <davem@davemloft.net>,
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
 Devesh Sharma <devesh.sharma@broadcom.com>,
 Faisal Latif <faisal.latif@intel.com>, Jack Wang <jinpu.wang@ionos.com>,
 Jakub Kicinski <kuba@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>,
 Jens Axboe <axboe@fb.com>, Karsten Graul <kgraul@linux.ibm.com>,
 Keith Busch <kbusch@kernel.org>, Lijun Ou <oulijun@huawei.com>,
 linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
 Max Gurtovoy <maxg@mellanox.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Michael Guralnik <michaelgur@nvidia.com>,
 Michal Kalderon <mkalderon@marvell.com>,
 Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
 Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>, netdev@vger.kernel.org,
 Potnuri Bharat Teja <bharat@chelsio.com>, rds-devel@oss.oracle.com,
 Sagi Grimberg <sagi@grimberg.me>, samba-technical@lists.samba.org,
 Santosh Shilimkar <santosh.shilimkar@oracle.com>,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
 Steve French <sfrench@samba.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 VMware PV-Drivers <pv-drivers@vmware.com>, Weihang Li
 <liweihang@huawei.com>, Yishai Hadas <yishaih@nvidia.com>,
 Zhu Yanjun <zyjzyj2000@gmail.com>
References: <20210405052404.213889-1-leon@kernel.org>
 <20210405052404.213889-3-leon@kernel.org>
 <befc60f3-d28a-5420-b381-0f408bd7cca9@talpey.com>
From: Adit Ranadive <aditr@vmware.com>
Message-ID: <7246a8dc-d484-e022-0270-23e29eaea390@vmware.com>
Date: Mon, 5 Apr 2021 13:40:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <befc60f3-d28a-5420-b381-0f408bd7cca9@talpey.com>
Content-Language: en-US
X-Originating-IP: [71.204.167.113]
X-ClientProxiedBy: BY3PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:217::22) To BY5PR05MB7155.namprd05.prod.outlook.com
 (2603:10b6:a03:1bf::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aditr-a02.vmware.com (71.204.167.113) by
 BY3PR04CA0017.namprd04.prod.outlook.com (2603:10b6:a03:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend
 Transport; Mon, 5 Apr 2021 20:40:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36e5738e-3a05-479b-44d9-08d8f8730e0b
X-MS-TrafficTypeDiagnostic: SJ0PR05MB7341:
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR05MB73411B3BEEA01D7DA54264BEC5779@SJ0PR05MB7341.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /vynTHLHZfa7GV83Z2iZ1hUCJuEz/L/0v7ppej4i30yCDay1NYNSfwDfTIFwp04YM16OnsRSe4TGswGYifQHvPxQaDiiyuALW/IjvMA7Ho25vYcrp3LX2zJtG8mHur8L3M7nUBK7NZEB99nYeMYkT7y+nbu3fOzRO2YG8LUc+Q48wrqUnlhiGO03ieYfTngcVDUAsYMTihHhz/Xr9AHp9EV6SJ23lFjWVxf1++fKXOIXsqUxdFqC8CJWbOvKgAtN229m7LP5nd87ThpqxU4Uepqfnf8lEmvXpOwG9YO1ulIhYOM491o+AOar6oDe5n2LEiKZ8ZaI0F08qRAjMW2llHNRTmT5Q7LmdJnnJWIuTJ5s+dkwwl4KLeH8BrJfG7cQpvie5C1NTnnERkWktbdX5r5V+waDqTPfxd4KOaI0XQLW1Q+WYo3lYHcoJ/dmk0+PDZJiZo8AFrvUYowmvtMq/IWGBtKKjQ/vAyXsUY2iNleW5afev3MpCHMZ2vJ/wJupxgvp3XCpnBMMX2JW0WQPjxRvVFfOj6StbCdyTfOcIjK/ge8zFcCwvtw8Dphz0AaS5GkDXqeCcPNElqCrc9exyzmCsFE2kz0+AoTrilFXid1oN4VPF4fORzMCpYE/4byLlBHQ3JIKeageG0ImvClMpPXSU0SjkTBPibiDlBzCwZSyNjW23VhUdrMDwqXJazgTbMhUM23JgXDjUBDuXqgUF1LPPnSc61IbSGxQSChnc9E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR05MB7155.namprd05.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(478600001)(6486002)(83380400001)(7696005)(36756003)(2616005)(31686004)(8936002)(186003)(66556008)(66476007)(66946007)(4326008)(16526019)(8676002)(86362001)(53546011)(110136005)(31696002)(54906003)(956004)(7406005)(7366002)(7416002)(5660300002)(26005)(316002)(2906002)(38100700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RWxmdmo5RFZ0dEtVOFJWb3Y5TDQ3cUJmMTRveDlzNVhvTGVzQ0hHNldqTTAx?=
 =?utf-8?B?NTBwRVdvZHAxZUpkRUkwUXFhczVIWFUxaDV1YWtJSnViaG1FMWZBdUZQb2My?=
 =?utf-8?B?bDRYdThJNXp1anJOTCs5Z2VuL3p3eEtqV0JGZjZKYmthdzNPWFNLQkNuU0ZJ?=
 =?utf-8?B?TVpzYTJVdDRuVnlVcW1iRXVaOVh4bmtZWWdpcVVWSUNZdkdBM1dvaFRQUUtx?=
 =?utf-8?B?SmtSbFpWTXFQekpQWHUrY1FjUk5WSmpSU1l0Mm95aVYyZWFXK0tqZmtWU0Q4?=
 =?utf-8?B?QXJxZHRrVmNuV3FWdGNjWmQvenFSMytOczJoT1B1Qmg5UEwvSjREMWhXczk5?=
 =?utf-8?B?YlJlVWRXYnRRNHh5aXBVKzc1WUZCQXF5TWpqVHNpOHRCMVEzWmc0VmJvWjNF?=
 =?utf-8?B?Q0l6bXNaaktjWkw1RHhKS2RCVXJSK2lFWnJMNlhlUmtlN2lTcHhHMWIvTnRE?=
 =?utf-8?B?alZ1aEVHeC9kVXY1eXltRUFpVTl4bHdHazFlZ0tnYTI0cnJrOTkvL3UvbUd6?=
 =?utf-8?B?bUs2VHdRaEJ4ckRHL253MTNGUC84YmxWV0U2eklnMkdhVDJ0SWtkdmVjQ2s5?=
 =?utf-8?B?ck1NL1hWT1o3SHMyS2U1OUhZdHV1cGtPZnlxMU9uaUFDNFdPS2xrMmZUdG1T?=
 =?utf-8?B?Q0lrbUxOU1RCakJiQWZNRWtPcG4rMTd1cXVaWmJrRXp6bGJrV2JwNTVGbytV?=
 =?utf-8?B?RE9lSG1XUXcyYWRFQjhNNk1idHVuWTluTGJiU0ZmdlBMaFF2V1VMZGNoQWtr?=
 =?utf-8?B?R0M4ZkVnZ2s4MjQ4OHl6ckJIZ3Y2Wm54cEdiR3dTdThDKys4SG81Tjl6ZGV2?=
 =?utf-8?B?YTBMSXdKVnhPS2h1UWZ5Y0dxOW9xcG0rYk5jNkZsTHBsWUR2Mlc0OTBEQ3Ux?=
 =?utf-8?B?S3VrRUJpMjIrbkxvWnZ0MmNLMWV1K3VSSmFTaW0ydnlBb1NPTk43STI1YmlY?=
 =?utf-8?B?TnFEQ3lrUCtZOTY2UTh2b29IVU9temNlYmdMcCsrbDhlZ2cybUFuM3BpM09t?=
 =?utf-8?B?Y3RxVTNrMnlLQUNGTWM5aXNGMklUU2hRbEQyR3Qxd21CUHc4US9XVGxwU2pH?=
 =?utf-8?B?VE4xQmRsdUt3SUw5SVVwbUpKVGd3RnJZb0lkZ0NZOG9EL0hwTlhRWWxQSGsr?=
 =?utf-8?B?NTZXWVM4WXgyL0prRmVQYStvOHRwZ2srWDFELzZ5UGpCOHBaQnU4ZGszTGN1?=
 =?utf-8?B?a25EK0ZWVzYycEtNUFBpTnFHMGxqLzZraGNWRk13N0xoOUdTKzN4OVhIVW0v?=
 =?utf-8?B?QnZNMlZlYTRFR3pVRVZUM3hmdkExMS90dEZZd3grR0RJODE3UVhuRC9TbFl3?=
 =?utf-8?B?NUxHalk3SjVzM2o0VVZVMUdzSzlMNVFWYlpGYkk3dTV2Y0VBTFV5N2NxODNH?=
 =?utf-8?B?ZTFPRXNaQkxLWEJvSWRwZGFYcHB0TWlvS0RUaXBvQmg4ZG1yWit0alRMY09r?=
 =?utf-8?B?N3I4dnBycTZqZG5EUXhNazVnMEZKYmNSVUUwV0RYTlh1OTVldEJJTUQycDhi?=
 =?utf-8?B?VVFpNnU4VHAzcGc1TnBJL3R5bXVGOHJLdE5LOGNnRktLYXVRUmZXNUMrUTYr?=
 =?utf-8?B?ZlFKWVNGNER4QnE4R3VhdCtjNnp5UFZwNkQ0OStMcFp6NmQ5dEJBeEYwdDJt?=
 =?utf-8?B?VTZOTkFrdHNmTG5Zckd5VEV3MlNqU3lCcDdSa3M4dFdoSnZvVFFtMEg4UUpV?=
 =?utf-8?B?M2J6dklsUER3aHNQc2pSK1JON25WZjZyZUo5Qmt4YmxnL25neGFna0RMN1pJ?=
 =?utf-8?Q?f3yNfrpTtmHT80tb3Gd11K/3NJGciDGrN4bMcsV?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e5738e-3a05-479b-44d9-08d8f8730e0b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR05MB7155.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 20:40:32.2157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XAt9q7HxE8cbKfbH6TY/pIyZrAUq64tbkPnedCjIjPNuUXbYaeVmzb28O7EDFZmACBPBO07x39zb8Vk18SU4ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7341
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210405_214041_924624_AB82B93B 
X-CRM114-Status: GOOD (  14.39  )
X-Mailman-Approved-At: Fri, 21 May 2021 08:20:09 +0100
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNC81LzIxIDExOjAxIEFNLCBUb20gVGFscGV5IHdyb3RlOgo+IE9uIDQvNS8yMDIxIDE6MjMg
QU0sIExlb24gUm9tYW5vdnNreSB3cm90ZToKPj4gRnJvbTogQXZpaGFpIEhvcm9uIDxhdmloYWlo
QG52aWRpYS5jb20+Cj4+Cj4+IEVuYWJsZSBSZWxheGVkIE9yZGVyaW5nIGluIF9faWJfYWxsb2Nf
cGQoKSBhbGxvY2F0aW9uIG9mIHRoZQo+PiBsb2NhbF9kbWFfbGtleS4KPj4KPj4gVGhpcyB3aWxs
IHRha2UgZWZmZWN0IG9ubHkgZm9yIGRldmljZXMgdGhhdCBkb24ndCBwcmUtYWxsb2NhdGUgdGhl
IGxrZXkKPj4gYnV0IGFsbG9jYXRlIGl0IHBlciBQRCBhbGxvY2F0aW9uLgo+Pgo+PiBTaWduZWQt
b2ZmLWJ5OiBBdmloYWkgSG9yb24gPGF2aWhhaWhAbnZpZGlhLmNvbT4KPj4gUmV2aWV3ZWQtYnk6
IE1pY2hhZWwgR3VyYWxuaWsgPG1pY2hhZWxndXJAbnZpZGlhLmNvbT4KPj4gU2lnbmVkLW9mZi1i
eTogTGVvbiBSb21hbm92c2t5IDxsZW9ucm9AbnZpZGlhLmNvbT4KPj4gLS0tCj4+IMKgIGRyaXZl
cnMvaW5maW5pYmFuZC9jb3JlL3ZlcmJzLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDMg
KystCj4+IMKgIGRyaXZlcnMvaW5maW5pYmFuZC9ody92bXdfcHZyZG1hL3B2cmRtYV9tci5jIHwg
MSArCj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
Cj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvY29yZS92ZXJicy5jIGIvZHJp
dmVycy9pbmZpbmliYW5kL2NvcmUvdmVyYnMuYwo+PiBpbmRleCBhMTc4MmY4YTZjYTAuLjliNzE5
ZjdkNmZkNSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvdmVyYnMuYwo+
PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvY29yZS92ZXJicy5jCj4+IEBAIC0yODcsNyArMjg3
LDggQEAgc3RydWN0IGliX3BkICpfX2liX2FsbG9jX3BkKHN0cnVjdCBpYl9kZXZpY2UgKmRldmlj
ZSwgdW5zaWduZWQgaW50IGZsYWdzLAo+PiDCoMKgwqDCoMKgIGlmIChkZXZpY2UtPmF0dHJzLmRl
dmljZV9jYXBfZmxhZ3MgJiBJQl9ERVZJQ0VfTE9DQUxfRE1BX0xLRVkpCj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCBwZC0+bG9jYWxfZG1hX2xrZXkgPSBkZXZpY2UtPmxvY2FsX2RtYV9sa2V5Owo+PiDC
oMKgwqDCoMKgIGVsc2UKPj4gLcKgwqDCoMKgwqDCoMKgIG1yX2FjY2Vzc19mbGFncyB8PSBJQl9B
Q0NFU1NfTE9DQUxfV1JJVEU7Cj4+ICvCoMKgwqDCoMKgwqDCoCBtcl9hY2Nlc3NfZmxhZ3MgfD0K
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSUJfQUNDRVNTX0xPQ0FMX1dSSVRFIHwgSUJfQUND
RVNTX1JFTEFYRURfT1JERVJJTkc7Cj4KPiBTbywgZG8gbG9jYWxfZG1hX2xrZXkncyBnZXQgcmVs
YXhlZCBvcmRlcmluZyB1bmNvbmRpdGlvbmFsbHk/Cj4KPj4gwqDCoMKgwqDCoCBpZiAoZmxhZ3Mg
JiBJQl9QRF9VTlNBRkVfR0xPQkFMX1JLRVkpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHByX3dh
cm4oIiVzOiBlbmFibGluZyB1bnNhZmUgZ2xvYmFsIHJrZXlcbiIsIGNhbGxlcik7Cj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvaHcvdm13X3B2cmRtYS9wdnJkbWFfbXIuYyBiL2Ry
aXZlcnMvaW5maW5pYmFuZC9ody92bXdfcHZyZG1hL3B2cmRtYV9tci5jCj4+IGluZGV4IGIzZmE3
ODM2OThhMC4uZDc0ODI3Njk0ZjkyIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2luZmluaWJhbmQv
aHcvdm13X3B2cmRtYS9wdnJkbWFfbXIuYwo+PiArKysgYi9kcml2ZXJzL2luZmluaWJhbmQvaHcv
dm13X3B2cmRtYS9wdnJkbWFfbXIuYwo+PiBAQCAtNjYsNiArNjYsNyBAQCBzdHJ1Y3QgaWJfbXIg
KnB2cmRtYV9nZXRfZG1hX21yKHN0cnVjdCBpYl9wZCAqcGQsIGludCBhY2MpCj4+IMKgwqDCoMKg
wqAgaW50IHJldDsKPj4gwqAgwqDCoMKgwqDCoCAvKiBTdXBwb3J0IG9ubHkgTE9DQUxfV1JJVEUg
ZmxhZyBmb3IgRE1BIE1ScyAqLwo+PiArwqDCoMKgIGFjYyAmPSB+SUJfQUNDRVNTX1JFTEFYRURf
T1JERVJJTkc7Cj4+IMKgwqDCoMKgwqAgaWYgKGFjYyAmIH5JQl9BQ0NFU1NfTE9DQUxfV1JJVEUp
IHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGRldl93YXJuKCZkZXYtPnBkZXYtPmRldiwKPj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAidW5zdXBwb3J0ZWQgZG1hIG1yIGFjY2VzcyBmbGFn
cyAlI3hcbiIsIGFjYyk7Cj4KPiBXaHkgZG9lcyB0aGUgcHZyZG1hIGRyaXZlciByZXF1aXJlIHJl
bGF4ZWQgb3JkZXJpbmcgdG8gYmUgb2ZmPwoKUFZSRE1BIGRvZXNuJ3Qgc3VwcG9ydCBhbnkgb3Ro
ZXIgZmxhZ3Mgb3RoZXIgdGhhbiBMT0NBTF9XUklURSBmb3IKRE1BIE1ScyBzbyB0aGUgTVIgY3Jl
YXRpb24gd2lsbCBmYWlsIGlmIGFueSBuZXcgdW5jb25kaXRpb25hbGx5IGFkZGVkCmZsYWcgaXNu
J3QgY2xlYXJlZC4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK
