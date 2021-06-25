Return-Path: <SRS0=COHi=LT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6361C2B9F4
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Jun 2021 12:22:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861F46162F
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Jun 2021 12:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861F46162F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JWFG7QvtIGZxAn/GisuILhdwYb9HgC8N8JBrfeFsCeM=; b=R1u03WcDU8XwmZ
	/gtQAk86RfzHtG6pO3/wUPQelZw4sVrzXSrDhS2ubbvFuqqWX6CbsI/PZ6Jq8wduLkSHPIDBinEDG
	2v/jyhtQBuKdBuf8rkqiDRtt6/qs4Q/7w+TsRH5adLGvFrP+tUrY9NRffi7uxEA4RF0lKg5ldmye0
	/81xyNCATeoWrYJp1HFPekEX1zV8n12/ZDswKNsvm0nocf7ri41+Jq4xa4yNum8dB9VWIypUxrbxt
	vgr5UOhmzcYrdDKMuba3IW/IVQHwgGIULD61nNkeHo4I/jUykkc4P+iBBDh5gd84EqHTyoWX07cCA
	xA2JPZQk6SXGEklAwN7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwkqP-001QKk-Bt; Fri, 25 Jun 2021 12:22:01 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwkqM-001QK0-Cu
 for linux-nvme@lists.infradead.org; Fri, 25 Jun 2021 12:22:00 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D04B421C99;
 Fri, 25 Jun 2021 12:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624623716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pAj1upETTIyHAZ/PkSRbshacc33JaBnwwpRJoNDa32c=;
 b=xyc6A4xctkd1tWu+GXqPEdu8UDgKldkATgON6UUtpNfDsstz8y7+RMNMAPpMdKgiD/Koce
 F8x6TQD1OA2Geetl2U4zF2ZnQNM82njAjVvey26iyUOURCUX2JRuXuoNFTO0BliMlAZ0vq
 XmkRALVOoiaGm9frJudpdSZvVXlMy6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624623716;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pAj1upETTIyHAZ/PkSRbshacc33JaBnwwpRJoNDa32c=;
 b=kfcmTV4mrN8XaQoL843ZMEYuw2Xgtc3ZZTjlz7IJmlEXmhN0pJSl7OlAy4Lk/v/iW5Cwjs
 X1lvSo5naec9mnCQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id BEB6511A97;
 Fri, 25 Jun 2021 12:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624623716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pAj1upETTIyHAZ/PkSRbshacc33JaBnwwpRJoNDa32c=;
 b=xyc6A4xctkd1tWu+GXqPEdu8UDgKldkATgON6UUtpNfDsstz8y7+RMNMAPpMdKgiD/Koce
 F8x6TQD1OA2Geetl2U4zF2ZnQNM82njAjVvey26iyUOURCUX2JRuXuoNFTO0BliMlAZ0vq
 XmkRALVOoiaGm9frJudpdSZvVXlMy6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624623716;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pAj1upETTIyHAZ/PkSRbshacc33JaBnwwpRJoNDa32c=;
 b=kfcmTV4mrN8XaQoL843ZMEYuw2Xgtc3ZZTjlz7IJmlEXmhN0pJSl7OlAy4Lk/v/iW5Cwjs
 X1lvSo5naec9mnCQ==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id /xKJLWTK1WBmRQAALh3uQQ
 (envelope-from <dwagner@suse.de>); Fri, 25 Jun 2021 12:21:56 +0000
Date: Fri, 25 Jun 2021 14:21:56 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 0/2] Handle update hardware queues and queue freeze more
 carefully
Message-ID: <20210625122156.x5yzoobuaaec5hss@beryllium.lan>
References: <20210625101649.49296-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210625101649.49296-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210625_052158_637769_80112D50 
X-CRM114-Status: GOOD (  21.93  )
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

On Fri, Jun 25, 2021 at 12:16:47PM +0200, Daniel Wagner wrote:
> this is a followup on the crash I reported in
> 
>   https://lore.kernel.org/linux-block/20210608183339.70609-1-dwagner@suse.de/
> 
> By moving the hardware check up the crash was gone. Unfortuntatly, I
> don't understand why this fixes the crash. The per-cpu access is
> crashing but I can't see why the blk_mq_update_nr_hw_queues() is
> fixing this problem.
> 
> Even though I can't explain why it fixes it, I think it makes sense to
> update the hardware queue mapping bevore we recreate the IO
> queues. Thus I avoided in the commit message to say it fixes
> something.

I just discussed this with Hannes and we figured out how the crash is
fixed by moving the blk_mq_update_nr_hw_queues() before the
nvme_fc_create_hw_io_queues()/nvme_fc_connect_io_queues().

First of all, blk_mq_update_nr_hw_queues() operates on the normal
tag_set and not the admin_tag_set. That means when we move the
blk_mq_update_nr_hw_queues() before the nvme_fc_connect_io_queues(), we
update the mapping to only CPUs and hwctx which are available. When we
then do the connect call nvmf_connect_io_queue() we will only allocate
tags from queues which are not in the BLK_MQ_S_INACTIVE anymore. Hence
we skip the blk_mq_put_tag() call.

> Also during testing I observed the we hang indivinetly in
> blk_mq_freeze_queue_wait(). Again I can't explain why we get stuck
> there but given a common pattern for the nvme_wait_freeze() is to use
> it with a timeout I think the timeout should be used too :)

The nvme_wait_freeeze() is probably not needed at all,
__blk_mq_update_nr_hw_queues() already calls blk_mq_freeze_queue(). So
there this is not needed at all. Furthermore, if we move
blk_mq_update_nr_hw_queues() in front of nvme_fc_create_hw_io_queues()
there can't be any pending I/Os because there are not queues.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
