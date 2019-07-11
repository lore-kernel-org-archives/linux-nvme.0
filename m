From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 11 Jul 2019 21:53:00 +0900
Subject: [PATCH rfc 5/6] nvme-cli: add --quiet option
In-Reply-To: <20190710232740.26734-6-jsmart2021@gmail.com>
References: <20190710232740.26734-1-jsmart2021@gmail.com>
 <20190710232740.26734-6-jsmart2021@gmail.com>
Message-ID: <20190711125300.GD8398@minwoo-desktop>

On 19-07-10 16:27:39, James Smart wrote:
> From: Sagi Grimberg <sagi at grimberg.me>
> 
> Now we are going to have discovery log change events, so
> instead of trying to figure out which NVM subsystem ports
> are already connected, we let the driver do that and
> only suppress the failure messages.
> 
> Example:
>   nvme connect-all ... --quiet
> 
> This option will be used by the discovery log change corresponding
> udev rule.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> Reviewed-by: James Smart <jsmart2021 at gmail.com>
> Reviewed-by: Hannes Reinecke <hare at suse.com>

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
