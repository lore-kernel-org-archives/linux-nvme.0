From: learner.study@gmail.com (Learner Study)
Date: Mon, 21 Apr 2014 20:34:07 -0700
Subject: [PATCH 2/2] NVMe: Implement PCI-e reset notification callback
In-Reply-To: <1E05E2AB-198E-473A-8AA5-87DA2E9910B8@gmail.com>
References: <1397000541-1085-1-git-send-email-keith.busch@intel.com>
 <1397000541-1085-2-git-send-email-keith.busch@intel.com>
 <CAP8+hKWcybw5u_m5M4c1p4eUAaTq4x+kO+tnegwD2ciDMEFNCw@mail.gmail.com>
 <alpine.LRH.2.03.1404211935510.5490@AMR>
 <1E05E2AB-198E-473A-8AA5-87DA2E9910B8@gmail.com>
Message-ID: <CAP8+hKUEygoeEv=LvY2ccp6cepnXEpi4WGVSaCnRw+zN7BUE_Q@mail.gmail.com>

Per the spec, "When an NVM Subsystem Reset occurs, the entire NVM
subsystem is reset"....so all VFs would get impacted, if a VF does a
Reset. So, I think Reset kind of control should be in PF mode only.

On Mon, Apr 21, 2014@7:45 PM, Learner <learner.study@gmail.com> wrote:
> But Won't resetting from a VF impact functionality of other VFs?
>
> On Apr 21, 2014,@6:57 PM, Keith Busch <keith.busch@intel.com> wrote:
>
>> On Mon, 21 Apr 2014, Learner Study wrote:
>>> Hi Keith,
>>>
>>> I think NVMe Reset should apply to PF mode driver only, and not to VF
>>> mode driver.
>>> Is that understanding correct? Does the NVMe driver know which mode
>>> its running in?
>>
>> Oh, this driver doesn't enable SR-IOV and has no PF/VF awareness. Shame
>> on us, I'll add it to my list unless someone beats me to it.
>>
>> Still, I think we'd like to be able to reset a VF if only because it
>> gets the queues back to a pristine state. A VF reset should not affect
>> any of the other functions.
