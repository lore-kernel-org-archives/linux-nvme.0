Return-Path: <SRS0=Bcfk=ED=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386D1C388F7
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2020 16:58:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9940B247CC
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2020 16:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lpk9tfsq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nWFx2UzN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9940B247CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XwAyUfWezcbP1cdzI1IPukLrS2YRfg80xn7XaGrVo8k=; b=lpk9tfsqxZ2f1CQZuDfu+tbWI
	BU2te1w0/8DTCLL/uD7G6lMmlFAaR2Q/c2PMnKLZBuP12QgeWYquh+7Bfd/eN7+W2nnbR3U00nssH
	O0RhNC4xsZ9b0EfgniMhrUpIkO5vqEhM/ymahD2Dn6V6kXTipAPRjiGInNm8fY4pNBhEhu9Xi/yCa
	l3d6NruUOkv61m2eRuKXWOhhZcSFIAfJjnOODLGj15e81Mq/We90mMCOUgocTFfpuQnHldKh/08/t
	UImhprZmv+z8gLTa6dXoXXyR2n0rV4PGsaEUCj58429FFKclUyBqiKyggvEi4j2sJrYXPOlpd6l04
	LTITCc9wQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXomT-0002hv-Lc; Wed, 28 Oct 2020 16:58:37 +0000
Received: from hqnvemgate26.nvidia.com ([216.228.121.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXom9-0002er-NJ
 for linux-nvme@lists.infradead.org; Wed, 28 Oct 2020 16:58:22 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f99a3120002>; Wed, 28 Oct 2020 09:57:54 -0700
Received: from [172.27.0.18] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 28 Oct
 2020 16:58:11 +0000
Subject: Re: [PATCH v3] nvme-rdma: handle nvme completion data length
To: zhenwei pi <pizhenwei@bytedance.com>, <kbusch@kernel.org>, <axboe@fb.com>, 
 <hch@lst.de>, <sagi@grimberg.me>
References: <20201025115124.1430678-1-pizhenwei@bytedance.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <86fa6106-b969-4bb9-95ee-c1101a61ff03@nvidia.com>
Date: Wed, 28 Oct 2020 18:58:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201025115124.1430678-1-pizhenwei@bytedance.com>
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1603904274; bh=cR2ZEkkVb/BlRCyOFgIUSEJCwL4kH+CyituXrsasLIE=;
 h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
 MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 Content-Language:X-Originating-IP:X-ClientProxiedBy;
 b=nWFx2UzNPDiROjdiBCoKaqsoXBmlMDFGaKIaTCPEvZLLmwBjn6a5pVAnzknVcWEBL
 Zp9/RSvDbckthXtzooyEMojhijAhKPEOtke6799ARYxLPNoBTJuyal0yJyMd3gb5rh
 dirt/6rnxeYZb1/wxBYsxH8MD/O/5f1ANoLm3NqDLrtaoOy8AlqSUa3/p0i8SSqd5S
 D+BsZTStZC7a1WXAMtLgF0VAILvWTxNSpNguPgDY0qrnjaKUPbxOnyRNYxKtjO8mqq
 PXrV0ShzH5EMS4x8hrVwa4ValWS2DFZhNql8gaq4CVNXEnbyfPPUkK1gu7aOPCA4Zh
 mynLNW5LnWEMw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201028_125817_967163_F5240A9D 
X-CRM114-Status: GOOD (  15.07  )
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
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 lengchao@huawei.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 10/25/2020 1:51 PM, zhenwei pi wrote:
> Hit a kernel warning:
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 0 PID: 0 at lib/refcount.c:28
>
> RIP: 0010:refcount_warn_saturate+0xd9/0xe0
> Call Trace:
>   <IRQ>
>   nvme_rdma_recv_done+0xf3/0x280 [nvme_rdma]
>   __ib_process_cq+0x76/0x150 [ib_core]
>   ...
>
> The reason is that a zero bytes message received from target, and the
> host side continues to process without length checking, then the
> previous CQE is processed twice.
>
> Do sanity check on received data length, try to recovery for corrupted
> CQE case.
>
> Because zero bytes message in not defined in spec, using zero bytes
> message to detect dead connections on transport layer is not
> standard, currently still treat it as illegal.
>
> Thanks to Chao Leng & Sagi for suggestions.
>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   drivers/nvme/host/rdma.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
Seems strange that the targets sends zero byte packets.

Can you specify which target is this and the scenario ?


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
