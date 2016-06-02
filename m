From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 2 Jun 2016 01:22:44 -0700
Subject: [PATCH v2] nvme/quirk: Add a delay before checking for adapter
 readiness
In-Reply-To: <201606011754.u51HsNPs003785@mx0a-001b2d01.pphosted.com>
References: <201606011754.u51HsNPs003785@mx0a-001b2d01.pphosted.com>
Message-ID: <20160602082244.GA12071@infradead.org>

Hi Guilherme,

the code looks fine code wise.  But based on the previous disccusion
we only need the delay after a firmware activation, right?  Even if
we don't have a good way to implement that (yet) it would be good
to document that fact in a comment.
