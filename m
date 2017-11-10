From: maurosr@linux.vnet.ibm.com (Mauro Rodrigues)
Date: Fri, 10 Nov 2017 09:17:42 -0200
Subject: building nvmetcli in buildroot
In-Reply-To: <CANqv2T2Uhy__zyQY-tixnfFmCYOZV7y=grmsgtshRkhx6nwoLw@mail.gmail.com>
References: <CANqv2T0CL+hJz0+_yUBnwQ995mupBTOBMpqEcrvi9ZawDBBCtg@mail.gmail.com>
 <20171109171019.GA15304@lst.de>
 <CANqv2T2Uhy__zyQY-tixnfFmCYOZV7y=grmsgtshRkhx6nwoLw@mail.gmail.com>
Message-ID: <20171110111741.GA28245@korriban>

On Fri, Nov 10, 2017@08:43:05AM +0100, stephane gonauer wrote:
> Hi,
> 
> I dug further into the question to better understand.
> 
> From my understanding the root cause lies in setuptools :
> 
> - buildroot uses --prefix option to set the prefix to $(TARGET_DIR)
> - the setup.cfg from nvmetcli uses -install-script
> - When both options are present, install-script completely overrides
> --prefix and is considered as an absolute path.
> 
> I tried to uses $(TARGET_DIR) inside setup.cfg but it is not evaluated
> when reaching setup.cfg (and it results in a path containing the
> TARGET_DIR and not its value).
> 
> Unless someone knows how to better use setuptools, I don't see a
> solution inside nvmetcli tree
> 
> St?phane

>From the top of my head I don't recall to see a different solution for
this.

Is your buildroot tool opensource? I would like to see how it deals
with python packages.

Also, I'll take a look if there is a different option from setuptools
standpoint.
> 
> 2017-11-09 18:10 GMT+01:00 Christoph Hellwig <hch at lst.de>:
> > I'm perfectly happy to make life for buildroots easier, but nvmetcli
> > is an admin tool that should live in /usr/sbin.  We'll need to find
> > a way for that to still be the default.
> 
