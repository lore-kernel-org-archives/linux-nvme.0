From: hare@suse.de (Hannes Reinecke)
Date: Wed, 10 Apr 2019 07:52:36 +0200
Subject: [PATCHv3] nvmet: Fix discover log page when offsets are used
In-Reply-To: <20190409160359.2683-1-keith.busch@intel.com>
References: <20190409160359.2683-1-keith.busch@intel.com>
Message-ID: <1edb5bc4-22e2-8e81-a9c2-038ffd9597e4@suse.de>

On 4/9/19 6:03 PM, Keith Busch wrote:
> The nvme target hadn't been taking the Get Log Page offset parameter
> into consideration, and so has been returning corrupted log pages when
> offsets are used. Since many tools, including nvme-cli, split the log
> request to 4k, we've been breaking discovery log responses when more
> than 3 subsystems exist.
> 
> Fix the returned data by internally generating the entire discovery
> log page and copying only the requested bytes into the user buffer. The
> command log page offset type has been modified to a native __le64 to
> make it easier to extract the value from a command.
> 
> Cc: Hannes Reinecke <hare at suse.de>
> Reviewed-by: James Smart <james.smart at broadcom.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
> v2 -> v3:
> 
>    Make entry counting return the consistent type (Chaitanya)
> 
>    Comment on dword aligned offset (Chaitanya)
> 
>    Simplified obtaining the offset by using a native le64 type
>    (Christoph, Bart)
> 
>    Updated change log
> 
>   drivers/nvme/target/admin-cmd.c |  5 +++
>   drivers/nvme/target/discovery.c | 68 +++++++++++++++++++++++++++--------------
>   drivers/nvme/target/nvmet.h     |  1 +
>   include/linux/nvme.h            |  9 ++++--
>   4 files changed, 58 insertions(+), 25 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
