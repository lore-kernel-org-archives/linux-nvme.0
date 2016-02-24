From: keith.busch@intel.com (Keith Busch)
Date: Wed, 24 Feb 2016 14:58:36 +0000
Subject: [PATCH] NVMe: Use IDA for namespace disk naming
In-Reply-To: <20160224130520.GA17955@infradead.org>
References: <1455819485-3730-1-git-send-email-keith.busch@intel.com>
 <20160221161249.GA21099@infradead.org>
 <20160223225635.GB20250@localhost.localdomain>
 <20160224130520.GA17955@infradead.org>
Message-ID: <20160224145835.GA7494@localhost.localdomain>

On Wed, Feb 24, 2016@05:05:20AM -0800, Christoph Hellwig wrote:
> But the bdi name embedds the major/minor of the device.  So if we
> haven't fully torn down the device we might run into sysfs name
> conflicts.

We don't tear down the minor until the final put_disk, fixing the
major/minor lifetime issue. That was commit:

  https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=2da78092dda13f1efd26edbbf99a567776913750

The namespace's disk_name using the IDA is released in the same path as
the final put_disk, so I think we're safe.
