From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 23 Jul 2019 10:31:21 -0700
Subject: [PATCH v2 1/3] nvme: have nvme_init_identify set ctrl->cap
In-Reply-To: <0b926f73-c439-7057-dcb8-75e89486f084@broadcom.com>
References: <20190723000654.6448-1-sagi@grimberg.me>
 <20190723000654.6448-2-sagi@grimberg.me>
 <0b926f73-c439-7057-dcb8-75e89486f084@broadcom.com>
Message-ID: <67662209-d680-733a-e673-6cd2c45010b3@grimberg.me>


> 
> wondering why we're re-reading CAP if it was already done in 
> nvme_enable_ctrl()

Its lost in patch #2
