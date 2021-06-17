Return-Path: <SRS0=fYEw=LL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB636C2B9F4
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jun 2021 08:56:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 945D6610CA
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jun 2021 08:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945D6610CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=56tj98PBMHqZ6XGCbRsI15AI6mB+b/I/eQhPVR99o2o=; b=f7Bf+VbknLlwL3
	bTg8G/CD4YbsPBZakBX7+I/2n5u5hqxvGF74UrToT3UVHhiVV4JV0VmcprfuxxlFhwGIQp8bh6WCn
	3fsCQamPtGsKZTu+i/vTgxtDZN2kd4ss+yeIO39Qw8mblx5+5TIG78SHr8rkS5bGb3s8vvs72XoQI
	moBCldWapYKQVpnyHE+b4cZy7g+Cvpey8ZfwwueA3BRIZzfCMsxldUAtg/0Hx04gEexwpyY9BpRzv
	BGxO2tMtNA962PXuHPxrE5zQIsjzqNWWRFKZDd32J/g3w2B52GBmFuxrZgpQ6Mp8XQouwOmDX1csz
	XvF1KVzhbA+QVjrOW9Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltnp9-009Z83-Hq; Thu, 17 Jun 2021 08:56:31 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltnp7-009Z7Z-Dv
 for linux-nvme@lists.infradead.org; Thu, 17 Jun 2021 08:56:30 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2691F21AFA;
 Thu, 17 Jun 2021 08:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623920188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mFHI24b7GH8BDCLYN320rP5qn0WlRwbfkHBbY5rqrLQ=;
 b=Iuma4vIrr07VFrjxSU9Ss7xUVDGr69yPgfe2HgMB9vHpXiO3ERWVa58zUA3a4b2SU7NpgF
 EleiSHV67xrhnVA+dvwvJVjnTH3ijQEVN5EiiGY3DIisxwJbg9vmL4QzAm8gQxKHhAV0QG
 /rwQyBmOgx0wDWzwyQlm0jmnymiX7So=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623920188;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mFHI24b7GH8BDCLYN320rP5qn0WlRwbfkHBbY5rqrLQ=;
 b=ZIUU2lM6KCzfwnpFgefuGEwkmLu9YKF2nPWeqJCKrH6FCW/EsphGibP+bUUdO7ElV/7Ry+
 7yCW3TAt/qGMyiAw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 0AB85118DD;
 Thu, 17 Jun 2021 08:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623920188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mFHI24b7GH8BDCLYN320rP5qn0WlRwbfkHBbY5rqrLQ=;
 b=Iuma4vIrr07VFrjxSU9Ss7xUVDGr69yPgfe2HgMB9vHpXiO3ERWVa58zUA3a4b2SU7NpgF
 EleiSHV67xrhnVA+dvwvJVjnTH3ijQEVN5EiiGY3DIisxwJbg9vmL4QzAm8gQxKHhAV0QG
 /rwQyBmOgx0wDWzwyQlm0jmnymiX7So=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623920188;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mFHI24b7GH8BDCLYN320rP5qn0WlRwbfkHBbY5rqrLQ=;
 b=ZIUU2lM6KCzfwnpFgefuGEwkmLu9YKF2nPWeqJCKrH6FCW/EsphGibP+bUUdO7ElV/7Ry+
 7yCW3TAt/qGMyiAw==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id D4ySATwOy2B3NQAALh3uQQ
 (envelope-from <dwagner@suse.de>); Thu, 17 Jun 2021 08:56:28 +0000
Date: Thu, 17 Jun 2021 10:56:27 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v3 4/4] nvme: code command_id with a genctr for
 use-after-free validation
Message-ID: <20210617085627.mhqobcbhsmrusuyz@beryllium.lan>
References: <20210616211936.451128-1-sagi@grimberg.me>
 <20210616211936.451128-5-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210616211936.451128-5-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210617_015629_661231_229B393D 
X-CRM114-Status: GOOD (  14.71  )
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

On Wed, Jun 16, 2021 at 02:19:36PM -0700, Sagi Grimberg wrote:
> We cannot detect a (perhaps buggy) controller that is sending us
> a completion for a request that was already completed (for example
> sending a completion twice), this phenomenon was seen in the wild
> a few times.
> 
> So to protect against this, we use the upper 4 msbits of the nvme sqe
> command_id to use as a 4-bit generation counter and verify it matches
> the existing request generation that is incrementing on every execution.
> 
> The 16-bit command_id structure now is constructed by:
> | xxxx | xxxxxxxxxxxx |
>   gen    request tag
> 
> This means that we are giving up some possible queue depth as 12 bits
> allow for a maximum queue depth of 4095 instead of 65536, however we
> never create such long queues anyways so no real harm done.
> 
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Acked-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

I've tested (only functional) this on FC (NetApp target). All looks
good.

Tested-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
