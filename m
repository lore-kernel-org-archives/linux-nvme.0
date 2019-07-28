From: jacek.anaszewski@gmail.com (Jacek Anaszewski)
Date: Sun, 28 Jul 2019 19:46:13 +0200
Subject: [PATCH v2 1/3] block: introduce LED block device activity trigger
In-Reply-To: <CAC5umygzNj=7LjzrzrVgOyLiZrKckaCgH68j0COFuWvX1yZAzA@mail.gmail.com>
References: <1563807552-23498-1-git-send-email-akinobu.mita@gmail.com>
 <1563807552-23498-2-git-send-email-akinobu.mita@gmail.com>
 <44a6093f-7df7-9442-c33b-5827eb5f187b@gmail.com>
 <CAC5umygzNj=7LjzrzrVgOyLiZrKckaCgH68j0COFuWvX1yZAzA@mail.gmail.com>
Message-ID: <5630049e-7ab7-e48e-894d-b07a87fe6c25@gmail.com>

Hi Akinobu,

On 7/28/19 3:51 PM, Akinobu Mita wrote:
> 2019?7?27?(?) 6:22 Jacek Anaszewski <jacek.anaszewski at gmail.com>:
>>
>> Hi Akinobu,
>>
>> Thank you for the v2. I've checked and it works as expected.
>>
>> One thing is missing though - ABI documentation.
>>
>> Please add Documentation/ABI/testing/sysfs-class-led-trigger-blk
>> and document read, write and discard files.
> 
> OK. I'll add document like below.
> 
> What:           /sys/class/leds/<led>/interval
> Date:           Aug 2019
> KernelVersion:  5.4
> Contact:        linux-leds at vger.kernel.org
> Description:
>                 Specifies the duration of the LED blink in milliseconds.
>                 Defaults to 50 ms.
> 
> What:           /sys/class/leds/<led>/read
> Date:           Aug 2019
> KernelVersion:  5.4
> Contact:        linux-leds at vger.kernel.org
> Description:
>                 Signal data read on the block device.
>                 If set to 0, the LED will not blink on data read.
>                 If set to 1 (default), the LED will blink for the milliseconds
>                 specified in interval to signal data read.
> 
> What:           /sys/class/leds/<led>/write
> Date:           Aug 2019
> KernelVersion:  5.4
> Contact:        linux-leds at vger.kernel.org
> Description:
>                 Signal data written on the block device.
>                 If set to 0, the LED will not blink on data written.
>                 If set to 1 (default), the LED will blink for the milliseconds
>                 specified in interval to signal data written.
> 
> What:           /sys/class/leds/<led>/discard
> Date:           Aug 2019
> KernelVersion:  5.4
> Contact:        linux-leds at vger.kernel.org
> Description:
>                 Signal data discarded on the block device.
>                 If set to 0, the LED will not blink on data discarded.
>                 If set to 1 (default), the LED will blink for the milliseconds
>                 specified in interval to signal data discarded.
> 

Looks good, please submit it officially.

-- 
Best regards,
Jacek Anaszewski
