From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 16 Sep 2016 02:27:43 -0700
Subject: [PATCH RFC 00/21] blk-mq: Introduce combined hardware queues
In-Reply-To: <cover.1474014910.git.agordeev@redhat.com>
References: <cover.1474014910.git.agordeev@redhat.com>
Message-ID: <20160916092743.GA5079@infradead.org>

Hi Alex,

this clashes badly with the my queue mapping rework that went into
Jens tree recently.

But in the meantime: there seem to be lots of little bugfixes and
cleanups in the series, any chance you could send them out as a first
series while updating the rest?

Also please Cc the linux-block list for block layer patches that don't
even seem to touch the nvme driver.
