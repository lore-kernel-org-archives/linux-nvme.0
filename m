From: hare@suse.de (Hannes Reinecke)
Date: Fri, 3 Nov 2017 10:37:00 +0100
Subject: [PATCH] nvme_fc auto-connect scripts
In-Reply-To: <159cfcc6-40e8-9062-7341-9a3de5f177af@broadcom.com>
References: <20171009201032.2018-1-jsmart2021@gmail.com>
 <e542bb4d-946f-a080-5701-f8019fdbc752@suse.de>
 <352f980c-2422-f917-a551-99bedf27e0ab@broadcom.com>
 <f0300e47-e219-19f9-1495-a662f9062b4d@suse.de>
 <159cfcc6-40e8-9062-7341-9a3de5f177af@broadcom.com>
Message-ID: <c71cc8e0-79d3-a135-1b3c-32b081d687ff@suse.de>

On 10/28/2017 06:08 PM, James Smart wrote:
> On 10/28/2017 6:34 AM, Hannes Reinecke wrote:
>>
>> Oh, I know that.
>> What I would prefer is to have a single udev rule per nvme connection,
>> containing both lport and rport information.
>> That would relieve us of having additional configuration, and we can
>> enable/disable connection by just having that udev rule.
>> This works pretty well; we're doing it exactly the same way on S/390 for
>> the network and zfcp connections.
>> So if we have that then we only need to know when the lport/rport
>> combination is ready; once that is done we can call the udev rule.
>> Ideally we'll be getting an event containing both of these informations,
>> then udev will be selecting the correct rule automatically.
>>
>> Cheers,
>>
>> Hannes
> 
> The main reason for the systemd use was the potential duration of the
> resulting nvme connect-all. The scripts are simple if udev makes the
> nvme cli call and don't require anything other than a single generic
> rule. But given its potential stalls, very bad.
> 
> If I understand you correctly, what you describe requires apriori
> knowledge of the connections in order to add the udevs rule. This is a
> step backward from current FC behavior and what users are used to.
> 
So, here's my take for this:

# cat 65-nvme-fc-connect-nvmf-test-subsys1.rules
SUBSYSTEM!="block, GOTO="nvme_autoconnect_end"
ACTION!="add|change", GOTO="nvme_autoconnect_end"
ENV{FC_EVENT}!="nvmediscovery", GOTO="nvme_autoconnect_end"
ENV{NVMEFC_HOST_TRADDR}!="?*", GOTO="nvme_autoconnect_end"
ENV{NVMEFC_TRADDR}!="?*", GOTO="nvme_autoconnect_end"
RUN+="/usr/sbin/nvme connect -t fc \
--host-traddr=$env{NVMEFC_HOST_TRADDR} \
-n nvmf-test-subsys1 -a $env{NVMEFC_TRADDR}"
LABEL="nvme_autoconnect_end"

Obviously, we would need to filter for the appropriate values of traddr
and host_traddr to not attempt connections to non-existing namespaces.

However, I do see the problem of nvme connect stalls; if we were having
a systemd service we would solve this issue nicely, indeed.
But then we shouldn't activate the service, it should rather be
activated per default, but depend on a specifice NVMe-FC _target_, which
should be presented by the discovery event.

Let's see what I can cobble together here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
