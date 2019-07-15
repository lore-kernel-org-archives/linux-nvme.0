From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 15 Jul 2019 09:41:24 -0600
Subject: [PATCH blktests 11/12] common: Use sysfs instead of modinfo for
 _have_module_param()
In-Reply-To: <20190715072148.GC4495@x250>
References: <20190712235742.22646-1-logang@deltatee.com>
 <20190712235742.22646-12-logang@deltatee.com> <20190715072148.GC4495@x250>
Message-ID: <91d723da-c1de-ae8b-d1c8-0a3bcee491db@deltatee.com>



On 2019-07-15 1:21 a.m., Johannes Thumshirn wrote:
> On Fri, Jul 12, 2019@05:57:41PM -0600, Logan Gunthorpe wrote:
>> Using modinfo fails if the given module is built-in. Instead,
>> just check for the parameter's existence in sysfs.
>>
>> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
>> ---
>>  common/rc | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/common/rc b/common/rc
>> index 49050c71dabf..d48f73c5bf3d 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -48,7 +48,7 @@ _have_modules() {
>>  }
>>  
>>  _have_module_param() {
>> -	if ! modinfo -F parm -0 "$1" | grep -q -z "^$2:"; then
>> +	if ! [ -e "/sys/module/$1/parameters/$2" ]; then
>>  		SKIP_REASON="$1 module does not have parameter $2"
>>  		return 1
>>  	fi
> 
> But this now fails if the module isn't loaded yet. IMHO we'll need to check if
> "/sys/module/$1" exists and if it does check for
> "/sys/module/$1/parameters/$2", if not try modinfo.
> 
> Does that make sense?

Yup, will fix for v2.

Thanks,

Logan
