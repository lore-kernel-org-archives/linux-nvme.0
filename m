From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 13 Oct 2016 03:06:22 -0700
Subject: [PATCH 0/3] nvmetcli fixes
In-Reply-To: <1476316842-23718-1-git-send-email-agrover@redhat.com>
References: <1476316842-23718-1-git-send-email-agrover@redhat.com>
Message-ID: <20161013100622.GB25325@infradead.org>

On Wed, Oct 12, 2016@05:00:39PM -0700, Andy Grover wrote:
> Here are some small fixes that help packaging nvmetcli,
> and help it minimally work with Python 3 -- there are likely more
> Py2/3 issues that will come out in testing but this gets us past
> initial import errors.

Thanks Andy, I've applied patches 2 and 3.  Any idea how to get
nvmetcli installed to /usr/sbin using setuptools?
