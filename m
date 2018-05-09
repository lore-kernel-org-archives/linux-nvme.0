From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 8 May 2018 21:40:14 -0700
Subject: [PATCH v3] nvme: add quirk to force medium priority for SQ
 creation
In-Reply-To: <672a97be-7fbf-b21e-9f75-2c18e64ccf8f@kernel.dk>
References: <672a97be-7fbf-b21e-9f75-2c18e64ccf8f@kernel.dk>
Message-ID: <20180509044014.GA10650@infradead.org>

On Tue, May 08, 2018@10:25:15AM -0600, Jens Axboe wrote:
> Some P3100 drives have a bug where they think WRRU (weighted round
> robin) is always enabled, even though the host doesn't set it. Since
> they think it's enabled, they also look at the submission queue
> creation priority. We used to set that to MEDIUM by default,
> but that was removed in commit 81c1cd98351b. This causes various
> issues on that drive. Add a quick to still set MEDIUM priority
> for that controller.

And this really isn't something that could be fixed with a trivial
firmware uptodate?  I'd really hate to pile on hacks like this if we
can somehow avoid it.
