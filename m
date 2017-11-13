From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 13 Nov 2017 22:18:02 +0200
Subject: [PATCH 3/4] nvmet: Add controllers to configfs
In-Reply-To: <1510576183-17215-4-git-send-email-israelr@mellanox.com>
References: <1510576183-17215-1-git-send-email-israelr@mellanox.com>
 <1510576183-17215-4-git-send-email-israelr@mellanox.com>
Message-ID: <4521c253-156a-b462-1c2d-3b20a59874ba@grimberg.me>


> +void nvmet_ctrl_configfs_del(struct nvmet_ctrl *ctrl)
> +{
> +	if (d_inode(ctrl->group.cg_item.ci_dentry))
> +		configfs_unregister_group(&ctrl->group);

I'm not sure I understand the conditional here, care to explain?
