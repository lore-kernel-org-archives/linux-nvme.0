From: nab@linux-iscsi.org (Nicholas A. Bellinger)
Date: Wed, 08 Nov 2017 02:27:14 -0800
Subject: [PATCH v3 2/9] IB/isert: use implicit CQ allocation
In-Reply-To: <20171108095742.25365-3-sagi@grimberg.me>
References: <20171108095742.25365-1-sagi@grimberg.me>
 <20171108095742.25365-3-sagi@grimberg.me>
Message-ID: <1510136834.29624.78.camel@haakon3.daterainc.com>

On Wed, 2017-11-08@11:57 +0200, Sagi Grimberg wrote:
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> [hch: ported to the new API]
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/infiniband/ulp/isert/ib_isert.c | 165 ++++----------------------------
>  drivers/infiniband/ulp/isert/ib_isert.h |  16 ----
>  2 files changed, 20 insertions(+), 161 deletions(-)
> 

Likewise.

Reviewed-by: Nicholas Bellinger <nab at linux-iscsi.org>
