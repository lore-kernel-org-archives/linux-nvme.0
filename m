Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6A4C25B48
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Oct 2023 16:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:Subject:References:To:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/mXC9bpUx2Gvbo/mBVlA9B3vXJ27xvmvay5KtVeD8F0=; b=SgugA6Y28z7dtnYvuBK28CchHS
	tSwTwuXBCRWHUp5ThluYyQYpLEo47N6KBCINgsAZpg3zAQkhL86T1cCxmwHcDeyR6pWbPRUfuMBjI
	umVB7GbLP1MhuN1Pk2G4eDgcQr75PsGjD9mBlBVfIPcs7X6GNey2PyxPADNcUHcZuZrPm21h1rqDC
	wew3+uJJWaDuNigGjkF/cc0z6jgTJu6egGuI6qkyP2d7RMQ6YYCJyzkFjSfspTSPxG9vOQNNIXDWL
	tJGxVEiAWX66Unt0FJU6QUaVlHc4hh+T7dt40MfI25BCEi65FzQACuOm9juJS1yXoAA3rciVsEUJN
	KMo9h6Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qw2mQ-00Epvs-0c;
	Thu, 26 Oct 2023 16:00:18 +0000
Received: from mout01.posteo.de ([185.67.36.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qw2mN-00EpvG-0c
	for linux-nvme@lists.infradead.org;
	Thu, 26 Oct 2023 16:00:16 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id DCFD524002A
	for <linux-nvme@lists.infradead.org>; Thu, 26 Oct 2023 18:00:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1698336010; bh=gz/q15Y5IBQAkezeX51l8pavF3vtCfpmitE2egjYVnU=;
	h=Message-ID:Date:MIME-Version:To:Subject:From:
	 Content-Transfer-Encoding:From;
	b=m3uPCOJt+v4anvH/pFqT/00kHMTfDkhcqd1Z/YCAwhv6g34RZFCBKxZsPFcMU5zRB
	 0EeWgpDT4JzxeXk9I6YY/ElIBCzEnF5iVf2twNiwYwQqFs2kOmVezCBGLcdj71mhHY
	 j8QSbaGfDXpif8Xciun04cw+VUdOOazyBa7868uIbr0/illwPBN9oK9vlL72H3jvfn
	 dgx8NATpcjNPlraDUcPjKo71/QoW920993aisJ5KJQQ46ISoZuWDqNgPZZSNxye596
	 JSfuXQby/dKgW166uWg6Eqpf5BYuXbqU5ynvXkMyn/lqM8bwFx8CFvdYba/66MAIkh
	 QETxC/34nPpGQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4SGVqt1jkCz6tws
	for <linux-nvme@lists.infradead.org>; Thu, 26 Oct 2023 18:00:09 +0200 (CEST)
Message-ID: <0fdbf818-348e-4441-9bb2-28d6fd3aca49@posteo.net>
Date: Thu, 26 Oct 2023 16:00:08 +0000
MIME-Version: 1.0
To: linux-nvme@lists.infradead.org
References: <20231024061337.35621-1-hare@suse.de>
Subject: Re: [PATCHv2 0/3] nvme: start keep-alive after admin queue setup
Content-Language: en-US
From: Mark O'Donovan <shiftee@posteo.net>
In-Reply-To: <20231024061337.35621-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231026_090015_389442_C837947D 
X-CRM114-Status: UNSURE (   6.18  )
X-CRM114-Notice: Please train this message.
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

Hi Hannes,

Testing with v1 of this patchset definitely seems
to have solved the problem.
With a 5s kato the connection below would have timed out.

The column to the left of ctrl/chap is milliseconds
since admin queue connect:

[  229.079675][  T640] nvme nvme0: qid 0: authenticated
[  229.087243][  T640] 00000169: ctrl:000000001221a9b6     <NEW KEEP-ALIVE START TIME>
[  229.091241][  T640] nvme nvme0: creating 16 I/O queues.
[  229.257482][  T112] 00000340: chap:00000000db978430 q01 nvme_queue_auth_work auth successful
[  229.412266][  T112] 00000494: chap:0000000062bd76c8 q02 nvme_queue_auth_work auth successful
...
[  231.425002][  T112] 00002507: chap:0000000051ca4f9a q15 nvme_queue_auth_work auth successful
[  231.579549][  T112] 00002662: chap:0000000008e8cfab q16 nvme_queue_auth_work auth successful
[  231.582339][  T640] <OLD KEEP-ALIVE START TIME>
[  231.832703][  T112] 00002915: ctrl:000000001221a9b6     nvme_keep_alive_work sending keep-alive


I have encountered another issue on my qemu vm where the first
call after power up to nvme_auth_process_dhchap_challenge() takes
almost 3s. The delay comes from crypto_alloc_tfm_node().
This patchset does not solve that particular problem.
I have submitted the patch below for it, but both would be required in
my opinion.

http://lists.infradead.org/pipermail/linux-nvme/2023-October/042862.html

Regards,
Mark

