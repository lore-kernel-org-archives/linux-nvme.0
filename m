From: saar@annapurnalabs.com (Saar Gross)
Date: Wed, 30 Nov 2016 10:31:45 +0200
Subject: [PATCH] nvme: use __iowrite64_copy for SQs in the CMB
In-Reply-To: <aa517f417f04c082415dcb004ef77d94.squirrel@webmail.raithlin.com>
References: <CACtDJFcvFUxCPYyy2de9v-0mrngQJ6+T57dc6K+BD04APk2nKA@mail.gmail.com>
 <CACtDJFc2DwsHfVp5BKZLNrJ-EUoJjMCRr1tu9BR4gNyyzT1DHQ@mail.gmail.com>
 <20161121091411.GA10123@infradead.org>
 <aa517f417f04c082415dcb004ef77d94.squirrel@webmail.raithlin.com>
Message-ID: <CACtDJFfFL2uha09razaLA+D1pwfj0mXdiRQ+UXTFND+GHo5Mwg@mail.gmail.com>

Sorry for taking so long to reply: yes, it might help with some PCIe
devices with weird alignment requirements.

The patch itself doesn't fix any broken devices (possibly other than
those PCIe devices mentioned above), it only replaces the current
implementation of memcpy_toio() to __iowrite64_copy() which is more
suited when working with WC buffers. We've tested the patch on a CMB
enabled device where we got the same performance as the original
implementation, which is expected as using __iowrite64_copy() should
really only make a difference with a very stressed system.

Thanks,
Saar


On Tue, Nov 22, 2016@4:43 AM, Stephen Bates <sbates@raithlin.com> wrote:
>
>>>
>>> Any comments on this patch? I didn't receive any so far.
>>>
>>
>> Please explain why we would want to apply the patch, e.g. without
>> it some devices may be broken, or that on a particular device you get much
>> better performance (including numbers and an explanation of the setup).
>>
>
> Some PCIe devices have requirements on the alignment of PCIe writes into
> them. Would this patch help with some of those devices?
>
> Stephen
>
