Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F16C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jul 2022 01:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NYgvPjfpETaXaFuTz3dmoG8Qh0QKnIF+2JiZK+rPjr8=; b=XDfhpj+sMk0++8O4rgh2Rp/O4l
	ucfEymxMuoGXYa2nGOFVYgT8eaRnCw/f21SB1szpR6ilCPB8FQS4Mrboh6tDiFLmB2fxDGwHB68BK
	87nsKoPoi+T5lqzQP1yZRdcCCoq098Ubc2rxGR3zhNnujYqYOTKkde/3sXtzc2wW5Azf4OwsAT8FE
	ml0idVhMKb+VJP9Ejg03yfacFWOwIYPMRgUc7OAxj/E9ocdMyBtZWqKmSelJOCgmR1KoMuiToGO63
	BYsz8n4sX++/SOirUuK3GYs+1n+NjjsNX8VtZGhkVBle4nVBYKtLEE30P1V9kkWtOSW1BHGGVaivQ
	ut25y7Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oC9gn-002wSx-H9; Fri, 15 Jul 2022 01:00:17 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oC9gk-002wSc-Ro; Fri, 15 Jul 2022 01:00:14 +0000
Date: Thu, 14 Jul 2022 18:00:14 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: axboe@kernel.dk, casey@schaufler-ca.com, joshi.k@samsung.com,
	linux-security-module@vger.kernel.org, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	a.manzanares@samsung.com, javier@javigon.com
Subject: Re: [PATCH] lsm,io_uring: add LSM hooks to for the new uring_cmd
 file op
Message-ID: <YtC8Hg1mjL+0mjfl@bombadil.infradead.org>
References: <20220714000536.2250531-1-mcgrof@kernel.org>
 <CAHC9VhSjfrMtqy_6+=_=VaCsJKbKU1oj6TKghkue9LrLzO_++w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSjfrMtqy_6+=_=VaCsJKbKU1oj6TKghkue9LrLzO_++w@mail.gmail.com>
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

On Wed, Jul 13, 2022 at 11:00:42PM -0400, Paul Moore wrote:
> On Wed, Jul 13, 2022 at 8:05 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > io-uring cmd support was added through ee692a21e9bf ("fs,io_uring:
> > add infrastructure for uring-cmd"), this extended the struct
> > file_operations to allow a new command which each subsystem can use
> > to enable command passthrough. Add an LSM specific for the command
> > passthrough which enables LSMs to inspect the command details.
> >
> > This was discussed long ago without no clear pointer for something
> > conclusive, so this enables LSMs to at least reject this new file
> > operation.
> >
> > [0] https://lkml.kernel.org/r/8adf55db-7bab-f59d-d612-ed906b948d19@schaufler-ca.com
> 
> [NOTE: I now see that the IORING_OP_URING_CMD has made it into the
> v5.19-rcX releases, I'm going to be honest and say that I'm
> disappointed you didn't post the related LSM additions 

It does not mean I didn't ask for them too.

> until
> v5.19-rc6, especially given our earlier discussions.]

And hence since I don't see it either, it's on us now.

As important as I think LSMs are, I cannot convince everyone
to take them as serious as I do.

> While the earlier discussion may not have offered a detailed approach
> on how to solve this, I think it was rather conclusive in that the
> approach used then (and reproduced here) did not provide enough
> context to the LSMs to be able to make a decision.

Right...

> There were similar
> concerns when it came to auditing the command passthrough.  It appears
> that most of my concerns in the original thread still apply to this
> patch.
> 
> Given the LSM hook in this patch, it is very difficult (impossible?)
> to determine the requested operation as these command opcodes are
> device/subsystem specific.  The unfortunate result is that the LSMs
> are likely going to either allow all, or none, of the commands for a
> given device/subsystem, and I think we can all agree that is not a
> good idea.
> 
> That is the critical bit of feedback on this patch, but there is more
> feedback inline below.

Given a clear solution is not easily tangible at this point
I was hoping perhaps at least the abilility to enable LSMs to
reject uring-cmd would be better than nothing at this point.

> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  include/linux/lsm_hook_defs.h | 1 +
> >  include/linux/lsm_hooks.h     | 3 +++
> >  include/linux/security.h      | 5 +++++
> >  io_uring/uring_cmd.c          | 5 +++++
> >  security/security.c           | 4 ++++
> >  5 files changed, 18 insertions(+)
> 
> ...
> 
> > diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
> > index 0a421ed51e7e..5e666aa7edb8 100644
> > --- a/io_uring/uring_cmd.c
> > +++ b/io_uring/uring_cmd.c
> > @@ -3,6 +3,7 @@
> >  #include <linux/errno.h>
> >  #include <linux/file.h>
> >  #include <linux/io_uring.h>
> > +#include <linux/security.h>
> >
> >  #include <uapi/linux/io_uring.h>
> >
> > @@ -82,6 +83,10 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
> >         struct file *file = req->file;
> >         int ret;
> >
> > +       ret = security_uring_cmd(ioucmd);
> > +       if (ret)
> > +               return ret;
> > +
> >         if (!req->file->f_op->uring_cmd)
> >                 return -EOPNOTSUPP;
> >
> 
> In order to be consistent with most of the other LSM hooks, the
> 'req->file->f_op->uring_cmd' check should come before the LSM hook
> call. 

Sure.

> The general approach used in most places is to first validate
> the request and do any DAC based access checks before calling into the
> LSM.

OK.

Let me know how you'd like to proceed given our current status.

  Luis

