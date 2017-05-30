From: hch@lst.de (Christoph Hellwig)
Date: Tue, 30 May 2017 11:27:58 +0200
Subject: [PATCH 4/7] nvme: also report include the EUI-64 in identify
 NS report
In-Reply-To: <2f6eac411a9ce4c0bdc756e0cb5cfed66208b9d7.1496131397.git.jthumshirn@suse.de>
References: <cover.1496131397.git.jthumshirn@suse.de>
 <2f6eac411a9ce4c0bdc756e0cb5cfed66208b9d7.1496131397.git.jthumshirn@suse.de>
Message-ID: <20170530092758.GC16736@lst.de>

This should have had a nvmet: prefix, and probably be merged into the
previous patch.  But I don't really thing we should at it all, see
my previous comment.
