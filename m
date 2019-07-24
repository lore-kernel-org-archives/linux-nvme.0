From: javier@javigon.com (=?utf-8?Q?Javier_Gonz=C3=A1lez?=)
Date: Wed, 24 Jul 2019 09:24:00 +0200
Subject: [PATCH 2/5] lnvm: export lnvm_get_identity
In-Reply-To: <20190723183601.29370-3-minwoo.im.dev@gmail.com>
References: <20190723183601.29370-1-minwoo.im.dev@gmail.com>
 <20190723183601.29370-3-minwoo.im.dev@gmail.com>
Message-ID: <4AEE1988-5741-44C3-989A-2798DC5EE819@javigon.com>

> On 23 Jul 2019,@20.35, Minwoo Im <minwoo.im.dev@gmail.com> wrote:
> 
> When a subcommand wants to fetch Geometry, this function would be the
> one to be taken.
> 
> Cc: Keith Busch <kbusch at kernel.org>
> Cc: Matias Bjorling <mb at lightnvm.io>
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
> nvme-lightnvm.c | 2 +-
> nvme-lightnvm.h | 2 ++
> 2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/nvme-lightnvm.c b/nvme-lightnvm.c
> index e8cdccd..2e665bf 100644
> --- a/nvme-lightnvm.c
> +++ b/nvme-lightnvm.c
> @@ -436,7 +436,7 @@ static void show_lnvm_id_ns(struct nvme_nvm_id *id, unsigned int flags)
> 	}
> }
> 
> -static int lnvm_get_identity(int fd, int nsid, struct nvme_nvm_id *nvm_id)
> +int lnvm_get_identity(int fd, int nsid, struct nvme_nvm_id *nvm_id)
> {
> 	struct nvme_admin_cmd cmd = {
> 		.opcode		= nvme_nvm_admin_identity,
> diff --git a/nvme-lightnvm.h b/nvme-lightnvm.h
> index 9dea912..9dc1868 100644
> --- a/nvme-lightnvm.h
> +++ b/nvme-lightnvm.h
> @@ -299,6 +299,8 @@ static inline struct ppa_addr generic_to_dev_addr(
> 	return l;
> }
> 
> +int lnvm_get_identity(int fd, int nsid, struct nvme_nvm_id *nvm_id);
> +
> int lnvm_do_init(char *, char *);
> int lnvm_do_list_devices(void);
> int lnvm_do_info(void);
> --
> 2.17.1

This and the other helpers for patch 4/5 looks good.


Reviewed-by: Javier Gonz?lez <javier at javigon.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190724/5bdddd09/attachment.sig>
