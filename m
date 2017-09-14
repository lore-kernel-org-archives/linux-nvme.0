From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 14 Sep 2017 10:03:00 -0700
Subject: [PATCH] nvmet: bump NVMET_NR_QUEUES to 128
In-Reply-To: <20170911231450.20409-1-jsmart2021@gmail.com>
References: <20170911231450.20409-1-jsmart2021@gmail.com>
Message-ID: <20170914170300.GA1235@infradead.org>

This looks ok as a quick check, but any chance you could send
a patch to make this configurable through configfs?  Preferably
also for the max queue size.
