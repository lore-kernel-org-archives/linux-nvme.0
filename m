From: dledford@redhat.com (Doug Ledford)
Date: Fri, 24 Mar 2017 16:41:54 -0400
Subject: [PATCH] IB/core: Protect against self-requeue of a cq work item
In-Reply-To: <1489003252-1893-1-git-send-email-sagi@grimberg.me>
References: <1489003252-1893-1-git-send-email-sagi@grimberg.me>
Message-ID: <1490388114.2404.24.camel@redhat.com>

On Wed, 2017-03-08@22:00 +0200, Sagi Grimberg wrote:
> We need to make sure that the cq work item does not
> run when we are destroying the cq. Unlike flush_work,
> cancel_work_sync protects against self-requeue of the
> work item (which we can do in ib_cq_poll_work).
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Hi Sagi, I didn't know if this was a theoretical or you actually hit
this in practice, so I pulled it for -rc in case it was actually being
hit in the wild. ?Thanks.

-- 
Doug Ledford <dledford at redhat.com>
? ? GPG KeyID: B826A3330E572FDD
? ?
Key fingerprint = AE6B 1BDA 122B 23B4 265B ?1274 B826 A333 0E57 2FDD
