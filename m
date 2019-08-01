From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 1 Aug 2019 11:42:39 -0700
Subject: [PATCH 2/2] nvme: do not remove namespaces during reset
In-Reply-To: <20190801071644.66690-3-hare@suse.de>
References: <20190801071644.66690-1-hare@suse.de>
 <20190801071644.66690-3-hare@suse.de>
Message-ID: <133a8679-0949-98ea-ed29-51be0fd2ebc3@grimberg.me>


> Whenever the controller is resetting or connecting we cannot make
> any decisions about the attached namespaces, and consequently we
> shouldn't remove them. So skip namespace removal during reset;
> a scan will be triggered anyway after reconnecting which will
> clean up any stale namespaces.

I personally dislike making nvme_ns_remove() to semantically
mean nvme_ns_maybe_remove()..

Is there a fundamental why this check is not performed in the
call-site and is inside nvme_ns_remove()? Are there other
calls that you have seen to be problematic? if so which? and how?
