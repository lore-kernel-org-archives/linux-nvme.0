From: maurosr@linux.vnet.ibm.com (Mauro Rodrigues)
Date: Wed, 5 Apr 2017 20:56:11 -0300
Subject: [PATCH 3/3] nvmetcli: Install nvmetcli executable in $PATH
In-Reply-To: <20170330082855.GC11540@lst.de>
References: <1490636805-13688-1-git-send-email-maurosr@linux.vnet.ibm.com>
 <1490636805-13688-3-git-send-email-maurosr@linux.vnet.ibm.com>
 <20170330082855.GC11540@lst.de>
Message-ID: <20170405235611.GA8885@korriban>

On Thu, Mar 30, 2017@10:28:55AM +0200, Christoph Hellwig wrote:
> On Mon, Mar 27, 2017@02:46:45PM -0300, Mauro S. M. Rodrigues wrote:
> > According to the README, one can install nvmetcli through setup.py.
> > When we try this, though, the nvmetcli wasn't configured in system's
> > $PATH.
> > Adding it to script list in setup.py solved the issue.
> 
> Andy sent the same patch a while ago, but it needs a fixup to
> 
>  a) install into /usr/sbin
>  b) fixups to the deb and rpm packaging to take this into account
> 
> Do you want to fix this up?  Otherwise I'll try to get to it myself,
> I should be able to access a Fedora test box again now.
>
Hi Cristoph!

I just sent a new version of the patch. I've also checked the contents
of both rpm and deb packages and everything looks correct:

~/dev/nvmetcli$ dpkg -c dist/nvmetcli_0.3.3.g08963d2_all.deb  |grep /usr/sbin/nvmetcli
-rwxr-xr-x root/root     17050 2017-04-05 15:47 ./usr/sbin/nvmetcli

and for the rpm:

# rpm -ql nvmetcli |grep /usr/sbin/nvmetcli
/usr/sbin/nvmetcli

Please let me know if I missed anything here.

Thanks in advanced!

--
Mauro Rodrigues
