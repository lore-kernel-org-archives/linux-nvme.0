From: keith.busch@intel.com (Keith Busch)
Date: Thu, 26 Apr 2018 14:41:04 -0600
Subject: [PATCH v2] nvme: change order of qid and cmdid in completion trace
In-Reply-To: <20180426202515.20206-1-jthumshirn@suse.de>
References: <20180426202515.20206-1-jthumshirn@suse.de>
Message-ID: <20180426204104.GA3094@localhost.localdomain>

On Thu, Apr 26, 2018@02:25:15PM -0600, Johannes Thumshirn wrote:
> Keith reported that command submission and command completion
> tracepoints have the order of the cmdid and qid fields swapped.
> 
> While it isn't easily possible to change the command submission
> tracepoint, as there is a regression test parsing it in blktests we
> can swap the command completion tracepoint to have the fields aligned.

It's the little things that matter. :)

Thanks, applied to nvme-4.18.
