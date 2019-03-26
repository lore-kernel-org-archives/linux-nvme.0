From: hch@lst.de (Christoph Hellwig)
Date: Tue, 26 Mar 2019 08:36:22 +0100
Subject: [PATCH 1/4] nvmet: set loop queue's segment boundary mask as
 PAGE_SIZE - 1
In-Reply-To: <20190326031928.9499-2-ming.lei@redhat.com>
References: <20190326031928.9499-1-ming.lei@redhat.com>
 <20190326031928.9499-2-ming.lei@redhat.com>
Message-ID: <20190326073622.GA21617@lst.de>

Note that in many cases allocating larger pages in the other targets
would be useful.  Given that you fix the one places where we made a page
size assumption I don't see a great need to limit outselves here.
