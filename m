Return-Path: <SRS0=JmHd=3K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BA2C2D0CE
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jan 2020 19:27:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8721F2073A
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jan 2020 19:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WdXhTlEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8721F2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=a26yJDEyl6B34YPP0l0s3rGk4rvXX+rM0dHQalwrTxs=; b=WdXhTlEaHlzefjT99UhRcJR1I
	h2nyytdbxfZ9vMjzIRZ84lwwAN/YvWD7VwOS778NZ9nivnzwY0wbKRHADFwc5NPQt4W6CzG2R5WKF
	07gNvkYvDEGVCDmCqghV4Hspvyq3avwGRcniWqqmSGclk+n65vYdrZ+s/MK50zwngg1VUT/XwzDSn
	flFYI68z3l7WhLW0uQ5JKkbfM9IH+gIE9KWv84DDt2ZUdVwb2TmWUuowvo8l//b2Ts7wHTggKFpsW
	+yUUHTgDNH8FZMydblsPcoBeb4BJEnEN4n5jxlmUoU8J3iT9AvtjPMIQwodM5SHQeHSQyZjIX+OLZ
	o/JqfcbQg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1itzB3-0006H9-Vl; Tue, 21 Jan 2020 19:27:05 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1itzAw-0006GH-Vj
 for linux-nvme@lists.infradead.org; Tue, 21 Jan 2020 19:27:05 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Jan 2020 11:26:57 -0800
X-IronPort-AV: E=Sophos;i="5.70,347,1574150400"; d="scan'208";a="374691282"
Received: from unknown (HELO [10.232.112.49]) ([10.232.112.49])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 21 Jan 2020 11:26:57 -0800
Subject: Re: [PATCH] nvme: clear stale nvmeq->tags after tagset free
To: Keith Busch <kbusch@kernel.org>,
 "Nadolski, Edmund" <edmund.nadolski@intel.com>
References: <20200114181745.2297-1-edmund.nadolski@intel.com>
 <20200116160602.GA28993@redsun51.ssa.fujisawa.hgst.com>
 <0ff9ee57-0211-0170-7c58-a6c5d9354beb@intel.com>
 <20200116232619.GA29624@redsun51.ssa.fujisawa.hgst.com>
 <12dc944f-d28c-3946-3dcd-28c45c1d2892@intel.com>
 <20200121174235.GA4954@redsun51.ssa.fujisawa.hgst.com>
 <0fd26a56-d57c-eeae-52b0-a80b64943bdb@intel.com>
 <20200121191234.GB4954@redsun51.ssa.fujisawa.hgst.com>
From: "Nadolski, Edmund" <edmund.nadolski@intel.com>
Message-ID: <4a1335e0-1192-ac1e-cb4b-9da9f926e68d@intel.com>
Date: Tue, 21 Jan 2020 12:26:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200121191234.GB4954@redsun51.ssa.fujisawa.hgst.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200121_112659_037822_847697BE 
X-CRM114-Status: GOOD (  15.44  )
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

On 1/21/2020 12:12 PM, Keith Busch wrote:
> On Tue, Jan 21, 2020 at 11:49:53AM -0700, Nadolski, Edmund wrote:
>> On 1/21/2020 10:42 AM, Keith Busch wrote:
>> > On Tue, Jan 21, 2020 at 10:32:22AM -0700, Nadolski, Edmund wrote:
>> > > The tagset pointer gets invalidated when the driver calls the following:
>> > > 
>> > > nvme_reset_work()
>> > >    +-> nvme_setup_io_queues()  <<< cmd fails, no io queues created
>> > >    +-> nvme_kill_queues()
>> > >    +-> nvme_remove_namespaces()
>> > >    |   +-> nvme_ns_remove()  <<< for each ctrl->namespaces
>> > >    |       +-> del_gendisk()
>> > >    |       +-> blk_cleanup_queue()
>> > >    |       |   +-> blk_mq_exit_queue()  <<< invalidates the tags
>> > >    |       |       +-> blk_mq_del_queue_tag_set()
>> > >    |       |       +-> blk_mq_exit_hw_queues()
>> > >    |       |           +-> blk_mq_exit_hctx()
>> > >    |       |               +-> set->ops->exit_hctx(...) <<< driver callback
>> > >    |       +-> nvme_put_ns()
>> > >    +-> nvme_free_tagset()
>> > >    |   +-> blk_mq_free_tagset()
>> > >    +-> nvme_start_ctrl()  <<< allow operation w/o namespaces
>> > > 
>> > > So the nvmeq->tags is already dead and stale by the time we get to
>> > > nvme_free_tagset.
>> > 
>> > No, nvmeq->tags is not stale until we call nvme_free_tagset().
>> 
>> I see this in blk/blk-mq.c:
>> 
>> 2943 /* tags can _not_ be used after returning from blk_mq_exit_queue */
>> 2944 void blk_mq_exit_queue(struct request_queue *q)
> 
> You can't access it through q->tag_set after that. The tagset still
> exists beyond any individual request_queue using it until you call
> blk_mq_free_tag_set().

Ah ok, well that's subtle ;)  (I guess it works as long as blk-mq guarantees 
the tagset lifetime.)

I'll rework the patch to clear the pointers from nvme_free_tagset, as you 
mentioned previously.


>> which ends up being called on every individual ctrl->namespaces entry.  What
>> have I overlooked?
> 
> There are various paths that can have driver can remove a subset of
> namespaces rather than all of them. Is that what you're overlooking?

Yes, I should have looked into all the callers of nvme_ns_remove.

Thanks,
Ed


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
