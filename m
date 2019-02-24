From: hare@suse.de (Hannes Reinecke)
Date: Sun, 24 Feb 2019 18:17:01 +0100
Subject: [PATCH nvme-cli rfc 0/6] Support discovery log change events
In-Reply-To: <20190223023257.21227-1-sagi@grimberg.me>
References: <20190223023257.21227-1-sagi@grimberg.me>
Message-ID: <d4012891-8bc7-00cf-ab96-7828270d25af@suse.de>

On 2/23/19 3:32 AM, Sagi Grimberg wrote:
> This series corresponds to the nvme-core discovery uevent notification
> for discovery log changes.
> 
> The motivation is that whenever we get a discovery log change event from
> a discovery controller, we want to query the discovery log page again
> and connect to the new controllers in the fabric.
> 
> To support this we have a couple of steps:
> 1. establish a "persistent" discovery controller
> 2. allow discovery over an existing "persisent" discovery controller device
>     node
> 3. allow users to pass "none" to nvme-cli for arguments that they don't
>     care about (this will be useful when we have udev rule that catches events
>     and simply feed them to nvme-cli without checking any parameters or building
>     a commandline arg string).
> 4. add udev+systemd scripting to make this all automatic.
> 
> Review and feedback is welcome.
> 
> Hannes Reinecke (1):
>    fc: add autoconnect systemd service and udev rule for fc discovery log
>      changes
> 
> Sagi Grimberg (5):
>    fabrics: ignore arguments that pass in "none"
>    fabrics: support persistent connections to a discovery controller
>    fabrics: allow user to retrieve discovery log from existing discovery
>      controller
>    fabrics: add --quiet option
>    fabrics: systemd and udev support for automatic discovery log changes
> 
>   Makefile                                | 10 +++-
>   fabrics.c                               | 62 ++++++++++++++++++-------
>   fabrics.h                               |  2 +
>   nvme.spec.in                            |  7 +++
>   systemd/nvmefc-boot-connections.service |  9 aw++++
>   systemd/nvmf-connect at .service           | 15 ++++++
>   udev/70-nvmf-autoconnect.rules          | 11 +++++
>   7 files changed, 98 insertions(+), 18 deletions(-)
>   create mode 100644 systemd/nvmefc-boot-connections.service
>   create mode 100644 systemd/nvmf-connect at .service
>   create mode 100644 udev/70-nvmf-autoconnect.rules
> 
Hmm.

Last time I've posted the autoconnect scripts you said you'd rather have 
them updated to be useful for generic discovery events.
So what happened to that?
As it stands (and as posted here) these scripts are pretty much 
independent on the remaining series as they react to the existent FC 
NVMe uevents.

And the one thing which I patently dislike about those scripts is this 
utterly weird interface.
Problem here is that abstract systemd services (ie those ending with an 
'@' sign) can pass exactly _one_ argument, namely that one following the 
'@' sign.
But for nvme we need to pass in several arguments, one for each 
command-line parameter.

The way it's solved nowadays is to insert a 'tab' character (\t) between 
each argument, use the combined string as parameter to the systemd 
service, and call 'echo' to split the parameters again.
Shudder.

What I really want to do here is to add a '--dry-run' option to 
nvme-cli, which then would instruct nvme-cli to _not_ write the final 
string to the ioctl interface but rather to stdout.
This string will not contain any spaces, and have each argument (minus 
any leading dashes) concatenated by commas.
So it should be possible to use this string as argument for the systemd 
service.
Then we only need to complementary call --argstr to accept this string 
for nvme-cli, re-parse it into the internal structure, and continue with 
the operation.

I do have some patches, but still need to polish them off (and possibly 
test them :-) before sending.

Cheers,

Hannes
