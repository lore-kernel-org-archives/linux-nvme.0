From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Tue, 20 Oct 2015 13:19:45 +0300
Subject: [PATCH 06/18] nvme: split a new struct nvme_ctrl out of struct
 nvme_dev
In-Reply-To: <1444975128-8768-7-git-send-email-hch@lst.de>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-7-git-send-email-hch@lst.de>
Message-ID: <56261541.9030702@dev.mellanox.co.il>

On 10/16/2015 8:58 AM, Christoph Hellwig wrote:
> The new struct nvme_ctrl will be used by the common NVMe code that sits
> on top of struct request_queue and the new nvme_ctrl_ops abstraction.
> It only contains the bare minimum required, which consists of values
> sampled during controller probe, the admin queue pointer and a second
> struct device pointer at the moment,

Hi Christoph,

Can you explain why nvme_ctrl needs an additional struct device pointer?
(I understand it will go away from your statement "at the moment"
haven't read the rest of the patch set yet).
