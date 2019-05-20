From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 20 May 2019 00:20:46 +0000
Subject: [PATCH] nvme-cli: close fd before return
References: <20190519175642.31815-1-chaitanya.kulkarni@wdc.com>
 <20190519184553.GC10876@minwooim-desktop>
Message-ID: <BN8PR04MB57474B1D9FD8DC489487336986060@BN8PR04MB5747.namprd04.prod.outlook.com>

This only covers the code path for nvme commands failure and not the 
errno codes ans thi ps mainly to make all the nvme error and return 
codes consistent.

On 5/19/19 11:46 AM, Minwoo Im wrote:
> This kind of patches are already in Github PR:
>    https://github.com/linux-nvme/nvme-cli/pull/490
> 
>> @@ -1216,7 +1216,7 @@ static int create_ns(int argc, char **argv, struct command *cmd, struct plugin *
>>   				fprintf(stderr, "identify failed\n");
>>   				show_nvme_status(err);
>>   			}
>> -			return err;
>> +			goto close_fd;
>>   		}
>>   		for (i = 0; i < 16; ++i) {
>>   			if ((1 << ns.lbaf[i].ds) == cfg.bs && ns.lbaf[i].ms == 0) {
>> @@ -1245,6 +1245,7 @@ static int create_ns(int argc, char **argv, struct command *cmd, struct plugin *
>>   	else
>>   		perror("create namespace");
>>   
>> + close_fd:
>>   	close(fd);
>>   
>>   	return err;
> 
> If this patch wants to free the leaked file descriptor in case of
> errors, it needs to cover more parts than it shows above.
> You can see the patch for the create_ns() from:
>    https://github.com/linux-nvme/nvme-cli/pull/490/commits/b0c8a309266c2daf6ebadf9ab14884c6954765a1
> 
>> @@ -3198,7 +3199,7 @@ static int format(int argc, char **argv, struct command *cmd, struct plugin *plu
>>   				fprintf(stderr, "identify failed\n");
>>   				show_nvme_status(err);
>>   			}
>> -			return err;
>> +			goto close_fd;
>>   		}
>>   		prev_lbaf = ns.flbas & 0xf;
> 
> It also needs to be coverted with more parts to close the leaked file
> descriptor.
> You can see the patch for the format() from:
>    https://github.com/linux-nvme/nvme-cli/pull/490/commits/e3c487c6d9c145ba0b90d4ef227510b4faa33e98
> 
