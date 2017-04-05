From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 5 Apr 2017 08:17:05 -0600
Subject: [PATCH rfc 5/6] block: Add rdma affinity based queue mapping
 helper
In-Reply-To: <1491140492-25703-6-git-send-email-sagi@grimberg.me>
References: <1491140492-25703-1-git-send-email-sagi@grimberg.me>
 <1491140492-25703-6-git-send-email-sagi@grimberg.me>
Message-ID: <ce263274-d814-6167-42a3-5d3cad170f18@kernel.dk>

On 04/02/2017 07:41 AM, Sagi Grimberg wrote:
> Like pci and virtio, we add a rdma helper for affinity
> spreading. This achieves optimal mq affinity assignments
> according to the underlying rdma device affinity maps.

Reviewed-by: Jens Axboe <axboe at fb.com>

-- 
Jens Axboe
