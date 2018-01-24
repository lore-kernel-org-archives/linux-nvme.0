From: keith.busch@intel.com (Keith Busch)
Date: Wed, 24 Jan 2018 08:59:35 -0700
Subject: [RFD] passthrough ioctl interface considered harmful?
In-Reply-To: <20180124150101.rxalj4x44bmwtaba@linux-x5ow.site>
References: <20180124150101.rxalj4x44bmwtaba@linux-x5ow.site>
Message-ID: <20180124155935.GD14790@localhost.localdomain>

On Wed, Jan 24, 2018@04:01:01PM +0100, Johannes Thumshirn wrote:
> Inspired by the discussion at [1] I've distilled a small test-case [1] which
> deletes QID 1 submission and completions queues. When running this while I/O
> is in-flight we obviously get timeouts and thus force controller resets.
> 
> For some commands commands (nvme_admin_format_nvm, nvme_admin_sanitize_nvm) we
> do already check whether it is a good idea or not and at least warn the user
> about the possible side effects.
> 
> Question here is, should we extend the list and/or block specific commands (at
> least while I/O is running)?

I like to think if you misuse the interface, you get to keep both
pieces. With great power comes great responsibility.
