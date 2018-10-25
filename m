From: bvanassche@acm.org (Bart Van Assche)
Date: Thu, 25 Oct 2018 09:08:47 -0700
Subject: [PATCH 0/2] nvmet-rdma: Suppress a lockdep complaint
In-Reply-To: <20181025151940.388-1-bvanassche@acm.org>
References: <20181025151940.388-1-bvanassche@acm.org>
Message-ID: <1540483727.66186.24.camel@acm.org>

On Thu, 2018-10-25@08:19 -0700, Bart Van Assche wrote:
> This patch series addresses a lockdep complaint that has been
> discussed recently on the NVMe mailing list. Please consider this
> patch series for the upstream kernel.

Please ignore this patch series - the real reason the lockdep complaint
did not appear anymore was an incorrect patch for the kernel workqueue
implementation.

Bart.
