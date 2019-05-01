From: james.smart@broadcom.com (James Smart)
Date: Wed, 1 May 2019 14:31:34 -0700
Subject: [PATCH nvme-cli rfc] fabrics: support default connect/discover
 args
In-Reply-To: <b9363689-6c3e-da34-8b17-f1f320cfbd70@broadcom.com>
References: <20190429225338.6866-1-sagi@grimberg.me>
 <b9363689-6c3e-da34-8b17-f1f320cfbd70@broadcom.com>
Message-ID: <6ff91824-3772-c2f8-3548-766f91041bf1@broadcom.com>



On 5/1/2019 2:23 PM, James Smart wrote:
>
>
> On 4/29/2019 3:53 PM, Sagi Grimberg wrote:
>> Introduce /etc/nvme/defargs.conf where we allow the user to
>> specify connect/discover parameters once and not for every
>> controller. The cli will always ingest the content of this
>> file before parsing cmdline args such that the user can
>> override them.
>>
>> The format is simply writing the arguments into the file as
>> if they were appended to the execution command.
>>
>> Also, properly install this file with some minimal documentation.
>>
>> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>> ---
>> This was raised before in the past that we don't have some place
>> to store default connect args.
>>
>> For example, when handling automatic discovery change log events
>> this can be a way for the user to set global default arguments.
>>
>> Feedback is welcome.
>>
>> ? Makefile??????????? |? 3 +++
>> ? etc/defargs.conf.in |? 5 ++++
>> ? fabrics.c?????????? | 63 +++++++++++++++++++++++++++++++++++++++++++++
>> ? nvme.spec.in??????? |? 1 +
>> ? 4 files changed, 72 insertions(+)
>> ? create mode 100644 etc/defargs.conf.in
>>
>>
>> diff --git a/etc/defargs.conf.in b/etc/defargs.conf.in
>> new file mode 100644
>> index 000000000000..e91106bf5bbf
>> --- /dev/null
>> +++ b/etc/defargs.conf.in
>> @@ -0,0 +1,5 @@
>> +# Used for extracting default controller connect parameters
>> +#
>> +# Example:
>> +# --keep-alive-tmo=<x> --reconnect-delay=<y> --ctrl-loss-tmo=<z> 
>> --nr-io-queues=<u>
>> +# --queue-size=<v>
>>
>
> What I'd like to see is a file? (maybe "connectargs.conf") that has a 
> syntax more like:
> <subnqn>? <trtype>? <traddr>? <trsvcid> <host-traddr>? :? <arg list>
>
> where the first 5 things, all addressing components for the connect, 
> can specify a matching policy, and if matched, "arg list" is then 
> applied. An addressing component could be wildcarded, thus match 
> anything.
>
> When a connect or connect-all request is made,? the cli would try to 
> match each line, and if matched, apply the arg list. If an argument 
> was set prior, it would be overridden. Then, command line args can 
> override the arg list built up by the match list.
>
> Thus, for global defaults, the opening line in the file can be?? " * * 
> * * * --keep-alive-tmo=<x> --reconnect-delay=<y>" and all connection 
> attempts would receive those args.
>
> We would probably do some special syntaxes over time:
> Rather than the long string for a discovery controller have a 
> shorthand string that means the same.
> Devise a subnqn syntax that allows a <prefix>* - so that all nqns from 
> vendor x that has the prefix could be applied, and so on.
>
> -- james
>

I do realize this would make us do a first pass through the cmd line 
args to get the addressing components.

-- james
