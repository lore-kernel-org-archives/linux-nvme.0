From: jsmart2021@gmail.com (James Smart)
Date: Thu, 19 Oct 2017 08:58:13 -0700
Subject: [PATCH 1/3] nvme: add duplicate_connect option
In-Reply-To: <20171019152024.GA4239@infradead.org>
References: <20171011003512.5946-1-jsmart2021@gmail.com>
 <20171011003512.5946-2-jsmart2021@gmail.com>
 <20171019152024.GA4239@infradead.org>
Message-ID: <458ccb0c-41fd-2709-5d90-033f8a111e75@gmail.com>

On 10/19/2017 8:20 AM, Christoph Hellwig wrote:
>> +	{ NVMF_OPT_DUP_CONNECT,		"duplicate_connect=%d"	},
> 
> This is a boolean parameter, so please drop the "=%d here".
> 
>> +		case NVMF_OPT_DUP_CONNECT:
>> +			if (match_int(args, &token)) {
>> +				ret = -EINVAL;
>> +				goto out;
>> +			}
>> +			if (token == 0)
>> +				opts->duplicate_connect = false;
>> +			else if (token == 1)
>> +				opts->duplicate_connect = true;
>> +			else {
>> +				pr_err("Invalid duplicate_connect %d\n", token);
>> +				ret = -EINVAL;
>> +				goto out;
>> +			}
>> +			break;
> 
> And replace all this code by:
> 
> 	case NVMF_OPT_DUP_CONNECT:
> 		opts->duplicate_connect = true;
> 		break;
> 
> That being said I'd be tempted to keep the existing behavior as
> the default, and make noduplicates the option.
> 

ok, so the mere existence of the parameter means it's true.  That's fine 
and I can repost.

I disagree with allowing duplicates to be the default.  Generically, I 
think it should be the exception. Let the admin that will create 
duplicates, thus is well aware of the ramifications and that it is a 
duplication, use the explicit syntax.  Note: currently patches only 
allow the option for "nvme connect", not "connect-all".

Selfishly, making duplicates allowed the defaults also impacts the 
scripts posted for FC, and widens the nvme cli syntax to connect-all.

-- james
