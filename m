From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 12 Mar 2019 14:07:38 -0700
Subject: [PATCH v4 3/3] nvmet-file: clamp-down file namespace lba_shift
In-Reply-To: <20190312143345.GB1149@lst.de>
References: <20190311220227.23656-1-sagi@grimberg.me>
 <20190311220227.23656-4-sagi@grimberg.me> <20190312143345.GB1149@lst.de>
Message-ID: <a220e95a-32f8-65b4-1591-44408b2d8fa2@grimberg.me>


>> When the backing file is a tempfile for example, the inode i_blkbits
>> can be 1M in size which causes problems for hosts to support as the
>> disk block size.
>>
>> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>> ---
>>   drivers/nvme/target/io-cmd-file.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
>> index 517522305e5c..d52fe965a5d5 100644
>> --- a/drivers/nvme/target/io-cmd-file.c
>> +++ b/drivers/nvme/target/io-cmd-file.c
>> @@ -49,7 +49,12 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
>>   		goto err;
>>   
>>   	ns->size = stat.size;
>> -	ns->blksize_shift = file_inode(ns->file)->i_blkbits;
>> +	/*
>> +	 * inode i_blkbits can be greater than the universally accepted upper
>> +	 * bound so make sure we export we export a sane namespace lba_shift.
>> +	 */
>> +	ns->blksize_shift = min_t(u8,
>> +			file_inode(ns->file)->i_blkbits, PAGE_SHIFT);
> 
> I still wonder why we clamp this down to PAGE SIZE rather than 4k.
> 
> Everything larger than 4k has a huge chance of not working with most
> remote hosts, even if our target system has a larger page size.

loop does the same thing, didn't ever hear complaints on that..
