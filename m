From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Mon, 20 May 2019 03:45:55 +0900
Subject: [PATCH] nvme-cli: close fd before return
In-Reply-To: <20190519175642.31815-1-chaitanya.kulkarni@wdc.com>
References: <20190519175642.31815-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20190519184553.GC10876@minwooim-desktop>

This kind of patches are already in Github PR:
  https://github.com/linux-nvme/nvme-cli/pull/490

> @@ -1216,7 +1216,7 @@ static int create_ns(int argc, char **argv, struct command *cmd, struct plugin *
>  				fprintf(stderr, "identify failed\n");
>  				show_nvme_status(err);
>  			}
> -			return err;
> +			goto close_fd;
>  		}
>  		for (i = 0; i < 16; ++i) {
>  			if ((1 << ns.lbaf[i].ds) == cfg.bs && ns.lbaf[i].ms == 0) {
> @@ -1245,6 +1245,7 @@ static int create_ns(int argc, char **argv, struct command *cmd, struct plugin *
>  	else
>  		perror("create namespace");
>  
> + close_fd:
>  	close(fd);
>  
>  	return err;

If this patch wants to free the leaked file descriptor in case of
errors, it needs to cover more parts than it shows above.
You can see the patch for the create_ns() from:
  https://github.com/linux-nvme/nvme-cli/pull/490/commits/b0c8a309266c2daf6ebadf9ab14884c6954765a1

> @@ -3198,7 +3199,7 @@ static int format(int argc, char **argv, struct command *cmd, struct plugin *plu
>  				fprintf(stderr, "identify failed\n");
>  				show_nvme_status(err);
>  			}
> -			return err;
> +			goto close_fd;
>  		}
>  		prev_lbaf = ns.flbas & 0xf;

It also needs to be coverted with more parts to close the leaked file
descriptor.
You can see the patch for the format() from:
  https://github.com/linux-nvme/nvme-cli/pull/490/commits/e3c487c6d9c145ba0b90d4ef227510b4faa33e98
