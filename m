From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Thu, 13 Apr 2017 16:31:20 +0000
Subject: [PATCH v2 0/4] arbitrary sg lists support
In-Reply-To: <1492098977-5231-1-git-send-email-maxg@mellanox.com>
References: <1492098977-5231-1-git-send-email-maxg@mellanox.com>
Message-ID: <1492101079.5176.9.camel@sandisk.com>

On Thu, 2017-04-13@18:56 +0300, Max Gurtovoy wrote:
> This patch adds an arbitrary sg list support to NVMEoF host for
> capable devices (such as RDMA CX4/CX5 HCAs).
> During the review we decided to add an helper function to ib_core
> that will be used by ULPs in order to avoid code duplication.

Hello Max,

A question that is not related to the ULP drivers touched by this patch series:
some time ago registration of sg-lists with gaps was disabled in the SRP
initiator because arbitrary sg-lists triggered CQE dumps in combination with the
mlx5 driver. Does this mean that this issue has been resolved? If so, what mlx5
driver and/or firmware version are needed to reenable arbitrary sg-list support
in the SRP initiator?

Thanks,

Bart.
