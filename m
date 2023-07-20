Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46980EB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Jul 2023 18:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FqeRW9Q5QhBsnFZQl0IMTBZtnRqfELuMjThOrYGsbGw=; b=w/Lvgq94gEmvGeAhcZrQcNj/G9
	UHnkNNTvErbnx5dPN9lO2Dt+WdnwQGk/0qrjTuQc2uLfnQ0DsfK4Ri7U4m8/ufWARO4E4ZzXaNCx+
	EJ7CLpBlBxbmfTWonaK13XiNNElEXw2Uy+IzWaruuZT7dVEaRzpKjG+a5aixK2AXKIF+lD+aOuSsi
	v6mk1qRdqLrxjqGcR/grW+MQu665ik53cMvg3Ph71B6JaV+OhcDLRJeeUDcTq+Ykpi8rl5XiyRI8w
	rR4RDEFHtbUirf4Bh1dqtb/wwn/tMbIdpvMG3RekR/dt28BRexNVwtTt1fyrDHDsxfYPvs8c49Esc
	1rtntxkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMYSO-00BuLu-2w;
	Thu, 20 Jul 2023 18:32:56 +0000
Received: from mail-dm6nam04on2071c.outbound.protection.outlook.com ([2a01:111:f400:7e8b::71c] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMYSK-00BuLH-2B
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jul 2023 18:32:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CT4Wns+4NpoH5FbpGsz0OZxFS2yFVMArMSI2XO7ZMWgR0K7PvguhFIn7mXuRrg+xRPRxiWZERspzxvUdDsltn3EW70Ubz19rz8nRpfMHOYxUv+HUcpN/8Z2uUAIlR0hEqjZmdlrS3V0nT/p9z0vGQFoJ6yYfQKGhUuMYl6TDCcVXuSi4/x59FfhradMh4e0xzbQzisfAfaZUN6SmLJUduYof6zrtP/ZQJ2x4EtRN3nG0WsVn62ALV4lM1cBVTbrtMvyXiTSD+9ehU8fg2Na5fy6NOo6FE6UzGg/mdyhTuGZHkCC8Kr5xZBpoOHbwzZtMbLA8jm5JcAXUNrIE0Xg/qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqeRW9Q5QhBsnFZQl0IMTBZtnRqfELuMjThOrYGsbGw=;
 b=X9loTksAlD3VE+J4vI1B1thxEDWMSESzsKY13xMuRVTM2OeFSUtZ5XkrRqZ0Z4Kk1igA0Vi9shxxU8ovRRakVuSH2IXGNNO+/ZNbVat1eJzEhfjXR7w3klobBp0MS9AV5ITBsqzq/hFrsnNSywqrXU0gsib4NSDVVC+218Gy9r6tQOfhrRy22heqbWugKV5tzifw7iRgyFiJ+sEjk+Bz9kCivNZRsd/Oqs9iZEcEQ8PBnyy3TW2yFq1K073BVCBGFe4bAm2XuFBEcpg5QjZ3L4F3+1BAyeF+tMwUjSimubGxRgUTB15bHSA0590J2CpwNc5Vq7IGwyw3p9hFhn0ZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqeRW9Q5QhBsnFZQl0IMTBZtnRqfELuMjThOrYGsbGw=;
 b=h9VOVwJaphO5lZzddxjt/4QbVaB3+AgM06BLLN8kRlRLVwAuUJWjGC+yuQoeLrLVSYlapOSNKILdTa9gl7ZiL9q1be9Q/Wy+5duSGzQl5TZOEl1td6TRF5Hc+UekPEEFBedvm/11os3YA87iQi6bhp07UfzuwqNTY32kWCTJkZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by CH0PR13MB5234.namprd13.prod.outlook.com (2603:10b6:610:f8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 18:32:42 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.025; Thu, 20 Jul 2023
 18:32:42 +0000
Date: Thu, 20 Jul 2023 19:32:33 +0100
From: Simon Horman <simon.horman@corigine.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Boris Pismenny <boris.pismenny@gmail.com>
Subject: Re: [PATCH 6/6] net/tls: implement ->read_sock()
Message-ID: <ZLl9wUxKrZpgHMxY@corigine.com>
References: <20230719113836.68859-1-hare@suse.de>
 <20230719113836.68859-7-hare@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719113836.68859-7-hare@suse.de>
X-ClientProxiedBy: LO6P123CA0052.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::10) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|CH0PR13MB5234:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cfbbb5e-cb21-4d36-f21a-08db894fb3b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zYAz8kPo5oXrKDcM1ziFunOBD3dpGHuULmvdSUXtH36K0kQbeJzfwa5OC15Q01e8BVm2YUkNZv16ZTe+DNcjdLHDWqHxdAU8ZKKAHQSF3/+DvEeTF6Ifb/MfEEM7hmCS7KnOGIIyHKZGTtnXMuax9Ww39lvLFY79FCzS3irMx0gNeOlKRmmdRJJg1VONQDK4eWFw7Akir0YLhwmmbzrDoeorEOmfEiP1prO2nFx8C9uDpkLe9wkfZIcxhiqtHEAfI5TkUG7+P4Y1P1GUsbGiNC6UMkBm2yPbJRVrBxaz4EEOhFCmo/9tpZn+NrbBMY2OsAeropdyqoC0moo4GOx/ja1YCw844y7urJA+FA5EnAmGBDZrQpd/My0FWBdUcFe7JEyCl7LR9uC3O1Jl+fTXBBqqhUzP/O0zgQA3xfGOV/sHa6Az4xsUeXdn5zhvNP/qvc5AAmear/wnchmko0v5SDumA9uztlNaHnptubj14U5EWHBsvStoWxVLvNY5RZm/yoAiVu3liQFeXx45JkZ3yhNx6dczPfoJH06p1fHnZkkSh4uv4M79owuupaeEBMtfjGO599dFhVzRp8TQKNFeOAjUVDpZMkdbC96wMiknB5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(366004)(136003)(39840400004)(451199021)(38100700002)(86362001)(36756003)(6512007)(6486002)(6666004)(478600001)(26005)(2906002)(186003)(6506007)(55236004)(8676002)(316002)(8936002)(44832011)(41300700001)(54906003)(7416002)(66946007)(6916009)(66476007)(5660300002)(66556008)(4326008)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c7zLdH5+4mS+ATaHaaCuDigpGruJFaYNmp1ODq32RkGlGOv9fxHhE2OBxYS+?=
 =?us-ascii?Q?DzUxA8TJTQE5Ijl4mQ2JYNNHjlTa0ijkoFdbP0FykTzS73wkxvwvSfRqFxBr?=
 =?us-ascii?Q?t+DEcCbltyoe8/mouygAPsV8Jk2zWXCupmuO/Pu4Eav2xVS5jdS7UQQllYhX?=
 =?us-ascii?Q?J7zmfuXtrr49NXOHRMw0Q8/hz1ZhSMoAPnFqo5zwFwx5l2SnFph1Kul8xPkx?=
 =?us-ascii?Q?Y7rhSbONWwktshzbD7zhIrgZ654Xfb+EvSFll12PFZrgisK1HvKCURaqxsiC?=
 =?us-ascii?Q?PhnlyL5ReEeg/Q98dyZHLbLqx0cPKn0+q39VPLJSubZ4QY1Ud9XFAFslTvwg?=
 =?us-ascii?Q?Kh3/E51rxG0uN5o4ktIabW04bRv+rftN3P1Lvs2dV+VIa0GD9q3CdDj7rGhL?=
 =?us-ascii?Q?d61sc58zdm9VWEWwLj7bqU8CBa5jOM0wVxIejh9pUs+fpR1pYwphqPnjiKJO?=
 =?us-ascii?Q?+V7GvewFPvnuBf6NtjcCd6dIxRtmkPFETdCtEtuIkp8/Oo7gI2jot/LLsv36?=
 =?us-ascii?Q?sofUayVcYbkCM/gON3C7P/gAodpv/zBAjdU0vCu0469s/QgMLp6VOweDFXJI?=
 =?us-ascii?Q?uxgLNF6zWAglOqDG9G8MFXEnMbVTcwR6+e5VSKh7VFPrH8/bQaju5j6JYYR7?=
 =?us-ascii?Q?xQxlt8Ar2l85EVxH3L5d3lrktS1VxsY/ITLeu0baVyOJC1dzdUSLZdB5JPMs?=
 =?us-ascii?Q?sXRDzVxxyWEqY4Hhbqj/dKAkWJqZMIoG6fhk1mjfW66RKe3B12JQYUv8t5lt?=
 =?us-ascii?Q?WmGGd0F1CJ2BfSjie0o9CQWomzFuv4SSu4j7FX2wzY1fry+d8b8CzVezAkn+?=
 =?us-ascii?Q?sZp/8cqjcSe4u1a7ZuUmaAMCGRl33/4TefP8dJ8TbYalk1KHCzHeW8C7SdKJ?=
 =?us-ascii?Q?KUGhqiXtf8n1vNKuLP+Z5irib8rcWskKLv8+jfzdgfWW7hU+JnZEb5XNsc7H?=
 =?us-ascii?Q?jpZ5Bw2pfN3z8OMVT9cMDt9FTf38VjtHrePf9N9Npebw2VT4E5VJj4iWAiSe?=
 =?us-ascii?Q?j120SAhvmKvPoqCjuzJyq4rCO3goQVoflkwHwdO8/Yo/l/vegjtzy1x1Cu1f?=
 =?us-ascii?Q?nrtSKv1ql7aUnScK5Fr8sHQfqkjHLp9xCxypNkMqxpSHz5OZTKtUzn3r1J05?=
 =?us-ascii?Q?lPsHnBgXOW5mMk4z1GtbVnpyxGzx/7rFi/EzjFjqSe7O6y6GP4dbnIuStP00?=
 =?us-ascii?Q?k/nrW7dORrs+N83X5p8+MGqoD3jK1P7Hzu9pjP+9ercxeCaWG0oa1aI6esJm?=
 =?us-ascii?Q?iHxwklw4OGzWpLdmO5SdIgTGkmIZpqaxXZr/CDwiSD79MOIenLKrcOZaS+1G?=
 =?us-ascii?Q?a8DWs/+E3oBGLn7s5x1tx180RopuY3cXuBLjKf8yKuk4k2R/sKWXHXFJemn5?=
 =?us-ascii?Q?Hpbc970SQCO/4QITDQlqk6AGFa7PUZ5Qc3skDcWR4yN3Ct6NM0xu8p1gUnaK?=
 =?us-ascii?Q?pfCBUn6uW+dTWszKMDSgpe25zkK3uxws1aAuTMMbdf+O5OUhMN7YTtGBTy9y?=
 =?us-ascii?Q?lXVkNQ3Z+Cz/r+3ZSFrpIdghrAFrGcHQvxzxOXWkvF0KK1zYdgRLQFQH2BBC?=
 =?us-ascii?Q?OjIWYgPocEj/GRs9QGO9LQFvu2b0jCbuF7T6p0DP/zqCaN5za/WsKYN7y6Qh?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfbbb5e-cb21-4d36-f21a-08db894fb3b3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 18:32:41.8995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2JDazfOO3qhYBBltgtVGPSiISYqTv7Yjhl+TGhK98dtJe8PCWu6zhHWC+ylaGe0fXYxKFx+C3kRrj/F3/y5tDUhs/O1/Sye/Ge0ox556KU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR13MB5234
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230720_113252_880452_F9F356EF 
X-CRM114-Status: GOOD (  19.14  )
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

On Wed, Jul 19, 2023 at 01:38:36PM +0200, Hannes Reinecke wrote:

...

Hi Hannes,

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index d0636ea13009..4829d2cb9a7c 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -2202,6 +2202,102 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
>  	goto splice_read_end;
>  }
>  
> +int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
> +		     sk_read_actor_t read_actor)
> +{
> +	struct tls_context *tls_ctx = tls_get_ctx(sk);
> +	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
> +	struct strp_msg *rxm = NULL;
> +	struct tls_msg *tlm;
> +	struct sk_buff *skb;
> +	struct sk_psock *psock;
> +	ssize_t copied = 0;
> +	bool bpf_strp_enabled;
> +	int err, used;
> +
> +	psock = sk_psock_get(sk);
> +	err = tls_rx_reader_acquire(sk, ctx, true);
> +	if (err < 0)
> +		goto psock_put;

skb is uninitialised here,
however, it is used in the psock_put unwind path.

Flagged by gcc-12 [-Wmaybe-uninitialized] and Smatch.

> +	bpf_strp_enabled = sk_psock_strp_enabled(psock);
> +
> +	/* If crypto failed the connection is broken */
> +	err = ctx->async_wait.err;
> +	if (err)
> +		goto read_sock_end;

Likewise, here.

> +
> +	do {
> +		if (!skb_queue_empty(&ctx->rx_list)) {
> +			skb = __skb_dequeue(&ctx->rx_list);
> +			rxm = strp_msg(skb);
> +		} else {
> +			struct tls_decrypt_arg darg;
> +
> +			err = tls_rx_rec_wait(sk, psock, true, true);
> +			if (err <= 0)
> +				goto read_sock_end;
> +
> +			memset(&darg.inargs, 0, sizeof(darg.inargs));
> +			darg.zc = !bpf_strp_enabled && ctx->zc_capable;
> +
> +			rxm = strp_msg(tls_strp_msg(ctx));
> +			tlm = tls_msg(tls_strp_msg(ctx));
> +
> +			/* read_sock does not support reading control messages */
> +			if (tlm->control != TLS_RECORD_TYPE_DATA) {
> +				err = -EINVAL;
> +				goto read_sock_requeue;
> +			}
> +
> +			if (!bpf_strp_enabled)
> +				darg.async = ctx->async_capable;
> +			else
> +				darg.async = false;
> +
> +			err = tls_rx_one_record(sk, NULL, &darg);
> +			if (err < 0) {
> +				tls_err_abort(sk, -EBADMSG);
> +				goto read_sock_end;
> +			}
> +
> +			sk_flush_backlog(sk);
> +			skb = darg.skb;
> +			rxm = strp_msg(skb);
> +
> +			tls_rx_rec_done(ctx);
> +		}
> +
> +		used = read_actor(desc, skb, rxm->offset, rxm->full_len);
> +		if (used <= 0) {
> +			if (!copied)
> +				err = used;
> +			goto read_sock_end;
> +		}
> +		copied += used;
> +		if (used < rxm->full_len) {
> +			rxm->offset += used;
> +			rxm->full_len -= used;
> +			if (!desc->count)
> +				goto read_sock_requeue;
> +		} else {
> +			consume_skb(skb);
> +			if (!desc->count)
> +				skb = NULL;
> +		}
> +	} while (skb);
> +
> +read_sock_end:
> +	tls_rx_reader_release(sk, ctx);
> +psock_put:
> +	if (psock)
> +		sk_psock_put(sk, psock);
> +	return copied ? : err;
> +
> +read_sock_requeue:
> +	__skb_queue_head(&ctx->rx_list, skb);
> +	goto read_sock_end;
> +}
> +
>  bool tls_sw_sock_is_readable(struct sock *sk)
>  {
>  	struct tls_context *tls_ctx = tls_get_ctx(sk);

