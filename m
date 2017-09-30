From: sagi@grimberg.me (Sagi Grimberg)
Date: Sat, 30 Sep 2017 19:18:15 +0200
Subject: [PATCH] nvme_fc: avoid workqueue flush stalls
In-Reply-To: <20170928165631.16097-1-jsmart2021@gmail.com>
References: <20170928165631.16097-1-jsmart2021@gmail.com>
Message-ID: <01c52881-b172-0d86-5db2-596acf6394db@grimberg.me>


> There's no need to wait for the full nvme_wq, which is now shared,
> to flush. flush only the delete_work item.

The patch looks correct, but can you explain what stalled that this
patch fixes?
