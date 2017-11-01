From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 1 Nov 2017 08:38:17 -0700
Subject: [PATCH 0/5] nvmet/nvmet_fc: add events for discovery controller
 rescan
In-Reply-To: <ed37c118-6a9b-b4ab-dc8c-27eaa0c178f9@broadcom.com>
References: <20171028172114.2045-1-jsmart2021@gmail.com>
 <286e4dc4-af2c-3482-4345-a7b9984da994@grimberg.me>
 <ed37c118-6a9b-b4ab-dc8c-27eaa0c178f9@broadcom.com>
Message-ID: <20171101153817.GB13553@infradead.org>

On Sun, Oct 29, 2017@09:43:14PM -0700, James Smart wrote:
> Currently, the FC-NVME standard strongly suggests a discovery controller on
> each target.

Yikes.  This is a new requirement not backed by anything in NVMe or
NVMeoF itself.  Please have discussion in the technical working group
on this behavior first.

It's not that I'm against it - but I really want this sort of optional
transport behavior clearly documented in the actual NVMe spec first.
