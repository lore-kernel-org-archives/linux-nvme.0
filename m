From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 13 Dec 2018 09:28:57 -0600
Subject: [PATCH v2 6/6] nvme-multipath: disable polling for underlying
 namespace request queue
In-Reply-To: <20181213063819.13614-7-sagi@grimberg.me>
References: <20181213063819.13614-1-sagi@grimberg.me>
 <20181213063819.13614-7-sagi@grimberg.me>
Message-ID: <3b8c0f01-ae3c-6003-152d-419316616f7f@opengridcomputing.com>


On 12/13/2018 12:38 AM, Sagi Grimberg wrote:
> Since the multipath device does not support polling (yet) we cannot
> pass requests to the polling queue map as those will not generate
> interrupt so we cannot reap the completion.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Looks good.

Signed-off-by: Steve Wise <swise at opengridcomputing.com>
