Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5797EC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 20:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1hYqy95ndGyqxRulx42wl25ri7vbyLsb209CHswx1yM=; b=up+9c41/mVKj6zdG3V/TDU0kbA
	6pI55xQKKK6K8eJYbpG1YiwmzP3teiW2I67QYjMPUd5qvaP9p6cbuPMQGvKbyYlZOo+IPjxDS1xg7
	Mbl+/ExXCmfXxItLLR5aaCxA/OJquw6VsCf7aEcN/J1qdsKRRwwxEGdOidIkcgWrM2ag7OWiRIPfI
	Jh7EDX7iI57EeEmB4NDbJUC2NzlI0oDk3CqBtGFqlpNoy/NZ1nTic39L/A6d+HEX+itMepfY4faGW
	xlkXdAhuK3lNgaDyS3HhKcXg8YyOj4T1e9uAlF10ZwgG/g6KAgpYoj25Lw02VQHusr/bSnMGwpjX5
	n5RTAwGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxDp2-000J7D-4j; Mon, 21 Nov 2022 20:55:20 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxDoz-000J6Z-TQ
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 20:55:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 677BB6146B;
	Mon, 21 Nov 2022 20:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C9AC433C1;
	Mon, 21 Nov 2022 20:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669064115;
	bh=fklIbxjZ4fI2eVhvV7BHArTOHsla7HiRX/G/vPaCWDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vKeias75RFAq5FnOjzAFo4LzKn5mlz0z6IzA9llv1JdN1uJiPlNY/OP4keEvAwcxN
	 Rv8cvagu19/jpDaO5++d197rO8dtNIcQZFrabsoT3UjI3E0iPxN/RNRTmw3xkH+FGA
	 h4D9jI4V7p3p4aH8aOWN7i0gQarZ84BoUg9FLHZa2V2KTUfEZqU00BMdn9lSpfDnZt
	 wEX7aJao+vJu2StuvwctTL9EFevrADrLg4ggRqIW1RbVBTldmMPx4pHablsylSr0G8
	 wRYg09tfwn6+bfEjld5O3p4pLJfV5PrDuvM/SmNA6ObuHeIN59lMSxbCXM/l2oXyu2
	 9WPjuPjWtI+LQ==
Date: Mon, 21 Nov 2022 13:55:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jonathan Derrick <jonathan.derrick@linux.dev>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	"Shin\\'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2] tests/nvme: Add admin-passthru+reset race test
Message-ID: <Y3vlsF7KcRrY7vCW@kbusch-mbp>
References: <20221117212210.934-1-jonathan.derrick@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117212210.934-1-jonathan.derrick@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_125518_002350_0F7432E8 
X-CRM114-Status: GOOD (  19.06  )
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

On Thu, Nov 17, 2022 at 02:22:10PM -0700, Jonathan Derrick wrote:
> I seem to have isolated the error mechanism for older kernels, but 6.2.0-rc2
> reliably segfaults my QEMU instance (something else to look into) and I don't
> have any 'real' hardware to test this on at the moment. It looks like several
> passthru commands are able to enqueue prior/during/after resetting/connecting.

I'm not seeing any problem with the latest nvme-qemu after several dozen
iterations of this test case. In that environment, the formats and
resets complete practically synchronously with the call, so everything
proceeds quickly. Is there anything special I need to change?
 
> The issue seems to be very heavily timing related, so the loop in the header is
> a lot more forceful in this approach.
> 
> As far as the loop goes, I've noticed it will typically repro immediately or
> pass the whole test.

I can only get possible repro in scenarios that have multi-second long,
serialized format times. Even then, it still appears that everything
fixes itself after a waiting. Are you observing the same, or is it stuck
forever in your observations?

> +remove_and_rescan() {
> +	local pdev=$1
> +	echo 1 > /sys/bus/pci/devices/"$pdev"/remove
> +	echo 1 > /sys/bus/pci/rescan
> +}

This function isn't called anywhere.

