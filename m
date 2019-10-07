Return-Path: <SRS0=ttKb=YA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FFDC47404
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2019 15:45:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C68320640
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2019 15:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vBvb5n1q";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJsQV7x6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C68320640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DUO1FKXjfFUTvDP4xuhJycmrO4wKA9ofLPvjh3biwcs=; b=vBvb5n1q9uA0P0
	eHcjUccERE4vaICcFiYwk/XZz8vsxSaSACS1iMnUh3y6nZBjo6JVcWlC9rbNCNJq0xV3fu94bSe60
	avHR+dqYMTZMNAlwUWCMSwJ50OCrzRFYnhfJ5mXotVcwcKXlu9nSLfFZ4LcxZKNR9wRPd62qhRJ3k
	VxxHjHHpSSS1jJBERwFmK7F3jQTpLFUwA9aKOBAxe2ZgVwWydNlQSL6b9CXba3pN309u3tDEXxsXL
	HHy06MZ8wZ/1qAr6Vw3MQ4vUFvhn9JyeOitu83n0SUXmYxG72+iquUxqSFITOnPHBSa2ewd/kcIcW
	hzhj8OrpWmoIDjPsdgrg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iHVCe-00048Q-Nk; Mon, 07 Oct 2019 15:45:40 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iHVBq-00028L-6j
 for linux-nvme@lists.infradead.org; Mon, 07 Oct 2019 15:44:53 +0000
Received: from C02WT3WMHTD6 (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7E70020640;
 Mon,  7 Oct 2019 15:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570463089;
 bh=7AVcHfK0bWVvjbPHEPoXKNBy22PlFsfUrhaMLwuWDd4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iJsQV7x6ZBiPD5VZEcxKK9/wKGyBDjS3LqOw8dRYjFTV6E10xSlpPPswFT6XLffWr
 IAf2UukUH0CW3fWCT+BmXqqFdB5SYdrXYnDEAder6sy44MLnZMMXPfdXEnvg5iwL8J
 Ndikus1/w88Ex9MyuVIw4tNMX3ti/O40TZuXrdNg=
Date: Mon, 7 Oct 2019 09:44:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Tyler Ramer <tyaramer@gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown when removing dead controller
Message-ID: <20191007154448.GA3818@C02WT3WMHTD6>
References: <20191003191354.GA4481@Serenity>
 <CAKcoMVC2LdcmUx6j5JzuT-TsFGz=mwQ0MsprrKR2qeXoTmQ-TQ@mail.gmail.com>
 <20191006192109.GA9983@keith-busch>
 <CAKcoMVCDk+VDk6PSznTzMfJsjhZMdo6wBKZLzNbjDCkg73-WEw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKcoMVCDk+VDk6PSznTzMfJsjhZMdo6wBKZLzNbjDCkg73-WEw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191007_084450_377362_7168BEFF 
X-CRM114-Status: GOOD (  14.17  )
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
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Oct 07, 2019 at 11:13:12AM -0400, Tyler Ramer wrote:
> > Setting the shutdown to true is
> > usually just to get the queues flushed, but the nvme_kill_queues() that
> > we call accomplishes the same thing.
> 
> The intention of this patch was to clean up another location where
> nvme_dev_disable()
> is called with shutdown == false, but the device is being removed due
> to a failure
> condition, so it should be shutdown.
> 
> Perhaps though, given nvme_kill_queues() provides a subset of the
> functionality of
> nvme_dev_disable() with shutdown == true, we can just use
> nvme_dev_disable() and
> remove nvme_kill_queues()?
> 
> This will make nvme_remove_dead_ctrl() more in line with nvme_remove(),
> nvme_shutdown(), etc.

It's fine to use the shutdown == true in this path as well, but I just wanted
to understand what problem it was fixing. It doesn't sound like your scenario
is going to end up setting CC.SHN, so the only thing the shutdown should
accomplish is flushing pending IO, but we already call kill_queues() right
after the nvme_dev_disable(), so that part should be okay.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
