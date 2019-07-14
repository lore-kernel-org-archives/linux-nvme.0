From: james.smart@broadcom.com (James Smart)
Date: Sun, 14 Jul 2019 08:13:36 -0700
Subject: [PATCH v2 3/3] nvme: fire discovery log page change events to
 userspace
In-Reply-To: <20190712180211.26333-4-sagi@grimberg.me>
References: <20190712180211.26333-1-sagi@grimberg.me>
 <20190712180211.26333-4-sagi@grimberg.me>
Message-ID: <169826df-9eb2-57ab-1141-d2cdb5eefd68@broadcom.com>



On 7/12/2019 11:02 AM, Sagi Grimberg wrote:
> Provide userspace with nvme discovery controller device instance,
> controller traddr and trsvcid. We'd expect userspace to handle
> this event by issuing a discovery + connect.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/core.c | 30 +++++++++++++++++++++++++++++-
>   1 file changed, 29 insertions(+), 1 deletion(-)
>
>


Reviewed-by: James Smart <james.smart at broadcom.com>
