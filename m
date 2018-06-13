From: ckulkarnilinux@gmail.com (chaitany kulkarni)
Date: Wed, 13 Jun 2018 10:41:06 -0700
Subject: [PATCH V3 0/8] nvmet: implement target passthru commands support
In-Reply-To: <20180612195506.23616-1-chaitanya.kulkarni@wdc.com>
References: <20180612195506.23616-1-chaitanya.kulkarni@wdc.com>
Message-ID: <CAK0tqimWQgonK4Do5cc6RB5SU5D4UmMarHPLYP9wptWxsOsWoA@mail.gmail.com>

Sorry for the noise, please drop this patch-series, I'll resend this
as this has one unrelated patch, my bad.
On Tue, Jun 12, 2018 at 12:55 PM Chaitanya Kulkarni
<chaitanya.kulkarni@wdc.com> wrote:
>
> This patchset aims to enable passing through entire physical NVMe drive
> through an NVMe over fabrics interface. This implies that all
> namespaces on the target drive are passed through to the initiator
> one-to-one and all admin commands from the initiator are forwarded back
> to the target drive. This allows for exposing Vender Unique Commands
> (VUCs) over the NVMe-OF interface.
>
> Changes since V2:-
> 1. Split the addition of passthru command handlers and integration into
>    two different patches since we we add guards to create one target ctonroller
>    per passthru controller. This way it will be easier to review the code.
> 2. Adjust the code for 4.18.
>
> Changes since V1:-
> 1. Update the new nvme core controller find API naming and
>    changed the string comparison of the ctrl.
> 2. Get rid of the newly added #defines for target ctrl values.
> 3. Use the newly added structure members in the same patch where
>    they are used. Aggregate the passthru command handling support
>    and integration with nvmet-core into one patch.
> 4. Introduce global NVMe Target subsystem list for connected and
>    not connected subsystems on the target side.
> 5. Add check when configuring the target ns and target
>    passthru ctrl to allow only one target controller to be created
>    for one passthru subsystem.
> 6. Use the passthru ctrl cntlid when creating the target controller.
>
> Chaitanya Kulkarni (8):
>   nvmet: add commands supported and effects log page
>   nvme-core: add new interfaces
>   nvme-core: export existing ctrl and ns interfaces
>   nvmet: export nvmet_add_async_event api
>   nvmet: add global subsystem list
>   nvmet: add passthru cmd handlers
>   nvmet: integrate passthru code with core
>   nvmet: add configfs interface for target passthru
>
>  drivers/nvme/host/core.c        |  80 +++++-
>  drivers/nvme/host/nvme.h        |  10 +
>  drivers/nvme/target/Makefile    |   3 +-
>  drivers/nvme/target/admin-cmd.c |  35 ++-
>  drivers/nvme/target/configfs.c  | 145 +++++++++-
>  drivers/nvme/target/core.c      | 193 ++++++++++++-
>  drivers/nvme/target/nvmet.h     |  19 ++
>  drivers/nvme/target/pt-cmd.c    | 481 ++++++++++++++++++++++++++++++++
>  8 files changed, 947 insertions(+), 19 deletions(-)
>  create mode 100644 drivers/nvme/target/pt-cmd.c
>
> --
> 2.17.0
>
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
