From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 16 Nov 2015 01:54:58 -0800
Subject: [PATCH RFC] nvmet: Reference namespaces percpu
In-Reply-To: <1447666323-16796-1-git-send-email-sagig@mellanox.com>
Message-ID: <20151116095458.GA15599@infradead.org>

Thanks Sagi,

this looks good to me.  If only the percpu_ref API would call ->release
in a useful context we could get rid of all this workqueue boilerplate
code in most users..
