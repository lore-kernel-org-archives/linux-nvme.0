From: sbauer@eng.utah.edu (Scott Bauer)
Date: Sat, 18 Feb 2017 08:52:19 -0700
Subject: [PATCHv2 4/5] block/sed: Embed function data into the function
 sequence
In-Reply-To: <20170218083605.GB11798@lst.de>
References: <1487376029-22662-1-git-send-email-jonathan.derrick@intel.com>
 <1487376029-22662-5-git-send-email-jonathan.derrick@intel.com>
 <20170218083605.GB11798@lst.de>
Message-ID: <d6d1c65a-4422-97d7-8ee8-fef46159b143@eng.utah.edu>



On 02/18/2017 01:36 AM, Christoph Hellwig wrote:
> Hi Jon,
> 
> I think this is a great cleanup!
> 
> A few nitpicky comments below:
> 
>> -typedef int (*opal_step)(struct opal_dev *dev);
>> +typedef struct opal_step {
>> +	int (*fn)(struct opal_dev *dev, void *data);
>> +	void *data;
>> +} opal_step;
> 
> no typedefs for structure types, please.
> 
>> +	opal_step *funcs;
> 
> maybe calls this member steps?
> 
>> +static int set_mbr_done(struct opal_dev *dev, void *data)
>>  {
>> -	u8 mbr_done_tf = *(u8 *)dev->func_data[dev->state];
>> +	u8 mbr_done_tf = *(u8 *)data;
> 
> No need for casts when going from void * to any pointer type.  There are
> a couple more instance below where the cast should be removed as well.

In this case he's actually casting & dereferencing the pointer, so it should be fine in this scenario?
