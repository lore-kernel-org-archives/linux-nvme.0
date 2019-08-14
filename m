From: kbusch@kernel.org (Keith Busch)
Date: Wed, 14 Aug 2019 13:08:15 -0600
Subject: [PATCH] nvme: Use first ctrl->instance id as subsystem id
In-Reply-To: <b5b471cc-8935-cf96-d55a-a7dc731cb0d6@canonical.com>
References: <20190814142836.2322-1-gpiccoli@canonical.com>
 <20190814160640.GA3256@localhost.localdomain>
 <abfc4bd0-f4f0-5655-81ee-ec32d3516f35@canonical.com>
 <20190814162754.GB3256@localhost.localdomain>
 <b5b471cc-8935-cf96-d55a-a7dc731cb0d6@canonical.com>
Message-ID: <20190814190814.GC3256@localhost.localdomain>

On Wed, Aug 14, 2019@11:29:17AM -0700, Guilherme G. Piccoli wrote:
> It is a suggestion from my colleague Dan (CCed here), something like:
> for non-multipath nvme, keep nvmeC and nvmeCnN (C=controller ida,
> N=namespace); for multipath nvme, use nvmeScCnN (S=subsystem ida).

This will inevitably lead to collisions. The existing naming scheme was
selected specifically to avoid that problem.
