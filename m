From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 13 Oct 2016 03:05:52 -0700
Subject: [PATCH 1/3] Add nvmetcli to setup.py scripts
In-Reply-To: <1476316842-23718-2-git-send-email-agrover@redhat.com>
References: <1476316842-23718-1-git-send-email-agrover@redhat.com>
 <1476316842-23718-2-git-send-email-agrover@redhat.com>
Message-ID: <20161013100552.GA25325@infradead.org>

On Wed, Oct 12, 2016@05:00:40PM -0700, Andy Grover wrote:
> This results in nvmetcli being placed in the right place on install, and
> the interpreter name will be changed to the current interpreter name,
> which may be different, e.g. /usr/bin/python3.
> 
> Signed-off-by: Andy Grover <agrover at redhat.com>

It installs it into the wrong place unfortunately, /usr/bin instead
of /usr/sbin.
