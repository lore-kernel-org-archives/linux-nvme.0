From: hare@suse.de (Hannes Reinecke)
Date: Tue, 22 May 2018 13:05:39 +0200
Subject: [PATCHv2 11/11] nvmet: ANA support
In-Reply-To: <20180522100552.GC11894@lst.de>
References: <20180522091004.39620-1-hare@suse.de>
 <20180522091004.39620-12-hare@suse.de> <20180522100552.GC11894@lst.de>
Message-ID: <c7e3cbcc-e372-8162-0d84-1fced2ccc3c2@suse.de>

On 05/22/2018 12:05 PM, Christoph Hellwig wrote:
> On Tue, May 22, 2018@11:10:04AM +0200, Hannes Reinecke wrote:
>> Add ANA support to the nvme target. The ANA configuration is optional, and
>> doesn't interfere with existing configurations.
>> ANA groups are created under each subsystem, the namespaces must to be linked
>> into this group to become part of the ANA group.
>> If ANA groups are created it is required to link the ANA groups into the
>> respective ports. Each ANA group can only be part of one port.
>> Linking the entire subsystem will be refused is ANA groups are specified.
>> Also this implementation has a limit of one single ANA state per group,
>> irrespective of the path. So when different ANA states are required one needs
>>   to create different ANA groups, one for each state.
>>
>> Signed-off-by: Hannes Reinecke <hare at suse.com>
>> ---
>>   drivers/nvme/target/admin-cmd.c | 156 +++++++++++++++-
>>   drivers/nvme/target/configfs.c  | 381 ++++++++++++++++++++++++++++++++++++++++
>>   drivers/nvme/target/core.c      |  94 +++++++++-
>>   drivers/nvme/target/discovery.c |  49 ++++--
>>   drivers/nvme/target/io-cmd.c    |  36 ++++
>>   drivers/nvme/target/nvmet.h     |  50 ++++++
>>   6 files changed, 747 insertions(+), 19 deletions(-)
> 
> What is the advantage over my implementation, which is a lot simpler?
> 
> Especially the configuration here seems extremely complex for no real
> gain.
> 
Primarily this is designed to be a testbed for the various ANA 
configurations. Plus ANA support can be disabled, too :-)
So with this we can do all sorts of compability testing like running
against various revisions, and we can to scalability tests etc.

_And_ you can have a simple ANA configuration with enabling

echo 1 > allow_any_ns

then you only need to link the ANA groups into the ports.
I don't really think it's _that_ complicated.

Cheers,

Hannes
