From: javier@javigon.com (=?utf-8?Q?Javier_Gonz=C3=A1lez?=)
Date: Thu, 25 Jul 2019 15:53:06 +0200
Subject: [PATCH 4/5] lnvm: introduce chunk-log command for chunk info
In-Reply-To: <20190725133736.GB3018@minwoo-desktop>
References: <20190723183601.29370-1-minwoo.im.dev@gmail.com>
 <20190723183601.29370-5-minwoo.im.dev@gmail.com>
 <20B9C888-532C-4762-9886-8C5E196CB5A4@javigon.com>
 <20190725133736.GB3018@minwoo-desktop>
Message-ID: <C15E06A5-2093-4023-8B32-43005D27D898@javigon.com>

> On 25 Jul 2019,@15.37, Minwoo Im <minwoo.im.dev@gmail.com> wrote:
> 
> Hi Javier,
> 
> Thanks for the review.
> 
>>> +int lnvm_do_chunk_log(int fd, __u32 nsid, __u32 data_len, void *data,
>>> +			unsigned int flags)
>>> +{
>>> +	int err;
>>> +
>>> +	err = nvme_get_log13(fd, nsid, NVM_LID_CHUNK_INFO, 0, 0, 0,
>>> +			false, data_len, data);
>>> +	if (!err) {
>>> +		if (flags & RAW)
>>> +			d_raw(data, data_len);
>>> +		else
>>> +			show_lnvm_chunk_log(data, data_len);
>>> +	} else if (err > 0)
>>> +		fprintf(stderr, "NVMe Status:%s(%x) NSID:%d\n",
>>> +			nvme_status_to_string(err), err, nsid);
>>> +	return err;
>> 
>> What about avoiding the nested if?
>> 
>> If (err) {
>> 	fprintf(stderr, "NVMe Status:%s(%x) NSID:%d\n",
>> 			nvme_status_to_string(err), err, nsid);
>> 
>> 	goto out;
>> }
>> 
>> If (flags & RAW)
>> 	d_raw(data, data_len);
>> else
>> 	show_lnvm_chunk_log(data, data_len);
>> 
>> out:
>> return err;
> 
> That makes sense, we should avoid the case when "err" is negative value
> which means the internal error from the nvme_get_log13() in printing the
> nvme status.  So how about this?
> 
> ```c
> 	if (err > 0) {
> 		fprintf(stderr, "NVMe Status:%s(%x) NSID:%d\n",
> 			nvme_status_to_string(err), err, nsid);
> 
> 		goto out;
> 	} else if (err < 0) {
> 		err = -errno;
> 		perror("nvme_get_log13");
> 
> 		goto out;
> 	}
> 
> 	if (flags & RAW)
> 		d_raw(data, data_len);
> 	else
> 		show_lnvm_chunk_log(data, data_len);
> 
> out:
> 	return err;
> ```

Looks good.

> 
>>> +}
>>> +
>>> static void show_lnvm_bbtbl(struct nvme_nvm_bb_tbl *tbl)
>>> {
>>> 	printf("verid    : %#x\n", (uint16_t)le16_to_cpu(tbl->verid));
>>> diff --git a/nvme-lightnvm.h b/nvme-lightnvm.h
>>> index 7a8ef7d..19660b7 100644
>>> --- a/nvme-lightnvm.h
>>> +++ b/nvme-lightnvm.h
>>> @@ -322,6 +322,7 @@ int lnvm_do_create_tgt(char *, char *, char *, int, int, int, int);
>>> int lnvm_do_remove_tgt(char *);
>>> int lnvm_do_factory_init(char *, int, int, int);
>>> int lnvm_do_id_ns(int, int, unsigned int);
>>> +int lnvm_do_chunk_log(int, __u32, __u32, void *, unsigned int);
>>> int lnvm_do_get_bbtbl(int, int, int, int, unsigned int);
>>> int lnvm_do_set_bbtbl(int, int, int, int, int, int, __u8);
>>> 
>>> diff --git a/plugins/lnvm/lnvm-nvme.c b/plugins/lnvm/lnvm-nvme.c
>>> index 754931a..6f2724a 100644
>>> --- a/plugins/lnvm/lnvm-nvme.c
>>> +++ b/plugins/lnvm/lnvm-nvme.c
>>> @@ -1,5 +1,7 @@
>>> #include <stdio.h>
>>> #include <errno.h>
>>> +#include <stdlib.h>
>>> +#include <unistd.h>
>>> 
>>> #include "nvme.h"
>>> #include "nvme-print.h"
>>> @@ -127,6 +129,88 @@ static int lnvm_id_ns(int argc, char **argv, struct command *cmd, struct plugin
>>> 	return lnvm_do_id_ns(fd, cfg.namespace_id, flags);
>>> }
>>> 
>>> +static int lnvm_chunk_log(int argc, char **argv, struct command *cmd, struct plugin *plugin)
>>> +{
>>> +	const char *desc = "Retrieve the chunk information log for the "\
>>> +		"specified given LightNVM device, returns in either "\
>>> +		"human-readable or binary format.\n"\
>>> +		"This will request Geometry first to get the "\
>>> +		"num_grp,num_pu,num_chk first to figure out the total size "\
>>> +		"of the log pages."\
>>> +		;
>>> +	const char *output_format = "Output format: normal|binary?;
>> 
>> normalbinary -> normal binary?
> 
> Oh It has "|" between them.  But I'm fine with that too.  It was just
> derieved from the nvme.c core module which builtin commands are taking
> now.

Oh, I didn?t see that. My mistake.

Javier
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190725/f4a438f8/attachment-0001.sig>
