From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 30 Jul 2019 09:10:32 +0800
Subject: [PATCH rfc 1/2] nvme: don't remove namespace if revalidate failed
 because of controller reset
In-Reply-To: <464bb489-552f-b67e-545d-48616a1e76dd@grimberg.me>
References: <20190729233201.27993-1-sagi@grimberg.me>
 <20190729233201.27993-2-sagi@grimberg.me>
 <CACVXFVM+WGwQeqiK-poVKoQR4hVxCMWu0n0-HdVGb8EDDCySSA@mail.gmail.com>
 <464bb489-552f-b67e-545d-48616a1e76dd@grimberg.me>
Message-ID: <CACVXFVO+e5De4+o8cqzvaVbMU22geicCbpmfk6zZStykEiDVmw@mail.gmail.com>

On Tue, Jul 30, 2019@9:06 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >> If a controller reset is racing with a namespace revalidation, the
> >> revalidation I/O will surely fail, but we should not remove the
> >
> > No, there is sync IO request in revalidation, and the sync IO can't be completed
> > during resetting.
>
> Why? of course it can. The controller reset is responsible to
> quiesce + abort + unquiesce both I/O and admin commands.

Abort simply cancels the in-flight requests, which will be retried &
re-queued into
blk-mq queues, and will be dispatched again after reset is done. That is why the
revalidation IO won't be failed.

Thanks,
Ming Lei
