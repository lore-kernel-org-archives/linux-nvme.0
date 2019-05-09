From: hare@suse.de (Hannes Reinecke)
Date: Thu, 9 May 2019 17:40:21 +0200
Subject: [PATCH nvme-cli rfc 5/5] nvmf auto-connect scripts
In-Reply-To: <fd4af817-3a90-380b-b485-81b44c12c8e9@broadcom.com>
References: <20190504000456.3888-1-jsmart2021@gmail.com>
 <20190504000456.3888-6-jsmart2021@gmail.com>
 <fd4af817-3a90-380b-b485-81b44c12c8e9@broadcom.com>
Message-ID: <6f54cdf9-bd99-8cd4-1981-a9db4970c1be@suse.de>

On 5/7/19 10:26 PM, James Smart wrote:
> 
>> +# Events from persistent discovery controllers or nvme-fc transport 
>> events
>> +ACTION=="change", SUBSYSTEM=="nvme", ENV{NVME_EVENT}=="discovery",\
>> +? ENV{NVME_CTLR_NAME}=="*", ENV{NVME_TRTYPE}=="*", 
>> ENV{NVME_TRADDR}=="*", \
>> +? ENV{NVME_TRSVCID}=="*", ENV{NVME_HOST_TRADDR}=="*", \
>> +? RUN+="/usr/bin/systemctl --no-block start 
>> nvmf-connect at --device=$env{NVME_CTLR_NAME}\t--transport=$env{NVME_TRTYPE}\t--traddr=$env{NVME_TRADDR}\t--trsvcid=$env{NVME_TRSVCID}\t--host-traddr=$env{NVME_HOST_TRADDR}.service" 
>>
>> +
>> +# nvme-fc transport generated events (old-style for compatibility)
>> +ACTION=="change", SUBSYSTEM=="fc", ENV{FC_EVENT}=="nvmediscovery", \
>> +? ENV{NVMEFC_HOST_TRADDR}=="*",? ENV{NVMEFC_TRADDR}=="*", \
>> +? RUN+="/usr/bin/systemctl --no-block start 
>> nvmf-connect at --device=none\t--transport=fc\t--traddr=$env{NVMEFC_TRADDR}\t--trsvcid=none\t--host-traddr=$env{NVMEFC_HOST_TRADDR}.service" 
>>
>>
> 
> I assume, that we should be adding --quiet to the above lines.? No need 
> to get it from the event.? Agree ?
> 
> And we would not add --persistent.?? Which makes me assume --persistent 
> would be left to manual/scripted calls or possibly pulled in by the se
> "defaults" file we were discussing.??? So, the linux policy is our 
> default discovery controller is non-persistent and requires admin 
> actions to enable the persistent option - as opposed to - looking at 
> IdentifyController:KAS to decide if KATO is supported, and if so, make 
> the connection persistent ?
> 
Didn't we discuss this in another thread?
My preferred workflow would be to create the persistent discovery 
connection during startup (by eg a system service or what have you),
and have the uevent using that connection.
Consequently, I would fill in a real device name with the --device 
option above.

Yes, this would be open to race conditions (ie someone might go ahead 
and re-create the device with a different connection before the event is 
processed), but you didn't like my argument to skip the --device call 
and have nvme-cli match on existing discovery connections ... and if we 
don't check for the connection in nvme-cli we'll always have that.

And it feels really stupid, to have a persistent discovery connection 
_just_ for AENs, and then have nvme-cli create _another_ connection when 
processing the event.
That really is a waste of resources.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare at suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
