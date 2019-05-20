From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 20 May 2019 01:44:22 +0000
Subject: [PATCH] nvme-cli: close fd before return
References: <BN8PR04MB57474B1D9FD8DC489487336986060@BN8PR04MB5747.namprd04.prod.outlook.com>
 <20190519175642.31815-1-chaitanya.kulkarni@wdc.com>
 <20190519184553.GC10876@minwooim-desktop>
 <CGME20190520002113epcas4p345b92c6d82619b92478af81e81392266@epcms2p7>
 <20190520002805epcms2p747debe2606f1a42a2b27a6d665f5612d@epcms2p7>
Message-ID: <BN8PR04MB5747CE9613ADDE4BA1D6A5C986060@BN8PR04MB5747.namprd04.prod.outlook.com>

On 5/19/19 5:28 PM, Minwoo Im wrote:
>> This only covers the code path for nvme commands failure and not the
>> errno codes ans thi ps mainly to make all the nvme error and return
>> codes consistent.
> 
> I think I don't agree with that.  If you want to fix the leaked fd before
> returning directly, then it should make it go to close_fd for the EINVAL
> cases without adding -(negative) on it.
> 
> I think the PR can be merged regardless to errno update now, though.
> 

Before we add your patch-series we need to make all the returns 
consistent which is not present in the format() and create_ns() for nvme 
error status. Ofcourse eventually all the fd leaks needs to be fixed.
This patch makes it sure the leaks for the only nvme error code are 
consistent and on the top of that your series fits well.

Without this we need to add two return calls in the create_ns () 
http://lists.infradead.org/pipermail/linux-nvme/2019-May/024307.html :-

static int attach_ns(int argc, char **argv, struct command *cmd, struct 
plugin *plugin)
@@ -1216,7 +1210,7 @@ static int create_ns(int argc, char **argv, struct 
command *cmd, struct plugin *
  				fprintf(stderr, "identify failed\n");
  				show_nvme_status(err);
  			}
-			return err;
+			return nvme_status_to_errno(err, false);
  		}
  		for (i = 0; i < 16; ++i) {
  			if ((1 << ns.lbaf[i].ds) == cfg.bs && ns.lbaf[i].ms == 0) {
@@ -1246,8 +1240,7 @@ static int create_ns(int argc, char **argv, struct 
command *cmd, struct plugin *
  		perror("create namespace");

  	close(fd);
-
-	return err;
+	return nvme_status_to_errno(err, false);
  }

It should be consistent with all the over functions with one return.

This what I'm trying to avoid (by ignoring other leaks for now), can you 
please explain why it is not a good idea to avoid this ?
