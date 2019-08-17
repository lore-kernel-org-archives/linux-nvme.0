From: jacek.anaszewski@gmail.com (Jacek Anaszewski)
Date: Sat, 17 Aug 2019 22:07:43 +0200
Subject: [PATCH v4 4/5] block: introduce LED block device activity trigger
In-Reply-To: <20190817145509.GA18381@amd>
References: <1565888399-21550-1-git-send-email-akinobu.mita@gmail.com>
 <1565888399-21550-5-git-send-email-akinobu.mita@gmail.com>
 <20190817145509.GA18381@amd>
Message-ID: <925633c4-a459-5e84-9c9a-502a504fdc82@gmail.com>

On 8/17/19 4:55 PM, Pavel Machek wrote:
> On Fri 2019-08-16 01:59:58, Akinobu Mita wrote:
>> This allows LEDs to be controlled by block device activity.
>>
>> We already have ledtrig-disk (LED disk activity trigger), but the lower
>> level disk drivers need to utilize ledtrig_disk_activity() to make the
>> LED blink.
>>
>> The LED block device trigger doesn't require the lower level drivers to
>> have any instrumentation. The activity is collected by polling the disk
>> stats.
>>
>> Example:
>>
>> echo block-nvme0n1 > /sys/class/leds/diy/trigger
> 
> Lets use one trigger "block" and have the device as a parameter,
> please.
> 
> We already have 1000 cpu triggers on 1000 cpu machines, and yes, its a
> disaster we'll need to fix. Lets not repeat the same mistake here.
> 
> I guess it may be slightly more work. Sorry about that.

We should be able to list available block devices to set,
so the problem would be not avoided anyway. And Greg already proposed
a solution for trigger file PAGE_SIZE overflow, so this should not pose
a big problem in the future once that is implemented.

> 								Pavel
> 
>> +++ b/include/linux/leds.h
>> +#else
>> +
>> +struct ledtrig_blk {
>> +};
>> +
> 
> Is the empty struct neccessary?

Yeah, I didn't like that too and tried to play with the code to turn
it into a pointer but it turned out to be non-trivial.

The thing is that struct ledtrig_blk is made a property of
struct gendisk, which then allows to get a pointer to the struct gendisk
of the registrar in ledtrig_blk_work() via container_of macro.

Initially I did not realize the problem and asked Akinobu to move the
trigger implementation to the LED subsystem since it seems to have
likely broad use and it would be good to have it visible in the LED
triggers config menu.

That move unfortunately entails the cumbersome dependency we're
discussing now. It's to be decided then if it wouldn't be cleaner
to have that trigger entirely implemented on gendisk side.

>> +static inline void ledtrig_blk_enable(struct gendisk *disk)
>> +{
>> +}
>> +
>> +static inline void ledtrig_blk_disable(struct gendisk *disk)
>> +{
>> +}
>> +
>> +static inline int ledtrig_blk_register(struct gendisk *disk)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline void ledtrig_blk_unregister(struct gendisk *disk)
>> +{
>> +}
> 
> Normally we put such empty functions on single lines...
> 
> Best regards,
> 									     Pavel
> 

-- 
Best regards,
Jacek Anaszewski
