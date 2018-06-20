From: bdeyal@gmail.com (Eyal BenDavid)
Date: Wed, 20 Jun 2018 19:20:23 +0300
Subject: NVME-CLI : Fabrics property-get and 64 bit property (CAP)
In-Reply-To: <CAPrnrPCy20UbgF2thtNnxcUZriDZdvGEs6MkZ0074w-ZLgyrdw@mail.gmail.com>
References: <CAPrnrPD2PtPO38cAzMfKdhS18GFj1vk032p0h0rQf0CFP+R=cw@mail.gmail.com>
 <e75d7829-9aeb-90fb-249a-c7ac4cef10bd@intel.com>
 <CAPrnrPBKcYUsuQ6krkcjB6BOzLcPz47vje4qjic5Xw9PQN3pTQ@mail.gmail.com>
 <20180619194802.GF19922@localhost.localdomain>
 <CAPrnrPCM79jUwngOQd0t6-pT3RocHNBnt_TS059d+NK-rodqDA@mail.gmail.com>
 <20180619202514.GG19922@localhost.localdomain>
 <CAPrnrPA2rUeWsrU5K_s9do30EjuxU3Z0VD_EVCk_81+n-kX+gQ@mail.gmail.com>
 <CAPrnrPCy20UbgF2thtNnxcUZriDZdvGEs6MkZ0074w-ZLgyrdw@mail.gmail.com>
Message-ID: <CAPrnrPD6HzwdPBtBEZrtM6R2Qn-8wua-v7XiM391L+Sf5hMeHA@mail.gmail.com>

Here is a small patch that fixes the offset.

Eyal

------

diff --git i/nvme-ioctl.c w/nvme-ioctl.c
index 63ff8fb..d52dd0a 100644
--- i/nvme-ioctl.c
+++ w/nvme-ioctl.c
@@ -572,8 +572,10 @@ int nvme_get_properties(int fd, void **pbar)
                        continue;
                }
                ret = 0;
-               if (is64bit)
+               if (is64bit) {
                        *(uint64_t *)(*pbar + off) = le64_to_cpu(value64);
+                       off += 4;
+               }
                else
                        *(uint32_t *)(*pbar + off) = le32_to_cpu(value64);
        }
