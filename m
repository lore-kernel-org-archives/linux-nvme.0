From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 8 May 2019 17:26:55 +0900
Subject: [PATCH V2 2/2] nvme-trace: Add support to trace fabrics command
In-Reply-To: <20190508072531.GD21823@lst.de>
References: <20190506194644.11109-1-minwoo.im.dev@gmail.com>
 <20190506194644.11109-3-minwoo.im.dev@gmail.com>
 <20190508072531.GD21823@lst.de>
Message-ID: <47dbbe1d-0f47-1197-17dd-16553ba645a4@gmail.com>

On 5/8/19 4:25 PM, Christoph Hellwig wrote:
>> +	if (likely(!nvme_is_fabrics(cmd)))
>> +		trace_nvme_setup_cmd(req, cmd);
>> +	else
>> +		trace_nvme_setup_fabrics_cmd(req, cmd);
>> +
> 
> I wonder if we really need this.  My idea would have been to just
> branch out to the fabrics command parser from parse_nvme_cmd().  Or did
> I miss something why that might not work?

You didn't miss anything.  I was trying to separate fabrics commands out 
of it because they have a little bit different "common" SQE fields than 
the existing one.  That's why I made it separated.

If you want parse_nvme_cmd() branch out to something like 
nvme_parse_fabrics_cmd(), it would be easier to go.  Actually that was 
my second try, but I thought people wanted to show the exact fields for 
fabrics commands in traces.

Anyway, If it's okay to go with common fields in common, and from the 
cdw10 position, I'l prepare a V3 patch.

> The benefit is that we don't have an additional branch in the
> non-tracing fast path (and also make it look a little nicer).

100% agreed.  As Chaitanya was worried about this part, I'm now also.

>> +#define show_fabric_type_name(type)					\
>> +	show_nvm_fabrics_type_name(type)
> 
> Why do we need this #define to the same name/signature?

Oh, I was just trying to form it like existing one.  I was referring 
show_opcode_name(), but, That just needs to branch out by a given "qid".

This #define has no need to define like this. Thanks for your review.
