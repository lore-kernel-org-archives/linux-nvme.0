Return-Path: <SRS0=dHSS=OF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F2BC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 13:01:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 817D661356
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 13:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 817D661356
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vLxrRFzYjWpjxCAKUe366NACCNPQzZPA2OQtxXKhOyA=; b=ElEpeZ0Xa9ohFz
	5vQsguppYUZbuEvXYCy/cjgvJl8+YCKY6R7L/l9VcaNPGKmywUB7LA/PYRRr2m7arHf9rRpvVtbkm
	yzNX4A9ZDwWnXGwTOG7eMjML7x82+fw0EtwZi4Zz7cMu+JXBgC7USTm84UsGA+RJqJ7xm5KNSW/gu
	T4IU9dWIx6lAevCeNnVtwCpkZbYR/fZe8rPd/auPtWCeC4rGHUJE74VdiaUFLlhntZTpoKwqDo8+N
	3HAMTNsjjQ2ffz8SuM3SQIwigshVSbUyOZzqGfgJqWnwlna4VJnw7Sh3hvZnloxf+5dLQzj4QfqAd
	lHLQDd8Hl4keGp5p0bYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQUWr-0096zk-JB; Wed, 15 Sep 2021 13:00:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQUWo-0096zN-OS
 for linux-nvme@lists.infradead.org; Wed, 15 Sep 2021 13:00:44 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id F314961355;
 Wed, 15 Sep 2021 13:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1631710842;
 bh=HzmARJHOWjJAgObx4+6ScKwdV/y3UM/9zWgBL6v1qIE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TzSG5HT/nA0aV7qxqbla+EeVLteVr2gezG+jhL8aQdP+KK2aGP5mEJ6ibF+Nr3TMG
 IeA9UuSsfYESuOuRkQlV+Xw6nnlXhEOxMH97WmDxwuLTJBLB6jBYqAK+LCdoQ1FsXJ
 E+Y+QyvVbODvjET8sd7j5dpgUu5lgQZAbhXjRESE=
Date: Wed, 15 Sep 2021 15:00:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [bug report] nvme0n1 node still exists after blktests
 nvme-tcp/014 on 5.13.16-rc1
Message-ID: <YUHueINHsFDRwHPa@kroah.com>
References: <CAHj4cs94pDUfSSfij=ENQxL-2PaGrHJSnhn_mHTC+hqSvPzBTQ@mail.gmail.com>
 <ca405578-5462-0ab9-91ab-de9d42ee0570@grimberg.me>
 <CAHj4cs8_382bLtbcR4F8RBJSmwMAdW22EiRycDjdLa0QtY2vnw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHj4cs8_382bLtbcR4F8RBJSmwMAdW22EiRycDjdLa0QtY2vnw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210915_060042_852718_29AE114A 
X-CRM114-Status: GOOD (  19.11  )
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

On Wed, Sep 15, 2021 at 08:41:21PM +0800, Yi Zhang wrote:
> On Tue, Sep 14, 2021 at 10:28 PM Sagi Grimberg <sagi@grimberg.me> wrote:
> >
> >
> > > Hello
> > > I found this failure on stable 5.13.16-rc1[1] and cannot reproduce it
> > > on 5.14, seems we are missing commit[2] on 5.13.y, could anyone help
> > > check it?
> >
> > Was it picked up and didn't apply correctly?
> >
> 
> Hi Sagi
> I tried apply that patch to stable branch, but failed to do that,
> would you or Hannes mind help backport it, thanks.
> 
> [linux-stable-rc ((daeb634aa75f...))]$ git am
> 0001-nvme-fix-refcounting-imbalance-when-all-paths-are-do.patch
> Applying: nvme: fix refcounting imbalance when all paths are down
> error: patch failed: drivers/nvme/host/nvme.h:716
> error: drivers/nvme/host/nvme.h: patch does not apply
> Patch failed at 0001 nvme: fix refcounting imbalance when all paths are down
> hint: Use 'git am --show-current-patch' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> 
> [linux-stable-rc ((daeb634aa75f...))]$ patch -p1 <
> 0001-nvme-fix-refcounting-imbalance-when-all-paths-are-do.patch
> patching file drivers/nvme/host/core.c
> Hunk #1 succeeded at 3761 (offset -46 lines).
> Hunk #2 succeeded at 3771 (offset -46 lines).
> Hunk #3 succeeded at 3790 (offset -46 lines).
> patching file drivers/nvme/host/multipath.c
> Hunk #1 succeeded at 757 (offset -3 lines).
> patching file drivers/nvme/host/nvme.h
> Hunk #1 FAILED at 716.
> Hunk #2 succeeded at 775 (offset 3 lines).
> 1 out of 2 hunks FAILED -- saving rejects to file drivers/nvme/host/nvme.h.rej

5.13 is only going to be around for a 2-3 more days, please move to
5.14.y at this point in time.  No need to do any extra work for 5.13.y
at this point in time as it is about to be end-of-life.

thanks,

greg k-h

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
