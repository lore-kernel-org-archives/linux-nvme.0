From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 23 Oct 2017 01:28:05 -0700
Subject: [PATCH v2] nvmet: Fix fatal_err_work deadlock
In-Reply-To: <20171020161253.29296-1-jsmart2021@gmail.com>
References: <20171020161253.29296-1-jsmart2021@gmail.com>
Message-ID: <20171023082805.GA25383@infradead.org>

The whole point of the flush_work suggestion was that we should not
require offloading the deleting to another workqueue for it.
