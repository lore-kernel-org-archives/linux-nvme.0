From: keith.busch@gmail.com (Keith Busch)
Date: Thu, 6 Jun 2019 14:56:10 -0600
Subject: nvme: build failure report for nvme_sync_queues()
In-Reply-To: <20190606192420.GA17774@minwooim-desktop>
References: <20190606184620.GA1676@minwooim-desktop>
 <20190606192420.GA17774@minwooim-desktop>
Message-ID: <CAOSXXT78U_CmaK_YqQR2D3OKJ5GSy+KtrN6ab4iMQHwn0aROQQ@mail.gmail.com>

On Thu, Jun 6, 2019@1:24 PM Minwoo Im <minwoo.im.dev@gmail.com> wrote:
> On 19-06-07 03:46:20, Minwoo Im wrote:
> > Hi all,
> >
> > I'd have to report a build failure due to the following commit:
> > Commit e7ae6d1e7c5f ("nvme-pci: Use host managed power state for suspend")
> >
> > Message:
> > drivers/nvme/host/pci.c:2876:2: error: implicit declaration of function ?nvme_sync_queues?; did you mean ?nvme_stop_queues?? [-Werror=implicit-function-declaration]
> >   nvme_sync_queues(ctrl);
> >     ^~~~~~~~~~~~~~~~
> >
> > Is the following patch applied to this branch ?
> >   [PATCHv4 1/4] nvme: Sync request queues on reset:
> >   http://lists.infradead.org/pipermail/linux-nvme/2018-July/019166.html
> >
> > If I miss something here, please let mw know.
> >
> > Thanks,
>
> Sorry I forgot to mention the branch name: nvme-5.3

Looks like the 5.3 branch forked early enough to miss this one from
the 5.2-rc2 brach:

  http://git.infradead.org/nvme.git/commitdiff/d6135c3a1ec0cddda7b8b8e1b5b4abeeafd98289
