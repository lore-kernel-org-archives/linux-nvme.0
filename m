Return-Path: <SRS0=JmHd=3K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151D2C2D0CE
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jan 2020 17:32:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCEAC206A2
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jan 2020 17:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sEmssmt1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEAC206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fyzlMosAjOnDXKrrQtJDcYsdiWQo8fZZWX7cwkw9/AA=; b=sEmssmt1ETKGldDmb9AbQ9DOl
	m9vtq4Dz2+VR5oVxtkfpMtAYzqG7Z1AbpLw3KfxZzCVxOi4YaaLjsVjt+cBvWn6TUa4/n/ZnVJQTT
	23lE1M+1fpKV38/r4yTWmty6lmHwcDAvWuYnLg1xvgpTToMXjLrdbRiTPLvBnVv/0j2O2WmHhMQbe
	vCuWBkWWGR9U69X2a4aIKO9vXPol5mSvaRmHl/oXcuWA5Vgp2i7KkwRXhknNeyHwXYTLWjQlEFLEq
	i8B9OiCJnz8I5c4rV/cRaxOsyRXAKxjqDJfDpT3xPQ1lnR43jfKJRG1l4Y/SSZohW8nIqQKw/iXYe
	xw5YlfUWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1itxOD-0008GU-Qn; Tue, 21 Jan 2020 17:32:33 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1itxO6-0008Fr-9K
 for linux-nvme@lists.infradead.org; Tue, 21 Jan 2020 17:32:31 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Jan 2020 09:32:23 -0800
X-IronPort-AV: E=Sophos;i="5.70,346,1574150400"; d="scan'208";a="374656745"
Received: from unknown (HELO [10.232.112.49]) ([10.232.112.49])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 21 Jan 2020 09:32:22 -0800
Subject: Re: [PATCH] nvme: clear stale nvmeq->tags after tagset free
To: Keith Busch <kbusch@kernel.org>,
 "Nadolski, Edmund" <edmund.nadolski@intel.com>
References: <20200114181745.2297-1-edmund.nadolski@intel.com>
 <20200116160602.GA28993@redsun51.ssa.fujisawa.hgst.com>
 <0ff9ee57-0211-0170-7c58-a6c5d9354beb@intel.com>
 <20200116232619.GA29624@redsun51.ssa.fujisawa.hgst.com>
From: "Nadolski, Edmund" <edmund.nadolski@intel.com>
Message-ID: <12dc944f-d28c-3946-3dcd-28c45c1d2892@intel.com>
Date: Tue, 21 Jan 2020 10:32:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200116232619.GA29624@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200121_093226_341891_126F3838 
X-CRM114-Status: GOOD (  17.80  )
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
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/16/2020 4:26 PM, Keith Busch wrote:
> On Thu, Jan 16, 2020 at 03:06:40PM -0700, Nadolski, Edmund wrote:
>> On 1/16/2020 9:06 AM, Keith Busch wrote:
>> > On Tue, Jan 14, 2020 at 11:17:45AM -0700, Edmund Nadolski wrote:
>> > > +static void nvme_exit_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
>> > > +{
>> > > +	struct nvme_queue *nvmeq = hctx->driver_data;
>> > > +
>> > > +	nvmeq->tags = NULL;
>> > > +}
>> > 
>> > If you've multiple namespaces, disconnecting one of them will cause the
>> > shared nvmeq to have NULL tags, which will crash the kernel on the very
>> > next CQE read.
>> 
>> Currently it crashes with just a single namespace, because the nvmeq->tags
>> is still pointing into a tagset that was previously released by calling
>> nvme_free_tagset() from nvme_reset_work().
>> 
>> Perhaps the driver should not free the tagset unless & until there are no
>> more namespaces?  Is nvme_remove_namespaces() supposed to ensure that?
> 
> Looks like we'd need to clear all the nvmeq tagset pointers in
> nvme_free_tagset() we're called from the reset work.

The tagset pointer gets invalidated when the driver calls the following:

nvme_reset_work()
    +-> nvme_setup_io_queues()  <<< cmd fails, no io queues created
    +-> nvme_kill_queues()
    +-> nvme_remove_namespaces()
    |   +-> nvme_ns_remove()  <<< for each ctrl->namespaces
    |       +-> del_gendisk()
    |       +-> blk_cleanup_queue()
    |       |   +-> blk_mq_exit_queue()  <<< invalidates the tags
    |       |       +-> blk_mq_del_queue_tag_set()
    |       |       +-> blk_mq_exit_hw_queues()
    |       |           +-> blk_mq_exit_hctx()
    |       |               +-> set->ops->exit_hctx(...) <<< driver callback
    |       +-> nvme_put_ns()
    +-> nvme_free_tagset()
    |   +-> blk_mq_free_tagset()
    +-> nvme_start_ctrl()  <<< allow operation w/o namespaces

So the nvmeq->tags is already dead and stale by the time we get to 
nvme_free_tagset. The exit_hctx callback seems like the architected place to 
clear it (also noting that we init it in nmve_init_hctx).

If we don't clear the stale nvmeq->tags from the exit_hctx callback, then we 
will never re-init with a valid one if/when the device does recover (i.e., in 
a future call into nvme_init_hctx).

Seems we should not need to worry about crashing in the presence of multiple 
namespaces, as this is the sequence that removes them all (notwithstanding 
some existing race window bug).

Thanks,
Ed

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
