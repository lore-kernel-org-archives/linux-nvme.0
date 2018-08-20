From: james.smart@broadcom.com (James Smart)
Date: Mon, 20 Aug 2018 09:23:20 -0700
Subject: [PATCH 2/2] nvme-connect: parse 'nvme_info' sysfs attribute for
 fc transport
In-Reply-To: <20180820103407.92783-3-hare@suse.de>
References: <20180820103407.92783-1-hare@suse.de>
 <20180820103407.92783-3-hare@suse.de>
Message-ID: <3868e631-add5-bbe3-6e11-ebb687fb1e4a@broadcom.com>

On 8/20/2018 3:34 AM, Hannes Reinecke wrote:
> The 'nvme_info' sysfs attribute for the SCSI host already contains
> all relevant information to issue a NVMe discovery. So for those
> cases we could use that information to format a discovery command
> and don't have to specify a discovery.conf file.
>
> This patch adds the infrastructure for parsing the information in
> the 'nvme_info' sysfs attribute and uses that information to attempt
> to connect to the discovery controller on that transport address.
>
> The user can select this feature by using 'nvme discover -t fc'.
>
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>   Documentation/nvme-discover.txt |   5 ++
>   fabrics.c                       | 193 +++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 197 insertions(+), 1 deletion(-)

Well....?? I know it probably works well, but it was not in the 
direction I was going.

Here's my issues:
1. the nvme_info sysfs parameter is not part of any transport and is a 
lpfc-specific attribute. So adding this into nvmecli concerns me. I 
don't know that lpfc has even considered the text format sufficient for 
being an "api" that can be called by "nvmecli" - meaning I don't know 
that it will pass the backward-compatibility tests.
2. What you are looking for is unnecessary: The patch to repost 
connectivity events has been post. Christoph just needs to review it 
again. I'll repost.
3. I also don't like parsing scsi stuff in the nvme cli. If we really 
need to pull fc-isms from it, then we should start the work for moving 
the fc transport out of scsi and into it's own layer that binds with 
scsi and nvme.? But I'd rather finish the fixes in nvme cli to address 
async connections, retries while controller being reconnected to, etc - 
that all enable the simple udev script.

-- james
