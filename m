From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 16 Jul 2015 21:50:21 -0400
Subject: [PATCH 3/3] block: Refuse adding appending a gapped integrity
 page to a bio
In-Reply-To: <20150716092646.GA17712@infradead.org> (Christoph Hellwig's
 message of "Thu, 16 Jul 2015 02:26:46 -0700")
References: <1436966356-8979-1-git-send-email-sagig@mellanox.com>
 <1436966356-8979-4-git-send-email-sagig@mellanox.com>
 <55A67C17.4080706@kernel.dk> <20150716092646.GA17712@infradead.org>
Message-ID: <yq1y4ifmu1u.fsf@sermon.lab.mkp.net>

>>>>> "Christoph" == Christoph Hellwig <hch at infradead.org> writes:

Christoph> In the long run we'll need to refactor it by adding bio_vec
Christoph> iteration helpers that can pick different anchors from the
Christoph> bio.

Yep. Always wanted to avoid that duplication. Keith's work made it
easier. I just haven't taken things one step further yet...

-- 
Martin K. Petersen	Oracle Linux Engineering
