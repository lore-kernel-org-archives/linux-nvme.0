From: hare@suse.de (Hannes Reinecke)
Date: Fri, 19 Jul 2019 09:27:16 +0200
Subject: [PATCH 10/10] nvme-cli: nvmf auto-connect scripts
In-Reply-To: <3a2ddff8-d900-1eee-2179-43539fcc1383@gmail.com>
References: <20190716211241.7650-1-jsmart2021@gmail.com>
 <20190716211241.7650-11-jsmart2021@gmail.com>
 <2bd2a068-dbbd-84e8-250e-d9d4afa640d3@suse.de>
 <5669f502-e931-d0ed-71f7-91d3fca01816@grimberg.me>
 <3a2ddff8-d900-1eee-2179-43539fcc1383@gmail.com>
Message-ID: <75bb5303-08a8-d96a-aa4d-0c52780fb25e@suse.de>

On 7/19/19 3:20 AM, James Smart wrote:
> On 7/18/2019 5:33 PM, Sagi Grimberg wrote:
>>
>>> The install sequence is slightly odd, but not enough to complain.
>>
>> Whats odd the udevadm vs. systemctl?
>>
>>> (udevadm trigger before systemd daemon-reload? I'd rather do it the
>>> other way round. Anyway.)
>>
>> Why? just out of curiosity?
> 
> I assume it's - if you load udev first, it can trigger systemd services
> that don't exit yet. Thus cleaner to have systemd setup then udev
> enabled to call it.
> 
Precisely.
Either udevadm trigger will already bring up the namespaces, but then
the call to systemctl is pointless.
Or the call to systemctl is required, but then the udevadm trigger will
draw a blank.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
