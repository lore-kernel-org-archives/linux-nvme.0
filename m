From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 21 Mar 2019 14:26:00 -0700
Subject: [PATCH] nvme: schedule requeue whenever a LIVE state is entered
In-Reply-To: <20190321141033.131308-1-hare@suse.de>
References: <20190321141033.131308-1-hare@suse.de>
Message-ID: <da58a1e4-14cd-2587-6350-dccabb6632f1@grimberg.me>


> When undergoing state transitions I/O might be requeued, hence
> we always have to schedule requeue_work whenever the nvme device
> is live, independent on whether the old state was live or not.

Any reason why not simply update from live to live?
