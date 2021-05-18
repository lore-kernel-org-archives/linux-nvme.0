Return-Path: <SRS0=ZIaN=KN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015C2C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 14:43:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C487F60FF2
	for <linux-nvme@archiver.kernel.org>; Tue, 18 May 2021 14:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C487F60FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=u0/vJzdxGtUcWzy7jlEnwnrM8Ylen1m92oMdmLn4EEY=; b=aICSyJKyVNm6NW2tsJe8WSiJo
	JetPQoRbbKqCmuEeFSRB/m0ex6aN0pNxymu84jVjmOXvWfokaEIrCaQBdGhR1GfUayew1wh4YajMN
	Al7kMAARGlsrS5UPB6NpvTNFbnZDfT0RbNwp+HT0oGt3WjTcXKpO92Xfr1Th951wc2AgrQ+rPKsOL
	sqw4UTGvlxGHQSTeSi8TgKW/Q03PNqaamGrLMBULOfsdDum8aOri9HSjPFA8PWEeOuXlXN9JspiPW
	tBzQGOWqqxH8Vl5n/98OKSMLYO9cwqWrSjkCSg9D6oXAHsD/nNboG3FYy3BUEN5C3HuK4KZfJgJIs
	nEMxEi6OQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lj0w1-0015CG-7G; Tue, 18 May 2021 14:43:01 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj0vv-0015Ar-7h
 for linux-nvme@desiato.infradead.org; Tue, 18 May 2021 14:42:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=RoTiwuDu3i9ZorigKrbSLFMbe0Id6ST14ERBxjqIYVM=; b=iIleTAspbjILDC5zWlWkTcS4mY
 IFfXR5oxHzOh19hN3Mo7uiHeGIoA9rF1zEl87i343tDnPKqmmjMsK5OzYED9iXUKK0iyhzkQaK03N
 yEccrS+RoglSwxTR6sOexMELPVf5Vz9VOx7fH2XExEf6VxF7FEbu6ZDpiBHmzcSG2PQ5NiQeddUfE
 j2a6AFaOUT490WSfaWsDj6EJB1yZm2KnmnAMzIe3J/atgRsRV7RquWgFsShDdx3L4IS4RmPMT5xP+
 fS1+v1TY9OsZiFNwoUXVJYpXqpikEncD/Ip6PhghXaWRvAYjWIPT+p9y6LkQn4I0HislYE81fE+se
 6UaSzyiw==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lj0vs-00Ejtl-FN
 for linux-nvme@lists.infradead.org; Tue, 18 May 2021 14:42:53 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF43E611CC;
 Tue, 18 May 2021 14:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621348972;
 bh=pGgA+p2kwfvUlubImThqxDQEbbJvFzdv2X/p5L3+7cM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fwDY64QGM8WEy2NzVGIzn4FC5sAWPFB49q/tfuSko7tg0CHAx10aWpB9nnI/DupZG
 3kCZmbILzQFmXhhFBWf1GBJR1v46/4g0IONyfJ4c+wPqnwe7pyCH9W2XOqhy00YMFb
 gYOiWabvFiU7Iv96Iws0VwEwrzmHcVSPkcjA/EpMa/0mbHq/4uTMnXicu9uZH+UWCv
 tsNa9beV154wavxCD4tC7BvYadXc5B6iCdqlAGVNC8wuMdeZd/K7Z7IQSi0tvC70TM
 HVPoE0wKNVHiC88PU1ANig2zrC+fw4e/4OeIsU6lkQcqBxvfJxsbFuKiC7P48GhdBu
 MpyxGf7c8t+kQ==
Date: Tue, 18 May 2021 07:42:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [regression] nvme flush failed from v5.13-rc1
Message-ID: <20210518144249.GE2709569@dhcp-10-100-145-180.wdc.com>
References: <CAHj4cs9MVLY+KkFXfmwPd5db69pVjAuD2g+yJ=oE14UddUmKKA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHj4cs9MVLY+KkFXfmwPd5db69pVjAuD2g+yJ=oE14UddUmKKA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_074252_557329_E8A1AC33 
X-CRM114-Status: GOOD (  10.91  )
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

On Tue, May 18, 2021 at 09:23:39PM +0800, Yi Zhang wrote:
> Hi
> commit[3] add a check to validates nsid which will lead nvme flush
> cmd[1] failed as the cmd.nsid will use the default nsid:
> NVME_NSID_ALL[2], that finally lead validate failed, any suggestions
> to fix it?

Flush is the only IO command that accepts a broadcast NSID, but the
kernel now prevents dispatching commands to anything but the NSID of the
block device that you dispatched it. Perhaps the kernel can relax that
requirement and accept "all namespaces" for IO commands (I'll look into
that).

I'll change nvme-cli to default to the block device's NSID, since that
should always work.

> [1]
> # nvme flush /dev/nvme0n1
> flush: Invalid argument
> # dmesg
> [  802.131609] nvme nvme0: nvme: nsid (4294967295) in cmd does not
> match nsid (1) of namespace
> 
> [2]
>         struct config cfg = {
>                 .namespace_id = NVME_NSID_ALL,
>         };
> 
> [3]
> commit c881a23fb6f7eb901155d25ba8dd1af0b8c7923b (HEAD, refs/bisect/bad)
> Author: Niklas Cassel <niklas.cassel@wdc.com>
> Date:   Fri Mar 26 19:48:00 2021 +0000
> 
>     nvme: disallow passthru cmd from targeting a nsid != nsid of the block dev

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
