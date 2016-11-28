From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 28 Nov 2016 07:55:52 -0800
Subject: [PATCH 3/3] nvmetcli: remove README file
In-Reply-To: <20161125074604.GB753@lst.de>
References: <1479924073-6952-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1479924073-6952-4-git-send-email-james_p_freyensee@linux.intel.com>
 <20161125074604.GB753@lst.de>
Message-ID: <1480348552.2827.12.camel@linux.intel.com>

On Fri, 2016-11-25@08:46 +0100, Christoph Hellwig wrote:
> On Wed, Nov 23, 2016@10:01:13AM -0800, Jay Freyensee wrote:
> > 
> > Contents of README have been moved and updated into the
> > manpage/html solution.
> 
> 
> I still think that a basic README is useful, including pointing
> people
> to the manpage, and for build instruction in case we add any.

OK, I can re-send the patch series and not touch the README.

> 
> 
> > 
> > --- a/README
> > +++ /dev/null
> > @@ -1,173 +0,0 @@
> > -nvmetcli
> > -========
> > -This contains the NVMe target admin tool "nvmetcli".??It can
> > either be
> > -used interactively by invoking it without arguments, or it can be
> > used
> > -to save, restore or clear the current NVMe target configuration.
> > -
> > -Installation
> > -------------
> > -Please install the configshell-fb package from
> > -https://github.com/agrover/configshell-fb first.
> > -
> > -nvmetcli can be run directly from the source directory or
> > installed
> > -using setup.py.
> > -
> > -Common Package Dependencies and Problems
> > ------------------------------------------
> > -nvmetcli uses the 'python-six' and 'pyparsing' packages
> > -(running nvmetcli without these packages may produce
> > -hard-to-decipher errors).
> 
> 
> E.g. keep everything up to here, then add a reference to
> nvmetcli.txt after that.
> 
> And keep the rest quotes below this text as well,
> 
> > 
> > -Example NVMe Target .json files
> > ---------------------------------------
> > -To load the loop + explicit host version above do the following:
> > -
> > -??./nvmetcli restore loop.json
> > -
> > -Or to load the rdma + no host authentication version do the
> > following
> > -after you've ensured that the IP address in rdma.json fits your
> > setup:
> > -
> > -??./nvmetcli restore rdma.json
> > -
> > -These files can also be edited directly using your favorite
> > editor.
> > -
> > -Testing
> > --------
> > -nvmetcli comes with a testsuite that tests itself and the kernel
> > configfs
> > -interface for the NVMe target.??To run it make sure you have nose2
> > and
> > -the coverage plugin for it installed and simple run 'make test'.
> > -
> > -Development
> > ------------------
> > -Please send to linux-nvme at lists.infradead.org for review and
> > acceptance.
> > --?
> > 2.7.4
> ---end quoted text---
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
