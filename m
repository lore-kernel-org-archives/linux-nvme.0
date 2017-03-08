From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Wed, 8 Mar 2017 22:12:56 +0000
Subject: [PATCH] IB/core: Protect against self-requeue of a cq work item
In-Reply-To: <1489003252-1893-1-git-send-email-sagi@grimberg.me>
References: <1489003252-1893-1-git-send-email-sagi@grimberg.me>
Message-ID: <1489011163.2813.7.camel@sandisk.com>

On Wed, 2017-03-08@22:00 +0200, Sagi Grimberg wrote:
> We need to make sure that the cq work item does not
> run when we are destroying the cq. Unlike flush_work,
> cancel_work_sync protects against self-requeue of the
> work item (which we can do in ib_cq_poll_work).

Reviewed-by: Bart Van Assche <bart.vanassche at sandisk.com>
