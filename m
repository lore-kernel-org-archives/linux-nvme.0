From: hch@lst.de (Christoph Hellwig)
Date: Mon, 25 Mar 2019 11:55:37 +0100
Subject: [PATCH 2/2] nvme: target: build bvec from sg directly
In-Reply-To: <20190325100708.24172-3-ming.lei@redhat.com>
References: <20190325100708.24172-1-ming.lei@redhat.com>
 <20190325100708.24172-3-ming.lei@redhat.com>
Message-ID: <20190325105537.GA24973@lst.de>

This looks pretty sensible even if we don't end up submitting multi-page
vecs.  But can you please just send it on top of mainline directly?
The previos patch just creates pointless churn.
