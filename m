From: javier@javigon.com (=?utf-8?Q?Javier_Gonz=C3=A1lez?=)
Date: Tue, 23 Jul 2019 07:44:14 +0200
Subject: [PATCH 2/4] lnvm: do not print 0 when the arg is not given
In-Reply-To: <20190721153219.5730-3-minwoo.im.dev@gmail.com>
References: <20190721153219.5730-1-minwoo.im.dev@gmail.com>
 <20190721153219.5730-3-minwoo.im.dev@gmail.com>
Message-ID: <6B21E49E-879E-4993-AEED-44A27FBD0011@javigon.com>

> On 21 Jul 2019,@17.32, Minwoo Im <minwoo.im.dev@gmail.com> wrote:
> 
> If an argument is not given by the user, it just needs to show the
> situation, not a prominent 0 which indicates the size of the argument
> variable.
> 
> Cc: Keith Busch <kbusch at kernel.org>
> Cc: Matias Bjorling <mb at lightnvm.io>
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
> plugins/lnvm/lnvm-nvme.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/plugins/lnvm/lnvm-nvme.c b/plugins/lnvm/lnvm-nvme.c
> index 37b6733..aacd469 100644
> --- a/plugins/lnvm/lnvm-nvme.c
> +++ b/plugins/lnvm/lnvm-nvme.c
> @@ -48,7 +48,7 @@ static int lnvm_init(int argc, char **argv, struct command *cmd, struct plugin *
> 		return ret;
> 
> 	if (!strlen(cfg.devname)) {
> -		fprintf(stderr, "device name missing %d\n", (int)strlen(cfg.devname));
> +		fprintf(stderr, "device name missing\n");
> 		return -EINVAL;
> 	}
> 
> @@ -179,7 +179,7 @@ static int lnvm_create_tgt(int argc, char **argv, struct command *cmd, struct pl
> 		return ret;
> 
> 	if (!strlen(cfg.devname)) {
> -		fprintf(stderr, "device name missing %d\n", (int)strlen(cfg.devname));
> +		fprintf(stderr, "device name missing\n");
> 		return -EINVAL;
> 	}
> 	if (!strlen(cfg.tgtname)) {
> @@ -265,7 +265,7 @@ static int lnvm_factory_init(int argc, char **argv, struct command *cmd, struct
> 		return ret;
> 
> 	if (!strlen(cfg.devname)) {
> -		fprintf(stderr, "device name missing %d\n", (int)strlen(cfg.devname));
> +		fprintf(stderr, "device name missing\n");
> 		return -EINVAL;
> 	}
> 
> --
> 2.17.1

LGTM


Reviewed-by: Javier Gonz?lez <javier at javigon.com>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190723/ab5980fb/attachment.sig>
