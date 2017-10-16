From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 16 Oct 2017 06:00:53 -0700
Subject: [PATCH] nvme/target: Change max_nsid in subsystem due to
 ns_disable if needed
In-Reply-To: <1507651167-4839-1-git-send-email-roys@lightbitslabs.com>
References: <1507651167-4839-1-git-send-email-roys@lightbitslabs.com>
Message-ID: <20171016130053.GA1936@infradead.org>

Actually, this doesn't even compile..  the entry in ->namespaces
is dev_link, not entry.

If you resend please also fix the line > 80 chars, preferably
by adding a new helper that returns the new max_nsid value.
