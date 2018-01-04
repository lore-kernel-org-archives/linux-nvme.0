From: snitzer@redhat.com (Mike Snitzer)
Date: Thu, 4 Jan 2018 18:42:59 -0500
Subject: [PATCH 2/5] nvme/multipath: Consult blk_status_t for failover
In-Reply-To: <20180104224623.8944-3-keith.busch@intel.com>
References: <20180104224623.8944-1-keith.busch@intel.com>
 <20180104224623.8944-3-keith.busch@intel.com>
Message-ID: <20180104234259.GC16051@redhat.com>

On Thu, Jan 04 2018 at  5:46pm -0500,
Keith Busch <keith.busch@intel.com> wrote:

> This removes nvme multipath's specific status decoding to see if failover
> is needed, using the generic blk_status_t that was translated earlier. This
> abstraction from the raw NVMe status means nvme status decoding exists
> in just one place.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Acked-by: Mike Snitzer <snitzer at redhat.com>
