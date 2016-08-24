From: roysh@mellanox.com (Roy Shterman)
Date: Wed, 24 Aug 2016 09:48:14 +0300
Subject: [PATCH] nvme-cli/fabrics: Added hostnqn parameter to connect
 command
In-Reply-To: <1471995724.23443.32.camel@linux.intel.com>
References: <1471946706-18036-1-git-send-email-roysh@mellanox.com>
 <1471995724.23443.32.camel@linux.intel.com>
Message-ID: <d137dcf6-88a3-4ce7-0e7a-e6823bd6b826@mellanox.com>



On 8/24/2016 2:42 AM, J Freyensee wrote:
> On Tue, 2016-08-23@13:05 +0300, Roy Shterman wrote:
>> Added user-defined 'hostnqn' to 'connect' command
>> so users could use the allowed_hosts attribute on the target and
>> still
>> connect to target with nvme-cli tool.
>>
>> usage examples:
>> 	nvme discover -t <TRANSPORT> -a <ADDRESS> -s <SERVICE_ID> -q
>> <USER-DEFINED_HOSTNQN>
> I believe the example needs to be changed from 'discover' to 'connect'
> ;-)
>
> Jay
That's correct, I will sent a new patch :)
>> Signed-off-by: Roy Shterman <roysh at mellanox.com>
>> ---
>>   fabrics.c |    2 ++
>>   1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/fabrics.c b/fabrics.c
>> index 26c4e22..942e987 100644
>> --- a/fabrics.c
>> +++ b/fabrics.c
>> @@ -711,6 +711,8 @@ int connect(const char *desc, int argc, char
>> **argv)
>>   			"transport address" },
>>   		{"trsvcid", 's', "LIST", CFG_STRING, &cfg.trsvcid,
>> required_argument,
>>   			"transport service id (e.g. IP port)" },
>> +		{"hostnqn", 'q', "LIST", CFG_STRING, &cfg.hostnqn,
>> required_argument,
>> +			"user-defined hostnqn" },
>>   		{0},
>>   	};
>>   
