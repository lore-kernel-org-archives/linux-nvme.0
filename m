Return-Path: <SRS0=ljDk=B2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1705C433E1
	for <linux-nvme@archiver.kernel.org>; Sun, 16 Aug 2020 13:51:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 831EB20708
	for <linux-nvme@archiver.kernel.org>; Sun, 16 Aug 2020 13:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YFDjU4/J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcIXJ1m/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831EB20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=psR8ctgM+C3BtDJRjE/C28qSyfLVDbdWH9+ou5cFCYs=; b=YFDjU4/JwWeAHu0blCZDWa5mf
	nQ/fRkjWL96cqJ9BnGljl9wFT6ed98dqwPKcuhjvTNG5CvaRJZ5qxojgTvDEWruDgmlq+VtUhbm7k
	RCYNSH/abJNYT3ifNJvTWNAaVZkQxzHJegqXx3e+9DBQ5/iFeI0wNemEqQl2OjgEIsxM2gyKFt7a3
	iaiosNclJxoXdtaDGJFxF2dPqqpMOMjnG9nxEy4h9SC8F0IWKJzrjP4til9Op3xofjjkA75y+TRh2
	/xCjXTAMoCLO3+BgrjGGHYx52Q4/yxoAvkrT+Kptv5PTPx1/nFS9PGYwywpjXB9gEGbc2Ykk6SN4u
	LsMXMNXWQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7J3n-0006ec-Dt; Sun, 16 Aug 2020 13:50:55 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7J3f-0006eB-4o
 for linux-nvme@lists.infradead.org; Sun, 16 Aug 2020 13:50:48 +0000
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A0F4620708;
 Sun, 16 Aug 2020 13:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597585843;
 bh=r5pCUfa+7GL4gvMpA6LRaUpmJ+k+6F3pLpgO3AsGBSc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IcIXJ1m/11WVz17PkicGhPZwiDKLAHg/eDa+E8BGdOl1IBp5Be/eQDep5QcmIesQK
 D1mNV2pP53kE2UTreAa3r9JB0NoUqwQ5Z94svNW9L6y3YpdfsQksmCkiIez4fNWBN3
 CdMRfV8AEpBpgSPbYWpmN5Pw9Aqb3wLVzATjvJEk=
Date: Sun, 16 Aug 2020 09:50:42 -0400
From: Sasha Levin <sashal@kernel.org>
To: Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH AUTOSEL 5.8 70/72] nvme-multipath: do not fall back to
 __nvme_find_path() for non-optimized paths
Message-ID: <20200816135042.GU2975990@sasha-vm>
References: <20200808233542.3617339-1-sashal@kernel.org>
 <20200808233542.3617339-70-sashal@kernel.org>
 <1899fe01e1eb5c23270541e1833b12365818c150.camel@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1899fe01e1eb5c23270541e1833b12365818c150.camel@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200816_095047_377183_1F22AADE 
X-CRM114-Status: GOOD (  14.08  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, stable@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 10, 2020 at 05:37:54PM +0200, Martin Wilck wrote:
>On Sat, 2020-08-08 at 19:35 -0400, Sasha Levin wrote:
>> From: Hannes Reinecke <hare@suse.de>
>>
>> [ Upstream commit fbd6a42d8932e172921c7de10468a2e12c34846b ]
>>
>> When nvme_round_robin_path() finds a valid namespace we should be
>> using it;
>> falling back to __nvme_find_path() for non-optimized paths will cause
>> the
>> result from nvme_round_robin_path() to be ignored for non-optimized
>> paths.
>>
>> Fixes: 75c10e732724 ("nvme-multipath: round-robin I/O policy")
>> Signed-off-by: Martin Wilck <mwilck@suse.com>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  drivers/nvme/host/multipath.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>
>Hello Sasha,
>
>this patch needs a fix that I recently submitted to linux-nvme.
>The same holds for the respective 5.7 and 5.4 AUTOSEL patches.
>
>http://lists.infradead.org/pipermail/linux-nvme/2020-August/018570.html

I'll grab it too, thanks!

-- 
Thanks,
Sasha

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
