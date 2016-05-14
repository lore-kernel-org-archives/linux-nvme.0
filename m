From: dan.j.williams@intel.com (Dan Williams)
Date: Sat, 14 May 2016 07:22:29 -0700
Subject: [RFCv2 3/3] block: Introduce S_HIPRI inode flag
In-Reply-To: <1463184168-3381-4-git-send-email-jonathan.derrick@intel.com>
References: <1463184168-3381-1-git-send-email-jonathan.derrick@intel.com>
 <1463184168-3381-4-git-send-email-jonathan.derrick@intel.com>
Message-ID: <CAPcyv4ibBEh7xm8jUX-aq0a2ecqbZugDa_L1K=dbFujbKaDVVw@mail.gmail.com>

[ adding Martin, given his hint infrastructure that is in the works... ]


On Fri, May 13, 2016@5:02 PM, Jon Derrick <jonathan.derrick@intel.com> wrote:
> S_HIPRI is a hint that indicates the file (currently only block devices)
> is a high priority file. This hint allows direct-io to the block device
> to poll for completions if polling is available to the block device.
>
> The motivation for this patch comes from tiered caching solutions. A
> user may wish to have low-latency block devices act as a cache for
> higher-latency storage media.
>
> With the introduction of block polling, polling could be enabled on a
> queue of a block device. The preadv2/pwritev2 sets allowed a user to
> specify per-io polling, but removed the ability to poll per-queue.
>
> Instead of having a user modify their software to use preadv2/pwritev2,
> this patch allows a user to set S_HIPRI on a block device file to request
> all direct-io for this file to be polled.

Setting aside whether this should be a per-task ioprio hint vs a block
device inode hint, this single flag loses the granularity of whether
reads or writes are polled.  Low latency reads with posted writes
seems a valid configuration.
