From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 20 Sep 2017 14:32:14 -0700
Subject: [PATCH] nvme_fc: add message on final controller removal
In-Reply-To: <20170919210210.20201-1-jsmart2021@gmail.com>
References: <20170919210210.20201-1-jsmart2021@gmail.com>
Message-ID: <20170920213214.GC10442@infradead.org>

On Tue, Sep 19, 2017@02:02:10PM -0700, James Smart wrote:
> Given disparity between class level delete and transport delete,
> add an info message when the transport controller object deletes.

Hmm.  Why do we need this in the FC code?
