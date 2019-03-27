From: hch@lst.de (Christoph Hellwig)
Date: Wed, 27 Mar 2019 15:24:49 +0100
Subject: [RFC] optimize nvme single segment I/O
In-Reply-To: <302780ee-8721-2039-63b9-0d64bf3b519b@fb.com>
References: <20190321231037.25104-1-hch@lst.de>
 <302780ee-8721-2039-63b9-0d64bf3b519b@fb.com>
Message-ID: <20190327142449.GE26200@lst.de>

FYI, I've pulled the series including the block helpers into nvme-5.2,
with a few tiny changes for the review comments from Chaitanya.
