From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Oct 2017 13:11:02 +0300
Subject: [PATCH v2 3/7] nvme_fc: add a dev_loss_tmo field to the remoteport
In-Reply-To: <20170927045046.22238-4-jsmart2021@gmail.com>
References: <20170927045046.22238-1-jsmart2021@gmail.com>
 <20170927045046.22238-4-jsmart2021@gmail.com>
Message-ID: <984d8db1-c518-b515-05b5-46ba61c58c84@grimberg.me>


> +#define NVME_FC_DEFAULT_DEV_LOSS_TMO	60	/* seconds */

Why not reusing NVMF_DEF_CTRL_LOSS_TMO ? and isn't 60 seconds
a little to aggressive to give up?

What do you do with the ctrl_loss_tmo user parameter?
