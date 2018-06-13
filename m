From: hch@lst.de (Christoph Hellwig)
Date: Wed, 13 Jun 2018 09:55:57 +0200
Subject: please revert a nvme-cli commit
Message-ID: <20180613075557.GA22940@lst.de>

d8f949c21e9d832149518f26c71dfd8de16cd628 does bogus blind retries
on failure, and the kernel part of it was rejected.  Let's sort this
out properly.

Similarly at least for now bb2d87d7f386882005bb87fe9412af23c646c876 is
bogus as well.  We require fabrics connect to be synchronous, and changing
that will require a longer discussion first.
