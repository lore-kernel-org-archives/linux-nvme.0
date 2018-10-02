From: hare@suse.de (Hannes Reinecke)
Date: Tue, 2 Oct 2018 16:04:10 +0200
Subject: [PATCH rfc 2/4] nvmet: don't override treq upon modification.
In-Reply-To: <20181002001422.9111-3-sagi@grimberg.me>
References: <20181002001422.9111-1-sagi@grimberg.me>
 <20181002001422.9111-3-sagi@grimberg.me>
Message-ID: <0340252a-3900-1349-90e3-f209df420848@suse.de>

On 10/2/18 2:14 AM, Sagi Grimberg wrote:
> Only override the allowed parts of it.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/target/configfs.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
