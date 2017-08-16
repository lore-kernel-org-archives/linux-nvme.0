From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 16 Aug 2017 12:46:25 +0300
Subject: Centralize nvme controller reset, delete and fabrics periodic
 reconnects
In-Reply-To: <20170816093559.GA24709@lst.de>
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
 <20170816081605.GA29784@infradead.org>
 <964d191e-0fe4-e440-71e6-0fd186d4f52b@grimberg.me>
 <20170816093559.GA24709@lst.de>
Message-ID: <ca050b6b-6694-834c-51ab-856b516bd6ad@grimberg.me>

>> Sure, should I have it on top of the affinity patches or not?
> 
> For now get any tree you have out to take a look.  In the longer
> run we'll need to decide how we want to deal with the merge
> of the two trees.  In general having to depend on the RDMA
> tree is a major risk because it's maintainance is so unreliable.

Its really a small conflict, easy enough to get it without. The problem
that no matter what I do, one tree would conflict...

> If it's in a branch of its own we could pull it in through and
> send that bit through both trees.

We can do that, should I use the nvme tree for that? or maybe once we
converge on the patch set?
