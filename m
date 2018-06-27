From: bdeyal@gmail.com (Eyal BenDavid)
Date: Wed, 27 Jun 2018 20:34:13 +0300
Subject: Fwd: [PATCH] nvme-cli : fix offset advance in nvme-ioctl.c:
 nvme_get_properties()
In-Reply-To: <CAPrnrPAFO-0WDcbrkx-JdbG=JtzLVmpNPSs1wjJtUg+TUR3Yiw@mail.gmail.com>
References: <CAPrnrPAFO-0WDcbrkx-JdbG=JtzLVmpNPSs1wjJtUg+TUR3Yiw@mail.gmail.com>
Message-ID: <CAPrnrPDMfkXRGLG_wb13mQjDfGLKP6u+RYg0FaSWQ4nAuqy2FQ@mail.gmail.com>

In case it was missed.
Thanks


---------- Forwarded message ---------
From: Eyal BenDavid <bdeyal@gmail.com>
Date: Sun, Jun 24, 2018 at 10:37 AM
Subject: [PATCH] nvme-cli : fix offset advance in nvme-ioctl.c:
nvme_get_properties()
To: linux-nvme <linux-nvme at lists.infradead.org>


In the case of 64 bit property, the offset loop variable is advanced
correctly only on error. When the call to nvme_property is successful
(and thus err == 0) the offset variable is advanced by 4 bytes only.

Here is a small patch that fixes the offset:

diff --git i/nvme-ioctl.c w/nvme-ioctl.c
index 63ff8fb..d52dd0a 100644
--- i/nvme-ioctl.c
+++ w/nvme-ioctl.c
@@ -572,8 +572,10 @@ int nvme_get_properties(int fd, void **pbar)
                        continue;
                }
                ret = 0;
-               if (is64bit)
+             if (is64bit) {
                        *(uint64_t *)(*pbar + off) = le64_to_cpu(value64);
+                       off += 4;
+               }

                else
                        *(uint32_t *)(*pbar + off) = le32_to_cpu(value64);
        }
