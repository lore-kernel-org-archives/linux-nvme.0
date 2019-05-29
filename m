From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 28 May 2019 23:22:00 -0700
Subject: [GIT PULL] nvme fixes for 5.2
In-Reply-To: <FA7D2A4E-6CEF-467C-8153-F1DBCA624626@oracle.com>
References: <20190516082541.GA19383@infradead.org>
 <5175ce5c-1943-a167-52f5-094a3d2dc4a4@Oracle.com>
 <FA7D2A4E-6CEF-467C-8153-F1DBCA624626@oracle.com>
Message-ID: <0eb19967-e0bc-ed16-c2a1-39e624e2d7ab@grimberg.me>


>    It appears to me the caller nvme_free_ctrl()  is using a device name that has been cleared :
> 
>      sysfs_remove_link(&subsys->dev.kobj, dev_name(ctrl->device));
> 
> 
> The name passed in is null in kernfs_remove_by_name_ns() :
> 
> 
>   if (!parent) {
>     WARN(1, KERN_WARNING "kernfs: can not remove '%s', no directory\n",   name);

Where do you see this warning in the log?

> I don?t have a actual crash dump to examine though.

Is this a regression then? or did this not work before the above
patches?

Would it be possible to get some more of the log?

Also, I see that this is the removal flow, was that intentional
removal during the reconnect? or did ctrl_loss_tmo expired?
