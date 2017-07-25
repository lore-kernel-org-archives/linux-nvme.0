From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 25 Jul 2017 18:06:31 +0200
Subject: [PATCH] nvme_fc: revise TRADDR parsing
In-Reply-To: <20170717205939.18229-1-jsmart2021@gmail.com>
References: <20170717205939.18229-1-jsmart2021@gmail.com>
Message-ID: <20170725160631.qhnlfija5ebb44wb@infradead.org>

Thanks, applied to nvme-4.13.

Note that one way to share the code without much overhead would be
turn it into inline routines in a header.  We'd still get duplicate
object code instances, but we'd only need to maintain the code in one
place.
