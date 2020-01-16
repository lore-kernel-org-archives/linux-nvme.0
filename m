Return-Path: <SRS0=1/6V=3F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B953C33CB3
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2020 23:26:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C809B20684
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2020 23:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="a4mc2gFt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCJbfBsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C809B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6Gg4bBy4BHKOMuULk7mv+tBL7z4+NMgA0INCLWshxm4=; b=a4mc2gFtvpfP67
	h9Mkqjz7iDoxRolSbg6phREkfs53G095hT9UrBKtgrH8RPicHDjBBVElgcYjOFtun8gv3TG4hvAX0
	XNjfsIrWF0CrX6iwz941y4l+U0Jy8N3Fg6PSl57tDKRq4CJL9i9szOeh4NAUf4rjSuEt2y8R+e2rU
	dS+lFs9jlslaD8HSR+LsDc6Q63KoYlKhafTznmH+cC0yCLIVLShrbjFWJmKcvDjz+/2VCbt40rWHJ
	/b/p3uEgHwabbxyx1358FQ018Yg6LNVAUSIG5mIULZlVNplNDPJbx0gdO1wb1rb1uOL+riLErSSWq
	WsHWYFkrfTiINWVxFxQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1isEWy-0001qw-C7; Thu, 16 Jan 2020 23:26:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1isEWv-0001q2-OT
 for linux-nvme@lists.infradead.org; Thu, 16 Jan 2020 23:26:26 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 174D12072E;
 Thu, 16 Jan 2020 23:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579217185;
 bh=qKP1lkLMMAG/u0mgAdV9gh/9/aDfK+wvCYtGmt8XwK8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nCJbfBsFgyDp4kTm3q0u8jC7Xqx+00l1OqcqZKo7fNHWRjiKFq+PzLsnrEoW1KwYE
 YH54o8oR4cmZAbYUi4GjXeohEROjMhNoM4mRz6OXbpIN5MX2++br+/3Z5LzO8G5kef
 kNrqYqJhW/T3bGQ/+gRyIspmgwlmGfNnOWWdsORE=
Date: Fri, 17 Jan 2020 08:26:19 +0900
From: Keith Busch <kbusch@kernel.org>
To: "Nadolski, Edmund" <edmund.nadolski@intel.com>
Subject: Re: [PATCH] nvme: clear stale nvmeq->tags after tagset free
Message-ID: <20200116232619.GA29624@redsun51.ssa.fujisawa.hgst.com>
References: <20200114181745.2297-1-edmund.nadolski@intel.com>
 <20200116160602.GA28993@redsun51.ssa.fujisawa.hgst.com>
 <0ff9ee57-0211-0170-7c58-a6c5d9354beb@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0ff9ee57-0211-0170-7c58-a6c5d9354beb@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200116_152625_815789_5114674F 
X-CRM114-Status: GOOD (  12.96  )
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

On Thu, Jan 16, 2020 at 03:06:40PM -0700, Nadolski, Edmund wrote:
> On 1/16/2020 9:06 AM, Keith Busch wrote:
> > On Tue, Jan 14, 2020 at 11:17:45AM -0700, Edmund Nadolski wrote:
> > > +static void nvme_exit_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
> > > +{
> > > +	struct nvme_queue *nvmeq = hctx->driver_data;
> > > +
> > > +	nvmeq->tags = NULL;
> > > +}
> > 
> > If you've multiple namespaces, disconnecting one of them will cause the
> > shared nvmeq to have NULL tags, which will crash the kernel on the very
> > next CQE read.
> 
> Currently it crashes with just a single namespace, because the nvmeq->tags
> is still pointing into a tagset that was previously released by calling
> nvme_free_tagset() from nvme_reset_work().
> 
> Perhaps the driver should not free the tagset unless & until there are no
> more namespaces?  Is nvme_remove_namespaces() supposed to ensure that?

Looks like we'd need to clear all the nvmeq tagset pointers in
nvme_free_tagset() we're called from the reset work.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
