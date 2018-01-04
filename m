From: snitzer@redhat.com (Mike Snitzer)
Date: Thu, 4 Jan 2018 18:43:50 -0500
Subject: [PATCH 3/5] block: Provide blk_status_t decoding for retryable
 errors
In-Reply-To: <20180104224623.8944-4-keith.busch@intel.com>
References: <20180104224623.8944-1-keith.busch@intel.com>
 <20180104224623.8944-4-keith.busch@intel.com>
Message-ID: <20180104234349.GD16051@redhat.com>

On Thu, Jan 04 2018 at  5:46pm -0500,
Keith Busch <keith.busch@intel.com> wrote:

> This patch provides a common decoder for block status that may be retried
> so various entities wishing to consult this do not have to duplicate
> this decision.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Acked-by: Mike Snitzer <snitzer at redhat.com>
