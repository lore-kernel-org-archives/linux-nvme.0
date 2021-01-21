Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06DAC433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 17:07:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6535D23A58
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 17:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6535D23A58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QQs0NkcKjG9Cz5ELYVgQ7Q5XllCyEpust+Xgt16kB1A=; b=UlKBbVKriW/Ivrt2UTSQ49NSm
	oMHGssRwvT5T0TseiSy6GCn4y5T0oESjnFnwgheHr6QW6I+80TZNx1tv+udTJn+hukKHTTigUTEIO
	S0A9n+kskWUDTdHcE3MMUtH6RwBw2swEe7GMkas1IQFEUEI/4E2VWAWNnwap7Py3o8qEQhDVep2MZ
	Sk2tIqAvHj5jJawVDfS8NotS203qjckfYkYcTZHYnpe5KH4cw+9cRcmEUNaDxApMZSjuW6mcbrqqe
	nEK6lxX8Q+Top0CXFgrMDp24g1JhpHYhKr+t/ZkaEftPkCRXy5hDW7skVvDtdZOaBBOmr65FEjg9u
	p0eOUnDow==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2dQw-0008Mu-6R; Thu, 21 Jan 2021 17:07:46 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2dQu-0008MP-Bp
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 17:07:45 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DC1D23A54;
 Thu, 21 Jan 2021 17:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611248861;
 bh=5HszyFQpnxAue6xVZ8PVSfnQ/jpShcNgYhxr7BvXR9c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iUNdFf72jL0YJdIqLZ+wWbamUbFKXN7eL+uLLba9pd51RWLD3aIr+mlhPrrcpAPWf
 XZRwPU+MfMZC1o+M9EfUpbJMGYFXTxW/39jPBpZ4yucte5vu9RgSYqlHTMyWUae5+3
 e4yzNXemF87j3ppZlj8J+QrUekd6/Foiem1qyQk95EFwEggK7AdmJ6BdMI80SEzNCg
 QQDF6lN1yrDe+g+NRbqFdFXlAZ8oXwj4bQCwtSfUN/4g2LnkO0LR/QhiF7fBDXmuRl
 JZJ+UQBOZVLkzIMEF12VRV7Yez2Modt/cEMk0HtvA2Q/8VCLZ2+8k72GSTMirfRzdT
 zOBRwwE94CwwQ==
Date: Fri, 22 Jan 2021 02:07:35 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: kernel oops after nvme_set_queue_count()
Message-ID: <20210121170735.GA32223@redsun51.ssa.fujisawa.hgst.com>
References: <d5f00c36-2981-0a0c-7a6d-b4ab2c8d139e@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d5f00c36-2981-0a0c-7a6d-b4ab2c8d139e@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_120744_491992_6A41E6EE 
X-CRM114-Status: GOOD (  16.82  )
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
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 21, 2021 at 09:25:39AM +0100, Hannes Reinecke wrote:
> Hi all,
> 
> a customer of ours ran into this oops:
> 
> [44157.918962] nvme nvme5: I/O 22 QID 0 timeout
> [44163.347467] nvme nvme5: Could not set queue count (880)
> [44163.347551] nvme nvme5: Successfully reconnected (6 attempts)
> [44168.414977] BUG: unable to handle kernel paging request at
> ffff888e261e7808
> [44168.414988] IP: 0xffff888e261e7808
> [44168.414994] PGD 98c2ae067 P4D 98c2ae067 PUD f57937063 PMD
> 8000000f660001e3
> 
> It's related to this code snippet in drivers/nvme/host/core.c
> 
> 	/*
> 	 * Degraded controllers might return an error when setting the queue
> 	 * count.  We still want to be able to bring them online and offer
> 	 * access to the admin queue, as that might be only way to fix them up.
> 	 */
> 	if (status > 0) {
> 		dev_err(ctrl->device, "Could not set queue count (%d)\n", status);
> 		*count = 0;
> 
> 
> causing nvme_set_queue_count() _not_ to return an error, but rather let the
> reconnect complete.
> Of course, as this failure is due to a timeout (cf the status code; 880
> is NVME_SC_HOST_PATH_ERROR), the admin queue has been torn down by the
> transport, causing this crash.

This doesn't sound right. No response from a controller timeout is
supposed to get the -EINTR return, which exits earlier with a returned
error above what you're showing.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
