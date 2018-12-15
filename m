From: jalee@purestorage.com (Jaesoo Lee)
Date: Fri, 14 Dec 2018 18:41:00 -0700
Subject: [PATCH] nvme-rdma: fix timeout handler
In-Reply-To: <fa19e6a2-e358-6e29-53c7-4a68eacf6a93@grimberg.me>
References: <20181213212917.8900-1-sagi@grimberg.me>
 <fa19e6a2-e358-6e29-53c7-4a68eacf6a93@grimberg.me>
Message-ID: <20181215014059.GA28629@xldev1604-tmpl.dev.purestorage.com>

I have tested the code (backported to v4.19.9) and verified it works great for the scenarios I had originally reported. Also the code looks good to me.

Thanks.

On Thu, Dec 13, 2018@01:35:31PM -0800, Sagi Grimberg wrote:
> This was meant to be an RFC, not yet for inclusion. I mostly
> wanted Jaesoo and Nitzan to provide their feedback...
