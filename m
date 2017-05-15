From: oza.oza@broadcom.com (Oza Oza)
Date: Mon, 15 May 2017 14:09:10 +0530
Subject: [RFC] NVMe Configuraiton using sysctl
In-Reply-To: <CAMSpPPcxWYtZMbAc4TWam3iC1cLbxBPM=EhNPKA6qweiGnJvVg@mail.gmail.com>
References: <CAMSpPPcxWYtZMbAc4TWam3iC1cLbxBPM=EhNPKA6qweiGnJvVg@mail.gmail.com>
Message-ID: <CAMSpPPf640XfjW38=NXHmkDG0SeduavOEkKiEJuGmobq183jNg@mail.gmail.com>

On Mon, May 15, 2017@2:04 PM, Oza Oza <oza.oza@broadcom.com> wrote:
> Hi,
>
> we are configuring interrupt coalesce for NVMe, but right now, it uses
> module param.
> so the same interrupt coalesce settings get applied for all the NVMEs
> connected to different RCs.
>
> ideally it should be with sysctl.
> for e.g.
> sysctl should provide interface to change
> Per-CPU IO queue pairs, interrupt coalesce settings etc..
>
> please suggest if we could have/implement sysctl module for NVMe ?
>
> Regards,
> Oza.

+ linux-nvme at lists.infradead.org
