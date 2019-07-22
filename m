From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 22 Jul 2019 11:11:11 -0700
Subject: [PATCH 0/4] small set of nvme cleanups
In-Reply-To: <3086fcef-efb2-85e4-4e36-2c5734cf3068@broadcom.com>
References: <20190719194546.24229-1-sagi@grimberg.me>
 <3086fcef-efb2-85e4-4e36-2c5734cf3068@broadcom.com>
Message-ID: <49f5b976-ce60-63a0-d5dc-4d650de41de5@grimberg.me>


> The changes look fine except for 1 main issue:? All of the nvmf 
> transports call nvme_enable_ctrl(), which still references ctrl->cap, 
> before they call nvme_init_identify().

You're right, I'll move the cap register read to nvme_enable_ctrl.

Thanks!
