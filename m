From: israelr@mellanox.com (Israel Rukshin)
Date: Tue, 14 Nov 2017 12:04:03 +0200
Subject: [PATCH 3/4] nvmet: Add controllers to configfs
In-Reply-To: <4521c253-156a-b462-1c2d-3b20a59874ba@grimberg.me>
References: <1510576183-17215-1-git-send-email-israelr@mellanox.com>
 <1510576183-17215-4-git-send-email-israelr@mellanox.com>
 <4521c253-156a-b462-1c2d-3b20a59874ba@grimberg.me>
Message-ID: <de0724f9-8bea-360c-75c6-5daeb25a7955@mellanox.com>

On 11/13/2017 10:18 PM, Sagi Grimberg wrote:
>
>> +void nvmet_ctrl_configfs_del(struct nvmet_ctrl *ctrl)
>> +{
>> +    if (d_inode(ctrl->group.cg_item.ci_dentry))
>> +        configfs_unregister_group(&ctrl->group);
>
> I'm not sure I understand the conditional here, care to explain?

Since I created the controller folder with configfs_register_group(), it 
creates this folder as a default folder.
Default folders are removed when their parent folder is removed.

The new filesystem hierarchy:
<SUBSYSTEM>/controllers/<CTRL_ID>/

Both controllers and controller (CTRL_ID) are default folders.
This condition protect us from a case that the user remove the subsystem 
folder with active connections.
When subsystem folder is removed by the user it first remove the 
controllers folder
and then it removes all the controller (CTRL_ID)  folders.
In this case there is no need to remove again the controller (CTRL_ID)  
folders when
the actual controller object is going to be freed.

This check simply asks if controller (CTRL_ID) folders was already removed.
