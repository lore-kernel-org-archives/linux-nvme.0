From: judy.brock@samsung.com (Judy Brock)
Date: Thu, 20 Apr 2017 04:33:34 +0000
Subject: [PATCH 4/5] nvme: Adjust the Samsung APST quirk
In-Reply-To: <CALCETrU3D+foUw50yW6vcaXoNEj4hHt7JWJ9BtVKTe_gP6=gFQ@mail.gmail.com>
References: <cover.1492656278.git.luto@kernel.org>
 <a3e55fbb6afca363fcae66ca7d30f1175793594b.1492656278.git.luto@kernel.org>
 <20170420030711.GB23085@kernel.dk>
 <CALCETrU3D+foUw50yW6vcaXoNEj4hHt7JWJ9BtVKTe_gP6=gFQ@mail.gmail.com>
 <CGME20170420043337uscas1p1614437f255a643cdb08e44c4fd43424f@uscas1p1.samsung.com>
Message-ID: <36E8D38D6B771A4BBDB1C0D800158A51879547C5@SSIEXCH-MB3.ssi.samsung.com>

[Jens] Do we know for a fact that it only happens on those systems, and isn't 
> purely specific to the device?

[Andy] I have decent evidence.  All of the reports are from XPS 15 9550 or Precision 5510, and Dell confirmed that they're basically the same machine and run literally the same BIOS.

The answer as per the above as far as we know is "yes".
>
> At this point in time, I'd be much more comfortable completely 
> disabling APST on Samsung, period.
>

1) Why? The answer to the question above was "Yes". This has been reported exclusively on the two Dell models with that exact same BIOS. Additionally, there are reports of the device acting fine on other systems so it is not purely specific to the device.

We request that the quirk should be only on the affected Dell machines - there is no reason to completely disable APST on Samsung.

2) Samsung shared in the more private thread that we are seeing excessive recovery attempts on the PCIe bus - no PCIe TLPs seen, just ordered sets.  This looks like a signal integrity problem to us on the Dell side. We shared excerpt of PCIe trace on the offline thread.

3) We also shared a more extensive report with Dell today. We've asked them to look into it. 

4) There was at least one report of same symptom on a Toshiba device and Lenovo system that seemed to also disappear by avoiding PS4. So it seems it would be best to continue to try to get to the bottom of the problem (root cause) and quirk judiciously in the meantime.

Thanks,
Judy



-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Andy Lutomirski
Sent: Wednesday, April 19, 2017 8:51 PM
To: Jens Axboe
Cc: Sagi Grimberg; linux-kernel at vger.kernel.org; linux-nvme; Keith Busch; Kai-Heng Feng; Andy Lutomirski; Christoph Hellwig; Niranjan Sivakumar
Subject: Re: [PATCH 4/5] nvme: Adjust the Samsung APST quirk

On Wed, Apr 19, 2017@8:07 PM, Jens Axboe <axboe@kernel.dk> wrote:
> On Wed, Apr 19 2017, Andy Lutomirski wrote:
>> I got a couple more reports: the Samsung APST issues appears to 
>> affect multiple 950-series devices in Dell XPS 15 9550 and Precision
>> 5510 laptops.  Change the quirk: rather than blacklisting the 
>> firmware on the first problematic SSD that was reported, disable APST 
>> on all 144d:a802 devices if they're installed in the two affected 
>> Dell models.  While we're at it, disable only the deepest sleep state 
>> instead of all of them -- the reporters say that this is sufficient 
>> to fix the problem.
>>
>> (I have a device that appears to be entirely identical to one of the 
>> affected devices, but I have a different Dell laptop, so it's not the 
>> case that all Samsung devices with firmware BXW75D0Q are broken under 
>> all circumstances.)
>>
>> Samsung engineers have an affected system, and hopefully they'll give 
>> us a better workaround some time soon.  In the mean time, this should 
>> minimize regressions.
>
> Do we know for a fact that it only happens on those systems, and isn't 
> purely specific to the device?

I have decent evidence.  All of the reports are from XPS 15 9550 or Precision 5510, and Dell confirmed that they're basically the same machine and run literally the same BIOS.  One of these reports is from a device with exactly the same model and firmware as my SSD, and mine is fine.  (I have a different laptop.)

>
> At this point in time, I'd be much more comfortable completely 
> disabling APST on Samsung, period.
>

I'd be fine with doing that for 4.11 and then doing this for 4.12-rc1.

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
