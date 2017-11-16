From: dledford@redhat.com (Doug Ledford)
Date: Thu, 16 Nov 2017 10:58:13 -0500
Subject: [PATCH v2 0/3] Fix request completion holes
In-Reply-To: <e89f72c6-12ce-c149-c81e-f3adb43a8e9e@grimberg.me>
References: <20171108100616.26605-1-sagi@grimberg.me>
 <1510611044.3735.49.camel@redhat.com>
 <e89f72c6-12ce-c149-c81e-f3adb43a8e9e@grimberg.me>
Message-ID: <1510847893.8751.0.camel@redhat.com>

On Thu, 2017-11-16@17:39 +0200, Sagi Grimberg wrote:
> > Sagi, are you ready for me to take this series in?  It seemed like there
> > was a question as to whether you might want to try atomics instead of
> > spin locks, or do you want to stick with spinlocks?
> 
> I still need a review for this, and I think we'll get it in through the
> nvme tree (via the block tree). Thanks.

Sorry, I didn't pay that close of attention to the files patched in each
one.  I just saw rdma in each subject line and assumed it was an rdma
destined patch series.  Looking closer I see it was really just Cc:ed to
linux-rdma for review.

-- 
Doug Ledford <dledford at redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20171116/3528d82b/attachment.sig>
