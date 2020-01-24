Return-Path: <SRS0=TgIa=3N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762DEC2D0DB
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2020 18:29:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D86B20709
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2020 18:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GpuUvOMn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hM2AU2wh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D86B20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B2rUfAGr1v/RYD0eswBtwBGrGis4qTr6zIZnQqE6UCc=; b=GpuUvOMnBLmci4
	cEr9XsePubi3iatJ/by5bzkJnNOwxvzT/YzmYWVBSApw797KiLFNbkoNJowd8P2k9nZmKwspKrWgT
	ESq7tF2b1Ef2tCWBbb+fyyLJU3vk+RhTJ9u7mKgWLQpKiffmjxsTLt+oy8alFM6bbwfnqXDKZkDmO
	NYpfNgSENjwNfhagTaCVYijU9ActObXZSemk8+CsJ7ewNua0njdwy9l2PFIK6UWC6hoSomR76DyWz
	Ys5z5KV8pMUYZWzZ5/wQexcjtVf9N0GeV3W+QupGcc2Fb+vpQ3AmLgVOShLQL/dtME6NoWiS0Eqta
	cNPZ4bo1Vgb5Y/DIzoYw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iv3i3-0004aa-U0; Fri, 24 Jan 2020 18:29:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iv3hx-0004YT-Kr
 for linux-nvme@lists.infradead.org; Fri, 24 Jan 2020 18:29:34 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E1B6320709;
 Fri, 24 Jan 2020 18:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579890569;
 bh=vHNfRVWwqfzV3PwS6VKTReQ+d3KpOWPqXs+y3ozbVtU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hM2AU2wheyUty8uvnf+lkRGTkhXz6YioBYakBckN4m3S9qkHhSAEcvIeHAC5pP0uo
 QZSF+l9ChqY2yUGNW7nuelj/GheBkjM7i/+DO4jeB8jIWZ2jfEOgHeyKvbix0Ja1yC
 hfhsgQFuMEFBw5rLSfNyHRakp/3Qdw1eossMR30M=
Date: Sat, 25 Jan 2020 03:29:26 +0900
From: Keith Busch <kbusch@kernel.org>
To: Edmund Nadolski <edmund.nadolski@intel.com>
Subject: Re: [PATCH v2 1/1] nvme: clear io tags when freeing tagset
Message-ID: <20200124182926.GB19243@redsun51.ssa.fujisawa.hgst.com>
References: <20200123201947.4482-1-edmund.nadolski@intel.com>
 <20200123201947.4482-2-edmund.nadolski@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200123201947.4482-2-edmund.nadolski@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200124_102931_059058_6C422669 
X-CRM114-Status: UNSURE (   7.20  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 23, 2020 at 01:19:47PM -0700, Edmund Nadolski wrote:
> A tagset is invalidated by blk_mq_free_tag_set, so nvme_free_tagset must
> clear nvmeq->tags for the io queues. A subsequent nvme_init_hctx will
> re-init the tags if/when needed.
> 
> Signed-off-by: Edmund Nadolski <edmund.nadolski@intel.com>

Thanks, applied for-5.6.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
