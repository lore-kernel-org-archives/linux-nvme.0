From: bvanassche@acm.org (Bart Van Assche)
Date: Tue, 4 Dec 2018 18:33:39 -0800
Subject: [PATCH] nvme-core: small cleanups
In-Reply-To: <20181204223709.GA17048@localhost.localdomain>
References: <20181129171804.5241-1-chaitanya.kulkarni@wdc.com>
 <1543876976.185366.175.camel@acm.org> <20181204222602.GA12719@infradead.org>
 <20181204223709.GA17048@localhost.localdomain>
Message-ID: <68f4a6b2-2c80-0eab-8305-3358fd8b989a@acm.org>

On 12/4/18 2:37 PM, Keith Busch wrote:
> On Tue, Dec 04, 2018@02:26:02PM -0800, Christoph Hellwig wrote:
>> On Mon, Dec 03, 2018@02:42:56PM -0800, Bart Van Assche wrote:
>>> On Thu, 2018-11-29@09:18 -0800, Chaitanya Kulkarni wrote:
>>>>   static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
>>>>   {
>>>> -	struct nvme_command c = { };
>>>> +	struct nvme_command c;
>>>>   	int error;
>>>>   
>>>> +	memset(&c, 0, sizeof(c));
>>>
>>> Please drop this and all similar changes. I think the preferred style in the Linux
>>> kernel for structure initialization is to use "= { }" instead of memset().
>>
>> I defintively prefer it.  But I don't think changing things either
>> way is really worth the effort anyway unless you change the surrounding
>> code to start with.
> 
> The empty braces initialization is a gcc extension. For standard C
> portability, you may use "= { 0 }" ... just in case anyone cares. :)

Let's change the C standard instead. Several other gcc extensions have 
already been incorporated in recent versions of the C standard.

Bart.
