From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 9 Mar 2017 08:57:46 +0100
Subject: Need some pointers to debug a KASAN splat in NVMe over Fabrics
 with rdma-rxe
In-Reply-To: <CAG9sBKPwEryc7U+hV=XJvRrFFhNvoktDOtwwS6piUw=cQ=bZhA@mail.gmail.com>
References: <5b16edcf-c39a-bc4b-0e32-8ccfb5d75efb@suse.de>
 <CAG9sBKPwEryc7U+hV=XJvRrFFhNvoktDOtwwS6piUw=cQ=bZhA@mail.gmail.com>
Message-ID: <38a12b22-7bad-c069-4c96-39fc93d20d79@suse.de>

Hi Moni,

On 03/08/2017 05:33 PM, Moni Shoua wrote:
> Your report and analysis seem to be accurate (regarding value of wqe->iova)
> Unfortunately we didn't have a chance yet to run kernel application
> tests but I will try to add them soon and be able to debug it myself.
> In the meantime

OK, thanks. This is highly appreciated as I think Soft RoCE is the
coolest thing since sliced bread for quick NVMf/iSER and SRP tests.

> 1. DId the test fail completely or is it just the KASAN error that
> made you look at init_send_wqe()?

No it fails completely. I can see both hosts talk RDMA/NVMf to each
other but the initiator side can't establish a connection. Without KASAN
I couldn't find a reason for it other than the following log message:
rdma_rxe: qp#17 moved to error state

I must admit I haven't looked up it's source yet, as my first test had
KASAN enabled.

> 2. You can take a look at librxe implementation of init_send_wqe() (it
> looks slightly different from kernel's implementation) and see what
> happens if you change implementation accordingly.

OK I'll have a look and hopefully come back with a (RFC) patch (fingers
crossed).

Thanks,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
