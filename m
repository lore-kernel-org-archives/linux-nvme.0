From: sbates@raithlin.com (Stephen Bates)
Date: Mon, 21 Nov 2016 20:43:40 -0600
Subject: [PATCH] nvme: use __iowrite64_copy for SQs in the CMB
In-Reply-To: <20161121091411.GA10123@infradead.org>
References: <CACtDJFcvFUxCPYyy2de9v-0mrngQJ6+T57dc6K+BD04APk2nKA@mail.gmail.com>
 <CACtDJFc2DwsHfVp5BKZLNrJ-EUoJjMCRr1tu9BR4gNyyzT1DHQ@mail.gmail.com>
 <20161121091411.GA10123@infradead.org>
Message-ID: <aa517f417f04c082415dcb004ef77d94.squirrel@webmail.raithlin.com>


>>
>> Any comments on this patch? I didn't receive any so far.
>>
>
> Please explain why we would want to apply the patch, e.g. without
> it some devices may be broken, or that on a particular device you get much
> better performance (including numbers and an explanation of the setup).
>

Some PCIe devices have requirements on the alignment of PCIe writes into
them. Would this patch help with some of those devices?

Stephen
