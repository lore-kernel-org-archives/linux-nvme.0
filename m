Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E6EC7EE22
	for <linux-nvme@archiver.kernel.org>; Tue,  9 May 2023 09:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zrLSiNyy0pd62YIyamkCE1ZM7fJmuVtMfWcXznkl2iw=; b=BHxnQztDx5u0n7CG4xRJw0AyTc
	fYT4cIXyqBiDGPU+nVG3fvLdKEfVGi/BxNvbFNDaTKiO6A/Z5AOXDu6quCbHntQD76tWailn/j8SD
	HJSsuioOKTRJbSQPvA6p0fbuJJT5nsgTkq46NY1UwHKuLnKMPmN7VJ+pVNSnEZ5vMwgqKRknjdubE
	CyiVejSfH+KyW5Z6Wz9r/VZuc1Dx/4cCHlOB368gdqvakra8RK5UnRtTXqsv05HBFYlicAWkhhdkF
	+vScpfC+PKzGYWHF1vMHd1eP8an+srYx9EaOZd4+zDNuQ+BdbkSOiwiAmELvWLrdCM2Kp/ShZ3EGU
	AYmEMxLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwJVi-002iOL-19;
	Tue, 09 May 2023 09:19:54 +0000
Received: from mail-dm6nam10on2060d.outbound.protection.outlook.com ([2a01:111:f400:7e88::60d] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwJVd-002iMv-0U
	for linux-nvme@lists.infradead.org;
	Tue, 09 May 2023 09:19:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyyrbYRvmaC/6/bDajdBluqd+PIuf0DksXJrcxh06vVoD22+wRPLjdqhOmBL+ZJECkDzzQQiNCTfFg/+v/cm03GSLmAuwat1pUYgUVOLgbcGFpUpDifMXgaN20AfA50XlqTbIW6zRErLz9r1U2BeOnAK+jHN0DJw6XaVRblzUeIR3fTEI5tHAWUjbgaZ3RZ6HwaQZmLFviAj/Rw95sph2d9aEVP5wDHX5phqAA2DAmFWmoGhIhIx3z8o/nxcs1Khnw5HPF2BtfRDFhRRKXb5dflzLdNzEWdQa8ix6DrzSAHYHGIsJy99IVttXQrveTVA5/vb1bCGf65RQEtGPwoRsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrLSiNyy0pd62YIyamkCE1ZM7fJmuVtMfWcXznkl2iw=;
 b=RT7/OYhmF/qGZeLu34IH7Kq8oGulLMJKo27sMvQnSxhVbb/ztQ/sYmiFcgNzIrvfVFkyW7db1R9MV1YFabujQNLK6mXeoRcE08OfMS10qiiCScgeK49fThjODRNTjA+maQWomF1raacre/STMvgVPbWgrZ1KmBVXcIl1EVlyJWDaCBogokh3A1adnjxS5tMg0tuMfF26bCY1RfocrIT2x78cPLzXYibsliTgWPZmhLD+f84a0hkZckaSXpkV2cx/GykClh6kQfGt0ftxHow1v9R8F2SaaomdiFi21WPOHo/MOApheOsdh19CblrlJtoMR0KOCjvFg3QW4ZURpc20YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrLSiNyy0pd62YIyamkCE1ZM7fJmuVtMfWcXznkl2iw=;
 b=gOkWd0/VTPWZGbV9dpp9FKDdnknmc9fvm9Can6s2Mxh6HtxsZ9Ue/QuupxdEB3qANEWv/LLdufzuyGGN4bWYYw3XOFHFs8zKkoabDZbioblSK/jWWKi+05LbrYlq2+8YjekqxYzh76GMhqMn/3xzncaZBua7DyuOpz2vrnw0OoGcfWgiIq2GQtGxmeIbv8LW7ThGnIkW9srwbEm7trxaRqHKigO98gmtFEZlAGHR4qYkwGHOkCLPsWPBNJfqiLiPgSHQxZVV11y17+2zm8gpp28rsN9t2eBPCgu7hy4JhYL+rplgeYRKmY/2oemKnwKApZqxFGEgP4tJm/Y3qWTjeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SA3PR12MB7878.namprd12.prod.outlook.com (2603:10b6:806:31e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 09:19:43 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%4]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 09:19:43 +0000
Message-ID: <fb934ee3-879f-f33f-efeb-945ccc9dc9a3@nvidia.com>
Date: Tue, 9 May 2023 12:19:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 07/17] net/tls: handle MSG_EOR for tls_sw TX flow
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>
References: <20230419065714.52076-1-hare@suse.de>
 <20230419065714.52076-8-hare@suse.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230419065714.52076-8-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::10) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SA3PR12MB7878:EE_
X-MS-Office365-Filtering-Correlation-Id: 2791febf-0076-46b3-ffd1-08db506e860d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	3vQZO7VA1EoA5uucydtU86f+SA53+GLsvBLeXB/HvrFkAV4neR41s5ptFgAjk42kEDJpoYz0OL+wBrddKxmaG5oqBaOsQ3NnYYztj7AqaCoyY8wzHBHVFQ1vlNsMX8snK/LqkmYWYsQT6MoI9COtpr/nkg8DtMp1Y2Wm1ZT76J3TvTuKkwLpIQiXqkkACxgKtLsYnlR7ut7n/OolRFUHfEVYK8C06++z3ONtZ7qNIQL35OMJCZ1tt340BIneokB0srsaM43kRCttnaBkoFEggycnu7GSzo1I3EidJDD+OyZuZhxkGNKc2fr6229toWxewK2nEk2l5Kpcn76lY+hAexTtmXU24rbkNiv0E9ycVm1fMG6SGXigFg6gPF3Wp+eKEg6KxazTvLbG7ebqbHTuWDStnUtJixyCaquGbKO/3nQVe3PsTkD5JQJ2zZwmTbjn9IrMgbgcYSfCxVXbXCXdjihvfGKZVmrEKx2SnYjg3xkJONuy1zH7d4QUlaGgXBU0K0PEqkE8LP1Sg199HqoOncIW82L0GlBMASCmmLW0QJARDd3Mb+mpiV+53az1J7dc0ZQGjP2FvPJb1rf53C3Qkd/INWqPmrJ8WvXY4WlyueJJPhFy/83P7E3rUXuGpWBn3VWGOKe129O5tBfmXPfbXA==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(451199021)(31686004)(36756003)(38100700002)(4326008)(2906002)(8936002)(31696002)(5660300002)(86362001)(8676002)(66556008)(66476007)(41300700001)(316002)(66946007)(83380400001)(186003)(110136005)(6512007)(26005)(53546011)(6506007)(6486002)(2616005)(6666004)(478600001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?YlExK1VWZENUYlVwTUtVTHBmL0pCOU5BOUorek5SOGtIZXA3anU4MWpMQUlF?=
 =?utf-8?B?SXZtTlFQb3ZQcXFDNk4zLzREaTJWd3VMSU9lcTFJbVJMRjRQTEs4UCtyb1B4?=
 =?utf-8?B?TVI3NkNyMGhGcDV2d0hmZlZldFF5bGdIVDhlWkdLS0Z4dWVZQXdBN1hKT0xP?=
 =?utf-8?B?S21PRjFUTGJaVWhObEVYRkZRZ3BjMlBsT0t5MTdzckwwMnd1QlhGUUwxd1FJ?=
 =?utf-8?B?R0FCcWVaV0RTVnF3TjJnckw5c2gyMnkyYzZtb0RDUUFkdm9iY25NR3hrem02?=
 =?utf-8?B?MnA0ZytreFdSRVNPa3ZmK0N0VG5NdkZCREtXZENvQjRScGpibWZFdGRLb1dI?=
 =?utf-8?B?d2lXUGxIM2FNTk1IazhOSzFtZXBlTjdlSStGRGVpc2VhdjlKUSsycGlYWmJF?=
 =?utf-8?B?Z0xieVN1NXNxUkJCTnkrTEJIWFR0REdFOTdrbE1nc053WFduQlFjeHI1c1VL?=
 =?utf-8?B?d01SczRqSjlYSVNTaEhxc3RBZnRWdDRkYzN6bFpabWZDT3BoYkhUcVRBWXBH?=
 =?utf-8?B?L2RlY01yV1NLVFdBMGk1Wkt4ZE1NMHFwMXZhQnhURjRsUkRqNVNidmNTam5M?=
 =?utf-8?B?WW1BNzc5Yk9WcnRMN3hVNWF3OUhOZ25Ic3JaZ292dGJZa2ZnZGtlc0l4eElO?=
 =?utf-8?B?L2MwRkxodlFicFJUVzFlcnU2dktJMnUzUEtmMy9mMjMxVVB5WmlqVGROMHFv?=
 =?utf-8?B?UTZOTTExcFpvYXhHbHgxNjY1VThPU200MlNvU0NZVzIyZXFHbm9mejE0TWdz?=
 =?utf-8?B?QUJxS3RBUmtYNmFWQkxyRCt3RlJMc3R4VjVXSlByZ0xXdFJWanQ5RjZ0T3c4?=
 =?utf-8?B?VmJwcFBzcGVlaWs2QXJ4WWhlM1o1TXRNbXNoNndmVjQvSEI4WXY5QURWTXhn?=
 =?utf-8?B?eWx5OVdZQVowdmtQdDhmK0ZIeDFUaGY5NXBXOUZVWHFicW1XN2EwQ284OU11?=
 =?utf-8?B?aWlpM0RIRUVCUjNLbEhBZ0dncjEycU5zbW5FNk1XclJlUDNZZkpOUVJxSE51?=
 =?utf-8?B?MitSd0ZFR01MSFRWa3JiNzM1WThXZzZmcDRIRTBCWlkyeDNFU2VxNmFiVGR1?=
 =?utf-8?B?QWgvU2xjdFFhRnVtRW4ya1VaRFJhWHFOb3hadmQwL21rQUVPRzFjNWdiL0h6?=
 =?utf-8?B?NnQ3TkRhTk16UEczQlY4TmpaZFBaSE9zNm1PbWJpVDM2RkFlTWpENXZaN28r?=
 =?utf-8?B?ZXgwNmE1WlhMWk9rWWlHaEhFdWRyZkpiVExwZVB1MHFsL1JpMjdTM2R0N1Z0?=
 =?utf-8?B?dUVPV2ozaG9sMGQ3N3pmc0MwYmdXYUsrV0Iya2RLZmJSdnJVbFREaXNtc0tB?=
 =?utf-8?B?YmVrOXFxdGN3SG1ldit2SUVCWG00V3A0NXRxbjIrUjRJcEV3RFQ4MkJLTmlO?=
 =?utf-8?B?dmJMRk9TUEowcDJBcW9TT0dMdlpTTFZHL09NQ21POXNsSFVKdnFNb3IwQzhS?=
 =?utf-8?B?RHNXVUhxQVFRYkhTdGVIZWJiUnAzS3FraVBEcnBZcWhDVURXMmNhOU5BTFRP?=
 =?utf-8?B?M3JLdmFHUmRNZ09nODBKK2g2Q0xKVEJtZGJULzFHVk4rdnJqeW95cWNuRHNE?=
 =?utf-8?B?MFAyN3RtM2l1TDk3QldrZ2t6WHpMeCtadUhaa1lpTlpQSFRtb0RxR05FdFI0?=
 =?utf-8?B?SlhGVlNHbkZzS3FMZkkrN1dqU3JiSUY0WEdWTDY1ZStJeXN2OWtMaVZnekE3?=
 =?utf-8?B?M2RiTkxHQXBNZWRnVnc4QXk2bWFWcW9qZzN1blM3bWtSb25rQi9OblVTL2F1?=
 =?utf-8?B?bEQrSi95L1pOZWJ0Lzl6V2xXSnpnT0FtR2xOdnNNYlNPcHByL2RWcGJpQ3Ni?=
 =?utf-8?B?dFFOZ0FrV0x2R1RpVUxyOU03ZmcydUh0T1ErQk0zcFJOWmVFdk0wYW9yN2hM?=
 =?utf-8?B?cmZjU0NhTGpHajNzS2tqRnhaSExzQTRDYmRhSFFudzNxa1d0ODBrTTZPSjlL?=
 =?utf-8?B?dnUvZHdxTTQ2V1Naa1F6Rk8xYW9IYzBNdGd4ZEJrQjFaRm1KdkdNZExZbzBm?=
 =?utf-8?B?enhtcmhuNldiZ3dUaFcwRzlZMFhIMWQyRFVCRkQ2eVVleGJpMFZySVdKaHVj?=
 =?utf-8?B?U29CYUpXazZMeW9nakViTFhvZ1JsMFROVVNQclJEV2VoZXNteTFJME9LMEtF?=
 =?utf-8?Q?YKrJQuKkiBlRs1MdAa0onCQsf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2791febf-0076-46b3-ffd1-08db506e860d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 09:19:43.1808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRWJySkwTbhXagwjeBbXE7Ku8JJSFjA2WupBBCRwH24OqEsQFtjOU3WXpr3MAmWVj6hXennwu4SayAPVkZER3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7878
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_021949_263599_A0709EB5 
X-CRM114-Status: GOOD (  18.92  )
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



On 19/04/2023 9:57, Hannes Reinecke wrote:
> tls_sw_sendmsg() / tls_do_sw_sendpage() already checks for an
> 'end of record' by evaluating the 'MSG_MORE' / 'MSG_SENDPAGE_NOTLAST'
> setting. So MSG_EOR can easily be handled by treating it
> as the opposite of MSG_MORE / MSG_SENDPAGE_NOTLAST.
> 

This seems like a nice optimization but seems not mandatory for the 
acceptance of TLS support in nvme/tcp.

I wonder if this can go to net/tls as a standalone patch ?


> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Cc: Jakub Kicinski <kuba@kernel.org>
> ---
>   net/tls/tls_sw.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 827292e29f99..9bee2dcd55bf 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -953,9 +953,12 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>   	int pending;
>   
>   	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
> -			       MSG_CMSG_COMPAT))
> +			       MSG_EOR | MSG_CMSG_COMPAT))
>   		return -EOPNOTSUPP;
>   
> +	if (msg->msg_flags & MSG_EOR)
> +		eor = true;
> +
>   	ret = mutex_lock_interruptible(&tls_ctx->tx_lock);
>   	if (ret)
>   		return ret;
> @@ -1173,6 +1176,8 @@ static int tls_sw_do_sendpage(struct sock *sk, struct page *page,
>   	bool eor;
>   
>   	eor = !(flags & MSG_SENDPAGE_NOTLAST);
> +	if (flags & MSG_EOR)
> +		eor = true;
>   	sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
>   
>   	/* Call the sk_stream functions to manage the sndbuf mem. */
> @@ -1274,7 +1279,7 @@ static int tls_sw_do_sendpage(struct sock *sk, struct page *page,
>   int tls_sw_sendpage_locked(struct sock *sk, struct page *page,
>   			   int offset, size_t size, int flags)
>   {
> -	if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
> +	if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_EOR |
>   		      MSG_SENDPAGE_NOTLAST | MSG_SENDPAGE_NOPOLICY |
>   		      MSG_NO_SHARED_FRAGS))
>   		return -EOPNOTSUPP;
> @@ -1288,7 +1293,7 @@ int tls_sw_sendpage(struct sock *sk, struct page *page,
>   	struct tls_context *tls_ctx = tls_get_ctx(sk);
>   	int ret;
>   
> -	if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
> +	if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_EOR |
>   		      MSG_SENDPAGE_NOTLAST | MSG_SENDPAGE_NOPOLICY))
>   		return -EOPNOTSUPP;
>   

