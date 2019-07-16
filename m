From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 16 Jul 2019 10:49:13 +1000
Subject: [PATCH 1/3] nvme: Pass the queue to SQ_SIZE/CQ_SIZE macros
In-Reply-To: <20190716004649.17799-1-benh@kernel.crashing.org>
References: <20190716004649.17799-1-benh@kernel.crashing.org>
Message-ID: <b4dbc5d430ee9e4975c1ec26ea964e3f09796e97.camel@kernel.crashing.org>

On Tue, 2019-07-16@10:46 +1000, Benjamin Herrenschmidt wrote:
> # Conflicts:
> #       drivers/nvme/host/pci.c
> ---

Oops :-) You can strip that or should I resend ? I'll wait for
comments/reviews regardless.

Cheers,
Ben.
