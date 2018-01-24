From: luto@kernel.org (Andy Lutomirski)
Date: Wed, 24 Jan 2018 09:00:16 -0800
Subject: [Intel-gfx] REGRESSION in c5552fde102f ("nvme: Enable autonomous
 power state transitions")
In-Reply-To: <20180124133533.GQ5453@intel.com>
References: <87shaveb5b.fsf@intel.com> <20180124133533.GQ5453@intel.com>
Message-ID: <CALCETrXQ7Nb1Th_Grdj+VXxkF+veHXP1jKu8DYqw9djXzYn4Zw@mail.gmail.com>

On Wed, Jan 24, 2018 at 5:35 AM, Ville Syrj?l?
<ville.syrjala@linux.intel.com> wrote:
> On Wed, Jan 24, 2018@01:42:08PM +0200, Jani Nikula wrote:
>>
>> Hi Andy, all -
>>
>> So this is an odd one.
>>
>> I'm getting display FIFO underruns in a very specific setting: Laptop
>> display switched off, and an external display connected. Other
>> combinations work fine.
>>
>> I've bisected this to c5552fde102f ("nvme: Enable autonomous power state
>> transitions"), and, being baffled by the result, carefully checked
>> this. There are no problems when running c5552fde102f^, with
>> nvme_core.default_ps_max_latency_us=0, or after 'echo 0 >
>> pm_qos_latency_tolerance_us'. With the last one, restoring the original
>> value of 100000 brings the underruns back.
>>
>> I have no idea what the root cause mechanism here is, but the bisect is
>> correct. Perhaps something to do with timing. I'd be happy to provide
>> further details.
>>
>> I see that you have quirked one Samsung device. Incidentally, this
>> Lenovo Yoga 910 (Kabylake, SunrisePoint LP PCH) also has a Samsung NVMe
>> device, just a different one. Details below. I don't know what the
>> failure mode in the quirked one is, so I don't know if this could be the
>> same issue.
>
> My first gut feeling would be that by allowing the nvme to go to sleep
> we're gettting into some deeper power saving state, which then causes
> display underruns. How does the package c-state residency look
> before/after the commit?

I know approximately nothing about how package C-states works and what
exactly triggers APSM low-power state entry, but I've seen reports
that APST is required to get ASPM L1 and that ASPM L1 is needed to get
to the deep PC states.  And deep PC states can surely trigger i915
issues...

--Andy
