Return-Path: <SRS0=xDof=EZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAC6C388F9
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 21:11:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F61522255
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 21:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UFI88oGF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eX9gKLP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F61522255
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3QvpUoBW4aE8fxAI0N38Ji980aLUdVtwN0mQc7lPZ4M=; b=UFI88oGF4NNg9SLYuj4lpaiaR
	sXMswyMTV/zi/iNEyiI8e7uk0qu2/3RE90YizALqxtpRW2Ok1RcSXwmyMOOURQCvLhV7AKR/TZPef
	Cesk8igF6uCxSEx7lYHhSYzlkhqrgNlS29ZMADaeGA6mFFbf/jZ9fMUHWWiTPfrxgtP8ZyrJcZHiX
	XJMaq/MKl41AVhbNzER84oedI+Uajk0+Dgc3P9n05SiKcrxjGzpq9BBHZDA47F9beNABGExWyFYpN
	2VEaUu/IsUrC1FjMefZHJVVr1oc9eBimAZLo2ll2hlWAPKKQTi/hBkuN1o94V86m1Ew24ymRz4A2v
	rMuPpoutg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kfrCv-0003SQ-HM; Thu, 19 Nov 2020 21:11:09 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfrB8-0002ca-Vw
 for linux-nvme@lists.infradead.org; Thu, 19 Nov 2020 21:09:20 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E20E822255;
 Thu, 19 Nov 2020 21:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605820157;
 bh=wobWbrfe+CcBfAqh6g1sHmyepcpP3tuS6adaYB2sqNk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eX9gKLP40Y036drTN5kXwWv7ntyy0/4K4wht1FrMjOGTY7+WYClrYAi61GWWeUcda
 QHt7JNCDAr6UlQTfIXDfl21Z7SKYuakRPErWkTMlfS4eCZ50RmSNgrKPC6qDUs+005
 hO0pO+OriwUpiDtdlBoYNC2MLiaz7UCAEab/zPRg=
Date: Thu, 19 Nov 2020 13:09:14 -0800
From: Keith Busch <kbusch@kernel.org>
To: Tom Roeder <tmroeder@google.com>
Subject: Re: [PATCH] nvme: Cache DMA descriptors to prevent corruption.
Message-ID: <20201119210914.GB2855047@dhcp-10-100-145-180.wdc.com>
References: <20201119185919.2742954-1-tmroeder@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201119185919.2742954-1-tmroeder@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201119_160919_154343_A7A32A96 
X-CRM114-Status: GOOD (  23.60  )
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
 linux-nvme@lists.infradead.org, Marios Pomonis <pomonis@google.com>,
 Jens Axboe <axboe@fb.com>, Peter Gonda <pgonda@google.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Nov 19, 2020 at 10:59:19AM -0800, Tom Roeder wrote:
> This patch changes the NVMe PCI implementation to cache host_mem_descs
> in non-DMA memory instead of depending on descriptors stored in DMA
> memory. This change is needed under the malicious-hypervisor threat
> model assumed by the AMD SEV and Intel TDX architectures, which encrypt
> guest memory to make it unreadable. Some versions of these architectures
> also make it cryptographically hard to modify guest memory without
> detection.
> 
> On these architectures, Linux generally leaves DMA memory unencrypted so
> that devices can still communicate directly with the kernel: DMA memory
> remains readable to and modifiable by devices. This means that this
> memory is also accessible to a hypervisor.
> 
> However, this means that a malicious hypervisor could modify the addr or
> size fields of descriptors and cause the NVMe driver to call
> dma_free_attrs on arbitrary addresses or on the right addresses but with
> the wrong size. To prevent this attack, this commit changes the code to
> cache those descriptors in non-DMA memory and to use the cached values
> when freeing the memory they describe.
 
If the hypervisor does that, then the device may use the wrong
addresses, too. I guess you can't do anything about that from the
driver, though.

> +	/* Cache the host_mem_descs in non-DMA memory so a malicious hypervisor
> +	 * can't change them.
> +	 */
> +	struct nvme_host_mem_buf_desc *host_mem_descs_cache;
>  	void **host_mem_desc_bufs;

This is never seen by an nvme device, so no need for an nvme specific
type here. You can use arch native types.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
