From: hch@lst.de (Christoph Hellwig)
Date: Tue, 26 Mar 2019 08:38:00 +0100
Subject: [PATCH 2/4] nvmet: fix computation of io vector number
In-Reply-To: <20190326031928.9499-3-ming.lei@redhat.com>
References: <20190326031928.9499-1-ming.lei@redhat.com>
 <20190326031928.9499-3-ming.lei@redhat.com>
Message-ID: <20190326073800.GB21617@lst.de>

I'd rather see this merged with the last one (and patch 3 dropped as
it just gets removed entirely in 4) - that fixes all the issues together
and doesn't require your patch 1 as as a workaround first.
