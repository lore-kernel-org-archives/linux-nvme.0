From: hare@suse.de (Hannes Reinecke)
Date: Wed, 24 Jan 2018 09:26:28 +0100
Subject: [LSF/MM TOPIC] NVMe over Fabrics auto-discovery in Linux
In-Reply-To: <464f1939-e3e6-95bc-f3d4-fcb83dfbf075@wdc.com>
References: <20180123151132.wrbc7dcjjhpzcnba@linux-x5ow.site>
 <464f1939-e3e6-95bc-f3d4-fcb83dfbf075@wdc.com>
Message-ID: <860c9d4a-af17-e0d3-5ef1-3224821cda86@suse.de>

On 01/23/2018 05:09 PM, Bart Van Assche wrote:
> 
> 
> On 01/23/18 07:11, Johannes Thumshirn wrote:
>> In NVMe over Fabrics we currently perform target discovery by running
>> either
>> one of 'nvme discover' or 'nvme connect-all' (with or without the use
>> of an
>> appropriate /etc/nvme/discovery.conf).
>>
>> This is well suited for the RDMA transport, which has no idea of the
>> underlying fabric and it's connections. To automatically connect to an
>> RDMA
>> target Sagi proposed a systemd one-shot service in [1].
>>
>> The Fibre Channel transport on the other hand does already know it's
>> mapping
>> of rports to lports and thus could automatically connect to the target
>> (with a
>> little help from udev) as shown in [2].
>>
>> Unfortunately the method for FC is not possible with RDMA and the
>> currently
>> used 'nvme discover/connect/connect-all' method is extremely
>> cumbersome with
>> Fibre Channel, especially as no special setup was/is needed for SCSI
>> devices
>> over Fibre Channel and administrators thus expect it for NVMe as well.
>>
>> Other downside of the "RDMA version" are 1) once the network topology
>> and thus
>> /etc/nvme/discovery.conf changes one has to rebuild the initrd if nvme
>> is to
>> be started from the initrd and 2) if we use the one-shot systemd
>> service there
>> is no way to automatically re-try the discovery/connect.
>>
>> I'm hoping we have developers from the RDMA and Fibre Channel
>> transports, as
>> well as seasoned Storage developers with a SCSI Fibre Channel and RDMA
>> knowledge and Distribution Maintainers around to discuss a way to
>> address this
>> problem is a user-friendly way.
>>
>> Byte,
>> ????Johannes
>>
>> [1]
>> http://lists.infradead.org/pipermail/linux-nvme/2017-September/012976.html
>>
>> [2]
>> http://lists.infradead.org/pipermail/linux-nvme/2017-December/014324.html
> 
> Hello Johannes,
> 
> Can you have a look at the SSDP and SLP protocols and see whether one of
> these protocols or an alternative is appropriate? See also
> https://en.wikipedia.org/wiki/Simple_Service_Discovery_Protocol and
> https://en.wikipedia.org/wiki/Service_Location_Protocol.
> 
Partially beside the point.

The problem currently is that FC-NVMe is the only transport which
implements dev_loss_tmo, causing connections to be dropped completely
after a certain time.
After that the user has to manually re-establish the connection via
nvme-cli, or one has to create some udev/systemd interaction (cf the
thread "nvme/fc: add 'discovery' sysfs attribute to fc transport
devices" and others).

The other transports just keep the reconnection loop running, and the
user has to manually _disconnect_ here.

So we have a difference in user experience, which should be reconciled.

Also, a user-space based rediscovery/reconnect will get tricky during
path failover, as one might end up with all connections down and no way
of ever being _able_ to call nvme-cli as the root fs in inaccessible.
But that might be another topic.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
