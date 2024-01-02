Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69CB7C46CD2
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jan 2024 23:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E6BfmPbVC7H4LMX1E6mpedqHC71z9oPx6FkitPNVIzk=; b=0DdfJfTEEWrWdYLMj9qyUFOKaV
	tfIa1BpldvKNUtb9hm6bjYuHLKVyY3pJlRjytLJIhTbcUyy2UDqxVSOeNzzNEGhd3jfrg0v+1Ik4e
	jCMUAB0UvX23A9NkYttHBHraEstvXWPE883SDb6MV4RjtoJLEIAp7luHZ0Df3jDNFosfVndnAth5n
	HmtiJ5W2PCvS2TApcJgxR5UYqBzpkpIOTUXuFwLr9CkdwlMg8uPHje9x1o1qpCmEyILBEVaHQRlHQ
	mPAcFEKMjEHFW6RJyfNsZlhtPMErUEQohslWg2oQhu6nzUxjmeG5sZgOOFnCeYeY55NmchOC5YYaN
	d21k6joQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKnvt-009HJ6-2Y;
	Tue, 02 Jan 2024 23:12:25 +0000
Received: from hr2.samba.org ([2a01:4f8:192:486::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKnvp-009HIN-2m
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jan 2024 23:12:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Cc:To:From:Date;
	bh=E6BfmPbVC7H4LMX1E6mpedqHC71z9oPx6FkitPNVIzk=; b=h3zrN52XG/ltsXVOLmVslmtE4w
	95XMzco9GArLpD5isX+2M0dGF0pvuo/RZFkhEMMIM9D0JFgsZfpEtPNEdJQhjNTuKStXsSmPJsTMm
	+T2B8RzqOjJUqSok0lywXl3qr/fqS66OF71rbxkWC3C8d7H8PkA7Agy8vmXQsV1v0/AwD99aIXvLh
	WVUFZIL2wSl9Ygj9shwygmrO93d9Pz7vGHZh2IRYO3HmxNOuNDnxH/QS9vF7JEwIbf+/Bd8HHrVEj
	i5GWyFlKTY8jfIJfyLvjq6aI3IZv+d8hGCmA9R0C9MlV/TU+uuJXMN1jF/I5nBUv/JCu8aUNJYicK
	u5aKrd8riMusP4Oi48vtxjfF4RnwjlL2VcFP5pR6ffMHxMXPHw3bfzR/R1XZjvjUDq6Xsg4BEyLkd
	rDA/BNsXE9JRELYJkKu+UE1MyM5c7vp/k6vIr1fOLyAA+EgzAyfYQZpvXXi1HnnHOgqbn6tmNto/j
	BEIeD62sDPNqC+QwrL3TjDt9;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1rKnvl-0068kT-02;
	Tue, 02 Jan 2024 23:12:17 +0000
Date: Tue, 2 Jan 2024 15:12:13 -0800
From: Jeremy Allison <jra@samba.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jeremy Allison <jallison@ciq.com>,
	tansuresh@google.com, hch@lst.de, gregkh@linuxfoundation.org,
	rafael@kernel.org, bhelgaas@google.com,
	linux-nvme@lists.infradead.org, jra@samba.org
Subject: Re: [PATCH 1/4] driver core: Support two-pass driver shutdown
Message-ID: <ZZSYTUuQAZtUBMT8@jeremy-HP-Z840-Workstation>
References: <20231227203337.GA1509884@bhelgaas>
 <1f55f4a5-24d4-437d-b2d7-5caecce3959f@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1f55f4a5-24d4-437d-b2d7-5caecce3959f@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_151221_922221_0B4E8970 
X-CRM114-Status: GOOD (  15.10  )
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
Reply-To: Jeremy Allison <jra@samba.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jan 01, 2024 at 11:23:05AM +0200, Sagi Grimberg wrote:
>
>>>From: Tanjore Suresh <tansuresh@google.com>
>>>
>>>This changes the bus driver interface with an additional entry point
>>>to enable devices to implement two-pass shutdown. The existing
>>>synchronous interface to shutdown is called, and if a shutdown_wait
>>>method is defined the device is moved to an alternate list.
>>>
>>>Once the shutdown method is called for all devices, the
>>>shutdown_wait method is then called synchronously for
>>>all devices on the alternate list.
>>
>>Christoph and Sagi noted that the objective is similar to "fire now
>>and wait for completion later."
>>
>>Would it be practical to actually *do* that, e.g., add a global
>>shutdown workqueue, have the .shutdown() method of nvme and similar
>>drivers add items to it, and have the driver core wait until
>>everything on that workqueue has completed?
>>
>>But I'm not a workqueue expert and I do see the scary warning at
>>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/workqueue.h?id=v6.6#n619,
>>about not flushing system-wide workqueues, so maybe this wouldn't be
>>workable.
>
>I don't think that a workqueue is necessary. What I do think that we
>should document somewhere that .shutdown() can be synchronous or
>asynchronous when paired with .shutdown_wait().

It's not exactly asynchronous when paired with .shutdown_wait().
That's why I used the phrase "two-pass" instead of asynchronous.

Also, I already added this documentation:

+ * @shutdown_wait: Optional driver callback to allow two-pass shutdown.

in the struct pci_driver comment definition in one of the
previous patches.


