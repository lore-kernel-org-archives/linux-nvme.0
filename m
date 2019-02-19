From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 19 Feb 2019 10:58:10 -0800
Subject: [PATCH 6/6] nvme: Avoid that deleting a controller triggers a
 circular locking complaint
In-Reply-To: <20190219165501.GC16341@localhost.localdomain>
References: <20190214225057.195397-1-bvanassche@acm.org>
 <20190214225057.195397-7-bvanassche@acm.org> <20190219151655.GB4121@lst.de>
 <20190219165501.GC16341@localhost.localdomain>
Message-ID: <bb4294ce-274c-1da2-2270-2849ca1952e2@grimberg.me>


> This looks correct. I had to double check 'ret' was initilized to 0
> outside what the diff is showing, so maybe it'd be more obvious if
> nvme_do_delete_ctrl() was in an 'else' condition.

Agreed.
