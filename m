From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 16 Nov 2017 17:39:55 +0200
Subject: [PATCH v2 0/3] Fix request completion holes
In-Reply-To: <1510611044.3735.49.camel@redhat.com>
References: <20171108100616.26605-1-sagi@grimberg.me>
 <1510611044.3735.49.camel@redhat.com>
Message-ID: <e89f72c6-12ce-c149-c81e-f3adb43a8e9e@grimberg.me>


> Sagi, are you ready for me to take this series in?  It seemed like there
> was a question as to whether you might want to try atomics instead of
> spin locks, or do you want to stick with spinlocks?

I still need a review for this, and I think we'll get it in through the
nvme tree (via the block tree). Thanks.
