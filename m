From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 28 Aug 2017 10:57:44 -0700
Subject: [GIT PULL] nvme update for Linux 4.14
In-Reply-To: <44a35d51-48d5-7181-df7e-b75fcbc053d9@kernel.dk>
References: <20170828143343.evhchzfzam3whgwm@infradead.org>
 <199590da-6ff8-24de-abca-00f23608b93b@kernel.dk>
 <20170828155336.GA5302@infradead.org>
 <3c45e618-6a96-6443-258a-dac8f93ccc7a@kernel.dk>
 <20170828155925.GA32254@infradead.org>
 <44a35d51-48d5-7181-df7e-b75fcbc053d9@kernel.dk>
Message-ID: <20170828175744.GA26713@infradead.org>

On Mon, Aug 28, 2017@10:03:39AM -0600, Jens Axboe wrote:
> But one rock is shittier than the other. If you based it against
> 4.14, then at least I only have to resolve the the problem once.
> 
> The real problem is that the patch that went into master had
> cleanups too. You should push back against that, since it will
> inevitably cause problems by diverging 4.13 and 4.14 more than
> absolutely necessary. Having conflicts in nvme for the block tree
> is not isolated to this series, unfortunately.

Given that the update doesn't appear to be in your for-next branch
yet: do you want me to rebase it and resend?
