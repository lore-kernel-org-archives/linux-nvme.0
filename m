From: keith.busch@intel.com (Keith Busch)
Date: Tue, 23 Sep 2014 09:31:35 -0600 (MDT)
Subject: Question on IOStat accounting
In-Reply-To: <08f801cfd701$b1b8c850$152a58f0$@samsung.com>
References: <067e01cfd273$76dbc4e0$64934ea0$@samsung.com>
 <alpine.LRH.2.03.1409170820490.4696@AMR>
 <08f801cfd701$b1b8c850$152a58f0$@samsung.com>
Message-ID: <alpine.LRH.2.03.1409230745540.4696@AMR>

On Tue, 23 Sep 2014, Indraneel Mukherjee wrote:
> If nvme_submit_bio_queue() fails to queue the IOD, the BIO gets queued in
> the sq_cong BIO list.
> But we don't start accounting for this immediately even though the BIO is
> now queued up with the Driver.
> Any particular reason for this? Is it because it's a rare scenario we're
> talking about here?

Hi Indraneel,

This seems more-or-less consistent with request based block drivers. The
main reason you'd get bios queued on the bio_list is if you're out of
memory, and request based drivers wouldn't start accounting if it couldn't
allocate memory either; if you're out of memory, you've probably bigger
problems than iostats, so hopefully it's a rare scenario.

The other reason you'd get bio's queued is if we're splitting them,
but then that kicks the kthread to immediatly send the two parts within
a jiffie, so the accounting is probably not affected there.

>
>> On Wed, 17 Sep 2014, Indraneel Mukherjee wrote:
>>> In the current implementation of IO accounting in the nvme driver,
>>> accounting is started once IOD is successfully prepared.
>>> Thereafter 2 cases can happen, either IO gets successfully submitted
>>> to device or it can get queued up in the IOD list if there is a failure.
>>>
>>> So what's the definition of iostat here? In-flight in the device or
>>> in-flight in the driver ? Is there a need to make this consistent?
>>
>> It seems consistent with other block drivers. Usually stats are handled
>> above the device driver at the request layer, but bio-based drivers handle
>> the stats on their own.
