Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608D1C4321E
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Dec 2022 21:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T8Ht4g3pwi7KsjFouTW7Az1RmQOTgXN9ehYhboRgI18=; b=Jc1ljnhrlM3hL1ttP/+VKJEMMa
	2N/kDiAJccWv6LZJSZlrVuOiGXr2cmRaQeIm7+34es2DiSdHs6S/VZUQXHj4XjQ6JgBt0hU+zJ3je
	6cHgPWqJLYv5YuRPY+1217sLbeJwgADu3Cjg8NR2hd6/O71WBZHRDp4Zu8CTz8PUfCh3mb+jKliqW
	QPQUIAlqXDRPX6jTnFOOcyvn6yLcExBQ3pg+tyo23n6MPjjU7lDUzdF6ZvIxbD2M3I6Kro6h50oVd
	I0TJKLeTWRoDaAHdUShoO47ByR0CWvJu2D6i4E4Rx488sthV5rryyUrrO/c+VFC5tX5Pb0E4DW+bN
	Y4WsVxxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0r0Y-00B86D-SV; Thu, 01 Dec 2022 21:22:14 +0000
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0qwY-00B7Iy-Fo
	for linux-nvme@lists.infradead.org; Thu, 01 Dec 2022 21:18:07 +0000
Received: by mail-il1-x12d.google.com with SMTP id s16so1318424iln.4
        for <linux-nvme@lists.infradead.org>; Thu, 01 Dec 2022 13:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T8Ht4g3pwi7KsjFouTW7Az1RmQOTgXN9ehYhboRgI18=;
        b=d0tFeWajk9vQY8T+NbGVNy9/q1RGR20OwKpvsoF1+T99cnN7xIm6i90mhMCmkx82uI
         tpy611X4R8Ug3nHuMW4JkdPr5Jt6VEwk0LJQrRMnbkncHfOyc1SaGZRbqkmYejdgaIUE
         jKLSnvHaqLh+MwcBQU/lB8zLiqQST92CzK7CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T8Ht4g3pwi7KsjFouTW7Az1RmQOTgXN9ehYhboRgI18=;
        b=Lhr1CBvHChLKAVip5NbuxDy7lFBPjo8/kVsfcdZd+KvEMTxw67IGW/FYNU0SaMDO/i
         wZcWEAHt1qmsFI2fjV2EpHSIdwjPLVzWyfIM6BqV6k1nXWNOKCDHhK1UFQkj/nhArCrv
         QW2S2/J8OFt5KdyOhn0A791C+AscJX4W1y7fciyGN3GVticDk/XnTtJtm9l/skN161FI
         FmP0I9Wcbd4NHhxMu9KiISlFWz7Slp1FmPlHoglaWpTyyerx6POT49KCJFpEt+/rfKFA
         6wRm7lPBUBzzYbqlBzh1/Ur+sFpg8y731KgKPIxnLRRL0IAOLJnurw996bjbuIXl2sdK
         mJqQ==
X-Gm-Message-State: ANoB5pmIHj34bSvftbEVjRhXggItH1PId/fNa2GgADi1eMyd0D8dzAvL
	h55ruQSMqkZRWTTHdl+Ow+tDA6ozIUlSJtlvgRg9VQ==
X-Google-Smtp-Source: AA0mqf5ty7k9Hwajh5Pd5Lb8XBGrjrxP5sN4V6Gdi6S4t2vtGgjmQkisVgyjEjv67hpbEwhPIT7UAVKp48PVVh6JQGQ=
X-Received: by 2002:a92:b74f:0:b0:302:ffcf:f007 with SMTP id
 c15-20020a92b74f000000b00302ffcff007mr14472936ilm.275.1669929482953; Thu, 01
 Dec 2022 13:18:02 -0800 (PST)
MIME-Version: 1.0
References: <20221118232756.1457075-1-csander@purestorage.com>
 <20221124002432.3715594-1-csander@purestorage.com> <20221129083905.GA25314@lst.de>
 <c3f8ebd7-8da5-a29f-bbc6-f4f893f7ef60@grimberg.me> <20221130083514.GA15442@lst.de>
 <3ac2968f-c640-815c-a7cb-fd6a8fe0cffb@grimberg.me>
In-Reply-To: <3ac2968f-c640-815c-a7cb-fd6a8fe0cffb@grimberg.me>
From: Caleb Sander <csander@purestorage.com>
Date: Thu, 1 Dec 2022 13:17:52 -0800
Message-ID: <CADUfDZqT5z3XiRBoueP+==JB3qizBKQJ+o82qw50nydTL9RzEQ@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix (S)RCU protection of nvme_ns_head list (alternate)
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, 
	linux-nvme@lists.infradead.org, Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221201_131806_643382_28B1EAE8 
X-CRM114-Status: GOOD (  16.36  )
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

On Wed, Nov 30, 2022 at 12:40 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >> I understand what you mean in general, but in this particular case
> >> I don't understand what is not working.
> >
> > How does this work?
>
> Particularly, the sleeping contexts are guaranteed not to dereference
> this NS after the two previous srcu synchronization steps so at this
> point, the only protection of nvme_ns_remove is against this
> non-sleepable traversal, which should be enough to protect with rcu.

Can you help me understand the safety here?
The namespace will be dereferenced when traversing the siblings list,
which is protected by SRCU.
But nvme_ns_remove() only synchronizes with RCU between removing the namespace
from the siblings list and freeing the namespace.
So it seems like there's a race here:
Thread A:                               Thread B:
nvme_ns_remove() executes
past the last synchronize_srcu()
                                        nvme_ns_head_submit_bio()
                                        calls srcu_read_lock(),
                                        starts traversing siblings list,
                                        holds pointer to ns
Removes ns from siblings list
Calls synchronize_rcu()
(does not block for the SRCU reader)
nvme_put_ns() reaches 0 references,
frees ns
                                        Dereferences ns to continue traversal
                                        => USE AFTER FREE

