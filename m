From: hare@suse.de (Hannes Reinecke)
Date: Tue, 2 Oct 2018 16:03:45 +0200
Subject: [PATCH rfc 1/4] nvmet: support fabrics sq flow control
In-Reply-To: <20181002001422.9111-2-sagi@grimberg.me>
References: <20181002001422.9111-1-sagi@grimberg.me>
 <20181002001422.9111-2-sagi@grimberg.me>
Message-ID: <05bbace3-a8a2-2df6-96d9-c6ef77695c35@suse.de>

On 10/2/18 2:14 AM, Sagi Grimberg wrote:
> Technical proposal 8005 "fabrics SQ flow control" introduces a mode
> where a host and controller agree to omit sq_head pointer updates
> when sending nvme completions.
> 
> In case the host indicated desire to operate in this mode (connect attribute)
> the controller will return back a connect completion with sq_head value
> of 0xffff as indication that it will omit sq_head pointer updates.
> 
> This mode saves us an atomic update in the I/O path.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/target/core.c        | 34 ++++++++++++++++++++-----------
>   drivers/nvme/target/fabrics-cmd.c |  8 +++++++-
>   drivers/nvme/target/nvmet.h       |  3 ++-
>   include/linux/nvme.h              |  4 ++++
>   4 files changed, 35 insertions(+), 14 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
