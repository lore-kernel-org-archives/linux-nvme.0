From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 16 Aug 2017 12:33:47 +0300
Subject: Centralize nvme controller reset, delete and fabrics periodic
 reconnects
In-Reply-To: <20170816081605.GA29784@infradead.org>
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
 <20170816081605.GA29784@infradead.org>
Message-ID: <964d191e-0fe4-e440-71e6-0fd186d4f52b@grimberg.me>

>> This set applies on nvme-4.14 plus 4.13 recent fixes.
> 
> I can't get this applied at all.

That's probably because this is on top of the rdma affinity
patches which are already in Doug's tree...

> A pointer to a git repo would
> always be nice for patchsets as large as this one, especially if
> the base is a bit murky..

Sure, should I have it on top of the affinity patches or not?
