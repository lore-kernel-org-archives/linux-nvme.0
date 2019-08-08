From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 8 Aug 2019 16:47:38 -0700
Subject: [PATCH v4 7/7] nvme: fix ns removal hang when failing to
 revalidate due to a transient error
In-Reply-To: <20190808232536.4258-8-sagi@grimberg.me>
References: <20190808232536.4258-1-sagi@grimberg.me>
 <20190808232536.4258-8-sagi@grimberg.me>
Message-ID: <02ddf34b-b502-9ae0-6e00-144b72e00eef@grimberg.me>


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
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> 
> 2
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Woops... squash left-over...
