From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 2 Jun 2019 23:22:21 +0000
Subject: [PATCH] nvme-cli: add default value for nsid of write-zeroes
References: <20190601070003.20142-1-minwoo.im.dev@gmail.com>
 <bfac4b78-937c-42e8-1be1-f9a81ad22ab7@grimberg.me>
Message-ID: <BYAPR04MB5749A32C48ADD555EF1B6A8C861B0@BYAPR04MB5749.namprd04.prod.outlook.com>

On 6/2/19 12:12 AM, Sagi Grimberg wrote:
>> diff --git a/nvme.c b/nvme.c
>> index 9819fcb..a7a96a1 100644
>> --- a/nvme.c
>> +++ b/nvme.c
>> @@ -3731,6 +3731,7 @@ static int write_zeroes(int argc, char **argv, struct command *cmd, struct plugi
>>   
>>   	struct config cfg = {
>>   		.start_block     = 0,
>> +		.namespace_id    = 0,
> This is implicitly set to 0. You should mention that you add this just
> for clarification, and its not fixing a bug.
Is this breaking any testcases or expected behavior ?
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
