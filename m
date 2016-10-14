From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 13 Oct 2016 22:50:42 -0700
Subject: [PATCH 1/3] Add nvmetcli to setup.py scripts
In-Reply-To: <eba038a5-a099-ff61-cbe5-250e56637ccd@redhat.com>
References: <1476316842-23718-1-git-send-email-agrover@redhat.com>
 <1476316842-23718-2-git-send-email-agrover@redhat.com>
 <20161013100552.GA25325@infradead.org>
 <eba038a5-a099-ff61-cbe5-250e56637ccd@redhat.com>
Message-ID: <20161014055042.GA5853@infradead.org>

On Thu, Oct 13, 2016@09:23:54AM -0700, Andy Grover wrote:
> On 10/13/2016 03:05 AM, Christoph Hellwig wrote:
> > On Wed, Oct 12, 2016@05:00:40PM -0700, Andy Grover wrote:
> > > This results in nvmetcli being placed in the right place on install, and
> > > the interpreter name will be changed to the current interpreter name,
> > > which may be different, e.g. /usr/bin/python3.
> > > 
> > > Signed-off-by: Andy Grover <agrover at redhat.com>
> > 
> > It installs it into the wrong place unfortunately, /usr/bin instead
> > of /usr/sbin.
> 
> There's a command-line argument to 'python setup.py install',
> --install-scripts, that can be used to put it in /usr/sbin if you want...

Can you fix up the specfile to use it?  I'll take care of the Debian
packaging then.
