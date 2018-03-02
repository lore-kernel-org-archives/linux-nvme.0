From: keith.busch@intel.com (Keith Busch)
Date: Fri, 2 Mar 2018 14:12:59 -0700
Subject: [PATCH v2 1/1] nvme: implement log page low/high offset and dwords
In-Reply-To: <mqdy3jfc3a1.fsf@linux-x5ow.site>
References: <20180226125540.9513-1-mb@lightnvm.io>
 <20180226125540.9513-2-mb@lightnvm.io>
 <mqdy3jfc3a1.fsf@linux-x5ow.site>
Message-ID: <20180302211258.GB22933@localhost.localdomain>

Thanks, applied for 4.17.

A side note for those interested, some bug fixing commits introduced in
the nvme-4.17 branch were applied to 4.16-rc. I've rebased these on top
of linux-block/for-next so we don't have the duplicate commits for the
4.17 merge window. The nvme branch currently may be viewed here:

  http://git.infradead.org/nvme.git/shortlog/refs/heads/for-next
