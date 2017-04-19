From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 19 Apr 2017 12:36:25 -0700
Subject: [PATCH v2 4/5] nvmet_fc: Rework target side abort handling
In-Reply-To: <20170411183232.8955-5-jsmart2021@gmail.com>
References: <20170411183232.8955-1-jsmart2021@gmail.com>
 <20170411183232.8955-5-jsmart2021@gmail.com>
Message-ID: <20170419193625.GE18191@infradead.org>

This looks ok as a change to the existing code:

Reviewed-by: Christoph Hellwig <hch at lst.de>

But we really need to go to the NVMe technical working group about
how to cater for the fact that the FC transport does transport aborts
(and thus probably doesn't use NVMe aborts at all, although we'd need
to clarify that).  Can you reach out to the working group and the T11
folks?
