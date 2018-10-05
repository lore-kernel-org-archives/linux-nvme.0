From: hare@suse.de (Hannes Reinecke)
Date: Fri, 5 Oct 2018 09:36:55 +0200
Subject: [PATCH rfc 0/3] add support to discovery async event notifications
In-Reply-To: <6874c24e-28ec-97da-5d31-6a9215f995e1@grimberg.me>
References: <20181004212328.30205-1-sagi@grimberg.me>
 <cbf24fc6-a6dd-dcc4-35ce-97bec248dd32@suse.de>
 <6874c24e-28ec-97da-5d31-6a9215f995e1@grimberg.me>
Message-ID: <1e8b8eae-d52b-b8d0-9d86-9e5898b0efc2@suse.de>

On 10/5/18 9:08 AM, Sagi Grimberg wrote:
> 
>>> the udev rule that ultimately achieves dynamic discovery enumeration 
>>> (TP 8002)
>>> is:
>>>
>>> SUBSYSTEM=="nvme", ACTION=="change", \
>>> ?? RUN+="/usr/sbin/nvme connect-all --device=nvme$env{NVME_INSTANCE} 
>>> --transport=$env{NVME_TRTYPE} \
>>> ?? --traddr=$env{NVME_TRADDR} --trsvcid=$env{NVME_TRSVCID} & disown
>>>
>> Not sure that'll work; IIRC udev doesn't follow the bash syntax of '&' 
>> here. Have you checked?
> 
> This works.
Oh, I don't doubt that it'll work in the sense that 'nvme connect-all' 
is executed.
I _do_ doubt that the 'disown' is doing anything at all; both '&' and 
'disown' will be used as arguments to '/usr/sbin/nvme', and _not_ 
interpreted by any shell (as no shell is invoked in the first place).
Internally udev will call 'execve' to call the new program, which will 
invoke a shell only for shell scripts; binary programs will be executed 
directly with not shell whatsoever.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
