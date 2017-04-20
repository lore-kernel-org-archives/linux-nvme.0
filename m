From: luto@kernel.org (Andy Lutomirski)
Date: Wed, 19 Apr 2017 20:51:08 -0700
Subject: [PATCH 4/5] nvme: Adjust the Samsung APST quirk
In-Reply-To: <20170420030711.GB23085@kernel.dk>
References: <cover.1492656278.git.luto@kernel.org>
 <a3e55fbb6afca363fcae66ca7d30f1175793594b.1492656278.git.luto@kernel.org>
 <20170420030711.GB23085@kernel.dk>
Message-ID: <CALCETrU3D+foUw50yW6vcaXoNEj4hHt7JWJ9BtVKTe_gP6=gFQ@mail.gmail.com>

On Wed, Apr 19, 2017@8:07 PM, Jens Axboe <axboe@kernel.dk> wrote:
> On Wed, Apr 19 2017, Andy Lutomirski wrote:
>> I got a couple more reports: the Samsung APST issues appears to
>> affect multiple 950-series devices in Dell XPS 15 9550 and Precision
>> 5510 laptops.  Change the quirk: rather than blacklisting the
>> firmware on the first problematic SSD that was reported, disable
>> APST on all 144d:a802 devices if they're installed in the two
>> affected Dell models.  While we're at it, disable only the deepest
>> sleep state instead of all of them -- the reporters say that this is
>> sufficient to fix the problem.
>>
>> (I have a device that appears to be entirely identical to one of the
>> affected devices, but I have a different Dell laptop, so it's not
>> the case that all Samsung devices with firmware BXW75D0Q are broken
>> under all circumstances.)
>>
>> Samsung engineers have an affected system, and hopefully they'll
>> give us a better workaround some time soon.  In the mean time, this
>> should minimize regressions.
>
> Do we know for a fact that it only happens on those systems, and isn't
> purely specific to the device?

I have decent evidence.  All of the reports are from XPS 15 9550 or
Precision 5510, and Dell confirmed that they're basically the same
machine and run literally the same BIOS.  One of these reports is from
a device with exactly the same model and firmware as my SSD, and mine
is fine.  (I have a different laptop.)

>
> At this point in time, I'd be much more comfortable completely disabling
> APST on Samsung, period.
>

I'd be fine with doing that for 4.11 and then doing this for 4.12-rc1.
