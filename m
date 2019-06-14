From: bvanassche@acm.org (Bart Van Assche)
Date: Fri, 14 Jun 2019 08:31:24 -0700
Subject: [PATCH v2 2/3] nvmet: Export NVMe namespace attributes
In-Reply-To: <BYAPR04MB5749D68053F5CAF2456E17FC86EE0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190610210612.103952-1-bvanassche@acm.org>
 <20190610210612.103952-3-bvanassche@acm.org>
 <BYAPR04MB5749D68053F5CAF2456E17FC86EE0@BYAPR04MB5749.namprd04.prod.outlook.com>
Message-ID: <4a104091-5ef2-ee3b-9653-cbb816b39a2e@acm.org>

On 6/13/19 9:42 PM, Chaitanya Kulkarni wrote:
> On 6/10/19 2:06 PM, Bart Van Assche wrote:
>> +/* Convert a 32-bit number to a 16-bit 0's based number */
>
> Since following function is only helper (and even though it is not in a
> fast patch can we make it inline ?

Do you mean declaring that function as inline or inlining the function? 
The usual approach for small helper functions in .c files is to not 
declare these inline and to let the compiler decide whether or not to 
inline these functions. I don't want to inline that function manually 
because that would reduce readability.

>> +static __le16 to0based(uint32_t a)
>
> The code in io-cmd-bdev.c uses u16, in the above line we are using
> uint32_t. Which one we should follow ? I think either way we should be
> consistent.

Are you sure the purpose of both functions is the same? Changing the 
argument type of this function from uint32_t into uint16_t or u16 is 
wrong. That would cause any argument larger than or equal to 1 << 16 to 
be truncated.

>> +	id->nsfeat |= 1 << 1;
>> +	id->nawun = ppl0b;
>> +	id->nawupf = ppl0b;
>> +	id->nacwu = ppl0b;
>
> The above 4 assignments are similar to the assignments present in the
> nvmet_file_set_limits() ? If so is it make sense to have a helper to
> reduce the code duplication ?

I don't think that that is a good idea.

>> +void nvmet_file_set_limits(struct file *file, struct nvme_id_ns *id)
>> +{
>> +	/* Physical blocks per logical block, 0's based. */
>> +	const __le16 ppl0b = cpu_to_le16(0);
>> +
>> +	/*
>> +	 * For NVMe 1.2 and later, bit 1 indicates that the fields NAWUN,
>> +	 * NAWUPF, and NACWU are defined for this namespace and should be
>> +	 * used by the host for this namespace instead of the AWUN, AWUPF,
>> +	 * and ACWU fields in the Identify Controller data structure.
>> +	 */
>> +	id->nsfeat |= 1 << 1;
>> +	id->nawun = ppl0b;
>> +	id->nawupf = ppl0b;
>> +	id->nacwu = ppl0b;
> 
> The above 3 assignments are where we are assigning value = 0, which will
> be the case any way since caller of this function is using kzalloc() to
> allocate nvme_id_ns *id(), isn't it ?

That change would reduce readability of the code.

The reason I wrote the code this way is because I was hoping that a 
filesystem expert would have a look at this code and tell me whether or 
not the physical block size is available in e.g. the superblock.

Bart.
