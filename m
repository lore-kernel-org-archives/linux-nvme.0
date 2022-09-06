Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A80DBC38145
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 04:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=05njV07sJBMDroait06pY76fcRd4k+pymsG8nnNmo8M=; b=Rv1BPNkXJKW3h+luLCzqlYXI1q
	QN0jNhh/NCN206mIwtPuAsKH9cclqkdLOoECHtmUMkyrKjCdoL3GfguGScoSWbAqAHopDb6f0fs2y
	VG1xNBqV2bPtYau+wga6iOH7YiZZ78S1RG2dYVUyntWOMl6ovwTpvJXM6911QpWeGDr8o1xDtRGtY
	SOJjy6VayTOljwJTI06qUf0AprwnzODVPkdxxZ4Pr/2SY03TzjTjYmiZvA68rdDR/Yv32qXGwFEV1
	NokpzRPoHyLM0G2EIdiU0UBC1F4j69YMxIwtZ8CglDottorjZqYBwvMg/4sc2CO3wwwpb6nPyMRki
	InyhB9/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVQXT-008Hny-6m; Tue, 06 Sep 2022 04:50:19 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVQXR-008HTy-SL
	for linux-nvme@bombadil.infradead.org; Tue, 06 Sep 2022 04:50:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=05njV07sJBMDroait06pY76fcRd4k+pymsG8nnNmo8M=; b=TYYWbbKjVYP6QfnTxhI4W44na5
	d0mP6NvWV0XoIhiwuNpfFLt5UIyCEobXdwrUE67yhjsB6plYLwsMTIWlwZUf6MVrG9Lln9ehwrnCf
	qdGt4PCH0YHWg9a2+OG6qCTnDbzUarqIZ/ky2Ll0bruJ5JKmkjU90UqyBQRz5X6uYPIomE4fxTpEK
	bTJNmlqw/uVWe/JtV+3XV5UyE3wnD6/h36y15Qs21HumRNuMb53g4+2yDiOp/UO1kjecQ6BnmvRnt
	AysnKPvfJ3WQRT5/fqfD34SpwBCrp0Dj0J3tyJtxZsFgkhOKBOsnpEuTMutGwfsY6sNj0c/Fd3rEt
	8Nyzv8kw==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVQXN-00A4zT-F9
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 04:50:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 550CD68AFE; Tue,  6 Sep 2022 06:49:41 +0200 (CEST)
Date: Tue, 6 Sep 2022 06:49:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] nvme: make NVMe freeze API reliably
Message-ID: <20220906044941.GB32525@lst.de>
References: <20220821084754.340585-1-ming.lei@redhat.com> <20220821084754.340585-2-ming.lei@redhat.com> <e2568bdd-a3cb-7a94-8018-d1468f3dcdd4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2568bdd-a3cb-7a94-8018-d1468f3dcdd4@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_055014_675095_B399527D 
X-CRM114-Status: GOOD (  12.38  )
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

On Thu, Aug 25, 2022 at 06:02:33PM +0800, Chao Leng wrote:
>
>
> On 2022/8/21 16:47, Ming Lei wrote:
>> From: Keith Busch <kbusch@kernel.org>
>>
>> In some corner cases[1], freeze wait and unfreeze API may be called on
>> unfrozen queue, add one per-ns flag of NVME_NS_FREEZE to make these
>> freeze APIs more reliably, then this kind of issues can be avoided.
>> And similar approach has been applied on stopping/quiescing nvme queues.
> This leads to another problem: the process that needs to be
> in the frozen state is not actually frozen.

Where do frozen processes come into play here?

