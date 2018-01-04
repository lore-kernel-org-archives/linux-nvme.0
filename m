From: snitzer@redhat.com (Mike Snitzer)
Date: Thu, 4 Jan 2018 18:41:53 -0500
Subject: [PATCH 1/5] nvme: Add more command status translation
In-Reply-To: <20180104224623.8944-2-keith.busch@intel.com>
References: <20180104224623.8944-1-keith.busch@intel.com>
 <20180104224623.8944-2-keith.busch@intel.com>
Message-ID: <20180104234153.GB16051@redhat.com>

On Thu, Jan 04 2018 at  5:46pm -0500,
Keith Busch <keith.busch@intel.com> wrote:

> This adds more NVMe status code translations to blk_status_t values,
> and captures all the current status codes NVMe multipath uses.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Acked-by: Mike Snitzer <snitzer at redhat.com>
