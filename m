From: hch@lst.de (Christoph Hellwig)
Date: Wed, 16 Aug 2017 11:57:07 +0200
Subject: Centralize nvme controller reset, delete and fabrics periodic
 reconnects
In-Reply-To: <ca050b6b-6694-834c-51ab-856b516bd6ad@grimberg.me>
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
 <20170816081605.GA29784@infradead.org>
 <964d191e-0fe4-e440-71e6-0fd186d4f52b@grimberg.me>
 <20170816093559.GA24709@lst.de>
 <ca050b6b-6694-834c-51ab-856b516bd6ad@grimberg.me>
Message-ID: <20170816095707.GA26561@lst.de>

On Wed, Aug 16, 2017@12:46:25PM +0300, Sagi Grimberg wrote:
>>> Sure, should I have it on top of the affinity patches or not?
>>
>> For now get any tree you have out to take a look.  In the longer
>> run we'll need to decide how we want to deal with the merge
>> of the two trees.  In general having to depend on the RDMA
>> tree is a major risk because it's maintainance is so unreliable.
>
> Its really a small conflict, easy enough to get it without. The problem
> that no matter what I do, one tree would conflict...

Let's keep the refactoring self contained in nvme now and sort out
the small conflict when the rdma tree is merge (which is alsmost
certainly going to be after the block tree)
