From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Fri, 14 Jun 2019 17:18:04 +0000
Subject: [PATCH v2 2/3] nvmet: Export NVMe namespace attributes
References: <20190610210612.103952-1-bvanassche@acm.org>
 <20190610210612.103952-3-bvanassche@acm.org>
 <BYAPR04MB5749D68053F5CAF2456E17FC86EE0@BYAPR04MB5749.namprd04.prod.outlook.com>
 <4a104091-5ef2-ee3b-9653-cbb816b39a2e@acm.org>
Message-ID: <BYAPR04MB57499B4C1225252183F01ADC86EE0@BYAPR04MB5749.namprd04.prod.outlook.com>

Hi Bart,

Thanks for the reply. Please see my inline reply, some things I'm not clear
about so asking for explanation which will help me in future to write a
better code.
My goal is to write a better code so it will be easy for maintainers and
reviewers.

On 6/14/19 8:31 AM, Bart Van Assche wrote:
> On 6/13/19 9:42 PM, Chaitanya Kulkarni wrote:
>> On 6/10/19 2:06 PM, Bart Van Assche wrote:
>>> +/* Convert a 32-bit number to a 16-bit 0's based number */
>> Since following function is only helper (and even though it is not in a
>> fast patch can we make it inline ?
> Do you mean declaring that function as inline or inlining the function? 
Not inline the function since it is makes perfect sense to have this
helpers.
> The usual approach for small helper functions in .c files is to not 
> declare these inline and to let the compiler decide whether or not to 
> inline these functions. I don't want to inline that function manually 
> because that would reduce readability.
Okay.
>
>>> +static __le16 to0based(uint32_t a)
>> The code in io-cmd-bdev.c uses u16, in the above line we are using
>> uint32_t. Which one we should follow ? I think either way we should be
>> consistent.
> Are you sure the purpose of both functions is the same? Changing the 
> argument type of this function from uint32_t into uint16_t or u16 is 
> wrong. That would cause any argument larger than or equal to 1 << 16 to 
> be truncated.

Sorry for not being clear, what I meant is uintXXX_t vs uXX. e.g.
instead of uint16_t ->u16

uint32_t ->u32. My comment refereed to the consistency of the data type
and not

changing the size of the variable.

>
>>> +	id->nsfeat |= 1 << 1;
>>> +	id->nawun = ppl0b;
>>> +	id->nawupf = ppl0b;
>>> +	id->nacwu = ppl0b;
>> The above 4 assignments are similar to the assignments present in the
>> nvmet_file_set_limits() ? If so is it make sense to have a helper to
>> reduce the code duplication ?
> I don't think that that is a good idea.

It will be great learning experience for me if you can educate me about
why this

is not a good idea, can you please explain  ?

The rational behind asking for an explanation is that I've got a comment
on my code

about not having same copy of the code in the kernel which is right.

The situation is same here where this code is operating on same
structure doing the

same thing across file io-cmd-bdev.c and io-cmd-file.c.


My understanding is that if this patch gets applied then we will have
same copy of two

assignments in the target which are exactly doing the same thing which
calls for a nice

little helper function.

>
>>> +void nvmet_file_set_limits(struct file *file, struct nvme_id_ns *id)
>>> +{
>>> +	/* Physical blocks per logical block, 0's based. */
>>> +	const __le16 ppl0b = cpu_to_le16(0);
>>> +
>>> +	/*
>>> +	 * For NVMe 1.2 and later, bit 1 indicates that the fields NAWUN,
>>> +	 * NAWUPF, and NACWU are defined for this namespace and should be
>>> +	 * used by the host for this namespace instead of the AWUN, AWUPF,
>>> +	 * and ACWU fields in the Identify Controller data structure.
>>> +	 */
>>> +	id->nsfeat |= 1 << 1;
>>> +	id->nawun = ppl0b;
>>> +	id->nawupf = ppl0b;
>>> +	id->nacwu = ppl0b;
>> The above 3 assignments are where we are assigning value = 0, which will
>> be the case any way since caller of this function is using kzalloc() to
>> allocate nvme_id_ns *id(), isn't it ?
> That change would reduce readability of the code.
>
> The reason I wrote the code this way is because I was hoping that a 
> filesystem expert would have a look at this code and tell me whether or 
> not the physical block size is available in e.g. the superblock.

Okay, I understand now thanks again.

>
> Bart.
>
>
