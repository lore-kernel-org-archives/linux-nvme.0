From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 16 May 2017 05:48:58 -0700
Subject: [PATCH v2 07/10] nvmet_fc: Add queue create and delete callbacks
 in LLDD api
In-Reply-To: <20170516001024.5281-8-jsmart2021@gmail.com>
References: <20170516001024.5281-1-jsmart2021@gmail.com>
 <20170516001024.5281-8-jsmart2021@gmail.com>
Message-ID: <20170516124858.GH28689@infradead.org>

On Mon, May 15, 2017@05:10:21PM -0700, James Smart wrote:
> To facilitate LLDD resource management on nvme queue creation and
> deletion, add optional callbacks queue_create and queue_delete.

Please send these together with driver changes to implement them,
otherwise they are impossible to review.
