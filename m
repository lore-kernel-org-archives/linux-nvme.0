Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3801E77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 09:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9DYBRILLrYCDskqfh82ITgdib2vL3UC1xp6lkia/84E=; b=b2LBqUiMF2fztrxbhgY2cZKz8Z
	POGhcyCX0dXuUN4YIbErYZ0A6j4GJoCT9wRS02Q/wCBZJQ059KgY8AUooogrdtNYT8NTnSYooF+eB
	WDZyYRYPFJtbRL5ZIuuHxbx/v+wiuhxUxk1YRxBsTBby02dNn+WrDsUtBw30gHl9z9zIxFZR/EPQ/
	dLqNRzagUPtQKBPAdyHNu1RuRWA+xKvCZLbZYoqBxKHXR/+zhSegzEequjreyrJQoSWGY8vpL0+7C
	rHgM25HiWvti1eNri2LqZ+WmHuvSc4hdN6RV8fpeEZxKTPGFm1ckM6fmDw/0ufiK2Echk+wQQukt6
	/t6D1Mbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUjso-00000000ljz-0zph;
	Mon, 06 Jan 2025 09:58:50 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUjsl-00000000lij-21Et
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 09:58:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B4C355C56AF;
	Mon,  6 Jan 2025 09:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB94C4CED2;
	Mon,  6 Jan 2025 09:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736157525;
	bh=pZtgrDo+nGaUpROwpN3o7YDRFjlTkS87lF/JlVn3qJQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FiDI+147q160Bi843SaYzy9d4AtNwPX9gUZbFV+YWJJMqNltH7YwUBXdy9RdWmNTc
	 Zyr/ZCBHwBiLTxwipMZf8JpQ40DHIj0dqYL4sxk1NddzdLku7zYby69f1sS+BEvawW
	 w5wDkAD6wFWlRUwldwKVLHEIDYCFhCOANHwqwuHblpPKKNv5yBuq2zVnNPjg89joEG
	 Mk1BOuwv4+WxF4apKP1UVC2IoFT1hNGc1WgAUKnktZjS0siyTuvXQ/2jNVkipcZieL
	 nO+H0u1I3Z0L0fSnWv3kSBROslpp1EMCGjdPw9cOhJZH6NlaX3m8AizIfg4y/Gl2o7
	 NuR+drj6/r1Jg==
Message-ID: <30064337-9fe1-47c7-b4ec-c999b06a1b47@kernel.org>
Date: Mon, 6 Jan 2025 18:58:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: Fix __blk_mq_update_nr_hw_queues() queue
 freeze and limits lock order
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>,
 Nilay Shroff <nilay@linux.ibm.com>
References: <20250104132522.247376-1-dlemoal@kernel.org>
 <20250104132522.247376-3-dlemoal@kernel.org> <20250106083014.GD18408@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250106083014.GD18408@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_015847_653591_11120335 
X-CRM114-Status: GOOD (  17.78  )
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

On 1/6/25 5:30 PM, Christoph Hellwig wrote:
> On Sat, Jan 04, 2025 at 10:25:21PM +0900, Damien Le Moal wrote:
>> __blk_mq_update_nr_hw_queues() freezes a device queues during operation,
>> which also includes updating the BLK_FEAT_POLL feature flag for the
>> device queues using queue_limits_start_update() and
>> queue_limits_commit_update(). This call order thus creates an invalid
>> ordering of a queue freeze and queue limit locking which can lead to a
>> deadlock when the device driver must issue commands to probe the device
>> when revalidating its limits.
>>
>> Avoid this issue by moving the update of the BLK_FEAT_POLL feature flag
>> out of the main queue remapping loop to the end of
>> __blk_mq_update_nr_hw_queues(), after the device queues have been
>> unfrozen.
> 
> What happens if I/O is queued after the unfreeze, but before clearing
> the poll flag?

Ah, yes, that would potentially be an issue... Hmmm... Maybe a better solution
would be to move the start update out of the main loop and do it first, before
the freeze. What I do not fully understand with the code of this function is
that it does freeze and limit update for each tag list of the tag set, but
there is only a single request queue for all of them. So I am confused. Why
does the blk_mq_freeze_queue and poll limit setting have to be done in the loop
multiple times for each tag list ? I do not see it... If we can move these out
of the tag list loops, then correcting the ordering becomes easy.

-- 
Damien Le Moal
Western Digital Research

