From: james.smart@broadcom.com (James Smart)
Date: Mon, 19 Dec 2016 16:54:03 -0800
Subject: [PATCH] nvme-fabrics: remove some logically dead code performing
 redundant ret checks
In-Reply-To: <20161209145947.5766-1-colin.king@canonical.com>
References: <20161209145947.5766-1-colin.king@canonical.com>
Message-ID: <50aa751e-4c77-17ad-438f-5c6b9b71b02b@broadcom.com>

Looks good.

-- james

Signed-off-by: James Smart <james.smart at broadcom.com>



On 12/9/2016 6:59 AM, Colin King wrote:
> From: Colin Ian King <colin.king at canonical.com>
>
> The check to see if ret is non-zero and return this rather than count
> is redundant in two occassions.  It is redundant because prior to this
> check, the return code ret is already checked for a non-zero error
> return value and we return from the function at that point.
>
> Signed-off-by: Colin Ian King <colin.king at canonical.com>
> ---
>   drivers/nvme/target/fcloop.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index bcb8ebe..4e8e6a2 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -845,7 +845,7 @@ fcloop_create_remote_port(struct device *dev, struct device_attribute *attr,
>   	rport->lport = nport->lport;
>   	nport->rport = rport;
>   
> -	return ret ? ret : count;
> +	return count;
>   }
>   
>   
> @@ -952,7 +952,7 @@ fcloop_create_target_port(struct device *dev, struct device_attribute *attr,
>   	tport->lport = nport->lport;
>   	nport->tport = tport;
>   
> -	return ret ? ret : count;
> +	return count;
>   }
>   
>   
