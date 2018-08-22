From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 22 Aug 2018 06:05:31 -0700
Subject: [PATCH V2] nvmet: free workqueue object if module init fails
In-Reply-To: <20180816014825.13762-1-chaitanya.kulkarni@wdc.com>
References: <20180816014825.13762-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180822130531.GB8963@infradead.org>

Looks good, but I had to apply this manually as the context didn't
match what is upstream.  Please double check that I didn't mess
it up.
