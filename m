From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 16 May 2017 05:46:32 -0700
Subject: [PATCH v2 03/10] nvme_fc: replace ioabort msleep loop with
 completion
In-Reply-To: <20170516001024.5281-4-jsmart2021@gmail.com>
References: <20170516001024.5281-1-jsmart2021@gmail.com>
 <20170516001024.5281-4-jsmart2021@gmail.com>
Message-ID: <20170516124632.GD28689@infradead.org>

As said before - please always use a waitqueue if you wait for a
specific condition.
