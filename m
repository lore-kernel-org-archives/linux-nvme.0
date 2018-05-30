From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 30 May 2018 13:48:13 +0300
Subject: [PATCH 04/17] IB/isert: use T10-PI check mask definitions from
 core layer
In-Reply-To: <20180528072225.GE5618@lst.de>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-5-git-send-email-maxg@mellanox.com>
 <20180528072225.GE5618@lst.de>
Message-ID: <b8fa242d-c2d5-79fe-cab2-1c73adadbc4b@mellanox.com>



On 5/28/2018 10:22 AM, Christoph Hellwig wrote:
> On Sun, May 27, 2018@06:50:09PM +0300, Max Gurtovoy wrote:
>> No reason to use hard-coded protection information checks in ib_isert driver.
>> Use check masks from RDMA core driver.
> 
> Looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> 

Christoph,

Before I sent the patches to Jason, I will change the commit to be:

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c 
b/drivers/infiniband/ulp/isert/ib_isert.c
index d8b6bde..d03f05a 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -2106,10 +2106,13 @@
                 return -EINVAL;
         }

-       sig_attrs->check_mask =
-              (se_cmd->prot_checks & TARGET_DIF_CHECK_GUARD  ? 0xc0 : 0) |
-              (se_cmd->prot_checks & TARGET_DIF_CHECK_APPTAG ? 0x30 : 0) |
-              (se_cmd->prot_checks & TARGET_DIF_CHECK_REFTAG ? 0x0f : 0);
+       if (se_cmd->prot_checks & TARGET_DIF_CHECK_GUARD)
+               sig_attrs->check_mask |= IB_SIG_CHECK_GUARD;
+       if (se_cmd->prot_checks & TARGET_DIF_CHECK_APPTAG)
+               sig_attrs->check_mask |= IB_SIG_CHECK_APPTAG;
+       if (se_cmd->prot_checks & TARGET_DIF_CHECK_REFTAG)
+               sig_attrs->check_mask |= IB_SIG_CHECK_REFTAG;
+
         return 0;
  }



I can reduce the instructions since we don't need to do a bitwise "or" 
with 0 (check mask is set to 0 in the start of the function).

Let me know if I can add your "Reviewed-by" for this.
