From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 16 Nov 2017 10:01:17 +0300
Subject: [bug report] nvme: track shared namespaces
Message-ID: <20171116070116.hbncfaea3635lxqm@mwanda>

Hello Christoph Hellwig,

This is a semi-automatic email about new static checker warnings.

The patch ed754e5deeb1: "nvme: track shared namespaces" from Nov 9, 
2017, leads to the following Smatch complaint:

    drivers/nvme/host/core.c:2991 nvme_ns_remove()
     error: we previously assumed 'head' could be null (see line 2983)

drivers/nvme/host/core.c
  2982		nvme_mpath_clear_current_path(ns);
  2983		if (head)
                    ^^^^
The patch adds a check

  2984			list_del_rcu(&ns->siblings);
  2985		mutex_unlock(&ns->ctrl->subsys->lock);
  2986	
  2987		mutex_lock(&ns->ctrl->namespaces_mutex);
  2988		list_del_init(&ns->list);
  2989		mutex_unlock(&ns->ctrl->namespaces_mutex);
  2990	
  2991		synchronize_srcu(&head->srcu);
                                  ^^^^^^^^^^
and a new unchecked dereference.

  2992		nvme_put_ns(ns);
  2993	}

regards,
dan carpenter
