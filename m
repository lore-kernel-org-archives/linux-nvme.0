From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Tue, 31 May 2016 20:23:36 -0300
Subject: [PATCH v3] NVMe: Add controller state for scheduling resets
In-Reply-To: <20160531230537.GI24107@localhost.localdomain>
References: <1464729927-14574-1-git-send-email-keith.busch@intel.com>
 <201605312210.u4VM8qNZ046737@mx0a-001b2d01.pphosted.com>
 <20160531222640.GH24107@localhost.localdomain>
 <201605312224.u4VMNvZS024236@mx0a-001b2d01.pphosted.com>
 <20160531230537.GI24107@localhost.localdomain>
Message-ID: <201605312323.u4VNDrlk028002@mx0a-001b2d01.pphosted.com>

On 05/31/2016 08:05 PM, Keith Busch wrote:
> On Tue, May 31, 2016@07:24:48PM -0300, Guilherme G. Piccoli wrote:
>> But imagine a scenario I have multiple nvme devices and want to upgrade the
>> firmware for only one. In this case, the procedure is to reset_controller
>> only the specific device after the fw activation.
>> modprobe the driver in this case it too much.
>
> I agree module reload would be heavy handed in your scenario, but just
> trying to establish what conditions you really need the quirk to work.

Only in reset_controller after a firmware activation. The quirk 
implementation was delaying all reset_controller calls though.


>> Now, the quirk needs 2 sec delay, not so big, but not so small value either.
>> Would be _desirable_ to have such distinguishing, although we can live
>> without it I guess.
>
> The module is typically only loaded once on boot. The driver probes all
> controllers in a background task, so it shouldn't be blocking anything
> that doesn't need to run IO to the drive. Is the added 2 seconds there
> really harming the experience?

Heheh, not that harmful.


>> But since you just sent the patch unifying the resets, I thought worth
>> asking you if it's possible to include some kind of differentiation, or if
>> such feature already exists (and I wasn't able to find heheh)
>
> You can know if the controller was initialized once before if it has an
> allocated admin tag set.

Thanks very much for the good hint, I might use this or leave the delay 
in every reset, since 2 sec is not that much.

Thanks for the the quick responses,



Guilherme
