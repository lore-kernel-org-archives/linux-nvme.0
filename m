From: nab@linux-iscsi.org (Nicholas A. Bellinger)
Date: Wed, 08 Nov 2017 02:25:25 -0800
Subject: [PATCH v3 3/9] IB/iser: use implicit CQ allocation
In-Reply-To: <20171108095742.25365-4-sagi@grimberg.me>
References: <20171108095742.25365-1-sagi@grimberg.me>
 <20171108095742.25365-4-sagi@grimberg.me>
Message-ID: <1510136725.29624.77.camel@haakon3.daterainc.com>

On Wed, 2017-11-08@11:57 +0200, Sagi Grimberg wrote:
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> [hch: ported to the new API]
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/infiniband/ulp/iser/iscsi_iser.h | 19 --------
>  drivers/infiniband/ulp/iser/iser_verbs.c | 82 ++++----------------------------
>  2 files changed, 8 insertions(+), 93 deletions(-)
> 

A nice improvement to make IB_QP_CREATE_ASSIGN_CQS common across ULPs.

Reviewed-by: Nicholas Bellinger <nab at linux-iscsi.org>
