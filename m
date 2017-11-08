From: hch@lst.de (Christoph Hellwig)
Date: Wed, 8 Nov 2017 09:54:17 +0100
Subject: [PATCH 4/5] nvme: implement multipath access to nvme subsystems
In-Reply-To: <20171102183034.9320-5-hch@lst.de>
References: <20171102183034.9320-1-hch@lst.de>
 <20171102183034.9320-5-hch@lst.de>
Message-ID: <20171108085417.GA19990@lst.de>

Can I get a review for this one?  The only changes vs the previously
reviewed versions is that we don't use the multipath code at all for
subsystems that aren't multiported, and that there is an explicit
opt-out at compile and module load time, so it shouldn't be that hard
to review for those who reviewed the previous versions.
