From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 01 Dec 2017 09:34:17 +0100
Subject: [PATCH v2] nvme-fc: don't require user to enter host_traddr
In-Reply-To: <f9b1eb5d-df4d-08fe-90da-5548bc1b6039@broadcom.com> (James
 Smart's message of "Thu, 30 Nov 2017 08:44:56 -0800")
References: <20171130151210.8168-1-jthumshirn@suse.de>
 <f9b1eb5d-df4d-08fe-90da-5548bc1b6039@broadcom.com>
Message-ID: <mqdefoe4zjq.fsf@linux-x5ow.site>

James Smart <james.smart at broadcom.com> writes:

> On 11/30/2017 7:12 AM, Johannes Thumshirn wrote:
>> One major usability difference between NVMf RDMA and FC is resolving
>> the default host transport address in RDMA. This is perfectly doable
>> in FC as well, as we already have all possible lport <-> rport
>> combinations pre-populated so we can pick the first lport that has a
>> connection to our desired rport per default or optionally use the user
>> supplied lport if we have one.
>>
>> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
>> Cc: James Smart <james.smart at broadcom.com>
>
> This is unnecessary and can create weird configurations. It assumes
> connections are manually created.

a) connections can (and will) be maually created and for this the users
have to know the topology or connection establishment will fail b) there
is no need that the connections are manually created. Sagi did post an
RFC systemd service which calls nvme connect-all and this is what should
be done regardless if we're running on FC-NVME or NVMe over RDMA any new
transport that may come in the future. What I want is a consistent user
experience within NVMe, as I am the one that has to answer a
documentation team's inquiries on how to configure NVMf, support QA in
testing and fix end user bugs. The least thing I want ot do is tell them
"well if you use rdma you have to use the nvme-connect.service, if you
use FC you have to have some magic udev rules and auto-connect scripts,
if you use $POSSIBLE_NEW_TRANSPORT you have to yada, yada".

I don't really like that we have to manully connect either but this
behaviour was first in NVMe so we should either stick to that or convert
RDMA over to using some sort of udev magic as well (which wont work as
far as I know, and it definitively won't work with TCP if and when it's
there).

> The weirdness is: a) an admin has to
> know there are multiple paths in order to connect them and be
> intelligent on how to get the complex name strings and try to know
> what connections are already in existence;? b) if a users has a
> connectivity loss beyond dev_loss_tmo or ctlr_loss_tmo such that the
> controller is terminated, they must manually issue the connec commands
> again; and c) those un-knowledgeable users will unknowingly find that
> their multiple paths aren't connected and the system will gang up on
> the host adapter detected on the system with connectivity. All things
> unexpected and not what occurs with FC and SCSI and which will result
> in system support calls.
>
> If the system uses the FC auto-connect scripts things will be properly
> connected across all paths connected to the subsystem - automatically,
> including resume after an extended connectivity loss - and the system
> will behave just like FC does with SCSI.
>
> I see no reason to add this patch.? Please move away from manual
> configuration.

OK so the please help with moving NVMe away from manual configuration.

I'm fine with either way I just don't want to have N different ways
because it is a documentation and usability nightmare.

        Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
