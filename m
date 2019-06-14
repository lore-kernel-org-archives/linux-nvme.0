From: bvanassche@acm.org (Bart Van Assche)
Date: Fri, 14 Jun 2019 10:43:21 -0700
Subject: [PATCH v2 2/3] nvmet: Export NVMe namespace attributes
In-Reply-To: <BYAPR04MB57499B4C1225252183F01ADC86EE0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190610210612.103952-1-bvanassche@acm.org>
 <20190610210612.103952-3-bvanassche@acm.org>
 <BYAPR04MB5749D68053F5CAF2456E17FC86EE0@BYAPR04MB5749.namprd04.prod.outlook.com>
 <4a104091-5ef2-ee3b-9653-cbb816b39a2e@acm.org>
 <BYAPR04MB57499B4C1225252183F01ADC86EE0@BYAPR04MB5749.namprd04.prod.outlook.com>
Message-ID: <a296a5c7-33f0-a1a6-07ec-f64dd8006693@acm.org>

On 6/14/19 10:18 AM, Chaitanya Kulkarni wrote:
>>>> +	id->nsfeat |= 1 << 1;
>>>> +	id->nawun = ppl0b;
>>>> +	id->nawupf = ppl0b;
>>>> +	id->nacwu = ppl0b;
>>> The above 4 assignments are similar to the assignments present in the
>>> nvmet_file_set_limits() ? If so is it make sense to have a helper to
>>> reduce the code duplication ?
>> I don't think that that is a good idea.
> 
> It will be great learning experience for me if you can educate me about
> why this
> 
> is not a good idea, can you please explain  ?
> 
> The rational behind asking for an explanation is that I've got a comment
> on my code
> 
> about not having same copy of the code in the kernel which is right.
> 
> The situation is same here where this code is operating on same
> structure doing the
> 
> same thing across file io-cmd-bdev.c and io-cmd-file.c.
> 
> 
> My understanding is that if this patch gets applied then we will have
> same copy of two
> 
> assignments in the target which are exactly doing the same thing which
> calls for a nice
> 
> little helper function.

Hi Chaitanya,

There is no hard rule that code duplication should be avoided at any
price in the Linux kernel. For this patch I will leave it to the NVMe
maintainers to decide whether or not they want to move these assignments
into a helper function.

Regarding req_op_str(): I had never seen it before if the same
functionality is needed in two different source files in the same
subsystem that code got copy/pasted instead of calling a single function
from all code that needs the functionality. I had asked to avoid to
duplicate req_op_str() because of the following reasons:
- If a new request operation would be added having one req_op_str()
implementation is more convenient than having multiple.
- An operation like conversion from a request operation into a string
should not happen inside f2fs. f2fs should call a block layer function
to do that conversion.

Bart.
