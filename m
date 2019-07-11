From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 11 Jul 2019 21:33:03 +0900
Subject: [PATCH rfc 2/6] nvme-cli: support persistent connections to a
 discovery controller
In-Reply-To: <20190710232740.26734-3-jsmart2021@gmail.com>
References: <20190710232740.26734-1-jsmart2021@gmail.com>
 <20190710232740.26734-3-jsmart2021@gmail.com>
Message-ID: <20190711123303.GB8398@minwoo-desktop>

On 19-07-10 16:27:36, James Smart wrote:
> From: Sagi Grimberg <sagi at grimberg.me>
> 
> Simply don't destroy the discovery controller after getting the
> log pages. Note that persistent connection to a discovery subsystem
> require to pass in a non-zero kato value, so if not provided we
> simply use a default of 30 seconds kato.
> 
> Example:
>   nvme connect-all ... --persistent
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> Reviewed-by: James Smart <jsmart2021 at gmail.com>
> Reviewed-by: Hannes Reinecke <hare at suse.com>
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>

This is what I really wanted to make it support!

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>

Thanks!
