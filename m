Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF086C61DD6
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 10:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BRN6sSMREUq9qGEwmYD2DEU4pm6R9ZTIUzVK89a+BjY=; b=n2dF2CS/B2Yk1CljNRa8w3EnI3
	1SxojXuzvL2r2MspPIxY9t1GpRVXV1pb5VtLDwBr2mdPVJoOml45L6lIESUE4R7zmpukol8z5UmGB
	17sPsZWrWdLJEKhyRbn7y8R6VolCIpGbOPznGuuXy6L62KRTmM0O09+LcqDmzlILg5S/QCZoGC52+
	FJU5enyVQi1Kl6WF+qkHrhHHgw9Qi5+kIPQBim499C+MYNr6/hMlUOpBcSOWfizESLGjC1/xyZUS5
	z+pODL1YtEh9RalPAIXWRc9zkBOWkxvZKdzQPu1zBiGnxxosSqu7DiA+vn6y69PajPrwbXmqRuAFv
	4tgr1t6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1iQZ-0000000ENct-3NIb;
	Wed, 02 Sep 2026 10:42:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1iQX-0000000ENc6-2wL8
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 10:42:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7C2326732A; Wed,  2 Sep 2026 12:42:41 +0200 (CEST)
Date: Wed, 2 Sep 2026 12:42:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: raoxu <raoxu@uniontech.com>, axboe@kernel.dk, hch@lst.de,
	kbusch@kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH nvme-7.3 3/4] nvme-fabrics: add helpers for subsystem
 and host identity options
Message-ID: <20260902104241.GC8206@lst.de>
References: <29BB44C32FF06823+20260821062142.1932160-1-raoxu@uniontech.com> <450E21059686C852+20260821062529.1936914-1-raoxu@uniontech.com> <e948f5e5-3e96-4467-a4dd-67316871cc7a@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e948f5e5-3e96-4467-a4dd-67316871cc7a@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_034245_888640_286BCDEE 
X-CRM114-Status: GOOD (  15.73  )
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

On Sun, Aug 23, 2026 at 01:11:56AM +0300, Sagi Grimberg wrote:
>
>
> On 21/08/2026 9:25, raoxu wrote:
>> From: Xu Rao <raoxu@uniontech.com>
>>
>> The nqn, hostnqn and hostid options also start with match_strdup(), but
>> unlike the direct string replacements handled by nvmf_parse_string_option()
>> they perform option-specific validation or conversion before parsing is
>> complete.
>
> Does this warrant that they get a special handler? I am not sure I see how 
> this helps.

That doesn't.  But the fact that nvmf_parse_options is more than 400
lines in the current upstream tree is.  For non-trivial parsers
using switch statements, the code flow tends to be a lot nice when
every case is split out into a helper and not in the containing function.


