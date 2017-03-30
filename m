From: hch@lst.de (Christoph Hellwig)
Date: Thu, 30 Mar 2017 10:28:55 +0200
Subject: [PATCH 3/3] nvmetcli: Install nvmetcli executable in $PATH
In-Reply-To: <1490636805-13688-3-git-send-email-maurosr@linux.vnet.ibm.com>
References: <1490636805-13688-1-git-send-email-maurosr@linux.vnet.ibm.com>
 <1490636805-13688-3-git-send-email-maurosr@linux.vnet.ibm.com>
Message-ID: <20170330082855.GC11540@lst.de>

On Mon, Mar 27, 2017@02:46:45PM -0300, Mauro S. M. Rodrigues wrote:
> According to the README, one can install nvmetcli through setup.py.
> When we try this, though, the nvmetcli wasn't configured in system's
> $PATH.
> Adding it to script list in setup.py solved the issue.

Andy sent the same patch a while ago, but it needs a fixup to

 a) install into /usr/sbin
 b) fixups to the deb and rpm packaging to take this into account

Do you want to fix this up?  Otherwise I'll try to get to it myself,
I should be able to access a Fedora test box again now.
