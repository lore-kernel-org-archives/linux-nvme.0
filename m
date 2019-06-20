From: hch@lst.de (Christoph Hellwig)
Date: Thu, 20 Jun 2019 08:36:19 +0200
Subject: [PATCH v4 0/3] nvme: add thermal zone devices
In-Reply-To: <1560439238-4054-1-git-send-email-akinobu.mita@gmail.com>
References: <1560439238-4054-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <20190620063619.GA21034@lst.de>

So the code looks perfectly fine to me.  But I'm still not convinced we
have an important enough use case, and I'm worried about the AEN uevent
implication.

Keith, Sagi, Jens, any opinion?
