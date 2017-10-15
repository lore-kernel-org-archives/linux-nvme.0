From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 15 Oct 2017 16:25:59 +0300
Subject: [PATCH 3/4] nvmet: Add controllers to configfs
In-Reply-To: <834d07fa-5830-ea7a-11b1-f20ebf47831c@gmail.com>
References: <1507635633-16665-1-git-send-email-israelr@mellanox.com>
 <1507635633-16665-4-git-send-email-israelr@mellanox.com>
 <834d07fa-5830-ea7a-11b1-f20ebf47831c@gmail.com>
Message-ID: <923a51f0-61f7-7813-97fc-65bf072a9bb6@mellanox.com>



On 10/15/2017 11:49 AM, roy wrote:
> Hi,
> 
> I think there is a potential problem here. for example in the next scenario:
> 
> core X is reading .../controllers/N/hostnqn and core Y is handling 
> nvmet_ctrl_free. basically
> 
> core Y can free the ctrl while core X will try to do sprintf on 
> ctrl->hostnqn which will cause NULL dereference.
> 
> Am I missing something?
> 

we delete the ctrl_configfs before freeing the ctrl. parallel processing 
should be protected by internal configfs mutex, just like in the case of 
reading namespace or port items.

for example:

static ssize_t nvmet_ns_enable_show(struct config_item *item, char *page)
{
         return sprintf(page, "%d\n", to_nvmet_ns(item)->enabled);
}

What I do see is an option for freeing the port (by rmdir ../ports/1/) 
and then ctrl->port will point to freed memory. I guess we can cache the 
needed values we want to show.
