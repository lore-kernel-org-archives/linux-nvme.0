From: keith.busch@linux.intel.com (Keith Busch)
Date: Mon, 11 Jun 2018 10:00:02 -0600
Subject: [PATCH] nvme: don't rely on the changed namespace list log
In-Reply-To: <20180611143009.GA14441@lst.de>
References: <20180606123742.4805-1-hch@lst.de> <20180611143009.GA14441@lst.de>
Message-ID: <20180611160002.GA791@localhost.localdomain>

Thanks, this looks fine. The main thing I want to prevent is reading from
a namespace with the wrong block size, which may corrupt memory. I don't
think it's possible to fix every scenario, but this patch at least narrows
it down even if the scenario this is guarding against is pretty unlikely.

Reviewed-by: Keith Busch <keith.busch at linux.intel.com>
