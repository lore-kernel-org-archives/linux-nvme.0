From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 8 Aug 2016 11:41:15 +0300
Subject: [PATCH nvme-cli 2/4] fabrics: stringify discover output.
In-Reply-To: <20160808065934.GB12598@lst.de>
References: <1470572365-20674-1-git-send-email-sagi@grimberg.me>
 <1470572365-20674-3-git-send-email-sagi@grimberg.me>
 <20160808065934.GB12598@lst.de>
Message-ID: <151359dc-4247-8b08-fa3f-0841e1c29c05@grimberg.me>


>> Just so we have a nice readable output.
>>
>> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>> ---
>>  fabrics.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 107 insertions(+), 8 deletions(-)
>>
>> diff --git a/fabrics.c b/fabrics.c
>> index 221e34e5e39b..9f99e6175428 100644
>> --- a/fabrics.c
>> +++ b/fabrics.c
>> @@ -63,6 +63,106 @@ static const match_table_t opt_tokens = {
>>  	{ OPT_ERR,		NULL		},
>>  };
>>
>> +#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
>
> should go into a header so that all of the tool has it available.

You're right, Moved to common.h

>> +static const char *cms_str(__u8 cm)
>> +{
>> +	size_t idx = cm;
>> +
>> +	return (idx < ARRAY_SIZE(cms) && cms[idx]) ?
>> +			cms[idx] : "unrecognized";
>> +}
>
> How about a little helper instead of duplicating this pattern many
> times, e.g
>
> static const char *lookup_string(const char **strings, size_t array_size,
> 		size_t id)
> {
> 	if (idx < array_size && strings[idx])
> 		return strings[idx];
> 	return "unrecognized";
> }

It is nicer, thanks!

Added, just with a different name: arg_str()

>
> also makes me wonder why we even bother with the inline annotation
> for such slow path code.

Because it's really short and simply returns a string. I can lose it...
