From: luto@amacapital.net (Andy Lutomirski)
Date: Thu, 27 Oct 2016 17:06:16 -0700
Subject: [PATCH v4 0/3] nvme power saving
In-Reply-To: <CALCETrUgU6Od9iKr87GMs7ZOd-xb5GL7GR-EH4DEo22uzKuPSA@mail.gmail.com>
References: <cover.1474049701.git.luto@kernel.org>
 <13b0fe95-01b8-89d7-df76-efc1aa14b27a@fb.com>
 <CALCETrV6GAZFG+cjdQrJpP7wVphfeRd=+UeTQcs5-iQYxNk6XA@mail.gmail.com>
 <0a2ffd51-6e0f-7db3-8135-84317d8f77bc@fb.com>
 <1474580016.15303.31.camel@linux.intel.com>
 <CALCETrUgU6Od9iKr87GMs7ZOd-xb5GL7GR-EH4DEo22uzKuPSA@mail.gmail.com>
Message-ID: <CALCETrVuAfpavqkyfKeqBtcCyZuThNxvOorcvmEzwTxyDrzEpg@mail.gmail.com>

On Thu, Sep 22, 2016@3:15 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> On Thu, Sep 22, 2016 at 2:33 PM, J Freyensee
> <james_p_freyensee@linux.intel.com> wrote:
>> On Thu, 2016-09-22@14:43 -0600, Jens Axboe wrote:
>>> On 09/22/2016 02:11 PM, Andy Lutomirski wrote:
>>> >
>>> > On Thu, Sep 22, 2016@7:23 AM, Jens Axboe <axboe@fb.com> wrote:
>>> > >
>>> > >
>>> > > On 09/16/2016 12:16 PM, Andy Lutomirski wrote:
>>> > > >
>>> > > >
>>> > > > Hi all-
>>> > > >
>>> > > > Here's v4 of the APST patch set.  The biggest bikesheddable
>>> > > > thing (I
>>> > > > think) is the scaling factor.  I currently have it hardcoded so
>>> > > > that
>>> > > > we wait 50x the total latency before entering a power saving
>>> > > > state.
>>> > > > On my Samsung 950, this means we enter state 3 (70mW, 0.5ms
>>> > > > entry
>>> > > > latency, 5ms exit latency) after 275ms and state 4 (5mW, 2ms
>>> > > > entry
>>> > > > latency, 22ms exit latency) after 1200ms.  I have the default
>>> > > > max
>>> > > > latency set to 25ms.
>>> > > >
>>> > > > FWIW, in practice, the latency this introduces seems to be well
>>> > > > under 22ms, but my benchmark is a bit silly and I might have
>>> > > > measured it wrong.  I certainly haven't observed a slowdown
>>> > > > just
>>> > > > using my laptop.
>>> > > >
>>> > > > This time around, I changed the names of parameters after Jay
>>> > > > Frayensee got confused by the first try.  Now they are:
>>> > > >
>>> > > >  - ps_max_latency_us in sysfs: actually controls it.
>>> > > >  - nvme_core.default_ps_max_latency_us: sets the default.
>>> > > >
>>> > > > Yeah, they're mouthfuls, but they should be clearer now.
>>> > >
>>> > >
>>> > > The only thing I don't like about this is the fact that's it's a
>>> > > driver private thing. Similar to ALPM on SATA, it's yet another
>>> > > knob that needs to be set. It we put it somewhere generic, then
>>> > > at least we could potentially use it in a generic fashion.
>>> >
>>> > Agreed.  I'm hoping to hear back from Rafael soon about the
>>> > dev_pm_qos
>>> > thing.
>>> >
>>> > >
>>> > >
>>> > > Additionally, it should not be on by default.
>>> >
>>> > I think I disagree with this.  Since we don't have anything like
>>> > laptop-mode AFAIK, I think we do want it on by default.  For the
>>> > server workloads that want to consume more idle power for faster
>>> > response when idle, I think the servers should be willing to make
>>> > this
>>> > change, just like they need to disable overly deep C states, etc.
>>> > (Admittedly, unifying the configuration would be nice.)
>>>
>>> I can see two reasons why we don't want it the default:
>>>
>>> 1) Changes like this has a tendency to cause issues on various types
>>> of
>>> hardware. How many NVMe devices have you tested this on? ALPM on SATA
>>> had a lot of initial problems, where slowed down some SSDs unberably.
>
> I'm reasonably optimistic that the NVMe situation will be a lot better
> for a couple of reasons:
>
> 1. There's only one player involved.  With ALPM, the controller and
> the drive need to cooperate on entering and leaving various idle
> states.  With NVMe, the controller *is* the drive, so there's no issue
> where a drive manufacturer might not have tested with the relevant
> controller or vice versa.
>
> 2. Windows appears to use it.  I haven't tested directly, but the
> Internet seems to think that Windows uses APST and maybe even manual
> state transitions, and that NVMe power states are even mandatory for
> Connected Standby logo compliance.
>
> 3. The feature is new.  NVMe 1.0 didn't support APST at all, so the
> driver is unlikely to cause problems with older drivers.
>
>>
>> ...and some SSDs don't even support this feature yet, so the number of
>> different NVMe devices available to test initially will most likely be
>> small (like the Fultondales I have, all I could check is to see if the
>> code broke anything if the device did not have this power-save
>> feature).
>>
>> I agree with Jens, makes a lot of sense to start with this feature
>> 'off'.
>>
>> To 'advertise' the feature, maybe make the feature a new selection in
>> Kconfig?  Example, initially make it "EXPERIMENTAL", and later when
>> more devices implement this feature it can be integrated more tightly
>> into the NVMe solution and default to on.
>>
>
> How about having a config option that's "default n" that changes the
> default?  I could also add a log message when APST is first enabled on
> a device to make it easier to notice a change.
>

It looks like there is at least one NVMe disk in existence (a
different Samsung device) that sporadically dies when APST is on.
This device appears to also sporadically die when APST is off, but it
lasts considerably longer before dying with APST off.

So here's what I'm tempted to do:

 - For devices that report NVMe version 1.2 support, APST is on by
default.  I hope this is safe.

 - For devices that don't report NVMe 1.2 or higher but do report
APSTA (which implies NVMe 1.1), then we can have a blacklist or a
whitelist.  A blacklist is nicer, but a whitelist is safer.

 - A sysfs and/or module control allows overriding this.

 - Implement dev_pm_qos latency control.  The chosen latency (if APST
is enabled) will be the lesser of the dev_pm_qos setting and a module
parameter.

How does that sound?
