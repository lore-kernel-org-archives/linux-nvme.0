Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D26C001B0
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jul 2023 16:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AGgqjlRmO8dZLkHxjzit8VZ0IxU6LPEQS73hbJJxUUU=; b=MdEmAjVF+XXpByKxyyxWaTWnmJ
	oUlVNwtdQQ5xqGcfCMX+V/BpfOPe/PpUBa6T85FSfKl9hEpnaOYA8SBwrrflwNh7GzPjoJHdRdw0j
	7LqzdPgA7jUGHVonhdlWwNuzl7ssIxRAXuNC265hlGrP3g8goNdaVtXRJZCedHdKDVI4XW+aSDfPI
	FXNxoUnIi/E5ykiG26MEpe7IaKGMERGvlaz6F8Trzp6zYA9jn0RvVGxoRdc43djdIjtyOyRyJ4o8J
	x/FvE7/7IQm4MLd2MgY6IJS+KSMRho6BEB8Vt7gSrp/zGkVzRpf/iLP6fqhmEv9ykW5Tg0PW6kyiR
	8TibSViA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNxzv-004nc9-2t;
	Mon, 24 Jul 2023 16:01:23 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNxzr-004nbj-2c
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jul 2023 16:01:22 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2680ccc1d52so618806a91.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Jul 2023 09:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1690214479; x=1690819279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGgqjlRmO8dZLkHxjzit8VZ0IxU6LPEQS73hbJJxUUU=;
        b=gzq6pqLS0SXEQqRn5oTFU9YLFAHcJU8BlE4dqSKkSArJOwd6lo1oudSThe80rZvZIn
         3x1XyH8OusHp7QDTea6NlZNDQXE+AUv7RGjJjyi3luJySY0qhnBWiA8TEO62/QIvVuzB
         CsE/QYgD9wHzV5fsLJQ49SmJLRhe3KX2Seu3j+tFBJGIe37zoQU6nVLW/krgk1AfL+CT
         HhXJs6mM2X04R1xMJMF2WLJcQ1iNdHURSqF/uzQvywhJWtP8aEEQxfLMRg60WN+I1L4O
         FNcmnxgrJTZu25ZkbWHUF8QV8slTOaSA5dgIYvsmgyV/1b+EJzGRCb2PtBdTj4RFH1kx
         otIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690214479; x=1690819279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGgqjlRmO8dZLkHxjzit8VZ0IxU6LPEQS73hbJJxUUU=;
        b=ZdliKwLa76TjKW5Ej19GlsdMv8ZeNQ4ttXQyp3AjZqfmD/4amD7LZjfj+EJ8fTJ8sn
         e6axoen+zRn5DDrJxHkv+RRPbp2qlJgvey8F3hCqzR50WWRviAxBHZdx91xewJCmiCxw
         w2rzNeqTwuNBeMLUyxJu5EonM+41hLdcSy9A5YybG6CCNXRHwOR/2hI/KzuxD8Kdnnrs
         1megzoiKYF8Po6omxVgMc7OtbC56o223kJsEvVdnjP7imOejoiry7BKCqSjOgMKXgy9K
         +E/r9BpvFHz6+FB/z0zutBxExfTvW041CV/y2ikByeEpI6Qgo8xzNm9ckEvoXB3TJBj8
         nMlg==
X-Gm-Message-State: ABy/qLZ1FyCdoIt7T1jMJfmD6PPf/o7MvJ/Yyrr79AFbQ2wTrKLwf8SB
	gyZBhrARwq8HVfHU/wShdl1zXxoKE6UfqVsWD0d58w==
X-Google-Smtp-Source: APBJJlHzaLsOBKmsWLcTug+i3+XCpiSUk0Robw2lmZjennzotrgZkr/+yOcC+YwOq5Zlv2XtveqMSFOAy8fqwTlENpg=
X-Received: by 2002:a17:90a:8a13:b0:263:661e:e0dc with SMTP id
 w19-20020a17090a8a1300b00263661ee0dcmr7998950pjn.25.1690214478752; Mon, 24
 Jul 2023 09:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230724090611.705366-1-sagi@grimberg.me> <CADUfDZr9bNo17_NmWLCu_kVdURQn7XbbwtZoi2XzF8NTNyL_VA@mail.gmail.com>
 <a20ee796-3690-9d2b-2363-4caaefc3aca9@grimberg.me>
In-Reply-To: <a20ee796-3690-9d2b-2363-4caaefc3aca9@grimberg.me>
From: Caleb Sander <csander@purestorage.com>
Date: Mon, 24 Jul 2023 09:01:06 -0700
Message-ID: <CADUfDZp02JKSdp=Xm4OFKtAAy+M2wh7KYw8sEXWPm+eO_3MmeQ@mail.gmail.com>
Subject: Re: [PATCH libnvme] fabrics: don't pass sqflow_disable if the kernel
 does not support the option
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_090119_938073_39E49322 
X-CRM114-Status: GOOD (  47.88  )
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

On Mon, Jul 24, 2023 at 8:35=E2=80=AFAM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
>
> > Hi Sagi,
> >
> > On Mon, Jul 24, 2023 at 2:11=E2=80=AFAM Sagi Grimberg <sagi@grimberg.me=
> wrote:
> >>
> >> Instead of retrying again without it.
> >>
> >> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> >> ---
> >>   src/nvme/fabrics.c | 12 +-----------
> >>   1 file changed, 1 insertion(+), 11 deletions(-)
> >>
> >> diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
> >> index fd761d10d0cb..2a9d8dc7f23a 100644
> >> --- a/src/nvme/fabrics.c
> >> +++ b/src/nvme/fabrics.c
> >> @@ -1026,7 +1026,7 @@ nvme_ctrl_t nvmf_connect_disc_entry(nvme_host_t =
h,
> >>                  return NULL;
> >>          }
> >>
> >> -       if (e->treq & NVMF_TREQ_DISABLE_SQFLOW)
> >> +       if (e->treq & NVMF_TREQ_DISABLE_SQFLOW && h->r->options->disab=
le_sqflow)
> >
> > How do we know options is initialized here? It looks like that's done
> > in __nvmf_supported_options(), called from nvmf_add_ctrl(), which is
> > called a few lines later in this function.
>
> This is for connecting discovery log entries, so the kernel cap was
> already read once for the discovery controller.
>
> Although granted, this can be udev driven on an existing discovery
> controller. Probably need to do it regardless of adding a controller.

Yes, I would avoid depending on the assumption that a connection has
already been made, especially since libnvme is designed to be a
standalone library, not necessarily used by nvme-cli.

>
> I remember when adding the capability to check supported opts I added
> an interface to do it per feature. Not sure why it was changed, it is
> much more sane to just read it on demand given that there is just a
> simple and short string copy in the kernel...
>
> Ideally this would become:
>         if (e->treq & NVMF_TREQ_DISABLE_SQFLOW &&
>             nvmf_check_cap("disable_sqflow"))
>                 c->cfg.disable_sqflow =3D true;
>         else
>                 c->cfg.disable_sqflow =3D false;
>
> Daniel? Any reason why we are caching these opts in an executable
> with a short lifetime? And apparently we need to be very precise when
> we rely on this cache to be stable.

I agree an interface like that to get the supported options on demand
would be much more ergonomic. I think the current design makes sense
as long the options are only needed in build_options(). I do think
it's good to minimize system calls to get this information; making one
for each option passed would be a significant overhead. The
type-checking provided by the nvme_fabric_options field names also
seems beneficial over plain string comparisons. But we could easily
add a nvmf_check_cap() wrapper around __nvmf_supported_options(),
since __nvmf_supported_options() already caches the supported options.
(I would personally prefer a name like "nvmef_option_supported" since
"capability" has a different meaning in the NVMe specifications.)

#define nvmf_option_supported(r, tok) \
        (!__nvmf_supported_options(r) && (r)->options->tok)


>
> If you prefer to cache it, at least do it in the start of every
> fabrics callback so we don't need to understand when this cache
> is valid...
>
> >
> >>                  c->cfg.disable_sqflow =3D true;
> >>
> >>          if (e->trtype =3D=3D NVMF_TRTYPE_TCP &&
> >> @@ -1038,16 +1038,6 @@ nvme_ctrl_t nvmf_connect_disc_entry(nvme_host_t=
 h,
> >>          if (!ret)
> >>                  return c;
> >>
> >> -       if (errno =3D=3D EINVAL && c->cfg.disable_sqflow) {
> >> -               errno =3D 0;
> >> -               /* disable_sqflow is unrecognized option on older kern=
els */
> >
> > The kernel didn't add support for reporting its supported options
> > until 5.17. If the kernel doesn't report this information, we fall
> > back to default_supported_options, which represents the options the
> > kernel supported when the reporting mechanism was added. These include
> > disable_sqflow, so h->r->options->disable_sqflow will always be true
> > (unless support for it is removed in the future), even if the kernel
> > is an old version that doesn't support it. So if this disable_sqflow
> > fallback behavior is necessary for older kernels, I don't think it can
> > safely be replaced by the h->r->options->disable_sqflow check.
>
> You right, it needs an else case, so we always set it based on the
> default/treq _and_ what the kernel supports.
>
> I will hold off with this patch until Daniel will reply to what
> he thinks needs to be done here.

