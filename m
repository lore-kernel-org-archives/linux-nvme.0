From: james.smart@broadcom.com (James Smart)
Date: Thu, 15 Aug 2019 14:17:14 -0700
Subject: [PATCH v6 7/7] nvme: fix ns removal hang when failing to
 revalidate due to a transient error
In-Reply-To: <20190813064304.7344-8-sagi@grimberg.me>
References: <20190813064304.7344-1-sagi@grimberg.me>
 <20190813064304.7344-8-sagi@grimberg.me>
Message-ID: <a60abc02-d4d3-3803-f198-33c7047454e5@broadcom.com>



On 8/12/2019 11:43 PM, Sagi Grimberg wrote:
> If a controller reset is racing with a namespace revalidation, the
> revalidation (admin) I/O will surely fail, but we should not remove the
> namespace as we will execute the I/O when the controller is back up.
> Same for spurious allocation errors (return -ENOMEM).
>
> Fix this by checking the specific error code that revalidate_disk
> returns, and if it is a transient error (for example ENOLINK correlates
> to BLK_STS_TRANSPORT or ENOMEM correlates to BLK_STS_RESOURCE or an
> allocation failure), do not remove the namespace as it will either
> recover when the controller is back up and schedule a subsequent scan,
> or the controller is going away and the namespaces will be removed anyways.
>
> This fixes a hang namespace scanning racing with a controller reset and
> also sporious I/O errors in path failover coditions where the
> controller reset is racing with the namespace scan work with multipath
> enabled.
>
> Reported-by: Hannes Reinecke  <hare at suse.de>
> Reviewed-by: Hannes Reinecke <hare at suse.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>

This looks fine:??? Reviewed-by: James Smart <james.smart at broadcom.com>

Q: do we need to do something about nvme_update_formats() which does a 
nvme_set_queue_dying() if nvme_revalidate_disk() fails ?? It's not 
removal, but....

-- james
