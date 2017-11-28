From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 28 Nov 2017 21:58:59 +0900
Subject: [PATCH] nvme-cli: add new HMB identify fields of TP 4002
In-Reply-To: <20171128123736.GA1736@infradead.org>
References: <1511870207-17033-1-git-send-email-minwoo.im.dev@gmail.com>
 <20171128123736.GA1736@infradead.org>
Message-ID: <CAA7jztfaOPPMONxSZi+uMbdFAMqmxE7cESpX4kFH_-36R1FQSg@mail.gmail.com>

Hi all,

I'm sorry for making confusions because of the numbering of reserved field.
It should be started with 338 instead of 332.

The following patch will be good to be reviewed.

Thanks,

Add new HMB identify fields (hmminds, hmmaxd) to struct nvme_id_ctrl.
Those fields were added in TP 4002 which is "HMB Enhancements".

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 linux/nvme.h | 4 +++-
 nvme-print.c | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/linux/nvme.h b/linux/nvme.h
index 2d5be8f..48497a3 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -217,7 +217,9 @@ struct nvme_id_ctrl {
        __le16                  mntmt;
        __le16                  mxtmt;
        __le32                  sanicap;
-       __u8                    rsvd332[180];
+       __le32                  hmminds;
+       __le16                  hmmaxd;
+       __u8                    rsvd338[174];
        __u8                    sqes;
        __u8                    cqes;
        __le16                  maxcmd;
diff --git a/nvme-print.c b/nvme-print.c
index db11dd7..1808405 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -860,6 +860,8 @@ void __show_nvme_id_ctrl(struct nvme_id_ctrl
*ctrl, unsigned int mode, void (*ve
        printf("sanicap : %#x\n", le32_to_cpu(ctrl->sanicap));
        if (human)
                show_nvme_id_ctrl_sanicap(ctrl->sanicap);
+       printf("hmminds : %d\n", le32_to_cpu(ctrl->hmminds));
+       printf("hmmaxd  : %d\n", le16_to_cpu(ctrl->hmmaxd));
        printf("sqes    : %#x\n", ctrl->sqes);
        if (human)
                show_nvme_id_ctrl_sqes(ctrl->sqes);
-- 
2.7.4
