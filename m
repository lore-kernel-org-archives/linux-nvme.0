From: snitzer@redhat.com (Mike Snitzer)
Date: Thu, 8 Dec 2016 20:16:56 -0500
Subject: [LSF/MM TOPIC ATTEND] multipath for NVMe over Fabrics
Message-ID: <20161209011656.GA320@redhat.com>

I'd like to discuss $subject.  I haven't heard of much progress on this
(but I'm also not tracking NVMe development at the moment).

Last I heard about getting DM multipath to work with NVMe over Fabrics
was this: https://patchwork.kernel.org/patch/9208997/

I've reintroduced bio-based support for the DM multipath target.
Between now and LSF I hope to come to terms with what the various work
items are for making DM multipath work for NVMeoF.  I welcome any
ideas/thoughts others might have.

Mike
