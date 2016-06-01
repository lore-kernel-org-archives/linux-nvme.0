From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Wed, 1 Jun 2016 10:29:16 -0300
Subject: [PATCH v3] NVMe: Add controller state for scheduling resets
In-Reply-To: <20160601080349.GA20479@infradead.org>
References: <1464729927-14574-1-git-send-email-keith.busch@intel.com>
 <201605312210.u4VM8qNZ046737@mx0a-001b2d01.pphosted.com>
 <20160531222640.GH24107@localhost.localdomain>
 <201605312224.u4VMNvZS024236@mx0a-001b2d01.pphosted.com>
 <20160531230537.GI24107@localhost.localdomain>
 <201605312323.u4VNDrlk028002@mx0a-001b2d01.pphosted.com>
 <20160601080349.GA20479@infradead.org>
Message-ID: <201606011329.u51DTEWH005230@mx0a-001b2d01.pphosted.com>

On 06/01/2016 05:03 AM, Christoph Hellwig wrote:
> On Tue, May 31, 2016@08:23:36PM -0300, Guilherme G. Piccoli wrote:
>> On 05/31/2016 08:05 PM, Keith Busch wrote:
>>> On Tue, May 31, 2016@07:24:48PM -0300, Guilherme G. Piccoli wrote:
>>>> But imagine a scenario I have multiple nvme devices and want to upgrade the
>>>> firmware for only one. In this case, the procedure is to reset_controller
>>>> only the specific device after the fw activation.
>>>> modprobe the driver in this case it too much.
>>>
>>> I agree module reload would be heavy handed in your scenario, but just
>>> trying to establish what conditions you really need the quirk to work.
>>
>> Only in reset_controller after a firmware activation. The quirk
>> implementation was delaying all reset_controller calls though.
>
> Only doing it after the firmware activation would be nice, but the
> only way to detect this reliably would be to check for the firmware
> activation command in the passthrough path.  And that really seems to
> be a bit too ugly.

Exactly! It would be too far, we might need a global or change multiple 
functions parameters...so I gave up the idea heheh

>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>
