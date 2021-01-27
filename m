Return-Path: <SRS0=3Lap=G6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196A9C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 15:09:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17EE2075A
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 15:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17EE2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cs4SRR2zrFSHcRlTEYybsxDGdrQYRMjjpqstYrAn/MU=; b=B9vR+SzH7RcRSNhHAlDW53Cwy
	7GOtJGm+gT0m8TOY3WGobvm73SD6vAwKZwxAfKjzFI6Gj2ac2/aYUFo05/er5jb8mmE36C1Ybkirf
	+SPmdz+jxYaFWgUuHTcOVIj63FIPrmnWeaYcNbg8hbB3mNTD/IIqjU/DTUzNizX49El/f9iqZQxiF
	E/jh8PiuT1RJhaVE2s3GaccvoGCIMKaaHmFbWwwtN8OTmR0QPtPJSM6KzDACMmdIApyZDcoPcxjd6
	JqbLuC6PgqLHiKQgM8CMWouSoImiSK1SfqpNb4h9sM1PnCK33OkJrtsp4L1O2BYxFe4H7dthvmHpQ
	9KbE2uRKg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4mRg-0002tp-3q; Wed, 27 Jan 2021 15:09:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4mRd-0002su-MW
 for linux-nvme@lists.infradead.org; Wed, 27 Jan 2021 15:09:22 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id E3A5D2075A;
 Wed, 27 Jan 2021 15:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611760160;
 bh=v34JgNu8bj3uA9Ju/QhQiUZ48T2QSldlNI3U/rC+f6E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=czOZV9fcjqjYzlFXWWuF94zJUuFpbH5S3EWWVWj27YJutqzhMVTsERpURMIcYh6JR
 a4sXGX/exeh4KkWsfGhcVGPGm4HCpDbIQ3FTo+2PgoKvcqgdBTdV3JT1BEiFGIHg5R
 vyWOhS63X1Zm2ETetfE8aXIEBQoms10K6ZtZI3Cemnk6c6b36L5+RZamzsKOosk8xe
 q21Ulxvq1ST/lk7KYam4wj6y5d73t59Wy/Mz3F6wpzyBUf4dATeyfcvNvZfFmYrQnk
 KCQsbspeLDbLKfj5W8GVRX2ntADUo3GRUgXVrRKXoChgDbQXXRPRpv+EilESzD9pOF
 4b1z6nfaQMU5A==
Date: Thu, 28 Jan 2021 00:09:17 +0900
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv2 0/5][RESEND] Fixup return value for
 nvme_submit_sync_cmd()
Message-ID: <20210127150917.GD23059@redsun51.ssa.fujisawa.hgst.com>
References: <20210127103326.16191-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210127103326.16191-1-hare@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_100921_893744_77DE1A87 
X-CRM114-Status: GOOD (  15.70  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Daniel Wagner <dwagner@suse.de>,
 James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 27, 2021 at 11:33:21AM +0100, Hannes Reinecke wrote:
> Hi all,
> 
> here are some small patches for fixing up the return value of nvme_submit_sync_cmd().
> As Keith correctly noted, nvme_submit_sync_cmd() should be returning
> an error if the command could not be performed; however, currently
> only pci does that.
> So we need to fix up nvme_cancel_request() to return an -EINTR
> on any pending sync commands during reset.
> And modify nvme-fc to return the same nvme status after timing out
> or cancelling requests.
> Plus, finally, adding a new flag 'NVME_REQ_TIMEOUT' to indicate
> that a command had been aborted due to a timeout, and translates that
> back into -ETIMEDOUT as a return code for nvme_submit_sync_cmd().

Mostly looks good, but I'm not sure I understand the NVME_REQ_TIMEOUT
flag at the end. That appears to be serving the same purpose as the
"CANCELLED" flag, no?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
