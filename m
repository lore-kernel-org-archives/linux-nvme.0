From: minwoo.im@samsung.com (Minwoo Im)
Date: Mon, 20 May 2019 10:54:01 +0900
Subject: [PATCH] nvme-cli: close fd before return
In-Reply-To: <BN8PR04MB5747CE9613ADDE4BA1D6A5C986060@BN8PR04MB5747.namprd04.prod.outlook.com>
References: <BN8PR04MB5747CE9613ADDE4BA1D6A5C986060@BN8PR04MB5747.namprd04.prod.outlook.com>
 <BN8PR04MB57474B1D9FD8DC489487336986060@BN8PR04MB5747.namprd04.prod.outlook.com>
 <20190519175642.31815-1-chaitanya.kulkarni@wdc.com>
 <20190519184553.GC10876@minwooim-desktop>
 <20190520002805epcms2p747debe2606f1a42a2b27a6d665f5612d@epcms2p7>
 <CGME20190520002113epcas4p345b92c6d82619b92478af81e81392266@epcms2p4>
Message-ID: <20190520015401epcms2p413869afe9728ffc36248cf8e5e00888e@epcms2p4>

> Before we add your patch-series we need to make all the returns
> consistent which is not present in the format() and create_ns() for nvme
> error status. Ofcourse eventually all the fd leaks needs to be fixed.
> This patch makes it sure the leaks for the only nvme error code are
> consistent and on the top of that your series fits well.
> 
> Without this we need to add two return calls in the create_ns ()
> http://lists.infradead.org/pipermail/linux-nvme/2019-May/024307.html :-
> 
> static int attach_ns(int argc, char **argv, struct command *cmd, struct
> plugin *plugin)
> @@ -1216,7 +1210,7 @@ static int create_ns(int argc, char **argv, struct
> command *cmd, struct plugin *
>   				fprintf(stderr, "identify failed\n");
>   				show_nvme_status(err);
>   			}
> -			return err;
> +			return nvme_status_to_errno(err, false);
>   		}
>   		for (i = 0; i < 16; ++i) {
>   			if ((1 << ns.lbaf[i].ds) == cfg.bs && ns.lbaf[i].ms == 0)
> {
> @@ -1246,8 +1240,7 @@ static int create_ns(int argc, char **argv, struct
> command *cmd, struct plugin *
>   		perror("create namespace");
> 
>   	close(fd);
> -
> -	return err;
> +	return nvme_status_to_errno(err, false);
>   }
> 
> It should be consistent with all the over functions with one return.
> 
> This what I'm trying to avoid (by ignoring other leaks for now), can you
> please explain why it is not a good idea to avoid this ?

I never thought it was not a good idea.  I just told you that it's just a
duplicated patch with on-going PR in the Github.

If we are returning the nvme_status_to_errno() in that other patch that
I have posted twice, is it that critical factor which blocks the patchsets to
be merged?

I don't know what exactly the issues are between "first merge patch serias
and code-cleanup there",  and "first merge this fix and rebase the patch series".
When I was preparing the patch series about errno, I was also hate that
codes you have posted above, but I need to make it focused first to make
people review this series first even there are two times calling like above.

If you really want to make it consistent, then why don't we just title it like
"Do not return in case of errors in the middle"

If you really want to close fd to fix the leak issue, then I think it needs to 
cover more than that.
