Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D96C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 18:58:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C57A613DF
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 18:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C57A613DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wp15bxwVV/kPgkXTlvHevV+SvOPgqctDzCILF7oB2a4=; b=Lwclzc+l2k0JdFtGeyQZJMbp3
	d8la6VFnH1wa96f4AkxkLbqmj3dPFNORdhSzRzMKUc+yfeIc2QjH7aHqkKkt+EFpLChlkbqFJgady
	WEwwvpSgvZMlVkykI7ZY5bCQl5WBQkihpyCJykT29X9im5ixYyQQqjOBzGJBhf1yki/kH804tot8g
	Zy3zAu93NJ9UxzcZBOIf0hFksWOeHiDOJHBO5KselMWOlzaOISBBgINYuVy0hXYZ88RCxUeRYeXIk
	ovuDABkO7eC0pQKTLn/0B5rJXiulSnr01iHSAbXvFKXG5EPSworWVJwZo5QLm1Tp0lPI0mjS71z1a
	1+fXpAf0g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYvZr-00Ctut-LY; Tue, 20 Apr 2021 18:58:27 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYvZo-00CtuC-1E
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 18:58:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=j2WJRaoQA2xwDMkUpR7MBfDMEtD1QrokqwGMQQM0Uik=; b=H7SlOfVruk031WLfS+81elHlsQ
 IWJuqciV6idwif9zjhkCbY1Wj4D/NF/sXAFF5eWQuRvdNeLB+K4+JyIvYEpEFEo/fCwuy04KxQbmU
 XU5MSj8H8cO3CkJbDlTHbPIuEKdKKk+e4cLok/4GWkhvceDVs5InKj230RLn1p7V4YsuFcm0qhAGO
 OyBNhAknGqeklKz4RVdhJMzhSCZZWnTu1edh64psXKijkASgpVuYHVLi4Z98Lf082VAvR3aBaIafZ
 +VRLkZcPGE20IGO9TGex/6MGFIiCN8vGSBY5zYKzo4esNgonPCxF1NY322emBIiSUxBZmgSOFitwz
 jrAuCG/Q==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYvZl-00CMcA-IG
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 18:58:22 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 319C0613E0;
 Tue, 20 Apr 2021 18:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618945101;
 bh=CmxcKRDOcWn/9RRZ+lWQ/GFD6BnvgK9nfFsGnbBsH8M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NN4Na2coxLgkaDrHYuk9k05wVDNGGxcQ+DH7LDfmNPA04u4RLhrpKeCth+omWxmXx
 pAAUSxlPlzuTQgIGOtoHv27x9ucRwgDGrCOsAMu1XwfvF6Ffrj+iyIcPTX9XxxgFEl
 JeHClTU2rCVv7wxFc4/79Z5FfGjaVs/UfjiJsDfhSbrw7MZieTVAvOSe9UO0W6tH5u
 oHls00nN+vBu630c903gfeKnqaw1tXxQ1opXbUy54A+vnOBmgVPzFuY1hZjKX0h3e4
 lEhRK3pFVAei0d0iQyt7d6NrcFGs95/54IdAwL0EoREv7NMgRT6bz28+qie2AKYMI9
 uY7nJDkGu2Myg==
Date: Wed, 21 Apr 2021 03:58:13 +0900
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshiiitr@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Minwoo Im <minwoo.im.dev@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: introduce generic per-namespace chardev
Message-ID: <20210420185813.GA18432@redsun51.ssa.fujisawa.hgst.com>
References: <20210420100746.2801722-1-hch@lst.de>
 <20210420100746.2801722-2-hch@lst.de>
 <CA+1E3rLB5C+zP1xduzwq2uwWgEWFxUt5x=hostq5YOgj_QBNbA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+1E3rLB5C+zP1xduzwq2uwWgEWFxUt5x=hostq5YOgj_QBNbA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_115821_661761_02E5B2F9 
X-CRM114-Status: GOOD (  16.40  )
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

On Tue, Apr 20, 2021 at 11:43:51PM +0530, Kanchan Joshi wrote:
> On Tue, Apr 20, 2021 at 3:37 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > From: Minwoo Im <minwoo.im.dev@gmail.com>
> >
> > Userspace has not been allowed to I/O to device that's failed to
> > be initialized.  This patch introduces generic per-namespace character
> > device to allow userspace to I/O regardless the block device is there or
> > not.
> 
> When an application uses this interface to issue passthrough IO, it
> needs to know the lba size (at least) to form the command correctly.
> But determining lba size would require an admin ioctl.
> Do you see there is a way to go about this issue?

You'd have to look up the parent controller and issue the command
through that.

If your application doesn't have permissions to open the controller,
then it wouldn't work.

So I guess all applications that can open generic namespaces would need
access to the controller handle. But if you do that, then is there a
point to this indirection anymore?

I have to agree, the ability to query your namespaces settings through
the namespace's handle really does simplify things...

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
