From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 30 Jul 2019 09:04:19 +0800
Subject: [PATCH rfc 1/2] nvme: don't remove namespace if revalidate failed
 because of controller reset
In-Reply-To: <20190729233201.27993-2-sagi@grimberg.me>
References: <20190729233201.27993-1-sagi@grimberg.me>
 <20190729233201.27993-2-sagi@grimberg.me>
Message-ID: <CACVXFVM+WGwQeqiK-poVKoQR4hVxCMWu0n0-HdVGb8EDDCySSA@mail.gmail.com>

On Tue, Jul 30, 2019@7:32 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
> If a controller reset is racing with a namespace revalidation, the
> revalidation I/O will surely fail, but we should not remove the

No, there is sync IO request in revalidation, and the sync IO can't be completed
during resetting.

Thanks,
Ming Lei
