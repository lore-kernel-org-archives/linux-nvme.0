From: james.smart@broadcom.com (James Smart)
Date: Wed, 24 Jul 2019 16:45:19 -0700
Subject: [PATCH v2 10/10] nvme-cli: nvmf auto-connect scripts
In-Reply-To: <642f1d36-f0bc-7e5d-7c49-63238bbc058c@grimberg.me>
References: <20190719225305.11397-1-jsmart2021@gmail.com>
 <20190719225305.11397-11-jsmart2021@gmail.com>
 <4efefb70-7ab1-69af-4f41-63223e9f4ff8@grimberg.me>
 <d5b4ef61-cf1d-ce9c-1bd0-7f372f874320@broadcom.com>
 <2297e9f3-4a9d-e759-5633-aeefe736b09c@grimberg.me>
 <1215e814-30f7-85e6-a9b9-fd7d2c725654@broadcom.com>
 <642f1d36-f0bc-7e5d-7c49-63238bbc058c@grimberg.me>
Message-ID: <e8a94912-61d2-8cd5-d487-0bd4f48be69b@broadcom.com>

On 7/24/2019 11:15 AM, Sagi Grimberg wrote:
>
>>>>>> +# Events from persistent discovery controllers or nvme-fc 
>>>>>> transport events
>>>>>> +ACTION=="change", SUBSYSTEM=="nvme", ENV{NVME_EVENT}=="discovery",\
>>>>>> +? ENV{NVME_CTRL_NAME}=="*", ENV{NVME_TRTYPE}=="*", 
>>>>>> ENV{NVME_TRADDR}=="*", \
>>>>>> +? ENV{NVME_TRSVCID}=="*", ENV{NVME_HOST_TRADDR}=="*", \
>>>>>> +? RUN+="/usr/bin/systemctl --no-block start 
>>>>>> nvmf-connect at --device=$env{NVME_CTRL_NAME}\t--transport=$env{NVME_TRTYPE}\t--traddr=$env{NVME_TRADDR}\t--trsvcid=$env{NVME_TRSVCID}\t--host-traddr=$env{NVME_HOST_TRADDR}.service" 
>>>>>>
>>>>>
>>>>> James, shouldn't this be /bin/systemctl?
>>>>
>>>> I don't believe so.?? On the distros I checked, /bin/systemctl is a 
>>>> soft or hard link to /usr/bin/systemctl
>>>
>>> Not always the case. Lets change that to /bin/systemctl.
>>
>> I have no problem changing it, but am wondering what resource is 
>> giving you the reference locations. I can't find anything that 
>> actually specifies the location with some having /bin and others 
>> /usr/bin. The other files seem to lean toward a preference of /usr/bin.
>
> I'm running ubuntu and systemctl is under /bin, not a softlink.
>
> I think we should be safe on relying that systemctl is under /bin..
>
> btw, remind me, must we call with absolute path in the rules?

ok.

I really don't know. I assume, from a sysadm perspective, full name is 
better than environment-based. But, I paired most of the other scripts 
back to no path so we can probably do so here.

I'll do a repost. let me know if there's anything else besides this item 
that you want to change.

-- james
