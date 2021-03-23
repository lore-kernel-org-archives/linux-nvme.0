Return-Path: <SRS0=jrCY=IV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E14C433C1
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 19:02:28 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A5B6191E
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Mar 2021 19:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A5B6191E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EXu8S4ZRxv1DO3IobomWN7wNRnLOs4vErYJXiP0J2X8=; b=S8XdBxAoX0F3JYCXut/s564np
	EJ+RK6D1GNF0zfLy33sfvZ9i7BG2KnCGglk1p3DQr3mRrgpSb77evPTq/Huq20fP1KFUsM61zJr8S
	7FX7mLVBL2s8lcmDLTmqf8pJmAapUL20gLlJ9JxOkFXtTlWp6kBqZAav+3JLWg2Biaap9qPRbBe9O
	7YL+5BFna5UFjrRGZ8kib2+pwa0anXeqFym84dwvp7UsXVeVAOH1M/ZaumQ/YR+eXsVz5s2I+Otil
	ROo29jCr/wlWVs3wxNhTLDaxoKTi7UZ6t92TxCtxNpfokCbtB/SEAK3B4TcZn855VoIhbjZdiYm6x
	O9TGCH+Nw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOmHn-00FZ1N-8x; Tue, 23 Mar 2021 19:01:51 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOmHj-00FZ0t-Ag
 for linux-nvme@lists.infradead.org; Tue, 23 Mar 2021 19:01:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 594FC68B02; Tue, 23 Mar 2021 20:01:45 +0100 (CET)
Date: Tue, 23 Mar 2021 20:01:45 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme-multipath: don't block on blk_queue_enter of
 the underlying device
Message-ID: <20210323190145.GA17528@lst.de>
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-3-hch@lst.de>
 <34e574dc-5e80-4afe-b858-71e6ff5014d6@grimberg.me>
 <33ec8b12-0b2b-e934-acb1-aae8d0259e2e@grimberg.me>
 <31e7f7f4-55fa-6b0c-426d-7f7e7638ab4b@huawei.com>
 <5d28226d-4619-74b6-1c73-c13ed57aa7ea@grimberg.me>
 <20210323161544.GA13402@lst.de>
 <162dc8f7-b46d-37ff-01e8-51d813e0a904@grimberg.me>
 <20210323182244.GA16649@lst.de>
 <c4ceed19-cdc5-aeca-0c4b-ebed088e8b82@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c4ceed19-cdc5-aeca-0c4b-ebed088e8b82@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210323_190147_522731_2D8BE4B6 
X-CRM114-Status: GOOD (  15.23  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Mar 23, 2021 at 12:00:34PM -0700, Sagi Grimberg wrote:
>
>>> The deadlock in this patchset reproduces upstream. It is not possible to
>>> update the kernel in the env in the original report.
>>>
>>> So IFF we assume that this does not reproduce in upstream (pending
>>> proof), is there something that we can do with stable fixes? This will
>>> probably go back to everything that is before 5.8...
>>
>> The direct_make_request removal should be pretty easily backportable.
>
> Umm, the direct_make_request removal is based on the submit_bio_noacct
> rework you've done. Are you suggesting that we replace it with
> generic_make_request for these kernels?

Yes.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
