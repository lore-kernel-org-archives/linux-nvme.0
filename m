From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 28 Aug 2017 08:53:36 -0700
Subject: [GIT PULL] nvme update for Linux 4.14
In-Reply-To: <199590da-6ff8-24de-abca-00f23608b93b@kernel.dk>
References: <20170828143343.evhchzfzam3whgwm@infradead.org>
 <199590da-6ff8-24de-abca-00f23608b93b@kernel.dk>
Message-ID: <20170828155336.GA5302@infradead.org>

On Mon, Aug 28, 2017@09:51:38AM -0600, Jens Axboe wrote:
> What is this against, exactly? It doesn't merge cleanly with my 4.14 branch.
> >From a quick look, looks like it's conflicting with:

It was based on the nvme-3.13 tree from about two weeks ago,
which was based on your for-linus at about that time.
