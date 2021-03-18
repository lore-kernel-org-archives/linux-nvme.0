Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D73C433E9
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 19:16:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CCCC64F01
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 19:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CCCC64F01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bva5eJE74oQlpsdNGitg/gOMQcAH73HHfrIJzWxsN2s=; b=qRORNIbkgWvvgkmbBO0SmFu0S
	syrVZCfTm2VyaN7uSJ3qlaoaCEv7PbDqKndPGLf5DByTmlxcVwEDmPseAn/2TiYPq7rLt7tNPqk32
	eNa329m3IQ3fYYUuFAhrdC/vVwk20YCVGDOLx03IxdfEuIocwqscaSODC11MEo23EsfNzWsEOcl7b
	HkbixAIuTtB44r0vTfEGdG0vX7xGL01AqVjaYs3FIlbEJMriPCLhqdlOYnHZedg6Gs4EmKbI3ROMj
	k4gfQsAfNerzksBxvqj/7MS2kMHbZ8TQ+rtWBjd7e2fAP8Ni87/vFjuYBlrnAIVWVhn1x0+PF8/GS
	5gRBTo9Uw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMy89-005v7j-2N; Thu, 18 Mar 2021 19:16:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMy84-005v72-Te
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 19:16:22 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A759664F01;
 Thu, 18 Mar 2021 19:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616094979;
 bh=RSgnT3FiumcLKGFMP9P0n/DXtn+x8TbcsrdPfxWACvk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=n6Ns1yaQkO5VhdToxM50Cy4X75sdHdF51/cZ3FqHMRyC6eIYpWkvux5oBNdoR8MsL
 6X3nUkDL1/l4oXH9TPKdK+PP6PoZdUNn0Jsh8ILX41T2uv0JOPXgiURUMCfZGp8Lfg
 j2MaLyE/zPKE9GvrjlSaVmCn1+ncUu/KClSppZx9pXIy+0CUytfx8j53yBduDXt3kv
 hyqnAZkYcXEaAliSN0u255LJoPCvQdOuR5dFAFH17Zl/fCimNGCz01FLTW6yZndmdK
 X92G5rZHIJB4pFBXoqPyiQbzLvHH9pEqikxb7iyN/fOs2Y+FxreGrfyHnYMYrpmdKU
 lUtltC2yfXtiw==
Date: Fri, 19 Mar 2021 04:16:13 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 0/3 rfc] Fix nvme-tcp and nvme-rdma controller reset hangs
Message-ID: <20210318191613.GB31675@redsun51.ssa.fujisawa.hgst.com>
References: <20210315222714.378417-1-sagi@grimberg.me>
 <1b2ccda9-5789-e73a-f0c9-2dd40f320203@grimberg.me>
 <20210316204204.GA23332@redsun51.ssa.fujisawa.hgst.com>
 <59f7a030-ea33-5c31-3c18-197c5a12e982@grimberg.me>
 <17b15849-f0f3-af61-113f-0eb717e96f0f@huawei.com>
 <20210317065910.GC14498@lst.de>
 <2e391aae-58c7-b8f7-1a9e-d7ad5bb3f8f3@huawei.com>
 <6c085430-cc10-a2fd-56ee-a360109c940a@grimberg.me>
 <55142c25-9a70-08a0-d46a-cad21da59d19@huawei.com>
 <7b7d5223-ddaf-eb88-f112-02834f8c8f93@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7b7d5223-ddaf-eb88-f112-02834f8c8f93@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_191621_177589_B3F7EEAE 
X-CRM114-Status: GOOD (  12.49  )
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

On Thu, Mar 18, 2021 at 11:46:08AM -0700, Sagi Grimberg wrote:
> 
> Placing the request on the requeue_list is fine, but the question is
> when to kick the requeue_work, nothing guarantees that an alternate path
> exist or will in a sane period. So constantly requeue+kick sounds like
> a really bad practice to me.

nvme_mpath_set_live(), where you reported the deadlock, kicks the
requeue_list. The difference that NOWAIT provides is that
nvme_mpath_set_live's schronize_srcu() is no longer blocked forever
because the .submit_bio() isn't waiting for entery on a frozen queue, so
now it's free to schedule the dispatch.

There's probably an optimization to kick it sooner if there's a viable
alternate path, but that could be a follow on.

If there's no immediate viable path, then the requests would remain on
the requeue list. That currently happens as long as there's a potential
controller in a reset or connecting state.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
