From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 14 Jul 2019 17:14:56 +0900
Subject: [PATCH v2 3/3] nvme: fire discovery log page change events to
 userspace
In-Reply-To: <20190712180211.26333-4-sagi@grimberg.me>
References: <20190712180211.26333-1-sagi@grimberg.me>
 <20190712180211.26333-4-sagi@grimberg.me>
Message-ID: <20190714081456.GD2993@minwoo-desktop>

On 19-07-12 11:02:11, Sagi Grimberg wrote:
> Provide userspace with nvme discovery controller device instance,
> controller traddr and trsvcid. We'd expect userspace to handle
> this event by issuing a discovery + connect.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Sagi, Thanks for this patch!

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
