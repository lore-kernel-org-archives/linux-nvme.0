Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A7AC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Nov 2023 18:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RPF52YGKE4Om8B5MFnlV0OhBSkjH3UnR44+aa/CcIB0=; b=JPcd11N05tnPSy3PFmBoK90wQz
	gEwlp7B2mhFi8UV6eBXksLDc6sni7VIFUItHjCKOJQhh0zpT1lyTi2GbsoYNtDOX3iODQENbufSgX
	5AZRzlt4HoDhH5GyXZTV6QKr3uIYs+bGv11Mk+mOCBcg8WmujDnmhIZ3A4GmQODh+vKaiZo67WA3O
	WegTesN6CHFqZBT3xpO7cObG+r5wh/qEWOP0bESq34knoXU1wrpZND2exSiCdi8+0zcAsmUvIiVJz
	un8R2N5DOyjGjEiHUv0Vf7XQ3d4+5r9xNakASgbgDszGd3jC1hKW0etAX7+ruvf67c1Ww1No+7Al9
	R/FOGSvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r2bEJ-00ETFO-1u;
	Mon, 13 Nov 2023 18:00:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r2bEF-00ETEq-21
	for linux-nvme@lists.infradead.org;
	Mon, 13 Nov 2023 18:00:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699898404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RPF52YGKE4Om8B5MFnlV0OhBSkjH3UnR44+aa/CcIB0=;
	b=GMaA0PXyBCndCrxx7cYgoDG5TjXyaLxfpNWI1MFyoNIwtg3noSioqn6o47IVV0+nZ6IHut
	vBOojMslstDFi1ZHGGmXR/awXj0WE0o23rH/8FBXP4GPUN2UCR+fMBhZp+vxdA04b20Tj+
	J5nVjSUwtH/xFvruw8QKyY4+qrDCJUQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-Tn-lIhH3P3WZ5o-pYFzeNw-1; Mon, 13 Nov 2023 12:58:16 -0500
X-MC-Unique: Tn-lIhH3P3WZ5o-pYFzeNw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9CBE28007B3;
	Mon, 13 Nov 2023 17:58:15 +0000 (UTC)
Received: from rhel-developer-toolbox (unknown [10.2.16.152])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BE5B62166B26;
	Mon, 13 Nov 2023 17:58:14 +0000 (UTC)
Date: Mon, 13 Nov 2023 09:58:12 -0800
From: Chris Leech <cleech@redhat.com>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Keith Busch <kbusch@kernel.org>,
	Maurizio Lombardi <mlombard@redhat.com>
Subject: Re: [bug report][bisected] nvme authentication setup failed observed
 during blktests nvme/041 nvme/042 nvme/043
Message-ID: <ZVJjtOGpulFV61ii@rhel-developer-toolbox>
References: <CAHj4cs8yZ4-BXqTK4W0UsPpmc2ctCD=_mYiwuAuvcmgS3+KJ8g@mail.gmail.com>
 <CAHj4cs8vqrePA-TE_GGNAZLG3iqZBq9L1GkanA4A0wRF_TXDeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHj4cs8vqrePA-TE_GGNAZLG3iqZBq9L1GkanA4A0wRF_TXDeA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231113_100007_829011_FFA37E93 
X-CRM114-Status: GOOD (  20.27  )
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

Hi Yi Zhang,

Where is your kernel configuration coming from?  If it's carried forward
from an older kernel, it may have the NVME_AUTH symbol set but not
NVME_HOST_AUTH.  That would now just enabled the shared host/target core
auth code, but not the host support.  I think updating your kernel
config to include NVME_HOST_AUTH will fix this.

- Chris

On Thu, Oct 19, 2023 at 03:16:13PM +0800, Yi Zhang wrote:
> Hi Hanns
> 
> Bisect shows it was introduced with this commit.
> 
> commit d680063482885c15d68e958212c3d6ad40a510dd (HEAD)
> Author: Hannes Reinecke <hare@suse.de>
> Date:   Thu Oct 12 14:22:48 2023 +0200
> 
>     nvme: rework NVME_AUTH Kconfig selection
> 
>     Having a single Kconfig symbol NVME_AUTH conflates the selection
>     of the authentication functions from nvme/common and nvme/host,
>     causing kbuild robot to complain when building the nvme target
>     only. So introduce a Kconfig symbol NVME_HOST_AUTH for the nvme
>     host bits and use NVME_AUTH for the common functions only.
>     And move the CRYPTO selection into nvme/common to make it
>     easier to read.
> 
> On Wed, Oct 18, 2023 at 2:57 PM Yi Zhang <yi.zhang@redhat.com> wrote:
> >
> > Hello
> > Just found the blktests nvme/041 nvme/042 nvme/043[2] failed on the
> > latest linux-block/for-next[1],
> > from the log I can see it was due to authentication setup failed,
> > please help check it, thanks.
> >
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-next
> > e3db512c4ab6 (HEAD -> for-next, origin/for-next) Merge branch
> > 'for-6.7/block' into for-next
> >
> > [2]
> > # ./check nvme/041
> > nvme/041 (Create authenticated connections)                  [failed]
> >     runtime  3.274s  ...  3.980s
> >     --- tests/nvme/041.out      2023-10-17 08:02:17.046653814 -0400
> >     +++ /root/blktests/results/nodev/nvme/041.out.bad   2023-10-18
> > 02:50:03.496539083 -0400
> >     @@ -2,5 +2,5 @@
> >      Test unauthenticated connection (should fail)
> >      NQN:blktests-subsystem-1 disconnected 0 controller(s)
> >      Test authenticated connection
> >     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
> >     +NQN:blktests-subsystem-1 disconnected 0 controller(s)
> >      Test complete
> >
> > # dmesg
> > [ 2701.636964] loop: module loaded
> > [ 2702.074262] run blktests nvme/041 at 2023-10-18 02:49:59
> > [ 2702.302067] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > [ 2702.447496] nvmet: creating nvm controller 1 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> > with DH-HMAC-CHAP.
> > [ 2702.447707] nvme nvme0: qid 0: authentication setup failed
> > [ 2704.099618] nvmet: creating nvm controller 1 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> > with DH-HMAC-CHAP.
> > [ 2704.099688] nvme nvme0: qid 0: authentication setup failed
> >
> >
> > --
> > Best Regards,
> >   Yi Zhang
> 
> 
> 
> -- 
> Best Regards,
>   Yi Zhang
> 


