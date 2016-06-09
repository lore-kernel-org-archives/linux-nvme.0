From: sagi@lightbits.io (Sagi Grimberg)
Date: Thu, 9 Jun 2016 12:29:20 +0300
Subject: nvme-fabrics: crash at nvme connect-all
In-Reply-To: <53708289.31891804.1465463883806.JavaMail.zimbra@kalray.eu>
References: <53708289.31891804.1465463883806.JavaMail.zimbra@kalray.eu>
Message-ID: <575936F0.9000600@lightbits.io>


> Hello,
> I'm testing the nvme-fabrics patchset and I get a kernel stall or errors when running
> nvme connect-all. Below you have the commands and kernel log I get when it outputs
> errors. I'm going to debug it further today.
>
> The commands I run:
>
> ./nvme discover -t rdma -a 10.0.0.3
> Discovery Log Number of Records 1, Generation counter 1
> =====Discovery Log Entry 0======
> trtype:  ipv4
> adrfam:  rdma
> nqntype: 2
> treq:    0
> portid:  2
> trsvcid: 4420
> subnqn:  testnqn
> traddr:  10.0.0.3
> rdma_prtype: 0
> rdma_qptype: 0
> rdma_cms:    0
> rdma_pkey: 0x0000
>
> ./nvme connect -t rdma -n testnqn -a 10.0.0.3
> Failed to write to /dev/nvme-fabrics: Connection reset by peer
>
> ./nvme connect-all -t rdma  -a 10.0.0.3
> <here the kernel crashes>

Hi Marta,

I got the same bug report, it looks like we're might
be facing a double-free condition.

Does this patch help?
-- 
commit fd36b6ef3d0881b1bccc1eac8737baaf8c863a21
Author: Sagi Grimberg <sagi at grimberg.me>
Date:   Thu Jun 9 12:17:09 2016 +0300

     fabrics: Don't directly free opts->host

     It might be the default host, so we need to call
     nvmet_put_host (which is safe against NULL lucky for
     us).

     Reported-by: Alexander Nezhinsky <alexander.nezhinsky at excelero.com>
     Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ee4b7f137ad5..cd7eb03c4ff7 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -806,7 +806,7 @@ nvmf_create_ctrl(struct device *dev, const char 
*buf, size_t count)
  out_unlock:
         mutex_unlock(&nvmf_transports_mutex);
  out_free_opts:
-       kfree(opts->host);
+       nvmf_host_put(opts->host);
         kfree(opts);
         return ERR_PTR(ret);
  }
-- 
