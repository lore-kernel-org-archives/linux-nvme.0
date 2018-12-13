From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 13 Dec 2018 09:23:52 -0600
Subject: [PATCH v2 1/6] block: introduce blk_execute_rq_polled
In-Reply-To: <20181213063819.13614-2-sagi@grimberg.me>
References: <20181213063819.13614-1-sagi@grimberg.me>
 <20181213063819.13614-2-sagi@grimberg.me>
Message-ID: <998d400e-f81a-469e-5105-47f063d15466@opengridcomputing.com>


On 12/13/2018 12:38 AM, Sagi Grimberg wrote:
> Used forsynchronous requests that needs polling. If we are knowingly

nit:? "Used for synchronous requests that need polling."


> sending a request down to a poll queue, we need a synchronous interface
> to poll for its completion.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>


Reviewed-by: Steve Wise <swise at opengricomputing.com>
