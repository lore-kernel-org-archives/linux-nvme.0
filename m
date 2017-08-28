From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 28 Aug 2017 08:59:25 -0700
Subject: [GIT PULL] nvme update for Linux 4.14
In-Reply-To: <3c45e618-6a96-6443-258a-dac8f93ccc7a@kernel.dk>
References: <20170828143343.evhchzfzam3whgwm@infradead.org>
 <199590da-6ff8-24de-abca-00f23608b93b@kernel.dk>
 <20170828155336.GA5302@infradead.org>
 <3c45e618-6a96-6443-258a-dac8f93ccc7a@kernel.dk>
Message-ID: <20170828155925.GA32254@infradead.org>

On Mon, Aug 28, 2017@09:55:55AM -0600, Jens Axboe wrote:
> > It was based on the nvme-3.13 tree from about two weeks ago,
> > which was based on your for-linus at about that time.
> 
> Changes for 4.14 should be against the 4.14 branch. for-linus is
> for 4.13. In any case, there will be a conflict against master...

We would have otherwise had conflicts against changes in Linus'
tree for 4.13, so we were between a rock and a hard place here.
