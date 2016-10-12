From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 12 Oct 2016 01:53:58 -0700
Subject: [PATCH 0/7 v2] nvme-fabrics: Add FC-NVME Transport support
In-Reply-To: <57f82b0d.sLiRmQ0NSI2pLk2l%james.smart@broadcom.com>
References: <57f82b0d.sLiRmQ0NSI2pLk2l%james.smart@broadcom.com>
Message-ID: <20161012085358.GA12972@infradead.org>

On Fri, Oct 07, 2016@04:09:01PM -0700, James Smart wrote:
> 
> The patches in this set add support for the FC transport to the nvme
> fabrics subsystem.  The set include header files with T11 transport
> definitions and an api for the FC-NVME transport to talk with FC LLDDs.
> It also includes host and target transport files. A FC loopback driver
> is supplied to act as a FC LLDD to exercise the api.

What's the timeline for submitting the lpfc support?  Even if you're
not submitting it quite yet having it available somewhere as a reference
would be really useful when reviewing the code.

Also the code makes git-am complain:

Applying: nvme-fabrics: Add FC transport FC-NVME definitions
/home/hch/work/linux/.git/rebase-apply/patch:266: new blank line at EOF.
+
warning: 1 line adds whitespace errors.
Applying: nvme-fabrics: Add FC transport LLDD api definitions
/home/hch/work/linux/.git/rebase-apply/patch:845: new blank line at EOF.
+
warning: 1 line adds whitespace errors.
Applying: nvme-fabrics: Add host FC transport support
/home/hch/work/linux/.git/rebase-apply/patch:2359: new blank line at
EOF.
+
warning: 1 line adds whitespace errors.
Applying: nvme-fabrics: Add target FC transport support
/home/hch/work/linux/.git/rebase-apply/patch:25: new blank line at EOF.
+
/home/hch/work/linux/.git/rebase-apply/patch:2020: new blank line at
EOF.
+
warning: 2 lines add whitespace errors.
Applying: nvme-fabrics: Add FC LLDD loopback driver to test FC-NVME
/home/hch/work/linux/.git/rebase-apply/patch:1190: new blank line at
EOF.
+
